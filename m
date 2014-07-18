From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 18 Jul 2014 11:53:05 +0200
Subject: [PATCH 1/2] clk: samsung: exynos4x12: Enable ARMCLK down feature
Message-ID: <1405677186-18678-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARMCLK down and up features on Exynos4212 and 4412 SoCs. The
frequency of ARMCLK will be reduced upon entering idle mode (WFI or
WFE).  Additionally upon exiting from idle mode the divider for ARMCLK
will be brought back to 1.

These are exactly the same settings as for Exynos5250
(clk-exynos5250.c), except of Exynos4412 where ARMCLK down is enabled
for all 4 cores.

Tested on Trats2 board (Exynos4412) and Samsung Gear 1 (Exynos4212).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 7f4a473a7ad7..b8ea37b23984 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -114,11 +114,34 @@
 #define DIV_CPU1		0x14504
 #define GATE_SCLK_CPU		0x14800
 #define GATE_IP_CPU		0x14900
+#define PWR_CTRL1		0x15020
+#define PWR_CTRL2		0x15024
 #define E4X12_DIV_ISP0		0x18300
 #define E4X12_DIV_ISP1		0x18304
 #define E4X12_GATE_ISP0		0x18800
 #define E4X12_GATE_ISP1		0x18804
 
+/* Below definitions are used for PWR_CTRL settings */
+#define PWR_CTRL1_CORE2_DOWN_RATIO		(7 << 28)
+#define PWR_CTRL1_CORE1_DOWN_RATIO		(7 << 16)
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
+
+#define PWR_CTRL2_DIV2_UP_EN			(1 << 25)
+#define PWR_CTRL2_DIV1_UP_EN			(1 << 24)
+#define PWR_CTRL2_DUR_STANDBY2_VAL		(1 << 16)
+#define PWR_CTRL2_DUR_STANDBY1_VAL		(1 << 8)
+#define PWR_CTRL2_CORE2_UP_RATIO		(1 << 4)
+#define PWR_CTRL2_CORE1_UP_RATIO		(1 << 0)
+
 /* the exynos4 soc type */
 enum exynos4_soc {
 	EXYNOS4210,
@@ -1164,6 +1187,34 @@ static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
 			VPLL_LOCK, VPLL_CON0, NULL),
 };
 
+static void __init exynos4_core_down_clock(void)
+{
+	unsigned int tmp;
+
+	/*
+	 * Enable arm clock down (in idle) and set arm divider
+	 * ratios in WFI/WFE state.
+	 */
+	tmp = (PWR_CTRL1_CORE2_DOWN_RATIO | PWR_CTRL1_CORE1_DOWN_RATIO |
+		PWR_CTRL1_DIV2_DOWN_EN | PWR_CTRL1_DIV1_DOWN_EN |
+		PWR_CTRL1_USE_CORE1_WFE | PWR_CTRL1_USE_CORE0_WFE |
+		PWR_CTRL1_USE_CORE1_WFI | PWR_CTRL1_USE_CORE0_WFI);
+	if (of_machine_is_compatible("samsung,exynos4412"))
+		tmp |= PWR_CTRL1_USE_CORE3_WFE | PWR_CTRL1_USE_CORE2_WFE |
+		       PWR_CTRL1_USE_CORE3_WFI | PWR_CTRL1_USE_CORE2_WFI;
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
+}
+
 /* register exynos4 clocks */
 static void __init exynos4_clk_init(struct device_node *np,
 				    enum exynos4_soc soc)
@@ -1250,6 +1301,8 @@ static void __init exynos4_clk_init(struct device_node *np,
 	samsung_clk_register_alias(ctx, exynos4_aliases,
 			ARRAY_SIZE(exynos4_aliases));
 
+	if (exynos4_soc == EXYNOS4X12)
+		exynos4_core_down_clock();
 	exynos4_clk_sleep_init();
 
 	pr_info("%s clocks: sclk_apll = %ld, sclk_mpll = %ld\n"
-- 
1.9.1
