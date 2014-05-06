From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 06 May 2014 17:51:18 +0900
Subject: [PATCH v2 2/6] ARM: EXYNOS: Move SYS_I2C_CFG register save/restore to
 i2c driver
In-Reply-To: <1399366282-4191-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399366282-4191-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399366282-4191-3-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's move SYS_I2C_CFG register save/restore during s2r into i2c driver.
This will help in removing static iodesc based mapping from exynos.c.
Also will help in removing SoC specific checks in pm.c making it
more independent of such macros.

CC: Wolfram Sang <wsa@the-dreams.de>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-i2c at vger.kernel.org
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/exynos.c           |   12 +-----------
 arch/arm/mach-exynos/include/mach/map.h |    3 ---
 arch/arm/mach-exynos/pm.c               |   10 ----------
 arch/arm/mach-exynos/regs-sys.h         |   22 ----------------------
 drivers/i2c/busses/i2c-s3c2410.c        |    8 ++++++++
 5 files changed, 9 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/regs-sys.h

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 54ae2e1..09063ee 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -29,11 +29,11 @@
 #include <asm/memory.h>
 
 #include <plat/cpu.h>
+#include <mach/map.h>
 
 #include "common.h"
 #include "mfc.h"
 #include "regs-pmu.h"
-#include "regs-sys.h"
 
 #define L2_AUX_VAL 0x7C470001
 #define L2_AUX_MASK 0xC200ffff
@@ -42,11 +42,6 @@ static struct regmap *exynos_pmu_regmap;
 
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S3C_VA_SYS,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSCON),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S3C_VA_TIMER,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_TIMER),
 		.length		= SZ_16K,
@@ -116,11 +111,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 
 static struct map_desc exynos5_iodesc[] __initdata = {
 	{
-		.virtual	= (unsigned long)S3C_VA_SYS,
-		.pfn		= __phys_to_pfn(EXYNOS5_PA_SYSCON),
-		.length		= SZ_64K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S3C_VA_TIMER,
 		.pfn		= __phys_to_pfn(EXYNOS5_PA_TIMER),
 		.length		= SZ_16K,
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 34eee6e..bd4a320 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -25,9 +25,6 @@
 
 #define EXYNOS_PA_CHIPID		0x10000000
 
-#define EXYNOS4_PA_SYSCON		0x10010000
-#define EXYNOS5_PA_SYSCON		0x10050100
-
 #define EXYNOS4_PA_CMU			0x10030000
 #define EXYNOS5_PA_CMU			0x10010000
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index a7a1b7f..59e5604 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -37,7 +37,6 @@
 
 #include "common.h"
 #include "regs-pmu.h"
-#include "regs-sys.h"
 #include "exynos-pmu.h"
 
 static struct regmap *pmu_regmap;
@@ -52,10 +51,6 @@ struct exynos_wkup_irq {
 	u32 mask;
 };
 
-static struct sleep_save exynos5_sys_save[] = {
-	SAVE_ITEM(EXYNOS5_SYS_I2C_CFG),
-};
-
 static struct sleep_save exynos_core_save[] = {
 	/* SROM side */
 	SAVE_ITEM(S5P_SROM_BW),
@@ -211,7 +206,6 @@ static void exynos_pm_prepare(void)
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
 	if (soc_is_exynos5250()) {
-		s3c_pm_do_save(exynos5_sys_save, ARRAY_SIZE(exynos5_sys_save));
 		/* Disable USE_RETENTION of JPEG_MEM_OPTION */
 		regmap_read(pmu_regmap, EXYNOS5_JPEG_MEM_OPTION, &tmp);
 		tmp &= ~EXYNOS5_OPTION_USE_RETENTION;
@@ -296,10 +290,6 @@ static void exynos_pm_resume(void)
 	regmap_write(pmu_regmap, S5P_PAD_RET_EBIA_OPTION, (1 << 28));
 	regmap_write(pmu_regmap, S5P_PAD_RET_EBIB_OPTION, (1 << 28));
 
-	if (soc_is_exynos5250())
-		s3c_pm_do_restore(exynos5_sys_save,
-			ARRAY_SIZE(exynos5_sys_save));
-
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
 	if (!soc_is_exynos5250())
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
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 0420150..2095a01 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -133,6 +133,7 @@ struct s3c24xx_i2c {
 	struct notifier_block	freq_transition;
 #endif
 	struct regmap		*sysreg;
+	unsigned int		syc_cfg;
 };
 
 static struct platform_device_id s3c24xx_driver_ids[] = {
@@ -1293,6 +1294,9 @@ static int s3c24xx_i2c_suspend_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
+	if (i2c->sysreg)
+		regmap_read(i2c->sysreg, EXYNOS5_SYS_I2C_CFG, &i2c->syc_cfg);
+
 	i2c->suspended = 1;
 
 	return 0;
@@ -1304,6 +1308,10 @@ static int s3c24xx_i2c_resume(struct device *dev)
 	struct s3c24xx_i2c *i2c = platform_get_drvdata(pdev);
 
 	i2c->suspended = 0;
+
+	if (i2c->sysreg)
+		regmap_write(i2c->sysreg, i2c->syc_cfg, EXYNOS5_SYS_I2C_CFG);
+
 	clk_prepare_enable(i2c->clk);
 	s3c24xx_i2c_init(i2c);
 	clk_disable_unprepare(i2c->clk);
-- 
1.7.10.4
