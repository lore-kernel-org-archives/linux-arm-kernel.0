From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 13 Apr 2012 12:04:57 +0530
Subject: [PATCH] clk: Allocate and add clock lookups from clk_register()
Message-ID: <9fa570d09d94cdc4892b4e413ef3a0edc6f9dcef.1334298848.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clock lookups are required for few clocks for which we do clk_get() or
clk_get_sys(). Adding clock lookups for them with new clock framework, would
mean a lot of code for each platform. Simplify this by doing this allocation and
addition to global list in clk_register() only.

This is done on request by the caller, i.e. only if user passes valid pointers
in "dev_id" OR "con_id" fields.

A lot of changes at other places/files/comments are also required, that i would
do separately. This is the initial version to get initial feedback.

Pointer to original discussion:
http://www.spinics.net/lists/arm-kernel/msg169133.html

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk.c            |   33 ++++++++++++++++++++++++++-------
 include/linux/clk-provider.h |    4 +++-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2bcce5a..16ce136 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -9,6 +9,7 @@
  * Standard functionality for the common clock API.  See Documentation/clk.txt
  */
 
+#include <linux/clkdev.h>
 #include <linux/clk-private.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1341,7 +1342,8 @@ out:
  */
 struct clk *clk_register(struct device *dev, const char *name,
 		const struct clk_ops *ops, struct clk_hw *hw,
-		const char **parent_names, u8 num_parents, unsigned long flags)
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		struct clk_lookup **cl, const char *dev_id, const char *con_id)
 {
 	int i, ret = -ENOMEM;
 	struct clk *clk;
@@ -1365,7 +1367,7 @@ struct clk *clk_register(struct device *dev, const char *name,
 
 	if (!clk->parent_names) {
 		pr_err("%s: could not allocate clk->parent_names\n", __func__);
-		goto fail_parent_names;
+		goto free_clk;
 	}
 
 	/* copy each string name in case parent_names is __initdata */
@@ -1373,19 +1375,36 @@ struct clk *clk_register(struct device *dev, const char *name,
 		clk->parent_names[i] = kstrdup(parent_names[i], GFP_KERNEL);
 		if (!clk->parent_names[i]) {
 			pr_err("%s: could not copy parent_names\n", __func__);
-			goto fail_parent_names_copy;
+			goto free_parents;
 		}
 	}
 
 	ret = __clk_init(dev, clk);
-	if (!ret)
-		return clk;
+	if (ret)
+		goto free_parents;
+
+	if (dev_id || con_id) {
+		struct clk_lookup *lookup;
+
+		lookup = clkdev_alloc(clk, dev_id, con_id);
+		if (!lookup) {
+			ret = ENODEV;
+			goto free_parents;
+		}
+
+		clkdev_add(lookup);
+
+		if (cl)
+			*cl = lookup;
+	}
+
+	return clk;
 
-fail_parent_names_copy:
+free_parents:
 	while (--i >= 0)
 		kfree(clk->parent_names[i]);
 	kfree(clk->parent_names);
-fail_parent_names:
+free_clk:
 	kfree(clk);
 fail_out:
 	return ERR_PTR(ret);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 8bb93c4..a50119d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -12,6 +12,7 @@
 #define __LINUX_CLK_PROVIDER_H
 
 #include <linux/clk.h>
+#include <linux/clkdev.h>
 
 #ifdef CONFIG_COMMON_CLK
 
@@ -281,7 +282,8 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
  */
 struct clk *clk_register(struct device *dev, const char *name,
 		const struct clk_ops *ops, struct clk_hw *hw,
-		const char **parent_names, u8 num_parents, unsigned long flags);
+		const char **parent_names, u8 num_parents, unsigned long flags,
+		struct clk_lookup **cl, const char *dev_id, const char *con_id);
 
 /* helper functions */
 const char *__clk_get_name(struct clk *clk);
-- 
1.7.9
