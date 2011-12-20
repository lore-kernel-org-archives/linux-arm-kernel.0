From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 Dec 2011 21:48:34 +0900
Subject: [PATCH 10/12] ARM: restart: EXYNOS: use new restart hook
In-Reply-To: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
References: <1324385316-6052-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1324385316-6052-11-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
[kgene.kim at samsung.com: according to local header, updated]
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/common.c                     |    7 +----
 arch/arm/mach-exynos/common.h                     |    2 +
 arch/arm/mach-exynos/include/mach/system.h        |    2 -
 arch/arm/mach-exynos/mach-armlex4210.c            |    1 +
 arch/arm/mach-exynos/mach-nuri.c                  |    1 +
 arch/arm/mach-exynos/mach-origen.c                |    1 +
 arch/arm/mach-exynos/mach-smdk4x12.c              |    2 +
 arch/arm/mach-exynos/mach-smdkv310.c              |    2 +
 arch/arm/mach-exynos/mach-universal_c210.c        |    1 +
 arch/arm/plat-samsung/include/plat/reset.h        |   16 -----------
 arch/arm/plat-samsung/include/plat/system-reset.h |   31 ---------------------
 11 files changed, 11 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/reset.h
 delete mode 100644 arch/arm/plat-samsung/include/plat/system-reset.h

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 8eb2293..5de4214 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -33,7 +33,6 @@
 #include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
-#include <plat/reset.h>
 #include <plat/sdhci.h>
 #include <plat/gpio-cfg.h>
 #include <plat/adc-core.h>
@@ -213,7 +212,7 @@ static void exynos_idle(void)
 	local_irq_enable();
 }
 
-static void exynos4_sw_reset(void)
+void exynos4_restart(char mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
 }
@@ -462,10 +461,6 @@ int __init exynos_init(void)
 	/* set idle function */
 	pm_idle = exynos_idle;
 
-	/* set sw_reset function */
-	if (soc_is_exynos4210() || soc_is_exynos4212() || soc_is_exynos4412())
-		s5p_reset_hook = exynos4_sw_reset;
-
 	return sysdev_register(&exynos4_sysdev);
 }
 
diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index 0476c5f..1ac49de 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -21,6 +21,8 @@ void exynos4_setup_clocks(void);
 void exynos4210_register_clocks(void);
 void exynos4212_register_clocks(void);
 
+void exynos4_restart(char mode, const char *cmd);
+
 extern struct sys_timer exynos4_timer;
 
 #ifdef CONFIG_ARCH_EXYNOS
diff --git a/arch/arm/mach-exynos/include/mach/system.h b/arch/arm/mach-exynos/include/mach/system.h
index 5e3220c..0063a6d 100644
--- a/arch/arm/mach-exynos/include/mach/system.h
+++ b/arch/arm/mach-exynos/include/mach/system.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H __FILE__
 
-#include <plat/system-reset.h>
-
 static void arch_idle(void)
 {
 	/* nothing here yet */
diff --git a/arch/arm/mach-exynos/mach-armlex4210.c b/arch/arm/mach-exynos/mach-armlex4210.c
index b1807c4..d726fcd 100644
--- a/arch/arm/mach-exynos/mach-armlex4210.c
+++ b/arch/arm/mach-exynos/mach-armlex4210.c
@@ -215,4 +215,5 @@ MACHINE_START(ARMLEX4210, "ARMLEX4210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= armlex4210_machine_init,
 	.timer		= &exynos4_timer,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index a6ecdbc..635fb97 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -1339,4 +1339,5 @@ MACHINE_START(NURI, "NURI")
 	.init_machine	= nuri_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve        = &nuri_reserve,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index ea35806..586eb99 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -700,4 +700,5 @@ MACHINE_START(ORIGEN, "ORIGEN")
 	.init_machine	= origen_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve	= &origen_reserve,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdk4x12.c b/arch/arm/mach-exynos/mach-smdk4x12.c
index 3b1a9f0..d00e4f0 100644
--- a/arch/arm/mach-exynos/mach-smdk4x12.c
+++ b/arch/arm/mach-exynos/mach-smdk4x12.c
@@ -292,6 +292,7 @@ MACHINE_START(SMDK4212, "SMDK4212")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.timer		= &exynos4_timer,
+	.restart	= exynos4_restart,
 MACHINE_END
 
 MACHINE_START(SMDK4412, "SMDK4412")
@@ -303,4 +304,5 @@ MACHINE_START(SMDK4412, "SMDK4412")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdk4x12_machine_init,
 	.timer		= &exynos4_timer,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-smdkv310.c b/arch/arm/mach-exynos/mach-smdkv310.c
index c9e331e..5b36561 100644
--- a/arch/arm/mach-exynos/mach-smdkv310.c
+++ b/arch/arm/mach-exynos/mach-smdkv310.c
@@ -381,6 +381,7 @@ MACHINE_START(SMDKV310, "SMDKV310")
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve	= &smdkv310_reserve,
+	.restart	= exynos4_restart,
 MACHINE_END
 
 MACHINE_START(SMDKC210, "SMDKC210")
@@ -391,4 +392,5 @@ MACHINE_START(SMDKC210, "SMDKC210")
 	.handle_irq	= gic_handle_irq,
 	.init_machine	= smdkv310_machine_init,
 	.timer		= &exynos4_timer,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 7066f12..52aea97 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1064,4 +1064,5 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.init_machine	= universal_machine_init,
 	.timer		= &exynos4_timer,
 	.reserve        = &universal_reserve,
+	.restart	= exynos4_restart,
 MACHINE_END
diff --git a/arch/arm/plat-samsung/include/plat/reset.h b/arch/arm/plat-samsung/include/plat/reset.h
deleted file mode 100644
index 32ca517..0000000
--- a/arch/arm/plat-samsung/include/plat/reset.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/reset.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __PLAT_SAMSUNG_RESET_H
-#define __PLAT_SAMSUNG_RESET_H __FILE__
-
-extern void (*s5p_reset_hook)(void);
-
-#endif /* __PLAT_SAMSUNG_RESET_H */
diff --git a/arch/arm/plat-samsung/include/plat/system-reset.h b/arch/arm/plat-samsung/include/plat/system-reset.h
deleted file mode 100644
index a448e99..0000000
--- a/arch/arm/plat-samsung/include/plat/system-reset.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/system-reset.h
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * Based on arch/arm/mach-s3c2410/include/mach/system-reset.h
- *
- * S5P - System define for arch_reset()
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <plat/watchdog-reset.h>
-
-void (*s5p_reset_hook)(void);
-
-static void arch_reset(char mode, const char *cmd)
-{
-	/* SWRESET support in s5p_reset_hook() */
-
-	if (s5p_reset_hook)
-		s5p_reset_hook();
-
-	/* Perform reset using Watchdog reset
-	 * if there is no s5p_reset_hook()
-	 */
-
-	arch_wdt_reset();
-}
-- 
1.7.4.4
