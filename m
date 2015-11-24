From: heiko.stuebner@collabora.com (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 24 Nov 2015 13:42:35 +0100
Subject: [RFC PATCH v3] clk: defer clk_gets on orphan clocks
Message-ID: <1483326.lTmfGmv5pO@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orphan clocks or children of orphan clocks don't have rate information at
all and can produce strange results if they're allowed to be used and the
parent becomes available later on.

This change, based on one from Stephen Boyd, defers __clk_create_clk()
calls on orphan clocks in all regular cases.

One special case that gets handled, is accessing such orphan clocks when
handling assigned-clocks configurations. In the boot-defaults it may be
the case that a clock is connected to an orphan parent which then might
be needed to get reparented to an actually usable clock using
assigned-clock-parents. In this case even orphaned clocks should be
usable, but only for the set-parent case.

The added of_clk_get_from_provider_with_orphans() is only available
to ccf internal parts to prevent abuse.

Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
---
This of course will still break sunxi, hence the RFC state for now.
As there is work pending for critical/handed-off clocks, I'm hoping
this can move forward at some point :-) .

I'd mainly like to get feedback if the assigned-clocks case looks ok
or should move somewhere else.

changes in v3:
- add special handling for assigned-clock-parents to allow reparenting
  of orphaned child-clocks.

changes in v2 (Stephens version):
- find a better place for the deferral

 drivers/clk/clk-conf.c |  5 +++--
 drivers/clk/clk.c      | 48 ++++++++++++++++++++++++++++++++++++++----------
 drivers/clk/clk.h      | 10 +++++++---
 drivers/clk/clkdev.c   |  4 ++--
 4 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 43a218f..60ebfd9 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/of.h>
 #include <linux/printk.h>
+#include "clk.h"
 
 static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 {
@@ -38,7 +39,7 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 		}
 		if (clkspec.np == node && !clk_supplier)
 			return 0;
-		pclk = of_clk_get_from_provider(&clkspec);
+		pclk = of_clk_get_from_provider_with_orphans(&clkspec);
 		if (IS_ERR(pclk)) {
 			pr_warn("clk: couldn't get parent clock %d for %s\n",
 				index, node->full_name);
@@ -53,7 +54,7 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 			rc = 0;
 			goto err;
 		}
-		clk = of_clk_get_from_provider(&clkspec);
+		clk = of_clk_get_from_provider_with_orphans(&clkspec);
 		if (IS_ERR(clk)) {
 			pr_warn("clk: couldn't get parent clock %d for %s\n",
 				index, node->full_name);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f13c3f4..46760cb 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2476,15 +2476,11 @@ out:
 	return ret;
 }
 
-struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
-			     const char *con_id)
+static struct clk *clk_hw_create_clk(struct clk_hw *hw, const char *dev_id,
+				     const char *con_id)
 {
 	struct clk *clk;
 
-	/* This is to allow this function to be chained to others */
-	if (!hw || IS_ERR(hw))
-		return (struct clk *) hw;
-
 	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk)
 		return ERR_PTR(-ENOMEM);
@@ -2501,6 +2497,19 @@ struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
 	return clk;
 }
 
+struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
+			     const char *con_id, bool with_orphans)
+{
+	/* This is to allow this function to be chained to others */
+	if (!hw || IS_ERR(hw))
+		return (struct clk *) hw;
+
+	if (hw->core->orphan && !with_orphans)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return clk_hw_create_clk(hw, dev_id, con_id);
+}
+
 void __clk_free_clk(struct clk *clk)
 {
 	clk_prepare_lock();
@@ -2569,7 +2578,7 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 
 	INIT_HLIST_HEAD(&core->clks);
 
-	hw->clk = __clk_create_clk(hw, NULL, NULL);
+	hw->clk = clk_hw_create_clk(hw, NULL, NULL);
 	if (IS_ERR(hw->clk)) {
 		ret = PTR_ERR(hw->clk);
 		goto fail_parent_names_copy;
@@ -3002,7 +3011,8 @@ void of_clk_del_provider(struct device_node *np)
 EXPORT_SYMBOL_GPL(of_clk_del_provider);
 
 struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
-				       const char *dev_id, const char *con_id)
+				       const char *dev_id, const char *con_id,
+				       bool with_orphans)
 {
 	struct of_clk_provider *provider;
 	struct clk *clk = ERR_PTR(-EPROBE_DEFER);
@@ -3017,7 +3027,7 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
 			clk = provider->get(clkspec, provider->data);
 		if (!IS_ERR(clk)) {
 			clk = __clk_create_clk(__clk_get_hw(clk), dev_id,
-					       con_id);
+					       con_id, with_orphans);
 
 			if (!IS_ERR(clk) && !__clk_get(clk)) {
 				__clk_free_clk(clk);
@@ -3042,7 +3052,25 @@ struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
  */
 struct clk *of_clk_get_from_provider(struct of_phandle_args *clkspec)
 {
-	return __of_clk_get_from_provider(clkspec, NULL, __func__);
+	return __of_clk_get_from_provider(clkspec, NULL, __func__, false);
+}
+
+/**
+ * of_clk_get_from_provider_with_orphans() - Lookup clock from a clock provider
+ * @clkspec: pointer to a clock specifier data structure
+ *
+ * This function looks up a struct clk from the registered list of clock
+ * providers, an input is a clock specifier data structure as returned
+ * from the of_parse_phandle_with_args() function call.
+ *
+ * The difference to of_clk_get_from_provider() is that this function will
+ * also successfully lookup orphan-clocks, as it in some cases may be
+ * necessary to access such orphan-clocks as well.
+ */
+struct clk *
+of_clk_get_from_provider_with_orphans(struct of_phandle_args *clkspec)
+{
+	return __of_clk_get_from_provider(clkspec, NULL, __func__, true);
 }
 
 int of_clk_get_parent_count(struct device_node *np)
diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index 00b35a1..5a70f09 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -13,17 +13,21 @@ struct clk_hw;
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 struct clk *__of_clk_get_from_provider(struct of_phandle_args *clkspec,
-				       const char *dev_id, const char *con_id);
+				       const char *dev_id, const char *con_id,
+				       bool with_orphans);
+struct clk *
+of_clk_get_from_provider_with_orphans(struct of_phandle_args *clkspec);
 #endif
 
 #ifdef CONFIG_COMMON_CLK
 struct clk *__clk_create_clk(struct clk_hw *hw, const char *dev_id,
-			     const char *con_id);
+			     const char *con_id, bool with_orphans);
 void __clk_free_clk(struct clk *clk);
 #else
 /* All these casts to avoid ifdefs in clkdev... */
 static inline struct clk *
-__clk_create_clk(struct clk_hw *hw, const char *dev_id, const char *con_id)
+__clk_create_clk(struct clk_hw *hw, const char *dev_id, const char *con_id,
+		 bool with_orphans)
 {
 	return (struct clk *)hw;
 }
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 779b6ff..eda20c2 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -43,7 +43,7 @@ static struct clk *__of_clk_get(struct device_node *np, int index,
 	if (rc)
 		return ERR_PTR(rc);
 
-	clk = __of_clk_get_from_provider(&clkspec, dev_id, con_id);
+	clk = __of_clk_get_from_provider(&clkspec, dev_id, con_id, false);
 	of_node_put(clkspec.np);
 
 	return clk;
@@ -177,7 +177,7 @@ struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 	if (!cl)
 		goto out;
 
-	clk = __clk_create_clk(cl->clk_hw, dev_id, con_id);
+	clk = __clk_create_clk(cl->clk_hw, dev_id, con_id, false);
 	if (IS_ERR(clk))
 		goto out;
 
-- 
2.6.1
