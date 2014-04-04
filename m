From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:47:55 +0200
Subject: [PATCH 09/17] ARM: exynos: cpuidle: Remove ifdef for scu_enable
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-10-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The scu_enable function is already a noop in the scu's header file is
CONFIG_SMP=n, so no need to use these macros in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/pm.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index f43a004..c0d8640 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -363,10 +363,7 @@ static void exynos_pm_resume(void)
 
 	if (!soc_is_exynos5250()) {
 		exynos4_restore_pll();
-
-#ifdef CONFIG_SMP
 		scu_enable(S5P_VA_SCU);
-#endif
 	}
 
 early_wakeup:
@@ -386,9 +383,7 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 		break;
 
 	case CPU_PM_EXIT:
-#ifdef CONFIG_SMP
 		scu_enable(S5P_VA_SCU);
-#endif
 		exynos_cpu_restore_register();
 		break;
 	}
-- 
1.7.9.5
