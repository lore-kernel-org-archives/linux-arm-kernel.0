From: pankaj.dev@st.com (Pankaj Dev)
Date: Fri, 26 Feb 2016 08:08:29 +0530
Subject: [RFC v1] clk: Add debugfs nodes for enable/disable/set-rate/set-parent
Message-ID: <1456454309-25037-1-git-send-email-pankaj.dev@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enhance debug interface for clocks, we add the following
interfaces to the clock nodes created at
/sys/kernel/debug/clk/CLOCK_NAME

1. clk_set_rate : Set new rate to value. Reading returns the
current rate
2. clk_set_parent : Set new parent to parent-name. Reading
returns the current parent
3. clk_prepare_enable : Call clk_prepare_enable X times,
X is the input value
4. clk_disable_unprepare : Call clk_disable_unprepare X
times, X is the input value

This is particularly useful during SoC bring-up phase, and also when
drivers want to verify if some issue is caused by clocks turning off at
wrong moments.

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>

---
 drivers/clk/clk.c |  143 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 143 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cbc72a1..aa08023 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -21,6 +21,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/sched.h>
+#include <linux/uaccess.h>
 
 #include "clk.h"
 
@@ -348,6 +349,128 @@ static const struct file_operations clk_dump_fops = {
 	.release	= single_release,
 };
 
+/* Debugfs set_rate entry */
+static int clk_debug_rate_get(void *data, u64 *rate)
+{
+	struct clk_core *c = data;
+
+	*rate = clk_get_rate(c->hw->clk);
+
+	return 0;
+}
+
+static int clk_debug_rate_set(void *data, u64 rate)
+{
+	struct clk_core *c = data;
+
+	return clk_set_rate(c->hw->clk, rate);
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(clk_debug_rate_fops, clk_debug_rate_get,
+			clk_debug_rate_set, "%lld\n");
+
+/* Debugfs prepare_enable entry */
+static int clk_debug_prep_enable(void *data, u64 count)
+{
+	struct clk_core *c = data;
+	int i, ret = 0;
+
+	for (i = 0; i < count; i++) {
+		ret = clk_prepare_enable(c->hw->clk);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(clk_debug_prep_enable_fops, NULL,
+			clk_debug_prep_enable, "%lld\n");
+
+/* Debugfs disable_unprepare entry */
+static int clk_debug_disable_unprep(void *data, u64 count)
+{
+	struct clk_core *c = data;
+	int i;
+
+	for (i = 0; i < count; i++)
+		clk_disable_unprepare(c->hw->clk);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(clk_debug_disable_unprep_fops, NULL,
+			clk_debug_disable_unprep, "%lld\n");
+
+/* Debugfs set_parent entry */
+static int clk_debug_parent_get(struct file *file,
+					char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct clk_core *c = file->private_data;
+	struct clk *p;
+	int ret;
+
+	if (*ppos)		/* continued read */
+		return 0;
+
+	p = clk_get_parent(c->hw->clk);
+	count = min(strlen(__clk_get_name(p)), count);
+
+	ret = copy_to_user(user_buf, __clk_get_name(p), count);
+	if (ret) {
+		pr_err("%s: error reading data\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Add \n */
+	ret = copy_to_user(user_buf + count, "\n", 1);
+	if (ret) {
+		pr_err("%s: error reading data\n", __func__);
+		return -EINVAL;
+	}
+	count++;
+
+	*ppos += count;
+
+	return count;
+}
+
+static int clk_debug_parent_set(struct file *file,
+					const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct clk_core *c = file->private_data;
+	struct clk *p;
+	char pname[50]; /* 50 char shud be enough for clock name + \0 */
+	int ret;
+
+	count = min(sizeof(pname), count);
+	strncpy_from_user(pname, user_buf, count);
+	pname[count - 1] = 0; /* NULL terminate */
+
+	p = __clk_lookup(pname);
+	if (!p) {
+			pr_err("%s: %s not found\n", __func__, pname);
+			return -EINVAL;
+	}
+
+	ret = clk_set_parent(c->hw->clk, p);
+	if (ret) {
+		pr_err("%s: %s Incorrect Argument\n", __func__, pname);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations clk_debug_parent_fops = {
+	.open = simple_open,
+	.read		= clk_debug_parent_get,
+	.write		= clk_debug_parent_set,
+};
+
+/* caller must hold prepare_lock */
 static int clk_debug_create_one(struct clk_core *clk, struct dentry *pdentry)
 {
 	struct dentry *d;
@@ -405,6 +528,26 @@ static int clk_debug_create_one(struct clk_core *clk, struct dentry *pdentry)
 			goto err_out;
 	}
 
+	d = debugfs_create_file("clk_set_rate", S_IRUGO | S_IWUSR, clk->dentry,
+				clk, &clk_debug_rate_fops);
+	if (!d)
+		goto err_out;
+
+	d = debugfs_create_file("clk_set_parent", S_IRUGO | S_IWUSR,
+				clk->dentry, clk, &clk_debug_parent_fops);
+	if (!d)
+		goto err_out;
+
+	d = debugfs_create_file("clk_prepare_enable", S_IWUSR, clk->dentry,
+				clk, &clk_debug_prep_enable_fops);
+	if (!d)
+		goto err_out;
+
+	d = debugfs_create_file("clk_disable_unprepare", S_IWUSR, clk->dentry,
+				clk, &clk_debug_disable_unprep_fops);
+	if (!d)
+		goto err_out;
+
 	ret = 0;
 	goto out;
 
-- 
1.7.5.4
