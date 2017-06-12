From: lkp@intel.com (kbuild test robot)
Date: Tue, 13 Jun 2017 02:13:47 +0800
Subject: [PATCH v2] net: phy: Make phy_ethtool_ksettings_get return void
In-Reply-To: <20170612141508.29229-1-yuval.shaia@oracle.com>
Message-ID: <201706130229.DNOTV7xx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuval,

[auto build test ERROR on net-next/master]
[also build test ERROR on next-20170609]
[cannot apply to v4.12-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yuval-Shaia/net-phy-Make-phy_ethtool_ksettings_get-return-void/20170613-005407
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c: In function 'xgene_get_link_ksettings':
>> drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c:134:10: error: void value not ignored as it ought to be
      return phy_ethtool_ksettings_get(phydev, cmd);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c:140:11: error: void value not ignored as it ought to be
       return phy_ethtool_ksettings_get(phydev, cmd);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/ethernet/apm/xgene-v2/ethtool.c: In function 'xge_get_link_ksettings':
>> drivers/net/ethernet/apm/xgene-v2/ethtool.c:160:9: error: void value not ignored as it ought to be
     return phy_ethtool_ksettings_get(phydev, cmd);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/ethtool.c:161:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +134 drivers/net/ethernet/apm/xgene/xgene_enet_ethtool.c

e6ad7673 Iyappan Subramanian 2014-08-07  118  	strcpy(info->version, XGENE_DRV_VERSION);
e6ad7673 Iyappan Subramanian 2014-08-07  119  	snprintf(info->fw_version, ETHTOOL_FWVERS_LEN, "N/A");
e6ad7673 Iyappan Subramanian 2014-08-07  120  	sprintf(info->bus_info, "%s", pdev->name);
e6ad7673 Iyappan Subramanian 2014-08-07  121  }
e6ad7673 Iyappan Subramanian 2014-08-07  122  
36a19b29 Philippe Reynes     2016-09-11  123  static int xgene_get_link_ksettings(struct net_device *ndev,
36a19b29 Philippe Reynes     2016-09-11  124  				    struct ethtool_link_ksettings *cmd)
e6ad7673 Iyappan Subramanian 2014-08-07  125  {
e6ad7673 Iyappan Subramanian 2014-08-07  126  	struct xgene_enet_pdata *pdata = netdev_priv(ndev);
971d3a44 Philippe Reynes     2016-09-11  127  	struct phy_device *phydev = ndev->phydev;
36a19b29 Philippe Reynes     2016-09-11  128  	u32 supported;
e6ad7673 Iyappan Subramanian 2014-08-07  129  
326dde3e Iyappan Subramanian 2017-05-18  130  	if (phy_interface_mode_is_rgmii(pdata->phy_mode)) {
e6ad7673 Iyappan Subramanian 2014-08-07  131  		if (phydev == NULL)
e6ad7673 Iyappan Subramanian 2014-08-07  132  			return -ENODEV;
e6ad7673 Iyappan Subramanian 2014-08-07  133  
36a19b29 Philippe Reynes     2016-09-11 @134  		return phy_ethtool_ksettings_get(phydev, cmd);
5e6a024b Iyappan Subramanian 2014-10-13  135  	} else if (pdata->phy_mode == PHY_INTERFACE_MODE_SGMII) {
52d1fd99 Iyappan Subramanian 2016-07-25  136  		if (pdata->mdio_driver) {
52d1fd99 Iyappan Subramanian 2016-07-25  137  			if (!phydev)
52d1fd99 Iyappan Subramanian 2016-07-25  138  				return -ENODEV;
52d1fd99 Iyappan Subramanian 2016-07-25  139  
36a19b29 Philippe Reynes     2016-09-11  140  			return phy_ethtool_ksettings_get(phydev, cmd);
52d1fd99 Iyappan Subramanian 2016-07-25  141  		}
52d1fd99 Iyappan Subramanian 2016-07-25  142  

:::::: The code at line 134 was first introduced by commit
:::::: 36a19b299536746f5c01d7716dac962f831e4d38 net: ethernet: apm: xgene: use new api ethtool_{get|set}_link_ksettings

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47748 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/95ba7a35/attachment-0001.gz>
