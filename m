From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 24 Jul 2018 18:49:44 +0200
Subject: [PATCH v2 2/4] ARM: exynos: Store Exynos5420 register state in one
 variable
In-Reply-To: <20180724164946.6274-1-krzk@kernel.org>
References: <20180724164946.6274-1-krzk@kernel.org>
Message-ID: <20180724164946.6274-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of keeping two static variables put them into one struct which
later can grow.  This will reduce number of file-scope symbols.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
New patch.
---
 arch/arm/mach-exynos/suspend.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index d3db306a5a70..5d4822e5d0ba 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -59,10 +59,14 @@ struct exynos_pm_data {
 	int (*cpu_suspend)(unsigned long);
 };
 
-static const struct exynos_pm_data *pm_data __ro_after_init;
+/* Used only on Exynos542x/5800 */
+struct exynos_pm_state {
+	int cpu_state;
+	unsigned int pmu_spare3;
+};
 
-static int exynos5420_cpu_state;
-static unsigned int exynos_pmu_spare3;
+static const struct exynos_pm_data *pm_data __ro_after_init;
+static struct exynos_pm_state pm_state;
 
 /*
  * GIC wake-up support
@@ -320,7 +324,7 @@ static void exynos5420_pm_prepare(void)
 	/* Set wake-up mask registers */
 	exynos_pm_set_wakeup_mask();
 
-	exynos_pmu_spare3 = pmu_raw_readl(S5P_PMU_SPARE3);
+	pm_state.pmu_spare3 = pmu_raw_readl(S5P_PMU_SPARE3);
 	/*
 	 * The cpu state needs to be saved and restored so that the
 	 * secondary CPUs will enter low power start. Though the U-Boot
@@ -328,8 +332,8 @@ static void exynos5420_pm_prepare(void)
 	 * needs to restore it back in case, the primary cpu fails to
 	 * suspend for any reason.
 	 */
-	exynos5420_cpu_state = readl_relaxed(sysram_base_addr +
-					     EXYNOS5420_CPU_STATE);
+	pm_state.cpu_state = readl_relaxed(sysram_base_addr +
+					   EXYNOS5420_CPU_STATE);
 
 	exynos_pm_enter_sleep_mode();
 
@@ -447,7 +451,7 @@ static void exynos5420_pm_resume(void)
 		       EXYNOS5_ARM_CORE0_SYS_PWR_REG);
 
 	/* Restore the sysram cpu state register */
-	writel_relaxed(exynos5420_cpu_state,
+	writel_relaxed(pm_state.cpu_state,
 		       sysram_base_addr + EXYNOS5420_CPU_STATE);
 
 	pmu_raw_writel(EXYNOS5420_USE_STANDBY_WFI_ALL,
@@ -456,7 +460,7 @@ static void exynos5420_pm_resume(void)
 	if (exynos_pm_central_resume())
 		goto early_wakeup;
 
-	pmu_raw_writel(exynos_pmu_spare3, S5P_PMU_SPARE3);
+	pmu_raw_writel(pm_state.pmu_spare3, S5P_PMU_SPARE3);
 
 early_wakeup:
 
-- 
2.14.1
