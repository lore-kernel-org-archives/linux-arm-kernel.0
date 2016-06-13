From: lkp@intel.com (kbuild test robot)
Date: Mon, 13 Jun 2016 19:42:02 +0800
Subject: [PATCH V2 1/1] clk: imx: refine the powerdown bit of clk-pllv3
In-Reply-To: <1465803434-31507-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <201606131954.Hm2ncCa4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on shawnguo/for-next]
[cannot apply to v4.7-rc3 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dong-Aisheng/clk-imx-refine-the-powerdown-bit-of-clk-pllv3/20160613-160108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-imx_v4_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/clk/imx/clk-pllv3.c: In function 'clk_pllv3_prepare':
>> drivers/clk/imx/clk-pllv3.c:82:14: error: 'struct clk_pllv3' has no member named 'powerdown'
      val &= ~pll->powerdown;
                 ^
   drivers/clk/imx/clk-pllv3.c: In function 'clk_pllv3_unprepare':
   drivers/clk/imx/clk-pllv3.c:97:13: error: 'struct clk_pllv3' has no member named 'powerdown'
      val |= pll->powerdown;
                ^

vim +82 drivers/clk/imx/clk-pllv3.c

bc3b84da arch/arm/mach-imx/clk-pllv3.c Shawn Guo     2013-10-30  76  	u32 val;
bc3b84da arch/arm/mach-imx/clk-pllv3.c Shawn Guo     2013-10-30  77  
bc3b84da arch/arm/mach-imx/clk-pllv3.c Shawn Guo     2013-10-30  78  	val = readl_relaxed(pll->base);
bc3b84da arch/arm/mach-imx/clk-pllv3.c Shawn Guo     2013-10-30  79  	if (pll->powerup_set)
b3e3e45d drivers/clk/imx/clk-pllv3.c   Dong Aisheng  2016-06-13  80  		val |= pll->power_bit;
0a036388 arch/arm/mach-imx/clk-pllv3.c Peter Chen    2013-07-16  81  	else
b3e76bdc drivers/clk/imx/clk-pllv3.c   Dong Aisheng  2016-06-08 @82  		val &= ~pll->powerdown;
bc3b84da arch/arm/mach-imx/clk-pllv3.c Shawn Guo     2013-10-30  83  	writel_relaxed(val, pll->base);
bc3b84da arch/arm/mach-imx/clk-pllv3.c Shawn Guo     2013-10-30  84  
c400f7a2 arch/arm/mach-imx/clk-pllv3.c Dmitry Voytik 2014-11-06  85  	return clk_pllv3_wait_lock(pll);

:::::: The code at line 82 was first introduced by commit
:::::: b3e76bdc0b2190e67427d31cd740debd01c03631 clk: imx: clk-pllv3: fix incorrect handle of enet powerdown bit

:::::: TO: Dong Aisheng <aisheng.dong@nxp.com>
:::::: CC: Shawn Guo <shawnguo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22549 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160613/d18ff405/attachment-0001.obj>
