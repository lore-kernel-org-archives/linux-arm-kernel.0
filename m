From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 09:47:59 +0200
Subject: [PATCH 13/17] ARM: exynos: cpuidle: Move clock setup to pm.c
In-Reply-To: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
References: <1396597683-6969-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1396597683-6969-14-git-send-email-daniel.lezcano@linaro.org>
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
---
 arch/arm/mach-exynos/cpuidle.c |   54 ---------------------------------------
 arch/arm/mach-exynos/pm.c      |   55 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 839185e..3872c1e 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -38,25 +38,6 @@
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
 
@@ -98,38 +79,6 @@ static int exynos_enter_lowpower(struct cpuidle_device *dev,
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
@@ -152,9 +101,6 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	if (soc_is_exynos5250())
-		exynos5_core_down_clk();
-
 	if (soc_is_exynos5440())
 		exynos_idle_driver.state_count = 1;
 
diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index b364212..1c9d253 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -60,6 +60,25 @@
 
 #define EXYNOS4210_CLKSRC_MASK_LCD1		(S5P_VA_CMU + 0x0C338)
 
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
 static const struct sleep_save exynos4_set_clksrc[] = {
 	{ .reg = EXYNOS4_CLKSRC_MASK_TOP		, .val = 0x00000001, },
 	{ .reg = EXYNOS4_CLKSRC_MASK_CAM		, .val = 0x11111111, },
@@ -99,7 +118,6 @@ static struct sleep_save exynos_core_save[] = {
 	SAVE_ITEM(S5P_SROM_BC3),
 };
 
-
 /* For Cortex-A9 Diagnostic and Power control register */
 static unsigned int save_arm_register[2];
 
@@ -139,6 +157,38 @@ static void exynos_cpu_restore_register(void)
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
@@ -425,6 +475,9 @@ static __init int exynos_pm_syscore_init(void)
 	if (soc_is_exynos5440())
 		return 0;
 
+	if (soc_is_exynos5250())
+		exynos5_core_down_clk();
+
 	if (!soc_is_exynos5250())
 		cpu_pm_register_notifier(&exynos_cpu_pm_notifier_block);
 
-- 
1.7.9.5
