From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 20 May 2014 16:08:28 +0200
Subject: [PATCH] clk: exynos4: Register custom fixed rate clocks conditionally
Message-ID: <1400594908-11941-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the Exynos custom fixed rate clocks registration (for oscillators
connected to the XXTI or XUSBXTI pins) only if "fixed-rate-clocks"
node is found in device tree. This allows to handle new dtbs with those
clocks described in a generic way and having the "fixed-rate-clocks"
node removed.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 05fc93c..f0b8420 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1045,7 +1045,7 @@ static unsigned long exynos4_get_xom(void)
 	return xom;
 }
 
-static void __init exynos4_clk_register_finpll(void)
+static void __init exynos4_clk_register_finpll(struct device_node *np)
 {
 	struct samsung_fixed_rate_clock fclk;
 	struct clk *clk;
@@ -1054,7 +1054,10 @@ static void __init exynos4_clk_register_finpll(void)
 	unsigned int xom = exynos4_get_xom();
 
 	parent_name = xom & 1 ? "xusbxti" : "xxti";
-	clk = clk_get(NULL, parent_name);
+	if (np)
+		clk = of_clk_get_by_name(np, parent_name);
+	else
+		clk = clk_get(NULL, parent_name);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to lookup parent clock %s, assuming "
 			"fin_pll clock frequency is 24MHz\n", __func__,
@@ -1193,11 +1196,18 @@ static void __init exynos4_clk_init(struct device_node *np,
 
 	samsung_clk_init(np, reg_base, CLK_NR_CLKS);
 
-	samsung_clk_of_register_fixed_ext(exynos4_fixed_rate_ext_clks,
-			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
-			ext_clk_match);
-
-	exynos4_clk_register_finpll();
+	if (of_find_node_by_name(np, "fixed-rate-clocks")) {
+		/*
+		 * Exynos custom fixed clock registration, only for
+		 * compatibility with legacy dtbs.
+		 */
+		samsung_clk_of_register_fixed_ext(exynos4_fixed_rate_ext_clks,
+					ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
+					ext_clk_match);
+		exynos4_clk_register_finpll(NULL);
+	} else {
+		exynos4_clk_register_finpll(np);
+	}
 
 	if (exynos4_soc == EXYNOS4210) {
 		samsung_clk_register_mux(exynos4210_mux_early,
-- 
1.7.9.5
