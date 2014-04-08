From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue,  8 Apr 2014 14:19:35 +0200
Subject: [PATCH V3 13/17] ARM: exynos: cpuidle: Move clock setup to pm.c
In-Reply-To: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396959579-18268-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more step is moving the clock ratio setting at idle time in pm.c

The macro names have been changed to be consistent with the other macros
name in the file.

Note, the clock divider was working only when cpuidle was enabled because it
was in its init routine. With this change, the clock divider is set in the pm's
init routine, so it will also operate when the cpuidle driver is not set, which
is good.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c  |   54 ---------------------------------------
 arch/arm/mach-exynos/pm.c       |   35 +++++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h |   19 ++++++++++++++
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index cd27dbf..44d169b 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -37,25 +37,6 @@
 			S5P_INFORM6 : (samsung_rev() == EXYNOS4210_REV_1_0 ? \
 			(S5P_VA_SYSRAM + 0x20) : S5P_INFORM1))
 
-#define EXYNOS5_PWR_CTRL1			(S5P_VA_CMU + 0x01020)
-#define EXYNOS5_PWR_CTRL2			(S5P_VA_CMU + 0x01024)
-
-#define PWR_CTRL1_CORE2_DOWN_RATIO		(7 << 28)
-#define PWR_CTRL1_CORE1_DOWN_RATIO		(7 << 16)
-#define PWR_CTRL1_DIV2_DOWN_EN			(1 << 9)
-#define PWR_CTRL1_DIV1_DOWN_EN			(1 << 8)
-#define PWR_CTRL1_USE_CORE1_WFE			(1 << 5)
-#define PWR_CTRL1_USE_CORE0_WFE			(1 << 4)
-#define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
-#define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
-
-#define PWR_CTRL2_DIV2_UP_EN			(1 << 25)
-#define PWR_CTRL2_DIV1_UP_EN			(1 << 24)
-#define PWR_CTRL2_DUR_STANDBY2_VAL		(1 << 16)
-#define PWR_CTRL2_DUR_STANDBY1_VAL		(1 << 8)
-#define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
-#define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
-
 static int idle_finisher(unsigned long flags)
 {
 
@@ -97,38 +78,6 @@ static int exynos_enter_lowpower(struct cpuidle_device *dev,
 		return exynos_enter_core0_aftr(dev, drv, new_index);
 }
 
-static void __init exynos5_core_down_clk(void)
-{
-	unsigned int tmp;
-
-	/*
-	 * Enable arm clock down (in idle) and set arm divider
-	 * ratios in WFI/WFE state.
-	 */
-	tmp = PWR_CTRL1_CORE2_DOWN_RATIO | \
-	      PWR_CTRL1_CORE1_DOWN_RATIO | \
-	      PWR_CTRL1_DIV2_DOWN_EN	 | \
-	      PWR_CTRL1_DIV1_DOWN_EN	 | \
-	      PWR_CTRL1_USE_CORE1_WFE	 | \
-	      PWR_CTRL1_USE_CORE0_WFE	 | \
-	      PWR_CTRL1_USE_CORE1_WFI	 | \
-	      PWR_CTRL1_USE_CORE0_WFI;
-	__raw_writel(tmp, EXYNOS5_PWR_CTRL1);
-
-	/*
-	 * Enable arm clock up (on exiting idle). Set arm divider
-	 * ratios when not in idle along with the standby duration
-	 * ratios.
-	 */
-	tmp = PWR_CTRL2_DIV2_UP_EN	 | \
-	      PWR_CTRL2_DIV1_UP_EN	 | \
-	      PWR_CTRL2_DUR_STANDBY2_VAL | \
-	      PWR_CTRL2_DUR_STANDBY1_VAL | \
-	      PWR_CTRL2_CORE2_UP_RATIO	 | \
-	      PWR_CTRL2_CORE1_UP_RATIO;
-	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
-}
-
 static struct cpuidle_driver exynos_idle_driver = {
 	.name			= "exynos_idle",
 	.owner			= THIS_MODULE,
@@ -151,9 +100,6 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	if (soc_is_exynos5250())
-		exynos5_core_down_clk();
-
 	if (soc_is_exynos5440())
 		exynos_idle_driver.state_count = 1;
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index 0e73591..90fb692 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -140,6 +140,38 @@ static void exynos_cpu_restore_register(void)
 		      : "cc");
 }
 
+static void __init exynos5_core_down_clk(void)
+{
+	unsigned int tmp;
+
+	/*
+	 * Enable arm clock down (in idle) and set arm divider
+	 * ratios in WFI/WFE state.
+	 */
+	tmp = EXYNOS5_PWR_CTRL1_CORE2_DOWN_RATIO | \
+	      EXYNOS5_PWR_CTRL1_CORE1_DOWN_RATIO | \
+	      EXYNOS5_PWR_CTRL1_DIV2_DOWN_EN	 | \
+	      EXYNOS5_PWR_CTRL1_DIV1_DOWN_EN	 | \
+	      EXYNOS5_PWR_CTRL1_USE_CORE1_WFE	 | \
+	      EXYNOS5_PWR_CTRL1_USE_CORE0_WFE	 | \
+	      EXYNOS5_PWR_CTRL1_USE_CORE1_WFI	 | \
+	      EXYNOS5_PWR_CTRL1_USE_CORE0_WFI;
+	__raw_writel(tmp, EXYNOS5_PWR_CTRL1);
+
+	/*
+	 * Enable arm clock up (on exiting idle). Set arm divider
+	 * ratios when not in idle along with the standby duration
+	 * ratios.
+	 */
+	tmp = EXYNOS5_PWR_CTRL2_DIV2_UP_EN	 | \
+	      EXYNOS5_PWR_CTRL2_DIV1_UP_EN	 | \
+	      EXYNOS5_PWR_CTRL2_DUR_STANDBY2_VAL | \
+	      EXYNOS5_PWR_CTRL2_DUR_STANDBY1_VAL | \
+	      EXYNOS5_PWR_CTRL2_CORE2_UP_RATIO	 | \
+	      EXYNOS5_PWR_CTRL2_CORE1_UP_RATIO;
+	__raw_writel(tmp, EXYNOS5_PWR_CTRL2);
+}
+
 static int exynos_cpu_suspend(unsigned long arg)
 {
 #ifdef CONFIG_CACHE_L2X0
@@ -256,6 +288,9 @@ static void exynos_pm_resume(void)
 
 	s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
 
+	if (soc_is_exynos5250())
+		exynos5_core_down_clk();
+
 	if (!soc_is_exynos5250())
 		scu_enable(S5P_VA_SCU);
 
diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
index 09c43c3..ba5f038 100644
--- a/arch/arm/mach-exynos/regs-pmu.h
+++ b/arch/arm/mach-exynos/regs-pmu.h
@@ -314,4 +314,23 @@
 
 #define EXYNOS5_OPTION_USE_RETENTION				(1 << 4)
 
+#define EXYNOS5_PWR_CTRL1			(S5P_VA_CMU + 0x01020)
+#define EXYNOS5_PWR_CTRL2			(S5P_VA_CMU + 0x01024)
+
+#define EXYNOS5_PWR_CTRL1_CORE2_DOWN_RATIO	(7 << 28)
+#define EXYNOS5_PWR_CTRL1_CORE1_DOWN_RATIO	(7 << 16)
+#define EXYNOS5_PWR_CTRL1_DIV2_DOWN_EN		(1 << 9)
+#define EXYNOS5_PWR_CTRL1_DIV1_DOWN_EN		(1 << 8)
+#define EXYNOS5_PWR_CTRL1_USE_CORE1_WFE		(1 << 5)
+#define EXYNOS5_PWR_CTRL1_USE_CORE0_WFE		(1 << 4)
+#define EXYNOS5_PWR_CTRL1_USE_CORE1_WFI		(1 << 1)
+#define EXYNOS5_PWR_CTRL1_USE_CORE0_WFI		(1 << 0)
+
+#define EXYNOS5_PWR_CTRL2_DIV2_UP_EN		(1 << 25)
+#define EXYNOS5_PWR_CTRL2_DIV1_UP_EN		(1 << 24)
+#define EXYNOS5_PWR_CTRL2_DUR_STANDBY2_VAL	(1 << 16)
+#define EXYNOS5_PWR_CTRL2_DUR_STANDBY1_VAL	(1 << 8)
+#define EXYNOS5_PWR_CTRL2_CORE2_UP_RATIO	(1 << 4)
+#define EXYNOS5_PWR_CTRL2_CORE1_UP_RATIO	(1 << 0)
+
 #endif /* __ASM_ARCH_REGS_PMU_H */
-- 
1.7.9.5
