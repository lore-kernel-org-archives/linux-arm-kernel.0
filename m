From: vikas.sajjan@linaro.org (Vikas Sajjan)
Date: Fri, 31 May 2013 18:01:36 +0530
Subject: [PATCH v3 6/6] clk: samsung: Add EPLL and VPLL freq table for
 exynos5250 SoC
In-Reply-To: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
References: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <1370003496-19288-7-git-send-email-vikas.sajjan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the EPLL and VPLL freq table for exynos5250 SoC.

Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |   48 +++++++++++++++++++++++++++++++---
 drivers/clk/samsung/clk.h            |    2 ++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index b0e6680..0566421 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -473,11 +473,32 @@ static __initdata struct of_device_id ext_clk_match[] = {
 	{ },
 };
 
+static const struct samsung_pll_rate_table vpll_24mhz_tbl[] = {
+	/* sorted in descending order */
+	/* PLL_36XX_RATE(rate, m, p, s, k) */
+	PLL_36XX_RATE(266000000, 266, 3, 3, 0),
+	PLL_36XX_RATE(70500000, 94, 2, 4, 0),
+};
+
+static const struct samsung_pll_rate_table epll_24mhz_tbl[] = {
+	/* sorted in descending order */
+	/* PLL_36XX_RATE(rate, m, p, s, k) */
+	PLL_36XX_RATE(192000000, 48, 3, 1, 0),
+	PLL_36XX_RATE(180633600, 45, 3, 1, 10381),
+	PLL_36XX_RATE(180000000, 45, 3, 1, 0),
+	PLL_36XX_RATE(73728000, 73, 3, 3, 47710),
+	PLL_36XX_RATE(67737600, 90, 4, 3, 20762),
+	PLL_36XX_RATE(49152000, 49, 3, 3, 9962),
+	PLL_36XX_RATE(45158400, 45, 3, 3, 10381),
+	PLL_36XX_RATE(32768000, 131, 3, 5, 4719),
+};
+
 /* register exynox5250 clocks */
 void __init exynos5250_clk_init(struct device_node *np)
 {
 	void __iomem *reg_base;
 	struct clk *apll, *mpll, *epll, *vpll, *bpll, *gpll, *cpll;
+	unsigned long fin_pll_rate, mout_vpllsrc_rate;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -497,6 +518,9 @@ void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
 			ARRAY_SIZE(exynos5250_pll_pmux_clks));
 
+	fin_pll_rate = _get_rate("fin_pll");
+	mout_vpllsrc_rate = _get_rate("mout_vpllsrc");
+
 	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
 			reg_base, NULL, 0);
 	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
@@ -507,10 +531,28 @@ void __init exynos5250_clk_init(struct device_node *np)
 			reg_base + 0x10050, NULL, 0);
 	cpll = samsung_clk_register_pll35xx("fout_cpll", "fin_pll",
 			reg_base + 0x10020, NULL, 0);
-	epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
-			reg_base + 0x10030, NULL, 0);
-	vpll = samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc",
+
+	if (fin_pll_rate == (24 * MHZ)) {
+		epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
+				reg_base + 0x10030, epll_24mhz_tbl,
+				ARRAY_SIZE(epll_24mhz_tbl));
+	} else {
+		pr_warn("Exynos5250: valid epll rate_table missing for\n"
+			"parent fin_pll:%lu hz\n", fin_pll_rate);
+		epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
+				reg_base + 0x10030, NULL, 0);
+	}
+
+	if (mout_vpllsrc_rate == (24 * MHZ)) {
+		vpll = samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc"
+			, reg_base + 0x10040, vpll_24mhz_tbl,
+			ARRAY_SIZE(vpll_24mhz_tbl));
+	} else {
+		pr_warn("Exynos5250: valid vpll rate_table missing for\n"
+			"parent mout_vpllsrc_rate:%lu hz\n", mout_vpllsrc_rate);
+		samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc",
 			reg_base + 0x10040, NULL, 0);
+	}
 
 	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_clks));
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index e4ad6ea..c997649 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -20,6 +20,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
+#define MHZ (1000*1000)
+
 /**
  * struct samsung_clock_alias: information about mux clock
  * @id: platform specific id of the clock.
-- 
1.7.9.5
