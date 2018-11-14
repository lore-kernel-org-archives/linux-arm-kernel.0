From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 14 Nov 2018 16:30:58 +0100
Subject: [PATCH v4] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
References: <CGME20181114153100eucas1p1a48e0febdfacfe40dd08c91a6b0d045e@eucas1p1.samsung.com>
Message-ID: <f38311a0-ed37-49e6-cae1-62dfb30c7325@samsung.com>
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
v4:
- rebased on top of next-20181114

v3:
- don't move PM to the line below in Kconfig

v2:
- convert Exynos code to not require <plat/pm-common.h> header

 arch/arm/mach-exynos/suspend.c |   14 ++++----------
 arch/arm/plat-samsung/Kconfig  |    1 +
 2 files changed, 5 insertions(+), 10 deletions(-)

Index: b/arch/arm/mach-exynos/suspend.c
===================================================================
--- a/arch/arm/mach-exynos/suspend.c	2018-11-14 16:01:05.095080862 +0100
+++ b/arch/arm/mach-exynos/suspend.c	2018-11-14 16:03:36.699084680 +0100
@@ -30,8 +30,6 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
-#include <plat/pm-common.h>
-
 #include "common.h"
 
 #define REG_TABLE_END (-1U)
@@ -498,11 +496,9 @@ static int exynos_suspend_enter(suspend_
 	u32 eint_wakeup_mask = exynos_read_eint_wakeup_mask();
 	int ret;
 
-	s3c_pm_debug_init();
-
-	S3C_PMDBG("%s: suspending the system...\n", __func__);
+	pr_debug("%s: suspending the system...\n", __func__);
 
-	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
+	pr_debug("%s: wakeup masks: %08x,%08x\n", __func__,
 		  exynos_irqwake_intmask, eint_wakeup_mask);
 
 	if (exynos_irqwake_intmask == -1U
@@ -512,7 +508,6 @@ static int exynos_suspend_enter(suspend_
 		return -EINVAL;
 	}
 
-	s3c_pm_save_uarts();
 	if (pm_data->pm_prepare)
 		pm_data->pm_prepare();
 	flush_cache_all();
@@ -525,12 +520,11 @@ static int exynos_suspend_enter(suspend_
 
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
--- a/arch/arm/plat-samsung/Kconfig	2018-11-14 16:01:05.095080862 +0100
+++ b/arch/arm/plat-samsung/Kconfig	2018-11-14 16:01:05.055080861 +0100
@@ -239,6 +239,7 @@ comment "Power management"
 config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
 	depends on PM && DEBUG_KERNEL
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
