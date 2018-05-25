From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Fri, 25 May 2018 18:37:21 +0800
Subject: [PATCH V3 2/4] clk: add new APIs to operate on all available clocks
In-Reply-To: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1527244643-10736-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces of_clk_bulk_get_all and clk_bulk_x_all APIs
to users who just want to handle all available clocks from device tree
without need to know the detailed clock information likes clock numbers
and names. This is useful in writing some generic drivers to handle clock
part.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * remove #if define condition
 * use kmalloc_array
v1->v2:
 * make of_clk_bulk_get_all private
 * add clk_bulk_get/put_all
---
 drivers/clk/clk-bulk.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h    | 42 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4460ac5..6a7118d 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -17,9 +17,11 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 					struct clk_bulk_data *clks)
@@ -49,6 +51,32 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 
+static int __must_check of_clk_bulk_get_all(struct device_node *np,
+					    struct clk_bulk_data **clks)
+{
+	struct clk_bulk_data *clk_bulk;
+	int num_clks;
+	int ret;
+
+	num_clks = of_clk_get_parent_count(np);
+	if (!num_clks)
+		return 0;
+
+	clk_bulk = kmalloc_array(num_clks, sizeof(*clk_bulk), GFP_KERNEL);
+	if (!clk_bulk)
+		return -ENOMEM;
+
+	ret = of_clk_bulk_get(np, num_clks, clk_bulk);
+	if (ret) {
+		kfree(clk_bulk);
+		return ret;
+	}
+
+	*clks = clk_bulk;
+
+	return num_clks;
+}
+
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
 	while (--num_clks >= 0) {
@@ -88,6 +116,29 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 }
 EXPORT_SYMBOL(clk_bulk_get);
 
+void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks)
+{
+	if (IS_ERR_OR_NULL(clks))
+		return;
+
+	clk_bulk_put(num_clks, clks);
+
+	kfree(clks);
+}
+EXPORT_SYMBOL(clk_bulk_put_all);
+
+int __must_check clk_bulk_get_all(struct device *dev,
+				  struct clk_bulk_data **clks)
+{
+	struct device_node *np = dev_of_node(dev);
+
+	if (!np)
+		return 0;
+
+	return of_clk_bulk_get_all(np, clks);
+}
+EXPORT_SYMBOL(clk_bulk_get_all);
+
 #ifdef CONFIG_HAVE_CLK_PREPARE
 
 /**
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dbd088..a76fdff 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -279,7 +279,26 @@ struct clk *clk_get(struct device *dev, const char *id);
  */
 int __must_check clk_bulk_get(struct device *dev, int num_clks,
 			      struct clk_bulk_data *clks);
-
+/**
+ * clk_bulk_get_all - lookup and obtain all available references to clock
+ *		      producer.
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * This helper function allows drivers to get all clk consumers in one
+ * operation. If any of the clk cannot be acquired then any clks
+ * that were obtained will be freed before returning to the caller.
+ *
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field.
+ * Returns 0 if there're none and a negative value if something failed.
+ *
+ * Drivers must assume that the clock source is not enabled.
+ *
+ * clk_bulk_get should not be called from within interrupt context.
+ */
+int __must_check clk_bulk_get_all(struct device *dev,
+				  struct clk_bulk_data **clks);
 /**
  * devm_clk_bulk_get - managed get multiple clk consumers
  * @dev: device for clock "consumer"
@@ -455,6 +474,19 @@ void clk_put(struct clk *clk);
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks);
 
 /**
+ * clk_bulk_put_all - "free" all the clock source
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * Note: drivers must ensure that all clk_bulk_enable calls made on this
+ * clock source are balanced by clk_bulk_disable calls prior to calling
+ * this function.
+ *
+ * clk_bulk_put_all should not be called from within interrupt context.
+ */
+void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks);
+
+/**
  * devm_clk_put	- "free" a managed clock source
  * @dev: device used to acquire the clock
  * @clk: clock source acquired with devm_clk_get()
@@ -609,6 +641,12 @@ static inline int __must_check clk_bulk_get(struct device *dev, int num_clks,
 	return 0;
 }
 
+static inline int __must_check clk_bulk_get_all(struct device *dev,
+					 struct clk_bulk_data **clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 {
 	return NULL;
@@ -630,6 +668,8 @@ static inline void clk_put(struct clk *clk) {}
 
 static inline void clk_bulk_put(int num_clks, struct clk_bulk_data *clks) {}
 
+static inline void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks) {}
+
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
 
 
-- 
2.7.4
