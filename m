From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 15 Oct 2018 17:50:00 +0200
Subject: [PATCH v3] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
References: <CGME20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37@eucas1p2.samsung.com>
Message-ID: <20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37~d0vYKtP7-2027420274eucas1p2g@eucas1p2.samsung.com>
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
v3:
- don't move PM to the line below in Kconfig

v2:
- convert Exynos code to not require <plat/pm-common.h> header

Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
needed s3c_pm_check_*() calls".

 arch/arm/mach-exynos/suspend.c |   14 ++++----------
 arch/arm/plat-samsung/Kconfig  |    1 +
 2 files changed, 5 insertions(+), 10 deletions(-)

Index: b/arch/arm/mach-exynos/suspend.c
===================================================================
--- a/arch/arm/mach-exynos/suspend.c	2018-10-15 17:39:54.628412461 +0200
+++ b/arch/arm/mach-exynos/suspend.c	2018-10-15 17:39:54.624412461 +0200
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
--- a/arch/arm/plat-samsung/Kconfig	2018-10-15 17:39:54.628412461 +0200
+++ b/arch/arm/plat-samsung/Kconfig	2018-10-15 17:40:35.416413489 +0200
@@ -239,6 +239,7 @@ comment "Power management"
 config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
 	depends on PM && DEBUG_KERNEL
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
