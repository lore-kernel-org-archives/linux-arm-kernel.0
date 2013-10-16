From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 13:08:10 +0200
Subject: [PATCH 1/9] clk: exynos4: Remove remnants of non-DT support
In-Reply-To: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
References: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
Message-ID: <1381921698-5060-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simplifies a bit clock initialization code by removing
remnants of non-DT clock initialization, such as reg_base and xom values
passed in function parameters.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index ad5ff50..a29bb87 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -960,12 +960,13 @@ static unsigned long exynos4_get_xom(void)
 	return xom;
 }
 
-static void __init exynos4_clk_register_finpll(unsigned long xom)
+static void __init exynos4_clk_register_finpll(void)
 {
 	struct samsung_fixed_rate_clock fclk;
 	struct clk *clk;
 	unsigned long finpll_f = 24000000;
 	char *parent_name;
+	unsigned int xom = exynos4_get_xom();
 
 	parent_name = xom & 1 ? "xusbxti" : "xxti";
 	clk = clk_get(NULL, parent_name);
@@ -1090,9 +1091,10 @@ static struct samsung_pll_clock exynos4x12_plls[nr_plls] __initdata = {
 
 /* register exynos4 clocks */
 static void __init exynos4_clk_init(struct device_node *np,
-				    enum exynos4_soc exynos4_soc,
-				    void __iomem *reg_base, unsigned long xom)
+				    enum exynos4_soc exynos4_soc)
 {
+	void __iomem *reg_base;
+
 	reg_base = of_iomap(np, 0);
 	if (!reg_base)
 		panic("%s: failed to map registers\n", __func__);
@@ -1110,7 +1112,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 			ARRAY_SIZE(exynos4_fixed_rate_ext_clks),
 			ext_clk_match);
 
-	exynos4_clk_register_finpll(xom);
+	exynos4_clk_register_finpll();
 
 	if (exynos4_soc == EXYNOS4210) {
 		samsung_clk_register_mux(exynos4210_mux_early,
@@ -1188,12 +1190,12 @@ static void __init exynos4_clk_init(struct device_node *np,
 
 static void __init exynos4210_clk_init(struct device_node *np)
 {
-	exynos4_clk_init(np, EXYNOS4210, NULL, exynos4_get_xom());
+	exynos4_clk_init(np, EXYNOS4210);
 }
 CLK_OF_DECLARE(exynos4210_clk, "samsung,exynos4210-clock", exynos4210_clk_init);
 
 static void __init exynos4412_clk_init(struct device_node *np)
 {
-	exynos4_clk_init(np, EXYNOS4X12, NULL, exynos4_get_xom());
+	exynos4_clk_init(np, EXYNOS4X12);
 }
 CLK_OF_DECLARE(exynos4412_clk, "samsung,exynos4412-clock", exynos4412_clk_init);
-- 
1.8.3.2
