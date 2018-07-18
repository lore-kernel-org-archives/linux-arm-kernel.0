From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Wed, 18 Jul 2018 13:57:38 +0100
Subject: [PATCH] clk: Add functions to get optional clocks
Message-ID: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Behaves the same as (devm_)clk_get except where there is no clock
producer. In this case, instead of returning -ENOENT, the function
returns NULL. This makes error checking simpler and allows
clk_prepare_enable, etc to be called on the returned reference
without additional checks.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/clk-devres.c | 11 +++++++++++
 drivers/clk/clkdev.c     | 11 +++++++++++
 include/linux/clk.h      | 27 +++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..63295d9 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -34,6 +34,17 @@ struct clk *devm_clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(devm_clk_get);
 
+struct clk *devm_clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *c = devm_clk_get(dev, id);
+
+	if (PTR_ERR(c) == -ENOENT)
+		return NULL;
+
+	return c;
+}
+EXPORT_SYMBOL(devm_clk_get_optional);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411..7f2cd1e 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -209,6 +209,17 @@ struct clk *clk_get(struct device *dev, const char *con_id)
 }
 EXPORT_SYMBOL(clk_get);
 
+struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *c = clk_get(dev, id);
+
+	if (PTR_ERR(c) == -ENOENT)
+		return NULL;
+
+	return c;
+}
+EXPORT_SYMBOL(clk_get_optional);
+
 void clk_put(struct clk *clk)
 {
 	__clk_put(clk);
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dbd088..907202b 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -258,6 +258,14 @@ static inline void clk_bulk_unprepare(int num_clks, struct clk_bulk_data *clks)
 struct clk *clk_get(struct device *dev, const char *id);
 
 /**
+ * clk_get_optional - lookup and obtain a reference to optional clock producer.
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
@@ -316,6 +324,14 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
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
@@ -603,6 +619,11 @@ static inline struct clk *clk_get(struct device *dev, const char *id)
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
@@ -614,6 +635,12 @@ static inline struct clk *devm_clk_get(struct device *dev, const char *id)
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
