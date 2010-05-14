From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 14 May 2010 09:50:23 +0200
Subject: [PATCH v4] ARM: S5PC100: Pre-requisite clock patch for
	plat-s5pc1xx to plat-s5p move
In-Reply-To: <1273822048-17632-1-git-send-email-kgene.kim@samsung.com>
References: <1273822048-17632-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <008701caf33a$1f293f10$5d7bbd30$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday, May 14, 2010 9:27 AM Kukjin Kim wrote:

> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This is a pre-requisite clock patch for the plat-s5pc1xx to plat-s5p
> movement. The patches that perform the movement of the code from
> plat-s5pc1xx to plat-s5p (and mach-s5pc100) should also enable the
> build for the mach-s5pc100/clock.c code.
> 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Looks and works fine.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>  arch/arm/mach-s5pc100/clock.c                   | 1358
> +++++++++++++++++++++++
>  arch/arm/mach-s5pc100/include/mach/regs-clock.h |   71 ++
>  arch/arm/plat-s5p/clock.c                       |    2 +-
>  arch/arm/plat-s5p/include/plat/pll.h            |   22 +
>  arch/arm/plat-s5p/include/plat/s5p-clock.h      |    2 +
>  5 files changed, 1454 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-s5pc100/clock.c
>  create mode 100644 arch/arm/mach-s5pc100/include/mach/regs-clock.h
> 
> diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
> new file mode 100644
> index 0000000..e3fed4c
> --- /dev/null
> +++ b/arch/arm/mach-s5pc100/clock.c
> @@ -0,0 +1,1358 @@
> +/* linux/arch/arm/mach-s5pc100/clock.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PC100 - Clock support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include <mach/map.h>
> +
> +#include <plat/cpu-freq.h>
> +#include <mach/regs-clock.h>
> +#include <plat/clock.h>
> +#include <plat/cpu.h>
> +#include <plat/pll.h>
> +#include <plat/s5p-clock.h>
> +#include <plat/clock-clksrc.h>
> +#include <plat/s5pc100.h>
> +
> +static struct clk s5p_clk_otgphy = {
> +	.name		= "otg_phy",
> +	.id		= -1,
> +};
> +
> +static struct clk *clk_src_mout_href_list[] = {
> +	[0] = &s5p_clk_27m,
> +	[1] = &clk_fin_hpll,
> +};
> +
> +static struct clksrc_sources clk_src_mout_href = {
> +	.sources	= clk_src_mout_href_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_mout_href_list),
> +};
> +
> +static struct clksrc_clk clk_mout_href = {
> +	.clk = {
> +		.name           = "mout_href",
> +		.id             = -1,
> +	},
> +	.sources        = &clk_src_mout_href,
> +	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 20, .size = 1 },
> +};
> +
> +static struct clk *clk_src_mout_48m_list[] = {
> +	[0] = &clk_xusbxti,
> +	[1] = &s5p_clk_otgphy,
> +};
> +
> +static struct clksrc_sources clk_src_mout_48m = {
> +	.sources	= clk_src_mout_48m_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_mout_48m_list),
> +};
> +
> +static struct clksrc_clk clk_mout_48m = {
> +	.clk = {
> +		.name           = "mout_48m",
> +		.id             = -1,
> +	},
> +	.sources        = &clk_src_mout_48m,
> +	.reg_src        = { .reg = S5P_CLK_SRC1, .shift = 24, .size = 1 },
> +};
> +
> +static struct clksrc_clk clk_mout_mpll = {
> +	.clk = {
> +		.name           = "mout_mpll",
> +		.id             = -1,
> +	},
> +	.sources        = &clk_src_mpll,
> +	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 4, .size = 1 },
> +};
> +
> +
> +static struct clksrc_clk clk_mout_apll = {
> +	.clk    = {
> +		.name           = "mout_apll",
> +		.id             = -1,
> +	},
> +	.sources        = &clk_src_apll,
> +	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
> +};
> +
> +static struct clksrc_clk clk_mout_epll = {
> +	.clk    = {
> +		.name           = "mout_epll",
> +		.id             = -1,
> +	},
> +	.sources        = &clk_src_epll,
> +	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
> +};
> +
> +static struct clk *clk_src_mout_hpll_list[] = {
> +	[0] = &s5p_clk_27m,
> +};
> +
> +static struct clksrc_sources clk_src_mout_hpll = {
> +	.sources	= clk_src_mout_hpll_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_mout_hpll_list),
> +};
> +
> +static struct clksrc_clk clk_mout_hpll = {
> +	.clk    = {
> +		.name           = "mout_hpll",
> +		.id             = -1,
> +	},
> +	.sources        = &clk_src_mout_hpll,
> +	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 12, .size = 1 },
> +};
> +
> +static struct clksrc_clk clk_div_apll = {
> +	.clk	= {
> +		.name	= "div_apll",
> +		.id	= -1,
> +		.parent	= &clk_mout_apll.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 0, .size = 1 },
> +};
> +
> +static struct clksrc_clk clk_div_arm = {
> +	.clk	= {
> +		.name	= "div_arm",
> +		.id	= -1,
> +		.parent	= &clk_div_apll.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 4, .size = 3 },
> +};
> +
> +static struct clksrc_clk clk_div_d0_bus = {
> +	.clk	= {
> +		.name	= "div_d0_bus",
> +		.id	= -1,
> +		.parent	= &clk_div_arm.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 8, .size = 3 },
> +};
> +
> +static struct clksrc_clk clk_div_pclkd0 = {
> +	.clk	= {
> +		.name	= "div_pclkd0",
> +		.id	= -1,
> +		.parent	= &clk_div_d0_bus.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 12, .size = 3 },
> +};
> +
> +static struct clksrc_clk clk_div_secss = {
> +	.clk	= {
> +		.name	= "div_secss",
> +		.id	= -1,
> +		.parent	= &clk_div_d0_bus.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 16, .size = 3 },
> +};
> +
> +static struct clksrc_clk clk_div_apll2 = {
> +	.clk	= {
> +		.name	= "div_apll2",
> +		.id	= -1,
> +		.parent	= &clk_mout_apll.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 0, .size = 3 },
> +};
> +
> +static struct clk *clk_src_mout_am_list[] = {
> +	[0] = &clk_mout_mpll.clk,
> +	[1] = &clk_div_apll2.clk,
> +};
> +
> +struct clksrc_sources clk_src_mout_am = {
> +	.sources	= clk_src_mout_am_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_mout_am_list),
> +};
> +
> +static struct clksrc_clk clk_mout_am = {
> +	.clk	= {
> +		.name	= "mout_am",
> +		.id	= -1,
> +	},
> +	.sources = &clk_src_mout_am,
> +	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 16, .size = 1 },
> +};
> +
> +static struct clksrc_clk clk_div_d1_bus = {
> +	.clk	= {
> +		.name	= "div_d1_bus",
> +		.id	= -1,
> +		.parent	= &clk_mout_am.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 3 },
> +};
> +
> +static struct clksrc_clk clk_div_mpll2 = {
> +	.clk	= {
> +		.name	= "div_mpll2",
> +		.id	= -1,
> +		.parent	= &clk_mout_am.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 8, .size = 1 },
> +};
> +
> +static struct clksrc_clk clk_div_mpll = {
> +	.clk	= {
> +		.name	= "div_mpll",
> +		.id	= -1,
> +		.parent	= &clk_mout_am.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 4, .size = 2 },
> +};
> +
> +static struct clk *clk_src_mout_onenand_list[] = {
> +	[0] = &clk_div_d0_bus.clk,
> +	[1] = &clk_div_d1_bus.clk,
> +};
> +
> +struct clksrc_sources clk_src_mout_onenand = {
> +	.sources	= clk_src_mout_onenand_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_mout_onenand_list),
> +};
> +
> +static struct clksrc_clk clk_mout_onenand = {
> +	.clk	= {
> +		.name	= "mout_onenand",
> +		.id	= -1,
> +	},
> +	.sources = &clk_src_mout_onenand,
> +	.reg_src = { .reg = S5P_CLK_SRC0, .shift = 24, .size = 1 },
> +};
> +
> +static struct clksrc_clk clk_div_onenand = {
> +	.clk	= {
> +		.name	= "div_onenand",
> +		.id	= -1,
> +		.parent	= &clk_mout_onenand.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 20, .size = 2 },
> +};
> +
> +static struct clksrc_clk clk_div_pclkd1 = {
> +	.clk	= {
> +		.name	= "div_pclkd1",
> +		.id	= -1,
> +		.parent	= &clk_div_d1_bus.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 16, .size = 3 },
> +};
> +
> +static struct clksrc_clk clk_div_cam = {
> +	.clk	= {
> +		.name	= "div_cam",
> +		.id	= -1,
> +		.parent	= &clk_div_mpll2.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV1, .shift = 24, .size = 5 },
> +};
> +
> +static struct clksrc_clk clk_div_hdmi = {
> +	.clk	= {
> +		.name	= "div_hdmi",
> +		.id	= -1,
> +		.parent	= &clk_mout_hpll.clk,
> +	},
> +	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 28, .size = 4 },
> +};
> +
> +static int s5pc100_epll_enable(struct clk *clk, int enable)
> +{
> +	unsigned int ctrlbit = clk->ctrlbit;
> +	unsigned int epll_con = __raw_readl(S5P_EPLL_CON) & ~ctrlbit;
> +
> +	if (enable)
> +		__raw_writel(epll_con | ctrlbit, S5P_EPLL_CON);
> +	else
> +		__raw_writel(epll_con, S5P_EPLL_CON);
> +
> +	return 0;
> +}
> +
> +static unsigned long s5pc100_epll_get_rate(struct clk *clk)
> +{
> +	return clk->rate;
> +}
> +
> +static u32 epll_div[][4] = {
> +	{ 32750000,	131, 3, 4 },
> +	{ 32768000,	131, 3, 4 },
> +	{ 36000000,	72,  3, 3 },
> +	{ 45000000,	90,  3, 3 },
> +	{ 45158000,	90,  3, 3 },
> +	{ 45158400,	90,  3, 3 },
> +	{ 48000000,	96,  3, 3 },
> +	{ 49125000,	131, 4, 3 },
> +	{ 49152000,	131, 4, 3 },
> +	{ 60000000,	120, 3, 3 },
> +	{ 67737600,	226, 5, 3 },
> +	{ 67738000,	226, 5, 3 },
> +	{ 73800000,	246, 5, 3 },
> +	{ 73728000,	246, 5, 3 },
> +	{ 72000000,	144, 3, 3 },
> +	{ 84000000,	168, 3, 3 },
> +	{ 96000000,	96,  3, 2 },
> +	{ 144000000,	144, 3, 2 },
> +	{ 192000000,	96,  3, 1 }
> +};
> +
> +static int s5pc100_epll_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	unsigned int epll_con;
> +	unsigned int i;
> +
> +	if (clk->rate == rate)	/* Return if nothing changed */
> +		return 0;
> +
> +	epll_con = __raw_readl(S5P_EPLL_CON);
> +
> +	epll_con &= ~(PLL65XX_MDIV_MASK | PLL65XX_PDIV_MASK |
> PLL65XX_SDIV_MASK);
> +
> +	for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
> +		if (epll_div[i][0] == rate) {
> +			epll_con |= (epll_div[i][1] << PLL65XX_MDIV_SHIFT) |
> +				    (epll_div[i][2] << PLL65XX_PDIV_SHIFT) |
> +				    (epll_div[i][3] << PLL65XX_SDIV_SHIFT);
> +			break;
> +		}
> +	}
> +
> +	if (i == ARRAY_SIZE(epll_div)) {
> +		printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	__raw_writel(epll_con, S5P_EPLL_CON);
> +
> +	clk->rate = rate;
> +
> +	return 0;
> +}
> +
> +static struct clk_ops s5pc100_epll_ops = {
> +	.get_rate = s5pc100_epll_get_rate,
> +	.set_rate = s5pc100_epll_set_rate,
> +};
> +
> +static int s5pc100_d0_0_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D00, clk, enable);
> +}
> +
> +static int s5pc100_d0_1_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D01, clk, enable);
> +}
> +
> +static int s5pc100_d0_2_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D02, clk, enable);
> +}
> +
> +static int s5pc100_d1_0_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D10, clk, enable);
> +}
> +
> +static int s5pc100_d1_1_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D11, clk, enable);
> +}
> +
> +static int s5pc100_d1_2_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D12, clk, enable);
> +}
> +
> +static int s5pc100_d1_3_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D13, clk, enable);
> +}
> +
> +static int s5pc100_d1_4_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D14, clk, enable);
> +}
> +
> +static int s5pc100_d1_5_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_D15, clk, enable);
> +}
> +
> +static int s5pc100_sclk0_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_SCLK0, clk, enable);
> +}
> +
> +static int s5pc100_sclk1_ctrl(struct clk *clk, int enable)
> +{
> +	return s5p_gatectrl(S5P_CLKGATE_SCLK1, clk, enable);
> +}
> +
> +/*
> + * The following clocks will be disabled during clock initialization. It
> is
> + * recommended to keep the following clocks disabled until the driver
> requests
> + * for enabling the clock.
> + */
> +static struct clk init_clocks_disable[] = {
> +	{
> +		.name		= "cssys",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_0_ctrl,
> +		.ctrlbit	= (1 << 6),
> +	}, {
> +		.name		= "secss",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_0_ctrl,
> +		.ctrlbit	= (1 << 5),
> +	}, {
> +		.name		= "g2d",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_0_ctrl,
> +		.ctrlbit	= (1 << 4),
> +	}, {
> +		.name		= "mdma",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_0_ctrl,
> +		.ctrlbit	= (1 << 3),
> +	}, {
> +		.name		= "cfcon",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_0_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "nfcon",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_1_ctrl,
> +		.ctrlbit	= (1 << 3),
> +	}, {
> +		.name		= "onenandc",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_1_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "sdm",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_2_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "seckey",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_2_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 2,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 7),
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 6),
> +	}, {
> +		.name		= "hsmmc",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 5),
> +	}, {
> +		.name		= "modemif",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 4),
> +	}, {
> +		.name		= "otg",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 3),
> +	}, {
> +		.name		= "usbhost",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "pdma",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "pdma",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	}, {
> +		.name		= "lcd",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_1_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	}, {
> +		.name		= "rotator",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_1_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "fimc",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_1_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "fimc",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_1_ctrl,
> +		.ctrlbit	= (1 << 3),
> +	}, {
> +		.name		= "fimc",
> +		.id		= 2,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_1_ctrl,
> +		.ctrlbit	= (1 << 4),
> +	}, {
> +		.name		= "jpeg",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_1_ctrl,
> +		.ctrlbit	= (1 << 5),
> +	}, {
> +		.name		= "mipi-dsim",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_1_ctrl,
> +		.ctrlbit	= (1 << 6),
> +	}, {
> +		.name		= "mipi-csis",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_1_ctrl,
> +		.ctrlbit	= (1 << 7),
> +	}, {
> +		.name		= "g3d",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_0_ctrl,
> +		.ctrlbit	= (1 << 8),
> +	}, {
> +		.name		= "tv",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_2_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	}, {
> +		.name		= "vp",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_2_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "mixer",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_2_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "hdmi",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_2_ctrl,
> +		.ctrlbit	= (1 << 3),
> +	}, {
> +		.name		= "mfc",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_2_ctrl,
> +		.ctrlbit	= (1 << 4),
> +	}, {
> +		.name		= "apc",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_3_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "iec",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_3_ctrl,
> +		.ctrlbit	= (1 << 3),
> +	}, {
> +		.name		= "systimer",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_3_ctrl,
> +		.ctrlbit	= (1 << 7),
> +	}, {
> +		.name		= "watchdog",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_3_ctrl,
> +		.ctrlbit	= (1 << 8),
> +	}, {
> +		.name		= "rtc",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_3_ctrl,
> +		.ctrlbit	= (1 << 9),
> +	}, {
> +		.name		= "i2c",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 4),
> +	}, {
> +		.name		= "i2c",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 5),
> +	}, {
> +		.name		= "spi",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 6),
> +	}, {
> +		.name		= "spi",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 7),
> +	}, {
> +		.name		= "spi",
> +		.id		= 2,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 8),
> +	}, {
> +		.name		= "irda",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 9),
> +	}, {
> +		.name		= "ccan",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 10),
> +	}, {
> +		.name		= "ccan",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 11),
> +	}, {
> +		.name		= "hsitx",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 12),
> +	}, {
> +		.name		= "hsirx",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 13),
> +	}, {
> +		.name		= "iis",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	}, {
> +		.name		= "iis",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "iis",
> +		.id		= 2,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "ac97",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 3),
> +	}, {
> +		.name		= "pcm",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 4),
> +	}, {
> +		.name		= "pcm",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 5),
> +	}, {
> +		.name		= "spdif",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 6),
> +	}, {
> +		.name		= "adc",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 7),
> +	}, {
> +		.name		= "keyif",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_5_ctrl,
> +		.ctrlbit	= (1 << 8),
> +	}, {
> +		.name		= "spi_48m",
> +		.id		= 0,
> +		.parent		= &clk_mout_48m.clk,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= (1 << 7),
> +	}, {
> +		.name		= "spi_48m",
> +		.id		= 1,
> +		.parent		= &clk_mout_48m.clk,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= (1 << 8),
> +	}, {
> +		.name		= "spi_48m",
> +		.id		= 2,
> +		.parent		= &clk_mout_48m.clk,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= (1 << 9),
> +	}, {
> +		.name		= "mmc_48m",
> +		.id		= 0,
> +		.parent		= &clk_mout_48m.clk,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= (1 << 15),
> +	}, {
> +		.name		= "mmc_48m",
> +		.id		= 1,
> +		.parent		= &clk_mout_48m.clk,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= (1 << 16),
> +	}, {
> +		.name		= "mmc_48m",
> +		.id		= 2,
> +		.parent		= &clk_mout_48m.clk,
> +		.enable		= s5pc100_sclk0_ctrl,
> +		.ctrlbit	= (1 << 17),
> +	},
> +};
> +
> +static struct clk clk_vclk54m = {
> +	.name		= "vclk_54m",
> +	.id		= -1,
> +	.rate		= 54000000,
> +};
> +
> +static struct clk clk_i2scdclk0 = {
> +	.name		= "i2s_cdclk0",
> +	.id		= -1,
> +};
> +
> +static struct clk clk_i2scdclk1 = {
> +	.name		= "i2s_cdclk1",
> +	.id		= -1,
> +};
> +
> +static struct clk clk_i2scdclk2 = {
> +	.name		= "i2s_cdclk2",
> +	.id		= -1,
> +};
> +
> +static struct clk clk_pcmcdclk0 = {
> +	.name		= "pcm_cdclk0",
> +	.id		= -1,
> +};
> +
> +static struct clk clk_pcmcdclk1 = {
> +	.name		= "pcm_cdclk1",
> +	.id		= -1,
> +};
> +
> +static struct clk *clk_src_group1_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll2.clk,
> +	[2] = &clk_fin_epll,
> +	[3] = &clk_mout_hpll.clk,
> +};
> +
> +struct clksrc_sources clk_src_group1 = {
> +	.sources	= clk_src_group1_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_group1_list),
> +};
> +
> +static struct clk *clk_src_group2_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll.clk,
> +};
> +
> +struct clksrc_sources clk_src_group2 = {
> +	.sources	= clk_src_group2_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_group2_list),
> +};
> +
> +static struct clk *clk_src_group3_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll.clk,
> +	[2] = &clk_fin_epll,
> +	[3] = &clk_i2scdclk0,
> +	[4] = &clk_pcmcdclk0,
> +	[5] = &clk_mout_hpll.clk,
> +};
> +
> +struct clksrc_sources clk_src_group3 = {
> +	.sources	= clk_src_group3_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_group3_list),
> +};
> +
> +static struct clk *clk_src_group4_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll.clk,
> +	[2] = &clk_fin_epll,
> +	[3] = &clk_i2scdclk1,
> +	[4] = &clk_pcmcdclk1,
> +	[5] = &clk_mout_hpll.clk,
> +};
> +
> +struct clksrc_sources clk_src_group4 = {
> +	.sources	= clk_src_group4_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_group4_list),
> +};
> +
> +static struct clk *clk_src_group5_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll.clk,
> +	[2] = &clk_fin_epll,
> +	[3] = &clk_i2scdclk2,
> +	[4] = &clk_mout_hpll.clk,
> +};
> +
> +struct clksrc_sources clk_src_group5 = {
> +	.sources	= clk_src_group5_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_group5_list),
> +};
> +
> +static struct clk *clk_src_group6_list[] = {
> +	[0] = &s5p_clk_27m,
> +	[1] = &clk_vclk54m,
> +	[2] = &clk_div_hdmi.clk,
> +};
> +
> +struct clksrc_sources clk_src_group6 = {
> +	.sources	= clk_src_group6_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_group6_list),
> +};
> +
> +static struct clk *clk_src_group7_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll.clk,
> +	[2] = &clk_mout_hpll.clk,
> +	[3] = &clk_vclk54m,
> +};
> +
> +struct clksrc_sources clk_src_group7 = {
> +	.sources	= clk_src_group7_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_group7_list),
> +};
> +
> +static struct clk *clk_src_mmc0_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll.clk,
> +	[2] = &clk_fin_epll,
> +};
> +
> +struct clksrc_sources clk_src_mmc0 = {
> +	.sources	= clk_src_mmc0_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_mmc0_list),
> +};
> +
> +static struct clk *clk_src_mmc12_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll.clk,
> +	[2] = &clk_fin_epll,
> +	[3] = &clk_mout_hpll.clk,
> +};
> +
> +struct clksrc_sources clk_src_mmc12 = {
> +	.sources	= clk_src_mmc12_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_mmc12_list),
> +};
> +
> +static struct clk *clk_src_irda_usb_list[] = {
> +	[0] = &clk_mout_epll.clk,
> +	[1] = &clk_div_mpll.clk,
> +	[2] = &clk_fin_epll,
> +	[3] = &clk_mout_hpll.clk,
> +};
> +
> +struct clksrc_sources clk_src_irda_usb = {
> +	.sources	= clk_src_irda_usb_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_irda_usb_list),
> +};
> +
> +static struct clk *clk_src_pwi_list[] = {
> +	[0] = &clk_fin_epll,
> +	[1] = &clk_mout_epll.clk,
> +	[2] = &clk_div_mpll.clk,
> +};
> +
> +struct clksrc_sources clk_src_pwi = {
> +	.sources	= clk_src_pwi_list,
> +	.nr_sources	= ARRAY_SIZE(clk_src_pwi_list),
> +};
> +
> +static struct clksrc_clk clksrcs[] = {
> +	{
> +		.clk	= {
> +			.name		= "sclk_spi",
> +			.id		= 0,
> +			.ctrlbit	= (1 << 4),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_group1,
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_spi",
> +			.id		= 1,
> +			.ctrlbit	= (1 << 5),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_group1,
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 8, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 8, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_spi",
> +			.id		= 2,
> +			.ctrlbit	= (1 << 6),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_group1,
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 12, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 12, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "uclk1",
> +			.id		= -1,
> +			.ctrlbit	= (1 << 3),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_group2,
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 0, .size = 1 },
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_mixer",
> +			.id		= -1,
> +			.ctrlbit	= (1 << 6),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_group6,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 28, .size = 2 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_audio",
> +			.id		= 0,
> +			.ctrlbit	= (1 << 8),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_group3,
> +		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 12, .size = 3 },
> +		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 12, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_audio",
> +			.id		= 1,
> +			.ctrlbit	= (1 << 9),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_group4,
> +		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 16, .size = 3 },
> +		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 16, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_audio",
> +			.id		= 2,
> +			.ctrlbit	= (1 << 10),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_group5,
> +		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 20, .size = 3 },
> +		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 20, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_lcd",
> +			.id		= -1,
> +			.ctrlbit	= (1 << 0),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_group7,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 12, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_fimc",
> +			.id		= 0,
> +			.ctrlbit	= (1 << 1),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_group7,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 16, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 16, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_fimc",
> +			.id		= 1,
> +			.ctrlbit	= (1 << 2),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_group7,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 20, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 20, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_fimc",
> +			.id		= 2,
> +			.ctrlbit	= (1 << 3),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_group7,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 24, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 24, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "mmc_bus",
> +			.id		= 0,
> +			.ctrlbit	= (1 << 12),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_mmc0,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 0, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 0, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "mmc_bus",
> +			.id		= 1,
> +			.ctrlbit	= (1 << 13),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_mmc12,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 4, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 4, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "mmc_bus",
> +			.id		= 2,
> +			.ctrlbit	= (1 << 14),
> +			.enable		= s5pc100_sclk1_ctrl,
> +
> +		},
> +		.sources = &clk_src_mmc12,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_irda",
> +			.id		= 2,
> +			.ctrlbit	= (1 << 10),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_irda_usb,
> +		.reg_src = { .reg = S5P_CLK_SRC2, .shift = 8, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_irda",
> +			.id		= -1,
> +			.ctrlbit	= (1 << 10),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_mmc12,
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 16, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 16, .size = 4 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_pwi",
> +			.id		= -1,
> +			.ctrlbit	= (1 << 1),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_pwi,
> +		.reg_src = { .reg = S5P_CLK_SRC3, .shift = 0, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV4, .shift = 0, .size = 3 },
> +	}, {
> +		.clk	= {
> +			.name		= "sclk_uhost",
> +			.id		= -1,
> +			.ctrlbit	= (1 << 11),
> +			.enable		= s5pc100_sclk0_ctrl,
> +
> +		},
> +		.sources = &clk_src_irda_usb,
> +		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 20, .size = 2 },
> +		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 20, .size = 4 },
> +	},
> +};
> +
> +/* Clock initialisation code */
> +static struct clksrc_clk *sysclks[] = {
> +	&clk_mout_apll,
> +	&clk_mout_epll,
> +	&clk_mout_mpll,
> +	&clk_mout_hpll,
> +	&clk_mout_href,
> +	&clk_mout_48m,
> +	&clk_div_apll,
> +	&clk_div_arm,
> +	&clk_div_d0_bus,
> +	&clk_div_pclkd0,
> +	&clk_div_secss,
> +	&clk_div_apll2,
> +	&clk_mout_am,
> +	&clk_div_d1_bus,
> +	&clk_div_mpll2,
> +	&clk_div_mpll,
> +	&clk_mout_onenand,
> +	&clk_div_onenand,
> +	&clk_div_pclkd1,
> +	&clk_div_cam,
> +	&clk_div_hdmi,
> +};
> +
> +void __init_or_cpufreq s5pc100_setup_clocks(void)
> +{
> +	unsigned long xtal;
> +	unsigned long arm;
> +	unsigned long hclkd0;
> +	unsigned long hclkd1;
> +	unsigned long pclkd0;
> +	unsigned long pclkd1;
> +	unsigned long apll;
> +	unsigned long mpll;
> +	unsigned long epll;
> +	unsigned long hpll;
> +	unsigned int ptr;
> +
> +	/* Set S5PC100 functions for clk_fout_epll */
> +	clk_fout_epll.enable = s5pc100_epll_enable;
> +	clk_fout_epll.ops = &s5pc100_epll_ops;
> +
> +	printk(KERN_DEBUG "%s: registering clocks\n", __func__);
> +
> +	xtal = clk_get_rate(&clk_xtal);
> +
> +	printk(KERN_DEBUG "%s: xtal is %ld\n", __func__, xtal);
> +
> +	apll = s5p_get_pll65xx(xtal, __raw_readl(S5P_APLL_CON));
> +	mpll = s5p_get_pll65xx(xtal, __raw_readl(S5P_MPLL_CON));
> +	epll = s5p_get_pll65xx(xtal, __raw_readl(S5P_EPLL_CON));
> +	hpll = s5p_get_pll65xx(xtal, __raw_readl(S5P_HPLL_CON));
> +
> +	printk(KERN_INFO "S5PC100: PLL settings, A=%ld.%ldMHz, M=%ld.%ldMHz,
> E=%ld.%ldMHz, H=%ld.%ldMHz\n",
> +			print_mhz(apll), print_mhz(mpll), print_mhz(epll),
> print_mhz(hpll));
> +
> +	clk_fout_apll.rate = apll;
> +	clk_fout_mpll.rate = mpll;
> +	clk_fout_epll.rate = epll;
> +	clk_mout_hpll.clk.rate = hpll;
> +
> +	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
> +		s3c_set_clksrc(&clksrcs[ptr], true);
> +
> +	arm = clk_get_rate(&clk_div_arm.clk);
> +	hclkd0 = clk_get_rate(&clk_div_d0_bus.clk);
> +	pclkd0 = clk_get_rate(&clk_div_pclkd0.clk);
> +	hclkd1 = clk_get_rate(&clk_div_d1_bus.clk);
> +	pclkd1 = clk_get_rate(&clk_div_pclkd1.clk);
> +
> +	printk(KERN_INFO "S5PC100: HCLKD0=%ld.%ldMHz, HCLKD1=%ld.%ldMHz,
> PCLKD0=%ld.%ldMHz, PCLKD1=%ld.%ldMHz\n",
> +			print_mhz(hclkd0), print_mhz(hclkd1), print_mhz(pclkd0),
> print_mhz(pclkd1));
> +
> +	clk_f.rate = arm;
> +	clk_h.rate = hclkd1;
> +	clk_p.rate = pclkd1;
> +}
> +
> +/*
> + * The following clocks will be enabled during clock initialization.
> + */
> +static struct clk init_clocks[] = {
> +	{
> +		.name		= "tzic",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_0_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "intc",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_0_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	}, {
> +		.name		= "ebi",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_1_ctrl,
> +		.ctrlbit	= (1 << 5),
> +	}, {
> +		.name		= "intmem",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_1_ctrl,
> +		.ctrlbit	= (1 << 4),
> +	}, {
> +		.name		= "sromc",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_1_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "dmc",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_1_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	}, {
> +		.name		= "chipid",
> +		.id		= -1,
> +		.parent		= &clk_div_d0_bus.clk,
> +		.enable		= s5pc100_d0_1_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	}, {
> +		.name		= "gpio",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_3_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "uart",
> +		.id		= 0,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 0),
> +	}, {
> +		.name		= "uart",
> +		.id		= 1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 1),
> +	}, {
> +		.name		= "uart",
> +		.id		= 2,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 2),
> +	}, {
> +		.name		= "uart",
> +		.id		= 3,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_4_ctrl,
> +		.ctrlbit	= (1 << 3),
> +	}, {
> +		.name		= "timers",
> +		.id		= -1,
> +		.parent		= &clk_div_d1_bus.clk,
> +		.enable		= s5pc100_d1_3_ctrl,
> +		.ctrlbit	= (1 << 6),
> +	},
> +};
> +
> +static struct clk *clks[] __initdata = {
> +	&clk_ext,
> +	&clk_i2scdclk0,
> +	&clk_i2scdclk1,
> +	&clk_i2scdclk2,
> +	&clk_pcmcdclk0,
> +	&clk_pcmcdclk1,
> +};
> +
> +void __init s5pc100_register_clocks(void)
> +{
> +	struct clk *clkp;
> +	int ret;
> +	int ptr;
> +
> +	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
> +
> +	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
> +		s3c_register_clksrc(sysclks[ptr], 1);
> +
> +	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
> +	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
> +
> +	clkp = init_clocks_disable;
> +	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
> +
> +		ret = s3c24xx_register_clock(clkp);
> +		if (ret < 0) {
> +			printk(KERN_ERR "Failed to register clock %s (%d)\n",
> +			       clkp->name, ret);
> +		}
> +		(clkp->enable)(clkp, 0);
> +	}
> +
> +	s3c_pwmclk_init();
> +}
> diff --git a/arch/arm/mach-s5pc100/include/mach/regs-clock.h
> b/arch/arm/mach-s5pc100/include/mach/regs-clock.h
> new file mode 100644
> index 0000000..f2283bd
> --- /dev/null
> +++ b/arch/arm/mach-s5pc100/include/mach/regs-clock.h
> @@ -0,0 +1,71 @@
> +/* linux/arch/arm/mach-s5pc100/include/mach/regs-clock.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PC100 - Clock register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_CLOCK_H
> +#define __ASM_ARCH_REGS_CLOCK_H __FILE__
> +
> +#include <mach/map.h>
> +
> +#define S5P_CLKREG(x)		(S3C_VA_SYS + (x))
> +
> +#define S5P_APLL_LOCK		S5P_CLKREG(0x00)
> +#define S5P_MPLL_LOCK		S5P_CLKREG(0x04)
> +#define S5P_EPLL_LOCK		S5P_CLKREG(0x08)
> +#define S5P_HPLL_LOCK		S5P_CLKREG(0x0C)
> +
> +#define S5P_APLL_CON		S5P_CLKREG(0x100)
> +#define S5P_MPLL_CON		S5P_CLKREG(0x104)
> +#define S5P_EPLL_CON		S5P_CLKREG(0x108)
> +#define S5P_HPLL_CON		S5P_CLKREG(0x10C)
> +
> +#define S5P_CLK_SRC0		S5P_CLKREG(0x200)
> +#define S5P_CLK_SRC1		S5P_CLKREG(0x204)
> +#define S5P_CLK_SRC2		S5P_CLKREG(0x208)
> +#define S5P_CLK_SRC3		S5P_CLKREG(0x20C)
> +
> +#define S5P_CLK_DIV0		S5P_CLKREG(0x300)
> +#define S5P_CLK_DIV1		S5P_CLKREG(0x304)
> +#define S5P_CLK_DIV2		S5P_CLKREG(0x308)
> +#define S5P_CLK_DIV3		S5P_CLKREG(0x30C)
> +#define S5P_CLK_DIV4		S5P_CLKREG(0x310)
> +
> +#define S5P_CLK_OUT		S5P_CLKREG(0x400)
> +
> +#define S5P_CLKGATE_D00		S5P_CLKREG(0x500)
> +#define S5P_CLKGATE_D01		S5P_CLKREG(0x504)
> +#define S5P_CLKGATE_D02		S5P_CLKREG(0x508)
> +
> +#define S5P_CLKGATE_D10		S5P_CLKREG(0x520)
> +#define S5P_CLKGATE_D11		S5P_CLKREG(0x524)
> +#define S5P_CLKGATE_D12		S5P_CLKREG(0x528)
> +#define S5P_CLKGATE_D13		S5P_CLKREG(0x52C)
> +#define S5P_CLKGATE_D14		S5P_CLKREG(0x530)
> +#define S5P_CLKGATE_D15		S5P_CLKREG(0x534)
> +
> +#define S5P_CLKGATE_D20		S5P_CLKREG(0x540)
> +
> +#define S5P_CLKGATE_SCLK0	S5P_CLKREG(0x560)
> +#define S5P_CLKGATE_SCLK1	S5P_CLKREG(0x564)
> +
> +/* CLKDIV0 */
> +#define S5P_CLKDIV0_D0_MASK		(0x7<<8)
> +#define S5P_CLKDIV0_D0_SHIFT		(8)
> +#define S5P_CLKDIV0_PCLKD0_MASK		(0x7<<12)
> +#define S5P_CLKDIV0_PCLKD0_SHIFT	(12)
> +
> +/* CLKDIV1 */
> +#define S5P_CLKDIV1_D1_MASK		(0x7<<12)
> +#define S5P_CLKDIV1_D1_SHIFT		(12)
> +#define S5P_CLKDIV1_PCLKD1_MASK		(0x7<<16)
> +#define S5P_CLKDIV1_PCLKD1_SHIFT	(16)
> +
> +#endif /* __ASM_ARCH_REGS_CLOCK_H */
> diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
> index 3fef951..24d116c 100644
> --- a/arch/arm/plat-s5p/clock.c
> +++ b/arch/arm/plat-s5p/clock.c
> @@ -38,7 +38,7 @@ struct clk clk_xusbxti = {
>  	.id		= -1,
>  };
> 
> -static struct clk s5p_clk_27m = {
> +struct clk s5p_clk_27m = {
>  	.name		= "clk_27m",
>  	.id		= -1,
>  	.rate		= 27000000,
> diff --git a/arch/arm/plat-s5p/include/plat/pll.h b/arch/arm/plat-
> s5p/include/plat/pll.h
> index d48325b..7db3227 100644
> --- a/arch/arm/plat-s5p/include/plat/pll.h
> +++ b/arch/arm/plat-s5p/include/plat/pll.h
> @@ -81,3 +81,25 @@ static inline unsigned long s5p_get_pll90xx(unsigned
> long baseclk,
> 
>  	return result;
>  }
> +
> +#define PLL65XX_MDIV_MASK	(0x3FF)
> +#define PLL65XX_PDIV_MASK	(0x3F)
> +#define PLL65XX_SDIV_MASK	(0x7)
> +#define PLL65XX_MDIV_SHIFT	(16)
> +#define PLL65XX_PDIV_SHIFT	(8)
> +#define PLL65XX_SDIV_SHIFT	(0)
> +
> +static inline unsigned long s5p_get_pll65xx(unsigned long baseclk, u32
> pll_con)
> +{
> +	u32 mdiv, pdiv, sdiv;
> +	u64 fvco = baseclk;
> +
> +	mdiv = (pll_con >> PLL65XX_MDIV_SHIFT) & PLL65XX_MDIV_MASK;
> +	pdiv = (pll_con >> PLL65XX_PDIV_SHIFT) & PLL65XX_PDIV_MASK;
> +	sdiv = (pll_con >> PLL65XX_SDIV_SHIFT) & PLL65XX_SDIV_MASK;
> +
> +	fvco *= mdiv;
> +	do_div(fvco, (pdiv << sdiv));
> +
> +	return (unsigned long)fvco;
> +}
> diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-
> s5p/include/plat/s5p-clock.h
> index a476a9f..b142607 100644
> --- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
> +++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
> @@ -21,10 +21,12 @@
>  #define clk_fin_mpll clk_ext_xtal_mux
>  #define clk_fin_epll clk_ext_xtal_mux
>  #define clk_fin_vpll clk_ext_xtal_mux
> +#define clk_fin_hpll clk_ext_xtal_mux
> 
>  extern struct clk clk_ext_xtal_mux;
>  extern struct clk clk_xusbxti;
>  extern struct clk clk_48m;
> +extern struct clk s5p_clk_27m;
>  extern struct clk clk_fout_apll;
>  extern struct clk clk_fout_mpll;
>  extern struct clk clk_fout_epll;
> --
> 1.6.3.3

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
