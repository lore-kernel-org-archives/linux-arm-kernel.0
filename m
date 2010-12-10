From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:17 +0000
Subject: [PATCH v3 06/14] picoxcell: add support for system clks
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-7-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The different picoXcell device variants have different numbers of clocks
and different capabilities (PC3X2 doesn't have any gateable or
controllable clocks). Add the infrastructure necessary for device
variants to provide their own clock implementation.

v2: allow multiple clk lookups so we can have aliases

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile              |    3 +-
 arch/arm/mach-picoxcell/clk.c                 |  134 +++++++++++++++++++++++++
 arch/arm/mach-picoxcell/include/mach/clkdev.h |   71 +++++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c      |    4 +
 4 files changed, 211 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/clk.c
 create mode 100644 arch/arm/mach-picoxcell/include/mach/clkdev.h

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 29b52e8..71a6523 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1,4 +1,5 @@
 obj-y				:= picoxcell_core.o io.o axi2cfg.o \
 				   time.o \
 				   mux.o \
-				   gpio.o
+				   gpio.o \
+				   clk.o
diff --git a/arch/arm/mach-picoxcell/clk.c b/arch/arm/mach-picoxcell/clk.c
new file mode 100644
index 0000000..a6136ff
--- /dev/null
+++ b/arch/arm/mach-picoxcell/clk.c
@@ -0,0 +1,134 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+
+#include <mach/clkdev.h>
+
+static DEFINE_SPINLOCK(clk_lock);
+static LIST_HEAD(picoxcell_clks);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->get_rate ? clk->get_rate(clk) : clk->rate;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	return clk->round_rate ? clk->round_rate(clk, rate) : -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return clk->set_rate ? clk->set_rate(clk, rate) : 0;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+int __clk_enable(struct clk *clk)
+{
+	if (++clk->enable_count > 0) {
+		if (clk->enable)
+			clk->enable(clk);
+	}
+
+	return 0;
+}
+
+int clk_enable(struct clk *clk)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	ret = __clk_enable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void __clk_disable(struct clk *clk)
+{
+	if (--clk->enable_count <= 0) {
+		if (clk->disable)
+			clk->disable(clk);
+	}
+}
+
+void clk_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+	__clk_disable(clk);
+	spin_unlock_irqrestore(&clk_lock, flags);
+}
+EXPORT_SYMBOL(clk_disable);
+
+static int clk_is_enabled(struct clk *clk)
+{
+	return clk->is_enabled ? clk->is_enabled(clk) : 1;
+}
+
+static ssize_t clocks_show(struct seq_file *s, void *priv)
+{
+	struct clk *clk;
+	ssize_t ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clk_lock, flags);
+
+	ret += seq_printf(s, "%16s%16s%16s\n\n", "name", "enabled", "rate");
+	list_for_each_entry(clk, &picoxcell_clks, head) {
+		ret += seq_printf(s, "%16s%16s%16d\n", clk->name,
+				  clk_is_enabled(clk) ? "enabled" : "disabled",
+				  clk->rate >= 0 ? clk->rate :
+					clk->get_rate(clk) * 1000);
+	}
+
+	spin_unlock_irqrestore(&clk_lock, flags);
+
+	return ret;
+}
+
+static int clocks_debugfs_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, clocks_show, inode->i_private);
+}
+
+static const struct file_operations clocks_debugfs_fops = {
+	.owner		= THIS_MODULE,
+	.open		= clocks_debugfs_open,
+	.llseek		= seq_lseek,
+	.read		= seq_read,
+	.release	= single_release,
+};
+
+void __init picoxcell_clk_debugfs_init(void)
+{
+	/* We only get called if debugfs is enabled and configured. */
+	struct dentry *clocks_debugfs_file = debugfs_create_file("clocks",
+			0444, arch_debugfs_dir, NULL, &clocks_debugfs_fops);
+	if (IS_ERR(clocks_debugfs_file)) {
+		pr_err("failed to create clocks debugfs entry (%ld)\n",
+		       PTR_ERR(clocks_debugfs_file));
+	}
+}
+
+void picoxcell_clk_add(struct clk *clk)
+{
+	list_add_tail(&clk->head, &picoxcell_clks);
+}
diff --git a/arch/arm/mach-picoxcell/include/mach/clkdev.h b/arch/arm/mach-picoxcell/include/mach/clkdev.h
new file mode 100644
index 0000000..437f7e8
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/clkdev.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#ifndef __PICOXCELL_CLKDEV_H__
+#define __PICOXCELL_CLKDEV_H__
+
+#include <asm/clkdev.h>
+
+struct clk {
+	const char	    *name;
+	struct list_head    head;
+	int		    rate;
+	unsigned	    min, max, step; /* min, max and frequency steps for
+					       variable rate clocks in KHz. */
+	int		    enable_count;
+	int		    clk_num;
+	void		    (*enable)(struct clk *clk);
+	void		    (*disable)(struct clk *clk);
+	int		    (*is_enabled)(struct clk *clk);
+	long		    (*round_rate)(struct clk *clk, unsigned long rate);
+	int		    (*set_rate)(struct clk *clk, unsigned long rate);
+	int		    (*get_rate)(struct clk *clk);
+};
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
+extern void __init picoxcell_clk_debugfs_init(void);
+extern void picoxcell_clk_add(struct clk *clk);
+extern int __clk_enable(struct clk *clk);
+extern void __clk_disable(struct clk *clk);
+
+/*
+ * Declare a new clock with a given rate and ID. All clocks are enabled by
+ * default.
+ */
+#define FIXED_CLK(__name, __rate, __id)					\
+	static struct clk __name ## _clk = {				\
+		.name		= #__name,				\
+		.rate		= __rate,				\
+		.clk_num	= __id,					\
+		.enable_count	= 1,					\
+	}
+
+#define VARIABLE_CLK(__name, __id, __min, __max, __step)		\
+	static struct clk __name ## _clk = {				\
+		.name		= #__name,				\
+		.clk_num	= __id,					\
+		.enable_count	= 1,					\
+		.rate		= -1,					\
+		.min		= __min,				\
+		.max		= __max,				\
+		.step		= __step,				\
+	}
+
+#define CLK_LOOKUP(__dev_id, __con_id, __clk) \
+	{ .dev_id = __dev_id, .con_id = __con_id, .clk = __clk }
+
+#endif /* __PICOXCELL_CLKDEV_H__ */
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index a8f6056..c261500 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -17,6 +17,7 @@
 #include <asm/hardware/vic.h>
 #include <asm/mach-types.h>
 
+#include <mach/clkdev.h>
 #include <mach/hardware.h>
 
 #include "mux.h"
@@ -152,6 +153,7 @@ static void __init picoxcell_debugfs_init(void)
 		arch_debugfs_dir = NULL;
 		return;
 	}
+	picoxcell_clk_debugfs_init();
 }
 
 /*
@@ -258,6 +260,8 @@ void __init picoxcell_core_init(void)
 	/* Add the arch debugfs entry. */
 	picoxcell_debugfs_init();
 
+	soc->init_clocks();
+
 	/* Initialise the pin muxing and gpio infrastructure. */
 	picoxcell_muxing_init(soc);
 
-- 
1.7.2.3
