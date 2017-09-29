From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 30 Sep 2017 04:22:43 +0800
Subject: [arm:phy 2/10] drivers/net/ethernet/marvell/mvneta.c:4555:35: error:
 'struct mvneta_port' has no member named 'phy_interface'
Message-ID: <201709300440.zI207cjm%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   dfaea820e59784cc983e158b10ecc78af3162c4f
commit: 3d6bda8e8ab387536f2a743f8bddde904fd38a3e [2/10] net: mvneta: convert to phylink
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3d6bda8e8ab387536f2a743f8bddde904fd38a3e
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

Note: the arm/phy HEAD dfaea820e59784cc983e158b10ecc78af3162c4f builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/net/ethernet/marvell/mvneta.c: In function 'mvneta_resume':
>> drivers/net/ethernet/marvell/mvneta.c:4555:35: error: 'struct mvneta_port' has no member named 'phy_interface'
     err = mvneta_port_power_up(pp, pp->phy_interface);
                                      ^~

vim +4555 drivers/net/ethernet/marvell/mvneta.c

9768b45c Jane Li       2017-03-16  4534  
9768b45c Jane Li       2017-03-16  4535  static int mvneta_resume(struct device *device)
9768b45c Jane Li       2017-03-16  4536  {
9768b45c Jane Li       2017-03-16  4537  	struct platform_device *pdev = to_platform_device(device);
9768b45c Jane Li       2017-03-16  4538  	struct net_device *dev = dev_get_drvdata(device);
9768b45c Jane Li       2017-03-16  4539  	struct mvneta_port *pp = netdev_priv(dev);
9768b45c Jane Li       2017-03-16  4540  	int err;
9768b45c Jane Li       2017-03-16  4541  
9768b45c Jane Li       2017-03-16  4542  	clk_prepare_enable(pp->clk);
9768b45c Jane Li       2017-03-16  4543  	if (!IS_ERR(pp->clk_bus))
9768b45c Jane Li       2017-03-16  4544  		clk_prepare_enable(pp->clk_bus);
9768b45c Jane Li       2017-03-16  4545  	if (pp->dram_target_info || pp->neta_armada3700)
9768b45c Jane Li       2017-03-16  4546  		mvneta_conf_mbus_windows(pp, pp->dram_target_info);
9768b45c Jane Li       2017-03-16  4547  	if (pp->bm_priv) {
9768b45c Jane Li       2017-03-16  4548  		err = mvneta_bm_port_init(pdev, pp);
9768b45c Jane Li       2017-03-16  4549  		if (err < 0) {
9768b45c Jane Li       2017-03-16  4550  			dev_info(&pdev->dev, "use SW buffer management\n");
9768b45c Jane Li       2017-03-16  4551  			pp->bm_priv = NULL;
9768b45c Jane Li       2017-03-16  4552  		}
9768b45c Jane Li       2017-03-16  4553  	}
9768b45c Jane Li       2017-03-16  4554  	mvneta_defaults_set(pp);
9768b45c Jane Li       2017-03-16 @4555  	err = mvneta_port_power_up(pp, pp->phy_interface);
9768b45c Jane Li       2017-03-16  4556  	if (err < 0) {
9768b45c Jane Li       2017-03-16  4557  		dev_err(device, "can't power up port\n");
9768b45c Jane Li       2017-03-16  4558  		return err;
9768b45c Jane Li       2017-03-16  4559  	}
9768b45c Jane Li       2017-03-16  4560  
9768b45c Jane Li       2017-03-16  4561  	netif_device_attach(dev);
d6956ac8 Jisheng Zhang 2017-03-29  4562  	if (netif_running(dev)) {
9768b45c Jane Li       2017-03-16  4563  		mvneta_open(dev);
d6956ac8 Jisheng Zhang 2017-03-29  4564  		mvneta_set_rx_mode(dev);
d6956ac8 Jisheng Zhang 2017-03-29  4565  	}
d6956ac8 Jisheng Zhang 2017-03-29  4566  
9768b45c Jane Li       2017-03-16  4567  	return 0;
9768b45c Jane Li       2017-03-16  4568  }
9768b45c Jane Li       2017-03-16  4569  #endif
9768b45c Jane Li       2017-03-16  4570  

:::::: The code at line 4555 was first introduced by commit
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
Size: 45914 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170930/710bf4ec/attachment-0001.gz>
