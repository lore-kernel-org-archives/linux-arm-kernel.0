From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 29 May 2015 18:01:27 +0200
Subject: [PATCH v2 2/3] clk: mediatek: Add support for clk-mux using regmap
In-Reply-To: <1432915288-14034-1-git-send-email-matthias.bgg@gmail.com>
References: <1432915288-14034-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1432915288-14034-3-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches adds support for the mediatek clocks to be able to register
and use a clk-mux wich relies on regmap.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clk/mediatek/clk-mtk.c | 37 +++++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h | 26 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 18444ae..cf953a8 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -111,6 +111,43 @@ int mtk_clk_register_gates(struct device_node *node, const struct mtk_gate *clks
 	return 0;
 }
 
+int mtk_clk_regm_register_mux(struct device_node *node,
+		const struct mtk_regm_mux *clks, int num,
+		struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+	struct regmap *regmap;
+
+	if (!clk_data)
+		return -ENOMEM;
+
+	regmap = syscon_node_to_regmap(node);
+	if (IS_ERR(regmap)) {
+		pr_err("Cannot find regmap for %s: %ld\n", node->full_name,
+				PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	for (i = 0; i < num; i++) {
+		const struct mtk_regm_mux *mux = &clks[i];
+
+		clk = clk_regm_register_mux(NULL, mux->name, mux->parent_names,
+					mux->num_parents, 0, regmap,
+					mux->mux_offset, mux->mux_shift,
+					mux->mux_width, mux->flags, NULL);
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk mux %s: %ld\n",
+					mux->name, PTR_ERR(clk));
+			continue;
+		}
+
+		clk_data->clks[mux->id] = clk;
+	}
+
+	return 0;
+}
+
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 61035b9..3f41725 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -156,6 +156,32 @@ void __init mtk_clk_register_plls(struct device_node *node,
 		const struct mtk_pll_data *plls, int num_plls,
 		struct clk_onecell_data *clk_data);
 
+struct mtk_regm_mux {
+	int id;
+	const char *name;
+	const char * const *parent_names;
+	u8 num_parents;
+	unsigned flags;
+	uint32_t mux_offset;
+	uint32_t mux_shift;
+	uint32_t mux_width;
+};
+
+int __init mtk_clk_regm_register_mux(struct device_node *node,
+		const struct mtk_regm_mux *clks, int num,
+		struct clk_onecell_data *clk_data);
+
+#define MUX_REGMAP(_id, _name, _parents, _offset, _shift, _width) {	\
+		.id = _id,						\
+		.name = _name,						\
+		.parent_names = _parents,				\
+		.num_parents = ARRAY_SIZE(_parents),			\
+		.flags = CLK_SET_RATE_PARENT,				\
+		.mux_offset = _offset,					\
+		.mux_shift = _shift,					\
+		.mux_width = _width,					\
+	}
+
 #ifdef CONFIG_RESET_CONTROLLER
 void mtk_register_reset_controller(struct device_node *np,
 			unsigned int num_regs, int regofs);
-- 
1.9.1
