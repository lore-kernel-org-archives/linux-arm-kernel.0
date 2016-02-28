From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:04 +0000
Subject: [PATCH v5 13/20] clk: bcm2835: expose current divider,
 parent and mash via debugfs
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-14-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

For each clock expose the following values via debugfs:
* current_parent - the currently selected parent
* current_divi - the integer portion of the currently set divider
* current_divf - the fractional portion of the currently set divider
* current_frac - the current frac/mash settings for the divider

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |  101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 366f975..b67147b 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -129,6 +129,10 @@
 # define CM_BUSY			BIT(7)
 # define CM_BUSYD			BIT(8)
 # define CM_FRAC			BIT(9)
+# define CM_MASH0			BIT(9)
+# define CM_MASH1			BIT(10)
+# define CM_MASH_MASK			(CM_MASH0 | CM_MASH1)
+# define CM_MASH_SHIFT			9
 # define CM_SRC_SHIFT			0
 # define CM_SRC_BITS			4
 # define CM_SRC_MASK			0xf
@@ -1045,6 +1049,90 @@ static u8 bcm2835_clock_get_parent(struct clk_hw *hw)
 	return (src & CM_SRC_MASK) >> CM_SRC_SHIFT;
 }
 
+static const char *bcm2835_clock_get_parent_name(struct clk_hw *hw)
+{
+	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	const struct bcm2835_clock_data *data = clock->data;
+	u8 id = bcm2835_clock_get_parent(hw);
+
+	return (id < data->num_mux_parents) ?
+		data->parents[id] : "unknown";
+}
+
+static int bcm2835_clock_debug_current_parent_open(struct inode *inode,
+						   struct file *file)
+{
+	const char *parent = bcm2835_clock_get_parent_name(inode->i_private);
+
+	file->private_data = kstrdup(parent, GFP_KERNEL);
+	return 0;
+}
+
+static ssize_t bcm2835_clock_debug_current_parent_read(struct file *file,
+						       char __user *buf,
+						       size_t len,
+						       loff_t *ppos)
+{
+	const char *parent = file->private_data;
+	size_t size = strlen(parent);
+
+	return simple_read_from_buffer(buf, len, ppos, parent, size);
+}
+
+static const struct file_operations bcm2835_clock_debug_current_parent_fops = {
+	.owner   = THIS_MODULE,
+	.open    = bcm2835_clock_debug_current_parent_open,
+	.release = simple_attr_release,
+	.read    = bcm2835_clock_debug_current_parent_read,
+	.llseek  = generic_file_llseek,
+};
+
+static int bcm2835_clock_debug_current_divi_get(void *hw, u64 *val)
+{
+	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	struct bcm2835_cprman *cprman = clock->cprman;
+	const struct bcm2835_clock_data *data = clock->data;
+	u32 div = cprman_read(cprman, data->div_reg);
+
+	*val = div >> CM_DIV_FRAC_BITS;
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(bcm2835_clock_debug_current_divi_fops,
+			bcm2835_clock_debug_current_divi_get,
+			NULL, "%llu\n");
+
+static int bcm2835_clock_debug_current_divf_get(void *hw, u64 *val)
+{
+	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	struct bcm2835_cprman *cprman = clock->cprman;
+	const struct bcm2835_clock_data *data = clock->data;
+	u32 div = cprman_read(cprman, data->div_reg);
+
+	*val = div & CM_DIV_FRAC_MASK;
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(bcm2835_clock_debug_current_divf_fops,
+			bcm2835_clock_debug_current_divf_get,
+			NULL, "%llu\n");
+
+static int bcm2835_clock_debug_current_frac_get(void *hw, u64 *val)
+{
+	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	struct bcm2835_cprman *cprman = clock->cprman;
+	const struct bcm2835_clock_data *data = clock->data;
+	u32 ctl = cprman_read(cprman, data->ctl_reg);
+
+	if (data->is_mash_clock)
+		*val = (ctl & CM_MASH_MASK) >> CM_MASH_SHIFT;
+	else
+		*val = ctl & CM_FRAC ? 1 : 0;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(bcm2835_clock_debug_current_frac_fops,
+			bcm2835_clock_debug_current_frac_get,
+			NULL, "%llu\n");
+
 static struct debugfs_reg32 bcm2835_debugfs_clock_reg32[] = {
 	{
 		.name = "ctl",
@@ -1063,6 +1151,19 @@ static int bcm2835_clock_debug_init(struct clk_hw *hw,
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
 
+	/* expose the current parrent */
+	debugfs_create_file("current_parent", S_IRUGO, dentry, hw,
+			    &bcm2835_clock_debug_current_parent_fops);
+
+	/* expose the current divider components */
+	debugfs_create_file("current_divi", S_IRUGO, dentry, hw,
+			    &bcm2835_clock_debug_current_divi_fops);
+	debugfs_create_file("current_divf", S_IRUGO, dentry, hw,
+			    &bcm2835_clock_debug_current_divf_fops);
+	debugfs_create_file("current_frac", S_IRUGO, dentry, hw,
+			    &bcm2835_clock_debug_current_frac_fops);
+
+	/* add the regset */
 	return bcm2835_debugfs_regset(
 		cprman, data->ctl_reg,
 		bcm2835_debugfs_clock_reg32,
-- 
1.7.10.4
