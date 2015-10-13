From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 13 Oct 2015 18:43:50 +0530
Subject: [PATCH v3 8/8] ARM: EXYNOS: Remove SROM related register settings from
 mach-exynos
In-Reply-To: <1444742030-31892-1-git-send-email-pankaj.dubey@samsung.com>
References: <1444742030-31892-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1444742030-31892-9-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As now we have dedicated driver for SROM controller, it will take care
of saving register banks during S2R so we can safely remove these
settings from mach-exynos.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                 |  2 ++
 arch/arm/mach-exynos/exynos.c                | 17 ---------
 arch/arm/mach-exynos/include/mach/map.h      |  3 --
 arch/arm/mach-exynos/regs-srom.h             | 53 ----------------------------
 arch/arm/mach-exynos/suspend.c               | 20 ++---------
 arch/arm/plat-samsung/include/plat/map-s5p.h |  1 -
 6 files changed, 4 insertions(+), 92 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/regs-srom.h

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 3a10f1a..7c917ef 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -27,6 +27,8 @@ menuconfig ARCH_EXYNOS
 	select SRAM
 	select THERMAL
 	select MFD_SYSCON
+	select SOC_SAMSUNG
+	select EXYNOS_SROM
 	help
 	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
 
diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 524aa6f..4ffb90e 100644
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
@@ -64,15 +59,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 	},
 };
 
-static struct map_desc exynos5_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_SROMC,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_SROMC),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
 static struct platform_device exynos_cpuidle = {
 	.name              = "exynos_cpuidle",
 #ifdef CONFIG_ARM_EXYNOS_CPUIDLE
@@ -144,9 +130,6 @@ static void __init exynos_map_io(void)
 {
 	if (soc_is_exynos4())
 		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
-
-	if (soc_is_exynos5())
-		iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
 }
 
 static void __init exynos_init_io(void)
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 86d8085..351e839 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -32,7 +32,4 @@
 #define EXYNOS4_PA_COREPERI		0x10500000
 #define EXYNOS4_PA_L2CC			0x10502000
 
-#define EXYNOS4_PA_SROMC		0x12570000
-#define EXYNOS5_PA_SROMC		0x12250000
-
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-exynos/regs-srom.h b/arch/arm/mach-exynos/regs-srom.h
deleted file mode 100644
index 5c4d442..0000000
--- a/arch/arm/mach-exynos/regs-srom.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
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
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index e00eb39..21abd9b 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -31,12 +31,13 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
+#include <mach/map.h>
+
 #include <plat/pm-common.h>
 
 #include "common.h"
 #include "exynos-pmu.h"
 #include "regs-pmu.h"
-#include "regs-srom.h"
 
 #define REG_TABLE_END (-1U)
 
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
@@ -339,8 +331,6 @@ static void exynos_pm_prepare(void)
 	/* Set wake-up mask registers */
 	exynos_pm_set_wakeup_mask();
 
-	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
 	exynos_pm_enter_sleep_mode();
 
 	/* ensure at least INFORM0 has the resume address */
@@ -371,8 +361,6 @@ static void exynos5420_pm_prepare(void)
 	/* Set wake-up mask registers */
 	exynos_pm_set_wakeup_mask();
 
-	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
 	exynos_pmu_spare3 = pmu_raw_readl(S5P_PMU_SPARE3);
 	/*
 	 * The cpu state needs to be saved and restored so that the
@@ -463,8 +451,6 @@ static void exynos_pm_resume(void)
 	/* For release retention */
 	exynos_pm_release_retention();
 
-	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
-
 	if (cpuid == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(S5P_VA_SCU);
 
@@ -531,8 +517,6 @@ static void exynos5420_pm_resume(void)
 
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
-- 
2.4.5
