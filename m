From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri,  8 Nov 2013 15:44:08 +0530
Subject: [PATCH 3/3] clk: exynos5250: register APLL rate table
In-Reply-To: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1383905648-23733-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

Register the APLL rate table so that we can set the APLL rate from
the cpufreq driver.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 986464c2339a..80f652053cb5 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -667,6 +667,27 @@ static struct samsung_pll_rate_table epll_24mhz_tbl[] __initdata = {
 	{ },
 };
 
+static struct samsung_pll_rate_table apll_24mhz_tbl[] __initdata = {
+	/* sorted in descending order */
+	/* PLL_35XX_RATE(rate, m, p, s) */
+	PLL_35XX_RATE(1700000000, 425, 6, 0),
+	PLL_35XX_RATE(1600000000, 200, 3, 0),
+	PLL_35XX_RATE(1500000000, 250, 4, 0),
+	PLL_35XX_RATE(1400000000, 175, 3, 0),
+	PLL_35XX_RATE(1300000000, 325, 6, 0),
+	PLL_35XX_RATE(1200000000, 200, 4, 0),
+	PLL_35XX_RATE(1100000000, 275, 6, 0),
+	PLL_35XX_RATE(1000000000, 125, 3, 0),
+	PLL_35XX_RATE(900000000, 150, 4, 0),
+	PLL_35XX_RATE(800000000, 100, 3, 0),
+	PLL_35XX_RATE(700000000, 175, 3, 1),
+	PLL_35XX_RATE(600000000, 200, 4, 1),
+	PLL_35XX_RATE(500000000, 125, 3, 1),
+	PLL_35XX_RATE(400000000, 100, 3, 1),
+	PLL_35XX_RATE(300000000, 200, 4, 2),
+	PLL_35XX_RATE(200000000, 100, 3, 2),
+};
+
 static struct samsung_pll_clock exynos5250_plls[nr_plls] __initdata = {
 	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, "fout_apll", NULL),
@@ -707,8 +728,10 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
 				ARRAY_SIZE(exynos5250_pll_pmux_clks));
 
-	if (_get_rate("fin_pll") == 24 * MHZ)
+	if (_get_rate("fin_pll") == 24 * MHZ) {
 		exynos5250_plls[epll].rate_table = epll_24mhz_tbl;
+		exynos5250_plls[apll].rate_table = apll_24mhz_tbl;
+	}
 
 	if (_get_rate("mout_vpllsrc") == 24 * MHZ)
 		exynos5250_plls[vpll].rate_table =  vpll_24mhz_tbl;
-- 
1.7.9.5
