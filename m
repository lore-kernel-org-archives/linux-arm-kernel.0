From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 2 Apr 2013 23:09:37 +0200
Subject: [PATCH V4 1/3] clk: Restructure code for __clk_reparent
In-Reply-To: <1364936979-20805-1-git-send-email-ulf.hansson@stericsson.com>
References: <1364936979-20805-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1364936979-20805-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Split __clk_reparent into three pieces, one for doing the actual
reparent for updating the clock tree topology, one for the
COMMON_CLK_DEBUG code and one for doing the rate recalculation.

This patch also makes it possible to hold the spinlock over the
update of the clock tree topology, which could not be done before
when both debugfs updates and clock rate updates was done within
the same function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>
---
 drivers/clk/clk.c |   70 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 0230c9d..013a3c7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -343,6 +343,39 @@ out:
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
@@ -396,6 +429,9 @@ static int __init clk_debug_init(void)
 late_initcall(clk_debug_init);
 #else
 static inline int clk_debug_register(struct clk *clk) { return 0; }
+static inline void clk_debug_reparent(struct clk *clk, struct clk *new_parent)
+{
+}
 #endif
 
 /* caller must hold prepare_lock */
@@ -1277,16 +1313,8 @@ out:
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
@@ -1294,27 +1322,13 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
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
+}
 
+void __clk_reparent(struct clk *clk, struct clk *new_parent)
+{
+	clk_reparent(clk, new_parent);
+	clk_debug_reparent(clk, new_parent);
 	__clk_recalc_rates(clk, POST_RATE_CHANGE);
 }
 
-- 
1.7.10
