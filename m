From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Fri, 11 Oct 2013 11:12:14 +0530
Subject: [PATCH V2] ARM: EXYNOS: Move arm core power down clock to exynos5250
 common clock
Message-ID: <1381470134-29410-1-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now with common clock support added for exynos5250 it is necessary to move
this code to exynos5250 common clock driver as clock registers should be
handled there. This change is tested in exynos5250 based arndale platform.

Cc: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Kukjin Kim <kgene.kim@samsugn.com>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---

Changes in V2:
* Rebased against linux-next tree.
* Removed un-used macros in regs-clock.h

 arch/arm/mach-exynos/cpuidle.c                 |   35 --------------------
 arch/arm/mach-exynos/include/mach/regs-clock.h |   16 ---------
 drivers/clk/samsung/clk-exynos5250.c           |   42 ++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 1bde6ad..40963ce 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -161,46 +161,11 @@ static int exynos4_enter_lowpower(struct cpuidle_device *dev,
 		return exynos4_enter_core0_aftr(dev, drv, new_index);
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
 static int __init exynos_cpuidle_probe(struct platform_device *pdev)
 {
 	int cpu_id, ret;
 	struct cpuidle_device *device;
 
-	if (soc_is_exynos5250())
-		exynos5_core_down_clk();
-
 	if (soc_is_exynos5440())
 		exynos4_idle_driver.state_count = 1;
 
diff --git a/arch/arm/mach-exynos/include/mach/regs-clock.h b/arch/arm/mach-exynos/include/mach/regs-clock.h
index d36ad76..b59b0ad 100644
--- a/arch/arm/mach-exynos/include/mach/regs-clock.h
+++ b/arch/arm/mach-exynos/include/mach/regs-clock.h
@@ -347,22 +347,6 @@
 
 #define EXYNOS5_EPLLCON0_LOCKED_SHIFT		(29)
 
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
 /* Compatibility defines and inclusion */
 
 #include <mach/regs-pmu.h>
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index adf3234..07f2f46 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -22,6 +22,8 @@
 #define APLL_CON0		0x100
 #define SRC_CPU			0x200
 #define DIV_CPU0		0x500
+#define PWR_CTRL1		0x1020
+#define PWR_CTRL2		0x1024
 #define MPLL_LOCK		0x4000
 #define MPLL_CON0		0x4100
 #define SRC_CORE1		0x4204
@@ -77,6 +79,23 @@
 #define GATE_IP_DISP1		0x10928
 #define GATE_IP_ACP		0x10000
 
+/*Below definitions are used for PWR_CTRL settings*/
+#define PWR_CTRL1_CORE2_DOWN_RATIO		(7 << 28)
+#define PWR_CTRL1_CORE1_DOWN_RATIO		(7 << 16)
+#define PWR_CTRL1_DIV2_DOWN_EN			(1 << 9)
+#define PWR_CTRL1_DIV1_DOWN_EN			(1 << 8)
+#define PWR_CTRL1_USE_CORE1_WFE			(1 << 5)
+#define PWR_CTRL1_USE_CORE0_WFE			(1 << 4)
+#define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
+#define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
+
+#define PWR_CTRL2_DIV2_UP_EN			(1 << 25)
+#define PWR_CTRL2_DIV1_UP_EN			(1 << 24)
+#define PWR_CTRL2_DUR_STANDBY2_VAL		(1 << 16)
+#define PWR_CTRL2_DUR_STANDBY1_VAL		(1 << 8)
+#define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
+#define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
+
 /* list of PLLs to be registered */
 enum exynos5250_plls {
 	apll, mpll, cpll, epll, vpll, gpll, bpll,
@@ -135,6 +154,8 @@ enum exynos5250_clks {
 static unsigned long exynos5250_clk_regs[] __initdata = {
 	SRC_CPU,
 	DIV_CPU0,
+	PWR_CTRL1,
+	PWR_CTRL2,
 	SRC_CORE1,
 	SRC_TOP0,
 	SRC_TOP2,
@@ -543,6 +564,7 @@ static struct of_device_id ext_clk_match[] __initdata = {
 static void __init exynos5250_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
+	unsigned int tmp;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -580,6 +602,26 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_register_gate(exynos5250_gate_clks,
 			ARRAY_SIZE(exynos5250_gate_clks));
 
+	/*
+	 * Enable arm clock down (in idle) and set arm divider
+	 * ratios in WFI/WFE state.
+	 */
+	tmp = (PWR_CTRL1_CORE2_DOWN_RATIO | PWR_CTRL1_CORE1_DOWN_RATIO |
+		PWR_CTRL1_DIV2_DOWN_EN | PWR_CTRL1_DIV1_DOWN_EN |
+		PWR_CTRL1_USE_CORE1_WFE | PWR_CTRL1_USE_CORE0_WFE |
+		PWR_CTRL1_USE_CORE1_WFI | PWR_CTRL1_USE_CORE0_WFI);
+	__raw_writel(tmp, reg_base + PWR_CTRL1);
+
+	/*
+	 * Enable arm clock up (on exiting idle). Set arm divider
+	 * ratios when not in idle along with the standby duration
+	 * ratios.
+	 */
+	tmp = (PWR_CTRL2_DIV2_UP_EN | PWR_CTRL2_DIV1_UP_EN |
+		PWR_CTRL2_DUR_STANDBY2_VAL | PWR_CTRL2_DUR_STANDBY1_VAL |
+		PWR_CTRL2_CORE2_UP_RATIO | PWR_CTRL2_CORE1_UP_RATIO);
+	__raw_writel(tmp, reg_base + PWR_CTRL2);
+
 	pr_info("Exynos5250: clock setup completed, armclk=%ld\n",
 			_get_rate("armclk"));
 }
-- 
1.7.1
