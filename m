From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 29 Nov 2016 01:21:30 +0000
Subject: [PATCH v4] clkdev: add devm_of_clk_get()
Message-ID: <87zikjw08i.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current Linux has of_clk_get(), but doesn't have devm_of_clk_get().
This patch adds it. It is implemeted in clk-devres.c to share
devm_clk_release().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - git log explain why it is implemeted in clk-devres
 - it is related to CONFIG_HAVE_CLK

 drivers/clk/clk-devres.c | 21 +++++++++++++++++++++
 include/linux/clk.h      | 27 +++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)

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
index 123c027..7f50c5f 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -17,8 +17,9 @@
 #include <linux/notifier.h>
 
 struct device;
-
 struct clk;
+struct device_node;
+struct of_phandle_args;
 
 /**
  * DOC: clk notifier callback types
@@ -249,6 +250,21 @@ static inline void clk_unprepare(struct clk *clk)
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
 /**
+ * devm_clk_get - lookup and obtain a managed reference to a clock producer.
+ * @dev: device for clock "consumer"
+ * @np: pointer to clock consumer node
+ * @index: clock index
+ *
+ * This function parses the clocks, and uses them to look up the
+ * struct clk from the registered list of clock providers by using
+ * @np and @index.
+ *
+ * The clock will automatically be freed when the device is unbound
+ * from the bus.
+ */
+struct clk *devm_of_clk_get(struct device *dev, struct device_node *np, int index);
+
+/**
  * clk_enable - inform the system when the clock source should be running.
  * @clk: clock source
  *
@@ -432,6 +448,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *devm_of_clk_get(struct device *dev,
+					  struct device_node *np, int index)
+{
+	return NULL;
+}
+
 static inline void clk_put(struct clk *clk) {}
 
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
@@ -501,9 +523,6 @@ static inline void clk_disable_unprepare(struct clk *clk)
 	clk_unprepare(clk);
 }
 
-struct device_node;
-struct of_phandle_args;
-
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *of_clk_get(struct device_node *np, int index);
 struct clk *of_clk_get_by_name(struct device_node *np, const char *name);
-- 
1.9.1
