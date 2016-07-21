From: lkp@intel.com (kbuild test robot)
Date: Fri, 22 Jul 2016 05:52:37 +0800
Subject: [PATCH v6 06/12] drivers: net: xgene: Add backward compatibility
In-Reply-To: <1469084370-16781-7-git-send-email-isubramanian@apm.com>
Message-ID: <201607220546.vhppFUlO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on net-next/master]
[also build test WARNING on next-20160721]
[cannot apply to v4.7-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Iyappan-Subramanian/drivers-net-xgene-Fix-module-crash-and-1G-hot-plug/20160722-005356
config: m68k-allmodconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/apm/xgene/xgene_enet_hw.c: In function 'xgene_enet_phy_connect':
>> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:834:22: warning: unused variable 'adev' [-Wunused-variable]
     struct acpi_device *adev;
                         ^
>> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:878:23: warning: 'phy_dev' may be used uninitialized in this function [-Wmaybe-uninitialized]
     phy_dev->advertising = phy_dev->supported;
                          ^

vim +/adev +834 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c

   828	int xgene_enet_phy_connect(struct net_device *ndev)
   829	{
   830		struct xgene_enet_pdata *pdata = netdev_priv(ndev);
   831		struct device_node *np;
   832		struct phy_device *phy_dev;
   833		struct device *dev = &pdata->pdev->dev;
 > 834		struct acpi_device *adev;
   835		int i;
   836	
   837		if (dev->of_node) {
   838			for (i = 0 ; i < 2; i++) {
   839				np = of_parse_phandle(dev->of_node, "phy-handle", i);
   840				if (np)
   841					break;
   842			}
   843	
   844			if (!np) {
   845				netdev_dbg(ndev, "No phy-handle found in DT\n");
   846				return -ENODEV;
   847			}
   848	
   849			phy_dev = of_phy_connect(ndev, np, &xgene_enet_adjust_link,
   850						 0, pdata->phy_mode);
   851			if (!phy_dev) {
   852				netdev_err(ndev, "Could not connect to PHY\n");
   853				return -ENODEV;
   854			}
   855	
   856			pdata->phy_dev = phy_dev;
   857		} else {
   858	#ifdef CONFIG_ACPI
   859			adev = acpi_phy_find_device(dev);
   860			if (adev)
   861				pdata->phy_dev =  adev->driver_data;
   862	
   863			phy_dev = pdata->phy_dev;
   864	
   865			if (!phy_dev ||
   866			    phy_connect_direct(ndev, phy_dev, &xgene_enet_adjust_link,
   867					       pdata->phy_mode)) {
   868				netdev_err(ndev, "Could not connect to PHY\n");
   869				return  -ENODEV;
   870			}
   871	#endif
   872		}
   873	
   874		pdata->phy_speed = SPEED_UNKNOWN;
   875		phy_dev->supported &= ~SUPPORTED_10baseT_Half &
   876				      ~SUPPORTED_100baseT_Half &
   877				      ~SUPPORTED_1000baseT_Half;
 > 878		phy_dev->advertising = phy_dev->supported;
   879	
   880		return 0;
   881	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37043 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/4bc05e6d/attachment-0001.obj>
