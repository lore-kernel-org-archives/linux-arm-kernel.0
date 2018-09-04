From: lkp@intel.com (kbuild test robot)
Date: Tue, 4 Sep 2018 23:49:09 +0800
Subject: [PATCH 06/27] clk: sunxi-ng: h6: Set video PLLs limits
In-Reply-To: <20180902072643.4917-7-jernej.skrabec@siol.net>
Message-ID: <20180904154909.GR17047@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jernej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sunxi/sunxi/for-next]
[also build test WARNING on v4.19-rc2 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/Allwinner-H6-DE3-and-HDMI-support/20180903-082543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__
:::::: branch date: 6 hours ago
:::::: commit date: 6 hours ago

>> drivers/clk/sunxi-ng/ccu-sun50i-h6.c:124:27: sparse: constant 2400000000 is so big it is long
   drivers/clk/sunxi-ng/ccu-sun50i-h6.c:142:27: sparse: constant 2400000000 is so big it is long

# https://github.com/0day-ci/linux/commit/752a88510f0bcada69753fccb31adb187f80f29a
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 752a88510f0bcada69753fccb31adb187f80f29a
vim +124 drivers/clk/sunxi-ng/ccu-sun50i-h6.c

524353ea4 Icenowy Zheng  2018-03-16  111  
524353ea4 Icenowy Zheng  2018-03-16  112  /*
524353ea4 Icenowy Zheng  2018-03-16  113   * For Video PLLs, the output divider is described as "used for testing"
524353ea4 Icenowy Zheng  2018-03-16  114   * in the user manual. So it's not modelled and forced to 0.
524353ea4 Icenowy Zheng  2018-03-16  115   */
524353ea4 Icenowy Zheng  2018-03-16  116  #define SUN50I_H6_PLL_VIDEO0_REG	0x040
524353ea4 Icenowy Zheng  2018-03-16  117  static struct ccu_nm pll_video0_clk = {
524353ea4 Icenowy Zheng  2018-03-16  118  	.enable		= BIT(31),
524353ea4 Icenowy Zheng  2018-03-16  119  	.lock		= BIT(28),
524353ea4 Icenowy Zheng  2018-03-16  120  	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
524353ea4 Icenowy Zheng  2018-03-16  121  	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
524353ea4 Icenowy Zheng  2018-03-16  122  	.fixed_post_div	= 4,
752a88510 Jernej Skrabec 2018-09-02  123  	.min_rate	= 288000000,
752a88510 Jernej Skrabec 2018-09-02 @124  	.max_rate	= 2400000000,
524353ea4 Icenowy Zheng  2018-03-16  125  	.common		= {
524353ea4 Icenowy Zheng  2018-03-16  126  		.reg		= 0x040,
524353ea4 Icenowy Zheng  2018-03-16  127  		.features	= CCU_FEATURE_FIXED_POSTDIV,
524353ea4 Icenowy Zheng  2018-03-16  128  		.hw.init	= CLK_HW_INIT("pll-video0", "osc24M",
524353ea4 Icenowy Zheng  2018-03-16  129  					      &ccu_nm_ops,
524353ea4 Icenowy Zheng  2018-03-16  130  					      CLK_SET_RATE_UNGATE),
524353ea4 Icenowy Zheng  2018-03-16  131  	},
524353ea4 Icenowy Zheng  2018-03-16  132  };
524353ea4 Icenowy Zheng  2018-03-16  133  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
