From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 22:09:07 +0200
Subject: [PATCH v3 04/27] clk: samsung: exynos5410: Provide fin_pll external
 fixed clock
In-Reply-To: <1462910970-1812-1-git-send-email-krzk@kernel.org>
References: <1462910970-1812-1-git-send-email-krzk@kernel.org>
Message-ID: <1462910970-1812-5-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like clock driver for Exynos542x/5800, provide the fixed clock here
so the clock bindings and their consumers would be consistent and
similar.

However a clock named "fin_pll" is already provided by generic
fixed-clock and it is both referenced in the clock driver (by name) and
in DT (by phandle). To make the transition smooth, first introduce the
new external fixed clock here under temporary, different name and switch
internal users to it.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/clk/samsung/clk-exynos5410.c | 42 +++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index d5d5dcabc4a9..35f2cb36f7ef 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -59,23 +59,29 @@ enum exynos5410_plls {
 };
 
 /* list of all parent clocks */
-PNAME(apll_p)		= { "fin_pll", "fout_apll", };
-PNAME(bpll_p)		= { "fin_pll", "fout_bpll", };
-PNAME(cpll_p)		= { "fin_pll", "fout_cpll" };
-PNAME(mpll_p)		= { "fin_pll", "fout_mpll", };
-PNAME(kpll_p)		= { "fin_pll", "fout_kpll", };
+PNAME(apll_p)		= { "fin_pll_new", "fout_apll", };
+PNAME(bpll_p)		= { "fin_pll_new", "fout_bpll", };
+PNAME(cpll_p)		= { "fin_pll_new", "fout_cpll" };
+PNAME(mpll_p)		= { "fin_pll_new", "fout_mpll", };
+PNAME(kpll_p)		= { "fin_pll_new", "fout_kpll", };
 
 PNAME(mout_cpu_p)	= { "mout_apll", "sclk_mpll", };
 PNAME(mout_kfc_p)	= { "mout_kpll", "sclk_mpll", };
 
-PNAME(mpll_user_p)	= { "fin_pll", "sclk_mpll", };
-PNAME(bpll_user_p)	= { "fin_pll", "sclk_bpll", };
+PNAME(mpll_user_p)	= { "fin_pll_new", "sclk_mpll", };
+PNAME(bpll_user_p)	= { "fin_pll_new", "sclk_bpll", };
 PNAME(mpll_bpll_p)	= { "sclk_mpll_muxed", "sclk_bpll_muxed", };
 
-PNAME(group2_p)		= { "fin_pll", "fin_pll", "none", "none",
+PNAME(group2_p)		= { "fin_pll_new", "fin_pll_new", "none", "none",
 			"none", "none", "sclk_mpll_bpll",
 			 "none", "none", "sclk_cpll" };
 
+/* fixed rate clocks generated outside the soc */
+static struct samsung_fixed_rate_clock
+		exynos5x_fixed_rate_ext_clks[] __initdata = {
+	FRATE(CLK_FIN_PLL, "fin_pll_new", NULL, 0, 0),
+};
+
 static struct samsung_mux_clock exynos5410_mux_clks[] __initdata = {
 	MUX(0, "mout_apll", apll_p, SRC_CPU, 0, 1),
 	MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
@@ -168,18 +174,24 @@ static struct samsung_gate_clock exynos5410_gate_clks[] __initdata = {
 };
 
 static struct samsung_pll_clock exynos5410_plls[nr_plls] __initdata = {
-	[apll] = PLL(pll_35xx, CLK_FOUT_APLL, "fout_apll", "fin_pll", APLL_LOCK,
+	[apll] = PLL(pll_35xx, CLK_FOUT_APLL, "fout_apll", "fin_pll_new", APLL_LOCK,
 		APLL_CON0, NULL),
-	[cpll] = PLL(pll_35xx, CLK_FOUT_CPLL, "fout_cpll", "fin_pll", CPLL_LOCK,
+	[cpll] = PLL(pll_35xx, CLK_FOUT_CPLL, "fout_cpll", "fin_pll_new", CPLL_LOCK,
 		CPLL_CON0, NULL),
-	[mpll] = PLL(pll_35xx, CLK_FOUT_MPLL, "fout_mpll", "fin_pll", MPLL_LOCK,
+	[mpll] = PLL(pll_35xx, CLK_FOUT_MPLL, "fout_mpll", "fin_pll_new", MPLL_LOCK,
 		MPLL_CON0, NULL),
-	[bpll] = PLL(pll_35xx, CLK_FOUT_BPLL, "fout_bpll", "fin_pll", BPLL_LOCK,
+	[bpll] = PLL(pll_35xx, CLK_FOUT_BPLL, "fout_bpll", "fin_pll_new", BPLL_LOCK,
 		BPLL_CON0, NULL),
-	[kpll] = PLL(pll_35xx, CLK_FOUT_KPLL, "fout_kpll", "fin_pll", KPLL_LOCK,
+	[kpll] = PLL(pll_35xx, CLK_FOUT_KPLL, "fout_kpll", "fin_pll_new", KPLL_LOCK,
 		KPLL_CON0, NULL),
 };
 
+/* Same as in Exynos5420 */
+static const struct of_device_id ext_clk_match[] __initconst = {
+	{ .compatible = "samsung,exynos5420-oscclk", .data = (void *)0, },
+	{ },
+};
+
 /* register exynos5410 clocks */
 static void __init exynos5410_clk_init(struct device_node *np)
 {
@@ -192,6 +204,10 @@ static void __init exynos5410_clk_init(struct device_node *np)
 
 	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
 
+	samsung_clk_of_register_fixed_ext(ctx, exynos5x_fixed_rate_ext_clks,
+			ARRAY_SIZE(exynos5x_fixed_rate_ext_clks),
+			ext_clk_match);
+
 	samsung_clk_register_pll(ctx, exynos5410_plls,
 			ARRAY_SIZE(exynos5410_plls), reg_base);
 
-- 
2.5.0
