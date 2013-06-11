From: yadi.brar@samsung.com (Yadwinder Singh Brar)
Date: Tue, 11 Jun 2013 15:01:15 +0530
Subject: [PATCH v7 10/11] clk: samsung: Reorder MUX registration for
 mout_vpllsrc
In-Reply-To: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
References: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
Message-ID: <1370943076-13461-11-git-send-email-yadi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vikas Sajjan <vikas.sajjan@linaro.org>

While trying to get rate of "mout_vpllsrc" MUX (parent) for registering the
"fout_vpll" (child), we found get rate was failing.

So this patch moves the mout_vpllsrc MUX out of the existing common list
and registers the mout_vpllsrc MUX before the PLL registrations.

Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
---
 drivers/clk/samsung/clk-exynos5250.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 623ae44..492d119 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -233,6 +233,10 @@ static struct samsung_fixed_factor_clock exynos5250_fixed_factor_clks[] __initda
 	FFACTOR(none, "fout_bplldiv2", "fout_bpll", 1, 2, 0),
 };
 
+static struct samsung_mux_clock exynos5250_pll_pmux_clks[] __initdata = {
+	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP2, 0, 1),
+};
+
 static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(none, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
 	MUX(none, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
@@ -240,7 +244,6 @@ static struct samsung_mux_clock exynos5250_mux_clks[] __initdata = {
 	MUX(none, "sclk_mpll", mout_mpll_p, SRC_CORE1, 8, 1),
 	MUX(none, "mout_bpll_fout", mout_bpll_fout_p, PLL_DIV2_SEL, 0, 1),
 	MUX(none, "sclk_bpll", mout_bpll_p, SRC_CDREX, 0, 1),
-	MUX(none, "mout_vpllsrc", mout_vpllsrc_p, SRC_TOP2, 0, 1),
 	MUX(none, "sclk_vpll", mout_vpll_p, SRC_TOP2, 16, 1),
 	MUX(none, "sclk_epll", mout_epll_p, SRC_TOP2, 12, 1),
 	MUX(none, "sclk_cpll", mout_cpll_p, SRC_TOP2, 8, 1),
@@ -536,6 +539,8 @@ static void __init exynos5250_clk_init(struct device_node *np)
 	samsung_clk_of_register_fixed_ext(exynos5250_fixed_rate_ext_clks,
 			ARRAY_SIZE(exynos5250_fixed_rate_ext_clks),
 			ext_clk_match);
+	samsung_clk_register_mux(exynos5250_pll_pmux_clks,
+				ARRAY_SIZE(exynos5250_pll_pmux_clks));
 	samsung_clk_register_pll(exynos5250_plls, ARRAY_SIZE(exynos5250_plls),
 					reg_base);
 	samsung_clk_register_fixed_rate(exynos5250_fixed_rate_clks,
-- 
1.7.0.4
