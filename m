From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 18 Jul 2014 16:36:33 +0200
Subject: [PATCH v2 2/2] clk: samsung: exynos3250: Enable ARMCLK down feature
In-Reply-To: <1405694193-29643-1-git-send-email-k.kozlowski@samsung.com>
References: <1405694193-29643-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1405694193-29643-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARMCLK down feature on Exynos3250 SoC. The frequency of
ARMCLK will be reduced upon entering idle mode (WFI or WFE).

The feature behaves like very fast cpufreq ondemand governor.

The patch uses simillar settings as Exynos5250 (clk-exynos5250.c),
except it disables clock up feature.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v1:
1. Add PWR_CTRL registers to the list of saved clk registers on
   Exynos3250. Suggested by Tomasz Figa.
2. Disable the clock up feature. (sug. Tomasz Figa)
3. Use macros for setting clock down ratio. (sug. Tomasz Figa)
---
 drivers/clk/samsung/clk-exynos3250.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 7a17bd40d1dd..a50dc88f0e8f 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -87,6 +87,22 @@
 #define SRC_CPU			0x14200
 #define DIV_CPU0		0x14500
 #define DIV_CPU1		0x14504
+#define PWR_CTRL1		0x15020
+#define PWR_CTRL2		0x15024
+
+/* Below definitions are used for PWR_CTRL settings */
+#define PWR_CTRL1_CORE2_DOWN_RATIO(x)		(((x) & 0x7) << 28)
+#define PWR_CTRL1_CORE1_DOWN_RATIO(x)		(((x) & 0x7) << 16)
+#define PWR_CTRL1_DIV2_DOWN_EN			(1 << 9)
+#define PWR_CTRL1_DIV1_DOWN_EN			(1 << 8)
+#define PWR_CTRL1_USE_CORE3_WFE			(1 << 7)
+#define PWR_CTRL1_USE_CORE2_WFE			(1 << 6)
+#define PWR_CTRL1_USE_CORE1_WFE			(1 << 5)
+#define PWR_CTRL1_USE_CORE0_WFE			(1 << 4)
+#define PWR_CTRL1_USE_CORE3_WFI			(1 << 3)
+#define PWR_CTRL1_USE_CORE2_WFI			(1 << 2)
+#define PWR_CTRL1_USE_CORE1_WFI			(1 << 1)
+#define PWR_CTRL1_USE_CORE0_WFI			(1 << 0)
 
 /* list of PLLs to be registered */
 enum exynos3250_plls {
@@ -168,6 +184,8 @@ static unsigned long exynos3250_cmu_clk_regs[] __initdata = {
 	SRC_CPU,
 	DIV_CPU0,
 	DIV_CPU1,
+	PWR_CTRL1,
+	PWR_CTRL2,
 };
 
 static int exynos3250_clk_suspend(void)
@@ -748,6 +766,27 @@ static struct samsung_pll_clock exynos3250_plls[nr_plls] __initdata = {
 			UPLL_LOCK, UPLL_CON0, NULL),
 };
 
+static void __init exynos3_core_down_clock(void)
+{
+	unsigned int tmp;
+
+	/*
+	 * Enable arm clock down (in idle) and set arm divider
+	 * ratios in WFI/WFE state.
+	 */
+	tmp = (PWR_CTRL1_CORE2_DOWN_RATIO(7) | PWR_CTRL1_CORE1_DOWN_RATIO(7) |
+		PWR_CTRL1_DIV2_DOWN_EN | PWR_CTRL1_DIV1_DOWN_EN |
+		PWR_CTRL1_USE_CORE1_WFE | PWR_CTRL1_USE_CORE0_WFE |
+		PWR_CTRL1_USE_CORE1_WFI | PWR_CTRL1_USE_CORE0_WFI);
+	__raw_writel(tmp, reg_base + PWR_CTRL1);
+
+	/*
+	 * Disable the clock up feature on Exynos4x12, in case it was
+	 * enabled by bootloader.
+	 */
+	__raw_writel(0x0, reg_base + PWR_CTRL2);
+}
+
 static void __init exynos3250_cmu_init(struct device_node *np)
 {
 	struct samsung_clk_provider *ctx;
@@ -775,6 +814,8 @@ static void __init exynos3250_cmu_init(struct device_node *np)
 	samsung_clk_register_div(ctx, div_clks, ARRAY_SIZE(div_clks));
 	samsung_clk_register_gate(ctx, gate_clks, ARRAY_SIZE(gate_clks));
 
+	exynos3_core_down_clock();
+
 	exynos3250_clk_sleep_init();
 }
 CLK_OF_DECLARE(exynos3250_cmu, "samsung,exynos3250-cmu", exynos3250_cmu_init);
-- 
1.9.1
