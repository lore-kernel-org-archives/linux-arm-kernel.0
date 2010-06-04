From: olof@lixom.net (Olof Johansson)
Date: Fri,  4 Jun 2010 02:10:35 -0500
Subject: [PATCH 03/10] [ARM] tegra: Add clock support
In-Reply-To: <1275635441-17378-3-git-send-email-olof@lixom.net>
References: <3478yvr76gerav> <1275635441-17378-1-git-send-email-olof@lixom.net>
	<1275635441-17378-2-git-send-email-olof@lixom.net>
	<1275635441-17378-3-git-send-email-olof@lixom.net>
Message-ID: <1275635441-17378-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

v2: fixes from Russell King:
	- include linux/io.h instead of asm/io.h
	- fix whitespace in Kconfig
	- Use spin_lock_init to initialize lock
	- Return -ENOSYS instead of BUG for unimplemented clock ops
	- Use proper return values in tegra2 clock ops
    additional changes:
	- Rename some clocks to match dev_ids
	- add rate propagation
	- add debugfs entries
	- add support for clock listed in clk_lookup under multiple dev_ids

Merged with separate later patch from Colin:
	Don't reset peripherials on clk_disable
	Correct flags on dvc_i2c
	Remove input clock
	Autodetect state of all clocks on init
	Add cpu, sys, and bus clocks
	Fix clk_set_rate on PLLs
	Replace per-clock locking with global clock lock

Olof:
	Misc formatting cleanups

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/Kconfig                          |    1 +
 arch/arm/mach-tegra/Makefile              |    2 +
 arch/arm/mach-tegra/clock.c               |  415 +++++++++
 arch/arm/mach-tegra/clock.h               |  133 +++
 arch/arm/mach-tegra/common.c              |    1 +
 arch/arm/mach-tegra/include/mach/clkdev.h |   32 +
 arch/arm/mach-tegra/tegra2_clocks.c       | 1341 +++++++++++++++++++++++++++++
 arch/arm/tools/mach-types                 |   98 ++-
 8 files changed, 2013 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-tegra/clock.c
 create mode 100644 arch/arm/mach-tegra/clock.h
 create mode 100644 arch/arm/mach-tegra/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-tegra/tegra2_clocks.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 388f371..92b9572 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -581,6 +581,7 @@ config ARCH_TEGRA
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_GPIO
 	select HAVE_CLK
+	select COMMON_CLKDEV
 	select ARCH_HAS_BARRIERS if CACHE_L2X0
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index a0d2c5b..e20546a 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -1,3 +1,5 @@
 obj-y                                   += common.o
 obj-y                                   += io.o
 obj-y                                   += irq.o
+obj-y                                   += clock.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
new file mode 100644
index 0000000..bb48242
--- /dev/null
+++ b/arch/arm/mach-tegra/clock.c
@@ -0,0 +1,415 @@
+/*
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/list.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/slab.h>
+#include <linux/seq_file.h>
+#include <asm/clkdev.h>
+
+#include "clock.h"
+
+static LIST_HEAD(clocks);
+
+static DEFINE_SPINLOCK(clock_lock);
+
+struct clk *get_tegra_clock_by_name(const char *name)
+{
+	struct clk *c;
+	struct clk *ret = NULL;
+	unsigned long flags;
+	spin_lock_irqsave(&clock_lock, flags);
+	list_for_each_entry(c, &clocks, node) {
+		if (strcmp(c->name, name) == 0) {
+			ret = c;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&clock_lock, flags);
+	return ret;
+}
+
+int clk_reparent(struct clk *c, struct clk *parent)
+{
+	pr_debug("%s: %s\n", __func__, c->name);
+	if (c->refcnt && c->parent)
+		clk_disable_locked(c->parent);
+	c->parent = parent;
+	if (c->refcnt && c->parent)
+		clk_enable_locked(c->parent);
+	list_del(&c->sibling);
+	list_add_tail(&c->sibling, &parent->children);
+	return 0;
+}
+
+static void propagate_rate(struct clk *c)
+{
+	struct clk *clkp;
+	pr_debug("%s: %s\n", __func__, c->name);
+	list_for_each_entry(clkp, &c->children, sibling) {
+		pr_debug("   %s\n", clkp->name);
+		if (clkp->ops->recalculate_rate)
+			clkp->ops->recalculate_rate(clkp);
+		propagate_rate(clkp);
+	}
+}
+
+void clk_init(struct clk *c)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clock_lock, flags);
+
+	INIT_LIST_HEAD(&c->children);
+	INIT_LIST_HEAD(&c->sibling);
+
+	if (c->ops && c->ops->init)
+		c->ops->init(c);
+
+	list_add(&c->node, &clocks);
+
+	if (c->parent)
+		list_add_tail(&c->sibling, &c->parent->children);
+
+	spin_unlock_irqrestore(&clock_lock, flags);
+}
+
+int clk_enable_locked(struct clk *c)
+{
+	int ret;
+	pr_debug("%s: %s\n", __func__, c->name);
+	if (c->refcnt == 0) {
+		if (c->parent) {
+			ret = clk_enable_locked(c->parent);
+			if (ret)
+				return ret;
+		}
+
+		if (c->ops && c->ops->enable) {
+			ret = c->ops->enable(c);
+			if (ret) {
+				if (c->parent)
+					clk_disable_locked(c->parent);
+				return ret;
+			}
+			c->state = ON;
+#ifdef CONFIG_DEBUG_FS
+			c->set = 1;
+#endif
+		}
+	}
+	c->refcnt++;
+
+	return 0;
+}
+
+int clk_enable(struct clk *c)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(&clock_lock, flags);
+	ret = clk_enable_locked(c);
+	spin_unlock_irqrestore(&clock_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable_locked(struct clk *c)
+{
+	pr_debug("%s: %s\n", __func__, c->name);
+	if (c->refcnt == 0) {
+		WARN(1, "Attempting to disable clock %s with refcnt 0", c->name);
+		return;
+	}
+	if (c->refcnt == 1) {
+		if (c->ops && c->ops->disable)
+			c->ops->disable(c);
+
+		if (c->parent)
+			clk_disable_locked(c->parent);
+
+		c->state = OFF;
+	}
+	c->refcnt--;
+}
+
+void clk_disable(struct clk *c)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&clock_lock, flags);
+	clk_disable_locked(c);
+	spin_unlock_irqrestore(&clock_lock, flags);
+}
+EXPORT_SYMBOL(clk_disable);
+
+int clk_set_parent_locked(struct clk *c, struct clk *parent)
+{
+	int ret;
+
+	pr_debug("%s: %s\n", __func__, c->name);
+
+	if (!c->ops || !c->ops->set_parent)
+		return -ENOSYS;
+
+	ret = c->ops->set_parent(c, parent);
+
+	if (ret)
+		return ret;
+
+	propagate_rate(c);
+
+	return 0;
+}
+
+int clk_set_parent(struct clk *c, struct clk *parent)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(&clock_lock, flags);
+	ret = clk_set_parent_locked(c, parent);
+	spin_unlock_irqrestore(&clock_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_parent);
+
+struct clk *clk_get_parent(struct clk *c)
+{
+	return c->parent;
+}
+EXPORT_SYMBOL(clk_get_parent);
+
+int clk_set_rate(struct clk *c, unsigned long rate)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clock_lock, flags);
+
+	pr_debug("%s: %s\n", __func__, c->name);
+
+	if (c->ops && c->ops->set_rate)
+		ret = c->ops->set_rate(c, rate);
+	else
+		ret = -ENOSYS;
+
+	propagate_rate(c);
+
+	spin_unlock_irqrestore(&clock_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+unsigned long clk_get_rate(struct clk *c)
+{
+	unsigned long flags;
+	unsigned long ret;
+
+	spin_lock_irqsave(&clock_lock, flags);
+
+	pr_debug("%s: %s\n", __func__, c->name);
+
+	ret = c->rate;
+
+	spin_unlock_irqrestore(&clock_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+int __init tegra_init_clock(void)
+{
+	tegra2_init_clocks();
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *clk_debugfs_root;
+
+
+static void clock_tree_show_one(struct seq_file *s, struct clk *c, int level)
+{
+	struct clk *child;
+	struct clk *safe;
+	const char *state = "uninit";
+	char div[5] = {0};
+
+	if (c->state == ON)
+		state = "on";
+	else if (c->state == OFF)
+		state = "off";
+
+	if (c->mul != 0 && c->div != 0) {
+		BUG_ON(c->mul > 2);
+		if (c->mul > c->div)
+			snprintf(div, sizeof(div), "x%d", c->mul / c->div);
+		else
+			snprintf(div, sizeof(div), "%d%s", c->div / c->mul,
+				(c->div % c->mul) ? ".5" : "");
+	}
+
+	seq_printf(s, "%*s%-*s %-6s %-3d %-5s %-10lu\n",
+		level * 3 + 1, c->set ? "" : "*",
+		30 - level * 3, c->name,
+		state, c->refcnt, div, c->rate);
+	list_for_each_entry_safe(child, safe, &c->children, sibling) {
+		clock_tree_show_one(s, child, level + 1);
+	}
+}
+
+static int clock_tree_show(struct seq_file *s, void *data)
+{
+	struct clk *c;
+	unsigned long flags;
+	seq_printf(s, " clock                          state  ref div   rate      \n");
+	seq_printf(s, "-----------------------------------------------------------\n");
+	spin_lock_irqsave(&clock_lock, flags);
+	list_for_each_entry(c, &clocks, node)
+		if (c->parent == NULL)
+			clock_tree_show_one(s, c, 0);
+	spin_unlock_irqrestore(&clock_lock, flags);
+	return 0;
+}
+
+static int clock_tree_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, clock_tree_show, inode->i_private);
+}
+
+static const struct file_operations clock_tree_fops = {
+	.open		= clock_tree_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int possible_parents_show(struct seq_file *s, void *data)
+{
+	struct clk *c = s->private;
+	int i;
+
+	for (i = 0; c->inputs[i].input; i++) {
+		char *first = (i == 0) ? "" : " ";
+		seq_printf(s, "%s%s", first, c->inputs[i].input->name);
+	}
+	seq_printf(s, "\n");
+	return 0;
+}
+
+static int possible_parents_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, possible_parents_show, inode->i_private);
+}
+
+static const struct file_operations possible_parents_fops = {
+	.open		= possible_parents_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int clk_debugfs_register_one(struct clk *c)
+{
+	struct dentry *d, *child, *child_tmp;
+
+	d = debugfs_create_dir(c->name, clk_debugfs_root);
+	if (!d)
+		return -ENOMEM;
+	c->dent = d;
+
+	d = debugfs_create_u8("refcnt", S_IRUGO, c->dent, (u8 *)&c->refcnt);
+	if (!d)
+		goto err_out;
+
+	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
+	if (!d)
+		goto err_out;
+
+	d = debugfs_create_x32("flags", S_IRUGO, c->dent, (u32 *)&c->flags);
+	if (!d)
+		goto err_out;
+
+	if (c->inputs) {
+		d = debugfs_create_file("possible_parents", S_IRUGO, c->dent,
+			c, &possible_parents_fops);
+		if (!d)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	d = c->dent;
+	list_for_each_entry_safe(child, child_tmp, &d->d_subdirs, d_u.d_child)
+		debugfs_remove(child);
+	debugfs_remove(c->dent);
+	return -ENOMEM;
+}
+
+static int clk_debugfs_register(struct clk *c)
+{
+	int err;
+	struct clk *pa = c->parent;
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
+	int err = -ENOMEM;
+
+	d = debugfs_create_dir("clock", NULL);
+	if (!d)
+		return -ENOMEM;
+	clk_debugfs_root = d;
+
+	d = debugfs_create_file("clock_tree", S_IRUGO, clk_debugfs_root, NULL,
+		&clock_tree_fops);
+	if (!d)
+		goto err_out;
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
+
+late_initcall(clk_debugfs_init);
+#endif
diff --git a/arch/arm/mach-tegra/clock.h b/arch/arm/mach-tegra/clock.h
new file mode 100644
index 0000000..54b21b8
--- /dev/null
+++ b/arch/arm/mach-tegra/clock.h
@@ -0,0 +1,133 @@
+/*
+ * arch/arm/mach-tegra/include/mach/clock.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_TEGRA_CLOCK_H
+#define __MACH_TEGRA_CLOCK_H
+
+#include <asm/clkdev.h>
+
+#define DIV_BUS		0x00000001
+#define DIV_U71		0x00000002
+#define DIV_U71_FIXED	0x00000004
+#define DIV_2		0x00000008
+#define PLL_FIXED	0x00000010
+#define PLL_HAS_CPCON	0x00000020
+#define MUX		0x00000040
+#define PLLD		0x00000080
+#define PERIPH_NO_RESET	0x00000100
+#define PERIPH_NO_ENB	0x00000200
+#define PERIPH_EMC_ENB	0x00000400
+#define ENABLE_ON_INIT	0x10000000
+struct clk;
+
+struct clk_mux_sel {
+	struct clk	*input;
+	u32		value;
+};
+
+struct clk_pll_table {
+	unsigned long	input_rate;
+	unsigned long	output_rate;
+	u16		n;
+	u16		m;
+	u8		p;
+	u8		cpcon;
+};
+
+struct clk_ops {
+	void		(*init)(struct clk *);
+	int		(*enable)(struct clk *);
+	void		(*disable)(struct clk *);
+	void		(*recalc)(struct clk *);
+	int		(*set_parent)(struct clk *, struct clk *);
+	int		(*set_rate)(struct clk *, unsigned long);
+	unsigned long	(*get_rate)(struct clk *);
+	long		(*round_rate)(struct clk *, unsigned long);
+	unsigned long	(*recalculate_rate)(struct clk *);
+};
+
+enum clk_state {
+	UNINITIALIZED = 0,
+	ON,
+	OFF,
+};
+
+struct clk {
+	/* node for master clocks list */
+	struct list_head		node;
+	struct list_head		children;	/* list of children */
+	struct list_head		sibling;	/* node for children */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry			*dent;
+	struct dentry			*parent_dent;
+#endif
+	struct clk_ops			*ops;
+	struct clk			*parent;
+	struct clk_lookup		lookup;
+	unsigned long			rate;
+	u32				flags;
+	u32				refcnt;
+	const char			*name;
+	u32				reg;
+	u32				reg_shift;
+	unsigned int			clk_num;
+	enum clk_state			state;
+#ifdef CONFIG_DEBUG_FS
+	bool				set;
+#endif
+
+	/* PLL */
+	unsigned long			input_min;
+	unsigned long			input_max;
+	unsigned long			cf_min;
+	unsigned long			cf_max;
+	unsigned long			vco_min;
+	unsigned long			vco_max;
+	u32				m;
+	u32				n;
+	u32				p;
+	u32				cpcon;
+	const struct clk_pll_table	*pll_table;
+
+	/* DIV */
+	u32				div;
+	u32				mul;
+
+	/* MUX */
+	const struct clk_mux_sel	*inputs;
+	u32				sel;
+	u32				reg_mask;
+};
+
+
+struct clk_duplicate {
+	const char *name;
+	struct clk_lookup lookup;
+};
+
+void tegra2_init_clocks(void);
+void clk_init(struct clk *clk);
+struct clk *get_tegra_clock_by_name(const char *name);
+unsigned long clk_measure_input_freq(void);
+void clk_disable_locked(struct clk *c);
+int clk_enable_locked(struct clk *c);
+int clk_set_parent_locked(struct clk *c, struct clk *parent);
+int clk_reparent(struct clk *c, struct clk *parent);
+
+#endif
diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
index 20875ee..838bb5d 100644
--- a/arch/arm/mach-tegra/common.c
+++ b/arch/arm/mach-tegra/common.c
@@ -40,5 +40,6 @@ void __init tegra_init_cache(void)
 
 void __init tegra_common_init(void)
 {
+	tegra_init_clock();
 	tegra_init_cache();
 }
diff --git a/arch/arm/mach-tegra/include/mach/clkdev.h b/arch/arm/mach-tegra/include/mach/clkdev.h
new file mode 100644
index 0000000..412f5c6
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/clkdev.h
@@ -0,0 +1,32 @@
+/*
+ * arch/arm/mach-tegra/include/mach/clkdev.h
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef __MACH_CLKDEV_H
+#define __MACH_CLKDEV_H
+
+static inline int __clk_get(struct clk *clk)
+{
+	return 1;
+}
+
+static inline void __clk_put(struct clk *clk)
+{
+}
+
+#endif
diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
new file mode 100644
index 0000000..7206653
--- /dev/null
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -0,0 +1,1341 @@
+/*
+ * arch/arm/mach-tegra/tegra2_clocks.c
+ *
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * Author:
+ *	Colin Cross <ccross@google.com>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include <asm/clkdev.h>
+
+#include <mach/iomap.h>
+
+#include "clock.h"
+
+#define RST_DEVICES			0x004
+#define RST_DEVICES_SET			0x300
+#define RST_DEVICES_CLR			0x304
+
+#define CLK_OUT_ENB			0x010
+#define CLK_OUT_ENB_SET			0x320
+#define CLK_OUT_ENB_CLR			0x324
+
+#define OSC_CTRL			0x50
+#define OSC_CTRL_OSC_FREQ_MASK		(3<<30)
+#define OSC_CTRL_OSC_FREQ_13MHZ		(0<<30)
+#define OSC_CTRL_OSC_FREQ_19_2MHZ	(1<<30)
+#define OSC_CTRL_OSC_FREQ_12MHZ		(2<<30)
+#define OSC_CTRL_OSC_FREQ_26MHZ		(3<<30)
+
+#define OSC_FREQ_DET			0x58
+#define OSC_FREQ_DET_TRIG		(1<<31)
+
+#define OSC_FREQ_DET_STATUS		0x5C
+#define OSC_FREQ_DET_BUSY		(1<<31)
+#define OSC_FREQ_DET_CNT_MASK		0xFFFF
+
+#define PERIPH_CLK_SOURCE_MASK		(3<<30)
+#define PERIPH_CLK_SOURCE_SHIFT		30
+#define PERIPH_CLK_SOURCE_ENABLE	(1<<28)
+#define PERIPH_CLK_SOURCE_DIV_MASK	0xFF
+#define PERIPH_CLK_SOURCE_DIV_SHIFT	0
+
+#define PLL_BASE			0x0
+#define PLL_BASE_BYPASS			(1<<31)
+#define PLL_BASE_ENABLE			(1<<30)
+#define PLL_BASE_REF_ENABLE		(1<<29)
+#define PLL_BASE_OVERRIDE		(1<<28)
+#define PLL_BASE_LOCK			(1<<27)
+#define PLL_BASE_DIVP_MASK		(0x7<<20)
+#define PLL_BASE_DIVP_SHIFT		20
+#define PLL_BASE_DIVN_MASK		(0x3FF<<8)
+#define PLL_BASE_DIVN_SHIFT		8
+#define PLL_BASE_DIVM_MASK		(0x1F)
+#define PLL_BASE_DIVM_SHIFT		0
+
+#define PLL_OUT_RATIO_MASK		(0xFF<<8)
+#define PLL_OUT_RATIO_SHIFT		8
+#define PLL_OUT_OVERRIDE		(1<<2)
+#define PLL_OUT_CLKEN			(1<<1)
+#define PLL_OUT_RESET_DISABLE		(1<<0)
+
+#define PLL_MISC			0xc
+#define PLL_MISC_DCCON_SHIFT		20
+#define PLL_MISC_LOCK_ENABLE		(1<<18)
+#define PLL_MISC_CPCON_SHIFT		8
+#define PLL_MISC_CPCON_MASK		(0xF<<PLL_MISC_CPCON_SHIFT)
+#define PLL_MISC_LFCON_SHIFT		4
+#define PLL_MISC_LFCON_MASK		(0xF<<PLL_MISC_LFCON_SHIFT)
+#define PLL_MISC_VCOCON_SHIFT		0
+#define PLL_MISC_VCOCON_MASK		(0xF<<PLL_MISC_VCOCON_SHIFT)
+
+#define PLLD_MISC_CLKENABLE		(1<<30)
+#define PLLD_MISC_DIV_RST		(1<<23)
+#define PLLD_MISC_DCCON_SHIFT		12
+
+#define PERIPH_CLK_TO_ENB_REG(c)	((c->clk_num / 32) * 4)
+#define PERIPH_CLK_TO_ENB_SET_REG(c)	((c->clk_num / 32) * 8)
+#define PERIPH_CLK_TO_ENB_BIT(c)	(1 << (c->clk_num % 32))
+
+#define SUPER_CLK_MUX			0x00
+#define SUPER_STATE_SHIFT		28
+#define SUPER_STATE_MASK		(0xF << SUPER_STATE_SHIFT)
+#define SUPER_STATE_STANDBY		(0x0 << SUPER_STATE_SHIFT)
+#define SUPER_STATE_IDLE		(0x1 << SUPER_STATE_SHIFT)
+#define SUPER_STATE_RUN			(0x2 << SUPER_STATE_SHIFT)
+#define SUPER_STATE_IRQ			(0x3 << SUPER_STATE_SHIFT)
+#define SUPER_STATE_FIQ			(0x4 << SUPER_STATE_SHIFT)
+#define SUPER_SOURCE_MASK		0xF
+#define	SUPER_FIQ_SOURCE_SHIFT		12
+#define	SUPER_IRQ_SOURCE_SHIFT		8
+#define	SUPER_RUN_SOURCE_SHIFT		4
+#define	SUPER_IDLE_SOURCE_SHIFT		0
+
+#define SUPER_CLK_DIVIDER		0x04
+
+#define BUS_CLK_DISABLE			(1<<3)
+#define BUS_CLK_DIV_MASK		0x3
+
+static void __iomem *reg_clk_base = IO_ADDRESS(TEGRA_CLK_RESET_BASE);
+
+#define clk_writel(value, reg) \
+	__raw_writel(value, (u32)reg_clk_base + (reg))
+#define clk_readl(reg) \
+	__raw_readl((u32)reg_clk_base + (reg))
+
+unsigned long clk_measure_input_freq(void)
+{
+	u32 clock_autodetect;
+
+	clk_writel(OSC_FREQ_DET_TRIG | 1, OSC_FREQ_DET);
+
+	while (clk_readl(OSC_FREQ_DET_STATUS) & OSC_FREQ_DET_BUSY)
+		;
+
+	clock_autodetect = clk_readl(OSC_FREQ_DET_STATUS);
+
+	if (clock_autodetect >= 732 - 3 &&
+	    clock_autodetect <= 732 + 3) {
+		return 12000000;
+	} else if (clock_autodetect >= 794 - 3 &&
+		   clock_autodetect <= 794 + 3) {
+		return 13000000;
+	} else if (clock_autodetect >= 1172 - 3 &&
+		   clock_autodetect <= 1172 + 3) {
+		return 19200000;
+	} else if (clock_autodetect >= 1587 - 3 &&
+		   clock_autodetect <= 1587 + 3) {
+		return 26000000;
+	} else {
+		pr_err("%s: Unexpected clock autodetect value %d",
+		       __func__, clock_autodetect);
+		BUG();
+		return 0;
+	}
+}
+
+static int clk_div71_possible_rate(struct clk *c, unsigned long rate)
+{
+	unsigned long input_rate = c->rate;
+	int divider_u71;
+
+	divider_u71 = (input_rate*2)/rate;
+	if (rate * divider_u71 == input_rate*2)
+		return divider_u71 - 2;
+	else
+		return -EINVAL;
+}
+
+static unsigned long tegra2_clk_recalculate_rate(struct clk *c)
+{
+	unsigned long rate;
+	rate = c->parent->rate;
+
+	if (c->mul != 0 && c->div != 0)
+		c->rate = rate * c->mul / c->div;
+	else
+		c->rate = rate;
+	return c->rate;
+}
+
+
+/* clk_m functions */
+static unsigned long tegra2_clk_m_autodetect_rate(struct clk *c)
+{
+	u32 auto_clock_control = clk_readl(OSC_CTRL) & ~OSC_CTRL_OSC_FREQ_MASK;
+
+	c->rate = clk_measure_input_freq();
+	switch (c->rate) {
+	case 12000000:
+		auto_clock_control |= OSC_CTRL_OSC_FREQ_12MHZ;
+		break;
+	case 13000000:
+		auto_clock_control |= OSC_CTRL_OSC_FREQ_13MHZ;
+		break;
+	case 19200000:
+		auto_clock_control |= OSC_CTRL_OSC_FREQ_19_2MHZ;
+		break;
+	case 26000000:
+		auto_clock_control |= OSC_CTRL_OSC_FREQ_26MHZ;
+		break;
+	default:
+		pr_err("%s: Unexpected clock rate %ld", __func__, c->rate);
+		BUG();
+	}
+	clk_writel(auto_clock_control, OSC_CTRL);
+	return c->rate;
+}
+
+static void tegra2_clk_m_init(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	tegra2_clk_m_autodetect_rate(c);
+}
+
+static int tegra2_clk_m_enable(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	return 0;
+}
+
+static void tegra2_clk_m_disable(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+	BUG();
+}
+
+static struct clk_ops tegra_clk_m_ops = {
+	.init     = tegra2_clk_m_init,
+	.enable   = tegra2_clk_m_enable,
+	.disable  = tegra2_clk_m_disable,
+};
+
+/* super clock functions */
+/* "super clocks" on tegra have two-stage muxes and a clock skipping
+ * super divider.  We will ignore the clock skipping divider, since we
+ * can't lower the voltage when using the clock skip, but we can if we
+ * lower the PLL frequency.
+ */
+static void tegra2_super_clk_init(struct clk *c)
+{
+	u32 val;
+	int source;
+	int shift;
+	const struct clk_mux_sel *sel;
+
+	val = clk_readl(c->reg + SUPER_CLK_MUX);
+	c->state = ON;
+	BUG_ON(((val & SUPER_STATE_MASK) != SUPER_STATE_RUN) &&
+		((val & SUPER_STATE_MASK) != SUPER_STATE_IDLE));
+	shift = ((val & SUPER_STATE_MASK) == SUPER_STATE_IDLE) ?
+		SUPER_IDLE_SOURCE_SHIFT : SUPER_RUN_SOURCE_SHIFT;
+	source = (val >> shift) & SUPER_SOURCE_MASK;
+	pr_info("%s %s %d\n", __func__, c->name, source);
+	for (sel = c->inputs; sel->input != NULL; sel++) {
+		if (sel->value == source)
+			break;
+	}
+	BUG_ON(sel->input == NULL);
+	c->parent = sel->input;
+	tegra2_clk_recalculate_rate(c);
+}
+
+static int tegra2_super_clk_enable(struct clk *c)
+{
+	clk_writel(0, c->reg + SUPER_CLK_DIVIDER);
+	return 0;
+}
+
+static void tegra2_super_clk_disable(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+
+	/* oops - don't disable the CPU clock! */
+	BUG();
+}
+
+static int tegra2_super_clk_set_parent(struct clk *c, struct clk *p)
+{
+	u32 val;
+	const struct clk_mux_sel *sel;
+	int shift;
+
+	val = clk_readl(c->reg + SUPER_CLK_MUX);;
+	BUG_ON(((val & SUPER_STATE_MASK) != SUPER_STATE_RUN) &&
+		((val & SUPER_STATE_MASK) != SUPER_STATE_IDLE));
+	shift = ((val & SUPER_STATE_MASK) == SUPER_STATE_IDLE) ?
+		SUPER_IDLE_SOURCE_SHIFT : SUPER_RUN_SOURCE_SHIFT;
+	for (sel = c->inputs; sel->input != NULL; sel++) {
+		if (sel->input == p) {
+			clk_reparent(c, p);
+			val &= ~(SUPER_SOURCE_MASK << shift);
+			val |= sel->value << shift;
+			clk_writel(val, c->reg);
+			c->rate = c->parent->rate;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static struct clk_ops tegra_super_ops = {
+	.init     = tegra2_super_clk_init,
+	.enable   = tegra2_super_clk_enable,
+	.disable  = tegra2_super_clk_disable,
+	.set_parent = tegra2_super_clk_set_parent,
+	.recalculate_rate = tegra2_clk_recalculate_rate,
+};
+
+/* bus clock functions */
+static void tegra2_bus_clk_init(struct clk *c)
+{
+	u32 val = clk_readl(c->reg);
+
+	c->state = ((val >> c->reg_shift) & BUS_CLK_DISABLE) ? OFF : ON;
+	c->div = ((val >> c->reg_shift) & BUS_CLK_DIV_MASK) + 1;
+	c->mul = 1;
+	tegra2_clk_recalculate_rate(c);
+}
+
+static int tegra2_bus_clk_enable(struct clk *c)
+{
+	u32 val = clk_readl(c->reg);
+
+	val &= ~(BUS_CLK_DISABLE << c->reg_shift);
+	clk_writel(val, c->reg);
+	return 0;
+}
+
+static void tegra2_bus_clk_disable(struct clk *c)
+{
+	u32 val = clk_readl(c->reg);
+
+	val |= BUS_CLK_DISABLE << c->reg_shift;
+	clk_writel(val, c->reg);
+}
+
+static int tegra2_bus_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	u32 val = clk_readl(c->reg);
+	unsigned long parent_rate = c->parent->rate;
+	int i;
+
+	for (i = 1; i <= 4; i++) {
+		if (rate == parent_rate / i) {
+			val &= ~(BUS_CLK_DIV_MASK << c->reg_shift);
+			val |= (i - 1) << c->reg_shift;
+			clk_writel(val, c->reg);
+			c->div = i;
+			c->mul = 1;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static struct clk_ops tegra_bus_ops = {
+	.init     = tegra2_bus_clk_init,
+	.enable   = tegra2_bus_clk_enable,
+	.disable  = tegra2_bus_clk_disable,
+	.set_rate = tegra2_bus_clk_set_rate,
+	.recalculate_rate = tegra2_clk_recalculate_rate,
+};
+
+/* PLL Functions */
+static unsigned long tegra2_pll_clk_recalculate_rate(struct clk *c)
+{
+	u64 rate;
+
+	rate = c->parent->rate;
+	rate *= c->n;
+	do_div(rate, c->m);
+	if (c->p == 2)
+		rate >>= 1;
+	c->rate = rate;
+	return c->rate;
+}
+
+static void tegra2_pll_clk_init(struct clk *c)
+{
+	u32 val = clk_readl(c->reg + PLL_BASE);
+
+	c->state = (val & PLL_BASE_ENABLE) ? ON : OFF;
+
+	if (c->flags & PLL_FIXED && !(val & PLL_BASE_OVERRIDE)) {
+		pr_warning("Clock %s has unknown fixed frequency\n", c->name);
+		c->n = 1;
+		c->m = 0;
+		c->p = 1;
+	} else if (val & PLL_BASE_BYPASS) {
+		c->n = 1;
+		c->m = 1;
+		c->p = 1;
+	} else {
+		c->n = (val & PLL_BASE_DIVN_MASK) >> PLL_BASE_DIVN_SHIFT;
+		c->m = (val & PLL_BASE_DIVM_MASK) >> PLL_BASE_DIVM_SHIFT;
+		c->p = (val & PLL_BASE_DIVP_MASK) ? 2 : 1;
+	}
+
+	val = clk_readl(c->reg + PLL_MISC);
+	if (c->flags & PLL_HAS_CPCON)
+		c->cpcon = (val & PLL_MISC_CPCON_MASK) >> PLL_MISC_CPCON_SHIFT;
+
+	tegra2_pll_clk_recalculate_rate(c);
+}
+
+static int tegra2_pll_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	u32 val;
+	unsigned long input_rate;
+	const struct clk_pll_table *sel;
+
+	pr_debug("%s: %s %lu\n", __func__, c->name, rate);
+	/* BUG_ON(c->refcnt != 0); */
+
+	input_rate = c->parent->rate;
+	for (sel = c->pll_table; sel->input_rate != 0; sel++) {
+		if (sel->input_rate == input_rate && sel->output_rate == rate) {
+			c->n = sel->n;
+			c->m = sel->m;
+			c->p = sel->p;
+			c->cpcon = sel->cpcon;
+			val = clk_readl(c->reg + PLL_BASE);
+			if (c->flags & PLL_FIXED)
+				val |= PLL_BASE_OVERRIDE;
+			val &= ~(PLL_BASE_DIVP_MASK | PLL_BASE_DIVN_MASK |
+				 PLL_BASE_DIVM_MASK);
+			val |= (c->m << PLL_BASE_DIVM_SHIFT) |
+				(c->n << PLL_BASE_DIVN_SHIFT);
+			BUG_ON(c->p > 2);
+			if (c->p == 2)
+				val |= 1 << PLL_BASE_DIVP_SHIFT;
+			clk_writel(val, c->reg + PLL_BASE);
+			c->rate = rate;
+
+			if (c->flags & PLL_HAS_CPCON) {
+				val = c->cpcon << PLL_MISC_CPCON_SHIFT;
+				clk_writel(val, c->reg + PLL_MISC);
+			}
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int tegra2_pll_clk_enable(struct clk *c)
+{
+	u32 val;
+
+	pr_debug("%s on clock %s\n", __func__, c->name);
+
+	val = clk_readl(c->reg + PLL_BASE);
+	val &= ~PLL_BASE_BYPASS;
+	val |= PLL_BASE_ENABLE;
+	clk_writel(val, c->reg + PLL_BASE);
+	return 0;
+}
+
+static void tegra2_pll_clk_disable(struct clk *c)
+{
+	u32 val;
+
+	pr_debug("%s on clock %s\n", __func__, c->name);
+
+	val = clk_readl(c->reg);
+	val &= ~(PLL_BASE_BYPASS | PLL_BASE_ENABLE);
+	clk_writel(val, c->reg);
+}
+
+static struct clk_ops tegra_pll_ops = {
+	.init     = tegra2_pll_clk_init,
+	.enable   = tegra2_pll_clk_enable,
+	.disable  = tegra2_pll_clk_disable,
+	.set_rate = tegra2_pll_clk_set_rate,
+	.recalculate_rate = tegra2_pll_clk_recalculate_rate,
+};
+
+/* Clock divider ops */
+static void tegra2_pll_div_clk_init(struct clk *c)
+{
+	u32 val = clk_readl(c->reg);
+	u32 divu71;
+
+	val >>= c->reg_shift;
+	c->state = (val & PLL_OUT_CLKEN) ? ON : OFF;
+	if (!(val & PLL_OUT_RESET_DISABLE))
+		c->state = OFF;
+
+	if (c->flags & DIV_U71) {
+		divu71 = (val & PLL_OUT_RATIO_MASK) >> PLL_OUT_RATIO_SHIFT;
+		c->div = (divu71 + 2);
+		c->mul = 2;
+	} else if (c->flags & DIV_2) {
+		c->div = 2;
+		c->mul = 1;
+	} else {
+		c->div = 1;
+		c->mul = 1;
+	}
+
+	tegra2_clk_recalculate_rate(c);
+}
+
+static int tegra2_pll_div_clk_enable(struct clk *c)
+{
+	u32 val;
+	u32 new_val;
+
+	pr_debug("%s: %s\n", __func__, c->name);
+	if (c->flags & DIV_U71) {
+		val = clk_readl(c->reg);
+		new_val = val >> c->reg_shift;
+		new_val &= 0xFFFF;
+
+		new_val |= PLL_OUT_CLKEN | PLL_OUT_RESET_DISABLE;
+
+		val &= ~(0xFFFF << c->reg_shift);
+		val |= new_val << c->reg_shift;
+		clk_writel(val, c->reg);
+		return 0;
+	} else if (c->flags & DIV_2) {
+		BUG_ON(!(c->flags & PLLD));
+		val = clk_readl(c->reg);
+		val &= ~PLLD_MISC_DIV_RST;
+		clk_writel(val, c->reg);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static void tegra2_pll_div_clk_disable(struct clk *c)
+{
+	u32 val;
+	u32 new_val;
+
+	pr_debug("%s: %s\n", __func__, c->name);
+	if (c->flags & DIV_U71) {
+		val = clk_readl(c->reg);
+		new_val = val >> c->reg_shift;
+		new_val &= 0xFFFF;
+
+		new_val &= ~(PLL_OUT_CLKEN | PLL_OUT_RESET_DISABLE);
+
+		val &= ~(0xFFFF << c->reg_shift);
+		val |= new_val << c->reg_shift;
+		clk_writel(val, c->reg);
+	} else if (c->flags & DIV_2) {
+		BUG_ON(!(c->flags & PLLD));
+		val = clk_readl(c->reg);
+		val |= PLLD_MISC_DIV_RST;
+		clk_writel(val, c->reg);
+	}
+}
+
+static int tegra2_pll_div_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	u32 val;
+	u32 new_val;
+	int divider_u71;
+
+	pr_debug("%s: %s %lu\n", __func__, c->name, rate);
+
+	if (c->flags & DIV_U71) {
+		divider_u71 = clk_div71_possible_rate(c->parent, rate);
+		if (divider_u71 >= 0) {
+			val = clk_readl(c->reg);
+			new_val = val >> c->reg_shift;
+			new_val &= 0xFFFF;
+			if (c->flags & DIV_U71_FIXED)
+				new_val |= PLL_OUT_OVERRIDE;
+			new_val &= ~PLL_OUT_RATIO_MASK;
+			new_val |= divider_u71 << PLL_OUT_RATIO_SHIFT;
+
+			val &= ~(0xFFFF << c->reg_shift);
+			val |= new_val << c->reg_shift;
+			clk_writel(val, c->reg);
+			c->rate = rate;
+			return 0;
+		}
+	} else if (c->flags & DIV_2) {
+		if (c->parent->rate == rate * 2) {
+			c->rate = rate;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+
+static struct clk_ops tegra_pll_div_ops = {
+	.init     = tegra2_pll_div_clk_init,
+	.enable   = tegra2_pll_div_clk_enable,
+	.disable  = tegra2_pll_div_clk_disable,
+	.set_rate = tegra2_pll_div_clk_set_rate,
+	.recalculate_rate = tegra2_clk_recalculate_rate,
+};
+
+/* Periph clk ops */
+
+static void tegra2_periph_clk_init(struct clk *c)
+{
+	u32 val = clk_readl(c->reg);
+	const struct clk_mux_sel *mux = 0;
+	const struct clk_mux_sel *sel;
+
+	if (c->flags & MUX) {
+		for (sel = c->inputs; sel->input != NULL; sel++) {
+			if (val >> PERIPH_CLK_SOURCE_SHIFT == sel->value)
+				mux = sel;
+		}
+		BUG_ON(!mux);
+
+		c->parent = mux->input;
+	} else {
+		c->parent = c->inputs[0].input;
+	}
+
+	if (c->flags & DIV_U71) {
+		u32 divu71 = val & PERIPH_CLK_SOURCE_DIV_MASK;
+		c->div = divu71 + 2;
+		c->mul = 2;
+	} else {
+		c->div = 1;
+		c->mul = 1;
+	}
+
+	c->state = ON;
+	if (!(clk_readl(CLK_OUT_ENB + PERIPH_CLK_TO_ENB_REG(c)) &
+			PERIPH_CLK_TO_ENB_BIT(c)))
+		c->state = OFF;
+	if (!(c->flags & PERIPH_NO_RESET))
+		if (clk_readl(RST_DEVICES + PERIPH_CLK_TO_ENB_REG(c)) &
+				PERIPH_CLK_TO_ENB_BIT(c))
+			c->state = OFF;
+	tegra2_clk_recalculate_rate(c);
+}
+
+static int tegra2_periph_clk_enable(struct clk *c)
+{
+	u32 val;
+
+	pr_debug("%s on clock %s\n", __func__, c->name);
+
+	clk_writel(PERIPH_CLK_TO_ENB_BIT(c),
+		CLK_OUT_ENB_SET + PERIPH_CLK_TO_ENB_SET_REG(c));
+	if (!(c->flags & PERIPH_NO_RESET))
+		clk_writel(PERIPH_CLK_TO_ENB_BIT(c),
+			RST_DEVICES_CLR + PERIPH_CLK_TO_ENB_SET_REG(c));
+	if (c->flags & PERIPH_EMC_ENB) {
+		/* The EMC peripheral clock has 2 extra enable bits */
+		/* FIXME: Do they need to be disabled? */
+		val = clk_readl(c->reg);
+		val |= 0x3 << 24;
+		clk_writel(val, c->reg);
+	}
+	return 0;
+}
+
+static void tegra2_periph_clk_disable(struct clk *c)
+{
+	pr_debug("%s on clock %s\n", __func__, c->name);
+
+	clk_writel(PERIPH_CLK_TO_ENB_BIT(c),
+		CLK_OUT_ENB_CLR + PERIPH_CLK_TO_ENB_SET_REG(c));
+}
+
+static int tegra2_periph_clk_set_parent(struct clk *c, struct clk *p)
+{
+	u32 val;
+	const struct clk_mux_sel *sel;
+
+	pr_debug("%s: %s %s\n", __func__, c->name, p->name);
+
+	for (sel = c->inputs; sel->input != NULL; sel++) {
+		if (sel->input == p) {
+			clk_reparent(c, p);
+			val = clk_readl(c->reg);
+			val &= ~PERIPH_CLK_SOURCE_MASK;
+			val |= (sel->value) << PERIPH_CLK_SOURCE_SHIFT;
+			clk_writel(val, c->reg);
+			c->rate = c->parent->rate;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int tegra2_periph_clk_set_rate(struct clk *c, unsigned long rate)
+{
+	u32 val;
+	int divider_u71;
+	const struct clk_mux_sel *sel;
+
+	pr_debug("%s: %lu\n", __func__, rate);
+
+	for (sel = c->inputs; sel->input != NULL; sel++) {
+		if (c->flags & DIV_U71) {
+			divider_u71 = clk_div71_possible_rate(sel->input, rate);
+			if (divider_u71 >= 0) {
+				/* FIXME: ensure we don't go through a too-high rate */
+				clk_set_parent_locked(c, sel->input);
+				udelay(1);
+				val = clk_readl(c->reg);
+				val &= ~PERIPH_CLK_SOURCE_DIV_MASK;
+				val |= divider_u71;
+				clk_writel(val, c->reg);
+				c->rate = rate;
+				return 0;
+			}
+		} else {
+			if (sel->input->rate == rate) {
+				clk_set_parent_locked(c, sel->input);
+				return 0;
+			}
+		}
+	}
+	return -EINVAL;
+}
+
+static struct clk_ops tegra_periph_clk_ops = {
+	.init       = &tegra2_periph_clk_init,
+	.enable     = &tegra2_periph_clk_enable,
+	.disable    = &tegra2_periph_clk_disable,
+	.set_parent = &tegra2_periph_clk_set_parent,
+	.set_rate   = &tegra2_periph_clk_set_rate,
+	.recalculate_rate = &tegra2_clk_recalculate_rate,
+};
+
+/* Clock doubler ops */
+static void tegra2_clk_double_init(struct clk *c)
+{
+	c->mul = 2;
+	c->div = 1;
+	c->state = ON;
+	if (!(clk_readl(CLK_OUT_ENB + PERIPH_CLK_TO_ENB_REG(c)) &
+			PERIPH_CLK_TO_ENB_BIT(c)))
+		c->state = OFF;
+	tegra2_clk_recalculate_rate(c);
+};
+
+static struct clk_ops tegra_clk_double_ops = {
+	.init       = &tegra2_clk_double_init,
+	.enable     = &tegra2_periph_clk_enable,
+	.disable    = &tegra2_periph_clk_disable,
+	.recalculate_rate = &tegra2_clk_recalculate_rate,
+};
+
+/* Clock definitions */
+static struct clk tegra_clk_32k = {
+	.name = "tegra_clk_32k",
+	.rate = 32678,
+	.ops  = NULL,
+};
+
+static struct clk_pll_table tegra_pll_s_table[] = {
+	{32768, 12000000, 366, 1, 1, 0},
+	{32768, 13000000, 397, 1, 1, 0},
+	{32768, 19200000, 586, 1, 1, 0},
+	{32768, 26000000, 793, 1, 1, 0},
+	{0, 0, 0, 0, 0, 0},
+};
+
+static struct clk tegra_pll_s = {
+	.name = "tegra_pll_s",
+	.ops = &tegra_pll_ops,
+	.reg       = 0xf0,
+	.input_min = 32768,
+	.input_max = 32768,
+	.parent     = &tegra_clk_32k,
+	.cf_min    = 0, /* FIXME */
+	.cf_max    = 0, /* FIXME */
+	.vco_min   = 12000000,
+	.vco_max   = 26000000,
+	.pll_table = tegra_pll_s_table,
+};
+
+static struct clk_mux_sel tegra_clk_m_sel[] = {
+	{ .input = &tegra_clk_32k, .value = 0},
+	{ .input = &tegra_pll_s,  .value = 1},
+	{ 0, 0},
+};
+static struct clk tegra_clk_m = {
+	.name      = "tegra_clk_m",
+	.flags     = ENABLE_ON_INIT,
+	.ops       = &tegra_clk_m_ops,
+	.inputs    = tegra_clk_m_sel,
+	.reg       = 0x1fc,
+	.reg_mask  = (1<<28),
+	.reg_shift = 28,
+};
+
+static struct clk_pll_table tegra_pll_c_table[] = {
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_c = {
+	.name      = "tegra_pll_c",
+	.flags	   = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0x80,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_c_table,
+};
+
+static struct clk tegra_pll_c_out1 = {
+	.name      = "tegra_pll_c_out1",
+	.ops       = &tegra_pll_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_c,
+	.reg       = 0x84,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_m_table[] = {
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_m = {
+	.name      = "tegra_pll_m",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0x90,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1200000000,
+	.pll_table = tegra_pll_m_table,
+};
+
+static struct clk tegra_pll_m_out1 = {
+	.name      = "tegra_pll_m_out1",
+	.ops       = &tegra_pll_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_m,
+	.reg       = 0x94,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_p_table[] = {
+	{ 12000000, 216000000, 432, 12, 2, 8},
+	{ 13000000, 216000000, 432, 13, 2, 8},
+	{ 19200000, 216000000, 90,   4, 2, 1},
+	{ 26000000, 216000000, 432, 26, 2, 8},
+	{ 12000000, 432000000, 432, 12, 1, 8},
+	{ 13000000, 432000000, 432, 13, 1, 8},
+	{ 19200000, 432000000, 90,   4, 1, 1},
+	{ 26000000, 432000000, 432, 26, 1, 8},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_p = {
+	.name      = "tegra_pll_p",
+	.flags     = ENABLE_ON_INIT | PLL_FIXED | PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xa0,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_p_table,
+};
+
+static struct clk tegra_pll_p_out1 = {
+	.name      = "tegra_pll_p_out1",
+	.ops       = &tegra_pll_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa4,
+	.reg_shift = 0,
+};
+
+static struct clk tegra_pll_p_out2 = {
+	.name      = "tegra_pll_p_out2",
+	.ops       = &tegra_pll_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa4,
+	.reg_shift = 16,
+};
+
+static struct clk tegra_pll_p_out3 = {
+	.name      = "tegra_pll_p_out3",
+	.ops       = &tegra_pll_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa8,
+	.reg_shift = 0,
+};
+
+static struct clk tegra_pll_p_out4 = {
+	.name      = "tegra_pll_p_out4",
+	.ops       = &tegra_pll_div_ops,
+	.flags     = ENABLE_ON_INIT | DIV_U71 | DIV_U71_FIXED,
+	.parent    = &tegra_pll_p,
+	.reg       = 0xa8,
+	.reg_shift = 16,
+};
+
+static struct clk_pll_table tegra_pll_a_table[] = {
+	{ 28800000, 56448000, 49, 25, 1, 1},
+	{ 28800000, 73728000, 64, 25, 1, 1},
+	{ 28800000, 11289600, 49, 25, 1, 1},
+	{ 28800000, 12288000, 64, 25, 1, 1},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_a = {
+	.name      = "tegra_pll_a",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xb0,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_pll_p_out1,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1400000000,
+	.pll_table = tegra_pll_a_table,
+};
+
+static struct clk tegra_pll_a_out0 = {
+	.name      = "tegra_pll_a_out0",
+	.ops       = &tegra_pll_div_ops,
+	.flags     = DIV_U71,
+	.parent    = &tegra_pll_a,
+	.reg       = 0xb4,
+	.reg_shift = 0,
+};
+
+static struct clk_pll_table tegra_pll_d_table[] = {
+	{ 12000000, 1000000000, 1000, 12, 1, 12},
+	{ 13000000, 1000000000, 1000, 13, 1, 12},
+	{ 19200000, 1000000000, 625,  12, 1, 8},
+	{ 26000000, 1000000000, 1000, 26, 1, 12},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_d = {
+	.name      = "tegra_pll_d",
+	.flags     = PLL_HAS_CPCON | PLLD,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xd0,
+	.input_min = 2000000,
+	.input_max = 40000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 40000000,
+	.vco_max   = 1000000000,
+	.pll_table = tegra_pll_d_table,
+};
+
+static struct clk tegra_pll_d_out0 = {
+	.name      = "tegra_pll_d_out0",
+	.ops       = &tegra_pll_div_ops,
+	.flags     = DIV_2 | PLLD,
+	.parent    = &tegra_pll_d,
+};
+
+static struct clk_pll_table tegra_pll_u_table[] = {
+	{ 12000000, 480000000, 960, 12, 1, 0},
+	{ 13000000, 480000000, 960, 13, 1, 0},
+	{ 19200000, 480000000, 200, 4,  1, 0},
+	{ 26000000, 480000000, 960, 26, 1, 0},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_u = {
+	.name      = "tegra_pll_u",
+	.flags     = 0,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xc0,
+	.input_min = 2000000,
+	.input_max = 40000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 480000000,
+	.vco_max   = 960000000,
+	.pll_table = tegra_pll_u_table,
+};
+
+static struct clk_pll_table tegra_pll_x_table[] = {
+	{ 12000000, 1000000000, 1000, 12, 1, 12},
+	{ 13000000, 1000000000, 1000, 13, 1, 12},
+	{ 19200000, 1000000000, 625,  12, 1, 8},
+	{ 26000000, 1000000000, 1000, 26, 1, 12},
+	{ 12000000, 750000000,  750,  12, 1, 12},
+	{ 13000000, 750000000,  750,  13, 1, 12},
+	{ 19200000, 750000000,  625,  16, 1, 8},
+	{ 26000000, 750000000,  750,  26, 1, 12},
+	{ 0, 0, 0, 0, 0, 0 },
+};
+
+static struct clk tegra_pll_x = {
+	.name      = "tegra_pll_x",
+	.flags     = PLL_HAS_CPCON,
+	.ops       = &tegra_pll_ops,
+	.reg       = 0xe0,
+	.input_min = 2000000,
+	.input_max = 31000000,
+	.parent    = &tegra_clk_m,
+	.cf_min    = 1000000,
+	.cf_max    = 6000000,
+	.vco_min   = 20000000,
+	.vco_max   = 1200000000,
+	.pll_table = tegra_pll_x_table,
+};
+
+static struct clk tegra_clk_d = {
+	.name      = "tegra_clk_d",
+	.flags     = PERIPH_NO_RESET,
+	.ops       = &tegra_clk_double_ops,
+	.clk_num   = 90,
+	.reg       = 0x34,
+	.reg_shift = 12,
+	.parent    = &tegra_clk_m,
+};
+
+/* FIXME: need tegra_audio
+static struct clk tegra_clk_audio_2x = {
+	.name      = "tegra_clk_d",
+	.flags     = PERIPH_NO_RESET,
+	.ops       = &tegra_clk_double_ops,
+	.clk_num   = 89,
+	.reg       = 0x34,
+	.reg_shift = 8,
+	.parent    = &tegra_audio,
+}
+*/
+
+static struct clk_mux_sel mux_cclk[] = {
+	{ .input = &tegra_clk_m,	.value = 0},
+	{ .input = &tegra_pll_c,	.value = 1},
+	{ .input = &tegra_clk_32k,	.value = 2},
+	{ .input = &tegra_pll_m,	.value = 3},
+	{ .input = &tegra_pll_p,	.value = 4},
+	{ .input = &tegra_pll_p_out4,	.value = 5},
+	{ .input = &tegra_pll_p_out3,	.value = 6},
+	{ .input = &tegra_clk_d,	.value = 7},
+	{ .input = &tegra_pll_x,	.value = 8},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_sclk[] = {
+	{ .input = &tegra_clk_m,	.value = 0},
+	{ .input = &tegra_pll_c_out1,	.value = 1},
+	{ .input = &tegra_pll_p_out4,	.value = 2},
+	{ .input = &tegra_pll_p_out3,	.value = 3},
+	{ .input = &tegra_pll_p_out2,	.value = 4},
+	{ .input = &tegra_clk_d,	.value = 5},
+	{ .input = &tegra_clk_32k,	.value = 6},
+	{ .input = &tegra_pll_m_out1,	.value = 7},
+	{ 0, 0},
+};
+
+static struct clk tegra_clk_cpu = {
+	.name	= "cpu",
+	.inputs	= mux_cclk,
+	.reg	= 0x20,
+	.ops	= &tegra_super_ops,
+};
+
+static struct clk tegra_clk_sys = {
+	.name	= "sys",
+	.inputs	= mux_sclk,
+	.reg	= 0x28,
+	.ops	= &tegra_super_ops,
+};
+
+static struct clk tegra_clk_hclk = {
+	.name		= "hclk",
+	.flags		= DIV_BUS,
+	.parent		= &tegra_clk_sys,
+	.reg		= 0x30,
+	.reg_shift	= 4,
+	.ops		= &tegra_bus_ops,
+};
+
+static struct clk tegra_clk_pclk = {
+	.name		= "pclk",
+	.flags		= DIV_BUS,
+	.parent		= &tegra_clk_hclk,
+	.reg		= 0x30,
+	.reg_shift	= 0,
+	.ops		= &tegra_bus_ops,
+};
+
+static struct clk_mux_sel mux_pllm_pllc_pllp_plla[] = {
+	{ .input = &tegra_pll_m, .value = 0},
+	{ .input = &tegra_pll_c, .value = 1},
+	{ .input = &tegra_pll_p, .value = 2},
+	{ .input = &tegra_pll_a_out0, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllm_pllc_pllp_clkm[] = {
+	{ .input = &tegra_pll_m, .value = 0},
+	{ .input = &tegra_pll_c, .value = 1},
+	{ .input = &tegra_pll_p, .value = 2},
+	{ .input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_pllm_clkm[] = {
+	{ .input = &tegra_pll_p, .value = 0},
+	{ .input = &tegra_pll_c, .value = 1},
+	{ .input = &tegra_pll_m, .value = 2},
+	{ .input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_plla_audio_pllp_clkm[] = {
+	{.input = &tegra_pll_a, .value = 0},
+	/* FIXME: no mux defined for tegra_audio
+	{.input = &tegra_audio, .value = 1},*/
+	{.input = &tegra_pll_p, .value = 2},
+	{.input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_plld_pllc_clkm[] = {
+	{.input = &tegra_pll_p, .value = 0},
+	{.input = &tegra_pll_d_out0, .value = 1},
+	{.input = &tegra_pll_c, .value = 2},
+	{.input = &tegra_clk_m, .value = 3},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_audio_clkm_clk32[] = {
+	{.input = &tegra_pll_p,     .value = 0},
+	{.input = &tegra_pll_c,     .value = 1},
+	/* FIXME: no mux defined for tegra_audio
+	{.input = &tegra_audio,     .value = 2},*/
+	{.input = &tegra_clk_m,     .value = 3},
+	{.input = &tegra_clk_32k,   .value = 4},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_pllc_pllm[] = {
+	{.input = &tegra_pll_p,     .value = 0},
+	{.input = &tegra_pll_c,     .value = 1},
+	{.input = &tegra_pll_m,     .value = 2},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_clk_m[] = {
+	{ .input = &tegra_clk_m, .value = 0},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_pllp_out3[] = {
+	{ .input = &tegra_pll_p_out3, .value = 0},
+	{ 0, 0},
+};
+
+static struct clk_mux_sel mux_clk_32k[] = {
+	{ .input = &tegra_clk_32k, .value = 0},
+	{ 0, 0},
+};
+
+#define PERIPH_CLK(_name, _dev, _con, _clk_num, _reg, _inputs, _flags) \
+	{						\
+		.name      = _name,			\
+		.lookup    = {				\
+			.dev_id    = _dev,		\
+			.con_id	   = _con,		\
+		},					\
+		.ops       = &tegra_periph_clk_ops,	\
+		.clk_num   = _clk_num,			\
+		.reg       = _reg,			\
+		.inputs    = _inputs,			\
+		.flags     = _flags,			\
+	}
+
+struct clk tegra_periph_clks[] = {
+	PERIPH_CLK("rtc",       "rtc-tegra",  NULL,   4,  0,     mux_clk_32k,                    PERIPH_NO_RESET),
+	PERIPH_CLK("timer",     "timer",      NULL,   5,  0,     mux_clk_m,                      0),
+	PERIPH_CLK("i2s1",      "i2s.0",      NULL,   11, 0x100, mux_plla_audio_pllp_clkm,       MUX | DIV_U71),
+	PERIPH_CLK("i2s2",      "i2s.1",      NULL,   18, 0x104, mux_plla_audio_pllp_clkm,       MUX | DIV_U71),
+	/* FIXME: spdif has 2 clocks but 1 enable */
+	PERIPH_CLK("spdif_out", "spdif_out",  NULL,   10, 0x108, mux_plla_audio_pllp_clkm,       MUX | DIV_U71),
+	PERIPH_CLK("spdif_in",  "spdif_in",   NULL,   10, 0x10c, mux_pllp_pllc_pllm,             MUX | DIV_U71),
+	PERIPH_CLK("pwm",       "pwm",        NULL,   17, 0x110, mux_pllp_pllc_audio_clkm_clk32, MUX | DIV_U71),
+	PERIPH_CLK("spi",       "spi",        NULL,   43, 0x114, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("xio",       "xio",        NULL,   45, 0x120, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("twc",       "twc",        NULL,   16, 0x12c, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sbc1",      "spi_tegra.0",NULL,   41, 0x134, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sbc2",      "spi_tegra.1",NULL,   44, 0x118, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sbc3",      "spi_tegra.2",NULL,   46, 0x11c, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sbc4",      "spi_tegra.3",NULL,   68, 0x1b4, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("ide",       "ide",        NULL,   25, 0x144, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("ndflash",   "tegra_nand", NULL,   13, 0x160, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	/* FIXME: vfir shares an enable with uartb */
+	PERIPH_CLK("vfir",      "vfir",       NULL,   7,  0x168, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sdmmc1",    "sdhci-tegra.0",    NULL,   14, 0x150, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sdmmc2",    "sdhci-tegra.1",    NULL,   9,  0x154, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sdmmc3",    "sdhci-tegra.2",    NULL,   69, 0x1bc, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("sdmmc4",    "sdhci-tegra.3",    NULL,   15, 0x160, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("vde",       "vde",        NULL,   61, 0x1c8, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("csite",     "csite",      NULL,   73, 0x1d4, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	/* FIXME: what is la? */
+	PERIPH_CLK("la",        "la",         NULL,   76, 0x1f8, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("owr",       "owr",        NULL,   71, 0x1cc, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("nor",       "nor",        NULL,   42, 0x1d0, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("mipi",      "mipi",       NULL,   50, 0x174, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("i2c1",      "tegra-i2c.0",      NULL,   12, 0x124, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("i2c2",      "tegra-i2c.1",      NULL,   54, 0x198, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("i2c3",      "tegra-i2c.2",      NULL,   67, 0x1b8, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("dvc",       "tegra-i2c.3",      NULL,   47, 0x128, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("i2c1_i2c",  "tegra-i2c.0",      "i2c",  0, 0, mux_pllp_out3,        0),
+	PERIPH_CLK("i2c2_i2c",  "tegra-i2c.1",      "i2c",  0, 0, mux_pllp_out3,        0),
+	PERIPH_CLK("i2c3_i2c",  "tegra-i2c.2",      "i2c",  0, 0, mux_pllp_out3,        0),
+	PERIPH_CLK("dvc_i2c",   "tegra-i2c.3",      "i2c",  0, 0, mux_pllp_out3,        0),
+	PERIPH_CLK("uarta",     "uart.0",     NULL,   6,  0x178, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uartb",     "uart.1",     NULL,   7,  0x17c, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uartc",     "uart.2",     NULL,   55, 0x1a0, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uartd",     "uart.3",     NULL,   65, 0x1c0, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("uarte",     "uart.4",     NULL,   66, 0x1c4, mux_pllp_pllc_pllm_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("3d",        "3d",         NULL,   24, 0x158, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("2d",        "2d",         NULL,   21, 0x15c, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	/* FIXME: vi and vi_sensor share an enable */
+	PERIPH_CLK("vi",        "vi",         NULL,   20, 0x148, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("vi_sensor", "vi_sensor",  NULL,   20, 0x1a8, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("epp",       "epp",        NULL,   19, 0x16c, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("mpe",       "mpe",        NULL,   60, 0x170, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	PERIPH_CLK("host1x",    "host1x",     NULL,   28, 0x180, mux_pllm_pllc_pllp_plla,        MUX | DIV_U71),
+	/* FIXME: cve and tvo share an enable  */
+	PERIPH_CLK("cve",       "cve",        NULL,   49, 0x140, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("tvo",       "tvo",        NULL,   49, 0x188, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("hdmi",      "hdmi",       NULL,   51, 0x18c, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("tvdac",     "tvdac",      NULL,   53, 0x194, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("disp1",     "tegrafb.0",  NULL,   27, 0x138, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("disp2",     "tegrafb.1",  NULL,   26, 0x13c, mux_pllp_plld_pllc_clkm,        MUX | DIV_U71),
+	PERIPH_CLK("usbd",      "fsl-tegra-udc",      NULL,   22, 0,     mux_clk_m,                    0),
+	PERIPH_CLK("usb2",      "usb.1",      NULL,   58, 0,     mux_clk_m,                              0),
+	PERIPH_CLK("usb3",      "usb.2",      NULL,   59, 0,     mux_clk_m,                              0),
+	PERIPH_CLK("emc",       "emc",        NULL,   57, 0x19c, mux_pllm_pllc_pllp_clkm,        MUX | DIV_U71 | PERIPH_EMC_ENB),
+};
+
+#define CLK_DUPLICATE(_name, _dev, _con) \
+	{						\
+		.name      = _name,			\
+		.lookup    = {				\
+			.dev_id    = _dev,		\
+			.con_id	   = _con,		\
+		},					\
+	}
+
+/* Some clocks may be used by different drivers depending on the board
+ * configuration.  List those here to register them twice in the clock lookup
+ * table under two names.
+ */
+struct clk_duplicate tegra_clk_duplicates[] = {
+	CLK_DUPLICATE("uarta", "tegra_uart.0", NULL),
+	CLK_DUPLICATE("uartb", "tegra_uart.1", NULL),
+	CLK_DUPLICATE("uartc", "tegra_uart.2", NULL),
+	CLK_DUPLICATE("uartd", "tegra_uart.3", NULL),
+	CLK_DUPLICATE("uarte", "tegra_uart.4", NULL),
+};
+
+#define CLK(dev, con, ck)     \
+	{       \
+		.dev_id = dev,  \
+		.con_id = con,  \
+		.clk = ck,  \
+	}
+
+struct clk_lookup tegra_clk_lookups[] = {
+	/* external root sources */
+	CLK(NULL, "32k_clk", &tegra_clk_32k),
+	CLK(NULL, "pll_s", &tegra_pll_s),
+	CLK(NULL, "clk_m", &tegra_clk_m),
+	CLK(NULL, "pll_m", &tegra_pll_m),
+	CLK(NULL, "pll_m_out1", &tegra_pll_m_out1),
+	CLK(NULL, "pll_c", &tegra_pll_c),
+	CLK(NULL, "pll_c_out1", &tegra_pll_c_out1),
+	CLK(NULL, "pll_p", &tegra_pll_p),
+	CLK(NULL, "pll_p_out1", &tegra_pll_p_out1),
+	CLK(NULL, "pll_p_out2", &tegra_pll_p_out2),
+	CLK(NULL, "pll_p_out3", &tegra_pll_p_out3),
+	CLK(NULL, "pll_p_out4", &tegra_pll_p_out4),
+	CLK(NULL, "pll_a",      &tegra_pll_a),
+	CLK(NULL, "pll_a_out0", &tegra_pll_a_out0),
+	CLK(NULL, "pll_d",      &tegra_pll_d),
+	CLK(NULL, "pll_d_out0", &tegra_pll_d_out0),
+	CLK(NULL, "pll_u",      &tegra_pll_u),
+	CLK(NULL, "pll_x",      &tegra_pll_x),
+	CLK(NULL, "cpu",	&tegra_clk_cpu),
+	CLK(NULL, "sys",	&tegra_clk_sys),
+	CLK(NULL, "hclk",	&tegra_clk_hclk),
+	CLK(NULL, "pclk",	&tegra_clk_pclk),
+	CLK(NULL, "clk_d",	&tegra_clk_d),
+};
+
+void tegra2_init_clocks(void)
+{
+	int i;
+	struct clk_lookup *cl;
+	struct clk *c;
+	struct clk_duplicate *cd;
+
+	for (i = 0; i < ARRAY_SIZE(tegra_clk_lookups); i++) {
+		cl = &tegra_clk_lookups[i];
+		clk_init(cl->clk);
+		clkdev_add(cl);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tegra_periph_clks); i++) {
+		c = &tegra_periph_clks[i];
+		cl = &c->lookup;
+		cl->clk = c;
+
+		clk_init(cl->clk);
+		clkdev_add(cl);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tegra_clk_duplicates); i++) {
+		cd = &tegra_clk_duplicates[i];
+		c = get_tegra_clock_by_name(cd->name);
+		if (c) {
+			cl = &cd->lookup;
+			cl->clk = c;
+			clkdev_add(cl);
+		} else {
+			pr_err("%s: Unknown duplicate clock %s\n", __func__,
+				cd->name);
+		}
+	}
+}
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index 8f10d24..2f8adca 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -12,7 +12,7 @@
 #
 #   http://www.arm.linux.org.uk/developer/machines/?action=new
 #
-# Last update: Sat May 1 10:36:42 2010
+# Last update: Fri Jun 4 07:10:47 2010
 #
 # machine_is_xxx	CONFIG_xxxx		MACH_TYPE_xxx		number
 #
@@ -1319,7 +1319,7 @@ mistral			MACH_MISTRAL		MISTRAL			1315
 msm			MACH_MSM		MSM			1316
 ct5910			MACH_CT5910		CT5910			1317
 ct5912			MACH_CT5912		CT5912			1318
-hynet_ine		MACH_HYNET_INE		HYNET_INE		1319
+argonst_foundation	MACH_HYNET_INE		HYNET_INE		1319
 hynet_app		MACH_HYNET_APP		HYNET_APP		1320
 msm7200			MACH_MSM7200		MSM7200			1321
 msm7600			MACH_MSM7600		MSM7600			1322
@@ -1777,7 +1777,7 @@ wdg002			MACH_WDG002		WDG002			1785
 sg560adsl		MACH_SG560ADSL		SG560ADSL		1786
 nextio_n2800_ica	MACH_NEXTIO_N2800_ICA	NEXTIO_N2800_ICA	1787
 dove_db			MACH_DOVE_DB		DOVE_DB			1788
-marvell_newdb		MACH_MARVELL_NEWDB	MARVELL_NEWDB		1789
+dove_avng		MACH_MARVELL_NEWDB	MARVELL_NEWDB		1789
 vandihud		MACH_VANDIHUD		VANDIHUD		1790
 magx_e8			MACH_MAGX_E8		MAGX_E8			1791
 magx_z6			MACH_MAGX_Z6		MAGX_Z6			1792
@@ -2308,7 +2308,7 @@ ecac2378		MACH_ECAC2378		ECAC2378		2319
 tazkiosk		MACH_TAZKIOSK		TAZKIOSK		2320
 whiterabbit_mch		MACH_WHITERABBIT_MCH	WHITERABBIT_MCH		2321
 sbox9263		MACH_SBOX9263		SBOX9263		2322
-oreo			MACH_OREO		OREO			2323
+oreo_camera		MACH_OREO		OREO			2323
 smdk6442		MACH_SMDK6442		SMDK6442		2324
 openrd_base		MACH_OPENRD_BASE	OPENRD_BASE		2325
 incredible		MACH_INCREDIBLE		INCREDIBLE		2326
@@ -2374,7 +2374,7 @@ sch_m490		MACH_SCH_M490		SCH_M490		2386
 rbl01			MACH_RBL01		RBL01			2387
 omnifi			MACH_OMNIFI		OMNIFI			2388
 otavalo			MACH_OTAVALO		OTAVALO			2389
-sienna			MACH_SIENNA		SIENNA			2390
+siena			MACH_SIENNA		SIENNA			2390
 htc_excalibur_s620	MACH_HTC_EXCALIBUR_S620	HTC_EXCALIBUR_S620	2391
 htc_opal		MACH_HTC_OPAL		HTC_OPAL		2392
 touchbook		MACH_TOUCHBOOK		TOUCHBOOK		2393
@@ -2498,7 +2498,7 @@ hiram			MACH_HIRAM		HIRAM			2510
 phy3250			MACH_PHY3250		PHY3250			2511
 ea3250			MACH_EA3250		EA3250			2512
 fdi3250			MACH_FDI3250		FDI3250			2513
-whitestone		MACH_WHITESTONE		WHITESTONE		2514
+htcwhitestone		MACH_WHITESTONE		WHITESTONE		2514
 at91sam9263nit		MACH_AT91SAM9263NIT	AT91SAM9263NIT		2515
 ccmx51			MACH_CCMX51		CCMX51			2516
 ccmx51js		MACH_CCMX51JS		CCMX51JS		2517
@@ -2582,7 +2582,7 @@ omap3_bulldog		MACH_OMAP3_BULLDOG	OMAP3_BULLDOG		2594
 pca101			MACH_PCA101		PCA101			2595
 buzzc			MACH_BUZZC		BUZZC			2596
 sasie2			MACH_SASIE2		SASIE2			2597
-davinci_cio		MACH_DAVINCI_CIO	DAVINCI_CIO		2598
+davinci_dm6467_cio	MACH_DAVINCI_CIO	DAVINCI_CIO		2598
 smartmeter_dl		MACH_SMARTMETER_DL	SMARTMETER_DL		2599
 wzl6410			MACH_WZL6410		WZL6410			2600
 wzl6410m		MACH_WZL6410M		WZL6410M		2601
@@ -2750,7 +2750,7 @@ h6053			MACH_H6053		H6053			2762
 smint01			MACH_SMINT01		SMINT01			2763
 prtlvt2			MACH_PRTLVT2		PRTLVT2			2764
 ap420			MACH_AP420		AP420			2765
-htcshift		MACH_HTCSHIFT		HTCSHIFT		2766
+htcclio			MACH_HTCSHIFT		HTCSHIFT		2766
 davinci_dm365_fc	MACH_DAVINCI_DM365_FC	DAVINCI_DM365_FC	2767
 msm8x55_surf		MACH_MSM8X55_SURF	MSM8X55_SURF		2768
 msm8x55_ffa		MACH_MSM8X55_FFA	MSM8X55_FFA		2769
@@ -2761,7 +2761,7 @@ oreo_controller		MACH_OREO_CONTROLLER	OREO_CONTROLLER		2773
 kopin_models		MACH_KOPIN_MODELS	KOPIN_MODELS		2774
 ttc_vision2		MACH_TTC_VISION2	TTC_VISION2		2775
 cns3420vb		MACH_CNS3420VB		CNS3420VB		2776
-lpc2			MACH_LPC2		LPC2			2777
+lpc_evo			MACH_LPC2		LPC2			2777
 olympus			MACH_OLYMPUS		OLYMPUS			2778
 vortex			MACH_VORTEX		VORTEX			2779
 s5pc200			MACH_S5PC200		S5PC200			2780
@@ -2788,7 +2788,7 @@ ti8168evm		MACH_TI8168EVM		TI8168EVM		2800
 neocoreomap		MACH_NEOCOREOMAP	NEOCOREOMAP		2801
 withings_wbp		MACH_WITHINGS_WBP	WITHINGS_WBP		2802
 dbps			MACH_DBPS		DBPS			2803
-sbc9261			MACH_SBC9261		SBC9261			2804
+at91sam9261		MACH_SBC9261		SBC9261			2804
 pcbfp0001		MACH_PCBFP0001		PCBFP0001		2805
 speedy			MACH_SPEEDY		SPEEDY			2806
 chrysaor		MACH_CHRYSAOR		CHRYSAOR		2807
@@ -2804,3 +2804,81 @@ teton_bga		MACH_TETON_BGA		TETON_BGA		2816
 snapper9g45		MACH_SNAPPER9G45	SNAPPER9G45		2817
 tam3517			MACH_TAM3517		TAM3517			2818
 pdc100			MACH_PDC100		PDC100			2819
+eukrea_cpuimx25sd	MACH_EUKREA_CPUIMX25	EUKREA_CPUIMX25		2820
+eukrea_cpuimx35sd	MACH_EUKREA_CPUIMX35	EUKREA_CPUIMX35		2821
+eukrea_cpuimx51sd	MACH_EUKREA_CPUIMX51SD	EUKREA_CPUIMX51SD	2822
+eukrea_cpuimx51		MACH_EUKREA_CPUIMX51	EUKREA_CPUIMX51		2823
+p565			MACH_P565		P565			2824
+acer_a4			MACH_ACER_A4		ACER_A4			2825
+davinci_dm368_bip	MACH_DAVINCI_DM368_BIP	DAVINCI_DM368_BIP	2826
+eshare			MACH_ESHARE		ESHARE			2827
+hw_omapl138_europa	MACH_HW_OMAPL138_EUROPA	HW_OMAPL138_EUROPA	2828
+wlbargn			MACH_WLBARGN		WLBARGN			2829
+bm170			MACH_BM170		BM170			2830
+netspace_mini_v2	MACH_NETSPACE_MINI_V2	NETSPACE_MINI_V2	2831
+netspace_plug_v2	MACH_NETSPACE_PLUG_V2	NETSPACE_PLUG_V2	2832
+siemens_l1		MACH_SIEMENS_L1		SIEMENS_L1		2833
+elv_lcu1		MACH_ELV_LCU1		ELV_LCU1		2834
+mcu1			MACH_MCU1		MCU1			2835
+omap3_tao3530		MACH_OMAP3_TAO3530	OMAP3_TAO3530		2836
+omap3_pcutouch		MACH_OMAP3_PCUTOUCH	OMAP3_PCUTOUCH		2837
+smdkc210		MACH_SMDKC210		SMDKC210		2838
+omap3_braillo		MACH_OMAP3_BRAILLO	OMAP3_BRAILLO		2839
+spyplug			MACH_SPYPLUG		SPYPLUG			2840
+ginger			MACH_GINGER		GINGER			2841
+tny_t3530		MACH_TNY_T3530		TNY_T3530		2842
+pca102			MACH_PCA102		PCA102			2843
+spade			MACH_SPADE		SPADE			2844
+mxc25_topaz		MACH_MXC25_TOPAZ	MXC25_TOPAZ		2845
+t5325			MACH_T5325		T5325			2846
+gw2361			MACH_GW2361		GW2361			2847
+elog			MACH_ELOG		ELOG			2848
+income			MACH_INCOME		INCOME			2849
+bcm589x			MACH_BCM589X		BCM589X			2850
+etna			MACH_ETNA		ETNA			2851
+hawks			MACH_HAWKS		HAWKS			2852
+meson			MACH_MESON		MESON			2853
+xsbase255		MACH_XSBASE255		XSBASE255		2854
+pvm2030			MACH_PVM2030		PVM2030			2855
+mioa502			MACH_MIOA502		MIOA502			2856
+vvbox_sdorig2		MACH_VVBOX_SDORIG2	VVBOX_SDORIG2		2857
+vvbox_sdlite2		MACH_VVBOX_SDLITE2	VVBOX_SDLITE2		2858
+vvbox_sdpro4		MACH_VVBOX_SDPRO4	VVBOX_SDPRO4		2859
+htc_spv_m700		MACH_HTC_SPV_M700	HTC_SPV_M700		2860
+mx257sx			MACH_MX257SX		MX257SX			2861
+goni			MACH_GONI		GONI			2862
+msm8x55_svlte_ffa	MACH_MSM8X55_SVLTE_FFA	MSM8X55_SVLTE_FFA	2863
+msm8x55_svlte_surf	MACH_MSM8X55_SVLTE_SURF	MSM8X55_SVLTE_SURF	2864
+quickstep		MACH_QUICKSTEP		QUICKSTEP		2865
+dmw96			MACH_DMW96		DMW96			2866
+hammerhead		MACH_HAMMERHEAD		HAMMERHEAD		2867
+trident			MACH_TRIDENT		TRIDENT			2868
+lightning		MACH_LIGHTNING		LIGHTNING		2869
+iconnect		MACH_ICONNECT		ICONNECT		2870
+autobot			MACH_AUTOBOT		AUTOBOT			2871
+coconut			MACH_COCONUT		COCONUT			2872
+durian			MACH_DURIAN		DURIAN			2873
+cayenne			MACH_CAYENNE		CAYENNE			2874
+fuji			MACH_FUJI		FUJI			2875
+synology_6282		MACH_SYNOLOGY_6282	SYNOLOGY_6282		2876
+em1sy			MACH_EM1SY		EM1SY			2877
+m502			MACH_M502		M502			2878
+matrix518		MACH_MATRIX518		MATRIX518		2879
+tiny_gurnard		MACH_TINY_GURNARD	TINY_GURNARD		2880
+spear1310		MACH_SPEAR1310		SPEAR1310		2881
+bv07			MACH_BV07		BV07			2882
+mxt_td61		MACH_MXT_TD61		MXT_TD61		2883
+openrd_ultimate		MACH_OPENRD_ULTIMATE	OPENRD_ULTIMATE		2884
+devixp			MACH_DEVIXP		DEVIXP			2885
+miccpt			MACH_MICCPT		MICCPT			2886
+mic256			MACH_MIC256		MIC256			2887
+as1167			MACH_AS1167		AS1167			2888
+omap3_ibiza		MACH_OMAP3_IBIZA	OMAP3_IBIZA		2889
+u5500			MACH_U5500		U5500			2890
+davinci_picto		MACH_DAVINCI_PICTO	DAVINCI_PICTO		2891
+mecha			MACH_MECHA		MECHA			2892
+bubba3			MACH_BUBBA3		BUBBA3			2893
+pupitre			MACH_PUPITRE		PUPITRE			2894
+tegra_harmony		MACH_TEGRA_HARMONY	TEGRA_HARMONY		2895
+tegra_vogue		MACH_TEGRA_VOGUE	TEGRA_VOGUE		2896
+tegra_e1165		MACH_TEGRA_E1165	TEGRA_E1165		2897
-- 
1.5.6.5
