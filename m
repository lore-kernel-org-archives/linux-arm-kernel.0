From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 24 Nov 2014 14:17:47 +0530
Subject: [PATCH v6 2/2] ARM: EXYNOS: Remove i2c sys configuration related code
In-Reply-To: <1416818867-29156-1-git-send-email-pankaj.dubey@samsung.com>
References: <1416818867-29156-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1416818867-29156-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all these code has been moved into i2c driver, now we can
safely remove them from machine files.

CC: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/exynos.c           |   39 ++-----------------------------
 arch/arm/mach-exynos/include/mach/map.h |    3 ---
 arch/arm/mach-exynos/pm.c               |    3 ++-
 arch/arm/mach-exynos/regs-sys.h         |   22 -----------------
 arch/arm/mach-exynos/suspend.c          |    7 ------
 5 files changed, 4 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/regs-sys.h

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index c13d083..2c84439 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -27,20 +27,16 @@
 #include <asm/mach/map.h>
 #include <asm/memory.h>
 
+#include <mach/map.h>
+
 #include "common.h"
 #include "mfc.h"
 #include "regs-pmu.h"
-#include "regs-sys.h"
 
 void __iomem *pmu_base_addr;
 
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S3C_VA_SYS,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSCON),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_SROMC,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_SROMC),
 		.length		= SZ_4K,
@@ -70,11 +66,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 
 static struct map_desc exynos5_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S3C_VA_SYS,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSCON),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_SROMC,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_SROMC),
 		.length		= SZ_4K,
@@ -213,32 +204,6 @@ static void __init exynos_init_irq(void)
 
 static void __init exynos_dt_machine_init(void)
 {
-	struct device_node *i2c_np;
-	const char *i2c_compat = "samsung,s3c2440-i2c";
-	unsigned int tmp;
-	int id;
-
-	/*
-	 * Exynos5's legacy i2c controller and new high speed i2c
-	 * controller have muxed interrupt sources. By default the
-	 * interrupts for 4-channel HS-I2C controller are enabled.
-	 * If node for first four channels of legacy i2c controller
-	 * are available then re-configure the interrupts via the
-	 * system register.
-	 */
-	if (soc_is_exynos5()) {
-		for_each_compatible_node(i2c_np, NULL, i2c_compat) {
-			if (of_device_is_available(i2c_np)) {
-				id = of_alias_get_id(i2c_np, "i2c");
-				if (id < 4) {
-					tmp = readl(EXYNOS5_SYS_I2C_CFG);
-					writel(tmp & ~(0x1 << id),
-							EXYNOS5_SYS_I2C_CFG);
-				}
-			}
-		}
-	}
-
 	/*
 	 * This is called from smp_prepare_cpus if we've built for SMP, but
 	 * we still need to set it up for PM and firmware ops if not.
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 1ad3f49..de3ae59 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -24,9 +24,6 @@
 
 #define EXYNOS_PA_CHIPID		0x10000000
 
-#define EXYNOS4_PA_SYSCON		0x10010000
-#define EXYNOS5_PA_SYSCON		0x10050100
-
 #define EXYNOS4_PA_CMU			0x10030000
 #define EXYNOS5_PA_CMU			0x10010000
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 86f3ecd..dfc8594 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -23,12 +23,13 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
+#include <mach/map.h>
+
 #include <plat/pm-common.h>
 
 #include "common.h"
 #include "exynos-pmu.h"
 #include "regs-pmu.h"
-#include "regs-sys.h"
 
 static inline void __iomem *exynos_boot_vector_addr(void)
 {
diff --git a/arch/arm/mach-exynos/regs-sys.h b/arch/arm/mach-exynos/regs-sys.h
deleted file mode 100644
index 84332b0..0000000
--- a/arch/arm/mach-exynos/regs-sys.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (c) 2014 Samsung Electronics Co., Ltd.
- *             http://www.samsung.com
- *
- * EXYNOS - system register definition
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_SYS_H
-#define __ASM_ARCH_REGS_SYS_H __FILE__
-
-#include <mach/map.h>
-
-#define S5P_SYSREG(x)                          (S3C_VA_SYS + (x))
-
-/* For EXYNOS5 */
-#define EXYNOS5_SYS_I2C_CFG                    S5P_SYSREG(0x0234)
-
-#endif /* __ASM_ARCH_REGS_SYS_H */
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index f8e7dcd..342797b 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -34,7 +34,6 @@
 
 #include "common.h"
 #include "regs-pmu.h"
-#include "regs-sys.h"
 #include "exynos-pmu.h"
 
 #define S5P_CHECK_SLEEP 0x00000BAD
@@ -53,10 +52,6 @@ struct exynos_wkup_irq {
 	u32 mask;
 };
 
-static struct sleep_save exynos5_sys_save[] = {
-	SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
-};
-
 static struct sleep_save exynos_core_save[] = {
 	/* SROM side */
 	SAVE_ITEM(S5P_SROM_BW),
@@ -497,8 +492,6 @@ static const struct exynos_pm_data exynos5250_pm_data = {
 	.wkup_irq	= exynos5250_wkup_irq,
 	.wake_disable_mask = ((0xFF << 8) | (0x1F << 1)),
 	.release_ret_regs = exynos_release_ret_regs,
-	.extra_save	= exynos5_sys_save,
-	.num_extra_save	= ARRAY_SIZE(exynos5_sys_save),
 	.pm_suspend	= exynos_pm_suspend,
 	.pm_resume	= exynos_pm_resume,
 	.pm_prepare	= exynos_pm_prepare,
-- 
1.7.9.5
