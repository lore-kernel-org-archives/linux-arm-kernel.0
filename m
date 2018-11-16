From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 16 Nov 2018 14:59:33 +0000
Subject: [PATCH v6 2/6] clk: Add (devm_)clk_get_optional() functions
In-Reply-To: <20181116145937.27660-1-phil.edworthy@renesas.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
Message-ID: <20181116145937.27660-3-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds clk_get_optional() and devm_clk_get_optional() functions to get
optional clocks.
They behave the same as (devm_)clk_get except where there is no clock
producer. In this case, instead of returning -ENOENT, the function
returns NULL. This makes error checking simpler and allows
clk_prepare_enable, etc to be called on the returned reference
without additional checks.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v6:
 - Add doxygen style comment for devm_clk_get_optional() args
v5:
 - No changes.
v4:
 - No changes.
v3:
 - No changes.
---
 drivers/clk/clk-devres.c | 18 ++++++++++++++++--
 drivers/clk/clkdev.c     | 17 +++++++++++++++--
 include/linux/clk.h      | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 12c87457eca1..be07536725a2 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -14,7 +14,7 @@ static void devm_clk_release(struct device *dev, void *res)
 	clk_put(*(struct clk **)res);
 }
 
-struct clk *devm_clk_get(struct device *dev, const char *id)
+static struct clk *__devm_clk_get(struct device *dev, const char *id, bool optional)
 {
 	struct clk **ptr, *clk;
 
@@ -22,7 +22,10 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	clk = clk_get(dev, id);
+	if (!optional)
+		clk = clk_get(dev, id);
+	else
+		clk = clk_get_optional(dev, id);
 	if (!IS_ERR(clk)) {
 		*ptr = clk;
 		devres_add(dev, ptr);
@@ -32,8 +35,19 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 
 	return clk;
 }
+
+struct clk *devm_clk_get(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, false);
+}
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	return __devm_clk_get(dev, id, true);
+}
+EXPORT_SYMBOL(devm_clk_get_optional);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 0c655d1ba1d9..ebf3afef4371 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -241,21 +241,34 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get_sys);
 
-struct clk *clk_get(struct device *dev, const char *con_id)
+static struct clk *internal_clk_get(struct device *dev, const char *con_id,
+				    bool optional)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct clk *clk;
 
 	if (dev && dev->of_node) {
-		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id, false);
+		clk = __of_clk_get_by_name(dev->of_node, dev_id, con_id,
+					   optional);
 		if (!IS_ERR(clk) || PTR_ERR(clk) == -EPROBE_DEFER)
 			return clk;
 	}
 
 	return clk_get_sys(dev_id, con_id);
 }
+
+struct clk *clk_get(struct device *dev, const char *con_id)
+{
+	return internal_clk_get(dev, con_id, false);
+}
 EXPORT_SYMBOL(clk_get);
 
+struct clk *clk_get_optional(struct device *dev, const char *con_id)
+{
+	return internal_clk_get(dev, con_id, true);
+}
+EXPORT_SYMBOL(clk_get_optional);
+
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 84512b3ecf5c..58bebc32133e 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -290,6 +290,16 @@ static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
  */
 struct clk *clk_get(struct device *dev, const char *id);
 
+/**
+ * clk_get_optional - lookup and obtain a reference to optional clock producer.
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as clk_get except where there is no clock producer. In this
+ * case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *clk_get_optional(struct device *dev, const char *id);
+
 /**
  * clk_bulk_get - lookup and obtain a number of references to clock producer.
  * @dev: device for clock "consumer"
@@ -383,6 +393,17 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
  */
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
+/**
+ * devm_clk_get_optional - lookup and obtain a managed reference to an optional
+ *			   clock producer.
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as devm_clk_get except where there is no clock producer. In
+ * this case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *devm_clk_get_optional(struct device *dev, const char *id);
+
 /**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
@@ -701,6 +722,11 @@ static inline struct clk *clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	return NULL;
+}
+
 static inline int __must_check clk_bulk_get(struct device *dev, int num_clks,
 					    struct clk_bulk_data *clks)
 {
@@ -718,6 +744,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 	return NULL;
 }
 
+static inline struct clk *devm_clk_get_optional(struct device *dev,
+						const char *id)
+{
+	return NULL;
+}
+
 static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 						 struct clk_bulk_data *clks)
 {
-- 
2.17.1
