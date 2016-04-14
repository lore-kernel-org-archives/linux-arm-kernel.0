From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 14 Apr 2016 16:11:52 +0800
Subject: [PATCH v7 7/9] clk: mediatek: Enable critical clocks for MT2701
In-Reply-To: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1460621514-65191-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1460621514-65191-8-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some system clocks should be turned on by default on MT2701.
This patch enable these clocks when related clocks have
been registered.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt2701.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 9542e47..90294e7 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -671,6 +671,21 @@ static const struct mtk_gate top_clks[] __initconst = {
 		28),
 };
 
+static struct clk_onecell_data *top_clk_data __initdata;
+static struct clk_onecell_data *pll_clk_data __initdata;
+
+static void __init mtk_clk_enable_critical(void)
+{
+	if (!top_clk_data || !pll_clk_data)
+		return;
+
+	clk_prepare_enable(pll_clk_data->clks[CLK_APMIXED_ARMPLL]);
+	clk_prepare_enable(top_clk_data->clks[CLK_TOP_AXI_SEL]);
+	clk_prepare_enable(top_clk_data->clks[CLK_TOP_MEM_SEL]);
+	clk_prepare_enable(top_clk_data->clks[CLK_TOP_DDRPHYCFG_SEL]);
+	clk_prepare_enable(top_clk_data->clks[CLK_TOP_RTC_SEL]);
+}
+
 static void __init mtk_topckgen_init(struct device_node *node)
 {
 	struct clk_onecell_data *clk_data;
@@ -683,7 +698,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 		return;
 	}
 
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	top_clk_data = clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 								clk_data);
@@ -704,6 +719,8 @@ static void __init mtk_topckgen_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_clk_enable_critical();
 }
 CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt2701-topckgen", mtk_topckgen_init);
 
@@ -1297,7 +1314,7 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 	struct clk_onecell_data *clk_data;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
+	pll_clk_data = clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR);
 	if (!clk_data)
 		return;
 
@@ -1308,6 +1325,8 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
 			__func__, r);
+
+	mtk_clk_enable_critical();
 }
 CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt2701-apmixedsys",
 							mtk_apmixedsys_init);
-- 
1.9.1
