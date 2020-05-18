//
//  ViewController.swift
//  NCMBSample
//
//  Created by 加藤拓洋 on 2020/05/19.
//  Copyright © 2020 TakumiKato. All rights reserved.
//

import UIKit
import NCMB

class ViewController: UIViewController {
    @IBOutlet var sampleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func save(){
        let object = NCMBObject(className: "Message")
        object?.setObject(sampleTextField.text, forKey: "text")
        object?.saveInBackground({ (error) in
            if error != nil {
                //エラーが発生したら
                print("error")
            }else{
                //保存に成功した場合
                print("success")
            }
        })
    }
    
    @IBAction func loadData(_ sender: Any) {
        let query = NCMBQuery(className: "Message")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print(error)
            }
            else{
                //うまくデータが取得できた
                print(result)
                let messages = result as! [NCMBObject]
                
                let text = messages.last?.object(forKey: "text") as! String
                
                self.sampleTextField.text = text
            }
        })
    }
    
    
    @IBAction func update(_ sender: Any) {
        let query = NCMBQuery(className: "Message")
        query?.whereKey("text", equalTo: "こんにちは")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print(error)
            }else{
              let messages = result as! [NCMBObject]
              let  textObject = messages.first
                textObject?.setObject("こんばんは", forKey: "text")
                textObject?.saveInBackground({ (error) in
                    if error != nil{
                        print(error)
                        
                    }else{
                        print("Update Succeed!")
                    }
                })
            }
        })
    }
    
}

