From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Mon, 15 May 2017 16:35:02 +0800
Subject: [PATCH 3/3] clk: Add common clock driver for Spreadtrum SoCs
In-Reply-To: <20170515083502.4492-1-chunyan.zhang@spreadtrum.com>
References: <20170515083502.4492-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20170515083502.4492-4-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xiaolong Zhang <xiaolong.zhang@spreadtrum.com>

This patch adds an initial common clock driver comprising clock gate,
divider, multiplexer, composite, pll, these drivers are used on almost
all Spreadtrum platforms so far.

Signed-off-by: Xiaolong Zhang <xiaolong.zhang@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/Makefile         |   1 +
 drivers/clk/sprd/Makefile    |   3 +
 drivers/clk/sprd/clk-gates.c | 366 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/composite.c | 109 ++++++++++++
 drivers/clk/sprd/divider.c   |  79 +++++++++
 drivers/clk/sprd/mux.c       |  77 +++++++++
 drivers/clk/sprd/pll.c       | 359 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/sprd/pll.h       |  73 ++++++++
 drivers/clk/sprd/pll_cfg.h   | 390 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 1457 insertions(+)
 create mode 100644 drivers/clk/sprd/Makefile
 create mode 100644 drivers/clk/sprd/clk-gates.c
 create mode 100644 drivers/clk/sprd/composite.c
 create mode 100644 drivers/clk/sprd/divider.c
 create mode 100644 drivers/clk/sprd/mux.c
 create mode 100644 drivers/clk/sprd/pll.c
 create mode 100644 drivers/clk/sprd/pll.h
 create mode 100644 drivers/clk/sprd/pll_cfg.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c19983a..1d62721 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
+obj-$(CONFIG_ARCH_SPRD)			+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi-ng/
diff --git a/drivers/clk/sprd/Makefile b/drivers/clk/sprd/Makefile
new file mode 100644
index 0000000..a783c27
--- /dev/null
+++ b/drivers/clk/sprd/Makefile
@@ -0,0 +1,3 @@
+ifneq ($(CONFIG_OF),)
+obj-y					+= divider.o mux.o composite.o pll.o clk-gates.o
+endif
diff --git a/drivers/clk/sprd/clk-gates.c b/drivers/clk/sprd/clk-gates.c
new file mode 100644
index 0000000..8d4ccb9
--- /dev/null
+++ b/drivers/clk/sprd/clk-gates.c
@@ -0,0 +1,366 @@
+/*
+ * Spreadtrum clock set/clear gate driver
+ *
+ * Copyright (C) 2015~2017 spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/spinlock.h>
+#include <linux/hwspinlock.h>
+
+DEFINE_SPINLOCK(gate_lock);
+
+#define to_clk_gate(_hw) container_of(_hw, struct clk_gate, hw)
+#define CLK_GATE_HWSPINLOCK		BIT(7)
+#define GLB_CLK_HWSPINLOCK_TIMEOUT	5000
+
+static struct hwspinlock		*glb_clk_hw_lock;
+
+static void sprd_clk_lock(struct clk_gate *gate,
+			unsigned long flags)
+{
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+	else
+		__acquire(gate->lock);
+}
+
+static void sprd_clk_unlock(struct clk_gate *gate,
+			unsigned long flags)
+{
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+	else
+		__release(gate->lock);
+}
+
+static void sprd_clk_hw_lock(struct clk_gate *gate,
+				unsigned long *flags)
+{
+	int ret = 0;
+
+	if (glb_clk_hw_lock && (gate->flags & CLK_GATE_HWSPINLOCK)) {
+		ret = hwspin_lock_timeout_irqsave(glb_clk_hw_lock,
+					  GLB_CLK_HWSPINLOCK_TIMEOUT,
+					  flags);
+		if (ret)
+			pr_err("glb_clk:%s lock the hwlock failed.\n",
+			       __clk_get_name(gate->hw.clk));
+		return;
+	}
+
+	sprd_clk_lock(gate, *flags);
+}
+
+static void sprd_clk_hw_unlock(struct clk_gate *gate,
+				unsigned long *flags)
+{
+	if (glb_clk_hw_lock && (gate->flags & CLK_GATE_HWSPINLOCK)) {
+		hwspin_unlock_irqrestore(glb_clk_hw_lock, flags);
+		return;
+	}
+
+	sprd_clk_unlock(gate, *flags);
+}
+
+static void sprd_clk_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+	unsigned long flags = 0;
+	u32 reg;
+
+	set ^= enable;
+
+	sprd_clk_hw_lock(gate, &flags);
+
+	reg = clk_readl(gate->reg);
+
+	if (set)
+		reg |= BIT(gate->bit_idx);
+	else
+		reg &= ~BIT(gate->bit_idx);
+
+	clk_writel(reg, gate->reg);
+
+	sprd_clk_hw_unlock(gate, &flags);
+}
+
+static int sprd_clk_gate_enable(struct clk_hw *hw)
+{
+	sprd_clk_gate_endisable(hw, 1);
+
+	return 0;
+}
+
+static void sprd_clk_gate_disable(struct clk_hw *hw)
+{
+	sprd_clk_gate_endisable(hw, 0);
+}
+
+static int sprd_clk_gate_is_enabled(struct clk_hw *hw)
+{
+	u32 reg;
+	struct clk_gate *gate = to_clk_gate(hw);
+
+	reg = clk_readl(gate->reg);
+
+	if (gate->flags & CLK_GATE_SET_TO_DISABLE)
+		reg ^= BIT(gate->bit_idx);
+
+	reg &= BIT(gate->bit_idx);
+
+	return reg ? 1 : 0;
+}
+
+const struct clk_ops sprd_clk_gate_ops = {
+	.enable = sprd_clk_gate_enable,
+	.disable = sprd_clk_gate_disable,
+	.is_enabled = sprd_clk_gate_is_enabled,
+};
+
+static void sprd_clk_sc_gate_endisable(struct clk_hw *hw, int enable,
+				       unsigned int offset)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
+	unsigned long flags = 0;
+	void __iomem *reg;
+
+	set ^= enable;
+
+	sprd_clk_lock(gate, flags);
+
+	/*
+	 * Each gate clock has three registers:
+	 * gate->reg			- base register
+	 * gate->reg + offset		- set register
+	 * gate->reg + 2 * offset	- clear register
+	 */
+	reg = set ? gate->reg + offset : gate->reg + 2 * offset;
+	clk_writel(BIT(gate->bit_idx), reg);
+
+	sprd_clk_unlock(gate, flags);
+
+}
+
+static int sprd_clk_sc100_gate_enable(struct clk_hw *hw)
+{
+	sprd_clk_sc_gate_endisable(hw, 1, 0x100);
+
+	return 0;
+}
+
+static void sprd_clk_sc100_gate_disable(struct clk_hw *hw)
+{
+	sprd_clk_sc_gate_endisable(hw, 0, 0x100);
+}
+
+static int sprd_clk_sc1000_gate_enable(struct clk_hw *hw)
+{
+	sprd_clk_sc_gate_endisable(hw, 1, 0x1000);
+
+	return 0;
+}
+
+static void sprd_clk_sc1000_gate_disable(struct clk_hw *hw)
+{
+	sprd_clk_sc_gate_endisable(hw, 0, 0x1000);
+}
+
+const struct clk_ops sprd_clk_sc100_gate_ops = {
+	.enable = sprd_clk_sc100_gate_enable,
+	.disable = sprd_clk_sc100_gate_disable,
+	.is_enabled = sprd_clk_gate_is_enabled,
+};
+
+const struct clk_ops sprd_clk_sc1000_gate_ops = {
+	.enable = sprd_clk_sc1000_gate_enable,
+	.disable = sprd_clk_sc1000_gate_disable,
+	.is_enabled = sprd_clk_gate_is_enabled,
+};
+
+static struct clk *sprd_clk_register_gate(struct device *dev,
+		const char *name, const char *parent_name,
+		unsigned long flags, void __iomem *reg,
+		u8 bit_idx, u8 clk_gate_flags,
+		spinlock_t *lock, const struct clk_ops *ops)
+{
+	struct clk_gate *gate;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	gate->reg = reg;
+	gate->bit_idx = bit_idx;
+	gate->flags = clk_gate_flags;
+	gate->lock = lock;
+	gate->hw.init = &init;
+
+	clk = clk_register(dev, &gate->hw);
+
+	if (IS_ERR(clk))
+		kfree(gate);
+
+	return clk;
+}
+
+static void __init sprd_clk_gates_setup(struct device_node *node,
+					   const struct clk_ops *ops)
+{
+	const char *clk_name = NULL;
+	void __iomem *reg;
+	const char *parent_name;
+	unsigned long flags = CLK_IGNORE_UNUSED;
+	u8 gate_flags = 0;
+	u32 index;
+	int number, i = 0;
+	struct resource res;
+	struct clk_onecell_data *clk_data;
+	struct property *prop;
+	const __be32 *p;
+
+	if (of_address_to_resource(node, 0, &res)) {
+		pr_err("%s: no DT registers found for %s\n",
+		       __func__, node->full_name);
+		return;
+	}
+
+	/*
+	 * bit[1:0] represents the gate flags, but bit[1] is not used
+	 * for the time being.
+	 */
+	if (res.start & 0x3) {
+		res.start &= ~0x3;
+		gate_flags |= CLK_GATE_SET_TO_DISABLE;
+	}
+	reg = ioremap(res.start, resource_size(&res));
+	if (!reg) {
+		pr_err("%s: gates clock[%s] ioremap failed!\n",
+		       __func__, node->full_name);
+		return;
+	}
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	if (!clk_data)
+		goto iounmap_reg;
+
+	number = of_property_count_u32_elems(node, "clock-indices");
+	if (number > 0) {
+		of_property_read_u32_index(node, "clock-indices",
+					   number - 1, &number);
+		number += 1;
+	} else {
+		number = of_property_count_strings(node, "clock-output-names");
+	}
+
+	clk_data->clks = kcalloc(number, sizeof(struct clk *),
+				 GFP_KERNEL);
+	if (!clk_data->clks)
+		goto kfree_clk_data;
+
+	/*
+	 * If the identifying number for the clocks in the node is not
+	 * linear from zero, then we use clock-indices mapping
+	 * identifiers into the clock-output-names array in DT.
+	 */
+	if (of_property_count_u32_elems(node, "clock-indices") > 0) {
+		of_property_for_each_u32(node, "clock-indices",
+					 prop, p, index) {
+			of_property_read_string_index(node,
+						      "clock-output-names",
+						      i++, &clk_name);
+
+			clk_data->clks[index] = sprd_clk_register_gate(NULL,
+						clk_name, parent_name, flags,
+						reg, index, gate_flags,
+						&gate_lock, ops);
+			WARN_ON(IS_ERR(clk_data->clks[index]));
+
+			clk_register_clkdev(clk_data->clks[index], clk_name,
+					    NULL);
+		}
+	} else {
+		of_property_for_each_string(node, "clock-output-names",
+					    prop, clk_name) {
+			clk_data->clks[i] = sprd_clk_register_gate(NULL,
+						clk_name, parent_name, flags,
+						reg, i,	gate_flags,
+						&gate_lock, ops);
+			WARN_ON(IS_ERR(clk_data->clks[i]));
+
+			clk_register_clkdev(clk_data->clks[i], clk_name, NULL);
+			i++;
+		}
+	}
+
+	clk_data->clk_num = number;
+	if (number == 1)
+		of_clk_add_provider(node, of_clk_src_simple_get, clk_data);
+	else
+		of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	return;
+
+kfree_clk_data:
+	kfree(clk_data);
+
+iounmap_reg:
+	iounmap(reg);
+}
+
+static void __init sprd_sc100_clk_gates_setup(struct device_node *node)
+{
+	sprd_clk_gates_setup(node, &sprd_clk_sc100_gate_ops);
+}
+
+static void __init sprd_sc1000_clk_gates_setup(struct device_node *node)
+{
+	sprd_clk_gates_setup(node, &sprd_clk_sc1000_gate_ops);
+}
+
+static void __init sprd_trad_clk_gates_setup(struct device_node *node)
+{
+	sprd_clk_gates_setup(node, &sprd_clk_gate_ops);
+}
+
+CLK_OF_DECLARE(gates_clock, "sprd,gates-clock",
+		sprd_trad_clk_gates_setup);
+CLK_OF_DECLARE(sc100_gates_clock, "sprd,sc100-gates-clock",
+	       sprd_sc100_clk_gates_setup);
+CLK_OF_DECLARE(sc1000_gates_clock, "sprd,sc1000-gates-clock",
+	       sprd_sc1000_clk_gates_setup);
+
+#ifdef CONFIG_SPRD_HWSPINLOCK
+static int __init sprd_clk_hwspinlock_init(void)
+{
+	/*
+	 * glb_clk belongs to the global registers, so it can use the
+	 * same hwspinlock
+	 */
+	glb_clk_hw_lock = hwspin_lock_get_used(1);
+	if (!glb_clk_hw_lock) {
+		pr_err("%s: Can't get the hardware spinlock.\n", __func__);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+subsys_initcall_sync(sprd_clk_hwspinlock_init);
+#endif
diff --git a/drivers/clk/sprd/composite.c b/drivers/clk/sprd/composite.c
new file mode 100644
index 0000000..118565a
--- /dev/null
+++ b/drivers/clk/sprd/composite.c
@@ -0,0 +1,109 @@
+/*
+ * Spreadtrum composite clock driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+void __init sprd_composite_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_mux *mux = NULL;
+	const struct clk_ops *mux_ops = NULL;
+	struct clk_divider *div = NULL;
+	const struct clk_ops *div_ops = NULL;
+	const char *clk_name = node->name;
+	const char **parent_names;
+	unsigned long flags = 0;
+	u32 msk;
+	int num_parents = 0;
+	int i = 0;
+	int index = 0;
+
+	if (of_property_read_string(node, "clock-output-names", &clk_name))
+		return;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (!num_parents) {
+		pr_err("%s: Failed to get %s's parent number!\n",
+		       __func__, clk_name);
+		return;
+	}
+
+	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
+	if (!parent_names)
+		return;
+
+	while (i < num_parents &&
+			(parent_names[i] =
+			 of_clk_get_parent_name(node, i)) != NULL)
+		i++;
+
+	mux = kzalloc(sizeof(struct clk_mux), GFP_KERNEL);
+	if (!mux)
+		goto kfree_parent_names;
+
+	if (!of_property_read_u32(node, "sprd,mux-msk", &msk)) {
+		mux->reg = of_iomap(node, index++);
+		if (!mux->reg)
+			goto kfree_mux;
+
+		mux->shift = __ffs(msk);
+		mux->mask = msk >> (mux->shift);
+		mux_ops = &clk_mux_ops;
+	}
+
+	div = kzalloc(sizeof(struct clk_divider), GFP_KERNEL);
+	if (!div)
+		goto iounmap_mux_reg;
+
+	if (!of_property_read_u32(node, "sprd,div-msk", &msk)) {
+		div->reg = of_iomap(node, index);
+		if (!div->reg)
+			div->reg = mux->reg;
+		if (!div->reg)
+			goto iounmap_mux_reg;
+
+		div->shift = __ffs(msk);
+		div->width = fls(msk) - div->shift;
+		div_ops = &clk_divider_ops;
+	}
+
+	flags |= CLK_IGNORE_UNUSED;
+	clk = clk_register_composite(NULL, clk_name, parent_names, num_parents,
+				     &mux->hw, mux_ops, &div->hw, div_ops, NULL,
+				     NULL, flags);
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		clk_register_clkdev(clk, clk_name, NULL);
+		return;
+	}
+
+	if (div->reg)
+		if (!mux || (div->reg != mux->reg))
+			iounmap(div->reg);
+
+	kfree(div);
+
+iounmap_mux_reg:
+	if (mux->reg)
+		iounmap(mux->reg);
+
+kfree_mux:
+	kfree(mux);
+
+kfree_parent_names:
+	pr_err("Failed to register composite clk %s!\n", clk_name);
+	kfree(parent_names);
+}
+
+CLK_OF_DECLARE(composite_clock, "sprd,composite-clock",
+	       sprd_composite_clk_setup);
diff --git a/drivers/clk/sprd/divider.c b/drivers/clk/sprd/divider.c
new file mode 100644
index 0000000..785d6c4
--- /dev/null
+++ b/drivers/clk/sprd/divider.c
@@ -0,0 +1,79 @@
+/*
+ * Spreadtrum divider clock driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+void __init sprd_divider_clk_setup(struct device_node *node)
+{
+	struct clk *clk, *pclk;
+	struct clk_divider *clk_div;
+	struct clk_composite *clk_composite;
+	const char *clk_name = node->name;
+	const char *parent;
+	void __iomem *reg;
+	u32 msk = 0;
+	u8 shift = 0;
+	u8 width = 0;
+
+	if (of_property_read_string(node, "clock-output-names", &clk_name))
+		return;
+
+	parent = of_clk_get_parent_name(node, 0);
+
+	if (of_property_read_bool(node, "reg")) {
+		reg = of_iomap(node, 0);
+	} else {
+		pclk = __clk_lookup(parent);
+		if (!pclk) {
+			pr_err("%s: clock[%s] has no reg and parent!\n",
+			       __func__, clk_name);
+			return;
+		}
+
+		clk_composite = container_of(__clk_get_hw(pclk),
+					     struct clk_composite, hw);
+
+		clk_div = container_of(clk_composite->rate_hw,
+				       struct clk_divider, hw);
+
+		reg = clk_div->reg;
+	}
+
+	if (!reg) {
+		pr_err("%s: clock[%s] remap register failed!\n",
+		       __func__, clk_name);
+		return;
+	}
+
+	if (of_property_read_u32(node, "sprd,div-msk", &msk)) {
+		pr_err("%s: Failed to get %s's div-msk\n", __func__, clk_name);
+		goto iounmap_reg;
+	}
+
+	shift = __ffs(msk);
+	width = fls(msk) - shift;
+	clk = clk_register_divider(NULL, clk_name, parent,
+				   0, reg, shift, width, 0, NULL);
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		clk_register_clkdev(clk, clk_name, NULL);
+		return;
+	}
+
+iounmap_reg:
+	iounmap(reg);
+	pr_err("%s: Failed to register divider clock[%s]!\n",
+	       __func__, clk_name);
+}
+
+CLK_OF_DECLARE(divider_clock, "sprd,divider-clock", sprd_divider_clk_setup);
diff --git a/drivers/clk/sprd/mux.c b/drivers/clk/sprd/mux.c
new file mode 100644
index 0000000..5969282
--- /dev/null
+++ b/drivers/clk/sprd/mux.c
@@ -0,0 +1,77 @@
+/*
+ * Spreadtrum multiplexer clock driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+void __init sprd_mux_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char **parent_names;
+	int   num_parents = 0;
+	void __iomem *reg;
+	u32  msk = 0;
+	u8   shift = 0;
+	u8   width = 0;
+	int i = 0;
+
+	if (of_property_read_string(node, "clock-output-names", &clk_name))
+		return;
+
+	if (of_property_read_u32(node, "sprd,mux-msk", &msk)) {
+		pr_err("%s: No mux-msk property found for %s!\n",
+		       __func__, clk_name);
+		return;
+	}
+	shift = __ffs(msk);
+	width = fls(msk) - shift;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (!num_parents) {
+		pr_err("%s: no parent found for %s!\n",
+		       __func__, clk_name);
+		return;
+	}
+
+	parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		return;
+
+	while (i < num_parents &&
+		(parent_names[i] =
+		 of_clk_get_parent_name(node, i)) != NULL)
+		i++;
+
+	reg = of_iomap(node, 0);
+	if (!reg) {
+		pr_err("%s: mux-clock[%s] of_iomap failed!\n", __func__,
+			clk_name);
+		goto kfree_parent_names;
+	}
+
+	clk = clk_register_mux(NULL, clk_name, parent_names, num_parents,
+			       CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
+			       reg, shift, width, 0, NULL);
+	if (clk) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		clk_register_clkdev(clk, clk_name, NULL);
+		return;
+	}
+
+	iounmap(reg);
+
+kfree_parent_names:
+	kfree(parent_names);
+}
+
+CLK_OF_DECLARE(muxed_clock, "sprd,muxed-clock", sprd_mux_clk_setup);
diff --git a/drivers/clk/sprd/pll.c b/drivers/clk/sprd/pll.c
new file mode 100644
index 0000000..de32bce
--- /dev/null
+++ b/drivers/clk/sprd/pll.c
@@ -0,0 +1,359 @@
+/*
+ * Spreatrum pll clock driver
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <linux/delay.h>
+#include "pll_cfg.h"
+
+struct sprd_pll_config *g_sprd_pll_config;
+
+static void pll_write(void __iomem *reg, u32 val, u32 msk)
+{
+	writel_relaxed((readl_relaxed(reg) & ~msk) | val, reg);
+}
+
+static unsigned long pll_get_refin_rate(struct sprd_pll_hw *pll,
+					struct sprd_pll_config *ppll_config)
+{
+	u32 i = 3;
+	u8 index;
+	u32 value;
+	const unsigned long refin[4] = { 2, 4, 13, 26 };
+
+	value = ppll_config->refin_msk.value;
+	index = ppll_config->refin_msk.index;
+	if (value) {
+		i = (readl_relaxed(pll->reg[index]) & value) >> __ffs(value);
+		i = i > 3 ? 3 : i;
+	}
+
+	return refin[i];
+}
+
+static u8 pll_get_ibias(unsigned long rate, struct pll_ibias_table *table)
+{
+	if (!table)
+		return 0;
+
+	for (; table->rate < SPRD_PLL_MAX_RATE; table++)
+		if (rate <= table->rate)
+			break;
+
+	return table->ibias;
+}
+
+static void *pll_get_config(struct clk_hw *hw,
+			    struct sprd_pll_config *pll_config)
+{
+	struct sprd_pll_config *p;
+
+	for (p = pll_config; p->name != NULL; p++)
+		if (!strcmp(p->name, __clk_get_name(hw->clk)))
+			break;
+
+	return p->name ? p : NULL;
+}
+
+static int pll_clk_prepare(struct clk_hw *hw)
+{
+	struct sprd_pll_config *pcfg;
+
+	pcfg = pll_get_config(hw, g_sprd_pll_config);
+	if (!pcfg)
+		return -EPERM;
+
+	udelay(pcfg->udelay);
+
+	return 0;
+}
+
+static long pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long *prate)
+{
+	return rate;
+}
+
+static inline int pll_check(struct sprd_pll_hw *pll,
+			    struct sprd_pll_config *ppll_config)
+{
+	if ((ppll_config->lock_done.index >= pll->reg_num)	||
+	    (ppll_config->div_s.index >= pll->reg_num)		||
+	    (ppll_config->mod_en.index >= pll->reg_num)		||
+	    (ppll_config->sdm_en.index >= pll->reg_num)		||
+	    (ppll_config->refin_msk.index >= pll->reg_num)	||
+	    (ppll_config->ibias_msk.index >= pll->reg_num)	||
+	    (ppll_config->pll_n_msk.index >= pll->reg_num)	||
+	    (ppll_config->nint_msk.index >= pll->reg_num)	||
+	    (ppll_config->kint_msk.index >= pll->reg_num)	||
+	    (ppll_config->prediv_msk.index >= pll->reg_num)) {
+		pr_err("%s: pll[%s] exceed max:%d\n", __func__,
+		       __clk_get_name(pll->hw.clk), pll->reg_num);
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* get field */
+#define gf(array, pll_struct) \
+	(array[pll_struct.index] & pll_struct.value)
+
+/* get field value */
+#define gfv(array, pll_struct) \
+	(gf(array, pll_struct) >> __ffs(pll_struct.value))
+
+static unsigned long pll_recalc_rate(struct sprd_pll_hw *pll,
+				     struct sprd_pll_config *ppll_config,
+				     unsigned long parent_rate)
+{
+	unsigned long rate, refin, k1, k2;
+	unsigned long kint = 0, nint, cfg[SPRD_PLL_MAX_REGNUM], n;
+	int i;
+	u32 value;
+
+	if (!ppll_config) {
+		pr_err("%s:%d Cannot get pll %s\n", __func__,
+			__LINE__, __clk_get_name(pll->hw.clk));
+		return parent_rate;
+	}
+
+	if (pll_check(pll, ppll_config))
+		return parent_rate;
+
+	for (i = 0; i < pll->reg_num; i++)
+		cfg[i] = readl_relaxed(pll->reg[i]);
+
+	refin = pll_get_refin_rate(pll, ppll_config);
+
+	if (gf(cfg, ppll_config->prediv_msk))
+		refin = refin * 2;
+
+	if (ppll_config->postdiv_msk.value &&
+	    (((ppll_config->postdiv_msk.fvco_threshold->flag == 1) &&
+	      gf(cfg, ppll_config->postdiv_msk)) ||
+	     ((ppll_config->postdiv_msk.fvco_threshold->flag == 0) &&
+	      !gf(cfg, ppll_config->postdiv_msk))))
+		refin = refin / 2;
+
+	if (!gf(cfg, ppll_config->div_s)) {
+		n = gfv(cfg, ppll_config->pll_n_msk);
+		rate = refin * n * 10000000;
+	} else {
+		nint = gfv(cfg, ppll_config->nint_msk);
+		if (gf(cfg, ppll_config->sdm_en))
+			kint = gfv(cfg, ppll_config->kint_msk);
+
+		value = ppll_config->kint_msk.value;
+#ifdef CONFIG_64BIT
+		k1 = 1000;
+		k2 = 1000;
+		i = 0;
+#else
+		k1 = 100;
+		k2 = 10000;
+		i = fls(value >> __ffs(value));
+		i = i < 20 ? 0 : i - 20;
+#endif
+		rate = DIV_ROUND_CLOSEST(refin * (kint >> i) * k1,
+					 ((value >> (__ffs(value) + i)) + 1)) *
+					 k2 + refin * nint * 1000000;
+	}
+
+	return rate;
+}
+
+static int pll_adjustable_set_rate(struct sprd_pll_hw *pll,
+				   struct sprd_pll_config *ppll_config,
+				   unsigned long rate,
+				   unsigned long parent_rate)
+{
+	u8 ibias, index;
+	u32 value;
+	unsigned long kint, nint;
+	unsigned long refin, val, fvco = rate;
+	struct reg_cfg cfg[SPRD_PLL_MAX_REGNUM] = {{},};
+	struct fvco_threshold *ft;
+	int i = 0;
+
+	if (ppll_config == NULL) {
+		pr_err("%s:%d Cannot get pll clk[%s]\n", __func__,
+			__LINE__, __clk_get_name(pll->hw.clk));
+		return -EINVAL;
+	}
+
+	if (pll_check(pll, ppll_config))
+		return -EINVAL;
+
+	/* calc the pll refin */
+	refin = pll_get_refin_rate(pll, ppll_config);
+
+	value = ppll_config->prediv_msk.value;
+	index = ppll_config->prediv_msk.index;
+	if (value) {
+		val = readl_relaxed(pll->reg[index]);
+		if (val & value)
+			refin = refin * 2;
+	}
+
+	value = ppll_config->postdiv_msk.value;
+	index = ppll_config->postdiv_msk.index;
+	ft = ppll_config->postdiv_msk.fvco_threshold;
+	cfg[index].msk = value;
+	if (value && ((ft->flag == 1 && fvco <= ft->rate) ||
+		      (ft->flag == 0 && fvco > ft->rate)))
+		cfg[index].val |= value;
+
+	if (fvco <= ft->rate)
+		fvco = fvco * 2;
+
+	value = ppll_config->div_s.value;
+	index = ppll_config->div_s.index;
+	cfg[index].val |= value;
+	cfg[index].msk |= value;
+
+	value = ppll_config->sdm_en.value;
+	index = ppll_config->sdm_en.index;
+	cfg[index].val |= value;
+	cfg[index].msk |= value;
+
+	nint  = fvco/(refin * 1000000);
+
+	value = ppll_config->nint_msk.value;
+	index = ppll_config->nint_msk.index;
+	cfg[index].val |= (nint << __ffs(value)) & value;
+	cfg[index].msk |= value;
+
+	value = ppll_config->kint_msk.value;
+	index = ppll_config->kint_msk.index;
+#ifndef CONFIG_64BIT
+	i = fls(value >> __ffs(value));
+	i = i < 20 ? 0 : i - 20;
+#endif
+	kint = DIV_ROUND_CLOSEST(((fvco - refin * nint * 1000000)/10000) *
+	((value >> (__ffs(value) + i)) + 1), refin * 100) << i;
+	cfg[index].val |= (kint << __ffs(value)) & value;
+	cfg[index].msk |= value;
+
+	ibias = pll_get_ibias(fvco, ppll_config->itable);
+	value = ppll_config->ibias_msk.value;
+	index = ppll_config->ibias_msk.index;
+	cfg[index].val |= ibias << __ffs(value) & value;
+	cfg[index].msk |= value;
+
+	for (i = 0; i < pll->reg_num; i++)
+		if (cfg[i].msk)
+			pll_write(pll->reg[i], cfg[i].val, cfg[i].msk);
+
+	udelay(ppll_config->udelay);
+
+	return 0;
+}
+
+static void pll_clk_setup(struct device_node *node,
+			  const struct clk_ops *clk_ops)
+{
+	struct clk *clk = NULL;
+	const char *parent_names;
+	struct sprd_pll_hw *pll;
+	int reg_num, index;
+	struct clk_init_data init = {
+		.ops = clk_ops,
+		.flags = CLK_IGNORE_UNUSED,
+		.num_parents = 1,
+	};
+
+	parent_names = of_clk_get_parent_name(node, 0);
+	if (!parent_names) {
+		pr_err("%s: Failed to get parent_names in node[%s]\n",
+			__func__, node->name);
+		return;
+	}
+	init.parent_names = &parent_names;
+
+	if (of_property_read_string(node, "clock-output-names", &init.name))
+		return;
+
+	pll = kzalloc(sizeof(struct sprd_pll_hw), GFP_KERNEL);
+	if (!pll)
+		return;
+
+	reg_num = of_property_count_u32_elems(node, "reg");
+	reg_num = reg_num / (of_n_addr_cells(node) + of_n_size_cells(node));
+	if (reg_num > SPRD_PLL_MAX_REGNUM) {
+		pr_err("%s: reg_num:%d exceed max number\n",
+		       __func__, reg_num);
+		goto kfree_pll;
+	}
+	pll->reg_num = reg_num;
+
+	for (index = 0; index < reg_num; index++) {
+		pll->reg[index] = of_iomap(node, index);
+		if (!pll->reg[index])
+			goto kfree_pll;
+	}
+
+	pll->hw.init = &init;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (!IS_ERR(clk)) {
+		clk_register_clkdev(clk, init.name, 0);
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return;
+	}
+
+kfree_pll:
+	kfree(pll);
+}
+
+static unsigned long sprd_adjustable_pll_recalc_rate(struct clk_hw *hw,
+						     unsigned long parent_rate)
+{
+	struct sprd_pll_config *ppll_config;
+	struct sprd_pll_hw *pll = to_sprd_pll_hw(hw);
+
+	ppll_config = pll_get_config(hw, g_sprd_pll_config);
+
+	return pll_recalc_rate(pll, ppll_config, parent_rate);
+}
+
+static int sprd_adjustable_pll_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct sprd_pll_config *ppll_config;
+	struct sprd_pll_hw *pll = to_sprd_pll_hw(hw);
+
+	ppll_config = pll_get_config(hw, g_sprd_pll_config);
+
+	return pll_adjustable_set_rate(pll, ppll_config, rate,
+					    parent_rate);
+}
+
+const struct clk_ops sprd_adjustable_pll_ops = {
+	.prepare = pll_clk_prepare,
+	.round_rate = pll_round_rate,
+	.set_rate = sprd_adjustable_pll_set_rate,
+	.recalc_rate = sprd_adjustable_pll_recalc_rate,
+};
+
+static void __init sc9836_adjustable_pll_setup(struct device_node *node)
+{
+	g_sprd_pll_config = sc9836_pll_config;
+	pll_clk_setup(node, &sprd_adjustable_pll_ops);
+}
+
+static void __init sc9860_adjustable_pll_setup(struct device_node *node)
+{
+	g_sprd_pll_config = sc9860_pll_config;
+	pll_clk_setup(node, &sprd_adjustable_pll_ops);
+}
+
+CLK_OF_DECLARE(sc9836_adjustable_pll_clock, "sprd,sc9836-adjustable-pll-clock",
+	       sc9836_adjustable_pll_setup);
+CLK_OF_DECLARE(sc9860_adjustable_pll_clock, "sprd,sc9860-adjustable-pll-clock",
+	       sc9860_adjustable_pll_setup);
diff --git a/drivers/clk/sprd/pll.h b/drivers/clk/sprd/pll.h
new file mode 100644
index 0000000..4b79092
--- /dev/null
+++ b/drivers/clk/sprd/pll.h
@@ -0,0 +1,73 @@
+/*
+ * Spreatrum clock pll driver head file
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef __SPRD_PLL_H__
+#define __SPRD_PLL_H__
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define SPRD_PLL_MAX_RATE	ULONG_MAX
+#define SPRD_PLL_MAX_REGNUM	(3)
+#define SPRD_DELAY_200		(200)
+#define SPRD_DELAY_1000		(1000)
+
+struct reg_cfg {
+	u32 val;
+	u32 msk;
+};
+
+struct pll_common {
+	u32 value;
+	u8  index;
+};
+
+struct fvco_threshold {
+	unsigned long rate;
+	int flag;
+};
+
+struct pll_div_mask {
+	u32 value;
+	u8  index;
+	struct fvco_threshold *fvco_threshold;
+};
+
+struct pll_ibias_table {
+	unsigned long rate;
+	u8 ibias;
+};
+
+struct sprd_pll_config {
+	char	*name;
+	u32		udelay;
+	struct pll_common	lock_done;
+	struct pll_common	div_s;
+	struct pll_common	mod_en;
+	struct pll_common	sdm_en;
+	struct pll_common	refin_msk;
+	struct pll_common	ibias_msk;
+	struct pll_common	pll_n_msk;
+	struct pll_common	nint_msk;
+	struct pll_common	kint_msk;
+	struct pll_div_mask	prediv_msk;
+	struct pll_div_mask	postdiv_msk;
+	struct pll_ibias_table	*itable;
+};
+
+struct sprd_pll_hw {
+	struct clk_hw	hw;
+	void __iomem	*reg[SPRD_PLL_MAX_REGNUM];
+	int		reg_num;
+};
+
+#define to_sprd_pll_hw(_hw) container_of(_hw, struct sprd_pll_hw, hw)
+
+#endif
diff --git a/drivers/clk/sprd/pll_cfg.h b/drivers/clk/sprd/pll_cfg.h
new file mode 100644
index 0000000..64e79f3
--- /dev/null
+++ b/drivers/clk/sprd/pll_cfg.h
@@ -0,0 +1,390 @@
+/*
+ * Spreatrum clock pll configurations
+ *
+ * Copyright (C) 2015~2017 Spreadtrum, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef __SPRD_PLL_CFG_H__
+#define __SPRD_PLL_CFG_H__
+
+#include "pll.h"
+
+static struct sprd_pll_config sc9836_pll_config[] = {
+	{
+		.name = "sc9836_pll",
+		.udelay = SPRD_DELAY_1000,
+		.lock_done.value = 1 << 27,
+		.lock_done.index = 0,
+		.div_s.value = 1 << 26,
+		.div_s.index = 0,
+		.mod_en.value = 1 << 25,
+		.mod_en.index = 0,
+		.sdm_en.value = 1 << 24,
+		.sdm_en.index = 0,
+		.refin_msk.value = 3 << 18,
+		.refin_msk.index = 0,
+		.ibias_msk.value = 3 << 16,
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7ff,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = 0x3f << 24,
+		.nint_msk.index = 1,
+		.kint_msk.value = 0xfffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0,
+		.prediv_msk.index = 0,
+		.postdiv_msk.value = 0x0,
+		.itable = NULL,
+	},
+
+	/* add configures above this */
+	{
+		.name = NULL,
+	}
+};
+
+/* GPLL/LPLL/DPLL/RPLL/CPLL */
+static struct pll_ibias_table sc9860_adjustable_pll1_table[] = {
+	{
+		.rate = 780000000,
+		.ibias = 0x0,
+	},
+	{
+		.rate = 988000000,
+		.ibias = 0x1,
+	},
+	{
+		.rate = 1196000000,
+		.ibias = 0x2,
+	},
+
+	/* add items above this */
+	{
+		.rate = SPRD_PLL_MAX_RATE,
+		.ibias = 0x2,
+	},
+};
+
+/* TWPLL/MPLL0/MPLL1 */
+static struct pll_ibias_table sc9860_adjustable_pll2_table[] = {
+	{
+		.rate = 1638000000,
+		.ibias = 0x0,
+	},
+	{
+		.rate = 2080000000,
+		.ibias = 0x1,
+	},
+	{
+		.rate = 2600000000UL,
+		.ibias = 0x2,
+	},
+
+	/* add items above this */
+	{
+		.rate = SPRD_PLL_MAX_RATE,
+		.ibias = 0x2,
+	},
+};
+
+static struct fvco_threshold sc9860_mpll0_threshold = {
+	.rate = 1300000000,
+	.flag = 1,
+};
+
+static struct fvco_threshold sc9860_gpll_threshold = {
+	.rate = 600000000,
+	.flag = 1,
+};
+
+static struct sprd_pll_config sc9860_pll_config[] = {
+	{
+		.name  = "clk_mpll0",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 20),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 19),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 18),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 17),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 11),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = (0x7f),
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = (1 << 24),
+		.postdiv_msk.index = 1,
+		.postdiv_msk.fvco_threshold = &sc9860_mpll0_threshold,
+		.itable = sc9860_adjustable_pll2_table,
+	},
+	{
+		.name  = "clk_mpll1",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 20),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 19),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 18),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 17),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 11),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7f,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = (1 << 24),
+		.prediv_msk.index = 1,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll2_table,
+	},
+	{
+		.name  = "clk_gpll",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 18),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 15),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 14),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 13),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 8),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7f,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.fvco_threshold = &sc9860_gpll_threshold,
+		.postdiv_msk.value = (1 << 17),
+		.postdiv_msk.index = 0,
+		.itable = sc9860_adjustable_pll1_table,
+	},
+	{
+		.name  = "clk_dpll0",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 16),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 15),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 14),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 13),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 8),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7f,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll1_table,
+	},
+	{
+		.name  = "clk_dpll1",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 16),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 15),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 14),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 13),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 8),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7f,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll1_table,
+	},
+	{
+		.name  = "clk_twpll",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 21),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 20),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 19),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 18),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 13),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7f,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll2_table,
+	},
+	{
+		.name  = "clk_ltepll0",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 31),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 27),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 26),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 25),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 20),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7f,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll1_table,
+	},
+	{
+		.name  = "clk_ltepll1",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 31),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 27),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 26),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 25),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 20),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7f,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll1_table,
+	},
+	{
+		.name  = "clk_cppll",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 17),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 15),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 14),
+		.mod_en.index = 0,
+		.sdm_en.value = (1 << 13),
+		.sdm_en.index = 0,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 8),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = 0x7f,
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 25),
+		.nint_msk.index = 1,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll1_table,
+	},
+	{
+	/* rpll register bit is different from other plls. */
+		.name  = "clk_rpll0",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 0),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 3),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 16),
+		.mod_en.index = 2,
+		.sdm_en.value = (1 << 17),
+		.sdm_en.index = 2,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 14),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = (0x7f << 16),
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 4),
+		.nint_msk.index = 0,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll1_table,
+	},
+	{
+		.name  = "clk_rpll1",
+		.udelay = SPRD_DELAY_200,
+		.lock_done.value = (1 << 0),
+		.lock_done.index = 0,
+		.div_s.value = (1 << 3),
+		.div_s.index = 0,
+		.mod_en.value = (1 << 16),
+		.mod_en.index = 2,
+		.sdm_en.value = (1 << 17),
+		.sdm_en.index = 2,
+		.refin_msk.value = 0,
+		.refin_msk.index = 0,
+		.ibias_msk.value = (3 << 14),
+		.ibias_msk.index = 0,
+		.pll_n_msk.value = (0x7f << 16),
+		.pll_n_msk.index = 0,
+		.nint_msk.value = (0x7f << 4),
+		.nint_msk.index = 0,
+		.kint_msk.value = 0x7fffff,
+		.kint_msk.index = 1,
+		.prediv_msk.value = 0x0,
+		.postdiv_msk.value = 0x0,
+		.itable = sc9860_adjustable_pll1_table,
+	},
+
+	/* add configures above this */
+	{
+		.name = NULL,
+	}
+};
+#endif
-- 
2.7.4
