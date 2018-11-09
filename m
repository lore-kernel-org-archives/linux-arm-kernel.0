From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 09 Nov 2018 09:25:26 -0800
Subject: [PATCH v12 2/5] clk: imx: add fractional PLL output clock
In-Reply-To: <201811091832.kSh4BXdS%fengguang.wu@intel.com>
References: <1541594266-16712-3-git-send-email-abel.vesa@nxp.com>
 <201811091832.kSh4BXdS%fengguang.wu@intel.com>
Message-ID: <154178432653.88331.17907414252177481094@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting kbuild test robot (2018-11-09 02:18:24)
> Hi Lucas,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on shawnguo/for-next]
> [also build test ERROR on v4.20-rc1 next-20181109]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Abel-Vesa/Add-i-MX8MQ-clock-driver/20181109-063930
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
> config: arm-multi_v5_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/clk/imx/clk-frac-pll.o: In function `clk_pll_recalc_rate':
> >> clk-frac-pll.c:(.text+0x74): undefined reference to `__aeabi_uldivmod'
>    drivers/clk/imx/clk-frac-pll.o: In function `clk_pll_round_rate':
>    clk-frac-pll.c:(.text+0xbc): undefined reference to `__aeabi_uldivmod'
> 

Why does the code do essentially:

	u64 val;

	do_div(val, div);
	val /= div2;

That should be using do_div() twice it seems.
