From: lkp@intel.com (kbuild test robot)
Date: Thu, 24 Aug 2017 10:35:50 +0800
Subject: [PATCH v2 3/4] net: phy: realtek: add disable RX internal delay
 mode
In-Reply-To: <20170822040400.12166-4-icenowy@aosc.io>
Message-ID: <201708241013.Evo4jDXf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.13-rc6 next-20170823]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Icenowy-Zheng/Workaround-broken-RTL8211E-on-some-Pine64-boards/20170823-234405
config: x86_64-randconfig-b0-08240928 (attached as .config)
compiler: gcc-4.4 (Debian 4.4.7-8) 4.4.7
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/net/phy/realtek.c: In function 'rtl8211e_config_init':
>> drivers/net/phy/realtek.c:130: warning: unused variable 'of_node'

vim +/of_node +130 drivers/net/phy/realtek.c

   126	
   127	static int rtl8211e_config_init(struct phy_device *phydev)
   128	{
   129		struct device *dev = &phydev->mdio.dev;
 > 130		struct device_node *of_node = dev->of_node;
   131		int ret;
   132	
   133		ret = genphy_config_init(phydev);
   134		if (ret < 0)
   135			return ret;
   136	
   137		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) {
   138			/* Disable the RX internal delay here.
   139			 *
   140			 * All the magic numbers are not documented on RTL8211E
   141			 * datasheet. They're said to be from Realtek by Pine64.
   142			 */
   143			phy_write(phydev, RTL8211_PAGE_SELECT, RTL8211E_EXT_PAGE);
   144			phy_write(phydev, RTL8211E_EXT_PAGE_SELECT, 0xa4);
   145			phy_write(phydev, 0x1c, 0xb591);
   146	
   147			/* Restore to default page 0 */
   148			phy_write(phydev, RTL8211_PAGE_SELECT, 0);
   149		}
   150	
   151		return 0;
   152	}
   153	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32072 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/d477cecf/attachment-0001.gz>
