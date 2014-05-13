From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 17:32:00 +0530
Subject: [PATCH v4 2/4] arm: exynos: Modify code to check for cortex A9 rather
 than the SoC
In-Reply-To: <1399982522-27928-1-git-send-email-a.kesavan@samsung.com>
References: <1399982522-27928-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1399982522-27928-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have an soc check to ensure that the scu and certain A9 specific
registers are not accessed on Exynos5250 (which is A15 based).

Rather than adding another soc specific check for 5420 let us test
for the Cortex A9 primary part number.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/pm.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 5effd38..95f8086 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -248,7 +248,7 @@ static int exynos_pm_suspend(void)
 	tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
 	regmap_write(pmu_regmap, S5P_CENTRAL_SEQ_OPTION, tmp);
 
-	if (!soc_is_exynos5250())
+	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
 		exynos_cpu_save_register();
 
 	return 0;
@@ -282,7 +282,7 @@ static void exynos_pm_resume(void)
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	if (!soc_is_exynos5250())
+	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
 		exynos_cpu_restore_register();
 
 	/* For release retention */
@@ -301,7 +301,7 @@ static void exynos_pm_resume(void)
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	if (!soc_is_exynos5250())
+	if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
 		scu_enable(S5P_VA_SCU);
 
 early_wakeup:
@@ -388,15 +388,18 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
 	case CPU_PM_ENTER:
 		if (cpu == 0) {
 			exynos_pm_central_suspend();
-			exynos_cpu_save_register();
+			if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
+				exynos_cpu_save_register();
 		}
 		break;
 
 	case CPU_PM_EXIT:
 		if (cpu == 0) {
-			if (!soc_is_exynos5250())
+			if (read_cpuid_part_number() ==
+					ARM_CPU_PART_CORTEX_A9) {
 				scu_enable(S5P_VA_SCU);
-			exynos_cpu_restore_register();
+				exynos_cpu_restore_register();
+			}
 			exynos_pm_central_resume();
 		}
 		break;
-- 
1.7.9.5
