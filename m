From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 15 Oct 2018 15:50:54 +0200
Subject: [PATCH v2] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
References: <CGME20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677@eucas1p2.samsung.com>
Message-ID: <20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677~dzHYfFW2j0676906769eucas1p2c@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
config option) is not working properly (debug messages are not
displayed after resume) on Exynos platforms because GPIOs restore
code is not implemented.

Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
Then convert Exynos code to not require <plat/pm-common.h>
header (use pr_debug() directly instead of S3C_PMDBG() macro and
remove redundant s3c_pm_*() calls).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- convert Exynos code to not require <plat/pm-common.h> header

Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
needed s3c_pm_check_*() calls".

 arch/arm/mach-exynos/suspend.c |   14 ++++----------
 arch/arm/plat-samsung/Kconfig  |    3 ++-
 2 files changed, 6 insertions(+), 11 deletions(-)

Index: b/arch/arm/mach-exynos/suspend.c
===================================================================
--- a/arch/arm/mach-exynos/suspend.c	2018-10-15 15:11:15.296187842 +0200
+++ b/arch/arm/mach-exynos/suspend.c	2018-10-15 15:22:54.656205454 +0200
@@ -30,8 +30,6 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
-#include <plat/pm-common.h>
-
 #include "common.h"
 
 #define REG_TABLE_END (-1U)
@@ -490,11 +488,9 @@ static int exynos_suspend_enter(suspend_
 {
 	int ret;
 
-	s3c_pm_debug_init();
-
-	S3C_PMDBG("%s: suspending the system...\n", __func__);
+	pr_debug("%s: suspending the system...\n", __func__);
 
-	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
+	pr_debug("%s: wakeup masks: %08x,%08x\n", __func__,
 			exynos_irqwake_intmask, exynos_get_eint_wake_mask());
 
 	if (exynos_irqwake_intmask == -1U
@@ -504,7 +500,6 @@ static int exynos_suspend_enter(suspend_
 		return -EINVAL;
 	}
 
-	s3c_pm_save_uarts();
 	if (pm_data->pm_prepare)
 		pm_data->pm_prepare();
 	flush_cache_all();
@@ -517,12 +512,11 @@ static int exynos_suspend_enter(suspend_
 
 	if (pm_data->pm_resume_prepare)
 		pm_data->pm_resume_prepare();
-	s3c_pm_restore_uarts();
 
-	S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
+	pr_debug("%s: wakeup stat: %08x\n", __func__,
 			pmu_raw_readl(S5P_WAKEUP_STAT));
 
-	S3C_PMDBG("%s: resuming the system...\n", __func__);
+	pr_debug("%s: resuming the system...\n", __func__);
 
 	return 0;
 }
Index: b/arch/arm/plat-samsung/Kconfig
===================================================================
--- a/arch/arm/plat-samsung/Kconfig	2018-10-15 15:16:22.804195586 +0200
+++ b/arch/arm/plat-samsung/Kconfig	2018-10-15 15:16:22.800195586 +0200
@@ -238,7 +238,8 @@ comment "Power management"
 
 config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
-	depends on PM && DEBUG_KERNEL
+	depends on DEBUG_KERNEL
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
 	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
