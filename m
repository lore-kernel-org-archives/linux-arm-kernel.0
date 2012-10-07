From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon,  8 Oct 2012 02:10:51 +0900
Subject: [PATCH v2 1/5] clk: samsung: add common clock framework support for
 Samsung platforms
In-Reply-To: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
References: <1349629855-4962-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1349629855-4962-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Samsung platforms include several types of clocks including fixed-rate,
mux, divider and gate clock types. There are typically hundreds of such clocks
on each of the Samsung platforms. To enable Samsung platforms to register these
clocks using the common clock framework, a bunch of utility functions are
introduced here which simplify the clock registration process.

In addition to the basic types of clock supported by common clock framework,
a Samsung specific representation of the PLL clocks is also introduced.

Both legacy and device tree based Samsung platforms are supported. On legacy
platforms, the clocks are statically instantiated and registered with common
clock framework. On device tree enabled platforms, the device tree is
searched and all clock nodes found are registered. It is also possible to
register statically instantiated clocks on device tree enabled platforms.

Cc: Mike Turquette <mturquette@ti.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/clk/Makefile         |    1 +
 drivers/clk/samsung/Makefile |    5 +
 drivers/clk/samsung/clk.c    |  414 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk.h    |  212 +++++++++++++++++++++
 4 files changed, 632 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/samsung/Makefile
 create mode 100644 drivers/clk/samsung/clk.c
 create mode 100644 drivers/clk/samsung/clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 71a25b9..95644e3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -19,6 +19,7 @@ endif
 obj-$(CONFIG_MACH_LOONGSON1)	+= clk-ls1x.o
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
+obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
 
 # Chip specific
 obj-$(CONFIG_COMMON_CLK_WM831X) += clk-wm831x.o
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
new file mode 100644
index 0000000..3f926b0
--- /dev/null
+++ b/drivers/clk/samsung/Makefile
@@ -0,0 +1,5 @@
+#
+# Samsung Clock specific Makefile
+#
+
+obj-$(CONFIG_PLAT_SAMSUNG)	+= clk.o
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
new file mode 100644
index 0000000..f5e269a
--- /dev/null
+++ b/drivers/clk/samsung/clk.c
@@ -0,0 +1,414 @@
+/*
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2012 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This file includes utility functions to register clocks to common
+ * clock framework for Samsung platforms. This includes an implementation
+ * of Samsung 'pll type' clock to represent the implementation of the
+ * pll found on Samsung platforms. In addition to that, utility functions
+ * to register mux, div, gate and fixed rate types of clocks are included.
+*/
+
+#include <linux/of.h>
+#include "clk.h"
+
+#define MAX_PARENT_CLKS		16
+#define to_clk_pll(_hw) container_of(_hw, struct samsung_pll_clock, hw)
+
+static DEFINE_SPINLOCK(lock);
+static void __iomem *reg_base;
+static void __iomem *reg_fin_pll;
+
+void __init samsung_clk_set_ctrl_base(void __iomem *base)
+{
+	reg_base = base;
+}
+
+void __init samsung_clk_set_finpll_reg(void __iomem *reg)
+{
+	reg_fin_pll = reg;
+}
+
+/* determine the output clock speed of the pll */
+static unsigned long samsung_pll_clock_recalc_rate(struct clk_hw *hw,
+				unsigned long parent_rate)
+{
+	struct samsung_pll_clock *clk_pll = to_clk_pll(hw);
+
+	if (clk_pll->get_rate)
+		return to_clk_pll(hw)->get_rate(parent_rate);
+
+	return 0;
+}
+
+/* round operation not supported */
+static long samsung_pll_clock_round_rate(struct clk_hw *hw, unsigned long drate,
+				unsigned long *prate)
+{
+	return samsung_pll_clock_recalc_rate(hw, *prate);
+}
+
+/* set the clock output rate of the pll */
+static int samsung_pll_clock_set_rate(struct clk_hw *hw, unsigned long drate,
+				unsigned long prate)
+{
+	struct samsung_pll_clock *clk_pll = to_clk_pll(hw);
+
+	if (clk_pll->set_rate)
+		return to_clk_pll(hw)->set_rate(drate);
+
+	return 0;
+}
+
+/* clock operations for samsung pll clock type */
+static const struct clk_ops samsung_pll_clock_ops = {
+	.recalc_rate = samsung_pll_clock_recalc_rate,
+	.round_rate = samsung_pll_clock_round_rate,
+	.set_rate = samsung_pll_clock_set_rate,
+};
+
+/* register a samsung pll type clock */
+void __init samsung_clk_register_pll(const char *name, const char **pnames,
+				struct device_node *np,
+				int (*set_rate)(unsigned long rate),
+				unsigned long (*get_rate)(unsigned long rate))
+{
+	struct samsung_pll_clock *clk_pll;
+	struct clk *clk;
+	struct clk_init_data init;
+	int ret;
+
+	clk_pll = kzalloc(sizeof(*clk_pll), GFP_KERNEL);
+	if (!clk_pll) {
+		pr_err("%s: could not allocate pll clk %s\n", __func__, name);
+		return;
+	}
+
+	init.name = name;
+	init.ops = &samsung_pll_clock_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+	init.parent_names = pnames;
+	init.num_parents = 1;
+
+	clk_pll->set_rate = set_rate;
+	clk_pll->get_rate = get_rate;
+	clk_pll->hw.init = &init;
+
+	/* register the clock */
+	clk = clk_register(NULL, &clk_pll->hw);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register pll clock %s\n", __func__,
+				name);
+		kfree(clk_pll);
+		return;
+	}
+
+#ifdef CONFIG_OF
+	if (np)
+		of_clk_add_provider(np, of_clk_src_simple_get, clk);
+#endif
+
+	/*
+	 * Register a clock lookup for the pll-type clock even if this
+	 * has been instantiated from device tree. This helps to do
+	 * clk_get() lookup on this clock for pruposes of displaying its
+	 * clock speed at boot time.
+	 */
+	ret = clk_register_clkdev(clk, name, NULL);
+	if (ret)
+		pr_err("%s: failed to register clock lookup for %s", __func__,
+				name);
+}
+
+#ifdef CONFIG_OF
+/* register a samsung pll type clock instantiated from device tree */
+void __init samsung_of_clk_register_pll(struct device_node *np)
+{
+	const char *clk_name = np->name;
+	const char *parent_name;
+
+	of_property_read_string(np, "clock-output-names", &clk_name);
+	parent_name = of_clk_get_parent_name(np, 0);
+	samsung_clk_register_pll(clk_name, &parent_name, np, NULL, NULL);
+}
+#endif
+
+/*
+ * Allow platform specific implementations to attach set_rate and get_rate
+ * callbacks for the pll type clock. Typical calling sequence..
+ *
+ * struct clk *clk = clk_get(NULL, "pll-clk-name");
+ * samsung_pll_clk_set_cb(clk, pll_set_rate, pll_get_rate);
+ */
+void __init samsung_pll_clk_set_cb(struct clk *clk,
+			int (*set_rate)(unsigned long rate),
+			unsigned long (*get_rate)(unsigned long rate))
+{
+	struct samsung_pll_clock *clk_pll;
+	struct clk_hw *hw = __clk_get_hw(clk);
+
+	clk_pll = to_clk_pll(hw);
+	clk_pll->set_rate = set_rate;
+	clk_pll->get_rate = get_rate;
+}
+
+/* register a list of fixed clocks (used only for non-dt platforms) */
+void __init samsung_clk_register_fixed_rate(
+		struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	for (idx = 0; idx < nr_clk; idx++, clk_list++) {
+		clk = clk_register_fixed_rate(NULL, clk_list->name, NULL,
+				clk_list->flags, clk_list->fixed_rate);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				clk_list->name);
+			continue;
+		}
+
+		/*
+		 * Register a lookup which will help in clk_get() and
+		 * printing the clock rate during clock initialization.
+		 */
+		ret = clk_register_clkdev(clk, clk_list->name,
+						clk_list->dev_name);
+		if (ret)
+			pr_err("clock: failed to register clock lookup for %s",
+				clk_list->name);
+	}
+}
+
+/* register a list of mux clocks */
+void __init samsung_clk_register_mux(struct samsung_mux_clock *clk_list,
+						unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	for (idx = 0; idx < nr_clk; idx++, clk_list++) {
+		clk = clk_register_mux(NULL, clk_list->name,
+			clk_list->parent_names, clk_list->num_parents,
+			clk_list->flags, clk_list->reg, clk_list->shift,
+			clk_list->width, clk_list->mux_flags, &lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n", __func__,
+				clk_list->name);
+			continue;
+		}
+
+#ifdef CONFIG_OF
+		if (clk_list->np)
+			of_clk_add_provider(clk_list->np, of_clk_src_simple_get,
+							clk);
+#endif
+
+		ret = clk_register_clkdev(clk, clk_list->name,
+						clk_list->dev_name);
+		if (ret)
+			pr_err("%s: failed to register clock lookup for %s",
+					__func__, clk_list->name);
+
+		if (clk_list->alias) {
+			ret = clk_register_clkdev(clk, clk_list->alias,
+						clk_list->dev_name);
+			if (ret)
+				pr_err("%s: failed to register lookup %s\n",
+					__func__, clk_list->alias);
+		}
+	}
+}
+
+#ifdef CONFIG_OF
+/* register a samsung mux type clock instantiated from device tree */
+void __init samsung_of_clk_register_mux(struct device_node *np)
+{
+	struct samsung_mux_clock mux_clk;
+	const char *clk_name = np->name;
+	const char *parent_names[MAX_PARENT_CLKS];
+	u32 reg_info[3];
+	int idx = 0;
+
+	of_property_read_string(np, "clock-output-names", &clk_name);
+	do {
+		/* get names of all parent clocks */
+		parent_names[idx] = of_clk_get_parent_name(np, idx);
+		idx++;
+	} while (parent_names[idx-1]);
+
+	if (of_property_read_u32_array(np, "reg-info", reg_info, 3))
+		pr_err("%s: invalid register info in node\n", __func__);
+
+	mux_clk.name = clk_name;
+	mux_clk.parent_names = parent_names;
+	mux_clk.num_parents = idx - 1;
+	mux_clk.reg = (void __iomem *)(reg_base + reg_info[0]);
+	mux_clk.shift = reg_info[1];
+	mux_clk.width = reg_info[2];
+	mux_clk.dev_name = NULL;
+	mux_clk.flags = 0;
+	mux_clk.mux_flags = 0;
+	mux_clk.alias = NULL;
+	mux_clk.np = np;
+
+	if (!strcmp(mux_clk.name, "fin_pll"))
+		mux_clk.reg = reg_fin_pll;
+
+	samsung_clk_register_mux(&mux_clk, 1);
+}
+#endif
+
+/* register a list of div clocks */
+void __init samsung_clk_register_div(struct samsung_div_clock *clk_list,
+						unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	for (idx = 0; idx < nr_clk; idx++, clk_list++) {
+		clk = clk_register_divider(NULL, clk_list->name,
+			clk_list->parent_name, clk_list->flags, clk_list->reg,
+			clk_list->shift, clk_list->width, clk_list->div_flags,
+			&lock);
+		if (IS_ERR(clk)) {
+			pr_err("clock: failed to register clock %s\n",
+				clk_list->name);
+			continue;
+		}
+
+#ifdef CONFIG_OF
+		if (clk_list->np)
+			of_clk_add_provider(clk_list->np, of_clk_src_simple_get,
+							clk);
+#endif
+
+		ret = clk_register_clkdev(clk, clk_list->name,
+						clk_list->dev_name);
+		if (ret)
+			pr_err("%s: failed to register clock lookup for %s",
+					__func__, clk_list->name);
+
+		if (clk_list->alias) {
+			ret = clk_register_clkdev(clk, clk_list->alias,
+						clk_list->dev_name);
+			if (ret)
+				pr_err("%s: failed to register lookup %s\n",
+					__func__, clk_list->alias);
+		}
+	}
+}
+
+#ifdef CONFIG_OF
+/* register a samsung div type clock instantiated from device tree */
+void __init samsung_of_clk_register_div(struct device_node *np)
+{
+	struct samsung_div_clock clk_div;
+	const char *clk_name = np->name;
+	const char *parent_name;
+	u32 reg_info[3];
+
+	of_property_read_string(np, "clock-output-names", &clk_name);
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (of_property_read_u32_array(np, "reg-info", reg_info, 3))
+		pr_err("%s: invalid register info in node\n", __func__);
+
+	clk_div.name = clk_name;
+	clk_div.parent_name = parent_name;
+	clk_div.reg = (void __iomem *)(reg_base + reg_info[0]);
+	clk_div.shift = reg_info[1];
+	clk_div.width = reg_info[2];
+	clk_div.dev_name = NULL;
+	clk_div.flags = 0;
+	clk_div.div_flags = 0;
+	clk_div.alias = NULL;
+	clk_div.np = np;
+
+	samsung_clk_register_div(&clk_div, 1);
+}
+#endif
+
+/* register a list of gate clocks */
+void __init samsung_clk_register_gate(struct samsung_gate_clock *clk_list,
+						unsigned int nr_clk)
+{
+	struct clk *clk;
+	unsigned int idx, ret;
+
+	for (idx = 0; idx < nr_clk; idx++, clk_list++) {
+		clk = clk_register_gate(NULL, clk_list->name,
+			clk_list->parent_name, clk_list->flags, clk_list->reg,
+			clk_list->bit_idx, clk_list->gate_flags, &lock);
+		if (IS_ERR(clk)) {
+			pr_err("clock: failed to register clock %s\n",
+				clk_list->name);
+			continue;
+		}
+
+#ifdef CONFIG_OF
+		if (clk_list->np)
+			of_clk_add_provider(clk_list->np, of_clk_src_simple_get,
+							clk);
+#endif
+
+		ret = clk_register_clkdev(clk, clk_list->name,
+						clk_list->dev_name);
+		if (ret)
+			pr_err("%s: failed to register clock lookup for %s",
+					__func__, clk_list->name);
+
+		if (clk_list->alias) {
+			ret = clk_register_clkdev(clk, clk_list->alias,
+						clk_list->dev_name);
+			if (ret)
+				pr_err("%s: failed to register lookup %s\n",
+					__func__, clk_list->alias);
+		}
+	}
+}
+
+#ifdef CONFIG_OF
+/* register a samsung gate type clock instantiated from device tree */
+void __init samsung_of_clk_register_gate(struct device_node *np)
+{
+	struct samsung_gate_clock clk_gate;
+	const char *clk_name = np->name;
+	const char *parent_name;
+	u32 reg_info[2];
+
+	of_property_read_string(np, "clock-output-names", &clk_name);
+	parent_name = of_clk_get_parent_name(np, 0);
+	if (of_property_read_u32_array(np, "reg-info", reg_info, 2))
+		pr_err("%s: invalid register info in node\n", __func__);
+
+	clk_gate.name = clk_name;
+	clk_gate.parent_name = parent_name;
+	clk_gate.reg = (void __iomem *)(reg_base + reg_info[0]);
+	clk_gate.bit_idx = reg_info[1];
+	clk_gate.dev_name = NULL;
+	clk_gate.flags = 0;
+	clk_gate.gate_flags = 0;
+	clk_gate.alias = NULL;
+	clk_gate.np = np;
+
+	samsung_clk_register_gate(&clk_gate, 1);
+}
+#endif
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
index 0000000..391607d
--- /dev/null
+++ b/drivers/clk/samsung/clk.h
@@ -0,0 +1,212 @@
+/*
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2012 Linaro Ltd.
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
+#include <mach/regs-clock.h>
+
+/**
+ * struct samsung_clk_pll: represents a samsung pll type clock
+ * @hw: connection to struct clk.
+ * @set_rate: callback for setting the pll clock rate
+ * @get_rate: callback for determing the pll clock rate
+ *
+ * Internal representation of the pll type clock. Platform specific
+ * implementation can instantiate clocks of this type by calling
+ * samsung_clk_register_pll() function.
+ */
+struct samsung_pll_clock {
+	struct clk_hw		hw;
+	int			(*set_rate)(unsigned long rate);
+	unsigned long		(*get_rate)(unsigned long xtal_rate);
+};
+
+/**
+ * struct samsung_fixed_rate_clock: information about fixed-rate clock
+ * @dev_name: name of the device to which this clock belongs.
+ * @name: name of this fixed-rate clock.
+ * @parent_name: optional parent clock name.
+ * @flags: optional fixed-rate clock flags.
+ * @fixed-rate: fixed clock rate of this clock.
+ * @np: node pointer for this clock.
+ */
+struct samsung_fixed_rate_clock {
+	const char		*dev_name;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		fixed_rate;
+	struct device_node	*np;
+};
+
+#define FRATE_CLK(dname, cname, pname, f, frate)	\
+	{						\
+		.dev_name	= dname,		\
+		.name		= cname,		\
+		.parent_name	= pname,		\
+		.flags		= f,			\
+		.fixed_rate	= frate,		\
+		.np		= NULL,			\
+	}
+
+/**
+ * struct samsung_mux_clock: information about mux clock
+ * @dev_name: name of the device to which this clock belongs.
+ * @name: name of this mux clock.
+ * @parent_names: array of pointer to parent clock names.
+ * @num_parents: number of parents listed in @parent_names.
+ * @flags: optional flags for basic clock.
+ * @reg: address of register for configuring the mux.
+ * @shift: starting bit location of the mux control bit-field in @reg.
+ * @width: width of the mux control bit-field in @reg.
+ * @mux_flags: flags for mux-type clock.
+ * @alias: optional clock alias name to be assigned to this clock.
+ * @np: node pointer for this clock.
+ */
+struct samsung_mux_clock {
+	const char		*dev_name;
+	const char		*name;
+	const char		**parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	void __iomem		*reg;
+	u8			shift;
+	u8			width;
+	u8			mux_flags;
+	const char		*alias;
+	struct device_node	*np;
+};
+
+#define MUXCLK(dname, cname, pnames, f, r, s, w, mf)		\
+	{							\
+		.dev_name	= dname,			\
+		.name		= cname,			\
+		.parent_names	= pnames,			\
+		.num_parents	= ARRAY_SIZE(pnames),		\
+		.flags		= f,				\
+		.reg		= r,				\
+		.shift		= s,				\
+		.width		= w,				\
+		.mux_flags	= mf,				\
+		.np		= NULL,				\
+	}
+
+/**
+ * struct samsung_div_clock: information about div clock
+ * @dev_name: name of the device to which this clock belongs.
+ * @name: name of this div clock.
+ * @parent_name: name of the parent clock.
+ * @flags: optional flags for basic clock.
+ * @reg: address of register for configuring the div.
+ * @shift: starting bit location of the div control bit-field in @reg.
+ * @div_flags: flags for div-type clock.
+ * @alias: optional clock alias name to be assigned to this clock.
+ * @np: node pointer for this clock.
+ */
+struct samsung_div_clock {
+	const char		*dev_name;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	void __iomem		*reg;
+	u8			shift;
+	u8			width;
+	u8			div_flags;
+	const char		*alias;
+	struct device_node	*np;
+};
+
+#define DIVCLK(dname, cname, pname, f, r, s, w, df)		\
+	{							\
+		.dev_name	= dname,			\
+		.name		= cname,			\
+		.parent_name	= pname,			\
+		.flags		= f,				\
+		.reg		= r,				\
+		.shift		= s,				\
+		.width		= w,				\
+		.div_flags	= df,				\
+		.np		= NULL,				\
+	}
+
+/**
+ * struct samsung_gate_clock: information about gate clock
+ * @dev_name: name of the device to which this clock belongs.
+ * @name: name of this gate clock.
+ * @parent_name: name of the parent clock.
+ * @flags: optional flags for basic clock.
+ * @reg: address of register for configuring the gate.
+ * @bit_idx: bit index of the gate control bit-field in @reg.
+ * @gate_flags: flags for gate-type clock.
+ * @alias: optional clock alias name to be assigned to this clock.
+ * @np: node pointer for this clock.
+ */
+struct samsung_gate_clock {
+	const char		*dev_name;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	void __iomem		*reg;
+	u8			bit_idx;
+	u8			gate_flags;
+	const char		*alias;
+	struct device_node	*np;
+};
+
+#define GATECLK(dname, cname, pname, f, r, b, a)		\
+	{							\
+		.dev_name	= dname,			\
+		.name		= cname,			\
+		.parent_name	= pname,			\
+		.flags		= f,				\
+		.reg		= r,				\
+		.bit_idx	= b,				\
+		.alias		= a,				\
+		.np		= NULL,				\
+	}
+
+extern void __init samsung_clk_set_ctrl_base(void __iomem *base);
+extern void __init samsung_clk_set_finpll_reg(void __iomem *reg);
+
+extern void __init samsung_clk_register_pll(const char *name,
+		const char **parent_names, struct device_node *np,
+		int (*set_rate)(unsigned long rate),
+		unsigned long (*get_rate)(unsigned long rate));
+
+extern void __init samsung_clk_register_fixed_rate(
+		struct samsung_fixed_rate_clock *clk_list, unsigned int nr_clk);
+
+extern void __init samsung_clk_register_mux(struct samsung_mux_clock *clk_list,
+		unsigned int nr_clk);
+
+extern void __init samsung_clk_register_div(struct samsung_div_clock *clk_list,
+		unsigned int nr_clk);
+
+extern void __init samsung_clk_register_gate(
+		struct samsung_gate_clock *clk_list, unsigned int nr_clk);
+
+extern void __init samsung_of_clk_register_mux(struct device_node *np);
+extern void __init samsung_of_clk_register_pll(struct device_node *np);
+extern void __init samsung_of_clk_register_div(struct device_node *np);
+extern void __init samsung_of_clk_register_gate(struct device_node *np);
+
+extern void __init samsung_pll_clk_set_cb(struct clk *clk,
+			int (*set_rate)(unsigned long rate),
+			unsigned long (*get_rate)(unsigned long rate));
+
+extern unsigned long _get_rate(const char *clk_name);
+
+#endif /* __SAMSUNG_CLK_H */
-- 
1.7.5.4
