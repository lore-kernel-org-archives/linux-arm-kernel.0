From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 25 Jan 2013 12:40:55 +0100
Subject: [PATCH 1/3] clk: Remove _clk_reparent from API and restructure code
In-Reply-To: <1359114057-11681-1-git-send-email-ulf.hansson@stericsson.com>
References: <1359114057-11681-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1359114057-11681-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

There shall be no reason for keeping this API available for clock
providers. So we remove it from the API and restrcuture the code so
for example the COMMON_CLK_DEBUG part is separated.

This patch will also make it possible to hold the spinlock over the
actual update of the clock tree topology, which could not be done
before when both debugfs updates and clock rate updates was done
within the same function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/clk.c            |   82 ++++++++++++++++++++++++------------------
 include/linux/clk-provider.h |    1 -
 2 files changed, 48 insertions(+), 35 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 593a2e4..2e10cc1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -284,6 +284,39 @@ out:
 }
 
 /**
+ * clk_debug_reparent - reparent clk node in the debugfs clk tree
+ * @clk: the clk being reparented
+ * @new_parent: the new clk parent, may be NULL
+ *
+ * Rename clk entry in the debugfs clk tree if debugfs has been
+ * initialized.  Otherwise it bails out early since the debugfs clk tree
+ * will be created lazily by clk_debug_init as part of a late_initcall.
+ *
+ * Caller must hold prepare_lock.
+ */
+static void clk_debug_reparent(struct clk *clk, struct clk *new_parent)
+{
+	struct dentry *d;
+	struct dentry *new_parent_d;
+
+	if (!inited)
+		return;
+
+	if (new_parent)
+		new_parent_d = new_parent->dentry;
+	else
+		new_parent_d = orphandir;
+
+	d = debugfs_rename(clk->dentry->d_parent, clk->dentry,
+			new_parent_d, clk->name);
+	if (d)
+		clk->dentry = d;
+	else
+		pr_debug("%s: failed to rename debugfs entry for %s\n",
+				__func__, clk->name);
+}
+
+/**
  * clk_debug_init - lazily create the debugfs clk tree visualization
  *
  * clks are often initialized very early during boot before memory can
@@ -338,6 +371,9 @@ static int __init clk_debug_init(void)
 late_initcall(clk_debug_init);
 #else
 static inline int clk_debug_register(struct clk *clk) { return 0; }
+static inline void clk_debug_reparent(struct clk *clk, struct clk *new_parent)
+{
+}
 #endif
 
 /* caller must hold prepare_lock */
@@ -1179,16 +1215,8 @@ out:
 	return ret;
 }
 
-void __clk_reparent(struct clk *clk, struct clk *new_parent)
+static void clk_reparent(struct clk *clk, struct clk *new_parent)
 {
-#ifdef CONFIG_COMMON_CLK_DEBUG
-	struct dentry *d;
-	struct dentry *new_parent_d;
-#endif
-
-	if (!clk || !new_parent)
-		return;
-
 	hlist_del(&clk->child_node);
 
 	if (new_parent)
@@ -1196,28 +1224,7 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
 	else
 		hlist_add_head(&clk->child_node, &clk_orphan_list);
 
-#ifdef CONFIG_COMMON_CLK_DEBUG
-	if (!inited)
-		goto out;
-
-	if (new_parent)
-		new_parent_d = new_parent->dentry;
-	else
-		new_parent_d = orphandir;
-
-	d = debugfs_rename(clk->dentry->d_parent, clk->dentry,
-			new_parent_d, clk->name);
-	if (d)
-		clk->dentry = d;
-	else
-		pr_debug("%s: failed to rename debugfs entry for %s\n",
-				__func__, clk->name);
-out:
-#endif
-
 	clk->parent = new_parent;
-
-	__clk_recalc_rates(clk, POST_RATE_CHANGE);
 }
 
 static int __clk_set_parent(struct clk *clk, struct clk *parent)
@@ -1329,7 +1336,9 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 	}
 
 	/* propagate rate recalculation downstream */
-	__clk_reparent(clk, parent);
+	clk_reparent(clk, parent);
+	clk_debug_reparent(clk, parent);
+	__clk_recalc_rates(clk, POST_RATE_CHANGE);
 
 out:
 	mutex_unlock(&prepare_lock);
@@ -1453,14 +1462,19 @@ int __clk_init(struct device *dev, struct clk *clk)
 	hlist_for_each_entry_safe(orphan, tmp, tmp2, &clk_orphan_list, child_node) {
 		if (orphan->ops->get_parent) {
 			i = orphan->ops->get_parent(orphan->hw);
-			if (!strcmp(clk->name, orphan->parent_names[i]))
-				__clk_reparent(orphan, clk);
+			if (!strcmp(clk->name, orphan->parent_names[i])) {
+				clk_reparent(orphan, clk);
+				clk_debug_reparent(orphan, clk);
+				__clk_recalc_rates(orphan, POST_RATE_CHANGE);
+			}
 			continue;
 		}
 
 		for (i = 0; i < orphan->num_parents; i++)
 			if (!strcmp(clk->name, orphan->parent_names[i])) {
-				__clk_reparent(orphan, clk);
+				clk_reparent(orphan, clk);
+				clk_debug_reparent(orphan, clk);
+				__clk_recalc_rates(orphan, POST_RATE_CHANGE);
 				break;
 			}
 	 }
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4989b8a..87a7c2c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -359,7 +359,6 @@ struct clk *__clk_lookup(const char *name);
  */
 int __clk_prepare(struct clk *clk);
 void __clk_unprepare(struct clk *clk);
-void __clk_reparent(struct clk *clk, struct clk *new_parent);
 unsigned long __clk_round_rate(struct clk *clk, unsigned long rate);
 
 struct of_device_id;
-- 
1.7.10
