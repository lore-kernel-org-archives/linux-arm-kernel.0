From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:33 +0530
Subject: [PATCH V2 13/69] ST SPEAr: Adding Debugfs support on clock framework
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <5a7bce117f170c3611e711cd4294844da62f7522.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/clock.c              |  116 ++++++++++++++++++++++++++++++
 arch/arm/plat-spear/include/plat/clock.h |    8 ++
 2 files changed, 124 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-spear/clock.c b/arch/arm/plat-spear/clock.c
index 8de7cf6..7d3338f 100644
--- a/arch/arm/plat-spear/clock.c
+++ b/arch/arm/plat-spear/clock.c
@@ -13,6 +13,7 @@
 
 #include <linux/bug.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/list.h>
@@ -22,8 +23,14 @@
 
 static DEFINE_SPINLOCK(clocks_lock);
 static LIST_HEAD(root_clks);
+#ifdef CONFIG_DEBUG_FS
+static LIST_HEAD(clocks);
+#endif
 
 static void propagate_rate(struct clk *, int on_init);
+#ifdef CONFIG_DEBUG_FS
+static int clk_debugfs_reparent(struct clk *);
+#endif
 
 static int generic_clk_enable(struct clk *clk)
 {
@@ -96,6 +103,10 @@ static void clk_reparent(struct clk *clk, struct pclk_info *pclk_info)
 
 	clk->pclk = pclk_info->pclk;
 	spin_unlock_irqrestore(&clocks_lock, flags);
+
+#ifdef CONFIG_DEBUG_FS
+	clk_debugfs_reparent(clk);
+#endif
 }
 
 static void do_clk_disable(struct clk *clk)
@@ -336,6 +347,12 @@ void clk_register(struct clk_lookup *cl)
 
 	spin_unlock_irqrestore(&clocks_lock, flags);
 
+	/* debugfs specific */
+#ifdef CONFIG_DEBUG_FS
+	list_add(&clk->node, &clocks);
+	clk->cl = cl;
+#endif
+
 	/* add clock to arm clockdev framework */
 	clkdev_add(cl);
 }
@@ -855,3 +872,102 @@ void recalc_root_clocks(void)
 	}
 	spin_unlock_irqrestore(&clocks_lock, flags);
 }
+
+#ifdef CONFIG_DEBUG_FS
+/*
+ *	debugfs support to trace clock tree hierarchy and attributes
+ */
+static struct dentry *clk_debugfs_root;
+static int clk_debugfs_register_one(struct clk *c)
+{
+	int err;
+	struct dentry *d, *child;
+	struct clk *pa = c->pclk;
+	char s[255];
+	char *p = s;
+
+	if (c) {
+		if (c->cl->con_id)
+			p += sprintf(p, "%s", c->cl->con_id);
+		if (c->cl->dev_id)
+			p += sprintf(p, "%s", c->cl->dev_id);
+	}
+	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
+	if (!d)
+		return -ENOMEM;
+	c->dent = d;
+
+	d = debugfs_create_u32("usage_count", S_IRUGO, c->dent,
+			(u32 *)&c->usage_count);
+	if (!d) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
+	if (!d) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	d = debugfs_create_x32("flags", S_IRUGO, c->dent, (u32 *)&c->flags);
+	if (!d) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+	return 0;
+
+err_out:
+	d = c->dent;
+	list_for_each_entry(child, &d->d_subdirs, d_u.d_child)
+		debugfs_remove(child);
+	debugfs_remove(c->dent);
+	return err;
+}
+
+static int clk_debugfs_register(struct clk *c)
+{
+	int err;
+	struct clk *pa = c->pclk;
+
+	if (pa && !pa->dent) {
+		err = clk_debugfs_register(pa);
+		if (err)
+			return err;
+	}
+
+	if (!c->dent) {
+		err = clk_debugfs_register_one(c);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+static int __init clk_debugfs_init(void)
+{
+	struct clk *c;
+	struct dentry *d;
+	int err;
+
+	d = debugfs_create_dir("clock", NULL);
+	if (!d)
+		return -ENOMEM;
+	clk_debugfs_root = d;
+
+	list_for_each_entry(c, &clocks, node) {
+		err = clk_debugfs_register(c);
+		if (err)
+			goto err_out;
+	}
+	return 0;
+err_out:
+	debugfs_remove_recursive(clk_debugfs_root);
+	return err;
+}
+late_initcall(clk_debugfs_init);
+
+static int clk_debugfs_reparent(struct clk *c)
+{
+	debugfs_remove(c->dent);
+	return clk_debugfs_register_one(c);
+}
+#endif /* CONFIG_DEBUG_FS */
diff --git a/arch/arm/plat-spear/include/plat/clock.h b/arch/arm/plat-spear/include/plat/clock.h
index f7b4b5a..621c17c 100644
--- a/arch/arm/plat-spear/include/plat/clock.h
+++ b/arch/arm/plat-spear/include/plat/clock.h
@@ -88,6 +88,9 @@ struct rate_config {
  * @children: list for childrens or this clock
  * @sibling: node for list of clocks having same parents
  * @private_data: clock specific private data
+ * @node: list to maintain clocks linearly
+ * @cl: clocklook up assoicated with this clock
+ * @dent: object for debugfs
  */
 struct clk {
 	unsigned int usage_count;
@@ -109,6 +112,11 @@ struct clk {
 	struct list_head children;
 	struct list_head sibling;
 	void *private_data;
+#ifdef CONFIG_DEBUG_FS
+	struct list_head node;
+	struct clk_lookup *cl;
+	struct dentry *dent;
+#endif
 };
 
 /* pll configuration structure */
-- 
1.7.2.2
