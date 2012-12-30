From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 29 Dec 2012 16:33:34 -0800
Subject: [PATCH v5 05/12] ARM: Exynos4: Migrate clock support to common clock
 framework
In-Reply-To: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1356827621-27617-6-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove Samsung specific clock support in Exynos4 and migrate to use
common clock framework.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/Kconfig               |    1 +
 arch/arm/mach-exynos/Makefile              |    3 -
 arch/arm/mach-exynos/clock-exynos4.h       |   35 -----
 arch/arm/mach-exynos/clock-exynos4210.c    |  188 ---------------------------
 arch/arm/mach-exynos/clock-exynos4212.c    |  192 ----------------------------
 arch/arm/mach-exynos/common.c              |   27 +---
 arch/arm/mach-exynos/common.h              |   17 +++
 arch/arm/mach-exynos/mach-armlex4210.c     |    1 -
 arch/arm/mach-exynos/mach-exynos4-dt.c     |    1 -
 arch/arm/mach-exynos/mach-nuri.c           |    1 -
 arch/arm/mach-exynos/mach-origen.c         |    1 -
 arch/arm/mach-exynos/mach-smdk4x12.c       |    1 -
 arch/arm/mach-exynos/mach-smdkv310.c       |    1 -
 arch/arm/mach-exynos/mach-universal_c210.c |    1 -
 arch/arm/plat-samsung/Kconfig              |    4 +-
 15 files changed, 27 insertions(+), 447 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/clock-exynos4.h
 delete mode 100644 arch/arm/mach-exynos/clock-exynos4210.c
 delete mode 100644 arch/arm/mach-exynos/clock-exynos4212.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 91d5b6f..ba2fc5c 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -15,6 +15,7 @@ config ARCH_EXYNOS4
 	bool "SAMSUNG EXYNOS4"
 	default y
 	select HAVE_SMP
+	select COMMON_CLK
 	select MIGHT_HAVE_CACHE_L2X0
 	help
 	  Samsung EXYNOS4 SoCs based systems
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 7e53a3a..59a9143 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -13,9 +13,6 @@ obj-				:=
 # Core
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
-obj-$(CONFIG_ARCH_EXYNOS4)	+= clock-exynos4.o
-obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
-obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 obj-$(CONFIG_SOC_EXYNOS5250)	+= clock-exynos5.o
 
 obj-$(CONFIG_PM)		+= pm.o
diff --git a/arch/arm/mach-exynos/clock-exynos4.h b/arch/arm/mach-exynos/clock-exynos4.h
deleted file mode 100644
index bd12d5f..0000000
--- a/arch/arm/mach-exynos/clock-exynos4.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Header file for exynos4 clock support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_CLOCK_H
-#define __ASM_ARCH_CLOCK_H __FILE__
-
-#include <linux/clk.h>
-
-extern struct clksrc_clk exynos4_clk_aclk_133;
-extern struct clksrc_clk exynos4_clk_mout_mpll;
-
-extern struct clksrc_sources exynos4_clkset_mout_corebus;
-extern struct clksrc_sources exynos4_clkset_group;
-
-extern struct clk *exynos4_clkset_aclk_top_list[];
-extern struct clk *exynos4_clkset_group_list[];
-
-extern struct clksrc_sources exynos4_clkset_mout_g2d0;
-extern struct clksrc_sources exynos4_clkset_mout_g2d1;
-
-extern int exynos4_clksrc_mask_fsys_ctrl(struct clk *clk, int enable);
-extern int exynos4_clk_ip_fsys_ctrl(struct clk *clk, int enable);
-extern int exynos4_clk_ip_lcd1_ctrl(struct clk *clk, int enable);
-extern int exynos4_clk_ip_image_ctrl(struct clk *clk, int enable);
-extern int exynos4_clk_ip_dmc_ctrl(struct clk *clk, int enable);
-
-#endif /* __ASM_ARCH_CLOCK_H */
diff --git a/arch/arm/mach-exynos/clock-exynos4210.c b/arch/arm/mach-exynos/clock-exynos4210.c
deleted file mode 100644
index fed4c26..0000000
--- a/arch/arm/mach-exynos/clock-exynos4210.c
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4210 - Clock support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/syscore_ops.h>
-
-#include <plat/cpu-freq.h>
-#include <plat/clock.h>
-#include <plat/cpu.h>
-#include <plat/pll.h>
-#include <plat/s5p-clock.h>
-#include <plat/clock-clksrc.h>
-#include <plat/pm.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-#include <mach/sysmmu.h>
-
-#include "common.h"
-#include "clock-exynos4.h"
-
-#ifdef CONFIG_PM_SLEEP
-static struct sleep_save exynos4210_clock_save[] = {
-	SAVE_ITEM(EXYNOS4_CLKSRC_IMAGE),
-	SAVE_ITEM(EXYNOS4_CLKDIV_IMAGE),
-	SAVE_ITEM(EXYNOS4210_CLKSRC_LCD1),
-	SAVE_ITEM(EXYNOS4210_CLKDIV_LCD1),
-	SAVE_ITEM(EXYNOS4210_CLKSRC_MASK_LCD1),
-	SAVE_ITEM(EXYNOS4210_CLKGATE_IP_IMAGE),
-	SAVE_ITEM(EXYNOS4210_CLKGATE_IP_LCD1),
-	SAVE_ITEM(EXYNOS4210_CLKGATE_IP_PERIR),
-};
-#endif
-
-static struct clksrc_clk *sysclks[] = {
-	/* nothing here yet */
-};
-
-static struct clksrc_clk exynos4210_clk_mout_g2d0 = {
-	.clk	= {
-		.name		= "mout_g2d0",
-	},
-	.sources = &exynos4_clkset_mout_g2d0,
-	.reg_src = { .reg = EXYNOS4_CLKSRC_IMAGE, .shift = 0, .size = 1 },
-};
-
-static struct clksrc_clk exynos4210_clk_mout_g2d1 = {
-	.clk	= {
-		.name		= "mout_g2d1",
-	},
-	.sources = &exynos4_clkset_mout_g2d1,
-	.reg_src = { .reg = EXYNOS4_CLKSRC_IMAGE, .shift = 4, .size = 1 },
-};
-
-static struct clk *exynos4210_clkset_mout_g2d_list[] = {
-	[0] = &exynos4210_clk_mout_g2d0.clk,
-	[1] = &exynos4210_clk_mout_g2d1.clk,
-};
-
-static struct clksrc_sources exynos4210_clkset_mout_g2d = {
-	.sources	= exynos4210_clkset_mout_g2d_list,
-	.nr_sources	= ARRAY_SIZE(exynos4210_clkset_mout_g2d_list),
-};
-
-static int exynos4_clksrc_mask_lcd1_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(EXYNOS4210_CLKSRC_MASK_LCD1, clk, enable);
-}
-
-static struct clksrc_clk clksrcs[] = {
-	{
-		.clk		= {
-			.name		= "sclk_sata",
-			.id		= -1,
-			.enable		= exynos4_clksrc_mask_fsys_ctrl,
-			.ctrlbit	= (1 << 24),
-		},
-		.sources = &exynos4_clkset_mout_corebus,
-		.reg_src = { .reg = EXYNOS4_CLKSRC_FSYS, .shift = 24, .size = 1 },
-		.reg_div = { .reg = EXYNOS4_CLKDIV_FSYS0, .shift = 20, .size = 4 },
-	}, {
-		.clk		= {
-			.name		= "sclk_fimd",
-			.devname	= "exynos4-fb.1",
-			.enable		= exynos4_clksrc_mask_lcd1_ctrl,
-			.ctrlbit	= (1 << 0),
-		},
-		.sources = &exynos4_clkset_group,
-		.reg_src = { .reg = EXYNOS4210_CLKSRC_LCD1, .shift = 0, .size = 4 },
-		.reg_div = { .reg = EXYNOS4210_CLKDIV_LCD1, .shift = 0, .size = 4 },
-	}, {
-		.clk	= {
-			.name		= "sclk_fimg2d",
-		},
-		.sources = &exynos4210_clkset_mout_g2d,
-		.reg_src = { .reg = EXYNOS4_CLKSRC_IMAGE, .shift = 8, .size = 1 },
-		.reg_div = { .reg = EXYNOS4_CLKDIV_IMAGE, .shift = 0, .size = 4 },
-	},
-};
-
-static struct clk init_clocks_off[] = {
-	{
-		.name		= "sataphy",
-		.id		= -1,
-		.parent		= &exynos4_clk_aclk_133.clk,
-		.enable		= exynos4_clk_ip_fsys_ctrl,
-		.ctrlbit	= (1 << 3),
-	}, {
-		.name		= "sata",
-		.id		= -1,
-		.parent		= &exynos4_clk_aclk_133.clk,
-		.enable		= exynos4_clk_ip_fsys_ctrl,
-		.ctrlbit	= (1 << 10),
-	}, {
-		.name		= "fimd",
-		.devname	= "exynos4-fb.1",
-		.enable		= exynos4_clk_ip_lcd1_ctrl,
-		.ctrlbit	= (1 << 0),
-	}, {
-		.name		= SYSMMU_CLOCK_NAME,
-		.devname	= SYSMMU_CLOCK_DEVNAME(2d, 14),
-		.enable		= exynos4_clk_ip_image_ctrl,
-		.ctrlbit	= (1 << 3),
-	}, {
-		.name		= SYSMMU_CLOCK_NAME,
-		.devname	= SYSMMU_CLOCK_DEVNAME(fimd1, 11),
-		.enable		= exynos4_clk_ip_lcd1_ctrl,
-		.ctrlbit	= (1 << 4),
-	}, {
-		.name		= "fimg2d",
-		.enable		= exynos4_clk_ip_image_ctrl,
-		.ctrlbit	= (1 << 0),
-	},
-};
-
-#ifdef CONFIG_PM_SLEEP
-static int exynos4210_clock_suspend(void)
-{
-	s3c_pm_do_save(exynos4210_clock_save, ARRAY_SIZE(exynos4210_clock_save));
-
-	return 0;
-}
-
-static void exynos4210_clock_resume(void)
-{
-	s3c_pm_do_restore_core(exynos4210_clock_save, ARRAY_SIZE(exynos4210_clock_save));
-}
-
-#else
-#define exynos4210_clock_suspend NULL
-#define exynos4210_clock_resume NULL
-#endif
-
-static struct syscore_ops exynos4210_clock_syscore_ops = {
-	.suspend	= exynos4210_clock_suspend,
-	.resume		= exynos4210_clock_resume,
-};
-
-void __init exynos4210_register_clocks(void)
-{
-	int ptr;
-
-	exynos4_clk_mout_mpll.reg_src.reg = EXYNOS4_CLKSRC_CPU;
-	exynos4_clk_mout_mpll.reg_src.shift = 8;
-	exynos4_clk_mout_mpll.reg_src.size = 1;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
-		s3c_register_clksrc(sysclks[ptr], 1);
-
-	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
-
-	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-
-	register_syscore_ops(&exynos4210_clock_syscore_ops);
-}
diff --git a/arch/arm/mach-exynos/clock-exynos4212.c b/arch/arm/mach-exynos/clock-exynos4212.c
deleted file mode 100644
index 8fba0b5..0000000
--- a/arch/arm/mach-exynos/clock-exynos4212.c
+++ /dev/null
@@ -1,192 +0,0 @@
-/*
- * Copyright (c) 2011-2012 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4212 - Clock support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/syscore_ops.h>
-
-#include <plat/cpu-freq.h>
-#include <plat/clock.h>
-#include <plat/cpu.h>
-#include <plat/pll.h>
-#include <plat/s5p-clock.h>
-#include <plat/clock-clksrc.h>
-#include <plat/pm.h>
-
-#include <mach/hardware.h>
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-#include <mach/sysmmu.h>
-
-#include "common.h"
-#include "clock-exynos4.h"
-
-#ifdef CONFIG_PM_SLEEP
-static struct sleep_save exynos4212_clock_save[] = {
-	SAVE_ITEM(EXYNOS4_CLKSRC_IMAGE),
-	SAVE_ITEM(EXYNOS4_CLKDIV_IMAGE),
-	SAVE_ITEM(EXYNOS4212_CLKGATE_IP_IMAGE),
-	SAVE_ITEM(EXYNOS4212_CLKGATE_IP_PERIR),
-};
-#endif
-
-static int exynos4212_clk_ip_isp0_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_ISP0, clk, enable);
-}
-
-static int exynos4212_clk_ip_isp1_ctrl(struct clk *clk, int enable)
-{
-	return s5p_gatectrl(EXYNOS4_CLKGATE_IP_ISP1, clk, enable);
-}
-
-static struct clk *clk_src_mpll_user_list[] = {
-	[0] = &clk_fin_mpll,
-	[1] = &exynos4_clk_mout_mpll.clk,
-};
-
-static struct clksrc_sources clk_src_mpll_user = {
-	.sources	= clk_src_mpll_user_list,
-	.nr_sources	= ARRAY_SIZE(clk_src_mpll_user_list),
-};
-
-static struct clksrc_clk clk_mout_mpll_user = {
-	.clk = {
-		.name		= "mout_mpll_user",
-	},
-	.sources	= &clk_src_mpll_user,
-	.reg_src	= { .reg = EXYNOS4_CLKSRC_CPU, .shift = 24, .size = 1 },
-};
-
-static struct clksrc_clk exynos4x12_clk_mout_g2d0 = {
-	.clk	= {
-		.name		= "mout_g2d0",
-	},
-	.sources = &exynos4_clkset_mout_g2d0,
-	.reg_src = { .reg = EXYNOS4_CLKSRC_DMC, .shift = 20, .size = 1 },
-};
-
-static struct clksrc_clk exynos4x12_clk_mout_g2d1 = {
-	.clk	= {
-		.name		= "mout_g2d1",
-	},
-	.sources = &exynos4_clkset_mout_g2d1,
-	.reg_src = { .reg = EXYNOS4_CLKSRC_DMC, .shift = 24, .size = 1 },
-};
-
-static struct clk *exynos4x12_clkset_mout_g2d_list[] = {
-	[0] = &exynos4x12_clk_mout_g2d0.clk,
-	[1] = &exynos4x12_clk_mout_g2d1.clk,
-};
-
-static struct clksrc_sources exynos4x12_clkset_mout_g2d = {
-	.sources	= exynos4x12_clkset_mout_g2d_list,
-	.nr_sources	= ARRAY_SIZE(exynos4x12_clkset_mout_g2d_list),
-};
-
-static struct clksrc_clk *sysclks[] = {
-	&clk_mout_mpll_user,
-};
-
-static struct clksrc_clk clksrcs[] = {
-	{
-		.clk	= {
-			.name		= "sclk_fimg2d",
-		},
-		.sources = &exynos4x12_clkset_mout_g2d,
-		.reg_src = { .reg = EXYNOS4_CLKSRC_DMC, .shift = 28, .size = 1 },
-		.reg_div = { .reg = EXYNOS4_CLKDIV_DMC1, .shift = 0, .size = 4 },
-	},
-};
-
-static struct clk init_clocks_off[] = {
-	{
-		.name		= SYSMMU_CLOCK_NAME,
-		.devname	= SYSMMU_CLOCK_DEVNAME(2d, 14),
-		.enable		= exynos4_clk_ip_dmc_ctrl,
-		.ctrlbit	= (1 << 24),
-	}, {
-		.name		= SYSMMU_CLOCK_NAME,
-		.devname	= SYSMMU_CLOCK_DEVNAME(isp, 9),
-		.enable		= exynos4212_clk_ip_isp0_ctrl,
-		.ctrlbit	= (7 << 8),
-	}, {
-		.name		= SYSMMU_CLOCK_NAME2,
-		.devname	= SYSMMU_CLOCK_DEVNAME(isp, 9),
-		.enable		= exynos4212_clk_ip_isp1_ctrl,
-		.ctrlbit	= (1 << 4),
-	}, {
-		.name		= "flite",
-		.devname	= "exynos-fimc-lite.0",
-		.enable		= exynos4212_clk_ip_isp0_ctrl,
-		.ctrlbit	= (1 << 4),
-	}, {
-		.name		= "flite",
-		.devname	= "exynos-fimc-lite.1",
-		.enable		= exynos4212_clk_ip_isp0_ctrl,
-		.ctrlbit	= (1 << 3),
-	}, {
-		.name		= "fimg2d",
-		.enable		= exynos4_clk_ip_dmc_ctrl,
-		.ctrlbit	= (1 << 23),
-	},
-};
-
-#ifdef CONFIG_PM_SLEEP
-static int exynos4212_clock_suspend(void)
-{
-	s3c_pm_do_save(exynos4212_clock_save, ARRAY_SIZE(exynos4212_clock_save));
-
-	return 0;
-}
-
-static void exynos4212_clock_resume(void)
-{
-	s3c_pm_do_restore_core(exynos4212_clock_save, ARRAY_SIZE(exynos4212_clock_save));
-}
-
-#else
-#define exynos4212_clock_suspend NULL
-#define exynos4212_clock_resume NULL
-#endif
-
-static struct syscore_ops exynos4212_clock_syscore_ops = {
-	.suspend	= exynos4212_clock_suspend,
-	.resume		= exynos4212_clock_resume,
-};
-
-void __init exynos4212_register_clocks(void)
-{
-	int ptr;
-
-	/* usbphy1 is removed */
-	exynos4_clkset_group_list[4] = NULL;
-
-	/* mout_mpll_user is used */
-	exynos4_clkset_group_list[6] = &clk_mout_mpll_user.clk;
-	exynos4_clkset_aclk_top_list[0] = &clk_mout_mpll_user.clk;
-
-	exynos4_clk_mout_mpll.reg_src.reg = EXYNOS4_CLKSRC_DMC;
-	exynos4_clk_mout_mpll.reg_src.shift = 12;
-	exynos4_clk_mout_mpll.reg_src.size = 1;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(sysclks); ptr++)
-		s3c_register_clksrc(sysclks[ptr], 1);
-
-	s3c_register_clksrc(clksrcs, ARRAY_SIZE(clksrcs));
-
-	s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-	s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_clocks_off));
-
-	register_syscore_ops(&exynos4212_clock_syscore_ops);
-}
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 535a7ed..2b1b225 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -67,7 +67,6 @@ static const char name_exynos5440[] = "EXYNOS5440";
 static void exynos4_map_io(void);
 static void exynos5_map_io(void);
 static void exynos5440_map_io(void);
-static void exynos4_init_clocks(int xtal);
 static void exynos5_init_clocks(int xtal);
 static void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
@@ -77,7 +76,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= EXYNOS4210_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_clocks	= exynos4_init_clocks,
 		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4210,
@@ -85,7 +83,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= EXYNOS4212_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_clocks	= exynos4_init_clocks,
 		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4212,
@@ -93,7 +90,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= EXYNOS4412_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_clocks	= exynos4_init_clocks,
 		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4412,
@@ -432,22 +428,6 @@ static void __init exynos5_map_io(void)
 		iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
 }
 
-static void __init exynos4_init_clocks(int xtal)
-{
-	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
-
-	s3c24xx_register_baseclocks(xtal);
-	s5p_register_clocks(xtal);
-
-	if (soc_is_exynos4210())
-		exynos4210_register_clocks();
-	else if (soc_is_exynos4212() || soc_is_exynos4412())
-		exynos4212_register_clocks();
-
-	exynos4_register_clocks();
-	exynos4_setup_clocks();
-}
-
 static void __init exynos5440_map_io(void)
 {
 	iotable_init(exynos5440_iodesc0, ARRAY_SIZE(exynos5440_iodesc0));
@@ -455,6 +435,7 @@ static void __init exynos5440_map_io(void)
 
 static void __init exynos5_init_clocks(int xtal)
 {
+#ifndef CONFIG_COMMON_CLK
 	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
 
 	s3c24xx_register_baseclocks(xtal);
@@ -462,6 +443,7 @@ static void __init exynos5_init_clocks(int xtal)
 
 	exynos5_register_clocks();
 	exynos5_setup_clocks();
+#endif
 }
 
 void __init exynos_timer_init(void)
@@ -472,6 +454,7 @@ void __init exynos_timer_init(void)
 	 */
 	if (!of_have_populated_dt() && (soc_is_exynos4210() ||
 		soc_is_exynos4212() || soc_is_exynos4412())) {
+		exynos4_clk_init();
 		exynos_mct_init();
 		return;
 	}
@@ -481,6 +464,10 @@ void __init exynos_timer_init(void)
 		if (arch_timer_of_register())
 			panic("%s: could not initialize timer\n", __func__);
 	} else {
+		if (of_machine_is_compatible("samsung,exynos4210") ||
+			       of_machine_is_compatible("samsung,exynos4212") ||
+			       of_machine_is_compatible("samsung,exynos4412"))
+			exynos4_clk_init();
 		exynos_mct_init();
 	}
 }
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 687b6f0..e3ed6bb 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -23,6 +23,23 @@ void exynos5_restart(char mode, const char *cmd);
 void exynos_init_late(void);
 extern void exynos_mct_init(void);
 
+#ifdef CONFIG_COMMON_CLK
+extern void exynos4_clk_init(void);
+extern void exynos4_clk_register_fixed_ext(unsigned long, unsigned long);
+#else
+/* todo: remove these after adding common clock support for exynos5 platforms */
+static inline void exynos4_clk_init(void)
+{
+	return;
+}
+
+static inline void exynos4_clk_register_fixed_ext(unsigned long xxti_f,
+							unsigned long xusbxti)
+{
+	return;
+}
+#endif
+
 void exynos_firmware_init(void);
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index 4d0ea70..e8dce5c 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -178,7 +178,6 @@ static void __init armlex4210_smsc911x_init(void)
 static void __init armlex4210_map_io(void)
 {
 	exynos_init_io(NULL, 0);
-	s3c24xx_init_clocks(24000000);
 	s3c24xx_init_uarts(armlex4210_uartcfgs,
 			   ARRAY_SIZE(armlex4210_uartcfgs));
 }
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index 86d914c..a7471ae 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -86,7 +86,6 @@ static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
 static void __init exynos4_dt_map_io(void)
 {
 	exynos_init_io(NULL, 0);
-	s3c24xx_init_clocks(24000000);
 }
 
 static void __init exynos4_dt_machine_init(void)
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 03d5ddf..8695d33 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1331,7 +1331,6 @@ static struct platform_device *nuri_devices[] __initdata = {
 static void __init nuri_map_io(void)
 {
 	exynos_init_io(NULL, 0);
-	s3c24xx_init_clocks(clk_xusbxti.rate);
 	s3c24xx_init_uarts(nuri_uartcfgs, ARRAY_SIZE(nuri_uartcfgs));
 }
 
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index 97dcf6f..5d9479d 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -755,7 +755,6 @@ static void s5p_tv_setup(void)
 static void __init origen_map_io(void)
 {
 	exynos_init_io(NULL, 0);
-	s3c24xx_init_clocks(clk_xusbxti.rate);
 	s3c24xx_init_uarts(origen_uartcfgs, ARRAY_SIZE(origen_uartcfgs));
 }
 
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index 08409b0..f67f541 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -323,7 +323,6 @@ static struct platform_device *smdk4x12_devices[] __initdata = {
 static void __init smdk4x12_map_io(void)
 {
 	exynos_init_io(NULL, 0);
-	s3c24xx_init_clocks(clk_xusbxti.rate);
 	s3c24xx_init_uarts(smdk4x12_uartcfgs, ARRAY_SIZE(smdk4x12_uartcfgs));
 }
 
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index d791e5d..a1be874 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -372,7 +372,6 @@ static void s5p_tv_setup(void)
 static void __init smdkv310_map_io(void)
 {
 	exynos_init_io(NULL, 0);
-	s3c24xx_init_clocks(clk_xusbxti.rate);
 	s3c24xx_init_uarts(smdkv310_uartcfgs, ARRAY_SIZE(smdkv310_uartcfgs));
 }
 
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 9e3340f..3999c16 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1093,7 +1093,6 @@ static struct platform_device *universal_devices[] __initdata = {
 static void __init universal_map_io(void)
 {
 	exynos_init_io(NULL, 0);
-	s3c24xx_init_clocks(clk_xusbxti.rate);
 	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
 	s5p_set_timer_source(S5P_PWM2, S5P_PWM4);
 }
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index a9d5216..a034560 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -25,7 +25,7 @@ config PLAT_S5P
 	select PLAT_SAMSUNG
 	select S3C_GPIO_TRACK
 	select S5P_GPIO_DRVSTR
-	select SAMSUNG_CLKSRC
+	select SAMSUNG_CLKSRC if !COMMON_CLK
 	select SAMSUNG_GPIOLIB_4BIT
 	select SAMSUNG_IRQ_VIC_TIMER
 	help
@@ -89,7 +89,7 @@ config SAMSUNG_CLKSRC
 	  used by newer systems such as the S3C64XX.
 
 config S5P_CLOCK
-	def_bool (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS)
+	def_bool ((ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_EXYNOS) && !COMMON_CLK)
 	help
 	  Support common clock part for ARCH_S5P and ARCH_EXYNOS SoCs
 
-- 
1.7.5.4
