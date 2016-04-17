From: lkp@intel.com (kbuild test robot)
Date: Sun, 17 Apr 2016 09:25:50 +0800
Subject: [PATCH 1/2] clk: sunxi: add predivider handling for factors clock
In-Reply-To: <1460832906-24064-2-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <201604170901.pPL2YWTP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vishnu,

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.6-rc3 next-20160415]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Vishnu-Patekar/sunxi-factors-clock-predivider-handling/20160417-025801
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-sunxi_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Vishnu-Patekar/sunxi-factors-clock-predivider-handling/20160417-025801 HEAD 19bb5fc952754381d9f4f9b2e57a1fa09f467359 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/clk/sunxi/clk-sunxi.c: In function 'sun6i_get_ahb1_factors':
>> drivers/clk/sunxi/clk-sunxi.c:310:9: error: 'struct factors_request' has no member named 'parent_index'
     if (req->parent_index == SUN6I_AHB1_PARENT_PLL6) {
            ^
   drivers/clk/sunxi/clk-sunxi.c: In function 'sun6i_ahb1_recalc':
   drivers/clk/sunxi/clk-sunxi.c:340:9: error: 'struct factors_request' has no member named 'parent_index'
     if (req->parent_index == SUN6I_AHB1_PARENT_PLL6)
            ^

vim +310 drivers/clk/sunxi/clk-sunxi.c

a78bb355 Chen-Yu Tsai 2016-01-25  304  	if (req->parent_rate && req->rate > req->parent_rate)
a78bb355 Chen-Yu Tsai 2016-01-25  305  		req->rate = req->parent_rate;
a78bb355 Chen-Yu Tsai 2016-01-25  306  
a78bb355 Chen-Yu Tsai 2016-01-25  307  	div = DIV_ROUND_UP(req->parent_rate, req->rate);
a78bb355 Chen-Yu Tsai 2016-01-25  308  
a78bb355 Chen-Yu Tsai 2016-01-25  309  	/* calculate pre-divider if parent is pll6 */
a78bb355 Chen-Yu Tsai 2016-01-25 @310  	if (req->parent_index == SUN6I_AHB1_PARENT_PLL6) {
a78bb355 Chen-Yu Tsai 2016-01-25  311  		if (div < 4)
a78bb355 Chen-Yu Tsai 2016-01-25  312  			calcp = 0;
a78bb355 Chen-Yu Tsai 2016-01-25  313  		else if (div / 2 < 4)

:::::: The code at line 310 was first introduced by commit
:::::: a78bb35552a800949b2bf68f372d3d6ccabdd790 clk: sunxi: rewrite sun6i-a31-ahb1-clk using factors clk with custom recalc

:::::: TO: Chen-Yu Tsai <wens@csie.org>
:::::: CC: Maxime Ripard <maxime.ripard@free-electrons.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 19218 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160417/140effd9/attachment-0001.obj>
