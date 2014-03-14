From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 14 Mar 2014 18:23:54 +0530
Subject: [PATCH 1/1] clk: exynos5420: Register APLL rate table
Message-ID: <1394801634-887-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register APLL rate table in Exynos5420 clock driver.
Will be required for the CPUFreq driver.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5420.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 7fd6bea467fd..358513724adc 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -775,6 +775,30 @@ static struct of_device_id ext_clk_match[] __initdata = {
 	{ },
 };
 
+static const struct samsung_pll_rate_table apll_24mhz_tbl[] = {
+	/* sorted in descending order */
+	/* PLL_35XX_RATE(rate, m, p, s) */
+	PLL_35XX_RATE(2000000000, 250, 3, 0),
+	PLL_35XX_RATE(1900000000, 475, 6, 0),
+	PLL_35XX_RATE(1800000000, 225, 3, 0),
+	PLL_35XX_RATE(1700000000, 425, 6, 0),
+	PLL_35XX_RATE(1600000000, 200, 3, 0),
+	PLL_35XX_RATE(1500000000, 250, 4, 0),
+	PLL_35XX_RATE(1400000000, 175, 3, 0),
+	PLL_35XX_RATE(1300000000, 325, 6, 0),
+	PLL_35XX_RATE(1200000000, 200, 2, 1),
+	PLL_35XX_RATE(1100000000, 275, 3, 1),
+	PLL_35XX_RATE(1000000000, 250, 3, 1),
+	PLL_35XX_RATE(900000000, 150, 2, 1),
+	PLL_35XX_RATE(800000000, 200, 3, 1),
+	PLL_35XX_RATE(700000000, 175, 3, 1),
+	PLL_35XX_RATE(600000000, 200, 2, 2),
+	PLL_35XX_RATE(500000000, 250, 3, 2),
+	PLL_35XX_RATE(400000000, 200, 3, 2),
+	PLL_35XX_RATE(300000000, 200, 2, 3),
+	PLL_35XX_RATE(200000000, 200, 3, 3),
+};
+
 /* register exynos5420 clocks */
 static void __init exynos5420_clk_init(struct device_node *np)
 {
@@ -790,6 +814,10 @@ static void __init exynos5420_clk_init(struct device_node *np)
 	samsung_clk_of_register_fixed_ext(exynos5420_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5420_fixed_rate_ext_clks),
 			ext_clk_match);
+
+	if (_get_rate("fin_pll") == 24 * MHZ)
+		exynos5420_plls[apll].rate_table = apll_24mhz_tbl;
+
 	samsung_clk_register_pll(exynos5420_plls, ARRAY_SIZE(exynos5420_plls),
 					reg_base);
 	samsung_clk_register_fixed_rate(exynos5420_fixed_rate_clks,
-- 
1.7.9.5
