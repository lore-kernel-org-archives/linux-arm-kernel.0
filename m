From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 May 2015 09:32:16 -0700
Subject: [PATCHv3 00/27] ARM: OMAP2+: clock code move under clk driver
In-Reply-To: <20150526160557.GD16525@atomide.com>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <20150526160557.GD16525@atomide.com>
Message-ID: <20150526163216.GF16525@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150526 09:08]:
> * Tero Kristo <t-kristo@ti.com> [150525 08:01]:
> > Hi,
> > 
> > As requested, posting v3 with somewhat changed diff parameters and
> > diffstat attached. Just some minor Makefile changes compared to v2,
> > these were discussed under that set.
> > 
> > Set has been pushed to:
> > - tree: https://github.com/t-kristo/linux-pm.git
> > - branch: for-4.2/ti-clk-move
> 
> Looks like this causes a build error for at least omap2 only .config:
> 
> drivers/clk/ti/dpll3xxx.o:(.rodata+0x1c): multiple definition of `clkhwops_omap3_dpll'
> drivers/clk/ti/dpll.o:(.rodata+0x0): first defined here
> 
> You may want to create a file selecting ARCH_OMAP2PLUS=y, then point
> KCONFIG_ALLCONFIG to that file for make randconfig. Then just build
> randconfigs :) Usually the issues like this are exposed within few
> randconfig builds, some take longer if the options have dependencies.

Found more similar issues for omap3 only and omap4 only configs:

drivers/built-in.o: In function `omap2_clkops_enable_clkdm':
omap-gpmc.c:(.text+0x202e0): undefined reference to `ti_clk_get_features'
drivers/built-in.o: In function `omap2_clkops_disable_clkdm':
omap-gpmc.c:(.text+0x20374): undefined reference to `ti_clk_get_features'
drivers/built-in.o: In function `_omap2_dpll_is_in_bypass':
omap-gpmc.c:(.text+0x21678): undefined reference to `ti_clk_get_features'
drivers/built-in.o: In function `omap2_dpll_round_rate':
omap-gpmc.c:(.text+0x218ac): undefined reference to `ti_clk_get_features'
omap-gpmc.c:(.text+0x218ec): undefined reference to `ti_clk_get_features'

drivers/built-in.o: In function `omap3xxx_dt_clk_init':
omap-gpmc.c:(.init.text+0x4d60): undefined reference to `omap2_clk_enable_init_clocks'
arch/arm/mach-omap2/built-in.o: In function `ti_clk_init_features':

arch/arm/mach-omap2/built-in.o: In function `ti_clk_init_features':
dss-common.c:(.init.text+0x4368): undefined reference to `ti_clk_setup_features'

Regards,

Tony
