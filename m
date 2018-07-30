From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 30 Jul 2018 14:31:49 +0100
Subject: [PATCH v3 2/2] clk: Add functions to get optional clocks
In-Reply-To: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
References: <1532957509-14541-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1532957509-14541-3-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Behaves the same as (devm_)clk_get except where there is no clock
producer. In this case, instead of returning -ENOENT, the function
returns NULL. This makes error checking simpler and allows
clk_prepare_enable, etc to be called on the returned reference
without additional checks.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v3:
 - No changes.
---
 drivers/clk/clk-devres.c | 18 ++++++++++++++++--
 drivers/clk/clkdev.c     | 17 +++++++++++++++--
 include/linux/clk.h      | 29 +++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..a2bb01a 100644
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
index a710333..2245ba6 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -219,21 +219,34 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
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
index de0e5e0..58ec7bc 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -291,6 +291,16 @@ static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
 struct clk *clk_get(struct device *dev, const char *id);
 
 /**
+ * clk_get_optional - lookup and obtain a reference to optional clock producer.
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Behaves the same as clk_get except where there is no clock producer. In this
+ * case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *clk_get_optional(struct device *dev, const char *id);
+
+/**
  * clk_bulk_get - lookup and obtain a number of references to clock producer.
  * @dev: device for clock "consumer"
  * @num_clks: the number of clk_bulk_data
@@ -349,6 +359,14 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 struct clk *devm_clk_get(struct device *dev, const char *id);
 
 /**
+ * devm_clk_get_optional - lookup and obtain a managed reference to an optional
+ *			   clock producer.
+ * Behaves the same as devm_clk_get except where there is no clock producer. In
+ * this case, instead of returning -ENOENT, the function returns NULL.
+ */
+struct clk *devm_clk_get_optional(struct device *dev, const char *id);
+
+/**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
  * @dev: device for clock "consumer"
@@ -636,6 +654,11 @@ static inline struct clk *clk_get(struct device *dev, const char *id)
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
@@ -647,6 +670,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
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
2.7.4
