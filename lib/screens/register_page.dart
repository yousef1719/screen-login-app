import 'package:flutter/material.dart';
import 'package:task/widgets/custom_button.dart';
import 'package:task/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({this.email, this.password, super.key});
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Image.asset('assets/Batman-Logo-2016.png'),
            const Text(
              'REGISTER',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const Spacer(
              flex: 1,
            ),
            CustomTextField(
              onChanged: (data) {
                email = data;
              },
              hintText: 'Email',
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              onChanged: (data) {
                password = data;
              },
              hintText: 'Password',
            ),
            const SizedBox(
              height: 15,
            ),
            CustomButton(
              onTap: () async {
                try {
                  UserCredential user = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email!, password: password!);
                } on FirebaseAuthException catch (ex) {
                  if (ex.code == 'weak-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Week Password',
                        ),
                      ),
                    );
                  } else if (ex.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Email Already Exists',
                        ),
                      ),
                    );
                  }
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Success',
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account ?',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Text(
                  '  Login.',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(
                        0xffE28F3D,
                      )),
                )
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
