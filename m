From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Jun 2017 02:45:25 +0800
Subject: [PATCH] net/phy: Make phy_ethtool_ksettings_get return void
In-Reply-To: <20170604171428.4012-1-yuval.shaia@oracle.com>
Message-ID: <201706050222.9nQpHVcL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuval,

[auto build test ERROR on net-next/master]
[also build test ERROR on v4.12-rc3 next-20170602]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Yuval-Shaia/net-phy-Make-phy_ethtool_ksettings_get-return-void/20170605-012813
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   drivers/net//ethernet/renesas/sh_eth.c: In function 'sh_eth_get_link_ksettings':
>> drivers/net//ethernet/renesas/sh_eth.c:1924:6: error: void value not ignored as it ought to be
     ret = phy_ethtool_ksettings_get(ndev->phydev, cmd);
         ^
--
   drivers/net//ethernet/renesas/ravb_main.c: In function 'ravb_get_link_ksettings':
>> drivers/net//ethernet/renesas/ravb_main.c:1084:9: error: void value not ignored as it ought to be
      error = phy_ethtool_ksettings_get(ndev->phydev, cmd);
            ^
--
   drivers/net//ethernet/apm/xgene/xgene_enet_ethtool.c: In function 'xgene_get_link_ksettings':
>> drivers/net//ethernet/apm/xgene/xgene_enet_ethtool.c:134:10: error: void value not ignored as it ought to be
      return phy_ethtool_ksettings_get(phydev, cmd);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net//ethernet/apm/xgene/xgene_enet_ethtool.c:140:11: error: void value not ignored as it ought to be
       return phy_ethtool_ksettings_get(phydev, cmd);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net//ethernet/apm/xgene-v2/ethtool.c: In function 'xge_get_link_ksettings':
>> drivers/net//ethernet/apm/xgene-v2/ethtool.c:160:9: error: void value not ignored as it ought to be
     return phy_ethtool_ksettings_get(phydev, cmd);
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net//ethernet/apm/xgene-v2/ethtool.c:161:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
--
   drivers/net//ethernet/stmicro/stmmac/stmmac_ethtool.c: In function 'stmmac_ethtool_get_link_ksettings':
>> drivers/net//ethernet/stmicro/stmmac/stmmac_ethtool.c:367:5: error: void value not ignored as it ought to be
     rc = phy_ethtool_ksettings_get(phy, cmd);
        ^

vim +1924 drivers/net//ethernet/renesas/sh_eth.c

9fd0375ad drivers/net/ethernet/renesas/sh_eth.c Philippe Reynes   2016-08-10  1908  	phy_start(ndev->phydev);
86a74ff21 drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2008-06-09  1909  
86a74ff21 drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2008-06-09  1910  	return 0;
86a74ff21 drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2008-06-09  1911  }
86a74ff21 drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2008-06-09  1912  
f08aff444 drivers/net/ethernet/renesas/sh_eth.c Philippe Reynes   2016-08-10  1913  static int sh_eth_get_link_ksettings(struct net_device *ndev,
f08aff444 drivers/net/ethernet/renesas/sh_eth.c Philippe Reynes   2016-08-10  1914  				     struct ethtool_link_ksettings *cmd)
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1915  {
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1916  	struct sh_eth_private *mdp = netdev_priv(ndev);
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1917  	unsigned long flags;
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1918  	int ret;
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1919  
9fd0375ad drivers/net/ethernet/renesas/sh_eth.c Philippe Reynes   2016-08-10  1920  	if (!ndev->phydev)
4f9dce230 drivers/net/ethernet/renesas/sh_eth.c Ben Hutchings     2015-01-16  1921  		return -ENODEV;
4f9dce230 drivers/net/ethernet/renesas/sh_eth.c Ben Hutchings     2015-01-16  1922  
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1923  	spin_lock_irqsave(&mdp->lock, flags);
f08aff444 drivers/net/ethernet/renesas/sh_eth.c Philippe Reynes   2016-08-10 @1924  	ret = phy_ethtool_ksettings_get(ndev->phydev, cmd);
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1925  	spin_unlock_irqrestore(&mdp->lock, flags);
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1926  
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1927  	return ret;
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1928  }
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1929  
f08aff444 drivers/net/ethernet/renesas/sh_eth.c Philippe Reynes   2016-08-10  1930  static int sh_eth_set_link_ksettings(struct net_device *ndev,
f08aff444 drivers/net/ethernet/renesas/sh_eth.c Philippe Reynes   2016-08-10  1931  				     const struct ethtool_link_ksettings *cmd)
dc19e4e5e drivers/net/sh_eth.c                  Nobuhiro Iwamatsu 2011-02-15  1932  {

:::::: The code at line 1924 was first introduced by commit
:::::: f08aff444ae0004c9ae6df3241fc313a5024d375 net: ethernet: renesas: sh_eth: use new api ethtool_{get|set}_link_ksettings

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47761 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/ddb8011e/attachment-0001.gz>
