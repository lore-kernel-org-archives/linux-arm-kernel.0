From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 17:16:03 +0800
Subject: [PATCH 2/2] clk: mediatek: Add clk_null to be the dummy root clock
 for MT8173
In-Reply-To: <1436519763-3195-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436519763-3195-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436519763-3195-3-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add a dummy clock "clk_null" to be the root clock of
clocks whose parents are not contained in CCF clock tree.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8173.c      | 5 +++++
 include/dt-bindings/clock/mt8173-clk.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 4b9e04c..c81bd72 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -24,6 +24,10 @@
 
 static DEFINE_SPINLOCK(mt8173_clk_lock);
 
+static const struct mtk_root_clk root_clks[] __initconst = {
+	ROOT_CLK(CLK_TOP_NULL, "clk_null", 0),
+};
+
 static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
 	FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
@@ -714,6 +718,7 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
+	mtk_clk_register_root_clks(root_clks, ARRAY_SIZE(root_clks), clk_data);
 	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index 4ad76ed..e91e9b8 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -17,6 +17,7 @@
 
 /* TOPCKGEN */
 
+#define CLK_TOP_NULL			0
 #define CLK_TOP_CLKPH_MCK_O		1
 #define CLK_TOP_DPI			2
 #define CLK_TOP_USB_SYSPLL_125M		3
-- 
1.8.1.1.dirty
