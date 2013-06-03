From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Mon, 03 Jun 2013 20:39:55 +0530
Subject: [PATCH v4 5/6] clk: samsung: Reorder MUX registration for mout_vpllsrc
In-Reply-To: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
References: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370272196-4346-6-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vikas Sajjan <vikas.sajjan@linaro.org>

While trying to get rate of "mout_vpllsrc" MUX (parent) for registering the
"fout_vpll" (child), we found get rate was failing.

So this patch moves the mout_vpllsrc MUX out of the existing common list
and registers the mout_vpllsrc MUX before the PLL registrations.

Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index ddf10ca..70cc6cf 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -207,6 +207,10 @@ struct samsung_fixed_factor_clock exynos5250_fixed_factor_clks[] __initdata = {
 	FFACTOR(none, "fout_bplldiv2", "fout_bpll", 1, 2, 0),
 };
 
+struct samsung_mux_clock exynos5250_pll_pmux_clks[] __initdata = {
+	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP2, 0, 1),
+};
+
 struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
 	MUX(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
@@ -214,7 +218,6 @@ struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(none, "sclk_mpll", mout_mpll_p, SRC_CORE1, 8, 1),
 	MUX(none, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
 	MUX(none, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
-	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP2, 0, 1),
 	MUX(none, "sclk_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
 	MUX(none, "sclk_epll", mout_epll_p, SRC_TOP2, 12, 1),
 	MUX(none, "sclk_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
@@ -490,6 +493,9 @@ void __init exynos5250_clk_init(struct device_node *np)
 			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
 			ext_clk_match);
 
+	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
+			ARRAY_SIZE(exynos5250_pll_pmux_clks));
+
 	apll = samsung_clk_register_pll35xx("fout_apll", "fin_pll",
 			reg_base, NULL, 0);
 	mpll = samsung_clk_register_pll35xx("fout_mpll", "fin_pll",
-- 
1.7.0.4
