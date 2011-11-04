From: cavokz@gmail.com (Domenico Andreoli)
Date: Fri, 4 Nov 2011 18:59:08 +0100
Subject: [RFC PATCH] Generic clock parent enumeration
Message-ID: <20111104175908.GA9337@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

  here is my proposal for the enumeration of a clock parents and the
first implementation of clk_set_parent() based on it. It depends on
the generic-clk-v2 patchset.

The basic idea is that only the clock can provide a way to walk all
the parent clocks that it can be attached to. This has multiple purposes:

 1. generic clock framework is able to find the best parent a given
    clock can be attached to in order to satisfy an arbitrary requirement
    (ie the lowest number of enabled parent clocks, energy constrains,
    clock network tuning, etc)

 2. generic clock framework is able to check in an implementation
    independent way if a given clock is suitable to be parent of
    another one

 3. the proposed implementation of the generic clk_set_parent()


Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

---
 drivers/clk/clk.c   |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/clk.h |   32 ++++++++++++++++++++++----
 2 files changed, 88 insertions(+), 7 deletions(-)

Index: b/drivers/clk/clk.c
===================================================================
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -241,10 +241,69 @@ struct clk *clk_get_parent(struct clk *c
 }
 EXPORT_SYMBOL_GPL(clk_get_parent);
 
+struct clk *clk_next_parent(struct clk *clk, void **data)
+{
+	if (!clk || !data || !clk->ops->next_parent)
+		return NULL;
+
+	return clk->ops->next_parent(clk->hw, data);
+}
+EXPORT_SYMBOL_GPL(clk_next_parent);
+
+static int clk_is_valid_parent(struct clk *clk, struct clk *candidate)
+{
+	struct clk *parent;
+	void *data;
+
+	for_each_clk_parent(clk, parent, data)
+		if (parent == candidate)
+			return 1;
+
+	return 0;
+}
+
+static int __clk_set_parent(struct clk *clk, struct clk *new_parent)
+{
+	int ret;
+
+	if (!clk)
+		return -EINVAL;
+
+	if (WARN_ON(clk->prepare_count > 0))
+		return -EBUSY;
+
+	if (clk->parent == new_parent)
+		return 0;
+
+	if (!clk->ops->set_parent)
+		return -EINVAL;
+
+	if (!clk_is_valid_parent(clk, new_parent))
+		return -EINVAL;
+
+	ret = clk->ops->set_parent(clk->hw, new_parent->hw);
+	if (ret)
+		return ret;
+
+	if (clk->parent)
+		hlist_del(&clk->child_node);
+	if (new_parent)
+		hlist_add_head(&clk->child_node, &new_parent->children);
+
+	clk->parent = new_parent;
+	clk_recalc_rates(clk);
+	return 0;
+}
+
 int clk_set_parent(struct clk *clk, struct clk *parent)
 {
-	/* not yet implemented */
-	return -ENOSYS;
+	int ret;
+
+	mutex_lock(&prepare_lock);
+	ret = __clk_set_parent(clk, parent);
+	mutex_unlock(&prepare_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(clk_set_parent);
 
Index: b/include/linux/clk.h
===================================================================
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -55,17 +55,24 @@ struct clk_hw {
  *		held. Optional, but recommended - if this op is not set,
  *		clk_get_rate will return 0.
  *
- * @get_parent	Query the parent of this clock; for clocks with multiple
- *		possible parents, query the hardware for the current
- *		parent. Currently only called when the clock is first
- *		registered.
- *
  * @set_rate	Change the rate of this clock. If this callback returns
  *		CLK_SET_RATE_PROPAGATE, the rate change will be propagated to
  *		the parent clock (which may propagate again). The requested
  *		rate of the parent is passed back from the callback in the
  *		second 'unsigned long *' argument.
  *
+ * @get_parent	Query the parent of this clock; for clocks with multiple
+ *		possible parents, query the hardware for the current
+ *		parent. Currently only called when the clock is first
+ *		registered.
+ *
+ * @next_parent	Used to enumerate all the parents that the given clock is
+ *		able to attach to.
+ *
+ * @set_parent	Change the internal clock state/configuration so that the
+ *		clock is attached to the new parent. The new parent is
+ *		guaranteed to be one of those returned by next_parent().
+ *
  * The clk_enable/clk_disable and clk_prepare/clk_unprepare pairs allow
  * implementations to split any work between atomic (enable) and sleepable
  * (prepare) contexts.  If a clock requires sleeping code to be turned on, this
@@ -87,6 +94,8 @@ struct clk_hw_ops {
 	int		(*set_rate)(struct clk_hw *,
 					unsigned long, unsigned long *);
 	struct clk *	(*get_parent)(struct clk_hw *);
+	struct clk *	(*next_parent)(struct clk_hw *, void **);
+	int		(*set_parent)(struct clk_hw *, struct clk_hw *);
 };
 
 enum {
@@ -295,6 +304,19 @@ int clk_set_parent(struct clk *clk, stru
 struct clk *clk_get_parent(struct clk *clk);
 
 /**
+ * clk_next_parent - get the next valid parent of the given clock
+ * @clk: clock source
+ * @data: iterator's private data
+ *
+ * Returns struct clk corresponding to the next parent clock source,
+ * or NULL if no more (if any) valid parents are left.
+ */
+struct clk *clk_next_parent(struct clk *clk, void **data);
+
+#define for_each_clk_parent(clk, parent, data) \
+	for ((data) = NULL; ((parent) = clk_next_parent(clk, &data)); )
+
+/**
  * clk_get_sys - get a clock based upon the device name
  * @dev_id: device name
  * @con_id: connection ID
