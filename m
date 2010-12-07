From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Tue, 7 Dec 2010 11:20:41 +0100
Subject: [PATCH] ARM: ux500: Add debugfs support for powerdebug
Message-ID: <AANLkTiks+=3dV3pJmFoiTe_Dp4HHj2=8fSRbANH82tkq@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds clock information to debugfs interface. This clock
tree like directory is used by powerdebug for displaying a readable
clock status. This patch sets also the name of clk_32khz and
clk_dummy_apb_pclk because this field is used to generate the clock
tree.

Signed-off-by: Vincent Guittot <vincent.guittot@stericsson.com>
---
 arch/arm/mach-ux500/clock.c |  195 ++++++++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-ux500/clock.h |    4 +
 2 files changed, 198 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 598902d..343a5a5 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -20,6 +20,12 @@
 #include <mach/hardware.h>
 #include "clock.h"

+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#include <linux/uaccess.h>	/* for copy_from_user */
+static LIST_HEAD(clk_list);
+#endif
+
 #define PRCC_PCKEN		0x00
 #define PRCC_PCKDIS		0x04
 #define PRCC_KCKEN		0x08
@@ -286,6 +292,7 @@ static struct clkops clk_prcc_ops = {
 };

 static struct clk clk_32khz = {
+	.name =  "clk_32khz",
 	.rate = 32000,
 };

@@ -422,7 +429,9 @@ static DEFINE_PRCC_CLK_CUSTOM(7, mtu0_ed, 2, -1,
NULL, clk_mtu_get_rate, 0);
 static DEFINE_PRCC_CLK(7, wdg_ed,	1, -1, NULL);
 static DEFINE_PRCC_CLK(7, cfgreg_ed,	0, -1, NULL);

-static struct clk clk_dummy_apb_pclk;
+static struct clk clk_dummy_apb_pclk = {
+	.name = "apb_pclk",
+};

 static struct clk_lookup u8500_common_clks[] = {
 	CLK(dummy_apb_pclk, NULL,	"apb_pclk"),
@@ -568,6 +577,183 @@ static struct clk_lookup u8500_v1_clks[] = {
 	CLK(uiccclk,	"uicc",		NULL),
 };

+#ifdef CONFIG_DEBUG_FS
+/*
+ *	debugfs support to trace clock tree hierarchy and attributes with
+ *	powerdebug
+ */
+static struct dentry *clk_debugfs_root;
+
+void __init clk_debugfs_add_table(struct clk_lookup *cl, size_t num)
+{
+	while (num--) {
+		/* Check that the clock has not been already registered */
+		if (!(cl->clk->list.prev != cl->clk->list.next))
+			list_add_tail(&cl->clk->list, &clk_list);
+
+		cl++;
+	}
+}
+
+static ssize_t usecount_dbg_read(struct file *file, char __user *buf,
+						  size_t size, loff_t *off)
+{
+	struct clk *clk = file->f_dentry->d_inode->i_private;
+	char cusecount[128];
+	unsigned int len;
+
+	len = sprintf(cusecount, "%u\n", clk->enabled);
+	return simple_read_from_buffer(buf, size, off, cusecount, len);
+}
+
+static ssize_t rate_dbg_read(struct file *file, char __user *buf,
+					  size_t size, loff_t *off)
+{
+	struct clk *clk = file->f_dentry->d_inode->i_private;
+	char crate[128];
+	unsigned int rate;
+	unsigned int len;
+
+	rate = clk_get_rate(clk);
+	len = sprintf(crate, "%u\n", rate);
+	return simple_read_from_buffer(buf, size, off, crate, len);
+}
+
+static const struct file_operations usecount_fops = {
+	.read = usecount_dbg_read,
+};
+
+static const struct file_operations set_rate_fops = {
+	.read = rate_dbg_read,
+};
+
+static struct dentry *clk_debugfs_register_dir(struct clk *c,
+						struct dentry *p_dentry)
+{
+	struct dentry *d, *clk_d, *child, *child_tmp;
+	char s[255];
+	char *p = s;
+
+	if (c->name == NULL)
+		p += sprintf(p, "BUG");
+	else
+		p += sprintf(p, "%s", c->name);
+
+	clk_d = debugfs_create_dir(s, p_dentry);
+	if (!clk_d)
+		return NULL;
+
+	d = debugfs_create_file("usecount", S_IRUGO,
+				clk_d, c, &usecount_fops);
+	if (!d)
+		goto err_out;
+	d = debugfs_create_file("rate", S_IRUGO,
+				clk_d, c, &set_rate_fops);
+	if (!d)
+		goto err_out;
+	/*
+	 * TODO : not currently available in ux500
+	 * d = debugfs_create_x32("flags", S_IRUGO, clk_d, (u32 *)&c->flags);
+	 * if (!d)
+	 *	goto err_out;
+	 */
+
+	return clk_d;
+
+err_out:
+	d = clk_d;
+	list_for_each_entry_safe(child, child_tmp, &d->d_subdirs, d_u.d_child)
+		debugfs_remove(child);
+	debugfs_remove(clk_d);
+	return NULL;
+}
+
+static void clk_debugfs_remove_dir(struct dentry *cdentry)
+{
+	struct dentry *d, *child, *child_tmp;
+
+	d = cdentry;
+	list_for_each_entry_safe(child, child_tmp, &d->d_subdirs, d_u.d_child)
+		debugfs_remove(child);
+	debugfs_remove(cdentry);
+	return ;
+}
+
+static int clk_debugfs_register_one(struct clk *c)
+{
+	struct clk *pa = c->parent_periph;
+	struct clk *bpa = c->parent_cluster;
+
+	if (!(bpa && !pa)) {
+		c->dent = clk_debugfs_register_dir(c,
+				pa ? pa->dent : clk_debugfs_root);
+		if (!c->dent)
+			return -ENOMEM;
+	}
+
+	if (bpa) {
+		c->dent_bus = clk_debugfs_register_dir(c,
+				bpa->dent_bus ? bpa->dent_bus : bpa->dent);
+		if ((!c->dent_bus) &&  (c->dent)) {
+			clk_debugfs_remove_dir(c->dent);
+			c->dent = NULL;
+			return -ENOMEM;
+		}
+	}
+	return 0;
+}
+
+static int clk_debugfs_register(struct clk *c)
+{
+	int err;
+	struct clk *pa = c->parent_periph;
+	struct clk *bpa = c->parent_cluster;
+
+	if (pa && (!pa->dent && !pa->dent_bus)) {
+		err = clk_debugfs_register(pa);
+		if (err)
+			return err;
+	}
+
+	if (bpa && (!bpa->dent && !bpa->dent_bus)) {
+		err = clk_debugfs_register(bpa);
+		if (err)
+			return err;
+	}
+
+	if ((!c->dent) && (!c->dent_bus)) {
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
+	list_for_each_entry(c, &clk_list, list) {
+		err = clk_debugfs_register(c);
+		if (err)
+			goto err_out;
+	}
+	return 0;
+err_out:
+	debugfs_remove_recursive(clk_debugfs_root);
+	return err;
+}
+
+late_initcall(clk_debugfs_init);
+#endif /* defined(CONFIG_DEBUG_FS) */
+
 int __init clk_init(void)
 {
 	if (cpu_is_u8500ed()) {
@@ -589,5 +775,12 @@ int __init clk_init(void)
 	else
 		clkdev_add_table(u8500_v1_clks, ARRAY_SIZE(u8500_v1_clks));

+#ifdef CONFIG_DEBUG_FS
+	clk_debugfs_add_table(u8500_common_clks, ARRAY_SIZE(u8500_common_clks));
+	if (cpu_is_u8500ed())
+		clk_debugfs_add_table(u8500_ed_clks, ARRAY_SIZE(u8500_ed_clks));
+	else
+		clk_debugfs_add_table(u8500_v1_clks, ARRAY_SIZE(u8500_v1_clks));
+#endif
 	return 0;
 }
diff --git a/arch/arm/mach-ux500/clock.h b/arch/arm/mach-ux500/clock.h
index a058025..0744907 100644
--- a/arch/arm/mach-ux500/clock.h
+++ b/arch/arm/mach-ux500/clock.h
@@ -90,6 +90,10 @@ struct clk {

 	struct clk		*parent_cluster;
 	struct clk		*parent_periph;
+#if defined(CONFIG_DEBUG_FS)
+	struct dentry		*dent;		/* For visible tree hierarchy */
+	struct dentry		*dent_bus;	/* For visible tree hierarchy */
+#endif
 };

 #define DEFINE_PRCMU_CLK(_name, _cg_off, _cg_bit, _reg)		\
-- 
1.7.0.4
