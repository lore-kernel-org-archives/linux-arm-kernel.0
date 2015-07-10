From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 10 Jul 2015 17:16:02 +0800
Subject: [PATCH 1/2] clk: mediatek: Add root clocks support for Mediatek SoC.
In-Reply-To: <1436519763-3195-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436519763-3195-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1436519763-3195-2-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds root clocks support by using CCF fixed-rate
clock implementation.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 23 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h | 17 ++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 18444ae..4ac80d3 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -49,6 +49,29 @@ err_out:
 	return NULL;
 }
 
+void mtk_clk_register_root_clks(const struct mtk_root_clk *clks, int num,
+		struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < num; i++) {
+		const struct mtk_root_clk *rc = &clks[i];
+
+		clk = clk_register_fixed_rate(NULL, rc->name, NULL,
+				CLK_IS_ROOT, rc->rate);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+					rc->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[rc->id] = clk;
+	}
+}
+
 void mtk_clk_register_factors(const struct mtk_fixed_factor *clks, int num,
 		struct clk_onecell_data *clk_data)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 9dda9d8..d8d8b06 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -25,6 +25,21 @@
 
 #define MHZ (1000 * 1000)
 
+struct mtk_root_clk {
+	int id;
+	const char *name;
+	unsigned long rate;
+};
+
+#define ROOT_CLK(_id, _name, _rate) {			\
+		.id = _id,				\
+		.name = _name,				\
+		.rate = _rate,				\
+	}
+
+void mtk_clk_register_root_clks(const struct mtk_root_clk *clks,
+		int num, struct clk_onecell_data *clk_data);
+
 struct mtk_fixed_factor {
 	int id;
 	const char *name;
@@ -41,7 +56,7 @@ struct mtk_fixed_factor {
 		.div = _div,				\
 	}
 
-extern void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
+void mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 		int num, struct clk_onecell_data *clk_data);
 
 struct mtk_composite {
-- 
1.8.1.1.dirty
