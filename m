From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Mon, 10 Jun 2013 18:54:19 +0530
Subject: [PATCH v6 7/7] clk: samsung: Add EPLL and VPLL freq table for
 exynos5250 SoC
In-Reply-To: <1370870659-10929-1-git-send-email-yadi.brar@samsung.com>
References: <1370870659-10929-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370870659-10929-8-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the EPLL and VPLL freq table for exynos5250 SoC.

Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c |   42 ++++++++++++++++++++++++++++++++-
 drivers/clk/samsung/clk.h            |    2 +
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 6881810..13e293e 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -493,6 +493,29 @@ static __initdata struct of_device_id ext_clk_match[] = {
 	{ },
 };
 
+static __initdata struct samsung_pll_rate_table vpll_24mhz_tbl[] = {
+	/* sorted in descending order */
+	/* PLL_36XX_RATE(rate, m, p, s, k) */
+	PLL_36XX_RATE(266000000, 266, 3, 3, 0),
+	/* Not in UM, but need for eDP on snow */
+	PLL_36XX_RATE(70500000, 94, 2, 4, 0),
+	{ },
+};
+
+static __initdata struct samsung_pll_rate_table epll_24mhz_tbl[] = {
+	/* sorted in descending order */
+	/* PLL_36XX_RATE(rate, m, p, s, k) */
+	PLL_36XX_RATE(192000000, 64, 2, 2, 0),
+	PLL_36XX_RATE(180633600, 90, 3, 2, 20762),
+	PLL_36XX_RATE(180000000, 90, 3, 2, 0),
+	PLL_36XX_RATE(73728000, 98, 2, 4, 19923),
+	PLL_36XX_RATE(67737600, 90, 2, 4, 20762),
+	PLL_36XX_RATE(49152000, 98, 3, 4, 19923),
+	PLL_36XX_RATE(45158400, 90, 3, 4, 20762),
+	PLL_36XX_RATE(32768000, 131, 3, 5, 4719)
+	{ },
+};
+
 struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
 	[apll] = PLL_A(pll_35xx, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, "fout_apll", NULL),
@@ -506,14 +529,16 @@ struct __initdata samsung_pll_clock exynos5250_plls[nr_plls] = {
 		CPLL_CON0, NULL),
 	[epll] = PLL(pll_36xx, fout_epll, "fout_epll", "fin_pll", EPLL_LOCK,
 		EPLL_CON0, NULL),
-	[vpll] = PLL(pll_36xx, fout_vpll, "fout_vpll", "fin_pll", VPLL_LOCK,
-		VPLL_CON0, NULL),
+	[vpll] = PLL(pll_36xx, fout_vpll, "fout_vpll", "mout_vpllsrc",
+		VPLL_LOCK, VPLL_CON0, NULL),
 };
 
 /* register exynox5250 clocks */
 void __init exynos5250_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
+	struct clk *vpllsrc;
+	unsigned long fin_pll_rate, mout_vpllsrc_rate = 0;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -531,6 +556,19 @@ void __init exynos5250_clk_init(struct device_node *np)
 			ext_clk_match);
 	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
 				ARRAY_SIZE(exynos5250_pll_pmux_clks));
+
+	fin_pll_rate = _get_rate("fin_pll");
+
+	if (fin_pll_rate == (24 * MHZ))
+		exynos5250_plls[epll].rate_table = epll_24mhz_tbl;
+
+	vpllsrc = __clk_lookup("mout_vpllsrc");
+	if (vpllsrc)
+		mout_vpllsrc_rate = clk_get_rate(vpllsrc);
+
+	if (mout_vpllsrc_rate == (24 * MHZ))
+		exynos5250_plls[vpll].rate_table =  vpll_24mhz_tbl;
+
 	samsung_clk_register_pll(exynos5250_plls, ARRAY_SIZE(exynos5250_plls),
 					reg_base);
 	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 3e6501c..378bf98 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -40,6 +40,8 @@ struct samsung_clock_alias {
 		.alias		= a,				\
 	}
 
+#define MHZ (1000*1000)
+
 /**
  * struct samsung_fixed_rate_clock: information about fixed-rate clock
  * @id: platform specific id of the clock.
-- 
1.7.0.4
