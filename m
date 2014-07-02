From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Jul 2014 01:58:39 +0200
Subject: [PATCH v5 04/14] clk: rockchip: add basic infrastructure for clock
 branches
In-Reply-To: <156042792.J76K6jxIGl@diego>
References: <156042792.J76K6jxIGl@diego>
Message-ID: <1605742.qS05PTXZXD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds infrastructure for registering clock branches. On Rockchip SoCs
most clock branches are a combination of mux,divider and gate components,
thus a composite clock is used when appropriate.

Clock branches are supposed to be declared in an array using the COMPOSITE*
or MUX, etc makros defined in the header and then registered using
rockchip_clk_register_branches.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-By: Max Schwarz <max.schwarz@online.de>
Tested-By: Max Schwarz <max.schwarz@online.de>
---
 drivers/clk/rockchip/Makefile |   1 +
 drivers/clk/rockchip/clk.c    | 209 +++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.h    | 250 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 460 insertions(+)
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
index 0000000..aa15d5a
--- /dev/null
+++ b/drivers/clk/rockchip/clk.c
@@ -0,0 +1,209 @@
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
+/**
+ * Register a clock branch.
+ * Most clock branches have a form like
+ *
+ * src1 --|--\
+ *        |M |--[GATE]-[DIV]-
+ * src2 --|--/
+ *
+ * sometimes without one of those components.
+ */
+struct clk *rockchip_clk_register_branch(const char *name,
+		const char **parent_names, u8 num_parents, void __iomem *base,
+		int muxdiv_offset, u8 mux_shift, u8 mux_width, u8 mux_flags,
+		u8 div_shift, u8 div_width, u8 div_flags,
+		struct clk_div_table *div_table, int gate_offset,
+		u8 gate_shift, u8 gate_flags, unsigned long flags,
+		spinlock_t *lock)
+{
+	struct clk *clk;
+	struct clk_mux *mux = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_divider *div = NULL;
+	const struct clk_ops *mux_ops = NULL, *div_ops = NULL,
+			     *gate_ops = NULL;
+
+	if (num_parents > 1) {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+
+		mux->reg = base + muxdiv_offset;
+		mux->shift = mux_shift;
+		mux->mask = BIT(mux_width) - 1;
+		mux->flags = mux_flags;
+		mux->lock = lock;
+		mux_ops = (mux_flags & CLK_MUX_READ_ONLY) ? &clk_mux_ro_ops
+							: &clk_mux_ops;
+	}
+
+	if (gate_offset >= 0) {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			return ERR_PTR(-ENOMEM);
+
+		gate->flags = gate_flags;
+		gate->reg = base + gate_offset;
+		gate->bit_idx = gate_shift;
+		gate->lock = lock;
+		gate_ops = &clk_gate_ops;
+	}
+
+	if (div_width > 0) {
+		div = kzalloc(sizeof(*div), GFP_KERNEL);
+		if (!div)
+			return ERR_PTR(-ENOMEM);
+
+		div->flags = div_flags;
+		div->reg = base + muxdiv_offset;
+		div->shift = div_shift;
+		div->width = div_width;
+		div->lock = lock;
+		div->table = div_table;
+		div_ops = (div_flags & CLK_DIVIDER_READ_ONLY)
+						? &clk_divider_ro_ops
+						: &clk_divider_ops;
+	}
+
+	clk = clk_register_composite(NULL, name, parent_names, num_parents,
+				     mux ? &mux->hw : NULL, mux_ops,
+				     div ? &div->hw : NULL, div_ops,
+				     gate ? &gate->hw : NULL, gate_ops,
+				     flags);
+
+	return clk;
+}
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
+	clk_table = kcalloc(nr_clks, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_table)
+		pr_err("%s: could not allocate clock lookup table\n", __func__);
+
+	clk_data.clks = clk_table;
+	clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+
+void rockchip_clk_add_lookup(struct clk *clk, unsigned int id)
+{
+	if (clk_table && id)
+		clk_table[id] = clk;
+}
+
+void __init rockchip_clk_register_branches(
+				      struct rockchip_clk_branch *list,
+				      unsigned int nr_clk)
+{
+	struct clk *clk = NULL;
+	unsigned int idx;
+	unsigned long flags;
+
+	for (idx = 0; idx < nr_clk; idx++, list++) {
+		flags = list->flags;
+
+		/* catch simple muxes */
+		switch (list->branch_type) {
+		case branch_mux:
+			clk = clk_register_mux(NULL, list->name,
+				list->parent_names, list->num_parents,
+				flags, reg_base + list->muxdiv_offset,
+				list->mux_shift, list->mux_width,
+				list->mux_flags, &clk_lock);
+			break;
+		case branch_divider:
+			if (list->div_table)
+				clk = clk_register_divider_table(NULL,
+					list->name, list->parent_names[0],
+					flags, reg_base + list->muxdiv_offset,
+					list->div_shift, list->div_width,
+					list->div_flags, list->div_table,
+					&clk_lock);
+			else
+				clk = clk_register_divider(NULL, list->name,
+					list->parent_names[0], flags,
+					reg_base + list->muxdiv_offset,
+					list->div_shift, list->div_width,
+					list->div_flags, &clk_lock);
+			break;
+		case branch_fraction_divider:
+			/* unimplemented */
+			continue;
+			break;
+		case branch_gate:
+			flags |= CLK_SET_RATE_PARENT;
+
+			/* keep all gates untouched for now */
+			flags |= CLK_IGNORE_UNUSED;
+
+			clk = clk_register_gate(NULL, list->name,
+				list->parent_names[0], flags,
+				reg_base + list->gate_offset,
+				list->gate_shift, list->gate_flags, &clk_lock);
+			break;
+		case branch_composite:
+			/* keep all gates untouched for now */
+			flags |= CLK_IGNORE_UNUSED;
+
+			clk = rockchip_clk_register_branch(list->name,
+				list->parent_names, list->num_parents,
+				reg_base, list->muxdiv_offset, list->mux_shift,
+				list->mux_width, list->mux_flags,
+				list->div_shift, list->div_width,
+				list->div_flags, list->div_table,
+				list->gate_offset, list->gate_shift,
+				list->gate_flags, flags, &clk_lock);
+			break;
+		}
+
+		/* none of the cases above matched */
+		if (!clk) {
+			pr_err("%s: unknown clock type %d\n",
+			       __func__, list->branch_type);
+			continue;
+		}
+
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s: %ld\n",
+			       __func__, list->name, PTR_ERR(clk));
+			continue;
+		}
+
+		rockchip_clk_add_lookup(clk, list->id);
+	}
+}
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
new file mode 100644
index 0000000..5b051b0
--- /dev/null
+++ b/drivers/clk/rockchip/clk.h
@@ -0,0 +1,250 @@
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
+#define RK2928_MISC_CON		0x134
+
+#define PNAME(x) static const char *x[] __initconst
+
+enum rockchip_clk_branch_type {
+	branch_composite,
+	branch_mux,
+	branch_divider,
+	branch_fraction_divider,
+	branch_gate,
+};
+
+struct rockchip_clk_branch {
+	unsigned int			id;
+	enum rockchip_clk_branch_type	branch_type;
+	const char			*name;
+	const char			**parent_names;
+	u8				num_parents;
+	unsigned long			flags;
+	int				muxdiv_offset;
+	u8				mux_shift;
+	u8				mux_width;
+	u8				mux_flags;
+	u8				div_shift;
+	u8				div_width;
+	u8				div_flags;
+	struct clk_div_table		*div_table;
+	int				gate_offset;
+	u8				gate_shift;
+	u8				gate_flags;
+};
+
+#define COMPOSITE(_id, cname, pnames, f, mo, ms, mw, mf, ds, dw,\
+		  df, go, gs, gf)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_composite,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.mux_flags	= mf,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+	}
+
+#define COMPOSITE_NOMUX(_id, cname, pname, f, mo, ds, dw, df,	\
+			go, gs, gf)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_composite,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+	}
+
+#define COMPOSITE_NOMUX_DIVTBL(_id, cname, pname, f, mo, ds, dw,\
+			       df, dt, go, gs, gf)		\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_composite,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.div_table	= dt,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+	}
+
+#define COMPOSITE_NODIV(_id, cname, pnames, f, mo, ms, mw, mf,	\
+			go, gs, gf)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_composite,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.mux_flags	= mf,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+	}
+
+#define COMPOSITE_NOGATE(_id, cname, pnames, f, mo, ms, mw, mf,	\
+			 ds, dw, df)				\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_composite,		\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.mux_shift	= ms,				\
+		.mux_width	= mw,				\
+		.mux_flags	= mf,				\
+		.div_shift	= ds,				\
+		.div_width	= dw,				\
+		.div_flags	= df,				\
+		.gate_offset	= -1,				\
+	}
+
+#define COMPOSITE_FRAC(_id, cname, pname, f, mo, df, go, gs, gf)\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_fraction_divider,	\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= mo,				\
+		.div_shift	= 16,				\
+		.div_width	= 16,				\
+		.div_flags	= df,				\
+		.gate_offset	= go,				\
+		.gate_shift	= gs,				\
+		.gate_flags	= gf,				\
+	}
+
+#define MUX(_id, cname, pnames, f, o, s, w, mf)			\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_mux,			\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.muxdiv_offset	= o,				\
+		.mux_shift	= s,				\
+		.mux_width	= w,				\
+		.mux_flags	= mf,				\
+		.gate_offset	= -1,				\
+	}
+
+#define DIV(_id, cname, pname, f, o, s, w, df)			\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_divider,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= o,				\
+		.div_shift	= s,				\
+		.div_width	= w,				\
+		.div_flags	= df,				\
+		.gate_offset	= -1,				\
+	}
+
+#define DIVTBL(_id, cname, pname, f, o, s, w, df, dt)		\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_divider,		\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.muxdiv_offset	= o,				\
+		.div_shift	= s,				\
+		.div_width	= w,				\
+		.div_flags	= df,				\
+		.div_table	= dt,				\
+	}
+
+#define GATE(_id, cname, pname, f, o, b, gf)			\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_gate,			\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.gate_offset	= o,				\
+		.gate_shift	= b,				\
+		.gate_flags	= gf,				\
+	}
+
+
+void rockchip_clk_init(struct device_node *np, void __iomem *base,
+		       unsigned long nr_clks);
+void rockchip_clk_add_lookup(struct clk *clk, unsigned int id);
+void rockchip_clk_register_branches(struct rockchip_clk_branch *clk_list,
+				    unsigned int nr_clk);
+
+#endif
-- 
1.9.0
