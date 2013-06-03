From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Mon, 03 Jun 2013 20:39:56 +0530
Subject: [PATCH v4 6/6] clk: samsung: Add EPLL and VPLL freq table for
 exynos5250 SoC
In-Reply-To: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
References: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370272196-4346-7-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the EPLL and VPLL freq table for exynos5250 SoC.

Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |   53 ++++++++++++++++++++++++++++++++--
 drivers/clk/samsung/clk.h            |    2 +
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 70cc6cf..f98c19d 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -472,11 +472,34 @@ static __initdata struct of_device_id ext_clk_match[] = {
 	{ },
 };
 
+static __initdata struct samsung_pll_rate_table vpll_24mhz_tbl[] = {
+	/* sorted in descending order */
+	/* PLL_36XX_RATE(rate, m, p, s, k) */
+	PLL_36XX_RATE(266000000, 266, 3, 3, 0),
+	/* Not in UM, but need for eDP on snow */
+	PLL_36XX_RATE(70500000, 94, 2, 4, 0),
+};
+
+static __initdata struct samsung_pll_rate_table epll_24mhz_tbl[] = {
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
+	struct clk *vpllsrc;
+	unsigned long fin_pll_rate, mout_vpllsrc_rate = 0;
 
 	if (np) {
 		reg_base = of_iomap(np, 0);
@@ -496,6 +519,11 @@ void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
 			ARRAY_SIZE(exynos5250_pll_pmux_clks));
 
+	fin_pll_rate = _get_rate("fin_pll");
+	vpllsrc = __clk_lookup("mout_vpllsrc");
+	if (vpllsrc)
+		mout_vpllsrc_rate = clk_get_rate(vpllsrc);
+
 	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
 			reg_base, NULL, 0);
 	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
@@ -506,10 +534,29 @@ void __init exynos5250_clk_init(struct device_node *np)
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
+		pr_warn("%s: valid epll rate_table missing for\n"
+			"parent fin_pll:%lu hz\n", __func__, fin_pll_rate);
+		epll = samsung_clk_register_pll36xx("fout_epll", "fin_pll",
+				reg_base + 0x10030, NULL, 0);
+	}
+
+	if (mout_vpllsrc_rate == (24 * MHZ)) {
+		vpll = samsung_clk_register_pll36xx("fout_vpll", "mout_vpllsrc"
+			, reg_base + 0x10040, vpll_24mhz_tbl,
+			ARRAY_SIZE(vpll_24mhz_tbl));
+	} else {
+		pr_warn("%s: valid vpll rate_table missing for\n"
+			"parent mout_vpllsrc_rate:%lu hz\n", __func__,
+			mout_vpllsrc_rate);
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
1.7.0.4
