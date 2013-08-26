From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 26 Aug 2013 19:09:09 +0200
Subject: [PATCH v2 14/16] clk: samsung: exynos4: Register PLL rate tables for
 Exynos4210
In-Reply-To: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
References: <1377536951-9307-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377536951-9307-15-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds rate tables for PLLs that can be reconfigured at runtime
for Exynos4210 SoCs. Provided tables contain PLL coefficients for
input clock of 24 MHz and so are registered only in this case. MPLL does
not need runtime reconfiguration and so table for it is not provided.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 9734042..722bf7c 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -992,6 +992,40 @@ static struct of_device_id ext_clk_match[] __initdata = {
 	{},
 };
 
+/* PLLs PMS values */
+static struct samsung_pll_rate_table exynos4210_apll_rates[] __initdata = {
+	PLL_45XX_RATE(1200000000, 150,  3, 1, 28),
+	PLL_45XX_RATE(1000000000, 250,  6, 1, 28),
+	PLL_45XX_RATE( 800000000, 200,  6, 1, 28),
+	PLL_45XX_RATE( 666857142, 389, 14, 1, 13),
+	PLL_45XX_RATE( 600000000, 100,  4, 1, 13),
+	PLL_45XX_RATE( 533000000, 533, 24, 1,  5),
+	PLL_45XX_RATE( 500000000, 250,  6, 2, 28),
+	PLL_45XX_RATE( 400000000, 200,  6, 2, 28),
+	PLL_45XX_RATE( 200000000, 200,  6, 3, 28),
+	{ /* sentinel */ }
+};
+
+static struct samsung_pll_rate_table exynos4210_epll_rates[] __initdata = {
+	PLL_4600_RATE(192000000, 48, 3, 1,     0, 0),
+	PLL_4600_RATE(180633605, 45, 3, 1, 10381, 0),
+	PLL_4600_RATE(180000000, 45, 3, 1,     0, 0),
+	PLL_4600_RATE( 73727996, 73, 3, 3, 47710, 1),
+	PLL_4600_RATE( 67737602, 90, 4, 3, 20762, 1),
+	PLL_4600_RATE( 49151992, 49, 3, 3,  9961, 0),
+	PLL_4600_RATE( 45158401, 45, 3, 3, 10381, 0),
+	{ /* sentinel */ }
+};
+
+static struct samsung_pll_rate_table exynos4210_vpll_rates[] __initdata = {
+	PLL_4650_RATE(360000000, 44, 3, 0, 1024, 0, 14, 0),
+	PLL_4650_RATE(324000000, 53, 2, 1, 1024, 1,  1, 1),
+	PLL_4650_RATE(259617187, 63, 3, 1, 1950, 0, 20, 1),
+	PLL_4650_RATE(110000000, 53, 3, 2, 2048, 0, 17, 0),
+	PLL_4650_RATE( 55360351, 53, 3, 3, 2417, 0, 17, 0),
+	{ /* sentinel */ }
+};
+
 static struct samsung_pll_clock exynos4210_plls[nr_plls] __initdata = {
 	[apll] = PLL_A(pll_4508, fout_apll, "fout_apll", "fin_pll", APLL_LOCK,
 		APLL_CON0, "fout_apll", NULL),
@@ -1042,6 +1076,17 @@ static void __init exynos4_clk_init(struct device_node *np,
 		samsung_clk_register_mux(exynos4210_mux_early,
 					ARRAY_SIZE(exynos4210_mux_early));
 
+		if (_get_rate("fin_pll") == 24000000) {
+			exynos4210_plls[apll].rate_table =
+							exynos4210_apll_rates;
+			exynos4210_plls[epll].rate_table =
+							exynos4210_epll_rates;
+		}
+
+		if (_get_rate("mout_vpllsrc") == 24000000)
+			exynos4210_plls[vpll].rate_table =
+							exynos4210_vpll_rates;
+
 		samsung_clk_register_pll(exynos4210_plls,
 					ARRAY_SIZE(exynos4210_plls), reg_base);
 	} else {
-- 
1.8.3.2
