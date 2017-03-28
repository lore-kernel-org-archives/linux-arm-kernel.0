From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 28 Mar 2017 08:56:27 +0800
Subject: [arm:phy 30/47] drivers/net//phy/phylink.c:818:9: error: implicit
 declaration of function 'phy_restart_aneg'
Message-ID: <201703280825.Jy1thxKE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   a96d8e502e7464884a8aa0954441c9dfe0593204
commit: 8c4876c90afc26859275be88f8320047a48494b7 [30/47] net: mvneta: convert to phylink
config: sh-allyesconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8c4876c90afc26859275be88f8320047a48494b7
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   drivers/net//phy/phylink.c: In function 'phylink_ethtool_nway_reset':
>> drivers/net//phy/phylink.c:818:9: error: implicit declaration of function 'phy_restart_aneg' [-Werror=implicit-function-declaration]
      ret = phy_restart_aneg(pl->phydev);
            ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/phy_restart_aneg +818 drivers/net//phy/phylink.c

7a562f6e Russell King 2015-09-22  802  		return -EINVAL;
7a562f6e Russell King 2015-09-22  803  
7a562f6e Russell King 2015-09-22  804  	mutex_lock(&pl->config_mutex);
7a562f6e Russell King 2015-09-22  805  	ret = __phylink_ethtool_ksettings_set(pl, kset);
7a562f6e Russell King 2015-09-22  806  	mutex_unlock(&pl->config_mutex);
7a562f6e Russell King 2015-09-22  807  
7a562f6e Russell King 2015-09-22  808  	return ret;
7a562f6e Russell King 2015-09-22  809  }
7a562f6e Russell King 2015-09-22  810  EXPORT_SYMBOL_GPL(phylink_ethtool_ksettings_set);
7a562f6e Russell King 2015-09-22  811  
f833c62b Russell King 2015-10-01  812  int phylink_ethtool_nway_reset(struct phylink *pl)
f833c62b Russell King 2015-10-01  813  {
f833c62b Russell King 2015-10-01  814  	int ret = 0;
f833c62b Russell King 2015-10-01  815  
f833c62b Russell King 2015-10-01  816  	mutex_lock(&pl->config_mutex);
f833c62b Russell King 2015-10-01  817  	if (pl->phydev)
f833c62b Russell King 2015-10-01 @818  		ret = phy_restart_aneg(pl->phydev);
f833c62b Russell King 2015-10-01  819  	phylink_mac_an_restart(pl);
f833c62b Russell King 2015-10-01  820  	mutex_unlock(&pl->config_mutex);
f833c62b Russell King 2015-10-01  821  
f833c62b Russell King 2015-10-01  822  	return ret;
f833c62b Russell King 2015-10-01  823  }
f833c62b Russell King 2015-10-01  824  EXPORT_SYMBOL_GPL(phylink_ethtool_nway_reset);
f833c62b Russell King 2015-10-01  825  
7a562f6e Russell King 2015-09-22  826  /* This emulates MII registers for a fixed-mode phy operating as per the

:::::: The code at line 818 was first introduced by commit
:::::: f833c62b63e6ec7dbd24e1ce6e8331c0b7f2e78f phylink: add ethtool nway_reset support

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@armlinux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44562 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170328/e2d1ffa4/attachment-0001.gz>
