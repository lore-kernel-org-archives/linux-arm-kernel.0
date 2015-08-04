From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 4 Aug 2015 16:16:53 +0800
Subject: [PATCH v6 4/9] clk: mediatek: Add fixed clocks support for Mediatek
 SoC.
In-Reply-To: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1438676218-11310-5-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds fixed clocks support by using CCF fixed-rate
clock implementation.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/clk/mediatek/clk-mtk.c | 23 +++++++++++++++++++++++
 drivers/clk/mediatek/clk-mtk.h | 17 +++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 268b6ff..cf08db6 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -49,6 +49,29 @@ err_out:
 	return NULL;
 }
 
+void __init mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
+		int num, struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < num; i++) {
+		const struct mtk_fixed_clk *rc = &clks[i];
+
+		clk = clk_register_fixed_rate(NULL, rc->name, rc->parent,
+				rc->parent ? 0 : CLK_IS_ROOT, rc->rate);
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
 void __init mtk_clk_register_factors(const struct mtk_fixed_factor *clks,
 		int num, struct clk_onecell_data *clk_data)
 {
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 740fe5e..32d4f55 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -25,6 +25,23 @@
 
 #define MHZ (1000 * 1000)
 
+struct mtk_fixed_clk {
+	int id;
+	const char *name;
+	const char *parent;
+	unsigned long rate;
+};
+
+#define FIXED_CLK(_id, _name, _parent, _rate) {		\
+		.id = _id,				\
+		.name = _name,				\
+		.parent = _parent,			\
+		.rate = _rate,				\
+	}
+
+void mtk_clk_register_fixed_clks(const struct mtk_fixed_clk *clks,
+		int num, struct clk_onecell_data *clk_data);
+
 struct mtk_fixed_factor {
 	int id;
 	const char *name;
-- 
1.8.1.1.dirty
