From: lkp@intel.com (kbuild test robot)
Date: Mon, 14 Nov 2016 16:15:56 +0800
Subject: [PATCH v2 2/2] phy: rockchip-inno-usb2: correct 480MHz output
 clock stable time
In-Reply-To: <1479106911-16049-3-git-send-email-wulf@rock-chips.com>
Message-ID: <201611141523.W3QwkU4E%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi William,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.9-rc5 next-20161114]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/William-Wu/phy-rockchip-inno-usb2-correct-clk_ops-callback/20161114-150723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/phy/phy-rockchip-inno-usb2.c: In function 'rockchip_usb2phy_clk480m_prepare':
>> drivers/phy/phy-rockchip-inno-usb2.c:169:3: error: too few arguments to function 'usleep_range'
      usleep_range(1200);
      ^~~~~~~~~~~~
   In file included from drivers/phy/phy-rockchip-inno-usb2.c:19:0:
   include/linux/delay.h:48:6: note: declared here
    void usleep_range(unsigned long min, unsigned long max);
         ^~~~~~~~~~~~

vim +/usleep_range +169 drivers/phy/phy-rockchip-inno-usb2.c

   163		if (!property_enabled(rphy, &rphy->phy_cfg->clkout_ctl)) {
   164			ret = property_enable(rphy, &rphy->phy_cfg->clkout_ctl, true);
   165			if (ret)
   166				return ret;
   167	
   168			/* waitting for the clk become stable */
 > 169			usleep_range(1200);
   170		}
   171	
   172		return 0;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56817 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/7b23a10b/attachment-0001.gz>
