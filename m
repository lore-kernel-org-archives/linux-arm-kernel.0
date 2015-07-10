From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 18:00:01 +0800
Subject: [PATCH v3 1/5] clk: mediatek: mt8173: Fix enabling of critical clocks
In-Reply-To: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436522405-13923-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436522405-13923-2-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

On the MT8173 the clocks are provided by different units. To enable
the critical clocks we must be sure that all parent clocks are already
registered, otherwise the parents of the critical clocks end up being
unused and get disabled later.

On MT8173, for example, it is the CLK_TOP clocks that have CLK_APMIXED
PLLs as their parents, so we cannot enable the CLK_TOP critical clocks
until the CLK_APMIXED clocks have all been registered.

To find a place where all parents are registered we try each time
after we've registered some clocks if all known providers are present
now and only then we enable the critical clocks.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 4b9e04c..b3d91ee 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -700,6 +700,22 @@ static const struct mtk_composite peri_clks[] __initconst = {
 	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
 };
 
+static struct clk_onecell_data *mt8173_top_clk_data;
+static struct clk_onecell_data *mt8173_pll_clk_data;
+
+static void __init mtk_clk_enable_critical(void)
+{
+	if (!mt8173_top_clk_data || !mt8173_pll_clk_data)
+		return;
+
+	clk_prepare_enable(mt8173_pll_clk_data->clks[CLK_APMIXED_ARMCA15PLL]);
+	clk_prepare_enable(mt8173_pll_clk_data->clks[CLK_APMIXED_ARMCA7PLL]);
+	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_MEM_SEL]);
+	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
+	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_CCI400_SEL]);
+	clk_prepare_enable(mt8173_top_clk_data->clks[CLK_TOP_RTC_SEL]);
+}
+
 static void __init mtk_topckgen_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
@@ -712,19 +728,19 @@ static void __init mtk_topckgen_init(struct device_node *node)
 		return;
 	}
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	mt8173_top_clk_data = clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
 	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
 			&mt8173_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_TOP_CCI400_SEL]);
-
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_clk_enable_critical();
 }
 CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8173-topckgen", mtk_topckgen_init);
 
@@ -818,13 +834,13 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
 
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	mt8173_pll_clk_data = clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (!clk_data)
 		return;
 
 	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
 
-	clk_prepare_enable(clk_data->clks[CLK_APMIXED_ARMCA15PLL]);
+	mtk_clk_enable_critical();
 }
 CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8173-apmixedsys",
 		mtk_apmixedsys_init);
-- 
1.8.1.1.dirty
