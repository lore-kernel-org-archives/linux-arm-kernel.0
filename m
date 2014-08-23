From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:03 +0900
Subject: [PATCH 3/3] ARM: shmobile: r7s72100: Remove legacy board support
In-Reply-To: <cover.1408670789.git.horms+renesas@verge.net.au>
References: <cover.1408670789.git.horms+renesas@verge.net.au>
Message-ID: <ad8c3af8b75ff26c5c887f2101da653bdcd53a38.1408670789.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

There's no legacy board anymore, genmai now boots with multiplatform
support only. Remove the leftovers.

Makefile.boot portion pointed out by Paul Bolle.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Wolfram Sang <wsa@sang-engineering.com>
Cc: Paul Bolle <pebolle@tiscali.nl>
[horms+renesas at verge.net.au: squashed in patch containing
 Makefile.boot change]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig          |   8 --
 arch/arm/mach-shmobile/Makefile         |   1 -
 arch/arm/mach-shmobile/Makefile.boot    |   1 -
 arch/arm/mach-shmobile/clock-r7s72100.c | 231 --------------------------------
 arch/arm/mach-shmobile/r7s72100.h       |   6 -
 arch/arm/mach-shmobile/setup-r7s72100.c |   2 -
 6 files changed, 249 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/clock-r7s72100.c
 delete mode 100644 arch/arm/mach-shmobile/r7s72100.h

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 169bda4..5814754 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -145,14 +145,6 @@ config ARCH_R8A7791
 	select SYS_SUPPORTS_SH_CMT
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 
-config ARCH_R7S72100
-	bool "RZ/A1H (R7S72100)"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_GIC
-	select CPU_V7
-	select SH_CLK_CPG
-	select SYS_SUPPORTS_SH_MTU2
-
 comment "Renesas ARM SoCs Board Type"
 
 config MACH_APE6EVM
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index be5fed2..c7e2ad8 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_ARCH_R8A7778)	+= clock-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= clock-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= clock-r8a7790.o
 obj-$(CONFIG_ARCH_R8A7791)	+= clock-r8a7791.o
-obj-$(CONFIG_ARCH_R7S72100)	+= clock-r7s72100.o
 endif
 
 # CPU reset vector handling objects
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index ebf97d4..a23e155 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -6,7 +6,6 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
 loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
-loadaddr-$(CONFIG_MACH_GENMAI) += 0x08008000
 loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
 loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
deleted file mode 100644
index 3eb2ec4..0000000
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- * r7a72100 clock framework support
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2012  Phil Edworthy
- * Copyright (C) 2011  Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/sh_clk.h>
-#include <linux/clkdev.h>
-
-#include "common.h"
-#include "r7s72100.h"
-
-/* Frequency Control Registers */
-#define FRQCR		0xfcfe0010
-#define FRQCR2		0xfcfe0014
-/* Standby Control Registers */
-#define STBCR3		0xfcfe0420
-#define STBCR4		0xfcfe0424
-#define STBCR7		0xfcfe0430
-#define STBCR9		0xfcfe0438
-#define STBCR10		0xfcfe043c
-
-#define PLL_RATE 30
-
-static struct clk_mapping cpg_mapping = {
-	.phys	= 0xfcfe0000,
-	.len	= 0x1000,
-};
-
-/* Fixed 32 KHz root clock for RTC */
-static struct clk r_clk = {
-	.rate           = 32768,
-};
-
-/*
- * Default rate for the root input clock, reset this with clk_set_rate()
- * from the platform code.
- */
-static struct clk extal_clk = {
-	.rate		= 13330000,
-	.mapping	= &cpg_mapping,
-};
-
-static unsigned long pll_recalc(struct clk *clk)
-{
-	return clk->parent->rate * PLL_RATE;
-}
-
-static struct sh_clk_ops pll_clk_ops = {
-	.recalc		= pll_recalc,
-};
-
-static struct clk pll_clk = {
-	.ops		= &pll_clk_ops,
-	.parent		= &extal_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-};
-
-static unsigned long bus_recalc(struct clk *clk)
-{
-	return clk->parent->rate / 3;
-}
-
-static struct sh_clk_ops bus_clk_ops = {
-	.recalc		= bus_recalc,
-};
-
-static struct clk bus_clk = {
-	.ops		= &bus_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-};
-
-static unsigned long peripheral0_recalc(struct clk *clk)
-{
-	return clk->parent->rate / 12;
-}
-
-static struct sh_clk_ops peripheral0_clk_ops = {
-	.recalc		= peripheral0_recalc,
-};
-
-static struct clk peripheral0_clk = {
-	.ops		= &peripheral0_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-};
-
-static unsigned long peripheral1_recalc(struct clk *clk)
-{
-	return clk->parent->rate / 6;
-}
-
-static struct sh_clk_ops peripheral1_clk_ops = {
-	.recalc		= peripheral1_recalc,
-};
-
-static struct clk peripheral1_clk = {
-	.ops		= &peripheral1_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-};
-
-struct clk *main_clks[] = {
-	&r_clk,
-	&extal_clk,
-	&pll_clk,
-	&bus_clk,
-	&peripheral0_clk,
-	&peripheral1_clk,
-};
-
-static int div2[] = { 1, 3, 0, 3 }; /* 1, 2/3, reserve, 1/3 */
-static int multipliers[] = { 1, 2, 1, 1 };
-
-static struct clk_div_mult_table div4_div_mult_table = {
-	.divisors = div2,
-	.nr_divisors = ARRAY_SIZE(div2),
-	.multipliers = multipliers,
-	.nr_multipliers = ARRAY_SIZE(multipliers),
-};
-
-static struct clk_div4_table div4_table = {
-	.div_mult_table = &div4_div_mult_table,
-};
-
-enum { DIV4_I,
-	DIV4_NR };
-
-#define DIV4(_reg, _bit, _mask, _flags) \
-	SH_CLK_DIV4(&pll_clk, _reg, _bit, _mask, _flags)
-
-/* The mask field specifies the div2 entries that are valid */
-struct clk div4_clks[DIV4_NR] = {
-	[DIV4_I]  = DIV4(FRQCR, 8, 0xB, CLK_ENABLE_REG_16BIT
-					| CLK_ENABLE_ON_INIT),
-};
-
-enum {
-	MSTP107, MSTP106, MSTP105, MSTP104, MSTP103,
-	MSTP97, MSTP96, MSTP95, MSTP94,
-	MSTP74,
-	MSTP47, MSTP46, MSTP45, MSTP44, MSTP43, MSTP42, MSTP41, MSTP40,
-	MSTP33,	MSTP_NR
-};
-
-static struct clk mstp_clks[MSTP_NR] = {
-	[MSTP107] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 7, 0), /* RSPI0 */
-	[MSTP106] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 6, 0), /* RSPI1 */
-	[MSTP105] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 5, 0), /* RSPI2 */
-	[MSTP104] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 4, 0), /* RSPI3 */
-	[MSTP103] = SH_CLK_MSTP8(&peripheral1_clk, STBCR10, 3, 0), /* RSPI4 */
-	[MSTP97] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 7, 0), /* RIIC0 */
-	[MSTP96] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 6, 0), /* RIIC1 */
-	[MSTP95] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 5, 0), /* RIIC2 */
-	[MSTP94] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 4, 0), /* RIIC3 */
-	[MSTP74] = SH_CLK_MSTP8(&peripheral1_clk, STBCR7, 4, 0), /* Ether */
-	[MSTP47] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 7, 0), /* SCIF0 */
-	[MSTP46] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 6, 0), /* SCIF1 */
-	[MSTP45] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 5, 0), /* SCIF2 */
-	[MSTP44] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 4, 0), /* SCIF3 */
-	[MSTP43] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 3, 0), /* SCIF4 */
-	[MSTP42] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 2, 0), /* SCIF5 */
-	[MSTP41] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 1, 0), /* SCIF6 */
-	[MSTP40] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 0, 0), /* SCIF7 */
-	[MSTP33] = SH_CLK_MSTP8(&peripheral0_clk, STBCR3, 3, 0), /* MTU2 */
-};
-
-static struct clk_lookup lookups[] = {
-	/* main clocks */
-	CLKDEV_CON_ID("rclk", &r_clk),
-	CLKDEV_CON_ID("extal", &extal_clk),
-	CLKDEV_CON_ID("pll_clk", &pll_clk),
-	CLKDEV_CON_ID("peripheral_clk", &peripheral1_clk),
-
-	/* DIV4 clocks */
-	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
-
-	/* MSTP clocks */
-	CLKDEV_DEV_ID("rspi-rz.0", &mstp_clks[MSTP107]),
-	CLKDEV_DEV_ID("rspi-rz.1", &mstp_clks[MSTP106]),
-	CLKDEV_DEV_ID("rspi-rz.2", &mstp_clks[MSTP105]),
-	CLKDEV_DEV_ID("rspi-rz.3", &mstp_clks[MSTP104]),
-	CLKDEV_DEV_ID("rspi-rz.4", &mstp_clks[MSTP103]),
-	CLKDEV_DEV_ID("r7s72100-ether", &mstp_clks[MSTP74]),
-
-	/* ICK */
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[MSTP47]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP46]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP45]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[MSTP44]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.4", &mstp_clks[MSTP43]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.5", &mstp_clks[MSTP42]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.6", &mstp_clks[MSTP41]),
-	CLKDEV_ICK_ID("sci_fck", "sh-sci.7", &mstp_clks[MSTP40]),
-	CLKDEV_ICK_ID("fck", "sh-mtu2", &mstp_clks[MSTP33]),
-};
-
-void __init r7s72100_clock_init(void)
-{
-	int k, ret = 0;
-
-	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
-		ret = clk_register(main_clks[k]);
-
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	if (!ret)
-		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
-
-	if (!ret)
-		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
-
-	if (!ret)
-		shmobile_clk_init();
-	else
-		panic("failed to setup rza1 clocks\n");
-}
diff --git a/arch/arm/mach-shmobile/r7s72100.h b/arch/arm/mach-shmobile/r7s72100.h
deleted file mode 100644
index 321ae4e..0000000
--- a/arch/arm/mach-shmobile/r7s72100.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_R7S72100_H__
-#define __ASM_R7S72100_H__
-
-void r7s72100_clock_init(void);
-
-#endif /* __ASM_R7S72100_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index d898cef..111437d 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -24,7 +24,6 @@
 
 #include "common.h"
 
-#ifdef CONFIG_USE_OF
 static const char *r7s72100_boards_compat_dt[] __initdata = {
 	"renesas,r7s72100",
 	NULL,
@@ -34,4 +33,3 @@ DT_MACHINE_START(R7S72100_DT, "Generic R7S72100 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.dt_compat	= r7s72100_boards_compat_dt,
 MACHINE_END
-#endif /* CONFIG_USE_OF */
-- 
2.0.1
