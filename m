From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 11 Mar 2015 12:08:41 +0100
Subject: [PATCH v4 3/3] ARM: EXYNOS: Remove left over 'extra_save'
In-Reply-To: <1426072121-6822-1-git-send-email-k.kozlowski@samsung.com>
References: <1426072121-6822-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1426072121-6822-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 32b0aa9aaeb4 ("ARM: EXYNOS: Remove i2c sys configuration related
code") the Exynos 5250 no longer saves additional registers under
'exynos_pm_data.extra_save' field.

No one else uses this code so get rid of it making also 'exynos_pm_data'
const everywhere.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---

Notes:
    Changes since v3:
    1. Add Pankaj's reviewed-by.
    
    Changes since v2:
    1. Remove also 'num_extra_save' field (suggested by Pankaj Dubey).
    
    Changes since v1:
    1. New patch.

 arch/arm/mach-exynos/suspend.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index d42fb1cd202d..6e5a3355ae81 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -63,8 +63,6 @@ static struct sleep_save exynos_core_save[] = {
 
 struct exynos_pm_data {
 	const struct exynos_wkup_irq *wkup_irq;
-	struct sleep_save *extra_save;
-	int num_extra_save;
 	unsigned int wake_disable_mask;
 	unsigned int *release_ret_regs;
 
@@ -75,7 +73,7 @@ struct exynos_pm_data {
 	int (*cpu_suspend)(unsigned long);
 };
 
-static struct exynos_pm_data *pm_data;
+static const struct exynos_pm_data *pm_data;
 
 static int exynos5420_cpu_state;
 static unsigned int exynos_pmu_spare3;
@@ -240,10 +238,6 @@ static void exynos_pm_prepare(void)
 
 	s3c_pm_do_save(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
-	 if (pm_data->extra_save)
-		s3c_pm_do_save(pm_data->extra_save,
-				pm_data->num_extra_save);
-
 	exynos_pm_enter_sleep_mode();
 
 	/* ensure at least INFORM0 has the resume address */
@@ -366,10 +360,6 @@ static void exynos_pm_resume(void)
 	/* For release retention */
 	exynos_pm_release_retention();
 
-	if (pm_data->extra_save)
-		s3c_pm_do_restore_core(pm_data->extra_save,
-					pm_data->num_extra_save);
-
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
 	if (cpuid == ARM_CPU_PART_CORTEX_A9)
@@ -622,7 +612,7 @@ void __init exynos_pm_init(void)
 		pr_err("Failed to find PMU node\n");
 		return;
 	}
-	pm_data = (struct exynos_pm_data *) match->data;
+	pm_data = (const struct exynos_pm_data *) match->data;
 
 	/* Platform-specific GIC callback */
 	gic_arch_extn.irq_set_wake = exynos_irq_set_wake;
-- 
1.9.1
