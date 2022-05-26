import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fluttertestlearn/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // 画面を構築する
    await tester.pumpWidget(const MyApp());

    //カウンターの値を取得する。
    String getCount(){
      var countObjs = find.byKey(const Key("CountText"));
      //カウンターが１つのみであること
      expect(countObjs, findsOneWidget);
      var countObj = countObjs.evaluate().first.widget;
      //カウンターがTextであること
      expect(countObj is Text, true);
      var countTextObj = countObj as Text;
      return countTextObj.data ?? "";
    }
    //0が書かれているWidgetが1つであることをテストする
    expect(getCount(), "0");

    //KeyからWidgetを取得する
    var oneButtonParent = find.byKey(const Key("OneButton"));
    var twoButtonParent = find.byKey(const Key("TwoButton"));
    //ボタンのテキストを取得する
    var buttonText = find.text("ボタン");
    //親要素から子要素を取得する
    var oneButtonText = find.descendant(of: oneButtonParent, matching: buttonText);
    var twoButtonText = find.descendant(of: twoButtonParent, matching: buttonText);

    //ボタンがそれぞれ存在するか？
    expect(oneButtonText, findsOneWidget);
    expect(twoButtonText, findsOneWidget);

    //１を足すボタンを押して更新
    await tester.tap(oneButtonText);
    await tester.pump();
    //0+1で1になるはず
    expect(getCount(), "1");

    //２を足すボタンを押して更新
    await tester.tap(twoButtonText);
    await tester.pump();
    //1+2で3になるはず
    expect(getCount(), "3");

    //両方のボタンを押して更新
    await tester.tap(oneButtonText);
    await tester.tap(twoButtonText);
    await tester.pump();
    //3+1+2で6になるはず
    expect(getCount(), "6");
  });
}
