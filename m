From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:47:54 +0200
Subject: [PATCH 08/17] ARM: exynos: cpuidle: Move scu_enable in the cpu_pm
 notifier
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We make the cpuidle code less arch dependent.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    6 ------
 arch/arm/mach-exynos/pm.c      |    3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 4b090cf..c63ad05 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -18,7 +18,6 @@
 #include <linux/platform_device.h>
 
 #include <asm/proc-fns.h>
-#include <asm/smp_scu.h>
 #include <asm/suspend.h>
 #include <asm/unified.h>
 #include <asm/cpuidle.h>
@@ -94,11 +93,6 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
 
 	cpu_pm_enter();
 	cpu_suspend(0, idle_finisher);
-
-#ifdef CONFIG_SMP
-	if (!soc_is_exynos5250())
-		scu_enable(S5P_VA_SCU);
-#endif
 	cpu_pm_exit();
 
 	/*
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index b2a075e..f43a004 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -386,6 +386,9 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 		break;
 
 	case CPU_PM_EXIT:
+#ifdef CONFIG_SMP
+		scu_enable(S5P_VA_SCU);
+#endif
 		exynos_cpu_restore_register();
 		break;
 	}
-- 
1.7.9.5
