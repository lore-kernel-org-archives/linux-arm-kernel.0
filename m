From: jiada_wang@mentor.com (Jiada Wang)
Date: Mon, 3 Jun 2013 16:29:45 +0900
Subject: [PATCH] clk: implement clk_unregister
Message-ID: <1370244585-2646-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently clk_unregister is unimplemented, it is required in case
sub modules want actually remove clk device registered by clk_register.
This patch adds the implementation of clk_unregiser.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
CC: Eremin, Dmitry <Dmitry_Eremin@mentor.com>
CC: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/clk/clk.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 545d8dd..f9944b2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -152,6 +152,25 @@ out:
 }
 
 /**
+ * clk_debug_unregister - remove a clk node from the debugfs clk tree
+ * @clk: the clk being removed from the debugfs clk tree
+ *
+ * Dynamically removes a clk and all it's children clk nodes from the
+ * debugfs clk tree if clk->dentry points to debugfs created by
+ * clk_debug_register in __clk_init.
+ *
+ * Caller must hold prepare_lock.
+ *
+ */
+static void clk_debug_unregister(struct clk *clk)
+{
+	if (!clk || !clk->dentry)
+		return;
+
+	debugfs_remove_recursive(clk->dentry);
+}
+
+/**
  * clk_debug_init - lazily create the debugfs clk tree visualization
  *
  * clks are often initialized very early during boot before memory can
@@ -195,6 +214,7 @@ static int __init clk_debug_init(void)
 late_initcall(clk_debug_init);
 #else
 static inline int clk_debug_register(struct clk *clk) { return 0; }
+static inline void clk_debug_unregister(struct clk *clk) { return; }
 #endif
 
 /* caller must hold prepare_lock */
@@ -1447,9 +1467,42 @@ EXPORT_SYMBOL_GPL(clk_register);
  * clk_unregister - unregister a currently registered clock
  * @clk: clock to unregister
  *
- * Currently unimplemented.
  */
-void clk_unregister(struct clk *clk) {}
+void clk_unregister(struct clk *clk)
+{
+	int i;
+
+	if (!clk)
+		return;
+
+	mutex_lock(&prepare_lock);
+	if (clk->prepare_count) {
+		pr_debug("%s: can't unregister clk %s, it is prepared\n",
+				__func__, clk->name);
+		goto out;
+	}
+
+	if (!hlist_empty(&clk->children)) {
+		pr_debug("%s: clk %s has registered children\n",
+				__func__, clk->name);
+		goto out;
+	}
+
+	clk_debug_unregister(clk);
+
+	hlist_del_init(&clk->child_node);
+
+	kfree(clk->parents);
+	i = clk->num_parents;
+	while (--i >= 0)
+		kfree(clk->parent_names[i]);
+	kfree(clk->parent_names);
+	kfree(clk->name);
+	kfree(clk);
+out:
+	mutex_unlock(&prepare_lock);
+	return;
+}
 EXPORT_SYMBOL_GPL(clk_unregister);
 
 /***        clk rate change notifiers        ***/
-- 
1.8.1.1
