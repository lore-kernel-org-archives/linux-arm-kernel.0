From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 2 Mar 2018 03:00:24 +0800
Subject: [xlnx:master 1122/1438]
 drivers//net/ethernet/cadence/macb_main.c:3754:2: warning: 'phy_node' may be
 used uninitialized in this function
Message-ID: <201803020253.oQ3kzW4X%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   807fdad49dd7b39688d91c60925994956cfafef4
commit: 818f168696f561c127f161379eb5b8d1835218a2 [1122/1438] Merge tag 'v4.14' into master
config: sh-allmodconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 818f168696f561c127f161379eb5b8d1835218a2
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers//net/ethernet/cadence/macb_main.c: In function 'macb_probe':
>> drivers//net/ethernet/cadence/macb_main.c:3754:2: warning: 'phy_node' may be used uninitialized in this function [-Wmaybe-uninitialized]
     of_node_put(phy_node);
     ^~~~~~~~~~~~~~~~~~~~~

vim +/phy_node +3754 drivers//net/ethernet/cadence/macb_main.c

6121d00ba drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-07-28  3665  
c69618b3e drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3666  	spin_lock_init(&bp->lock);
f6970505d drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3667  
ad78347f0 drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3668  	/* setup capabilities */
f6970505d drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3669  	macb_configure_caps(bp, macb_config);
f6970505d drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3670  
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3671  	platform_set_drvdata(pdev, dev);
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3672  
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3673  	dev->irq = platform_get_irq(pdev, 0);
c69618b3e drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3674  	if (dev->irq < 0) {
c69618b3e drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3675  		err = dev->irq;
b22ae0b4d drivers/net/ethernet/cadence/macb.c Wei Yongjun                      2016-08-12  3676  		goto err_out_free_netdev;
c69618b3e drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3677  	}
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3678  
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3679  	mac = of_get_mac_address(np);
509070437 drivers/net/ethernet/cadence/macb.c Guenter Roeck                    2013-04-02  3680  	if (mac)
eefb52d1e drivers/net/ethernet/cadence/macb.c Moritz Fischer                   2016-03-29  3681  		ether_addr_copy(bp->dev->dev_addr, mac);
509070437 drivers/net/ethernet/cadence/macb.c Guenter Roeck                    2013-04-02  3682  	else
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3683  		macb_get_hwaddr(bp);
6c36a7074 drivers/net/macb.c                  frederic RODO                    2007-07-12  3684  
5833e0526 drivers/net/ethernet/cadence/macb.c Gregory CLEMENT                  2015-12-11  3685  	/* Power up the PHY if there is a GPIO reset */
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3686  	phy_node = of_parse_phandle(np, "phy-handle", 0);
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3687  	if (!phy_node && of_phy_is_fixed_link(np)) {
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3688  		err = of_phy_register_fixed_link(np);
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3689  		if (err < 0) {
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3690  			dev_err(&pdev->dev, "broken fixed-link specification");
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3691  			goto failed_phy;
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3692  		}
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3693  		phy_node = of_node_get(np);
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3694  		bp->phy_node = phy_node;
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3695  	} else {
270c499f0 drivers/net/ethernet/cadence/macb.c Gregory CLEMENT                  2015-12-17  3696  		int gpio = of_get_named_gpio(phy_node, "reset-gpios", 0);
7613445d1 drivers/net/ethernet/cadence/macb.c Charles Keepax                   2016-03-28  3697  		if (gpio_is_valid(gpio)) {
270c499f0 drivers/net/ethernet/cadence/macb.c Gregory CLEMENT                  2015-12-17  3698  			bp->reset_gpio = gpio_to_desc(gpio);
27f1c64b9 drivers/net/ethernet/cadence/macb.c Sergei Shtylyov                  2016-03-22  3699  			gpiod_direction_output(bp->reset_gpio, 1);
270c499f0 drivers/net/ethernet/cadence/macb.c Gregory CLEMENT                  2015-12-17  3700  		}
7613445d1 drivers/net/ethernet/cadence/macb.c Charles Keepax                   2016-03-28  3701  	}
5833e0526 drivers/net/ethernet/cadence/macb.c Gregory CLEMENT                  2015-12-11  3702  
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3703  	err = of_get_phy_mode(np);
fb97a8466 drivers/net/ethernet/cadence/macb.c Jean-Christophe PLAGNIOL-VILLARD 2011-11-18  3704  	if (err < 0) {
c607a0d99 drivers/net/ethernet/cadence/macb.c Jingoo Han                       2013-08-30  3705  		pdata = dev_get_platdata(&pdev->dev);
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3706  		if (pdata && pdata->is_rmii)
fb97a8466 drivers/net/ethernet/cadence/macb.c Jean-Christophe PLAGNIOL-VILLARD 2011-11-18  3707  			bp->phy_interface = PHY_INTERFACE_MODE_RMII;
fb97a8466 drivers/net/ethernet/cadence/macb.c Jean-Christophe PLAGNIOL-VILLARD 2011-11-18  3708  		else
fb97a8466 drivers/net/ethernet/cadence/macb.c Jean-Christophe PLAGNIOL-VILLARD 2011-11-18  3709  			bp->phy_interface = PHY_INTERFACE_MODE_MII;
fb97a8466 drivers/net/ethernet/cadence/macb.c Jean-Christophe PLAGNIOL-VILLARD 2011-11-18  3710  	} else {
fb97a8466 drivers/net/ethernet/cadence/macb.c Jean-Christophe PLAGNIOL-VILLARD 2011-11-18  3711  		bp->phy_interface = err;
fb97a8466 drivers/net/ethernet/cadence/macb.c Jean-Christophe PLAGNIOL-VILLARD 2011-11-18  3712  	}
fb97a8466 drivers/net/ethernet/cadence/macb.c Jean-Christophe PLAGNIOL-VILLARD 2011-11-18  3713  
6f43a25c4 drivers/net/ethernet/cadence/macb.c Punnaiah Choudary Kalluri        2016-02-03  3714  	macb_reset_phy(pdev);
6f43a25c4 drivers/net/ethernet/cadence/macb.c Punnaiah Choudary Kalluri        2016-02-03  3715  
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3716  	/* IP specific init */
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3717  	err = init(pdev);
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3718  	if (err)
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3719  		goto err_out_free_netdev;
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3720  
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3721  	err = register_netdev(dev);
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3722  	if (err) {
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3723  		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
c69618b3e drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3724  		goto err_out_unregister_netdev;
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3725  	}
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3726  
72ca820bd drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2013-04-14  3727  	err = macb_mii_init(bp);
72ca820bd drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2013-04-14  3728  	if (err)
6c36a7074 drivers/net/macb.c                  frederic RODO                    2007-07-12  3729  		goto err_out_unregister_netdev;
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3730  
03fc4721c drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2012-07-03  3731  	netif_carrier_off(dev);
03fc4721c drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2012-07-03  3732  
b0fbcba40 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-07-18  3733  	tasklet_init(&bp->hresp_err_tasklet, macb_hresp_error_task,
b0fbcba40 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-07-18  3734  		     (unsigned long)bp);
b0fbcba40 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-07-18  3735  
5879823fc drivers/net/ethernet/cadence/macb.c Bo Shen                          2014-09-13  3736  	netdev_info(dev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
5879823fc drivers/net/ethernet/cadence/macb.c Bo Shen                          2014-09-13  3737  		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
5879823fc drivers/net/ethernet/cadence/macb.c Bo Shen                          2014-09-13  3738  		    dev->base_addr, dev->irq, dev->dev_addr);
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3739  
6c36a7074 drivers/net/macb.c                  frederic RODO                    2007-07-12  3740  	phydev = bp->phy_dev;
2220943a2 drivers/net/ethernet/cadence/macb.c Andrew Lunn                      2016-01-06  3741  	phy_attached_info(phydev);
1b0a659ac drivers/net/ethernet/cadence/macb.c Shubhrajyoti Datta               2017-02-20  3742  	pm_runtime_mark_last_busy(&bp->pdev->dev);
1b0a659ac drivers/net/ethernet/cadence/macb.c Shubhrajyoti Datta               2017-02-20  3743  	pm_runtime_put_autosuspend(&bp->pdev->dev);
6c36a7074 drivers/net/macb.c                  frederic RODO                    2007-07-12  3744  
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3745  	return 0;
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3746  
6c36a7074 drivers/net/macb.c                  frederic RODO                    2007-07-12  3747  err_out_unregister_netdev:
6c36a7074 drivers/net/macb.c                  frederic RODO                    2007-07-12  3748  	unregister_netdev(dev);
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3749  
7d4c44d35 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2014-12-15  3750  err_out_free_netdev:
e4bfd971b drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2014-12-12  3751  	free_netdev(dev);
421d9df06 drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2015-03-07  3752  
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3753  failed_phy:
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07 @3754  	of_node_put(phy_node);
59e3534d4 drivers/net/ethernet/cadence/macb.c Harini Katakam                   2016-10-07  3755  
c69618b3e drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3756  err_disable_clocks:
e4bfd971b drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2014-12-12  3757  	clk_disable_unprepare(tx_clk);
e4bfd971b drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2014-12-12  3758  	clk_disable_unprepare(hclk);
e4bfd971b drivers/net/ethernet/cadence/macb.c Cyrille Pitchen                  2014-12-12  3759  	clk_disable_unprepare(pclk);
aead88bd0 drivers/net/ethernet/cadence/macb.c shubhrajyoti.datta at xilinx.com    2016-08-16  3760  	clk_disable_unprepare(rx_clk);
1b0a659ac drivers/net/ethernet/cadence/macb.c Shubhrajyoti Datta               2017-02-20  3761  	pm_runtime_disable(&pdev->dev);
1b0a659ac drivers/net/ethernet/cadence/macb.c Shubhrajyoti Datta               2017-02-20  3762  	pm_runtime_set_suspended(&pdev->dev);
1b0a659ac drivers/net/ethernet/cadence/macb.c Shubhrajyoti Datta               2017-02-20  3763  	pm_runtime_dont_use_autosuspend(&pdev->dev);
c69618b3e drivers/net/ethernet/cadence/macb.c Nicolas Ferre                    2015-03-31  3764  
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3765  	return err;
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3766  }
89e5785fc drivers/net/macb.c                  Haavard Skinnemoen               2006-11-09  3767  

:::::: The code at line 3754 was first introduced by commit
:::::: 59e3534d47765cfe33bdf2ac1e7a5559ae70dec7 net: macb: Add support for fixed link

:::::: TO: Harini Katakam <harini.katakam@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46810 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180302/be883709/attachment-0001.gz>
