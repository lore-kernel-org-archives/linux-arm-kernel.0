From: ryder.lee@mediatek.com (Ryder Lee)
Date: Tue, 2 Jan 2018 19:47:51 +0800
Subject: [PATCH 09/12] clk: mediatek: move part of mtk_clk_register_gates() to
 the new function
In-Reply-To: <cover.1514881870.git.ryder.lee@mediatek.com>
References: <cover.1514881870.git.ryder.lee@mediatek.com>
Message-ID: <f658c6163421800b248e7b96fae05c8d6e043e02.1514881870.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some subsystems, the regmap has already been initialized from its parent,
so there is no need to map it again. To keep flexible, we move some parts to
the new function - mtk_clk_register_num_gates(), and then use it for those
subsystems.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 26 +++++++++++++++++---------
 drivers/clk/mediatek/clk-mtk.h |  4 ++++
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 9c0ae42..815c98f 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -101,24 +101,16 @@ void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 	}
 }
 
-int mtk_clk_register_gates(struct device_node *node,
+int mtk_clk_register_num_gates(struct regmap *regmap,
 		const struct mtk_gate *clks,
 		int num, struct clk_onecell_data *clk_data)
 {
 	int i;
 	struct clk *clk;
-	struct regmap *regmap;
 
 	if (!clk_data)
 		return -ENOMEM;
 
-	regmap = syscon_node_to_regmap(node);
-	if (IS_ERR(regmap)) {
-		pr_err("Cannot find regmap for %pOF: %ld\n", node,
-				PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
-
 	for (i = 0; i < num; i++) {
 		const struct mtk_gate *gate = &clks[i];
 
@@ -144,6 +136,22 @@ int mtk_clk_register_gates(struct device_node *node,
 	return 0;
 }
 
+int mtk_clk_register_gates(struct device_node *node,
+		const struct mtk_gate *clks,
+		int num, struct clk_onecell_data *clk_data)
+{
+	struct regmap *regmap;
+
+	regmap = syscon_node_to_regmap(node);
+	if (IS_ERR(regmap)) {
+		pr_err("Cannot find regmap for %pOF: %ld\n", node,
+				PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return mtk_clk_register_num_gates(regmap, clks, num, clk_data);
+}
+
 struct clk *mtk_clk_register_composite(const struct mtk_composite *mc,
 		void __iomem *base, spinlock_t *lock)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index f10250d..f969c28 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -159,6 +159,10 @@ struct mtk_gate {
 	const struct clk_ops *ops;
 };
 
+int mtk_clk_register_num_gates(struct regmap *regmap,
+		const struct mtk_gate *clks, int num,
+		struct clk_onecell_data *clk_data);
+
 int mtk_clk_register_gates(struct device_node *node,
 			const struct mtk_gate *clks, int num,
 			struct clk_onecell_data *clk_data);
-- 
1.9.1
