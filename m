From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Aug 2016 11:49:45 +0900
Subject: [PATCH 2/2] clk: samsung: exynos5410: Use samsung_cmu_register_one()
 to simplify code
In-Reply-To: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
References: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1471834185-20249-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the samsung_cmu_register_one() to simplify code
and move the pll/mux/div/gate data to initconst section.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clk/samsung/clk-exynos5410.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5410.c b/drivers/clk/samsung/clk-exynos5410.c
index 54ec486a5e45..5488a4460c15 100644
--- a/drivers/clk/samsung/clk-exynos5410.c
+++ b/drivers/clk/samsung/clk-exynos5410.c
@@ -230,29 +230,22 @@ static const struct samsung_pll_clock exynos5410_plls[nr_plls] __initconst = {
 		KPLL_CON0, NULL),
 };
 
+static const struct samsung_cmu_info cmu __initconst = {
+	.pll_clks	= exynos5410_plls,
+	.nr_pll_clks	= ARRAY_SIZE(exynos5410_plls),
+	.mux_clks	= exynos5410_mux_clks,
+	.nr_mux_clks	= ARRAY_SIZE(exynos5410_mux_clks),
+	.div_clks	= exynos5410_div_clks,
+	.nr_div_clks	= ARRAY_SIZE(exynos5410_div_clks),
+	.gate_clks	= exynos5410_gate_clks,
+	.nr_gate_clks	= ARRAY_SIZE(exynos5410_gate_clks),
+	.nr_clk_ids	= CLK_NR_CLKS,
+};
+
 /* register exynos5410 clocks */
 static void __init exynos5410_clk_init(struct device_node *np)
 {
-	struct samsung_clk_provider *ctx;
-	void __iomem *reg_base;
-
-	reg_base = of_iomap(np, 0);
-	if (!reg_base)
-		panic("%s: failed to map registers\n", __func__);
-
-	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
-
-	samsung_clk_register_pll(ctx, exynos5410_plls,
-			ARRAY_SIZE(exynos5410_plls), reg_base);
-
-	samsung_clk_register_mux(ctx, exynos5410_mux_clks,
-			ARRAY_SIZE(exynos5410_mux_clks));
-	samsung_clk_register_div(ctx, exynos5410_div_clks,
-			ARRAY_SIZE(exynos5410_div_clks));
-	samsung_clk_register_gate(ctx, exynos5410_gate_clks,
-			ARRAY_SIZE(exynos5410_gate_clks));
-
-	samsung_clk_of_add_provider(np, ctx);
+	samsung_cmu_register_one(np, &cmu);
 
 	pr_debug("Exynos5410: clock setup completed.\n");
 }
-- 
1.9.1
