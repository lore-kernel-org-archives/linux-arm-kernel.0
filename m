From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  8 Sep 2010 20:06:29 +0900
Subject: [PATCH v2 04/13] ARM: S5P64X0: Update Clock for S5P6440 and S5P6450
Message-ID: <1283943989-6812-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates regarding clock files for supporting S5P6440 and
S5P6450 with one kernel image. The mach-s5p64x0/clock.c is for common
of them and there are specific clock files for each SoCs.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Changes since v1:
- Modified spi clock name to use one clock source in spi

 arch/arm/mach-s5p6440/clock.c                      |  846 --------------------
 arch/arm/mach-s5p6440/include/mach/regs-clock.h    |  130 ---
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |  626 +++++++++++++++
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |  655 +++++++++++++++
 arch/arm/mach-s5p64x0/clock.c                      |  253 ++++++
 arch/arm/mach-s5p64x0/include/mach/regs-clock.h    |   63 ++
 arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h |   46 ++
 arch/arm/plat-s5p/clock.c                          |   19 +
 arch/arm/plat-s5p/include/plat/pll.h               |    7 +
 arch/arm/plat-s5p/include/plat/s5p-clock.h         |    8 +-
 10 files changed, 1674 insertions(+), 979 deletions(-)
 delete mode 100644 arch/arm/mach-s5p6440/clock.c
 delete mode 100644 arch/arm/mach-s5p6440/include/mach/regs-clock.h
 create mode 100644 arch/arm/mach-s5p64x0/clock-s5p6440.c
 create mode 100644 arch/arm/mach-s5p64x0/clock-s5p6450.c
 create mode 100644 arch/arm/mach-s5p64x0/clock.c
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/regs-clock.h
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h

diff --git a/arch/arm/mach-s5p6440/clock.c b/arch/arm/mach-s5p6440/clock.c
deleted file mode 100644
index ca6e48d..0000000
--- a/arch/arm/mach-s5p6440/clock.c
+++ /dev/null
@@ -1,846 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/clock.c
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6440 - Clock support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/errno.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/sysdev.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-
-#include <plat/cpu-freq.h>
-#include <mach/regs-clock.h>
-#include <plat/clock.h>
-#include <plat/cpu.h>
-#include <plat/clock-clksrc.h>
-#include <plat/s5p-clock.h>
-#include <plat/pll.h>
-#include <plat/s5p6440.h>
-
-/* APLL Mux output clock */
-static struct clksrc_clk clk_mout_apll = {
-	.clk    = {
-		.name           = "mout_apll",
-		.id             = -1,
-	},
-	.sources        = &clk_src_apll,
-	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 0, .size = 1 },
-};
-
-static int s5p6440_epll_enable(struct clk *clk, int enable)
-{
-	unsigned int ctrlbit = clk->ctrlbit;
-	unsigned int epll_con = __raw_readl(S5P_EPLL_CON) & ~ctrlbit;
-
-	if (enable)
-		__raw_writel(epll_con | ctrlbit, S5P_EPLL_CON);
-	else
-		__raw_writel(epll_con, S5P_EPLL_CON);
-
-	return 0;
-}
-
-static unsigned long s5p6440_epll_get_rate(struct clk *clk)
-{
-	return clk->rate;
-}
-
-static u32 epll_div[][5] = {
-	{ 36000000,	0,	48, 1, 4 },
-	{ 48000000,	0,	32, 1, 3 },
-	{ 60000000,	0,	40, 1, 3 },
-	{ 72000000,	0,	48, 1, 3 },
-	{ 84000000,	0,	28, 1, 2 },
-	{ 96000000,	0,	32, 1, 2 },
-	{ 32768000,	45264,	43, 1, 4 },
-	{ 45158000,	6903,	30, 1, 3 },
-	{ 49152000,	50332,	32, 1, 3 },
-	{ 67738000,	10398,	45, 1, 3 },
-	{ 73728000,	9961,	49, 1, 3 }
-};
-
-static int s5p6440_epll_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned int epll_con, epll_con_k;
-	unsigned int i;
-
-	if (clk->rate == rate)	/* Return if nothing changed */
-		return 0;
-
-	epll_con = __raw_readl(S5P_EPLL_CON);
-	epll_con_k = __raw_readl(S5P_EPLL_CON_K);
-
-	epll_con_k &= ~(PLL90XX_KDIV_MASK);
-	epll_con &= ~(PLL90XX_MDIV_MASK | PLL90XX_PDIV_MASK | PLL90XX_SDIV_MASK);
-
-	for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
-		 if (epll_div[i][0] == rate) {
-			epll_con_k |= (epll_div[i][1] << PLL90XX_KDIV_SHIFT);
-			epll_con |= (epll_div[i][2] << PLL90XX_MDIV_SHIFT) |
-				    (epll_div[i][3] << PLL90XX_PDIV_SHIFT) |
-				    (epll_div[i][4] << PLL90XX_SDIV_SHIFT);
-			break;
-		}
-	}
-
-	if (i == ARRAY_SIZE(epll_div)) {
-		printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n", __func__);
-		return -EINVAL;
-	}
-
-	__raw_writel(epll_con, S5P_EPLL_CON);
-	__raw_writel(epll_con_k, S5P_EPLL_CON_K);
-
-	clk->rate = rate;
-
-	return 0;
-}
-
-static struct clk_ops s5p6440_epll_ops = {
-	.get_rate = s5p6440_epll_get_rate,
-	.set_rate = s5p6440_epll_set_rate,
-};
-
-static struct clksrc_clk clk_mout_epll = {
-	.clk    = {
-		.name           = "mout_epll",
-		.id             = -1,
-	},
-	.sources        = &clk_src_epll,
-	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 2, .size = 1 },
-};
-
-static struct clksrc_clk clk_mout_mpll = {
-	.clk = {
-		.name           = "mout_mpll",
-		.id             = -1,
-	},
-	.sources        = &clk_src_mpll,
-	.reg_src        = { .reg = S5P_CLK_SRC0, .shift = 1, .size = 1 },
-};
-
-enum perf_level {
-	L0 = 532*1000,
-	L1 = 266*1000,
-	L2 = 133*1000,
-};
-
-static const u32 clock_table[][3] = {
-	/*{ARM_CLK, DIVarm, DIVhclk}*/
-	{L0 * 1000, (0 << ARM_DIV_RATIO_SHIFT), (3 << S5P_CLKDIV0_HCLK_SHIFT)},
-	{L1 * 1000, (1 << ARM_DIV_RATIO_SHIFT), (1 << S5P_CLKDIV0_HCLK_SHIFT)},
-	{L2 * 1000, (3 << ARM_DIV_RATIO_SHIFT), (0 << S5P_CLKDIV0_HCLK_SHIFT)},
-};
-
-static unsigned long s5p6440_armclk_get_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	u32 clkdiv;
-
-	/* divisor mask starts at bit0, so no need to shift */
-	clkdiv = __raw_readl(ARM_CLK_DIV) & ARM_DIV_MASK;
-
-	return rate / (clkdiv + 1);
-}
-
-static unsigned long s5p6440_armclk_round_rate(struct clk *clk,
-						unsigned long rate)
-{
-	u32 iter;
-
-	for (iter = 1 ; iter < ARRAY_SIZE(clock_table) ; iter++) {
-		if (rate > clock_table[iter][0])
-			return clock_table[iter-1][0];
-	}
-
-	return clock_table[ARRAY_SIZE(clock_table) - 1][0];
-}
-
-static int s5p6440_armclk_set_rate(struct clk *clk, unsigned long rate)
-{
-	u32 round_tmp;
-	u32 iter;
-	u32 clk_div0_tmp;
-	u32 cur_rate = clk->ops->get_rate(clk);
-	unsigned long flags;
-
-	round_tmp = clk->ops->round_rate(clk, rate);
-	if (round_tmp == cur_rate)
-		return 0;
-
-
-	for (iter = 0 ; iter < ARRAY_SIZE(clock_table) ; iter++) {
-		if (round_tmp == clock_table[iter][0])
-			break;
-	}
-
-	if (iter >= ARRAY_SIZE(clock_table))
-		iter = ARRAY_SIZE(clock_table) - 1;
-
-	local_irq_save(flags);
-	if (cur_rate > round_tmp) {
-		/* Frequency Down */
-		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) & ~(ARM_DIV_MASK);
-		clk_div0_tmp |= clock_table[iter][1];
-		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
-
-		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) &
-				~(S5P_CLKDIV0_HCLK_MASK);
-		clk_div0_tmp |= clock_table[iter][2];
-		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
-
-
-	} else {
-		/* Frequency Up */
-		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) &
-				~(S5P_CLKDIV0_HCLK_MASK);
-		clk_div0_tmp |= clock_table[iter][2];
-		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
-
-		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) & ~(ARM_DIV_MASK);
-		clk_div0_tmp |= clock_table[iter][1];
-		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
-		}
-	local_irq_restore(flags);
-
-	clk->rate = clock_table[iter][0];
-
-	return 0;
-}
-
-static struct clk_ops s5p6440_clkarm_ops = {
-	.get_rate	= s5p6440_armclk_get_rate,
-	.set_rate	= s5p6440_armclk_set_rate,
-	.round_rate	= s5p6440_armclk_round_rate,
-};
-
-static struct clksrc_clk clk_armclk = {
-	.clk	= {
-		.name	= "armclk",
-		.id	= 1,
-		.parent	= &clk_mout_apll.clk,
-		.ops	= &s5p6440_clkarm_ops,
-	},
-	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 0, .size = 4 },
-};
-
-static struct clksrc_clk clk_dout_mpll = {
-	.clk	= {
-		.name	= "dout_mpll",
-		.id	= -1,
-		.parent	= &clk_mout_mpll.clk,
-	},
-	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 4, .size = 1 },
-};
-
-static struct clksrc_clk clk_hclk = {
-	.clk	= {
-		.name	= "clk_hclk",
-		.id	= -1,
-		.parent	= &clk_armclk.clk,
-	},
-	.reg_div	= { .reg = S5P_CLK_DIV0, .shift = 8, .size = 4 },
-};
-
-static struct clksrc_clk clk_pclk = {
-	.clk	= {
-		.name	= "clk_pclk",
-		.id	= -1,
-		.parent	= &clk_hclk.clk,
-	},
-	.reg_div = { .reg = S5P_CLK_DIV0, .shift = 12, .size = 4 },
-};
-
-static struct clk *clkset_hclklow_list[] = {
-	&clk_mout_apll.clk,
-	&clk_mout_mpll.clk,
-};
-
-static struct clksrc_sources clkset_hclklow = {
-	.sources	= clkset_hclklow_list,
-	.nr_sources	= ARRAY_SIZE(clkset_hclklow_list),
-};
-
-static struct clksrc_clk clk_hclk_low = {
-	.clk = {
-		.name	= "hclk_low",
-		.id	= -1,
-	},
-	.sources	= &clkset_hclklow,
-	.reg_src	= { .reg = S5P_SYS_OTHERS, .shift = 6, .size = 1 },
-	.reg_div	= { .reg = S5P_CLK_DIV3, .shift = 8, .size = 4 },
-};
-
-static struct clksrc_clk clk_pclk_low = {
-	.clk	= {
-		.name	= "pclk_low",
-		.id	= -1,
-		.parent	= &clk_hclk_low.clk,
-	},
-	.reg_div = { .reg = S5P_CLK_DIV3, .shift = 12, .size = 4 },
-};
-
-int s5p6440_clk48m_ctrl(struct clk *clk, int enable)
-{
-	unsigned long flags;
-	u32 val;
-
-	/* can't rely on clock lock, this register has other usages */
-	local_irq_save(flags);
-
-	val = __raw_readl(S5P_OTHERS);
-	if (enable)
-		val |= S5P_OTHERS_USB_SIG_MASK;
-	else
-		val &= ~S5P_OTHERS_USB_SIG_MASK;
-
-	__raw_writel(val, S5P_OTHERS);
-
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static int s5p6440_pclk_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLK_GATE_PCLK, clk, enable);
-}
-
-static int s5p6440_hclk0_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLK_GATE_HCLK0, clk, enable);
-}
-
-static int s5p6440_hclk1_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLK_GATE_HCLK1, clk, enable);
-}
-
-static int s5p6440_sclk_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLK_GATE_SCLK0, clk, enable);
-}
-
-static int s5p6440_sclk1_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLK_GATE_SCLK1, clk, enable);
-}
-
-static int s5p6440_mem_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(S5P_CLK_GATE_MEM0, clk, enable);
-}
-
-/*
- * The following clocks will be disabled during clock initialization. It is
- * recommended to keep the following clocks disabled until the driver requests
- * for enabling the clock.
- */
-static struct clk init_clocks_disable[] = {
-	{
-		.name		= "nand",
-		.id		= -1,
-		.parent		= &clk_hclk.clk,
-		.enable		= s5p6440_mem_ctrl,
-		.ctrlbit	= S5P_CLKCON_MEM0_HCLK_NFCON,
-	}, {
-		.name		= "adc",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_TSADC,
-	}, {
-		.name		= "i2c",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_IIC0,
-	}, {
-		.name		= "i2s_v40",
-		.id		= 0,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_IIS2,
-	}, {
-		.name		= "spi",
-		.id		= 0,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_SPI0,
-	}, {
-		.name		= "spi",
-		.id		= 1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_SPI1,
-	}, {
-		.name		= "sclk_spi_48",
-		.id		= 0,
-		.parent		= &clk_48m,
-		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_SPI0_48,
-	}, {
-		.name		= "sclk_spi_48",
-		.id		= 1,
-		.parent		= &clk_48m,
-		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_SPI1_48,
-	}, {
-		.name		= "mmc_48m",
-		.id		= 0,
-		.parent		= &clk_48m,
-		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_MMC0_48,
-	}, {
-		.name		= "mmc_48m",
-		.id		= 1,
-		.parent		= &clk_48m,
-		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_MMC1_48,
-	}, {
-		.name		= "mmc_48m",
-		.id		= 2,
-		.parent		= &clk_48m,
-		.enable		= s5p6440_sclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_SCLK0_MMC2_48,
-	}, {
-		.name    	= "otg",
-		.id	   	= -1,
-		.parent		= &clk_hclk_low.clk,
-		.enable  	= s5p6440_hclk0_ctrl,
-		.ctrlbit 	= S5P_CLKCON_HCLK0_USB
-	}, {
-		.name    	= "post",
-		.id	   	= -1,
-		.parent		= &clk_hclk_low.clk,
-		.enable  	= s5p6440_hclk0_ctrl,
-		.ctrlbit 	= S5P_CLKCON_HCLK0_POST0
-	}, {
-		.name		= "lcd",
-		.id		= -1,
-		.parent		= &clk_hclk_low.clk,
-		.enable		= s5p6440_hclk1_ctrl,
-		.ctrlbit	= S5P_CLKCON_HCLK1_DISPCON,
-	}, {
-		.name		= "hsmmc",
-		.id		= 0,
-		.parent		= &clk_hclk_low.clk,
-		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC0,
-	}, {
-		.name		= "hsmmc",
-		.id		= 1,
-		.parent		= &clk_hclk_low.clk,
-		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC1,
-	}, {
-		.name		= "hsmmc",
-		.id		= 2,
-		.parent		= &clk_hclk_low.clk,
-		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= S5P_CLKCON_HCLK0_HSMMC2,
-	}, {
-		.name		= "rtc",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_RTC,
-	}, {
-		.name		= "watchdog",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_WDT,
-	}, {
-		.name		= "timers",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_PWM,
-	}, {
-		.name		= "hclk_fimgvg",
-		.id		= -1,
-		.parent		= &clk_hclk.clk,
-		.enable		= s5p6440_hclk1_ctrl,
-		.ctrlbit	= (1 << 2),
-	}, {
-		.name		= "tsi",
-		.id		= -1,
-		.parent		= &clk_hclk_low.clk,
-		.enable		= s5p6440_hclk1_ctrl,
-		.ctrlbit	= (1 << 0),
-	}, {
-		.name		= "pclk_fimgvg",
-		.id		= -1,
-		.parent		= &clk_pclk.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= (1 << 31),
-	}, {
-		.name		= "dmc0",
-		.id		= -1,
-		.parent		= &clk_pclk.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= (1 << 30),
-	}, {
-		.name		= "etm",
-		.id		= -1,
-		.parent		= &clk_pclk.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= (1 << 29),
-	}, {
-		.name		= "dsim",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= (1 << 28),
-	}, {
-		.name		= "gps",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= (1 << 25),
-	}, {
-		.name		= "pcm",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= (1 << 8),
-	}, {
-		.name		= "irom",
-		.id		= -1,
-		.parent		= &clk_hclk.clk,
-		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= (1 << 25),
-	}, {
-		.name		= "dma",
-		.id		= -1,
-		.parent		= &clk_hclk_low.clk,
-		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= (1 << 12),
-	}, {
-		.name		= "2d",
-		.id		= -1,
-		.parent		= &clk_hclk.clk,
-		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= (1 << 8),
-	},
-};
-
-/*
- * The following clocks will be enabled during clock initialization.
- */
-static struct clk init_clocks[] = {
-	{
-		.name		= "gpio",
-		.id		= -1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_GPIO,
-	}, {
-		.name		= "uart",
-		.id		= 0,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_UART0,
-	}, {
-		.name		= "uart",
-		.id		= 1,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_UART1,
-	}, {
-		.name		= "uart",
-		.id		= 2,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_UART2,
-	}, {
-		.name		= "uart",
-		.id		= 3,
-		.parent		= &clk_pclk_low.clk,
-		.enable		= s5p6440_pclk_ctrl,
-		.ctrlbit	= S5P_CLKCON_PCLK_UART3,
-	}, {
-		.name		= "mem",
-		.id		= -1,
-		.parent		= &clk_hclk.clk,
-		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= (1 << 21),
-	}, {
-		.name		= "intc",
-		.id		= -1,
-		.parent		= &clk_hclk.clk,
-		.enable		= s5p6440_hclk0_ctrl,
-		.ctrlbit	= (1 << 1),
-	},
-};
-
-static struct clk clk_iis_cd_v40 = {
-	.name		= "iis_cdclk_v40",
-	.id		= -1,
-};
-
-static struct clk clk_pcm_cd = {
-	.name		= "pcm_cdclk",
-	.id		= -1,
-};
-
-static struct clk *clkset_group1_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll.clk,
-	&clk_fin_epll,
-};
-
-static struct clksrc_sources clkset_group1 = {
-	.sources	= clkset_group1_list,
-	.nr_sources	= ARRAY_SIZE(clkset_group1_list),
-};
-
-static struct clk *clkset_uart_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll.clk,
-};
-
-static struct clksrc_sources clkset_uart = {
-	.sources	= clkset_uart_list,
-	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
-};
-
-static struct clk *clkset_audio_list[] = {
-	&clk_mout_epll.clk,
-	&clk_dout_mpll.clk,
-	&clk_fin_epll,
-	&clk_iis_cd_v40,
-	&clk_pcm_cd,
-};
-
-static struct clksrc_sources clkset_audio = {
-	.sources	= clkset_audio_list,
-	.nr_sources	= ARRAY_SIZE(clkset_audio_list),
-};
-
-static struct clksrc_clk clksrcs[] = {
-	{
-		.clk	= {
-			.name		= "mmc_bus",
-			.id		= 0,
-			.ctrlbit        = S5P_CLKCON_SCLK0_MMC0,
-			.enable		= s5p6440_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 18, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "mmc_bus",
-			.id		= 1,
-			.ctrlbit        = S5P_CLKCON_SCLK0_MMC1,
-			.enable		= s5p6440_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 20, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 4, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "mmc_bus",
-			.id		= 2,
-			.ctrlbit        = S5P_CLKCON_SCLK0_MMC2,
-			.enable		= s5p6440_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 22, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 8, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "uclk1",
-			.id		= -1,
-			.ctrlbit        = S5P_CLKCON_SCLK0_UART,
-			.enable		= s5p6440_sclk_ctrl,
-		},
-		.sources = &clkset_uart,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 13, .size = 1 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 16, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "spi_epll",
-			.id		= 0,
-			.ctrlbit        = S5P_CLKCON_SCLK0_SPI0,
-			.enable		= s5p6440_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 14, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "spi_epll",
-			.id		= 1,
-			.ctrlbit        = S5P_CLKCON_SCLK0_SPI1,
-			.enable		= s5p6440_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 16, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 4, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_post",
-			.id		= -1,
-			.ctrlbit	= (1 << 10),
-			.enable		= s5p6440_sclk_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC0, .shift = 26, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV1, .shift = 12, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_dispcon",
-			.id		= -1,
-			.ctrlbit	= (1 << 1),
-			.enable		= s5p6440_sclk1_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 4, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_fimgvg",
-			.id		= -1,
-			.ctrlbit	= (1 << 2),
-			.enable		= s5p6440_sclk1_ctrl,
-		},
-		.sources = &clkset_group1,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 8, .size = 2 },
-		.reg_div = { .reg = S5P_CLK_DIV3, .shift = 4, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_audio2",
-			.id		= -1,
-			.ctrlbit	= (1 << 11),
-			.enable		= s5p6440_sclk_ctrl,
-		},
-		.sources = &clkset_audio,
-		.reg_src = { .reg = S5P_CLK_SRC1, .shift = 0, .size = 3 },
-		.reg_div = { .reg = S5P_CLK_DIV2, .shift = 24, .size = 4 },
-	},
-};
-
-/* Clock initialisation code */
-static struct clksrc_clk *sysclks[] = {
-	&clk_mout_apll,
-	&clk_mout_epll,
-	&clk_mout_mpll,
-	&clk_dout_mpll,
-	&clk_armclk,
-	&clk_hclk,
-	&clk_pclk,
-	&clk_hclk_low,
-	&clk_pclk_low,
-};
-
-void __init_or_cpufreq s5p6440_setup_clocks(void)
-{
-	struct clk *xtal_clk;
-	unsigned long xtal;
-	unsigned long fclk;
-	unsigned long hclk;
-	unsigned long hclk_low;
-	unsigned long pclk;
-	unsigned long pclk_low;
-	unsigned long epll;
-	unsigned long apll;
-	unsigned long mpll;
-	unsigned int ptr;
-
-	/* Set S5P6440 functions for clk_fout_epll */
-	clk_fout_epll.enable = s5p6440_epll_enable;
-	clk_fout_epll.ops = &s5p6440_epll_ops;
-
-	clk_48m.enable = s5p6440_clk48m_ctrl;
-
-	xtal_clk = clk_get(NULL, "ext_xtal");
-	BUG_ON(IS_ERR(xtal_clk));
-
-	xtal = clk_get_rate(xtal_clk);
-	clk_put(xtal_clk);
-
-	epll = s5p_get_pll90xx(xtal, __raw_readl(S5P_EPLL_CON),
-				__raw_readl(S5P_EPLL_CON_K));
-	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P_MPLL_CON), pll_4502);
-	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P_APLL_CON), pll_4502);
-
-	clk_fout_mpll.rate = mpll;
-	clk_fout_epll.rate = epll;
-	clk_fout_apll.rate = apll;
-
-	printk(KERN_INFO "S5P6440: PLL settings, A=%ld.%ldMHz, M=%ld.%ldMHz," \
-			" E=%ld.%ldMHz\n",
-			print_mhz(apll), print_mhz(mpll), print_mhz(epll));
-
-	fclk = clk_get_rate(&clk_armclk.clk);
-	hclk = clk_get_rate(&clk_hclk.clk);
-	pclk = clk_get_rate(&clk_pclk.clk);
-	hclk_low = clk_get_rate(&clk_hclk_low.clk);
-	pclk_low = clk_get_rate(&clk_pclk_low.clk);
-
-	printk(KERN_INFO "S5P6440: HCLK=%ld.%ldMHz, HCLK_LOW=%ld.%ldMHz," \
-			" PCLK=%ld.%ldMHz, PCLK_LOW=%ld.%ldMHz\n",
-			print_mhz(hclk), print_mhz(hclk_low),
-			print_mhz(pclk), print_mhz(pclk_low));
-
-	clk_f.rate = fclk;
-	clk_h.rate = hclk;
-	clk_p.rate = pclk;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
-		s3c_set_clksrc(&clksrcs[ptr], true);
-}
-
-static struct clk *clks[] __initdata = {
-	&clk_ext,
-	&clk_iis_cd_v40,
-	&clk_pcm_cd,
-};
-
-void __init s5p6440_register_clocks(void)
-{
-	struct clk *clkp;
-	int ret;
-	int ptr;
-
-	ret = s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
-	if (ret > 0)
-		printk(KERN_ERR "Failed to register %u clocks\n", ret);
-
-	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
-		s3c_register_clksrc(sysclks[ptr], 1);
-
-	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
-	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
-
-	clkp = init_clocks_disable;
-	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
-
-		ret = s3c24xx_register_clock(clkp);
-		if (ret < 0) {
-			printk(KERN_ERR "Failed to register clock %s (%d)\n",
-			       clkp->name, ret);
-		}
-		(clkp->enable)(clkp, 0);
-	}
-
-	s3c_pwmclk_init();
-}
diff --git a/arch/arm/mach-s5p6440/include/mach/regs-clock.h b/arch/arm/mach-s5p6440/include/mach/regs-clock.h
deleted file mode 100644
index c783ecc..0000000
--- a/arch/arm/mach-s5p6440/include/mach/regs-clock.h
+++ /dev/null
@@ -1,130 +0,0 @@
-/* linux/arch/arm/mach-s5p6440/include/mach/regs-clock.h
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S5P6440 - Clock register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_CLOCK_H
-#define __ASM_ARCH_REGS_CLOCK_H __FILE__
-
-#include <mach/map.h>
-
-#define S5P_CLKREG(x)		(S3C_VA_SYS + (x))
-
-#define S5P_APLL_LOCK		S5P_CLKREG(0x00)
-#define S5P_MPLL_LOCK		S5P_CLKREG(0x04)
-#define S5P_EPLL_LOCK		S5P_CLKREG(0x08)
-#define S5P_APLL_CON		S5P_CLKREG(0x0C)
-#define S5P_MPLL_CON		S5P_CLKREG(0x10)
-#define S5P_EPLL_CON		S5P_CLKREG(0x14)
-#define S5P_EPLL_CON_K		S5P_CLKREG(0x18)
-#define S5P_CLK_SRC0		S5P_CLKREG(0x1C)
-#define S5P_CLK_DIV0		S5P_CLKREG(0x20)
-#define S5P_CLK_DIV1		S5P_CLKREG(0x24)
-#define S5P_CLK_DIV2		S5P_CLKREG(0x28)
-#define S5P_CLK_OUT		S5P_CLKREG(0x2C)
-#define S5P_CLK_GATE_HCLK0	S5P_CLKREG(0x30)
-#define S5P_CLK_GATE_PCLK	S5P_CLKREG(0x34)
-#define S5P_CLK_GATE_SCLK0	S5P_CLKREG(0x38)
-#define S5P_CLK_GATE_MEM0	S5P_CLKREG(0x3C)
-#define S5P_CLK_DIV3		S5P_CLKREG(0x40)
-#define S5P_CLK_GATE_HCLK1	S5P_CLKREG(0x44)
-#define S5P_CLK_GATE_SCLK1	S5P_CLKREG(0x48)
-#define S5P_AHB_CON0           	S5P_CLKREG(0x100)
-#define S5P_CLK_SRC1           	S5P_CLKREG(0x10C)
-#define S5P_SWRESET		S5P_CLKREG(0x114)
-#define S5P_SYS_ID		S5P_CLKREG(0x118)
-#define S5P_SYS_OTHERS		S5P_CLKREG(0x11C)
-#define S5P_MEM_CFG_STAT	S5P_CLKREG(0x12C)
-#define S5P_PWR_CFG		S5P_CLKREG(0x804)
-#define S5P_EINT_WAKEUP_MASK	S5P_CLKREG(0x808)
-#define S5P_NORMAL_CFG		S5P_CLKREG(0x810)
-#define S5P_STOP_CFG		S5P_CLKREG(0x814)
-#define S5P_SLEEP_CFG		S5P_CLKREG(0x818)
-#define S5P_OSC_FREQ		S5P_CLKREG(0x820)
-#define S5P_OSC_STABLE		S5P_CLKREG(0x824)
-#define S5P_PWR_STABLE		S5P_CLKREG(0x828)
-#define S5P_MTC_STABLE		S5P_CLKREG(0x830)
-#define S5P_OTHERS		S5P_CLKREG(0x900)
-#define S5P_RST_STAT		S5P_CLKREG(0x904)
-#define S5P_WAKEUP_STAT		S5P_CLKREG(0x908)
-#define S5P_SLPEN		S5P_CLKREG(0x930)
-#define S5P_INFORM0		S5P_CLKREG(0xA00)
-#define S5P_INFORM1		S5P_CLKREG(0xA04)
-#define S5P_INFORM2		S5P_CLKREG(0xA08)
-#define S5P_INFORM3		S5P_CLKREG(0xA0C)
-
-/* CLKDIV0 */
-#define S5P_CLKDIV0_PCLK_MASK		(0xf << 12)
-#define S5P_CLKDIV0_PCLK_SHIFT		(12)
-#define S5P_CLKDIV0_HCLK_MASK		(0xf << 8)
-#define S5P_CLKDIV0_HCLK_SHIFT		(8)
-#define S5P_CLKDIV0_MPLL_MASK		(0x1 << 4)
-#define S5P_CLKDIV0_ARM_MASK		(0xf << 0)
-#define S5P_CLKDIV0_ARM_SHIFT		(0)
-
-/* CLKDIV3 */
-#define S5P_CLKDIV3_PCLK_LOW_MASK	(0xf << 12)
-#define S5P_CLKDIV3_PCLK_LOW_SHIFT	(12)
-#define S5P_CLKDIV3_HCLK_LOW_MASK	(0xf << 8)
-#define S5P_CLKDIV3_HCLK_LOW_SHIFT	(8)
-
-/* HCLK0 GATE Registers */
-#define S5P_CLKCON_HCLK0_USB		(1<<20)
-#define S5P_CLKCON_HCLK0_HSMMC2		(1<<19)
-#define S5P_CLKCON_HCLK0_HSMMC1		(1<<18)
-#define S5P_CLKCON_HCLK0_HSMMC0		(1<<17)
-#define S5P_CLKCON_HCLK0_POST0		(1<<5)
-
-/* HCLK1 GATE Registers */
-#define S5P_CLKCON_HCLK1_DISPCON	(1<<1)
-
-/* PCLK GATE Registers */
-#define S5P_CLKCON_PCLK_IIS2		(1<<26)
-#define S5P_CLKCON_PCLK_SPI1		(1<<22)
-#define S5P_CLKCON_PCLK_SPI0		(1<<21)
-#define S5P_CLKCON_PCLK_GPIO		(1<<18)
-#define S5P_CLKCON_PCLK_IIC0		(1<<17)
-#define S5P_CLKCON_PCLK_TSADC		(1<<12)
-#define S5P_CLKCON_PCLK_PWM		(1<<7)
-#define S5P_CLKCON_PCLK_RTC		(1<<6)
-#define S5P_CLKCON_PCLK_WDT		(1<<5)
-#define S5P_CLKCON_PCLK_UART3		(1<<4)
-#define S5P_CLKCON_PCLK_UART2		(1<<3)
-#define S5P_CLKCON_PCLK_UART1		(1<<2)
-#define S5P_CLKCON_PCLK_UART0		(1<<1)
-
-/* SCLK0 GATE Registers */
-#define S5P_CLKCON_SCLK0_MMC2_48	(1<<29)
-#define S5P_CLKCON_SCLK0_MMC1_48	(1<<28)
-#define S5P_CLKCON_SCLK0_MMC0_48	(1<<27)
-#define S5P_CLKCON_SCLK0_MMC2		(1<<26)
-#define S5P_CLKCON_SCLK0_MMC1		(1<<25)
-#define S5P_CLKCON_SCLK0_MMC0		(1<<24)
-#define S5P_CLKCON_SCLK0_SPI1_48 	(1<<23)
-#define S5P_CLKCON_SCLK0_SPI0_48 	(1<<22)
-#define S5P_CLKCON_SCLK0_SPI1		(1<<21)
-#define S5P_CLKCON_SCLK0_SPI0		(1<<20)
-#define S5P_CLKCON_SCLK0_UART		(1<<5)
-
-/* SCLK1 GATE Registers */
-
-/* MEM0 GATE Registers */
-#define S5P_CLKCON_MEM0_HCLK_NFCON	(1<<2)
-
-/*OTHERS Resgister */
-#define S5P_OTHERS_USB_SIG_MASK		(1<<16)
-#define S5P_OTHERS_HCLK_LOW_SEL_MPLL	(1<<6)
-
-/* Compatibility defines */
-#define ARM_CLK_DIV			S5P_CLK_DIV0
-#define ARM_DIV_RATIO_SHIFT		0
-#define ARM_DIV_MASK			(0xf << ARM_DIV_RATIO_SHIFT)
-
-#endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6440.c b/arch/arm/mach-s5p64x0/clock-s5p6440.c
new file mode 100644
index 0000000..f93dcd8
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/clock-s5p6440.c
@@ -0,0 +1,626 @@
+/* linux/arch/arm/mach-s5p64x0/clock-s5p6440.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P6440 - Clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+#include <mach/s5p64x0-clock.h>
+
+#include <plat/cpu-freq.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/s5p-clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/s5p6440.h>
+
+static u32 epll_div[][5] = {
+	{ 36000000,	0,	48, 1, 4 },
+	{ 48000000,	0,	32, 1, 3 },
+	{ 60000000,	0,	40, 1, 3 },
+	{ 72000000,	0,	48, 1, 3 },
+	{ 84000000,	0,	28, 1, 2 },
+	{ 96000000,	0,	32, 1, 2 },
+	{ 32768000,	45264,	43, 1, 4 },
+	{ 45158000,	6903,	30, 1, 3 },
+	{ 49152000,	50332,	32, 1, 3 },
+	{ 67738000,	10398,	45, 1, 3 },
+	{ 73728000,	9961,	49, 1, 3 }
+};
+
+static int s5p6440_epll_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int epll_con, epll_con_k;
+	unsigned int i;
+
+	if (clk->rate == rate)	/* Return if nothing changed */
+		return 0;
+
+	epll_con = __raw_readl(S5P64X0_EPLL_CON);
+	epll_con_k = __raw_readl(S5P64X0_EPLL_CON_K);
+
+	epll_con_k &= ~(PLL90XX_KDIV_MASK);
+	epll_con &= ~(PLL90XX_MDIV_MASK | PLL90XX_PDIV_MASK | PLL90XX_SDIV_MASK);
+
+	for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
+		 if (epll_div[i][0] == rate) {
+			epll_con_k |= (epll_div[i][1] << PLL90XX_KDIV_SHIFT);
+			epll_con |= (epll_div[i][2] << PLL90XX_MDIV_SHIFT) |
+				    (epll_div[i][3] << PLL90XX_PDIV_SHIFT) |
+				    (epll_div[i][4] << PLL90XX_SDIV_SHIFT);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(epll_div)) {
+		printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n", __func__);
+		return -EINVAL;
+	}
+
+	__raw_writel(epll_con, S5P64X0_EPLL_CON);
+	__raw_writel(epll_con_k, S5P64X0_EPLL_CON_K);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+static struct clk_ops s5p6440_epll_ops = {
+	.get_rate = s5p64x0_epll_get_rate,
+	.set_rate = s5p6440_epll_set_rate,
+};
+
+static struct clksrc_clk clk_hclk = {
+	.clk	= {
+		.name		= "clk_hclk",
+		.id		= -1,
+		.parent		= &clk_armclk.clk,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV0, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk clk_pclk = {
+	.clk	= {
+		.name		= "clk_pclk",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV0, .shift = 12, .size = 4 },
+};
+static struct clksrc_clk clk_hclk_low = {
+	.clk	= {
+		.name		= "clk_hclk_low",
+		.id		= -1,
+	},
+	.sources	= &clkset_hclk_low,
+	.reg_src	= { .reg = S5P64X0_SYS_OTHERS, .shift = 6, .size = 1 },
+	.reg_div	= { .reg = S5P64X0_CLK_DIV3, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk clk_pclk_low = {
+	.clk	= {
+		.name		= "clk_pclk_low",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV3, .shift = 12, .size = 4 },
+};
+
+/*
+ * The following clocks will be disabled during clock initialization. It is
+ * recommended to keep the following clocks disabled until the driver requests
+ * for enabling the clock.
+ */
+static struct clk init_clocks_disable[] = {
+	{
+		.name		= "nand",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+		.enable		= s5p64x0_mem_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "post",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 5)
+	}, {
+		.name		= "2d",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 8),
+	}, {
+		.name		= "hsmmc",
+		.id		= 0,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 17),
+	}, {
+		.name		= "hsmmc",
+		.id		= 1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 18),
+	}, {
+		.name		= "hsmmc",
+		.id		= 2,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 19),
+	}, {
+		.name		= "otg",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 20)
+	}, {
+		.name		= "irom",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 25),
+	}, {
+		.name		= "lcd",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk1_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "hclk_fimgvg",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+		.enable		= s5p64x0_hclk1_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "tsi",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk1_ctrl,
+		.ctrlbit	= (1 << 0),
+	}, {
+		.name		= "watchdog",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 5),
+	}, {
+		.name		= "rtc",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 6),
+	}, {
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 7),
+	}, {
+		.name		= "pcm",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 8),
+	}, {
+		.name		= "adc",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
+		.name		= "i2c",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 17),
+	}, {
+		.name		= "spi",
+		.id		= 0,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 21),
+	}, {
+		.name		= "spi",
+		.id		= 1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 22),
+	}, {
+		.name		= "gps",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 25),
+	}, {
+		.name		= "i2s_v40",
+		.id		= 0,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
+		.name		= "dsim",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "etm",
+		.id		= -1,
+		.parent		= &clk_pclk.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 29),
+	}, {
+		.name		= "dmc0",
+		.id		= -1,
+		.parent		= &clk_pclk.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 30),
+	}, {
+		.name		= "pclk_fimgvg",
+		.id		= -1,
+		.parent		= &clk_pclk.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 31),
+	}, {
+		.name		= "sclk_spi_48",
+		.id		= 0,
+		.parent		= &clk_48m,
+		.enable		= s5p64x0_sclk_ctrl,
+		.ctrlbit	= (1 << 22),
+	}, {
+		.name		= "sclk_spi_48",
+		.id		= 1,
+		.parent		= &clk_48m,
+		.enable		= s5p64x0_sclk_ctrl,
+		.ctrlbit	= (1 << 23),
+	}, {
+		.name		= "mmc_48m",
+		.id		= 0,
+		.parent		= &clk_48m,
+		.enable		= s5p64x0_sclk_ctrl,
+		.ctrlbit	= (1 << 27),
+	}, {
+		.name		= "mmc_48m",
+		.id		= 1,
+		.parent		= &clk_48m,
+		.enable		= s5p64x0_sclk_ctrl,
+		.ctrlbit	= (1 << 28),
+	}, {
+		.name		= "mmc_48m",
+		.id		= 2,
+		.parent		= &clk_48m,
+		.enable		= s5p64x0_sclk_ctrl,
+		.ctrlbit	= (1 << 29),
+	},
+};
+
+/*
+ * The following clocks will be enabled during clock initialization.
+ */
+static struct clk init_clocks[] = {
+	{
+		.name		= "intc",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "mem",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 21),
+	}, {
+		.name		= "dma",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
+		.name		= "uart",
+		.id		= 0,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "uart",
+		.id		= 1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "uart",
+		.id		= 2,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "uart",
+		.id		= 3,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "gpio",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 18),
+	},
+};
+
+static struct clk clk_iis_cd_v40 = {
+	.name		= "iis_cdclk_v40",
+	.id		= -1,
+};
+
+static struct clk clk_pcm_cd = {
+	.name		= "pcm_cdclk",
+	.id		= -1,
+};
+
+static struct clk *clkset_group1_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll.clk,
+	&clk_fin_epll,
+};
+
+static struct clksrc_sources clkset_group1 = {
+	.sources	= clkset_group1_list,
+	.nr_sources	= ARRAY_SIZE(clkset_group1_list),
+};
+
+static struct clk *clkset_uart_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll.clk,
+};
+
+static struct clksrc_sources clkset_uart = {
+	.sources	= clkset_uart_list,
+	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
+};
+
+static struct clk *clkset_audio_list[] = {
+	&clk_mout_epll.clk,
+	&clk_dout_mpll.clk,
+	&clk_fin_epll,
+	&clk_iis_cd_v40,
+	&clk_pcm_cd,
+};
+
+static struct clksrc_sources clkset_audio = {
+	.sources	= clkset_audio_list,
+	.nr_sources	= ARRAY_SIZE(clkset_audio_list),
+};
+
+static struct clksrc_clk clksrcs[] = {
+	{
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 0,
+			.ctrlbit	= (1 << 24),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 18, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 1,
+			.ctrlbit	= (1 << 25),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 20, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 4, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "mmc_bus",
+			.id		= 2,
+			.ctrlbit	= (1 << 26),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 22, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 8, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "uclk1",
+			.id		= -1,
+			.ctrlbit	= (1 << 5),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 13, .size = 1 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 16, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_spi",
+			.id		= 0,
+			.ctrlbit	= (1 << 20),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 14, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_spi",
+			.id		= 1,
+			.ctrlbit	= (1 << 21),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 16, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 4, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_post",
+			.id		= -1,
+			.ctrlbit	= (1 << 10),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 26, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 12, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_dispcon",
+			.id		= -1,
+			.ctrlbit	= (1 << 1),
+			.enable		= s5p64x0_sclk1_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P64X0_CLK_SRC1, .shift = 4, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV3, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_fimgvg",
+			.id		= -1,
+			.ctrlbit	= (1 << 2),
+			.enable		= s5p64x0_sclk1_ctrl,
+		},
+		.sources = &clkset_group1,
+		.reg_src = { .reg = S5P64X0_CLK_SRC1, .shift = 8, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV3, .shift = 4, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_audio2",
+			.id		= -1,
+			.ctrlbit	= (1 << 11),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_audio,
+		.reg_src = { .reg = S5P64X0_CLK_SRC1, .shift = 0, .size = 3 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 24, .size = 4 },
+	},
+};
+
+/* Clock initialization code */
+static struct clksrc_clk *sysclks[] = {
+	&clk_mout_apll,
+	&clk_mout_epll,
+	&clk_mout_mpll,
+	&clk_dout_mpll,
+	&clk_armclk,
+	&clk_hclk,
+	&clk_pclk,
+	&clk_hclk_low,
+	&clk_pclk_low,
+};
+
+void __init_or_cpufreq s5p6440_setup_clocks(void)
+{
+	struct clk *xtal_clk;
+
+	unsigned long xtal;
+	unsigned long fclk;
+	unsigned long hclk;
+	unsigned long hclk_low;
+	unsigned long pclk;
+	unsigned long pclk_low;
+
+	unsigned long apll;
+	unsigned long mpll;
+	unsigned long epll;
+	unsigned int ptr;
+
+	/* Set S5P6440 functions for clk_fout_epll */
+
+	clk_fout_epll.enable = s5p64x0_epll_enable;
+	clk_fout_epll.ops = &s5p6440_epll_ops;
+
+	clk_48m.enable = s5p64x0_clk48m_ctrl;
+
+	xtal_clk = clk_get(NULL, "ext_xtal");
+	BUG_ON(IS_ERR(xtal_clk));
+
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P64X0_APLL_CON), pll_4502);
+	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P64X0_MPLL_CON), pll_4502);
+	epll = s5p_get_pll90xx(xtal, __raw_readl(S5P64X0_EPLL_CON),
+				__raw_readl(S5P64X0_EPLL_CON_K));
+
+	clk_fout_apll.rate = apll;
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+
+	printk(KERN_INFO "S5P6440: PLL settings, A=%ld.%ldMHz, M=%ld.%ldMHz," \
+			" E=%ld.%ldMHz\n",
+			print_mhz(apll), print_mhz(mpll), print_mhz(epll));
+
+	fclk = clk_get_rate(&clk_armclk.clk);
+	hclk = clk_get_rate(&clk_hclk.clk);
+	pclk = clk_get_rate(&clk_pclk.clk);
+	hclk_low = clk_get_rate(&clk_hclk_low.clk);
+	pclk_low = clk_get_rate(&clk_pclk_low.clk);
+
+	printk(KERN_INFO "S5P6440: HCLK=%ld.%ldMHz, HCLK_LOW=%ld.%ldMHz," \
+			" PCLK=%ld.%ldMHz, PCLK_LOW=%ld.%ldMHz\n",
+			print_mhz(hclk), print_mhz(hclk_low),
+			print_mhz(pclk), print_mhz(pclk_low));
+
+	clk_f.rate = fclk;
+	clk_h.rate = hclk;
+	clk_p.rate = pclk;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
+		s3c_set_clksrc(&clksrcs[ptr], true);
+}
+
+static struct clk *clks[] __initdata = {
+	&clk_ext,
+	&clk_iis_cd_v40,
+	&clk_pcm_cd,
+};
+
+void __init s5p6440_register_clocks(void)
+{
+	struct clk *clkp;
+	int ret;
+	int ptr;
+
+	s3c24xx_register_clocks(clks, ARRAY_SIZE(clks));
+
+	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
+		s3c_register_clksrc(sysclks[ptr], 1);
+
+	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+
+	clkp = init_clocks_disable;
+	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
+
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+		(clkp->enable)(clkp, 0);
+	}
+
+	s3c_pwmclk_init();
+}
diff --git a/arch/arm/mach-s5p64x0/clock-s5p6450.c b/arch/arm/mach-s5p64x0/clock-s5p6450.c
new file mode 100644
index 0000000..f9afb05
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/clock-s5p6450.c
@@ -0,0 +1,655 @@
+/* linux/arch/arm/mach-s5p64x0/clock-s5p6450.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P6450 - Clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+#include <mach/s5p64x0-clock.h>
+
+#include <plat/cpu-freq.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/s5p-clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/s5p6450.h>
+
+static struct clksrc_clk clk_mout_dpll = {
+	.clk	= {
+		.name		= "mout_dpll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_dpll,
+	.reg_src	= { .reg = S5P64X0_CLK_SRC0, .shift = 5, .size = 1 },
+};
+
+static u32 epll_div[][5] = {
+	{ 133000000,	27307,	55, 2, 2 },
+	{ 100000000,	43691,	41, 2, 2 },
+	{ 480000000,	0,	80, 2, 0 },
+};
+
+static int s5p6450_epll_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned int epll_con, epll_con_k;
+	unsigned int i;
+
+	if (clk->rate == rate)	/* Return if nothing changed */
+		return 0;
+
+	epll_con = __raw_readl(S5P64X0_EPLL_CON);
+	epll_con_k = __raw_readl(S5P64X0_EPLL_CON_K);
+
+	epll_con_k &= ~(PLL90XX_KDIV_MASK);
+	epll_con &= ~(PLL90XX_MDIV_MASK | PLL90XX_PDIV_MASK | PLL90XX_SDIV_MASK);
+
+	for (i = 0; i < ARRAY_SIZE(epll_div); i++) {
+		 if (epll_div[i][0] == rate) {
+			epll_con_k |= (epll_div[i][1] << PLL90XX_KDIV_SHIFT);
+			epll_con |= (epll_div[i][2] << PLL90XX_MDIV_SHIFT) |
+				    (epll_div[i][3] << PLL90XX_PDIV_SHIFT) |
+				    (epll_div[i][4] << PLL90XX_SDIV_SHIFT);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(epll_div)) {
+		printk(KERN_ERR "%s: Invalid Clock EPLL Frequency\n", __func__);
+		return -EINVAL;
+	}
+
+	__raw_writel(epll_con, S5P64X0_EPLL_CON);
+	__raw_writel(epll_con_k, S5P64X0_EPLL_CON_K);
+
+	clk->rate = rate;
+
+	return 0;
+}
+
+static struct clk_ops s5p6450_epll_ops = {
+	.get_rate = s5p64x0_epll_get_rate,
+	.set_rate = s5p6450_epll_set_rate,
+};
+
+static struct clksrc_clk clk_dout_epll = {
+	.clk	= {
+		.name		= "dout_epll",
+		.id		= -1,
+		.parent		= &clk_mout_epll.clk,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV1, .shift = 24, .size = 4 },
+};
+
+static struct clksrc_clk clk_mout_hclk_sel = {
+	.clk	= {
+		.name		= "mout_hclk_sel",
+		.id		= -1,
+	},
+	.sources	= &clkset_hclk_low,
+	.reg_src	= { .reg = S5P64X0_OTHERS, .shift = 15, .size = 1 },
+};
+
+static struct clk *clkset_hclk_list[] = {
+	&clk_mout_hclk_sel.clk,
+	&clk_armclk.clk,
+};
+
+static struct clksrc_sources clkset_hclk = {
+	.sources	= clkset_hclk_list,
+	.nr_sources	= ARRAY_SIZE(clkset_hclk_list),
+};
+
+static struct clksrc_clk clk_hclk = {
+	.clk	= {
+		.name		= "clk_hclk",
+		.id		= -1,
+	},
+	.sources	= &clkset_hclk,
+	.reg_src	= { .reg = S5P64X0_OTHERS, .shift = 14, .size = 1 },
+	.reg_div	= { .reg = S5P64X0_CLK_DIV0, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk clk_pclk = {
+	.clk	= {
+		.name		= "clk_pclk",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+	},
+	.reg_div = { .reg = S5P64X0_CLK_DIV0, .shift = 12, .size = 4 },
+};
+static struct clksrc_clk clk_dout_pwm_ratio0 = {
+	.clk	= {
+		.name		= "clk_dout_pwm_ratio0",
+		.id		= -1,
+		.parent		= &clk_mout_hclk_sel.clk,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV3, .shift = 16, .size = 4 },
+};
+
+static struct clksrc_clk clk_pclk_to_wdt_pwm = {
+	.clk	= {
+		.name		= "clk_pclk_to_wdt_pwm",
+		.id		= -1,
+		.parent		= &clk_dout_pwm_ratio0.clk,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV3, .shift = 20, .size = 4 },
+};
+
+static struct clksrc_clk clk_hclk_low = {
+	.clk	= {
+		.name		= "clk_hclk_low",
+		.id		= -1,
+	},
+	.sources	= &clkset_hclk_low,
+	.reg_src	= { .reg = S5P64X0_OTHERS, .shift = 6, .size = 1 },
+	.reg_div	= { .reg = S5P64X0_CLK_DIV3, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk clk_pclk_low = {
+	.clk	= {
+		.name		= "clk_pclk_low",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV3, .shift = 12, .size = 4 },
+};
+
+/*
+ * The following clocks will be disabled during clock initialization. It is
+ * recommended to keep the following clocks disabled until the driver requests
+ * for enabling the clock.
+ */
+static struct clk init_clocks_disable[] = {
+	{
+		.name		= "usbhost",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "hsmmc",
+		.id		= 0,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 17),
+	}, {
+		.name		= "hsmmc",
+		.id		= 1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 18),
+	}, {
+		.name		= "hsmmc",
+		.id		= 2,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 19),
+	}, {
+		.name		= "usbotg",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 20),
+	}, {
+		.name		= "lcd",
+		.id		= -1,
+		.parent		= &clk_h,
+		.enable		= s5p64x0_hclk1_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "watchdog",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 5),
+	}, {
+		.name		= "adc",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
+		.name		= "i2c",
+		.id		= 0,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 17),
+	}, {
+		.name		= "spi",
+		.id		= 0,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 21),
+	}, {
+		.name		= "spi",
+		.id		= 1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 22),
+	}, {
+		.name		= "iis",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 26),
+	}, {
+		.name		= "i2c",
+		.id		= 1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 27),
+	}, {
+		.name		= "dmc0",
+		.id		= -1,
+		.parent		= &clk_pclk.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 30),
+	}
+};
+
+/*
+ * The following clocks will be enabled during clock initialization.
+ */
+static struct clk init_clocks[] = {
+	{
+		.name		= "intc",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "mem",
+		.id		= -1,
+		.parent		= &clk_hclk.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 21),
+	}, {
+		.name		= "dma",
+		.id		= -1,
+		.parent		= &clk_hclk_low.clk,
+		.enable		= s5p64x0_hclk0_ctrl,
+		.ctrlbit	= (1 << 12),
+	}, {
+		.name		= "uart",
+		.id		= 0,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 1),
+	}, {
+		.name		= "uart",
+		.id		= 1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 2),
+	}, {
+		.name		= "uart",
+		.id		= 2,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 3),
+	}, {
+		.name		= "uart",
+		.id		= 3,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 4),
+	}, {
+		.name		= "timers",
+		.id		= -1,
+		.parent		= &clk_pclk_to_wdt_pwm.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 7),
+	}, {
+		.name		= "gpio",
+		.id		= -1,
+		.parent		= &clk_pclk_low.clk,
+		.enable		= s5p64x0_pclk_ctrl,
+		.ctrlbit	= (1 << 18),
+	},
+};
+
+static struct clk *clkset_uart_list[] = {
+	&clk_dout_epll.clk,
+	&clk_dout_mpll.clk,
+};
+
+static struct clksrc_sources clkset_uart = {
+	.sources	= clkset_uart_list,
+	.nr_sources	= ARRAY_SIZE(clkset_uart_list),
+};
+
+static struct clk *clkset_mali_list[] = {
+	&clk_mout_epll.clk,
+	&clk_mout_apll.clk,
+	&clk_mout_mpll.clk,
+};
+
+static struct clksrc_sources clkset_mali = {
+	.sources	= clkset_mali_list,
+	.nr_sources	= ARRAY_SIZE(clkset_mali_list),
+};
+
+static struct clk *clkset_group2_list[] = {
+	&clk_dout_epll.clk,
+	&clk_dout_mpll.clk,
+	&clk_ext_xtal_mux,
+};
+
+static struct clksrc_sources clkset_group2 = {
+	.sources	= clkset_group2_list,
+	.nr_sources	= ARRAY_SIZE(clkset_group2_list),
+};
+
+static struct clk *clkset_dispcon_list[] = {
+	&clk_dout_epll.clk,
+	&clk_dout_mpll.clk,
+	&clk_ext_xtal_mux,
+	&clk_mout_dpll.clk,
+};
+
+static struct clksrc_sources clkset_dispcon = {
+	.sources	= clkset_dispcon_list,
+	.nr_sources	= ARRAY_SIZE(clkset_dispcon_list),
+};
+
+static struct clk *clkset_hsmmc44_list[] = {
+	&clk_dout_epll.clk,
+	&clk_dout_mpll.clk,
+	&clk_ext_xtal_mux,
+	&s5p_clk_27m,
+	&clk_48m,
+};
+
+static struct clksrc_sources clkset_hsmmc44 = {
+	.sources	= clkset_hsmmc44_list,
+	.nr_sources	= ARRAY_SIZE(clkset_hsmmc44_list),
+};
+
+static struct clk *clkset_sclk_audio0_list[] = {
+	[0] = &clk_dout_epll.clk,
+	[1] = &clk_dout_mpll.clk,
+	[2] = &clk_ext_xtal_mux,
+	[3] = NULL,
+	[4] = NULL,
+};
+
+static struct clksrc_sources clkset_sclk_audio0 = {
+	.sources	= clkset_sclk_audio0_list,
+	.nr_sources	= ARRAY_SIZE(clkset_sclk_audio0_list),
+};
+
+static struct clksrc_clk clk_sclk_audio0 = {
+	.clk		= {
+		.name		= "audio-bus",
+		.id		= -1,
+		.enable		= s5p64x0_sclk_ctrl,
+		.ctrlbit	= (1 << 8),
+		.parent		= &clk_dout_epll.clk,
+	},
+	.sources	= &clkset_sclk_audio0,
+	.reg_src	= { .reg = S5P64X0_CLK_SRC1, .shift = 10, .size = 3 },
+	.reg_div	= { .reg = S5P64X0_CLK_DIV2, .shift = 8, .size = 4 },
+};
+
+static struct clksrc_clk clksrcs[] = {
+	{
+		.clk	= {
+			.name		= "sclk_mmc",
+			.id		= 0,
+			.ctrlbit	= (1 << 24),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 18, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_mmc",
+			.id		= 1,
+			.ctrlbit	= (1 << 25),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 20, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 4, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_mmc",
+			.id		= 2,
+			.ctrlbit	= (1 << 26),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 22, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 8, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "uclk1",
+			.id		= -1,
+			.ctrlbit	= (1 << 5),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_uart,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 13, .size = 1 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 16, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_spi",
+			.id		= 0,
+			.ctrlbit	= (1 << 20),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 14, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_spi",
+			.id		= 1,
+			.ctrlbit	= (1 << 21),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 16, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 4, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_fimc",
+			.id		= -1,
+			.ctrlbit	= (1 << 10),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 26, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 12, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "aclk_mali",
+			.id		= -1,
+			.ctrlbit	= (1 << 2),
+			.enable		= s5p64x0_sclk1_ctrl,
+		},
+		.sources = &clkset_mali,
+		.reg_src = { .reg = S5P64X0_CLK_SRC1, .shift = 8, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV3, .shift = 4, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_2d",
+			.id		= -1,
+			.ctrlbit	= (1 << 12),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_mali,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 30, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV2, .shift = 20, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_usi",
+			.id		= -1,
+			.ctrlbit	= (1 << 7),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 10, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 16, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_camif",
+			.id		= -1,
+			.ctrlbit	= (1 << 6),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_group2,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 28, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 20, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_dispcon",
+			.id		= -1,
+			.ctrlbit	= (1 << 1),
+			.enable		= s5p64x0_sclk1_ctrl,
+		},
+		.sources = &clkset_dispcon,
+		.reg_src = { .reg = S5P64X0_CLK_SRC1, .shift = 4, .size = 2 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV3, .shift = 0, .size = 4 },
+	}, {
+		.clk	= {
+			.name		= "sclk_hsmmc44",
+			.id		= -1,
+			.ctrlbit	= (1 << 30),
+			.enable		= s5p64x0_sclk_ctrl,
+		},
+		.sources = &clkset_hsmmc44,
+		.reg_src = { .reg = S5P64X0_CLK_SRC0, .shift = 6, .size = 3 },
+		.reg_div = { .reg = S5P64X0_CLK_DIV1, .shift = 28, .size = 4 },
+	},
+};
+
+/* Clock initialization code */
+static struct clksrc_clk *sysclks[] = {
+	&clk_mout_apll,
+	&clk_mout_epll,
+	&clk_dout_epll,
+	&clk_mout_mpll,
+	&clk_dout_mpll,
+	&clk_armclk,
+	&clk_mout_hclk_sel,
+	&clk_dout_pwm_ratio0,
+	&clk_pclk_to_wdt_pwm,
+	&clk_hclk,
+	&clk_pclk,
+	&clk_hclk_low,
+	&clk_pclk_low,
+	&clk_sclk_audio0,
+};
+
+void __init_or_cpufreq s5p6450_setup_clocks(void)
+{
+	struct clk *xtal_clk;
+
+	unsigned long xtal;
+	unsigned long fclk;
+	unsigned long hclk;
+	unsigned long hclk_low;
+	unsigned long pclk;
+	unsigned long pclk_low;
+
+	unsigned long apll;
+	unsigned long mpll;
+	unsigned long epll;
+	unsigned long dpll;
+	unsigned int ptr;
+
+	/* Set S5P6450 functions for clk_fout_epll */
+
+	clk_fout_epll.enable = s5p64x0_epll_enable;
+	clk_fout_epll.ops = &s5p6450_epll_ops;
+
+	clk_48m.enable = s5p64x0_clk48m_ctrl;
+
+	xtal_clk = clk_get(NULL, "ext_xtal");
+	BUG_ON(IS_ERR(xtal_clk));
+
+	xtal = clk_get_rate(xtal_clk);
+	clk_put(xtal_clk);
+
+	apll = s5p_get_pll45xx(xtal, __raw_readl(S5P64X0_APLL_CON), pll_4502);
+	mpll = s5p_get_pll45xx(xtal, __raw_readl(S5P64X0_MPLL_CON), pll_4502);
+	epll = s5p_get_pll90xx(xtal, __raw_readl(S5P64X0_EPLL_CON),
+				__raw_readl(S5P64X0_EPLL_CON_K));
+	dpll = s5p_get_pll46xx(xtal, __raw_readl(S5P6450_DPLL_CON),
+				__raw_readl(S5P6450_DPLL_CON_K), pll_4650c);
+
+	clk_fout_apll.rate = apll;
+	clk_fout_mpll.rate = mpll;
+	clk_fout_epll.rate = epll;
+	clk_fout_dpll.rate = dpll;
+
+	printk(KERN_INFO "S5P6450: PLL settings, A=%ld.%ldMHz, M=%ld.%ldMHz," \
+			" E=%ld.%ldMHz, D=%ld.%ldMHz\n",
+			print_mhz(apll), print_mhz(mpll), print_mhz(epll),
+			print_mhz(dpll));
+
+	fclk = clk_get_rate(&clk_armclk.clk);
+	hclk = clk_get_rate(&clk_hclk.clk);
+	pclk = clk_get_rate(&clk_pclk.clk);
+	hclk_low = clk_get_rate(&clk_hclk_low.clk);
+	pclk_low = clk_get_rate(&clk_pclk_low.clk);
+
+	printk(KERN_INFO "S5P6450: HCLK=%ld.%ldMHz, HCLK_LOW=%ld.%ldMHz," \
+			" PCLK=%ld.%ldMHz, PCLK_LOW=%ld.%ldMHz\n",
+			print_mhz(hclk), print_mhz(hclk_low),
+			print_mhz(pclk), print_mhz(pclk_low));
+
+	clk_f.rate = fclk;
+	clk_h.rate = hclk;
+	clk_p.rate = pclk;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
+		s3c_set_clksrc(&clksrcs[ptr], true);
+}
+
+void __init s5p6450_register_clocks(void)
+{
+	struct clk *clkp;
+	int ret;
+	int ptr;
+
+	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
+		s3c_register_clksrc(sysclks[ptr], 1);
+
+	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
+	s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clocks));
+
+	clkp = init_clocks_disable;
+	for (ptr = 0; ptr < ARRAY_SIZE(init_clocks_disable); ptr++, clkp++) {
+
+		ret = s3c24xx_register_clock(clkp);
+		if (ret < 0) {
+			printk(KERN_ERR "Failed to register clock %s (%d)\n",
+			       clkp->name, ret);
+		}
+		(clkp->enable)(clkp, 0);
+	}
+
+	s3c_pwmclk_init();
+}
diff --git a/arch/arm/mach-s5p64x0/clock.c b/arch/arm/mach-s5p64x0/clock.c
new file mode 100644
index 0000000..523ba80
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/clock.c
@@ -0,0 +1,253 @@
+/* linux/arch/arm/mach-s5p64x0/clock.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P64X0 - Clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+#include <linux/io.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
+#include <plat/cpu-freq.h>
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+#include <plat/s5p-clock.h>
+#include <plat/clock-clksrc.h>
+#include <plat/s5p6440.h>
+#include <plat/s5p6450.h>
+
+struct clksrc_clk clk_mout_apll = {
+	.clk	= {
+		.name		= "mout_apll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_apll,
+	.reg_src	= { .reg = S5P64X0_CLK_SRC0, .shift = 0, .size = 1 },
+};
+
+struct clksrc_clk clk_mout_mpll = {
+	.clk	= {
+		.name		= "mout_mpll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_mpll,
+	.reg_src	= { .reg = S5P64X0_CLK_SRC0, .shift = 1, .size = 1 },
+};
+
+struct clksrc_clk clk_mout_epll = {
+	.clk	= {
+		.name		= "mout_epll",
+		.id		= -1,
+	},
+	.sources	= &clk_src_epll,
+	.reg_src	= { .reg = S5P64X0_CLK_SRC0, .shift = 2, .size = 1 },
+};
+
+enum perf_level {
+	L0 = 532*1000,
+	L1 = 266*1000,
+	L2 = 133*1000,
+};
+
+static const u32 clock_table[][3] = {
+	/*{ARM_CLK, DIVarm, DIVhclk}*/
+	{L0 * 1000, (0 << ARM_DIV_RATIO_SHIFT), (3 << S5P64X0_CLKDIV0_HCLK_SHIFT)},
+	{L1 * 1000, (1 << ARM_DIV_RATIO_SHIFT), (1 << S5P64X0_CLKDIV0_HCLK_SHIFT)},
+	{L2 * 1000, (3 << ARM_DIV_RATIO_SHIFT), (0 << S5P64X0_CLKDIV0_HCLK_SHIFT)},
+};
+
+int s5p64x0_epll_enable(struct clk *clk, int enable)
+{
+	unsigned int ctrlbit = clk->ctrlbit;
+	unsigned int epll_con = __raw_readl(S5P64X0_EPLL_CON) & ~ctrlbit;
+
+	if (enable)
+		__raw_writel(epll_con | ctrlbit, S5P64X0_EPLL_CON);
+	else
+		__raw_writel(epll_con, S5P64X0_EPLL_CON);
+
+	return 0;
+}
+
+unsigned long s5p64x0_epll_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+unsigned long s5p64x0_armclk_get_rate(struct clk *clk)
+{
+	unsigned long rate = clk_get_rate(clk->parent);
+	u32 clkdiv;
+
+	/* divisor mask starts at bit0, so no need to shift */
+	clkdiv = __raw_readl(ARM_CLK_DIV) & ARM_DIV_MASK;
+
+	return rate / (clkdiv + 1);
+}
+
+unsigned long s5p64x0_armclk_round_rate(struct clk *clk, unsigned long rate)
+{
+	u32 iter;
+
+	for (iter = 1 ; iter < ARRAY_SIZE(clock_table) ; iter++) {
+		if (rate > clock_table[iter][0])
+			return clock_table[iter-1][0];
+	}
+
+	return clock_table[ARRAY_SIZE(clock_table) - 1][0];
+}
+
+int s5p64x0_armclk_set_rate(struct clk *clk, unsigned long rate)
+{
+	u32 round_tmp;
+	u32 iter;
+	u32 clk_div0_tmp;
+	u32 cur_rate = clk->ops->get_rate(clk);
+	unsigned long flags;
+
+	round_tmp = clk->ops->round_rate(clk, rate);
+	if (round_tmp == cur_rate)
+		return 0;
+
+
+	for (iter = 0 ; iter < ARRAY_SIZE(clock_table) ; iter++) {
+		if (round_tmp == clock_table[iter][0])
+			break;
+	}
+
+	if (iter >= ARRAY_SIZE(clock_table))
+		iter = ARRAY_SIZE(clock_table) - 1;
+
+	local_irq_save(flags);
+	if (cur_rate > round_tmp) {
+		/* Frequency Down */
+		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) & ~(ARM_DIV_MASK);
+		clk_div0_tmp |= clock_table[iter][1];
+		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
+
+		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) &
+				~(S5P64X0_CLKDIV0_HCLK_MASK);
+		clk_div0_tmp |= clock_table[iter][2];
+		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
+
+
+	} else {
+		/* Frequency Up */
+		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) &
+				~(S5P64X0_CLKDIV0_HCLK_MASK);
+		clk_div0_tmp |= clock_table[iter][2];
+		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
+
+		clk_div0_tmp = __raw_readl(ARM_CLK_DIV) & ~(ARM_DIV_MASK);
+		clk_div0_tmp |= clock_table[iter][1];
+		__raw_writel(clk_div0_tmp, ARM_CLK_DIV);
+	}
+	local_irq_restore(flags);
+
+	clk->rate = clock_table[iter][0];
+
+	return 0;
+}
+
+struct clk_ops s5p64x0_clkarm_ops = {
+	.get_rate	= s5p64x0_armclk_get_rate,
+	.set_rate	= s5p64x0_armclk_set_rate,
+	.round_rate	= s5p64x0_armclk_round_rate,
+};
+
+struct clksrc_clk clk_armclk = {
+	.clk	= {
+		.name		= "armclk",
+		.id		= 1,
+		.parent		= &clk_mout_apll.clk,
+		.ops		= &s5p64x0_clkarm_ops,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV0, .shift = 0, .size = 4 },
+};
+
+struct clksrc_clk clk_dout_mpll = {
+	.clk	= {
+		.name		= "dout_mpll",
+		.id		= -1,
+		.parent		= &clk_mout_mpll.clk,
+	},
+	.reg_div	= { .reg = S5P64X0_CLK_DIV0, .shift = 4, .size = 1 },
+};
+
+struct clk *clkset_hclk_low_list[] = {
+	&clk_mout_apll.clk,
+	&clk_mout_mpll.clk,
+};
+
+struct clksrc_sources clkset_hclk_low = {
+	.sources	= clkset_hclk_low_list,
+	.nr_sources	= ARRAY_SIZE(clkset_hclk_low_list),
+};
+
+int s5p64x0_pclk_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P64X0_CLK_GATE_PCLK, clk, enable);
+}
+
+int s5p64x0_hclk0_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P64X0_CLK_GATE_HCLK0, clk, enable);
+}
+
+int s5p64x0_hclk1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P64X0_CLK_GATE_HCLK1, clk, enable);
+}
+
+int s5p64x0_sclk_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P64X0_CLK_GATE_SCLK0, clk, enable);
+}
+
+int s5p64x0_sclk1_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P64X0_CLK_GATE_SCLK1, clk, enable);
+}
+
+int s5p64x0_mem_ctrl(struct clk *clk, int enable)
+{
+	return s5p_gatectrl(S5P64X0_CLK_GATE_MEM0, clk, enable);
+}
+
+int s5p64x0_clk48m_ctrl(struct clk *clk, int enable)
+{
+	unsigned long flags;
+	u32 val;
+
+	/* can't rely on clock lock, this register has other usages */
+	local_irq_save(flags);
+
+	val = __raw_readl(S5P64X0_OTHERS);
+	if (enable)
+		val |= S5P64X0_OTHERS_USB_SIG_MASK;
+	else
+		val &= ~S5P64X0_OTHERS_USB_SIG_MASK;
+
+	__raw_writel(val, S5P64X0_OTHERS);
+
+	local_irq_restore(flags);
+
+	return 0;
+}
diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-clock.h b/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
new file mode 100644
index 0000000..58e1bc8
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
@@ -0,0 +1,63 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P64X0 - Clock register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_REGS_CLOCK_H
+#define __ASM_ARCH_REGS_CLOCK_H __FILE__
+
+#include <mach/map.h>
+
+#define S5P_CLKREG(x)			(S3C_VA_SYS + (x))
+
+#define S5P64X0_APLL_CON		S5P_CLKREG(0x0C)
+#define S5P64X0_MPLL_CON		S5P_CLKREG(0x10)
+#define S5P64X0_EPLL_CON		S5P_CLKREG(0x14)
+#define S5P64X0_EPLL_CON_K		S5P_CLKREG(0x18)
+
+#define S5P64X0_CLK_SRC0		S5P_CLKREG(0x1C)
+
+#define S5P64X0_CLK_DIV0		S5P_CLKREG(0x20)
+#define S5P64X0_CLK_DIV1		S5P_CLKREG(0x24)
+#define S5P64X0_CLK_DIV2		S5P_CLKREG(0x28)
+
+#define S5P64X0_CLK_GATE_HCLK0		S5P_CLKREG(0x30)
+#define S5P64X0_CLK_GATE_PCLK		S5P_CLKREG(0x34)
+#define S5P64X0_CLK_GATE_SCLK0		S5P_CLKREG(0x38)
+#define S5P64X0_CLK_GATE_MEM0		S5P_CLKREG(0x3C)
+
+#define S5P64X0_CLK_DIV3		S5P_CLKREG(0x40)
+
+#define S5P64X0_CLK_GATE_HCLK1		S5P_CLKREG(0x44)
+#define S5P64X0_CLK_GATE_SCLK1		S5P_CLKREG(0x48)
+
+#define S5P6450_DPLL_CON		S5P_CLKREG(0x50)
+#define S5P6450_DPLL_CON_K		S5P_CLKREG(0x54)
+
+#define S5P64X0_CLK_SRC1		S5P_CLKREG(0x10C)
+
+#define S5P64X0_SYS_ID			S5P_CLKREG(0x118)
+#define S5P64X0_SYS_OTHERS		S5P_CLKREG(0x11C)
+
+#define S5P64X0_PWR_CFG			S5P_CLKREG(0x804)
+#define S5P64X0_OTHERS			S5P_CLKREG(0x900)
+
+#define S5P64X0_CLKDIV0_HCLK_SHIFT	(8)
+#define S5P64X0_CLKDIV0_HCLK_MASK	(0xF << S5P64X0_CLKDIV0_HCLK_SHIFT)
+
+#define S5P64X0_OTHERS_USB_SIG_MASK	(1 << 16)
+
+/* Compatibility defines */
+
+#define ARM_CLK_DIV			S5P64X0_CLK_DIV0
+#define ARM_DIV_RATIO_SHIFT		0
+#define ARM_DIV_MASK			(0xF << ARM_DIV_RATIO_SHIFT)
+
+#endif /* __ASM_ARCH_REGS_CLOCK_H */
diff --git a/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h b/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
new file mode 100644
index 0000000..ff85b4b
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
@@ -0,0 +1,46 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Header file for s5p64x0 clock support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_CLOCK_H
+#define __ASM_ARCH_CLOCK_H __FILE__
+
+#include <linux/clk.h>
+
+extern struct clksrc_clk clk_mout_apll;
+extern struct clksrc_clk clk_mout_mpll;
+extern struct clksrc_clk clk_mout_epll;
+
+extern int s5p64x0_epll_enable(struct clk *clk, int enable);
+extern unsigned long s5p64x0_epll_get_rate(struct clk *clk);
+
+extern unsigned long s5p64x0_armclk_get_rate(struct clk *clk);
+extern unsigned long s5p64x0_armclk_round_rate(struct clk *clk, unsigned long rate);
+extern int s5p64x0_armclk_set_rate(struct clk *clk, unsigned long rate);
+
+extern struct clk_ops s5p64x0_clkarm_ops;
+
+extern struct clksrc_clk clk_armclk;
+extern struct clksrc_clk clk_dout_mpll;
+
+extern struct clk *clkset_hclk_low_list[];
+extern struct clksrc_sources clkset_hclk_low;
+
+extern int s5p64x0_pclk_ctrl(struct clk *clk, int enable);
+extern int s5p64x0_hclk0_ctrl(struct clk *clk, int enable);
+extern int s5p64x0_hclk1_ctrl(struct clk *clk, int enable);
+extern int s5p64x0_sclk_ctrl(struct clk *clk, int enable);
+extern int s5p64x0_sclk1_ctrl(struct clk *clk, int enable);
+extern int s5p64x0_mem_ctrl(struct clk *clk, int enable);
+
+extern int s5p64x0_clk48m_ctrl(struct clk *clk, int enable);
+
+#endif /* __ASM_ARCH_CLOCK_H */
diff --git a/arch/arm/plat-s5p/clock.c b/arch/arm/plat-s5p/clock.c
index b5e2552..8aaf4e6 100644
--- a/arch/arm/plat-s5p/clock.c
+++ b/arch/arm/plat-s5p/clock.c
@@ -74,6 +74,13 @@ struct clk clk_fout_epll = {
 	.ctrlbit	= (1 << 31),
 };
 
+/* DPLL clock output */
+struct clk clk_fout_dpll = {
+	.name		= "fout_dpll",
+	.id		= -1,
+	.ctrlbit	= (1 << 31),
+};
+
 /* VPLL clock output */
 struct clk clk_fout_vpll = {
 	.name		= "fout_vpll",
@@ -122,6 +129,17 @@ struct clksrc_sources clk_src_epll = {
 	.nr_sources	= ARRAY_SIZE(clk_src_epll_list),
 };
 
+/* Possible clock sources for DPLL Mux */
+static struct clk *clk_src_dpll_list[] = {
+	[0] = &clk_fin_dpll,
+	[1] = &clk_fout_dpll,
+};
+
+struct clksrc_sources clk_src_dpll = {
+	.sources	= clk_src_dpll_list,
+	.nr_sources	= ARRAY_SIZE(clk_src_dpll_list),
+};
+
 struct clk clk_vpll = {
 	.name		= "vpll",
 	.id		= -1,
@@ -145,6 +163,7 @@ static struct clk *s5p_clks[] __initdata = {
 	&clk_fout_apll,
 	&clk_fout_mpll,
 	&clk_fout_epll,
+	&clk_fout_dpll,
 	&clk_fout_vpll,
 	&clk_arm,
 	&clk_vpll,
diff --git a/arch/arm/plat-s5p/include/plat/pll.h b/arch/arm/plat-s5p/include/plat/pll.h
index 4e8fe08..bf28fad 100644
--- a/arch/arm/plat-s5p/include/plat/pll.h
+++ b/arch/arm/plat-s5p/include/plat/pll.h
@@ -47,6 +47,7 @@ static inline unsigned long s5p_get_pll45xx(unsigned long baseclk, u32 pll_con,
 }
 
 #define PLL46XX_KDIV_MASK	(0xFFFF)
+#define PLL4650C_KDIV_MASK	(0xFFF)
 #define PLL46XX_MDIV_MASK	(0x1FF)
 #define PLL46XX_PDIV_MASK	(0x3F)
 #define PLL46XX_SDIV_MASK	(0x7)
@@ -57,6 +58,7 @@ static inline unsigned long s5p_get_pll45xx(unsigned long baseclk, u32 pll_con,
 enum pll46xx_type_t {
 	pll_4600,
 	pll_4650,
+	pll_4650c,
 };
 
 static inline unsigned long s5p_get_pll46xx(unsigned long baseclk,
@@ -72,6 +74,11 @@ static inline unsigned long s5p_get_pll46xx(unsigned long baseclk,
 	sdiv = (pll_con0 >> PLL46XX_SDIV_SHIFT) & PLL46XX_SDIV_MASK;
 	kdiv = pll_con1 & PLL46XX_KDIV_MASK;
 
+	if (pll_type == pll_4650c)
+		kdiv = pll_con1 & PLL4650C_KDIV_MASK;
+	else
+		kdiv = pll_con1 & PLL46XX_KDIV_MASK;
+
 	tmp = baseclk;
 
 	if (pll_type == pll_4600) {
diff --git a/arch/arm/plat-s5p/include/plat/s5p-clock.h b/arch/arm/plat-s5p/include/plat/s5p-clock.h
index 09418b1..17036c8 100644
--- a/arch/arm/plat-s5p/include/plat/s5p-clock.h
+++ b/arch/arm/plat-s5p/include/plat/s5p-clock.h
@@ -1,7 +1,7 @@
 /* linux/arch/arm/plat-s5p/include/plat/s5p-clock.h
  *
- * Copyright 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * Header file for s5p clock support
  *
@@ -20,6 +20,7 @@
 #define clk_fin_apll clk_ext_xtal_mux
 #define clk_fin_mpll clk_ext_xtal_mux
 #define clk_fin_epll clk_ext_xtal_mux
+#define clk_fin_dpll clk_ext_xtal_mux
 #define clk_fin_vpll clk_ext_xtal_mux
 #define clk_fin_hpll clk_ext_xtal_mux
 
@@ -30,6 +31,7 @@ extern struct clk s5p_clk_27m;
 extern struct clk clk_fout_apll;
 extern struct clk clk_fout_mpll;
 extern struct clk clk_fout_epll;
+extern struct clk clk_fout_dpll;
 extern struct clk clk_fout_vpll;
 extern struct clk clk_arm;
 extern struct clk clk_vpll;
@@ -37,8 +39,8 @@ extern struct clk clk_vpll;
 extern struct clksrc_sources clk_src_apll;
 extern struct clksrc_sources clk_src_mpll;
 extern struct clksrc_sources clk_src_epll;
+extern struct clksrc_sources clk_src_dpll;
 
-extern int s5p6440_clk48m_ctrl(struct clk *clk, int enable);
 extern int s5p_gatectrl(void __iomem *reg, struct clk *clk, int enable);
 
 #endif /* __ASM_PLAT_S5P_CLOCK_H */
-- 
1.6.2.5
