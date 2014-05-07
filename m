From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 07 May 2014 23:11:46 +0200
Subject: [PATCH v2 02/11] clk: rockchip: add basic infrastructure
In-Reply-To: <3477211.Gkyeur83TV@diego>
References: <3477211.Gkyeur83TV@diego>
Message-ID: <15907890.b9dRjoX1rg@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds infrastructure for registering basic clock types. It is heavily inspired
by the Samsung implementation and fits surprisingly well to the Rockchip clock
controllers.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/Makefile |   1 +
 drivers/clk/rockchip/clk.c    | 131 ++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.h    | 160 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 292 insertions(+)
 create mode 100644 drivers/clk/rockchip/clk.c
 create mode 100644 drivers/clk/rockchip/clk.h

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 8d3aefa..0068a8b 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-y	+= clk-rockchip.o
+obj-y	+= clk.o
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
new file mode 100644
index 0000000..b71413e
--- /dev/null
+++ b/drivers/clk/rockchip/clk.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright (c) 2014 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * based on
+ *
+ * samsung/clk.c
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2013 Linaro Ltd.
+ * Author: Thomas Abraham <thomas.ab@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/slab.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include "clk.h"
+
+static DEFINE_SPINLOCK(clk_lock);
+static struct clk **clk_table;
+static void __iomem *reg_base;
+static struct clk_onecell_data clk_data;
+
+void __init rockchip_clk_init(struct device_node *np, void __iomem *base,
+			      unsigned long nr_clks)
+{
+	reg_base = base;
+
+	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
+	if (!clk_table)
+		pr_err("%s: could not allocate clock lookup table\n", __func__);
+
+	if (!np)
+		return;
+
+#ifdef CONFIG_OF
+	clk_data.clks = clk_table;
+	clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+#endif
+}
+
+void rockchip_clk_add_lookup(struct clk *clk, unsigned int id)
+{
+	if (clk_table && id)
+		clk_table[id] = clk;
+}
+
+void __init rockchip_clk_register_mux(struct rockchip_mux_clock *list,
+				      unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		clk = clk_register_mux(NULL, list->name, list->parent_names,
+			list->num_parents, list->flags, reg_base + list->offset,
+			list->shift, list->width, list->mux_flags, &clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				list->name);
+			continue;
+		}
+
+		rockchip_clk_add_lookup(clk, list->id);
+	}
+}
+
+void __init rockchip_clk_register_div(struct rockchip_div_clock *list,
+					unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		if (list->table)
+			clk = clk_register_divider_table(NULL, list->name,
+					list->parent_name, list->flags,
+					reg_base + list->offset, list->shift,
+					list->width, list->div_flags,
+					list->table, &clk_lock);
+		else
+			clk = clk_register_divider(NULL, list->name,
+					list->parent_name, list->flags,
+					reg_base + list->offset, list->shift,
+					list->width, list->div_flags,
+					&clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				list->name);
+			continue;
+		}
+
+		rockchip_clk_add_lookup(clk, list->id);
+	}
+}
+
+void __init rockchip_clk_register_gate(struct rockchip_gate_clock *list,
+			       unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx;
+	unsigned long flags;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		flags = list->flags | CLK_SET_RATE_PARENT;
+
+		/* keep all gates untouched for now */
+		flags |= CLK_IGNORE_UNUSED;
+
+		clk = clk_register_gate(NULL, list->name, list->parent_name,
+				flags, reg_base + list->offset,
+				list->bit_idx, list->gate_flags, &clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				list->name);
+			continue;
+		}
+
+		rockchip_clk_add_lookup(clk, list->id);
+	}
+}
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
new file mode 100644
index 0000000..2b42c8b
--- /dev/null
+++ b/drivers/clk/rockchip/clk.h
@@ -0,0 +1,160 @@
+/*
+ * Copyright (c) 2014 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
+ *
+ * based on
+ *
+ * samsung/clk.h
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2013 Linaro Ltd.
+ * Author: Thomas Abraham <thomas.ab@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef CLK_ROCKCHIP_CLK_H
+#define CLK_ROCKCHIP_CLK_H
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#define HIWORD_UPDATE(val, mask, shift) \
+		((val) << (shift) | (mask) << ((shift) + 16))
+
+/* register positions shared by RK2928, RK3066 and RK3188 */
+#define RK2928_PLL_CON(x)		(x * 0x4)
+#define RK2928_MODE_CON		0x40
+#define RK2928_CLKSEL_CON(x)	(x * 0x4 + 0x44)
+#define RK2928_CLKGATE_CON(x)	(x * 0x4 + 0xd0)
+#define RK2928_GLB_SRST_FST		0x100
+#define RK2928_GLB_SRST_SND		0x104
+#define RK2928_SOFTRST_CON(x)	(x * 0x4 + 0x110)
+
+#define PNAME(x) static const char *x[] __initconst
+
+/**
+ * struct rockchip_mux_clock: information about mux clock
+ * @id: platform specific id of the clock.
+ * @name: name of this mux clock.
+ * @parent_names: array of pointer to parent clock names.
+ * @num_parents: number of parents listed in @parent_names.
+ * @flags: optional flags for basic clock.
+ * @offset: offset of the register for configuring the mux.
+ * @shift: starting bit location of the mux control bit-field in @reg.
+ * @width: width of the mux control bit-field in @reg.
+ * @mux_flags: flags for mux-type clock.
+ */
+struct rockchip_mux_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		**parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			mux_flags;
+};
+
+#define MUX(_id, cname, pnames, o, s, w, f, mf)			\
+	{							\
+		.id		= _id,				\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.offset		= o,				\
+		.shift		= s,				\
+		.width		= w,				\
+		.mux_flags	= mf,				\
+	}
+
+/**
+ * struct rockchip_div_clock: information about div clock
+ * @id: platform specific id of the clock.
+ * @name: name of this div clock.
+ * @parent_name: name of the parent clock.
+ * @flags: optional flags for basic clock.
+ * @offset: offset of the register for configuring the div.
+ * @shift: starting bit location of the div control bit-field in @reg.
+ * @div_flags: flags for div-type clock.
+ */
+struct rockchip_div_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			div_flags;
+	struct clk_div_table	*table;
+};
+
+#define DIV(_id, cname, pname, o, s, w, f, df, t)		\
+	{							\
+		.id		= _id,				\
+		.name		= cname,			\
+		.parent_name	= pname,			\
+		.flags		= f,				\
+		.offset		= o,				\
+		.shift		= s,				\
+		.width		= w,				\
+		.div_flags	= df,				\
+		.table		= t,				\
+	}
+
+
+/**
+ * struct rockchip_gate_clock: information about gate clock
+ * @id: platform specific id of the clock.
+ * @name: name of this gate clock.
+ * @parent_name: name of the parent clock.
+ * @flags: optional flags for basic clock.
+ * @offset: offset of the register for configuring the gate.
+ * @bit_idx: bit index of the gate control bit-field in @reg.
+ * @gate_flags: flags for gate-type clock.
+ */
+struct rockchip_gate_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			bit_idx;
+	u8			gate_flags;
+};
+
+#define GATE(_id, cname, pname, o, b, f, gf)			\
+	{							\
+		.id		= _id,				\
+		.name		= cname,			\
+		.parent_name	= pname,			\
+		.flags		= f,				\
+		.offset		= o,				\
+		.bit_idx	= b,				\
+		.gate_flags	= gf,				\
+	}
+
+void rockchip_clk_init(struct device_node *np, void __iomem *base,
+		       unsigned long nr_clks);
+
+void rockchip_clk_add_lookup(struct clk *clk, unsigned int id);
+
+void rockchip_clk_register_mux(struct rockchip_mux_clock *clk_list,
+			       unsigned int nr_clk);
+void rockchip_clk_register_div(struct rockchip_div_clock *clk_list,
+			       unsigned int nr_clk);
+void rockchip_clk_register_gate(struct rockchip_gate_clock *clk_list,
+				unsigned int nr_clk);
+
+#endif
-- 
1.9.0
