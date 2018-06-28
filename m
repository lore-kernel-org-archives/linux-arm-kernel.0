From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Thu, 28 Jun 2018 10:54:53 +0300
Subject: [PATCH] clk: clkdev - add managed versions of lookup registrations
Message-ID: <20180628075453.GA7793@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devm_clk_hw_register_clkdev, devm_clk_register_clkdev and
devm_clk_release_clkdev as a first styep to clean up drivers which are
leaking clkdev lookups at driver remove.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

While searching for example on how clk drivers release clkdev at exit
I found that many of those don't. Simple grep for clkdev under
drivers/clk suggest that bunch of drivers which call clk_register_clkdev
or clk_hw_register_clkdev never call clkdev_drop. In order to help
cleaning this up I decided to add devm versions of clk_register_clkdev
and clk_hw_register_clkdev. I hope this would allow simply converting
bunch of calls to clk_register_clkdev and clk_hw_register_clkdev into
managed versions without building further clean up logic.

Please review this carefully. I have only performed some simple tests
with my BD71837 driver. And as I have only limited understanding on
clkdev lookups I may have done mistakes. Thanks!

 drivers/clk/clkdev.c   | 165 +++++++++++++++++++++++++++++++++++++++++--------
 include/linux/clkdev.h |   8 +++
 2 files changed, 147 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411140b6..4752a0004a6c 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -390,7 +390,7 @@ void clkdev_drop(struct clk_lookup *cl)
 }
 EXPORT_SYMBOL(clkdev_drop);
 
-static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
+static struct clk_lookup *do_clk_register_clkdev(struct clk_hw *hw,
 						const char *con_id,
 						const char *dev_id, ...)
 {
@@ -404,6 +404,24 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 	return cl;
 }
 
+static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
+	const char *con_id, const char *dev_id)
+{
+	struct clk_lookup *cl;
+
+	/*
+	 * Since dev_id can be NULL, and NULL is handled specially, we must
+	 * pass it as either a NULL format string, or with "%s".
+	 */
+	if (dev_id)
+		cl = do_clk_register_clkdev(hw, con_id, "%s",
+					   dev_id);
+	else
+		cl = do_clk_register_clkdev(hw, con_id, NULL);
+
+	return cl;
+}
+
 /**
  * clk_register_clkdev - register one clock lookup for a struct clk
  * @clk: struct clk to associate with all clk_lookups
@@ -421,22 +439,18 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 int clk_register_clkdev(struct clk *clk, const char *con_id,
 	const char *dev_id)
 {
-	struct clk_lookup *cl;
-
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	int rval = 0;
 
-	/*
-	 * Since dev_id can be NULL, and NULL is handled specially, we must
-	 * pass it as either a NULL format string, or with "%s".
-	 */
-	if (dev_id)
-		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, "%s",
-					   dev_id);
-	else
-		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, NULL);
+	if (IS_ERR(clk)) {
+		rval = PTR_ERR(clk);
+	} else {
+		struct clk_lookup *cl;
 
-	return cl ? 0 : -ENOMEM;
+		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, dev_id);
+		if (!cl)
+			rval = -ENOMEM;
+	}
+	return rval;
 }
 EXPORT_SYMBOL(clk_register_clkdev);
 
@@ -456,21 +470,120 @@ EXPORT_SYMBOL(clk_register_clkdev);
  */
 int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
 	const char *dev_id)
+{
+	int rval = 0;
+
+	if (IS_ERR(hw)) {
+		rval = PTR_ERR(hw);
+	} else {
+		struct clk_lookup *cl;
+
+		cl = __clk_register_clkdev(hw, con_id, dev_id);
+		if (!cl)
+			rval = -ENOMEM;
+	}
+
+	return rval;
+}
+EXPORT_SYMBOL(clk_hw_register_clkdev);
+
+static void devm_clkdev_release(struct device *dev, void *res)
+{
+	clkdev_drop(*(struct clk_lookup **)res);
+}
+
+static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
+{
+	struct clk_lookup **l = res;
+
+	if (!l || !*l) {
+		WARN_ON(!l || !*l);
+		return 0;
+	}
+
+	return *l == data;
+}
+
+/**
+ * devm_clk_release_clkdev - Resource managed clkdev lookup release
+ * @dev: device this lookup is bound
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * Drop the clkdev lookup created with devm_clk_hw_register_clkdev or
+ * with devm_clk_register_clkdev. Normally this function will not need to be
+ * called and the resource management code will ensure that the resource is
+ * freed.
+ */
+void devm_clk_release_clkdev(struct device *dev, const char *con_id,
+			     const char *dev_id)
 {
 	struct clk_lookup *cl;
+	int rval;
+
+	cl = clk_find(dev_id, con_id);
+	WARN_ON(!cl);
+	rval = devres_release(dev, devm_clkdev_release,
+			      &devm_clk_match_clkdev, cl);
+	WARN_ON(rval);
+}
+EXPORT_SYMBOL(devm_clk_release_clkdev);
+
+/**
+ * devm_clk_hw_register_clkdev - managed clk lookup registration for clk_hw
+ * @dev: device this lookup is bound
+ * @hw: struct clk_hw to associate with all clk_lookups
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * con_id or dev_id may be NULL as a wildcard, just as in the rest of
+ * clkdev.
+ *
+ * To make things easier for mass registration, we detect error clk_hws
+ * from a previous clk_hw_register_*() call, and return the error code for
+ * those.  This is to permit this function to be called immediately
+ * after clk_hw_register_*().
+ */
+int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
+				const char *con_id, const char *dev_id)
+{
+	struct clk_lookup **cl = NULL;
 
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
+	cl = devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
+	if (cl) {
+		*cl = __clk_register_clkdev(hw, con_id, dev_id);
+		if (*cl)
+			devres_add(dev, cl);
+		else
+			devres_free(cl);
+	}
+	return (cl && *cl) ? 0 : -ENOMEM;
+}
+EXPORT_SYMBOL(devm_clk_hw_register_clkdev);
 
-	/*
-	 * Since dev_id can be NULL, and NULL is handled specially, we must
-	 * pass it as either a NULL format string, or with "%s".
-	 */
-	if (dev_id)
-		cl = __clk_register_clkdev(hw, con_id, "%s", dev_id);
-	else
-		cl = __clk_register_clkdev(hw, con_id, NULL);
-
-	return cl ? 0 : -ENOMEM;
+/**
+ * devm_clk_register_clkdev - managed clk lookup registration for a struct clk
+ * @dev: device this lookup is bound
+ * @clk: struct clk to associate with all clk_lookups
+ * @con_id: connection ID string on device
+ * @dev_id: string describing device name
+ *
+ * con_id or dev_id may be NULL as a wildcard, just as in the rest of
+ * clkdev.
+ *
+ * To make things easier for mass registration, we detect error clks
+ * from a previous clk_register() call, and return the error code for
+ * those.  This is to permit this function to be called immediately
+ * after clk_register().
+ */
+int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
+			     const char *con_id, const char *dev_id)
+{
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	return devm_clk_hw_register_clkdev(dev, __clk_get_hw(clk), con_id,
+					   dev_id);
 }
-EXPORT_SYMBOL(clk_hw_register_clkdev);
+EXPORT_SYMBOL(devm_clk_register_clkdev);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 4890ff033220..27ebeae8ae26 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -52,4 +52,12 @@ int clk_add_alias(const char *, const char *, const char *, struct device *);
 int clk_register_clkdev(struct clk *, const char *, const char *);
 int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
 
+int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
+			     const char *con_id, const char *dev_id);
+int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
+				const char *con_id, const char *dev_id);
+void devm_clk_release_clkdev(struct device *dev, const char *con_id,
+			     const char *dev_id);
+
+
 #endif
-- 
2.14.3
