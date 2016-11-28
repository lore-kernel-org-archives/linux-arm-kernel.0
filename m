From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 28 Nov 2016 09:32:51 +0000
Subject: [PATCH v3] clkdev: add devm_of_clk_get()
Message-ID: <87vav89chw.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Linux has of_clk_get(), but doesn't have devm_of_clk_get().
This patch adds it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - implement in clk-devres.c, and reused existing devm_clk_release()

 drivers/clk/clk-devres.c | 21 +++++++++++++++++++++
 include/linux/clk.h      |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 8f57154..2449b25 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -53,3 +53,24 @@ void devm_clk_put(struct device *dev, struct clk *clk)
 	WARN_ON(ret);
 }
 EXPORT_SYMBOL(devm_clk_put);
+
+struct clk *devm_of_clk_get(struct device *dev,
+			    struct device_node *np, int index)
+{
+	struct clk **ptr, *clk;
+
+	ptr = devres_alloc(devm_clk_release, sizeof(*ptr), GFP_KERNEL);
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
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 123c027..1b713db 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -506,6 +506,8 @@ static inline void clk_disable_unprepare(struct clk *clk)
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
+struct clk *devm_of_clk_get(struct device *dev,
+			    struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec);
 #else
@@ -513,6 +515,11 @@ static inline struct clk *of_clk_get(struct device_node *np, int index)
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
