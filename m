From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 27 Jul 2017 19:21:39 +0800
Subject: [arm:phy 15/23] drivers/net/ethernet/marvell/mvneta.c:4558:35:
 error: 'struct mvneta_port' has no member named 'phy_interface'
Message-ID: <201707271937.pBdVMjC6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   93875f86328b49a0a4928c73ad13bfd96fd17c0b
commit: 0ee3701144e52a6d6d241116bc079dc963706186 [15/23] net: mvneta: convert to phylink
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0ee3701144e52a6d6d241116bc079dc963706186
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm/phy HEAD 93875f86328b49a0a4928c73ad13bfd96fd17c0b builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/net/ethernet/marvell/mvneta.c: In function 'mvneta_resume':
>> drivers/net/ethernet/marvell/mvneta.c:4558:35: error: 'struct mvneta_port' has no member named 'phy_interface'
     err = mvneta_port_power_up(pp, pp->phy_interface);
                                      ^~

vim +4558 drivers/net/ethernet/marvell/mvneta.c

9768b45c Jane Li       2017-03-16  4537  
9768b45c Jane Li       2017-03-16  4538  static int mvneta_resume(struct device *device)
9768b45c Jane Li       2017-03-16  4539  {
9768b45c Jane Li       2017-03-16  4540  	struct platform_device *pdev = to_platform_device(device);
9768b45c Jane Li       2017-03-16  4541  	struct net_device *dev = dev_get_drvdata(device);
9768b45c Jane Li       2017-03-16  4542  	struct mvneta_port *pp = netdev_priv(dev);
9768b45c Jane Li       2017-03-16  4543  	int err;
9768b45c Jane Li       2017-03-16  4544  
9768b45c Jane Li       2017-03-16  4545  	clk_prepare_enable(pp->clk);
9768b45c Jane Li       2017-03-16  4546  	if (!IS_ERR(pp->clk_bus))
9768b45c Jane Li       2017-03-16  4547  		clk_prepare_enable(pp->clk_bus);
9768b45c Jane Li       2017-03-16  4548  	if (pp->dram_target_info || pp->neta_armada3700)
9768b45c Jane Li       2017-03-16  4549  		mvneta_conf_mbus_windows(pp, pp->dram_target_info);
9768b45c Jane Li       2017-03-16  4550  	if (pp->bm_priv) {
9768b45c Jane Li       2017-03-16  4551  		err = mvneta_bm_port_init(pdev, pp);
9768b45c Jane Li       2017-03-16  4552  		if (err < 0) {
9768b45c Jane Li       2017-03-16  4553  			dev_info(&pdev->dev, "use SW buffer management\n");
9768b45c Jane Li       2017-03-16  4554  			pp->bm_priv = NULL;
9768b45c Jane Li       2017-03-16  4555  		}
9768b45c Jane Li       2017-03-16  4556  	}
9768b45c Jane Li       2017-03-16  4557  	mvneta_defaults_set(pp);
9768b45c Jane Li       2017-03-16 @4558  	err = mvneta_port_power_up(pp, pp->phy_interface);
9768b45c Jane Li       2017-03-16  4559  	if (err < 0) {
9768b45c Jane Li       2017-03-16  4560  		dev_err(device, "can't power up port\n");
9768b45c Jane Li       2017-03-16  4561  		return err;
9768b45c Jane Li       2017-03-16  4562  	}
9768b45c Jane Li       2017-03-16  4563  
9768b45c Jane Li       2017-03-16  4564  	netif_device_attach(dev);
d6956ac8 Jisheng Zhang 2017-03-29  4565  	if (netif_running(dev)) {
9768b45c Jane Li       2017-03-16  4566  		mvneta_open(dev);
d6956ac8 Jisheng Zhang 2017-03-29  4567  		mvneta_set_rx_mode(dev);
d6956ac8 Jisheng Zhang 2017-03-29  4568  	}
d6956ac8 Jisheng Zhang 2017-03-29  4569  
9768b45c Jane Li       2017-03-16  4570  	return 0;
9768b45c Jane Li       2017-03-16  4571  }
9768b45c Jane Li       2017-03-16  4572  #endif
9768b45c Jane Li       2017-03-16  4573  

:::::: The code at line 4558 was first introduced by commit
:::::: 9768b45ceb0bc7bdee61837afad331dd6bf7977f net: mvneta: support suspend and resume

:::::: TO: Jane Li <jiel@marvell.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36276 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170727/26a9c60f/attachment-0001.gz>
