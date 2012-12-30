From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Sat, 29 Dec 2012 16:33:30 -0800
Subject: [PATCH v5 01/12] clk: samsung: add common clock framework helper
 functions for Samsung platforms
In-Reply-To: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1356827621-27617-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Samsung platforms include different types of clock including fixed-rate,
mux, divider and gate clock types. There are typically hundreds of such clocks
on each of the Samsung platforms. To enable Samsung platforms to register these
clocks using the common clock framework, a bunch of utility functions are
introduced here which simplify the clock registration process. The clocks are
usually statically instantiated and registered with common clock framework.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/clk/Makefile         |    1 +
 drivers/clk/samsung/Makefile |    5 +
 drivers/clk/samsung/clk.c    |  180 +++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk.h    |  216 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 402 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/samsung/Makefile
 create mode 100644 drivers/clk/samsung/clk.c
 create mode 100644 drivers/clk/samsung/clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ee90e87..aa14ab3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 obj-$(CONFIG_ARCH_SUNXI)	+= clk-sunxi.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= clk-zynq.o
+obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
 
 # Chip specific
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
new file mode 100644
index 0000000..bd920b4
--- /dev/null
+++ b/drivers/clk/samsung/Makefile
@@ -0,0 +1,5 @@
+#
+# Samsung Clock specific Makefile
+#
+
+obj-$(CONFIG_COMMON_CLK)	+= clk.o
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
new file mode 100644
index 0000000..af000fb
--- /dev/null
+++ b/drivers/clk/samsung/clk.c
@@ -0,0 +1,180 @@
+/*
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2012 Linaro Ltd.
+ * Author: Thomas Abraham <thomas.ab@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file includes utility functions to register clocks to common
+ * clock framework for Samsung platforms.
+*/
+
+#include "clk.h"
+
+static DEFINE_SPINLOCK(lock);
+static struct clk **clk_table;
+static void __iomem *reg_base;
+#ifdef CONFIG_OF
+static struct clk_onecell_data clk_data;
+#endif
+
+/* setup the essentials required to support clock lookup using ccf */
+void __init samsung_clk_init(struct device_node *np, void __iomem *base,
+				unsigned long nr_clks)
+{
+	reg_base = base;
+	if (!np)
+		return;
+
+#ifdef CONFIG_OF
+	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
+	if (!clk_table)
+		panic("could not allocate clock lookup table\n");
+
+	clk_data.clks = clk_table;
+	clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+#endif
+}
+
+/* add a clock instance to the clock lookup table used for dt based lookup */
+void samsung_clk_add_lookup(struct clk *clk, unsigned int id)
+{
+	if (clk_table && id)
+		clk_table[id] = clk;
+}
+
+/* register a list of fixed clocks */
+void __init samsung_clk_register_fixed_rate(
+		struct samsung_fixed_rate_clock *list, unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		clk = clk_register_fixed_rate(NULL, list->name,
+			list->parent_name, list->flags, list->fixed_rate);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				list->name);
+			continue;
+		}
+
+		samsung_clk_add_lookup(clk, list->id);
+
+		/*
+		 * Unconditionally add a clock lookup for the fixed rate clocks.
+		 * There are not many of these on any of Samsung platforms.
+		 */
+		ret = clk_register_clkdev(clk, list->name, NULL);
+		if (ret)
+			pr_err("%s: failed to register clock lookup for %s",
+				__func__, list->name);
+	}
+}
+
+/* register a list of mux clocks */
+void __init samsung_clk_register_mux(struct samsung_mux_clock *list,
+					unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		clk = clk_register_mux(NULL, list->name, list->parent_names,
+			list->num_parents, list->flags, reg_base + list->offset,
+			list->shift, list->width, list->mux_flags, &lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				list->name);
+			continue;
+		}
+
+		samsung_clk_add_lookup(clk, list->id);
+
+		/* register a clock lookup only if a clock alias is specified */
+		if (list->alias) {
+			ret = clk_register_clkdev(clk, list->alias,
+						list->dev_name);
+			if (ret)
+				pr_err("%s: failed to register lookup %s\n",
+						__func__, list->alias);
+		}
+	}
+}
+
+/* register a list of div clocks */
+void __init samsung_clk_register_div(struct samsung_div_clock *list,
+					unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		clk = clk_register_divider(NULL, list->name, list->parent_name,
+			list->flags, reg_base + list->offset, list->shift,
+			list->width, list->div_flags, &lock);
+		if (IS_ERR(clk)) {
+			pr_err("clock: failed to register clock %s\n",
+				list->name);
+			continue;
+		}
+
+		samsung_clk_add_lookup(clk, list->id);
+
+		/* register a clock lookup only if a clock alias is specified */
+		if (list->alias) {
+			ret = clk_register_clkdev(clk, list->alias,
+						list->dev_name);
+			if (ret)
+				pr_err("%s: failed to register lookup %s\n",
+						__func__, list->alias);
+		}
+	}
+}
+
+/* register a list of gate clocks */
+void __init samsung_clk_register_gate(struct samsung_gate_clock *list,
+						unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		clk = clk_register_gate(NULL, list->name, list->parent_name,
+				list->flags, reg_base + list->offset,
+				list->bit_idx, list->gate_flags, &lock);
+		if (IS_ERR(clk)) {
+			pr_err("clock: failed to register clock %s\n",
+				list->name);
+			continue;
+		}
+
+		/* register a clock lookup only if a clock alias is specified */
+		if (list->alias) {
+			ret = clk_register_clkdev(clk, list->alias,
+							list->dev_name);
+			if (ret)
+				pr_err("%s: failed to register lookup %s\n",
+					__func__, list->alias);
+		}
+
+		samsung_clk_add_lookup(clk, list->id);
+	}
+}
+
+/* utility function to get the rate of a specified clock */
+unsigned long _get_rate(const char *clk_name)
+{
+	struct clk *clk;
+	unsigned long rate;
+
+	clk = clk_get(NULL, clk_name);
+	if (IS_ERR(clk))
+		return 0;
+	rate = clk_get_rate(clk);
+	clk_put(clk);
+	return rate;
+}
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
new file mode 100644
index 0000000..4013edf
--- /dev/null
+++ b/drivers/clk/samsung/clk.h
@@ -0,0 +1,216 @@
+/*
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2012 Linaro Ltd.
+ * Author: Thomas Abraham <thomas.ab@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Common Clock Framework support for all Samsung platforms
+*/
+
+#ifndef __SAMSUNG_CLK_H
+#define __SAMSUNG_CLK_H
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <mach/map.h>
+
+/**
+ * struct samsung_fixed_rate_clock: information about fixed-rate clock
+ * @id: platform specific id of the clock.
+ * @name: name of this fixed-rate clock.
+ * @parent_name: optional parent clock name.
+ * @flags: optional fixed-rate clock flags.
+ * @fixed-rate: fixed clock rate of this clock.
+ */
+struct samsung_fixed_rate_clock {
+	unsigned int		id;
+	char			*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		fixed_rate;
+};
+
+#define FRATE(_id, cname, pname, f, frate)	\
+	{						\
+		.id		= _id,			\
+		.name		= cname,		\
+		.parent_name	= pname,		\
+		.flags		= f,			\
+		.fixed_rate	= frate,		\
+	}
+
+/**
+ * struct samsung_mux_clock: information about mux clock
+ * @id: platform specific id of the clock.
+ * @dev_name: name of the device to which this clock belongs.
+ * @name: name of this mux clock.
+ * @parent_names: array of pointer to parent clock names.
+ * @num_parents: number of parents listed in @parent_names.
+ * @flags: optional flags for basic clock.
+ * @offset: offset of the register for configuring the mux.
+ * @shift: starting bit location of the mux control bit-field in @reg.
+ * @width: width of the mux control bit-field in @reg.
+ * @mux_flags: flags for mux-type clock.
+ * @alias: optional clock alias name to be assigned to this clock.
+ */
+struct samsung_mux_clock {
+	unsigned int		id;
+	const char		*dev_name;
+	const char		*name;
+	const char		**parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			mux_flags;
+	const char		*alias;
+};
+
+#define __MUX(_id, dname, cname, pnames, o, s, w, f, mf, a)	\
+	{							\
+		.id		= _id,				\
+		.dev_name	= dname,			\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.offset		= o,				\
+		.shift		= s,				\
+		.width		= w,				\
+		.mux_flags	= mf,				\
+		.alias		= a,				\
+	}
+
+#define MUX(_id, cname, pnames, o, s, w)			\
+	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, NULL)
+
+#define MUX_A(_id, cname, pnames, o, s, w, a)			\
+	__MUX(_id, NULL, cname, pnames, o, s, w, 0, 0, a)
+
+#define MUX_F(_id, cname, pnames, o, s, w, f, mf)		\
+	__MUX(_id, NULL, cname, pnames, o, s, w, f, mf, NULL)
+
+/**
+ * @id: platform specific id of the clock.
+ * struct samsung_div_clock: information about div clock
+ * @dev_name: name of the device to which this clock belongs.
+ * @name: name of this div clock.
+ * @parent_name: name of the parent clock.
+ * @flags: optional flags for basic clock.
+ * @offset: offset of the register for configuring the div.
+ * @shift: starting bit location of the div control bit-field in @reg.
+ * @div_flags: flags for div-type clock.
+ * @alias: optional clock alias name to be assigned to this clock.
+ */
+struct samsung_div_clock {
+	unsigned int		id;
+	const char		*dev_name;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			div_flags;
+	const char		*alias;
+};
+
+#define __DIV(_id, dname, cname, pname, o, s, w, f, df, a)	\
+	{							\
+		.id		= _id,				\
+		.dev_name	= dname,			\
+		.name		= cname,			\
+		.parent_name	= pname,			\
+		.flags		= f,				\
+		.offset		= o,				\
+		.shift		= s,				\
+		.width		= w,				\
+		.div_flags	= df,				\
+		.alias		= a,				\
+	}
+
+#define DIV(_id, cname, pname, o, s, w)				\
+	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, NULL)
+
+#define DIV_A(_id, cname, pname, o, s, w, a)			\
+	__DIV(_id, NULL, cname, pname, o, s, w, 0, 0, a)
+
+#define DIV_F(_id, cname, pname, o, s, w, f, df)		\
+	__DIV(_id, NULL, cname, pname, o, s, w, f, df, NULL)
+
+/**
+ * struct samsung_gate_clock: information about gate clock
+ * @id: platform specific id of the clock.
+ * @dev_name: name of the device to which this clock belongs.
+ * @name: name of this gate clock.
+ * @parent_name: name of the parent clock.
+ * @flags: optional flags for basic clock.
+ * @offset: offset of the register for configuring the gate.
+ * @bit_idx: bit index of the gate control bit-field in @reg.
+ * @gate_flags: flags for gate-type clock.
+ * @alias: optional clock alias name to be assigned to this clock.
+ */
+struct samsung_gate_clock {
+	unsigned int		id;
+	const char		*dev_name;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			bit_idx;
+	u8			gate_flags;
+	const char		*alias;
+};
+
+#define __GATE(_id, dname, cname, pname, o, b, f, gf, a)	\
+	{							\
+		.id		= _id,				\
+		.dev_name	= dname,			\
+		.name		= cname,			\
+		.parent_name	= pname,			\
+		.flags		= f,				\
+		.offset		= o,				\
+		.bit_idx	= b,				\
+		.gate_flags	= gf,				\
+		.alias		= a,				\
+	}
+
+#define GATE(_id, cname, pname, o, b, f, gf)			\
+	__GATE(_id, NULL, cname, pname, o, b, f, gf, NULL)
+
+#define GATE_A(_id, cname, pname, o, b, f, gf, a)		\
+	__GATE(_id, NULL, cname, pname, o, b, f, gf, a)
+
+#define GATE_D(_id, dname, cname, pname, o, b, f, gf)		\
+	__GATE(_id, dname, cname, pname, o, b, f, gf, NULL)
+
+#define GATE_DA(_id, dname, cname, pname, o, b, f, gf, a)	\
+	__GATE(_id, dname, cname, pname, o, b, f, gf, a)
+
+#define PNAME(x) static const char *x[] __initdata
+
+extern void __init samsung_clk_init(struct device_node *np, void __iomem *base,
+					unsigned long nr_clks);
+extern void samsung_clk_add_lookup(struct clk *clk, unsigned int id);
+
+extern void __init samsung_clk_register_fixed_rate(
+		struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk);
+extern void __init samsung_clk_register_mux(struct samsung_mux_clock *clk_list,
+		unsigned int nr_clk);
+extern void __init samsung_clk_register_div(struct samsung_div_clock *clk_list,
+		unsigned int nr_clk);
+extern void __init samsung_clk_register_gate(
+		struct samsung_gate_clock *clk_list, unsigned int nr_clk);
+
+extern unsigned long _get_rate(const char *clk_name);
+
+#endif /* __SAMSUNG_CLK_H */
-- 
1.7.5.4
