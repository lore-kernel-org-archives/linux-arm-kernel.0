From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 12:40:05 +0200
Subject: [PATCH V5 10/20] ARM: exynos: cpuidle: Remove ifdef for scu_enable
In-Reply-To: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397212815-16068-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The scu_enable function is already a noop in the scu's header file is
CONFIG_SMP=n, so no need to use these macros in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/pm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index aba577f..9773a00 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -244,7 +244,7 @@ static void exynos_pm_resume(void)
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (IS_ENABLED(CONFIG_SMP) && !soc_is_exynos5250())
+	if (!soc_is_exynos5250())
 		scu_enable(S5P_VA_SCU);
 
 early_wakeup:
@@ -336,10 +336,8 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 
 	case CPU_PM_EXIT:
 		if (cpu == 0) {
-#ifdef CONFIG_SMP
 			if (!soc_is_exynos5250())
 				scu_enable(S5P_VA_SCU);
-#endif
 			exynos_cpu_restore_register();
 		}
 		break;
-- 
1.7.9.5
