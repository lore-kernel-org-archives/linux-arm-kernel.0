From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 4 Jul 2016 01:36:50 +0000
Subject: [PATCH v2] clkdev: add devm_of_clk_get()
Message-ID: <87wpl2yyuw.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is based on devm_clk_get()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - added "static" and "inline" on header

 drivers/clk/clkdev.c | 26 ++++++++++++++++++++++++++
 include/linux/clk.h  |  7 +++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 89cc700..93a613b 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -55,6 +55,32 @@ struct clk *of_clk_get(struct device_node *np, int index)
 }
 EXPORT_SYMBOL(of_clk_get);
 
+static void devm_of_clk_release(struct device *dev, void *res)
+{
+	clk_put(*(struct clk **)res);
+}
+
+struct clk *devm_of_clk_get(struct device *dev,
+			    struct device_node *np, int index)
+{
+	struct clk **ptr, *clk;
+
+	ptr = devres_alloc(devm_of_clk_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	clk = of_clk_get(np, index);
+	if (!IS_ERR(clk)) {
+		*ptr = clk;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL(devm_of_clk_get);
+
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
 					const char *name)
diff --git a/include/linux/clk.h b/include/linux/clk.h
index a89ba4e..33cd540 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -502,6 +502,8 @@ struct of_phandle_args;
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
+struct clk *devm_of_clk_get(struct device *dev,
+			    struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
 #else
@@ -509,6 +511,11 @@ static inline struct clk *of_clk_get(struct device_node *np, int index)
 {
 	return ERR_PTR(-ENOENT);
 }
+static inline struct clk *devm_of_clk_get(struct device *dev,
+			    struct device_node *np, int index)
+{
+	return ERR_PTR(-ENOENT);
+}
 static inline struct clk *of_clk_get_by_name(struct device_node *np,
 					     const char *name)
 {
-- 
1.9.1
