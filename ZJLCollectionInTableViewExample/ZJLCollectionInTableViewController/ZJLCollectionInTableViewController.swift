//
//  ZJLCollectionInTableViewController.swift
//  ZJLCollectionInTableViewExample
//
//  Created by ZhongZhongzhong on 16/6/21.
//  Copyright © 2016年 ZhongZhongzhong. All rights reserved.
//

import UIKit

let reuseTableCell : NSString = "myTableCell"
let reuseCollectionCell : NSString = "myCollectionViewCell"


class ZJLCollectionInTableViewController: UITableViewController {
    var dataArray : Array<AnyObject>!
    var offsetDictionary : Dictionary<NSObject,AnyObject>!
    convenience init(data : Array<AnyObject>) {
        self.init()
        tableView.registerClass(ZJLCollectionInTableViewCell.self, forCellReuseIdentifier: reuseTableCell as String)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        dataArray = data
        offsetDictionary = Dictionary<NSObject,AnyObject>()
        
    }
}

extension ZJLCollectionInTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseTableCell as String, forIndexPath: indexPath) as! ZJLCollectionInTableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! ZJLCollectionInTableViewCell
        cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: indexPath.row)
        
        let key = cell.collectionView.tag
        let value = offsetDictionary[key]
        let horizontalOffset = CGFloat(value != nil ? value!.floatValue : 0)
        cell.collectionView.setContentOffset(CGPointMake(horizontalOffset, 0), animated: false)
        
    }
}

extension ZJLCollectionInTableViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let temp = dataArray[collectionView.tag] as! Array<AnyObject>
        return temp.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseCollectionCell as String, forIndexPath: indexPath)
        
        //let collectionViewArray = dataArray[collectionView.tag] as! Array<AnyObject>
        cell.backgroundColor = UIColor.grayColor()
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if !(scrollView is UICollectionView) {
            return
        }
        let horizontalOffset = scrollView.contentOffset.x
        let collectionView = scrollView as! UICollectionView
        offsetDictionary[collectionView.tag] = horizontalOffset
    }
}
