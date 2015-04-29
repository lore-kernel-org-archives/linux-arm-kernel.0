From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 29 Apr 2015 14:08:29 +0530
Subject: [PATCH 2/5] ARM: EXYNOS: Remove SROM related register settings from
 mach-exynos
In-Reply-To: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
References: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1430296712-10287-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As now we have dedicated driver for SROM controller, it will take care
of saving register banks during S2R so we can safely remove these
settings from mach-exynos.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                   |  2 +
 arch/arm/mach-exynos/exynos.c                  | 10 -----
 arch/arm/mach-exynos/include/mach/map.h        |  3 --
 arch/arm/mach-exynos/suspend.c                 | 20 +---------
 arch/arm/plat-samsung/include/plat/map-s5p.h   |  1 -
 arch/arm/plat-samsung/include/plat/regs-srom.h | 54 --------------------------
 6 files changed, 4 insertions(+), 86 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-srom.h

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 603820e..e842b23 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -25,6 +25,8 @@ menuconfig ARCH_EXYNOS
 	select S5P_DEV_MFC
 	select SRAM
 	select MFD_SYSCON
+	select SOC_SAMSUNG
+	select EXYNOS_SROM
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index a140872..e422517 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -37,11 +37,6 @@ void __iomem *pmu_base_addr;
 
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S5P_VA_SROMC,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_CMU,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
 		.length		= SZ_128K,
@@ -66,11 +61,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 
 static struct map_desc exynos5_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S5P_VA_SROMC,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_SROMC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_CMU,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_CMU),
 		.length		= 144 * SZ_1K,
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index de3ae59..ff39f02 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -33,9 +33,6 @@
 #define EXYNOS4_PA_COREPERI		0x10500000
 #define EXYNOS4_PA_L2CC			0x10502000
 
-#define EXYNOS4_PA_SROMC		0x12570000
-#define EXYNOS5_PA_SROMC		0x12250000
-
 /* Compatibility UART */
 
 #define EXYNOS5440_PA_UART0		0x000B0000
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 6e5a335..2af5c76 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -30,7 +30,8 @@
 #include <asm/suspend.h>
 
 #include <plat/pm-common.h>
-#include <plat/regs-srom.h>
+
+#include <mach/map.h>
 
 #include "common.h"
 #include "regs-pmu.h"
@@ -52,15 +53,6 @@ struct exynos_wkup_irq {
 	u32 mask;
 };
 
-static struct sleep_save exynos_core_save[] = {
-	/* SROM side */
-	SAVE_ITEM(S5P_SROM_BW),
-	SAVE_ITEM(S5P_SROM_BC0),
-	SAVE_ITEM(S5P_SROM_BC1),
-	SAVE_ITEM(S5P_SROM_BC2),
-	SAVE_ITEM(S5P_SROM_BC3),
-};
-
 struct exynos_pm_data {
 	const struct exynos_wkup_irq *wkup_irq;
 	unsigned int wake_disable_mask;
@@ -236,8 +228,6 @@ static void exynos_pm_prepare(void)
 	/* Set wake-up mask registers */
 	exynos_pm_set_wakeup_mask();
 
-	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
 	exynos_pm_enter_sleep_mode();
 
 	/* ensure at least INFORM0 has the resume address */
@@ -268,8 +258,6 @@ static void exynos5420_pm_prepare(void)
 	/* Set wake-up mask registers */
 	exynos_pm_set_wakeup_mask();
 
-	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
 	exynos_pmu_spare3 = pmu_raw_readl(S5P_PMU_SPARE3);
 	/*
 	 * The cpu state needs to be saved and restored so that the
@@ -360,8 +348,6 @@ static void exynos_pm_resume(void)
 	/* For release retention */
 	exynos_pm_release_retention();
 
-	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
 	if (cpuid == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(S5P_VA_SCU);
 
@@ -427,8 +413,6 @@ static void exynos5420_pm_resume(void)
 
 	pmu_raw_writel(exynos_pmu_spare3, S5P_PMU_SPARE3);
 
-	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
 early_wakeup:
 
 	tmp = pmu_raw_readl(EXYNOS5420_SFR_AXI_CGDIS1);
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index f5cf2bd..e555769 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -18,7 +18,6 @@
 
 #define S5P_VA_DMC0		S3C_ADDR(0x02440000)
 #define S5P_VA_DMC1		S3C_ADDR(0x02480000)
-#define S5P_VA_SROMC		S3C_ADDR(0x024C0000)
 
 #define S5P_VA_COREPERI_BASE	S3C_ADDR(0x02800000)
 #define S5P_VA_COREPERI(x)	(S5P_VA_COREPERI_BASE + (x))
diff --git a/arch/arm/plat-samsung/include/plat/regs-srom.h b/arch/arm/plat-samsung/include/plat/regs-srom.h
deleted file mode 100644
index 9b6729c..0000000
--- a/arch/arm/plat-samsung/include/plat/regs-srom.h
+++ /dev/null
@@ -1,54 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/regs-srom.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * S5P SROMC register definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_SAMSUNG_REGS_SROM_H
-#define __PLAT_SAMSUNG_REGS_SROM_H __FILE__
-
-#include <mach/map.h>
-
-#define S5P_SROMREG(x)		(S5P_VA_SROMC + (x))
-
-#define S5P_SROM_BW		S5P_SROMREG(0x0)
-#define S5P_SROM_BC0		S5P_SROMREG(0x4)
-#define S5P_SROM_BC1		S5P_SROMREG(0x8)
-#define S5P_SROM_BC2		S5P_SROMREG(0xc)
-#define S5P_SROM_BC3		S5P_SROMREG(0x10)
-#define S5P_SROM_BC4		S5P_SROMREG(0x14)
-#define S5P_SROM_BC5		S5P_SROMREG(0x18)
-
-/* one register BW holds 4 x 4-bit packed settings for NCS0 - NCS3 */
-
-#define S5P_SROM_BW__DATAWIDTH__SHIFT		0
-#define S5P_SROM_BW__ADDRMODE__SHIFT		1
-#define S5P_SROM_BW__WAITENABLE__SHIFT		2
-#define S5P_SROM_BW__BYTEENABLE__SHIFT		3
-
-#define S5P_SROM_BW__CS_MASK			0xf
-
-#define S5P_SROM_BW__NCS0__SHIFT		0
-#define S5P_SROM_BW__NCS1__SHIFT		4
-#define S5P_SROM_BW__NCS2__SHIFT		8
-#define S5P_SROM_BW__NCS3__SHIFT		12
-#define S5P_SROM_BW__NCS4__SHIFT		16
-#define S5P_SROM_BW__NCS5__SHIFT		20
-
-/* applies to same to BCS0 - BCS3 */
-
-#define S5P_SROM_BCX__PMC__SHIFT		0
-#define S5P_SROM_BCX__TACP__SHIFT		4
-#define S5P_SROM_BCX__TCAH__SHIFT		8
-#define S5P_SROM_BCX__TCOH__SHIFT		12
-#define S5P_SROM_BCX__TACC__SHIFT		16
-#define S5P_SROM_BCX__TCOS__SHIFT		24
-#define S5P_SROM_BCX__TACS__SHIFT		28
-
-#endif /* __PLAT_SAMSUNG_REGS_SROM_H */
-- 
2.2.0
