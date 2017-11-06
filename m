From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue,  7 Nov 2017 01:15:52 +0530
Subject: [PATCH v2 3/3] clk: actions: Add clock driver for Actions S900 SoC
In-Reply-To: <1509997552-29718-1-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1509997552-29718-1-git-send-email-manivannan.sadhasivam@linaro.org>
Message-ID: <1509997552-29718-4-git-send-email-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock driver for Actions Semi OWL series S900 SoC

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v2:

1. Changed the directory structure to actions/ and used owl- prefix
   for sources.
2. Fixed MAINTAINERS and added Andreas as Designated Reviewer (R:).
3. Introduced new Kconfig for S900 code part (CONFIG_CLK_OWL_S900).
4. Changed the license from GPLv2 to GPLv2+.
5. Added CLK_IGNORE_UNUSED flag to some essential PLL's

 MAINTAINERS                      |   8 +
 drivers/clk/Kconfig              |   1 +
 drivers/clk/Makefile             |   1 +
 drivers/clk/actions/Kconfig      |   6 +
 drivers/clk/actions/Makefile     |   2 +
 drivers/clk/actions/owl-clk.c    | 316 +++++++++++++++++++++
 drivers/clk/actions/owl-clk.h    | 298 ++++++++++++++++++++
 drivers/clk/actions/owl-factor.c | 268 ++++++++++++++++++
 drivers/clk/actions/owl-pll.c    | 344 +++++++++++++++++++++++
 drivers/clk/actions/owl-s900.c   | 585 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 1829 insertions(+)
 create mode 100644 drivers/clk/actions/Kconfig
 create mode 100644 drivers/clk/actions/Makefile
 create mode 100644 drivers/clk/actions/owl-clk.c
 create mode 100644 drivers/clk/actions/owl-clk.h
 create mode 100644 drivers/clk/actions/owl-factor.c
 create mode 100644 drivers/clk/actions/owl-pll.c
 create mode 100644 drivers/clk/actions/owl-s900.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d750..b774081 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1098,6 +1098,14 @@ F:	arch/arm/mach-*/
 F:	arch/arm/plat-*/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 
+ARM/ACTIONS SEMI SoC CLOCK SUPPORT
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+R:	Andreas F?rber <afaerber@suse.de>
+S:	Maintained
+F:	drivers/clk/actions/
+F:	include/dt-bindings/clock/actions,s900-cmu.h
+F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+
 ARM/ACTIONS SEMI ARCHITECTURE
 M:	Andreas F?rber <afaerber@suse.de>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 1c4e1aa..b063ce8 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -226,6 +226,7 @@ config COMMON_CLK_VC5
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
 
+source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c99f363..5fc361b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_COMMON_CLK_WM831X)		+= clk-wm831x.o
 obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 
 # please keep this section sorted lexicographically by directory path name
+obj-$(CONFIG_ARCH_ACTIONS)		+= actions/
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 obj-$(CONFIG_ARCH_ARTPEC)		+= axis/
 obj-$(CONFIG_ARC_PLAT_AXS10X)		+= axs10x/
diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
new file mode 100644
index 0000000..0de7a03
--- /dev/null
+++ b/drivers/clk/actions/Kconfig
@@ -0,0 +1,6 @@
+config CLK_OWL_S900
+	bool "Clock Driver for Actions S900 SoC"
+	depends on ARCH_ACTIONS || COMPILE_TEST
+	default ARCH_ACTIONS
+	help
+	  Build the clock driver for Actions S900 SoC.
diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
new file mode 100644
index 0000000..83bef30
--- /dev/null
+++ b/drivers/clk/actions/Makefile
@@ -0,0 +1,2 @@
+obj-y				+= owl-clk.o owl-pll.o owl-factor.o
+obj-$(CONFIG_CLK_OWL_S900)	+= owl-s900.o
diff --git a/drivers/clk/actions/owl-clk.c b/drivers/clk/actions/owl-clk.c
new file mode 100644
index 0000000..4fb1aee
--- /dev/null
+++ b/drivers/clk/actions/owl-clk.c
@@ -0,0 +1,316 @@
+/*
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Author: David Liu <liuwei@actions-semi.com>
+ *
+ * Copyright (c) 2017 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ *
+ * based on
+ *
+ * samsung/clk.c
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2013 Linaro Ltd.
+ * Author: Thomas Abraham <thomas.ab@owl.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "owl-clk.h"
+
+void owl_clk_add_hw_data(struct owl_clk_provider *ctx, struct clk_hw *clk_hw,
+				unsigned int id)
+{
+	if (id)
+		ctx->clk_data.hws[id] = clk_hw;
+}
+
+/* register a list of fixed factor clocks */
+void owl_clk_register_fixed_factor(struct owl_clk_provider *ctx,
+			struct owl_fixed_factor_clock *clks, int nums)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = clk_hw_register_fixed_factor(NULL, clks[i].name,
+				clks[i].parent_name, clks[i].flags,
+				clks[i].mult, clks[i].div);
+		if (IS_ERR(clk_hw)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		owl_clk_add_hw_data(ctx, clk_hw, clks[i].id);
+	}
+}
+
+/* register a list of pll clocks */
+void owl_clk_register_pll(struct owl_clk_provider *ctx,
+			struct owl_pll_clock *clks, int nums)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = owl_pll_clk_register(clks[i].name, clks[i].parent_name,
+				clks[i].flags, ctx->reg_base + clks[i].offset,
+				clks[i].bfreq, clks[i].enable_bit,
+				clks[i].shift, clks[i].width,
+				clks[i].min_mul, clks[i].max_mul,
+				clks[i].pll_flags, clks[i].table,
+				&ctx->lock);
+		if (IS_ERR(clk_hw)) {
+			pr_err("%s: failed to register clock %s\n",
+				__func__, clks[i].name);
+			continue;
+
+		}
+
+		owl_clk_add_hw_data(ctx, clk_hw, clks[i].id);
+	}
+}
+
+/* register a list of divider clocks */
+void owl_clk_register_divider(struct owl_clk_provider *ctx,
+		struct owl_divider_clock *clks, int nums)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = clk_hw_register_divider_table(NULL, clks[i].name,
+				clks[i].parent_name, clks[i].flags,
+				ctx->reg_base + clks[i].offset, clks[i].shift,
+				clks[i].width, clks[i].div_flags,
+				clks[i].table, &ctx->lock);
+		if (IS_ERR(clk_hw)) {
+			pr_err("%s: failed to register clock %s\n",
+				__func__, clks[i].name);
+			continue;
+		}
+
+		owl_clk_add_hw_data(ctx, clk_hw, clks[i].id);
+	}
+}
+
+/* register a list of factor divider clocks */
+void owl_clk_register_factor(struct owl_clk_provider *ctx,
+		struct owl_factor_clock *clks, int nums)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = owl_factor_clk_register(NULL, clks[i].name,
+				clks[i].parent_name, clks[i].flags,
+				ctx->reg_base + clks[i].offset, clks[i].shift,
+				clks[i].width, clks[i].div_flags,
+				clks[i].table, &ctx->lock);
+		if (IS_ERR(clk_hw)) {
+			pr_err("%s: failed to register clock %s\n",
+				__func__, clks[i].name);
+			continue;
+		}
+
+		owl_clk_add_hw_data(ctx, clk_hw, clks[i].id);
+	}
+}
+
+/* register a list of mux clocks */
+void owl_clk_register_mux(struct owl_clk_provider *ctx,
+		struct owl_mux_clock *clks, int nums)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = clk_hw_register_mux(NULL, clks[i].name,
+				clks[i].parent_names, clks[i].num_parents,
+				clks[i].flags, ctx->reg_base + clks[i].offset,
+				clks[i].shift, clks[i].width,
+				clks[i].mux_flags, &ctx->lock);
+		if (IS_ERR(clk_hw)) {
+			pr_err("%s: failed to register clock %s\n",
+				__func__, clks[i].name);
+			continue;
+		}
+
+		owl_clk_add_hw_data(ctx, clk_hw, clks[i].id);
+	}
+}
+
+/* register a list of gate clocks */
+void owl_clk_register_gate(struct owl_clk_provider *ctx,
+		struct owl_gate_clock *clks, int nums)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = clk_hw_register_gate(NULL, clks[i].name,
+				clks[i].parent_name, clks[i].flags,
+				ctx->reg_base + clks[i].offset,
+				clks[i].bit_idx, clks[i].gate_flags,
+				&ctx->lock);
+		if (IS_ERR(clk_hw)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		owl_clk_add_hw_data(ctx, clk_hw, clks[i].id);
+	}
+}
+
+static struct clk_hw *_register_composite(struct owl_clk_provider *ctx,
+			struct owl_composite_clock *cclk)
+{
+	struct clk_hw *clk_hw;
+	struct owl_mux_clock *amux;
+	struct owl_gate_clock *agate;
+	union rate_clock *arate;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk_fixed_factor *fixed_factor = NULL;
+	struct clk_divider *div = NULL;
+	struct owl_factor *factor = NULL;
+	struct clk_hw *mux_hw = NULL;
+	struct clk_hw *gate_hw = NULL;
+	struct clk_hw *rate_hw = NULL;
+	const struct clk_ops *rate_ops = NULL;
+	const char *clk_name = cclk->name;
+	const char **parent_names;
+	int i, num_parents;
+
+	amux = &cclk->mux;
+	agate = &cclk->gate;
+	arate = &cclk->rate;
+
+	parent_names = NULL;
+	num_parents = 0;
+
+	if (amux->id) {
+		num_parents = amux->num_parents;
+		if (num_parents > 0) {
+			parent_names = kzalloc((sizeof(char *) * num_parents),
+					GFP_KERNEL);
+			if (!parent_names)
+				return ERR_PTR(-ENOMEM);
+
+			for (i = 0; i < num_parents; i++)
+				parent_names[i] = kstrdup(amux->parent_names[i],
+						GFP_KERNEL);
+		}
+
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return NULL;
+
+		/* set up gate properties */
+		mux->reg = ctx->reg_base + amux->offset;
+		mux->shift = amux->shift;
+		mux->mask = BIT(amux->width) - 1;
+		mux->flags = amux->mux_flags;
+		mux->lock = &ctx->lock;
+		mux_hw = &mux->hw;
+	}
+
+	if (arate->fixed_factor.id) {
+		switch (cclk->type) {
+		case OWL_COMPOSITE_TYPE_FIXED_FACTOR:
+			fixed_factor = kzalloc(sizeof(*fixed_factor),
+					GFP_KERNEL);
+			if (!fixed_factor)
+				return NULL;
+			fixed_factor->mult = arate->fixed_factor.mult;
+			fixed_factor->div = arate->fixed_factor.div;
+
+			rate_ops = &clk_fixed_factor_ops;
+			rate_hw = &fixed_factor->hw;
+			break;
+
+		case OWL_COMPOSITE_TYPE_DIVIDER:
+			div = kzalloc(sizeof(*div), GFP_KERNEL);
+			if (!div)
+				return NULL;
+			div->reg = ctx->reg_base + arate->div.offset;
+			div->shift = arate->div.shift;
+			div->width = arate->div.width;
+			div->flags = arate->div.div_flags;
+			div->table = arate->div.table;
+			div->lock = &ctx->lock;
+
+			rate_ops = &clk_divider_ops;
+			rate_hw = &div->hw;
+			break;
+
+		case OWL_COMPOSITE_TYPE_FACTOR:
+			factor = kzalloc(sizeof(*factor), GFP_KERNEL);
+			if (!factor)
+				return NULL;
+			factor->reg = ctx->reg_base + arate->factor.offset;
+			factor->shift = arate->factor.shift;
+			factor->width = arate->factor.width;
+			factor->flags = arate->factor.div_flags;
+			factor->table = arate->factor.table;
+			factor->lock = &ctx->lock;
+
+			rate_ops = &owl_factor_ops;
+			rate_hw = &factor->hw;
+			break;
+
+		default:
+			break;
+		}
+	}
+
+	if (agate->id) {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			return ERR_PTR(-ENOMEM);
+
+		/* set up gate properties */
+		gate->reg = ctx->reg_base + agate->offset;
+		gate->bit_idx = agate->bit_idx;
+		gate->lock = &ctx->lock;
+		gate_hw = &gate->hw;
+	}
+
+	clk_hw = clk_hw_register_composite(NULL, clk_name,
+			parent_names, num_parents,
+			mux_hw, &clk_mux_ops,
+			rate_hw, rate_ops,
+			gate_hw, &clk_gate_ops, cclk->flags);
+
+	return clk_hw;
+}
+
+/* register a list of composite clocks */
+void owl_clk_register_composite(struct owl_clk_provider *ctx,
+		struct owl_composite_clock *clks, int nums)
+{
+	struct clk_hw *clk_hw;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk_hw = _register_composite(ctx, &clks[i]);
+		if (IS_ERR(clk_hw)) {
+			pr_err("%s: failed to register clock %s\n",
+				__func__, clks[i].name);
+			continue;
+		}
+
+		owl_clk_add_hw_data(ctx, clk_hw, clks[i].id);
+	}
+}
diff --git a/drivers/clk/actions/owl-clk.h b/drivers/clk/actions/owl-clk.h
new file mode 100644
index 0000000..8e61f17b
--- /dev/null
+++ b/drivers/clk/actions/owl-clk.h
@@ -0,0 +1,298 @@
+/*
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Author: David Liu <liuwei@actions-semi.com>
+ *
+ * Copyright (c) 2017 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ *
+ * based on
+ *
+ * samsung/clk.h
+ * Copyright (c) 2013 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2013 Linaro Ltd.
+ * Author: Thomas Abraham <thomas.ab@owl.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __OWL_CLK_H
+#define __OWL_CLK_H
+
+#include <linux/clk-provider.h>
+
+struct owl_clk_provider {
+	void __iomem		*reg_base;
+	struct clk_hw_onecell_data clk_data;
+	spinlock_t		lock;
+};
+
+struct owl_fixed_factor_clock {
+	unsigned int		id;
+	char			*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned int		mult;
+	unsigned int		div;
+};
+
+/* last entry should have rate = 0 */
+struct clk_pll_table {
+	unsigned int		val;
+	unsigned long		rate;
+};
+
+struct owl_pll_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	unsigned long		bfreq;
+	u8			enable_bit;
+	u8			shift;
+	u8			width;
+	u8			min_mul;
+	u8			max_mul;
+	u8			pll_flags;
+	const struct clk_pll_table *table;
+};
+
+#define CLK_OWL_PLL_FIXED_FREQ	BIT(0)
+
+struct owl_divider_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			div_flags;
+	struct clk_div_table	*table;
+	const char		*alias;
+};
+
+struct clk_factor_table {
+	unsigned int		val;
+	unsigned int		mul;
+	unsigned int		div;
+};
+
+struct owl_factor_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			div_flags;
+	struct clk_factor_table	*table;
+	const char		*alias;
+};
+
+struct owl_factor {
+	struct clk_hw		hw;
+	void __iomem		*reg;
+	u8			shift;
+	u8			width;
+	u8			flags;
+	const struct clk_factor_table *table;
+	spinlock_t		*lock;
+};
+
+extern const struct clk_ops owl_factor_ops;
+
+struct owl_mux_clock {
+	unsigned int		id;
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
+struct owl_gate_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			bit_idx;
+	u8			gate_flags;
+	const char		*alias;
+};
+
+union rate_clock {
+	struct owl_fixed_factor_clock	fixed_factor;
+	struct owl_divider_clock	div;
+	struct owl_factor_clock		factor;
+};
+
+struct owl_composite_clock {
+	unsigned int		id;
+	const char		*name;
+	unsigned int		type;
+	unsigned long		flags;
+
+	struct owl_mux_clock	mux;
+	struct owl_gate_clock	gate;
+	union rate_clock	rate;
+};
+
+#define OWL_COMPOSITE_TYPE_DIVIDER         1
+#define OWL_COMPOSITE_TYPE_FACTOR          2
+#define OWL_COMPOSITE_TYPE_FIXED_FACTOR    3
+#define OWL_COMPOSITE_TYPE_PASS            10
+
+#define COMP_FIXED_FACTOR_CLK(_id, _name, _flags, _mux, _gate, _fixed_factor) \
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.type		= OWL_COMPOSITE_TYPE_FIXED_FACTOR,	\
+		.flags		= _flags,				\
+		.mux		= _mux,					\
+		.gate		= _gate,				\
+		.rate.fixed_factor = _fixed_factor,			\
+	}
+
+#define COMP_DIV_CLK(_id, _name, _flags, _mux, _gate, _div)		\
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.type		= OWL_COMPOSITE_TYPE_DIVIDER,		\
+		.flags		= _flags,				\
+		.mux		= _mux,					\
+		.gate		= _gate,				\
+		.rate.div	= _div,					\
+	}
+
+#define COMP_FACTOR_CLK(_id, _name, _flags, _mux, _gate, _factor)	\
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.type		= OWL_COMPOSITE_TYPE_FACTOR,		\
+		.flags		= _flags,				\
+		.mux		= _mux,					\
+		.gate		= _gate,				\
+		.rate.factor	= _factor,				\
+	}
+
+#define COMP_PASS_CLK(_id, _name, _flags, _mux, _gate)			\
+	{								\
+		.id		= _id,					\
+		.name		= _name,				\
+		.type		= OWL_COMPOSITE_TYPE_PASS,		\
+		.flags		= _flags,				\
+		.mux		= _mux,					\
+		.gate		= _gate,				\
+	}
+
+#define C_MUX(p, o, s, w, mf)						\
+	{								\
+		.id		= -1,					\
+		.parent_names	= p,					\
+		.num_parents	= ARRAY_SIZE(p),			\
+		.offset		= o,					\
+		.shift		= s,					\
+		.width		= w,					\
+		.mux_flags	= mf,					\
+	}
+
+/* fixed mux, only one parent */
+#define C_MUX_F(p, mf)							\
+	{								\
+		.id		= -1,					\
+		.parent_names	= p,					\
+		.num_parents	= 1,					\
+		.mux_flags = mf,					\
+	}
+
+#define C_GATE(o, b, gf)						\
+	{								\
+		.id		= -1,					\
+		.offset		= o,					\
+		.bit_idx	= b,					\
+		.gate_flags	= gf,					\
+	}
+
+#define C_NULL								\
+	{								\
+		.id		= 0,					\
+	}
+
+#define C_FIXED_FACTOR(m, d)						\
+	{								\
+		.id		= -1,					\
+		.mult		= m,					\
+		.div		= d,					\
+	}
+
+#define C_DIVIDER(o, s, w, t, df)					\
+	{								\
+		.id		= -1,					\
+		.offset		= o,					\
+		.shift		= s,					\
+		.width		= w,					\
+		.table		= t,					\
+		.div_flags	= df,					\
+	}
+
+#define C_FACTOR(o, s, w, t, df)					\
+	{								\
+		.id		= -1,					\
+		.offset		= o,					\
+		.shift		= s,					\
+		.width		= w,					\
+		.table		= t,					\
+		.div_flags	= df,					\
+	}
+
+extern void owl_clk_register_pll(struct owl_clk_provider *ctx,
+		struct owl_pll_clock *clks, int nums);
+
+extern void owl_clk_register_fixed_factor(
+		struct owl_clk_provider *ctx,
+		struct owl_fixed_factor_clock *clks,
+		int nums);
+
+extern void owl_clk_register_divider(struct owl_clk_provider *ctx,
+		struct owl_divider_clock *clks, int nums);
+
+extern void owl_clk_register_factor(struct owl_clk_provider *ctx,
+		struct owl_factor_clock *clks, int nums);
+
+extern void owl_clk_register_mux(struct owl_clk_provider *ctx,
+		struct owl_mux_clock *clks, int nums);
+
+extern void owl_clk_register_gate(struct owl_clk_provider *ctx,
+		struct owl_gate_clock *clks, int nums);
+
+extern void owl_clk_register_composite(struct owl_clk_provider *ctx,
+		struct owl_composite_clock *clks, int nums);
+
+extern struct clk_hw *owl_pll_clk_register(const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, unsigned long bfreq, u8 enable_bit,
+		u8 shift, u8 width, u8 min_mul, u8 max_mul, u8 pll_flags,
+		const struct clk_pll_table *table, spinlock_t *lock);
+
+extern struct clk_hw *owl_factor_clk_register(struct device *dev,
+		const char *name, const char *parent_name,
+		unsigned long flags, void __iomem *reg, u8 shift,
+		u8 width, u8 clk_factor_flags,
+		const struct clk_factor_table *table, spinlock_t *lock);
+
+#endif /* __OWL_CLK_H */
diff --git a/drivers/clk/actions/owl-factor.c b/drivers/clk/actions/owl-factor.c
new file mode 100644
index 0000000..18471ec
--- /dev/null
+++ b/drivers/clk/actions/owl-factor.c
@@ -0,0 +1,268 @@
+/*
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Author: David Liu <liuwei@actions-semi.com>
+ *
+ * Copyright (c) 2017 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include "owl-clk.h"
+
+#define to_owl_factor(_hw)	container_of(_hw, struct owl_factor, hw)
+#define div_mask(d)		((1 << ((d)->width)) - 1)
+
+static unsigned int _get_table_maxval(const struct clk_factor_table *table)
+{
+	unsigned int maxval = 0;
+	const struct clk_factor_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++)
+		if (clkt->val > maxval)
+			maxval = clkt->val;
+	return maxval;
+}
+
+static int _get_table_div_mul(const struct clk_factor_table *table,
+			unsigned int val, unsigned int *mul, unsigned int *div)
+{
+	const struct clk_factor_table *clkt;
+
+	for (clkt = table; clkt->div; clkt++) {
+		if (clkt->val == val) {
+			*mul = clkt->mul;
+			*div = clkt->div;
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static unsigned int _get_table_val(const struct clk_factor_table *table,
+			unsigned long rate, unsigned long parent_rate)
+{
+	const struct clk_factor_table *clkt;
+	int val = -1;
+	u64 calc_rate;
+
+	for (clkt = table; clkt->div; clkt++) {
+		calc_rate = parent_rate * clkt->mul;
+		do_div(calc_rate, clkt->div);
+
+		if ((unsigned long)calc_rate <= rate) {
+			val = clkt->val;
+			break;
+		}
+	}
+
+	if (val == -1)
+		val = _get_table_maxval(table);
+
+	return val;
+}
+
+static int clk_val_best(struct clk_hw *hw, unsigned long rate,
+			unsigned long *best_parent_rate)
+{
+	struct owl_factor *factor = to_owl_factor(hw);
+	const struct clk_factor_table *clkt = factor->table;
+	unsigned long parent_rate, try_parent_rate, best = 0, cur_rate;
+	unsigned long parent_rate_saved = *best_parent_rate;
+	int bestval = 0;
+
+	if (!rate)
+		rate = 1;
+
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		parent_rate = *best_parent_rate;
+		bestval = _get_table_val(clkt, rate, parent_rate);
+		return bestval;
+	}
+
+	for (clkt = factor->table; clkt->div; clkt++) {
+		try_parent_rate = rate * clkt->div / clkt->mul;
+
+		if (try_parent_rate == parent_rate_saved) {
+			pr_debug("%s: [%d %d %d] found try_parent_rate %ld\n",
+				__func__, clkt->val, clkt->mul, clkt->div,
+				try_parent_rate);
+			/*
+			 * It's the most ideal case if the requested rate can be
+			 * divided from parent clock without any need to change
+			 * parent rate, so return the divider immediately.
+			 */
+			*best_parent_rate = parent_rate_saved;
+			return clkt->val;
+		}
+
+		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+				try_parent_rate);
+		cur_rate = DIV_ROUND_UP(parent_rate, clkt->div) * clkt->mul;
+		if (cur_rate <= rate && cur_rate > best) {
+			bestval = clkt->val;
+			best = cur_rate;
+			*best_parent_rate = parent_rate;
+		}
+	}
+
+	if (!bestval) {
+		bestval = _get_table_maxval(clkt);
+		*best_parent_rate = clk_hw_round_rate(
+				clk_hw_get_parent(hw), 1);
+	}
+
+	pr_debug("%s: return bestval %d\n", __func__, bestval);
+
+	return bestval;
+}
+
+/**
+ * owl_factor_round_rate() - round a clock frequency
+ * @hw:	handle between common and hardware-specific interfaces
+ * @rate: desired clock frequency
+ * @prate: clock frequency of parent clock
+ */
+static long owl_factor_round_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long *parent_rate)
+{
+	struct owl_factor *factor = to_owl_factor(hw);
+	const struct clk_factor_table *clkt = factor->table;
+	unsigned int val, mul = 0, div = 1;
+
+	val = clk_val_best(hw, rate, parent_rate);
+	_get_table_div_mul(clkt, val, &mul, &div);
+
+	return *parent_rate * mul / div;
+}
+
+/**
+ * owl_factor_recalc_rate() - recalculate clock frequency
+ * @hw:	handle between common and hardware-specific interfaces
+ * @parent_rate: clock frequency of parent clock
+ */
+static unsigned long owl_factor_recalc_rate(struct clk_hw *hw,
+			unsigned long parent_rate)
+{
+	struct owl_factor *factor = to_owl_factor(hw);
+	const struct clk_factor_table *clkt = factor->table;
+	u64 rate;
+	u32 val, mul, div;
+
+	div = 0;
+	mul = 0;
+
+	val = readl(factor->reg) >> factor->shift;
+	val &= div_mask(factor);
+
+	_get_table_div_mul(clkt, val, &mul, &div);
+	if (!div) {
+		WARN(!(factor->flags & CLK_DIVIDER_ALLOW_ZERO),
+			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
+			__clk_get_name(hw->clk));
+		return parent_rate;
+	}
+
+	rate = (u64)parent_rate * mul;
+	do_div(rate, div);
+
+	return rate;
+}
+
+/**
+ * owl_factor_set_rate() - set clock frequency
+ * @hw: handle between common and hardware-specific interfaces
+ * @parent_rate: clock frequency of parent clock
+ */
+static int owl_factor_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct owl_factor *factor = to_owl_factor(hw);
+	unsigned long flags = 0;
+	u32 val, v;
+
+	val = _get_table_val(factor->table, rate, parent_rate);
+
+	pr_debug("%s: get_table_val %d\n", __func__, val);
+
+	if (val > div_mask(factor))
+		val = div_mask(factor);
+
+	if (factor->lock)
+		spin_lock_irqsave(factor->lock, flags);
+
+	v = readl(factor->reg);
+	v &= ~(div_mask(factor) << factor->shift);
+	v |= val << factor->shift;
+	writel(v, factor->reg);
+
+	if (factor->lock)
+		spin_unlock_irqrestore(factor->lock, flags);
+
+	return 0;
+}
+
+const struct clk_ops owl_factor_ops = {
+	.round_rate	= owl_factor_round_rate,
+	.recalc_rate	= owl_factor_recalc_rate,
+	.set_rate	= owl_factor_set_rate,
+};
+
+/**
+ * owl_factor_clk_register() - register pll with the clock framework
+ * @name: pll name
+ * @parent: parent clock name
+ * @reg: pointer to pll control register
+ * @pll_status: pointer to pll status register
+ * @lock_index: bit index to this pll's lock status bit in pll_status
+ * @lock: register lock
+ */
+struct clk_hw *owl_factor_clk_register(struct device *dev, const char *name,
+		const char *parent_name, unsigned long flags,
+		void __iomem *reg, u8 shift, u8 width,
+		u8 clk_factor_flags, const struct clk_factor_table *table,
+		spinlock_t *lock)
+
+{
+	struct owl_factor *factor;
+	struct clk_init_data initd;
+	struct clk_hw *clk_hw;
+	int ret;
+
+	factor = kzalloc(sizeof(*factor), GFP_KERNEL);
+	if (!factor)
+		return ERR_PTR(-ENOMEM);
+
+	initd.name = name;
+	initd.ops = &owl_factor_ops;
+	initd.flags = flags;
+	initd.parent_names = (parent_name ? &parent_name : NULL);
+	initd.num_parents = (parent_name ? 1 : 0);
+
+	factor->reg = reg;
+	factor->shift = shift;
+	factor->width = width;
+	factor->flags = clk_factor_flags;
+	factor->lock = lock;
+	factor->hw.init = &initd;
+	factor->table = table;
+
+	clk_hw = &factor->hw;
+	ret = clk_hw_register(dev, clk_hw);
+	if (ret) {
+		kfree(factor);
+		clk_hw = ERR_PTR(ret);
+	}
+
+	return clk_hw;
+}
diff --git a/drivers/clk/actions/owl-pll.c b/drivers/clk/actions/owl-pll.c
new file mode 100644
index 0000000..942b528
--- /dev/null
+++ b/drivers/clk/actions/owl-pll.c
@@ -0,0 +1,344 @@
+/*
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Author: David Liu <liuwei@actions-semi.com>
+ *
+ * Copyright (c) 2017 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include "owl-clk.h"
+
+/**
+ * struct owl_pll
+ * @hw: handle between common and hardware-specific interfaces
+ * @reg: pll control register
+ * @lock: register lock
+ * @bfreq: base frequency of the pll. pll frequency = bfreq * mul
+ * @enable_bit: enable bit for pll
+ * @shift: shift to the multiplier bit field
+ * @width: width of the multiplier bit field
+ * @min_mul: minimum multiple for the pll
+ * @max_mul: maximum multiple for the pll
+ * @pll_flags: flags for the pll
+ * @table: pll table
+ */
+struct owl_pll {
+	struct clk_hw		hw;
+	void __iomem		*reg;
+	spinlock_t		*lock;
+	unsigned long		bfreq;
+	u8			enable_bit;
+	u8			shift;
+	u8			width;
+	u8			min_mul;
+	u8			max_mul;
+	u8			pll_flags;
+	const struct clk_pll_table *table;
+};
+
+#define to_owl_pll(_hw)		container_of(_hw, struct owl_pll, hw)
+#define mul_mask(m)		((1 << ((m)->width)) - 1)
+#define PLL_STABILITY_WAIT_US	(50)
+
+/**
+ * owl_pll_calculate_mul() - calculate multiple for specific rate
+ * @pll: owl pll
+ * @rate: desired clock frequency
+ */
+static u32 owl_pll_calculate_mul(struct owl_pll *pll, unsigned long rate)
+{
+	u32 mul;
+
+	mul = DIV_ROUND_CLOSEST(rate, pll->bfreq);
+	if (mul < pll->min_mul)
+		mul = pll->min_mul;
+	else if (mul > pll->max_mul)
+		mul = pll->max_mul;
+
+	return mul &= mul_mask(pll);
+}
+
+static unsigned int _get_table_rate(const struct clk_pll_table *table,
+		unsigned int val)
+{
+	const struct clk_pll_table *clkt;
+
+	for (clkt = table; clkt->rate; clkt++)
+		if (clkt->val == val)
+			return clkt->rate;
+
+	return 0;
+}
+
+static const struct clk_pll_table *_get_pll_table(
+		const struct clk_pll_table *table, unsigned long rate)
+{
+	const struct clk_pll_table *clkt;
+
+	for (clkt = table; clkt->rate; clkt++) {
+		if (clkt->rate == rate) {
+			table = clkt;
+			break;
+		} else if (clkt->rate < rate)
+			table = clkt;
+	}
+
+	return table;
+}
+
+/**
+ * owl_pll_round_rate() - round a clock frequency
+ * @hw: handle between common and hardware-specific interfaces
+ * @rate: desired clock frequency
+ * @parent_rate: clock frequency of parent clock
+ */
+static long owl_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *parent_rate)
+{
+	struct owl_pll *pll = to_owl_pll(hw);
+	const struct clk_pll_table *clkt;
+	u32 mul;
+
+	if (pll->table) {
+		clkt = _get_pll_table(pll->table, rate);
+		return clkt->rate;
+	}
+
+	/* fixed frequency */
+	if (pll->width == 0)
+		return pll->bfreq;
+
+	mul = owl_pll_calculate_mul(pll, rate);
+
+	return pll->bfreq * mul;
+}
+
+/**
+ * owl_pll_recalc_rate() - recalculate pll clock frequency
+ * @hw:	handle between common and hardware-specific interfaces
+ * @parent_rate: clock frequency of parent clock
+ */
+static unsigned long owl_pll_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct owl_pll *pll = to_owl_pll(hw);
+	unsigned long rate;
+	u32 val, mul;
+
+	if (pll->table) {
+		val = readl(pll->reg) >> pll->shift;
+		val &= mul_mask(pll);
+
+		rate = _get_table_rate(pll->table, val);
+
+		return rate;
+	}
+
+	/* fixed frequency */
+	if (pll->width == 0)
+		return pll->bfreq;
+
+	mul = (readl(pll->reg) >> pll->shift) & mul_mask(pll);
+
+	return pll->bfreq * mul;
+}
+
+/**
+ * owl_pll_is_enabled - check if pll is enabled
+ * @hw: handle between common and hardware-specific interfaces
+ *
+ * Not sure this is a good idea, but since disabled means bypassed for
+ * this clock implementation we say we are always enabled.
+ */
+static int owl_pll_is_enabled(struct clk_hw *hw)
+{
+	struct owl_pll *pll = to_owl_pll(hw);
+	unsigned long flags = 0;
+	u32 v;
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	v = readl(pll->reg);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+
+	return !!(v & BIT(pll->enable_bit));
+}
+
+/**
+ * owl_pll_enable - enable pll clock
+ * @hw:	handle between common and hardware-specific interfaces
+ */
+static int owl_pll_enable(struct clk_hw *hw)
+{
+	struct owl_pll *pll = to_owl_pll(hw);
+	unsigned long flags = 0;
+	u32 v;
+
+	/* exit if pll is enabled */
+	if (owl_pll_is_enabled(hw))
+		return 0;
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	v = readl(pll->reg);
+	v |= BIT(pll->enable_bit);
+	writel(v, pll->reg);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+
+	udelay(PLL_STABILITY_WAIT_US);
+
+	return 0;
+}
+
+/**
+ * owl_pll_disable - disable pll clock
+ * @hw:	handle between common and hardware-specific interfaces
+ */
+static void owl_pll_disable(struct clk_hw *hw)
+{
+	struct owl_pll *pll = to_owl_pll(hw);
+	unsigned long flags = 0;
+	u32 v;
+
+	/* exit if pll is disabled */
+	if (!owl_pll_is_enabled(hw))
+		return;
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	v = readl(pll->reg);
+	v &= ~BIT(pll->enable_bit);
+	writel(v, pll->reg);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+}
+
+/**
+ * owl_pll_set_rate - set pll rate
+ * @hw: handle between common and hardware-specific interfaces
+ * @rate: desired clock frequency
+ * @parent_rate: clock frequency of parent
+ */
+static int owl_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct owl_pll *pll = to_owl_pll(hw);
+	const struct clk_pll_table *clkt;
+	unsigned long flags = 0;
+	u32 val, v;
+
+	pr_debug("%s: rate %ld, parent_rate %ld, before set rate: reg 0x%x\n",
+		__func__, rate, parent_rate, readl(pll->reg));
+
+	/* fixed frequency */
+	if (pll->width == 0)
+		return 0;
+
+	if (pll->table) {
+		clkt = _get_pll_table(pll->table, rate);
+		val = clkt->val;
+	} else {
+		val = owl_pll_calculate_mul(pll, rate);
+	}
+
+	if (pll->lock)
+		spin_lock_irqsave(pll->lock, flags);
+
+	v = readl(pll->reg);
+	v &= ~mul_mask(pll);
+	v |= val << pll->shift;
+	writel(v, pll->reg);
+
+	udelay(PLL_STABILITY_WAIT_US);
+
+	if (pll->lock)
+		spin_unlock_irqrestore(pll->lock, flags);
+
+	pr_debug("%s: after set rate: reg 0x%x\n", __func__,
+		readl(pll->reg));
+
+	return 0;
+}
+
+static const struct clk_ops owl_pll_ops = {
+	.enable = owl_pll_enable,
+	.disable = owl_pll_disable,
+	.is_enabled = owl_pll_is_enabled,
+	.round_rate = owl_pll_round_rate,
+	.recalc_rate = owl_pll_recalc_rate,
+	.set_rate = owl_pll_set_rate,
+};
+
+/**
+ * owl_pll_clk_register() - register pll with the clock framework
+ * @name: pll name
+ * @parent: parent clock name
+ * @reg: pointer to pll control register
+ * @pll_status: pointer to pll status register
+ * @lock_index: bit index to this pll's lock status bit in @pll_status
+ * @lock: register lock
+ */
+struct clk_hw *owl_pll_clk_register(const char *name, const char *parent_name,
+		unsigned long flags, void __iomem *reg, unsigned long bfreq,
+		u8 enable_bit, u8 shift, u8 width, u8 min_mul, u8 max_mul,
+		u8 pll_flags, const struct clk_pll_table *table,
+		spinlock_t *lock)
+{
+	struct owl_pll *pll;
+	struct clk_hw *clk_hw;
+	struct clk_init_data initd;
+	int ret;
+
+	pll = kmalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	initd.name = name;
+	initd.parent_names = (parent_name ? &parent_name : NULL);
+	initd.num_parents = (parent_name ? 1 : 0);
+	initd.ops = &owl_pll_ops;
+	initd.flags = flags;
+
+	pll->hw.init = &initd;
+	pll->bfreq = bfreq;
+	pll->enable_bit = enable_bit;
+	pll->shift = shift;
+	pll->width = width;
+	pll->min_mul = min_mul;
+	pll->max_mul = max_mul;
+	pll->pll_flags = pll_flags;
+	pll->table = table;
+	pll->reg = reg;
+	pll->lock = lock;
+
+	clk_hw = &pll->hw;
+	ret = clk_hw_register(NULL, clk_hw);
+	if (ret) {
+		kfree(pll);
+		clk_hw = ERR_PTR(ret);
+	}
+
+	return clk_hw;
+}
diff --git a/drivers/clk/actions/owl-s900.c b/drivers/clk/actions/owl-s900.c
new file mode 100644
index 0000000..51e297f
--- /dev/null
+++ b/drivers/clk/actions/owl-s900.c
@@ -0,0 +1,585 @@
+/*
+ * Copyright (c) 2014 Actions Semi Inc.
+ * Author: David Liu <liuwei@actions-semi.com>
+ *
+ * Copyright (c) 2017 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/actions,s900-cmu.h>
+#include "owl-clk.h"
+
+#define CMU_COREPLL		(0x0000)
+#define CMU_DEVPLL		(0x0004)
+#define CMU_DDRPLL		(0x0008)
+#define CMU_NANDPLL		(0x000C)
+#define CMU_DISPLAYPLL		(0x0010)
+#define CMU_AUDIOPLL		(0x0014)
+#define CMU_TVOUTPLL		(0x0018)
+#define CMU_BUSCLK		(0x001C)
+#define CMU_SENSORCLK		(0x0020)
+#define CMU_LCDCLK		(0x0024)
+#define CMU_DSICLK		(0x0028)
+#define CMU_CSICLK		(0x002C)
+#define CMU_DECLK		(0x0030)
+#define CMU_BISPCLK		(0x0034)
+#define CMU_IMXCLK		(0x0038)
+#define CMU_HDECLK		(0x003C)
+#define CMU_VDECLK		(0x0040)
+#define CMU_VCECLK		(0x0044)
+#define CMU_NANDCCLK		(0x004C)
+#define CMU_SD0CLK		(0x0050)
+#define CMU_SD1CLK		(0x0054)
+#define CMU_SD2CLK		(0x0058)
+#define CMU_UART0CLK		(0x005C)
+#define CMU_UART1CLK		(0x0060)
+#define CMU_UART2CLK		(0x0064)
+#define CMU_PWM0CLK		(0x0070)
+#define CMU_PWM1CLK		(0x0074)
+#define CMU_PWM2CLK		(0x0078)
+#define CMU_PWM3CLK		(0x007C)
+#define CMU_USBPLL		(0x0080)
+#define CMU_ASSISTPLL		(0x0084)
+#define CMU_EDPCLK		(0x0088)
+#define CMU_GPU3DCLK		(0x0090)
+#define CMU_CORECTL		(0x009C)
+#define CMU_DEVCLKEN0		(0x00A0)
+#define CMU_DEVCLKEN1		(0x00A4)
+#define CMU_DEVRST0		(0x00A8)
+#define CMU_DEVRST1		(0x00AC)
+#define CMU_UART3CLK		(0x00B0)
+#define CMU_UART4CLK		(0x00B4)
+#define CMU_UART5CLK		(0x00B8)
+#define CMU_UART6CLK		(0x00BC)
+#define CMU_TLSCLK		(0x00C0)
+#define CMU_SD3CLK		(0x00C4)
+#define CMU_PWM4CLK		(0x00C8)
+#define CMU_PWM5CLK		(0x00CC)
+
+static struct clk_pll_table clk_audio_pll_table[] = {
+	{0, 45158400}, {1, 49152000},
+	{0, 0},
+};
+
+static struct clk_pll_table clk_edp_pll_table[] = {
+	{0, 810000000}, {1, 1350000000}, {2, 2700000000},
+	{0, 0},
+};
+
+/* pll clocks */
+static struct owl_pll_clock s900_pll_clks[] = {
+	{ CLK_CORE_PLL, "core_pll", NULL, CLK_IGNORE_UNUSED, CMU_COREPLL, 24000000, 9, 0, 8,  5, 107, 0, NULL, },
+	{ CLK_DEV_PLL, "dev_pll",  NULL, CLK_IGNORE_UNUSED, CMU_DEVPLL, 6000000, 8, 0, 8, 20, 180, 0, NULL, },
+	{ CLK_DDR_PLL, "ddr_pll",  NULL, CLK_IGNORE_UNUSED, CMU_DDRPLL, 24000000, 8, 0, 8,  5,  45, 0, NULL, },
+	{ CLK_NAND_PLL, "nand_pll", NULL, CLK_IGNORE_UNUSED, CMU_NANDPLL, 6000000, 8, 0, 8,  4, 100, 0, NULL, },
+	{ CLK_DISPLAY_PLL, "display_pll", NULL, CLK_IGNORE_UNUSED, 0, 6000000, 8, 0, 8, 20, 180, 0, NULL, },
+	{ CLK_ASSIST_PLL, "assist_pll", NULL, CLK_IGNORE_UNUSED, 0, 500000000, 0, 0, 0, 0, 0, CLK_OWL_PLL_FIXED_FREQ, NULL, },
+	{ CLK_AUDIO_PLL, "audio_pll", NULL, CLK_IGNORE_UNUSED, 0, 0, 4, 0, 1, 0, 0, 0, clk_audio_pll_table, },
+
+	{ CLK_EDP_PLL, "edp_pll", "24M_edp", CLK_IGNORE_UNUSED, 0, 0, 9, 0, 2, 0, 0, 0, clk_edp_pll_table, },
+};
+
+static const char *cpu_clk_mux_p[] = { "losc", "hosc", "core_pll", };
+static const char *dev_clk_p[] = { "hosc", "dev_pll", };
+static const char *noc_clk_mux_p[] = { "dev_clk", "assist_pll", };
+static const char *dmm_clk_mux_p[] = { "dev_clk", "nand_pll", "assist_pll", "ddr_clk_src", };
+
+static const char *bisp_clk_mux_p[] = { "assist_pll", "dev_clk", };
+static const char *csi_clk_mux_p[] = { "display_pll", "dev_clk", };
+static const char *de_clk_mux_p[] = { "assist_pll", "dev_clk", };
+static const char *eth_mac_clk_mux_p[] = { "assist_pll", };
+static const char *gpu_clk_mux_p[] = { "dev_clk", "display_pll", "", "ddr_clk_src", };
+static const char *hde_clk_mux_p[] = { "dev_clk", "display_pll", "", "ddr_clk_src", };
+static const char *i2c_clk_mux_p[] = { "assist_pll", };
+static const char *imx_clk_mux_p[] = { "assist_pll", "dev_clk", };
+static const char *lcd_clk_mux_p[] = { "display_pll", "nand_pll", };
+static const char *nand_clk_mux_p[] = { "dev_clk", "nand_pll", };
+static const char *pwm_clk_mux_p[] = { "hosc" };
+static const char *sd_clk_mux_p[] = { "dev_clk", "nand_pll", };
+static const char *sensor_clk_mux_p[] = { "hosc", "bisp", };
+static const char *speed_sensor_clk_mux_p[] = { "hosc", };
+static const char *spi_clk_mux_p[] = { "ahb_clk", };
+static const char *thermal_sensor_clk_mux_p[] = { "hosc", };
+static const char *uart_clk_mux_p[] = { "hosc", "dev_pll", };
+static const char *vce_clk_mux_p[] = { "dev_clk", "display_pll", "assist_pll", "ddr_clk_src", };
+static const char *i2s_clk_mux_p[] = { "audio_pll", };
+
+static const char *edp_clk_mux_p[] = { "assist_pll", "display_pll", };
+
+/* mux clocks */
+static struct owl_mux_clock s900_mux_clks[] = {
+	{ CLK_CPU,  "cpu_clk", cpu_clk_mux_p, ARRAY_SIZE(cpu_clk_mux_p), CLK_SET_RATE_PARENT, CMU_BUSCLK, 0, 2, 0, "cpu_clk", },
+	{ CLK_DEV,  "dev_clk", dev_clk_p, ARRAY_SIZE(dev_clk_p), CLK_SET_RATE_PARENT, CMU_DEVPLL, 12, 1, 0, "dev_clk", },
+	{ CLK_NOC_CLK_MUX,  "noc_clk_mux", noc_clk_mux_p, ARRAY_SIZE(noc_clk_mux_p), CLK_SET_RATE_PARENT, CMU_BUSCLK, 7, 1, 0, },
+};
+
+static struct clk_div_table nand_div_table[] = {
+	{0, 1},   {1, 2},   {2, 4},   {3, 6},
+	{4, 8},   {5, 10},  {6, 12},  {7, 14},
+	{8, 16},  {9, 18},  {10, 20}, {11, 22},
+	{12, 24}, {13, 26}, {14, 28}, {15, 30},
+	{0, 0},
+};
+
+static struct clk_factor_table sd_factor_table[] = {
+	/* bit0 ~ 4 */
+	{0, 1, 1}, {1, 1, 2}, {2, 1, 3}, {3, 1, 4},
+	{4, 1, 5}, {5, 1, 6}, {6, 1, 7}, {7, 1, 8},
+	{8, 1, 9}, {9, 1, 10}, {10, 1, 11}, {11, 1, 12},
+	{12, 1, 13}, {13, 1, 14}, {14, 1, 15}, {15, 1, 16},
+	{16, 1, 17}, {17, 1, 18}, {18, 1, 19}, {19, 1, 20},
+	{20, 1, 21}, {21, 1, 22}, {22, 1, 23}, {23, 1, 24},
+	{24, 1, 25}, {25, 1, 26}, {26, 1, 27}, {27, 1, 28},
+	{28, 1, 29}, {29, 1, 30}, {30, 1, 31}, {31, 1, 32},
+
+	/* bit8: /128 */
+	{256, 1, 1 * 128}, {257, 1, 2 * 128}, {258, 1, 3 * 128}, {259, 1, 4 * 128},
+	{260, 1, 5 * 128}, {261, 1, 6 * 128}, {262, 1, 7 * 128}, {263, 1, 8 * 128},
+	{264, 1, 9 * 128}, {265, 1, 10 * 128}, {266, 1, 11 * 128}, {267, 1, 12 * 128},
+	{268, 1, 13 * 128}, {269, 1, 14 * 128}, {270, 1, 15 * 128}, {271, 1, 16 * 128},
+	{272, 1, 17 * 128}, {273, 1, 18 * 128}, {274, 1, 19 * 128}, {275, 1, 20 * 128},
+	{276, 1, 21 * 128}, {277, 1, 22 * 128}, {278, 1, 23 * 128}, {279, 1, 24 * 128},
+	{280, 1, 25 * 128}, {281, 1, 26 * 128}, {282, 1, 27 * 128}, {283, 1, 28 * 128},
+	{284, 1, 29 * 128}, {285, 1, 30 * 128}, {286, 1, 31 * 128}, {287, 1, 32 * 128},
+
+	{0, 0},
+};
+
+static struct clk_div_table apb_div_table[] = {
+	{1, 2},   {2, 3},   {3, 4},
+	{0, 0},
+};
+
+static struct clk_div_table eth_mac_div_table[] = {
+	{0, 2},   {1, 4},
+	{0, 0},
+};
+
+static struct clk_div_table rmii_ref_div_table[] = {
+	{0, 4},   {1, 10},
+	{0, 0},
+};
+
+static struct clk_div_table usb3_mac_div_table[] = {
+	{1, 2},   {2, 3},   {3, 4},
+	{0, 8},
+};
+
+static struct clk_div_table i2s_div_table[] = {
+	{0, 1},   {1, 2},   {2, 3},   {3, 4},
+	{4, 6},   {5, 8},   {6, 12},  {7, 16},
+	{8, 24},
+	{0, 0},
+};
+
+static struct clk_div_table hdmia_div_table[] = {
+	{0, 1},   {1, 2},   {2, 3},   {3, 4},
+	{4, 6},   {5, 8},   {6, 12},  {7, 16},
+	{8, 24},
+	{0, 0},
+};
+
+
+/* divider clocks */
+static struct owl_divider_clock s900_div_clks[] = {
+	{ CLK_NOC_CLK_DIV, "noc_clk_div", "noc_clk", 0, CMU_BUSCLK, 19, 1, 0, NULL, },
+	{ CLK_AHB, "ahb_clk", "noc_clk_div", 0, CMU_BUSCLK, 4, 1, 0, NULL, "ahb_clk", },
+	{ CLK_APB, "apb_clk", "ahb_clk", 0, CMU_BUSCLK, 8, 2, 0, apb_div_table, "apb_clk", },
+	{ CLK_USB3_MAC, "usb3_mac", "assist_pll", 0, CMU_ASSISTPLL, 12, 2, 0, usb3_mac_div_table, "usb3_mac", },
+	{ CLK_RMII_REF, "rmii_ref", "assist_pll", 0, CMU_ASSISTPLL, 8, 1, 0, rmii_ref_div_table, "rmii_ref", },
+};
+
+static struct clk_factor_table dmm_factor_table[] = {
+	{0, 1, 1}, {1, 2, 3}, {2, 1, 2}, {3, 1, 3},
+	{4, 1, 4},
+	{0, 0, 0},
+};
+
+static struct clk_factor_table noc_factor_table[] = {
+	{0, 1, 1},   {1, 2, 3},   {2, 1, 2}, {3, 1, 3},  {4, 1, 4},
+	{0, 0, 0},
+};
+
+static struct clk_factor_table bisp_factor_table[] = {
+	{0, 1, 1}, {1, 2, 3}, {2, 1, 2}, {3, 2, 5},
+	{4, 1, 3}, {5, 1, 4}, {6, 1, 6}, {7, 1, 8},
+	{0, 0, 0},
+};
+
+/* divider clocks */
+static struct owl_factor_clock s900_factor_clks[] = {
+	{ CLK_NOC, "noc_clk", "noc_clk_mux", 0, CMU_BUSCLK, 16, 3, 0, noc_factor_table, "noc_clk", },
+	{ CLK_DE1, "de_clk1", "de_clk", 0, CMU_DECLK, 0, 3, 0, bisp_factor_table, "de_clk1", },
+	{ CLK_DE2, "de_clk2", "de_clk", 0, CMU_DECLK, 4, 3, 0, bisp_factor_table, "de_clk2", },
+	{ CLK_DE3, "de_clk3", "de_clk", 0, CMU_DECLK, 8, 3, 0, bisp_factor_table, "de_clk3", },
+};
+
+/* gate clocks */
+static struct owl_gate_clock s900_gate_clks[] = {
+	{ CLK_GPIO,  "gpio", "apb_clk", 0, CMU_DEVCLKEN0, 18, 0, "gpio", },
+	{ CLK_GPU,   "gpu", NULL, 0, CMU_DEVCLKEN0, 30, 0, "gpu", },
+	{ CLK_DMAC,  "dmac", "noc_clk_div", 0, CMU_DEVCLKEN0, 1, 0, "dmac", },
+	{ CLK_TIMER,  "timer", "hosc", 0, CMU_DEVCLKEN1, 27, 0, "timer", },
+	{ CLK_DSI,  "dsi_clk", NULL, 0, CMU_DEVCLKEN0, 12, 0, "dsi", },
+
+	{ CLK_DDR0,  "ddr0_clk", "ddr_pll", CLK_IGNORE_UNUSED, CMU_DEVCLKEN0, 31, 0, "ddr0", },
+	{ CLK_DDR1,  "ddr1_clk", "ddr_pll", CLK_IGNORE_UNUSED, CMU_DEVCLKEN0, 29, 0, "ddr1", },
+
+	{ CLK_USB3_480MPLL0,	"usb3_480mpll0",	NULL, 0, CMU_USBPLL, 3, 0, "usb3_480mpll0", },
+	{ CLK_USB3_480MPHY0,	"usb3_480mphy0",	NULL, 0, CMU_USBPLL, 2, 0, "usb3_480mphy0", },
+	{ CLK_USB3_5GPHY,	"usb3_5gphy",		NULL, 0, CMU_USBPLL, 1, 0, "usb3_5gphy", },
+	{ CLK_USB3_CCE,		"usb3_cce",		NULL, 0, CMU_USBPLL, 0, 0, "usb3_cce", },
+
+	{ CLK_24M_EDP,		"24M_edp",		"diff24M", 0, CMU_EDPCLK, 8, 0, "24M_edp", },
+	{ CLK_EDP_LINK,		"edp_link",		"edp_pll", 0, CMU_DEVCLKEN0, 10, 0, "edp_link", },
+
+	{ CLK_USB2H0_PLLEN,	"usbh0_pllen",	NULL, 0, CMU_USBPLL, 12, 0, "usbh0_pllen", },
+	{ CLK_USB2H0_PHY,	"usbh0_phy",	NULL, 0, CMU_USBPLL, 10, 0, "usbh0_phy", },
+	{ CLK_USB2H0_CCE,	"usbh0_cce",		NULL, 0, CMU_USBPLL, 8, 0, "usbh0_cce", },
+
+	{ CLK_USB2H1_PLLEN,	"usbh1_pllen",	NULL, 0, CMU_USBPLL, 13, 0, "usbh1_pllen", },
+	{ CLK_USB2H1_PHY,	"usbh1_phy",	NULL, 0, CMU_USBPLL, 11, 0, "usbh1_phy", },
+	{ CLK_USB2H1_CCE,	"usbh1_cce",		NULL, 0, CMU_USBPLL, 9, 0, "usbh1_cce", },
+};
+
+static struct owl_composite_clock s900_composite_clks[] = {
+	COMP_FACTOR_CLK(CLK_BISP, "bisp", 0,
+			C_MUX(bisp_clk_mux_p, CMU_BISPCLK, 4, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 14, 0),
+			C_FACTOR(CMU_BISPCLK, 0, 3, bisp_factor_table, 0)),
+
+	COMP_DIV_CLK(CLK_CSI0, "csi0", 0,
+			C_MUX(csi_clk_mux_p, CMU_CSICLK, 4, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 13, 0),
+			C_DIVIDER(CMU_CSICLK, 0, 4, NULL, 0)),
+
+	COMP_DIV_CLK(CLK_CSI1, "csi1", 0,
+			C_MUX(csi_clk_mux_p, CMU_CSICLK, 20, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 15, 0),
+			C_DIVIDER(CMU_CSICLK, 16, 4, NULL, 0)),
+
+	COMP_PASS_CLK(CLK_DE, "de_clk", 0,
+			C_MUX(de_clk_mux_p, CMU_DECLK, 12, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 8, 0)),
+
+	COMP_FACTOR_CLK(CLK_DMM, "dmm", CLK_IGNORE_UNUSED,
+			C_MUX(dmm_clk_mux_p, CMU_BUSCLK, 10, 2, 0),
+			C_GATE(CMU_DEVCLKEN0, 19, 0),
+			C_FACTOR(CMU_BUSCLK, 12, 3, dmm_factor_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_EDP, "edp_clk", 0,
+			C_MUX(edp_clk_mux_p, CMU_EDPCLK, 19, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 10, 0),
+			C_FACTOR(CMU_EDPCLK, 16, 3, bisp_factor_table, 0)),
+
+	COMP_DIV_CLK(CLK_ETH_MAC, "eth_mac", 0,
+			C_MUX_F(eth_mac_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 22, 0),
+			C_DIVIDER(CMU_ASSISTPLL, 10, 1, eth_mac_div_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_GPU_CORE, "gpu_core", 0,
+			C_MUX(gpu_clk_mux_p, CMU_GPU3DCLK, 4, 2, 0),
+			C_GATE(CMU_GPU3DCLK, 15, 0),
+			C_FACTOR(CMU_GPU3DCLK, 0, 3, bisp_factor_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_GPU_MEM, "gpu_mem", 0,
+			C_MUX(gpu_clk_mux_p, CMU_GPU3DCLK, 20, 2, 0),
+			C_GATE(CMU_GPU3DCLK, 14, 0),
+			C_FACTOR(CMU_GPU3DCLK, 16, 3, bisp_factor_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_GPU_SYS, "gpu_sys", 0,
+			C_MUX(gpu_clk_mux_p, CMU_GPU3DCLK, 28, 2, 0),
+			C_GATE(CMU_GPU3DCLK, 13, 0),
+			C_FACTOR(CMU_GPU3DCLK, 24, 3, bisp_factor_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_HDE, "hde", 0,
+			C_MUX(hde_clk_mux_p, CMU_HDECLK, 4, 2, 0),
+			C_GATE(CMU_DEVCLKEN0, 27, 0),
+			C_FACTOR(CMU_HDECLK, 0, 3, bisp_factor_table, 0)),
+
+	COMP_DIV_CLK(CLK_HDMI_AUDIO, "hdmia", 0,
+			C_MUX(i2s_clk_mux_p, CMU_AUDIOPLL, 24, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 22, 0),
+			C_DIVIDER(CMU_AUDIOPLL, 24, 4, hdmia_div_table, 0)),
+
+	COMP_FIXED_FACTOR_CLK(CLK_I2C0, "i2c0", 0,
+			C_MUX_F(i2c_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 14, 0),
+			C_FIXED_FACTOR(1, 5)),
+
+	COMP_FIXED_FACTOR_CLK(CLK_I2C1, "i2c1", 0,
+			C_MUX_F(i2c_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 15, 0),
+			C_FIXED_FACTOR(1, 5)),
+
+	COMP_FIXED_FACTOR_CLK(CLK_I2C2, "i2c2", 0,
+			C_MUX_F(i2c_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 30, 0),
+			C_FIXED_FACTOR(1, 5)),
+
+	COMP_FIXED_FACTOR_CLK(CLK_I2C3, "i2c3", 0,
+			C_MUX_F(i2c_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 31, 0),
+			C_FIXED_FACTOR(1, 5)),
+
+	COMP_FIXED_FACTOR_CLK(CLK_I2C4, "i2c4", 0,
+			C_MUX_F(i2c_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN0, 17, 0),
+			C_FIXED_FACTOR(1, 5)),
+
+	COMP_FIXED_FACTOR_CLK(CLK_I2C5, "i2c5", 0,
+			C_MUX_F(i2c_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 1, 0),
+			C_FIXED_FACTOR(1, 5)),
+
+	COMP_DIV_CLK(CLK_I2SRX, "i2srx", 0,
+			C_MUX(i2s_clk_mux_p, CMU_AUDIOPLL, 24, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 21, 0),
+			C_DIVIDER(CMU_AUDIOPLL, 20, 4, i2s_div_table, 0)),
+
+	COMP_DIV_CLK(CLK_I2STX, "i2stx", 0,
+			C_MUX(i2s_clk_mux_p, CMU_AUDIOPLL, 24, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 20, 0),
+			C_DIVIDER(CMU_AUDIOPLL, 16, 4, i2s_div_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_IMX, "imx", 0,
+			C_MUX(imx_clk_mux_p, CMU_IMXCLK, 4, 1, 0),
+			C_GATE(CMU_DEVCLKEN1, 17, 0),
+			C_FACTOR(CMU_IMXCLK, 0, 3, bisp_factor_table, 0)),
+
+	COMP_DIV_CLK(CLK_LCD, "lcd", 0,
+			C_MUX(lcd_clk_mux_p, CMU_LCDCLK, 12, 2, 0),
+			C_GATE(CMU_DEVCLKEN0, 9, 0),
+			C_DIVIDER(CMU_LCDCLK, 0, 5, NULL, 0)),
+
+	COMP_DIV_CLK(CLK_NAND0, "nand0", CLK_SET_RATE_PARENT,
+			C_MUX(nand_clk_mux_p, CMU_NANDCCLK, 8, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 4, 0),
+			C_DIVIDER(CMU_NANDCCLK, 0, 4, nand_div_table, 0)),
+
+	COMP_DIV_CLK(CLK_NAND1, "nand1", CLK_SET_RATE_PARENT,
+			C_MUX(nand_clk_mux_p, CMU_NANDCCLK, 24, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 11, 0),
+			C_DIVIDER(CMU_NANDCCLK, 16, 4, nand_div_table, 0)),
+
+	COMP_DIV_CLK(CLK_PWM0, "pwm0", 0,
+			C_MUX_F(pwm_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 23, 0),
+			C_DIVIDER(CMU_PWM0CLK, 0, 6, NULL, 0)),
+
+	COMP_DIV_CLK(CLK_PWM0, "pwm1", 0,
+			C_MUX_F(pwm_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 24, 0),
+			C_DIVIDER(CMU_PWM1CLK, 0, 6, NULL, 0)),
+	/*
+	 * pwm2 may be for backlight, do not gate it
+	 * even it is "unused", because it may be
+	 * enabled at boot stage, and in kernel, driver
+	 * has no effective method to know the real status,
+	 * so, the best way is keeping it as what it was.
+	 */
+	COMP_DIV_CLK(CLK_PWM0, "pwm2", CLK_IGNORE_UNUSED,
+			C_MUX_F(pwm_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 25, 0),
+			C_DIVIDER(CMU_PWM2CLK, 0, 6, NULL, 0)),
+
+	COMP_DIV_CLK(CLK_PWM0, "pwm3", 0,
+			C_MUX_F(pwm_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 26, 0),
+			C_DIVIDER(CMU_PWM3CLK, 0, 6, NULL, 0)),
+
+	COMP_DIV_CLK(CLK_PWM0, "pwm4", 0,
+			C_MUX_F(pwm_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 4, 0),
+			C_DIVIDER(CMU_PWM4CLK, 0, 6, NULL, 0)),
+
+	COMP_DIV_CLK(CLK_PWM5, "pwm5", 0,
+			C_MUX_F(pwm_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 5, 0),
+			C_DIVIDER(CMU_PWM5CLK, 0, 6, NULL, 0)),
+
+	COMP_FACTOR_CLK(CLK_SD0, "sd0", 0,
+			C_MUX(sd_clk_mux_p, CMU_SD0CLK, 9, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 5, 0),
+			C_FACTOR(CMU_SD0CLK, 0, 9, sd_factor_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_SD1, "sd1", 0,
+			C_MUX(sd_clk_mux_p, CMU_SD1CLK, 9, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 6, 0),
+			C_FACTOR(CMU_SD1CLK, 0, 9, sd_factor_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_SD2, "sd2", 0,
+			C_MUX(sd_clk_mux_p, CMU_SD2CLK, 9, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 7, 0),
+			C_FACTOR(CMU_SD2CLK, 0, 9, sd_factor_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_SD3, "sd3", 0,
+			C_MUX(sd_clk_mux_p, CMU_SD3CLK, 9, 1, 0),
+			C_GATE(CMU_DEVCLKEN0, 16, 0),
+			C_FACTOR(CMU_SD3CLK, 0, 9, sd_factor_table, 0)),
+
+	COMP_DIV_CLK(CLK_SENSOR, "sensor", 0,
+			C_MUX(sensor_clk_mux_p, CMU_SENSORCLK, 4, 1, 0),
+			C_NULL,
+			C_DIVIDER(CMU_SENSORCLK, 0, 4, NULL, 0)),
+
+	COMP_DIV_CLK(CLK_SPEED_SENSOR, "speed_sensor", 0,
+			C_MUX_F(speed_sensor_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 0, 0),
+			C_DIVIDER(CMU_TLSCLK, 0, 4, NULL, CLK_DIVIDER_POWER_OF_TWO)),
+
+	COMP_PASS_CLK(CLK_SPI0, "spi0", 0,
+			C_MUX_F(spi_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 10, 0)),
+
+	COMP_PASS_CLK(CLK_SPI1, "spi1", 0,
+			C_MUX_F(spi_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 11, 0)),
+
+	COMP_PASS_CLK(CLK_SPI2, "spi2", 0,
+			C_MUX_F(spi_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 12, 0)),
+
+	COMP_PASS_CLK(CLK_SPI3, "spi3", 0,
+			C_MUX_F(spi_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 13, 0)),
+
+	COMP_DIV_CLK(CLK_THERMAL_SENSOR, "thermal_sensor", 0,
+			C_MUX_F(thermal_sensor_clk_mux_p, 0),
+			C_GATE(CMU_DEVCLKEN1, 2, 0),
+			C_DIVIDER(CMU_TLSCLK, 8, 4, NULL, CLK_DIVIDER_POWER_OF_TWO)),
+
+	COMP_DIV_CLK(CLK_UART0, "uart0", 0,
+			C_MUX(uart_clk_mux_p, CMU_UART0CLK, 16, 1, 0),
+			C_GATE(CMU_DEVCLKEN1, 6, 0),
+			C_DIVIDER(CMU_UART0CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
+
+	COMP_DIV_CLK(CLK_UART1, "uart1", 0,
+			C_MUX(uart_clk_mux_p, CMU_UART1CLK, 16, 1, 0),
+			C_GATE(CMU_DEVCLKEN1, 7, 0),
+			C_DIVIDER(CMU_UART1CLK, 1, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
+
+	COMP_DIV_CLK(CLK_UART2, "uart2", 0,
+			C_MUX(uart_clk_mux_p, CMU_UART2CLK, 16, 1, 0),
+			C_GATE(CMU_DEVCLKEN1, 8, 0),
+			C_DIVIDER(CMU_UART2CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
+
+	COMP_DIV_CLK(CLK_UART3, "uart3", 0,
+			C_MUX(uart_clk_mux_p, CMU_UART3CLK, 16, 1, 0),
+			C_GATE(CMU_DEVCLKEN1, 19, 0),
+			C_DIVIDER(CMU_UART3CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
+
+	COMP_DIV_CLK(CLK_UART4, "uart4", 0,
+			C_MUX(uart_clk_mux_p, CMU_UART4CLK, 16, 1, 0),
+			C_GATE(CMU_DEVCLKEN1, 20, 0),
+			C_DIVIDER(CMU_UART4CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
+
+	COMP_DIV_CLK(CLK_UART5, "uart5", 0,
+			C_MUX(uart_clk_mux_p, CMU_UART5CLK, 16, 1, 0),
+			C_GATE(CMU_DEVCLKEN1, 21, 0),
+			C_DIVIDER(CMU_UART5CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
+
+	COMP_DIV_CLK(CLK_UART6, "uart6", 0,
+			C_MUX(uart_clk_mux_p, CMU_UART6CLK, 16, 1, 0),
+			C_GATE(CMU_DEVCLKEN1, 18, 0),
+			C_DIVIDER(CMU_UART6CLK, 0, 8, NULL, CLK_DIVIDER_ROUND_CLOSEST)),
+
+	COMP_FACTOR_CLK(CLK_VCE, "vce", 0,
+			C_MUX(vce_clk_mux_p, CMU_VCECLK, 4, 2, 0),
+			C_GATE(CMU_DEVCLKEN0, 26, 0),
+			C_FACTOR(CMU_VCECLK, 0, 3, bisp_factor_table, 0)),
+
+	COMP_FACTOR_CLK(CLK_VDE, "vde", 0,
+			C_MUX(hde_clk_mux_p, CMU_VDECLK, 4, 2, 0),
+			C_GATE(CMU_DEVCLKEN0, 25, 0),
+			C_FACTOR(CMU_VDECLK, 0, 3, bisp_factor_table, 0)),
+};
+
+static int s900_clk_probe(struct platform_device *pdev)
+{
+	struct owl_clk_provider *ctx;
+	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
+	void __iomem *base;
+	int i;
+
+	ctx = kzalloc(sizeof(struct owl_clk_provider) +
+			sizeof(*ctx->clk_data.hws) * CLK_NR_CLKS, GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	for (i = 0; i < CLK_NR_CLKS; ++i)
+		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	ctx->reg_base = base;
+	ctx->clk_data.num = CLK_NR_CLKS;
+	spin_lock_init(&ctx->lock);
+
+	/* register pll clocks */
+	owl_clk_register_pll(ctx, s900_pll_clks,
+			ARRAY_SIZE(s900_pll_clks));
+
+	/* register divider clocks */
+	owl_clk_register_divider(ctx, s900_div_clks,
+			ARRAY_SIZE(s900_div_clks));
+
+	/* register factor divider clocks */
+	owl_clk_register_factor(ctx, s900_factor_clks,
+			ARRAY_SIZE(s900_factor_clks));
+
+	/* register mux clocks */
+	owl_clk_register_mux(ctx, s900_mux_clks,
+			ARRAY_SIZE(s900_mux_clks));
+
+	/* register gate clocks */
+	owl_clk_register_gate(ctx, s900_gate_clks,
+			ARRAY_SIZE(s900_gate_clks));
+
+	/* register composite clocks */
+	owl_clk_register_composite(ctx, s900_composite_clks,
+			ARRAY_SIZE(s900_composite_clks));
+
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get,
+				&ctx->clk_data);
+
+}
+
+static const struct of_device_id s900_clk_of_match[] = {
+	{ .compatible = "actions,s900-cmu", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, s900_clk_of_match);
+
+static struct platform_driver s900_clk_driver = {
+	.probe = s900_clk_probe,
+	.driver = {
+		.name = "s900-cmu",
+		.of_match_table = s900_clk_of_match,
+	},
+};
+
+static int __init s900_clk_init(void)
+{
+	return platform_driver_register(&s900_clk_driver);
+}
+core_initcall(s900_clk_init);
-- 
2.7.4
