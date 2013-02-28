From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 28 Feb 2013 15:19:21 +0800
Subject: [PATCH 2/7] clk: hs: add clock support
In-Reply-To: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
References: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1362035966-17628-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock support with device tree on Hisilicon SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/clk/Makefile |    1 +
 drivers/clk/clk-hs.c |  463 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 464 insertions(+)
 create mode 100644 drivers/clk/clk-hs.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 300d477..2d3a08d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
 obj-$(CONFIG_ARCH_NOMADIK)	+= clk-nomadik.o
 obj-$(CONFIG_ARCH_HIGHBANK)	+= clk-highbank.o
+obj-$(CONFIG_ARCH_HS)		+= clk-hs.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
 obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
diff --git a/drivers/clk/clk-hs.c b/drivers/clk/clk-hs.c
new file mode 100644
index 0000000..e802bf4
--- /dev/null
+++ b/drivers/clk/clk-hs.c
@@ -0,0 +1,463 @@
+/*
+ * Hisilicon clock driver
+ *
+ * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *	   Xin Li <li.xin@linaro.org>
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
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/clk-private.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#define HI3620_DISABLE_OFF		0x4
+#define HI3620_STATUS_OFF		0x8
+
+struct hi3620_periclk {
+	struct clk_hw	hw;
+	void __iomem	*enable;	/* enable register */
+	void __iomem	*reset;		/* reset register */
+	u32		ebits;		/* bits in enable/disable register */
+	u32		rbits;		/* bits in reset/unreset register */
+	spinlock_t	*lock;
+};
+
+struct hi3620_muxclk {
+	struct clk_hw	hw;
+	void __iomem	*reg;		/* mux register */
+	u8		shift;
+	u8		width;
+	u32		ebits;		/* enable bits in mux register */
+	u32		mbits;		/* mask bits in mux register */
+	spinlock_t	*lock;
+};
+
+struct hs_clk {
+	void __iomem	*pmctrl;
+	void __iomem	*sctrl;
+	spinlock_t	lock;
+};
+
+static struct hs_clk hs_clk;
+
+static int hi3620_clkgate_prepare(struct clk_hw *hw)
+{
+	struct hi3620_periclk *pclk;
+	unsigned long flags = 0;
+
+	pclk = container_of(hw, struct hi3620_periclk, hw);
+
+	if (pclk->lock)
+		spin_lock_irqsave(pclk->lock, flags);
+	writel_relaxed(pclk->ebits, pclk->enable + HI3620_DISABLE_OFF);
+	writel_relaxed(pclk->rbits, pclk->reset + HI3620_DISABLE_OFF);
+	readl_relaxed(pclk->reset + HI3620_STATUS_OFF);
+	if (pclk->lock)
+		spin_unlock_irqrestore(pclk->lock, flags);
+	return 0;
+}
+
+static int hi3620_clkgate_enable(struct clk_hw *hw)
+{
+	struct hi3620_periclk *pclk;
+	unsigned long flags = 0;
+
+	pclk = container_of(hw, struct hi3620_periclk, hw);
+	if (pclk->lock)
+		spin_lock_irqsave(pclk->lock, flags);
+	writel_relaxed(pclk->ebits, pclk->enable);
+	readl_relaxed(pclk->enable + HI3620_STATUS_OFF);
+	if (pclk->lock)
+		spin_unlock_irqrestore(pclk->lock, flags);
+	return 0;
+}
+
+static void hi3620_clkgate_disable(struct clk_hw *hw)
+{
+	struct hi3620_periclk *pclk;
+	unsigned long flags = 0;
+
+	pclk = container_of(hw, struct hi3620_periclk, hw);
+	if (pclk->lock)
+		spin_lock_irqsave(pclk->lock, flags);
+	writel_relaxed(pclk->ebits, pclk->enable + HI3620_DISABLE_OFF);
+	readl_relaxed(pclk->enable + HI3620_STATUS_OFF);
+	if (pclk->lock)
+		spin_unlock_irqrestore(pclk->lock, flags);
+}
+
+static struct clk_ops hi3620_clkgate_ops = {
+	.prepare	= hi3620_clkgate_prepare,
+	.enable		= hi3620_clkgate_enable,
+	.disable	= hi3620_clkgate_disable,
+};
+
+static void __init hi3620_clkgate_setup(struct device_node *np)
+{
+	struct hi3620_periclk *pclk;
+	struct clk_init_data *init;
+	struct clk *clk;
+	const char *clk_name, *name, **parent_names;
+	u32 rdata[2], gdata[2];
+
+	if (!hs_clk.sctrl)
+		return;
+
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+	if (of_property_read_u32_array(np, "hisilicon,hi3620-clkreset",
+				       &rdata[0], 2))
+		return;
+	if (of_property_read_u32_array(np, "hisilicon,hi3620-clkgate",
+				       &gdata[0], 2))
+		return;
+	if (rdata[1] >= 32 || gdata[1] >= 32)
+		return;
+
+	/* gate only has the fixed parent */
+	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		return;
+	parent_names[0] = of_clk_get_parent_name(np, 0);
+
+	pclk = kzalloc(sizeof(*pclk), GFP_KERNEL);
+	if (!pclk)
+		goto err;
+
+	init = kzalloc(sizeof(*init), GFP_KERNEL);
+	if (!init)
+		goto err_pclk;
+	init->name = kstrdup(clk_name, GFP_KERNEL);
+	init->ops = &hi3620_clkgate_ops;
+	init->flags = CLK_SET_RATE_PARENT;
+	init->parent_names = parent_names;
+	init->num_parents = 1;
+
+	pclk->reset = hs_clk.sctrl + rdata[0];
+	pclk->rbits = 1 << rdata[1];
+	pclk->enable = hs_clk.sctrl + gdata[0];
+	pclk->ebits = 1 << gdata[1];
+	pclk->lock = &hs_clk.lock;
+	pclk->hw.init = init;
+
+	clk = clk_register(NULL, &pclk->hw);
+	if (IS_ERR(clk))
+		goto err_init;
+	if (!of_property_read_string(np, "clock-names", &name))
+		clk_register_clkdev(clk, name, NULL);
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+err_init:
+	kfree(init);
+err_pclk:
+	kfree(pclk);
+err:
+	kfree(parent_names);
+}
+
+static u8 hi3620_clk_get_parent(struct clk_hw *hw)
+{
+	struct hi3620_muxclk *mclk;
+	u32 data;
+	unsigned long flags = 0;
+
+	mclk = container_of(hw, struct hi3620_muxclk, hw);
+
+	if (mclk->lock)
+		spin_lock_irqsave(mclk->lock, flags);
+
+	data = readl_relaxed(mclk->reg) >> mclk->shift;
+	data &= (1 << mclk->width) - 1;
+
+	if (mclk->lock)
+		spin_unlock_irqrestore(mclk->lock, flags);
+
+	if (data >= __clk_get_num_parents(hw->clk))
+		return -EINVAL;
+
+	return (u8)data;
+}
+
+static int hi3620_clk_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct hi3620_muxclk *mclk;
+	u32 data;
+	unsigned long flags = 0;
+
+	mclk = container_of(hw, struct hi3620_muxclk, hw);
+
+	if (mclk->lock)
+		spin_lock_irqsave(mclk->lock, flags);
+
+	data = readl_relaxed(mclk->reg);
+	data &= ~(((1 << mclk->width) - 1) << mclk->shift);
+	data |= index << mclk->shift;
+	writel_relaxed(data, mclk->reg);
+	/* set mask enable bits */
+	data |= mclk->mbits;
+	writel_relaxed(data, mclk->reg);
+
+	if (mclk->lock)
+		spin_unlock_irqrestore(mclk->lock, flags);
+
+	return 0;
+}
+
+static struct clk_ops hi3620_clkmux_ops = {
+	.get_parent	= hi3620_clk_get_parent,
+	.set_parent	= hi3620_clk_set_parent,
+};
+
+static void __init hi3620_clkmux_setup(struct device_node *np)
+{
+	struct hi3620_muxclk *mclk;
+	struct clk_init_data *init;
+	struct clk *clk;
+	const char *clk_name, **parent_names;
+	u32 rdata[2];
+	u8 num_parents;
+	int i;
+
+	if (!hs_clk.sctrl)
+		return;
+
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+	if (of_property_read_u32_array(np, "hisilicon,hi3620-clkmux",
+				       &rdata[0], 2))
+		return;
+	/* get the count of items in mux */
+	for (i = 0; ; i++) {
+		/* parent's #clock-cells property is always 0 */
+		if (!of_parse_phandle(np, "clocks", i))
+			break;
+	}
+	parent_names = kzalloc(sizeof(char *) * i, GFP_KERNEL);
+	if (!parent_names)
+		return;
+
+	for (num_parents = i, i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(np, i);
+
+	mclk = kzalloc(sizeof(*mclk), GFP_KERNEL);
+	if (!mclk)
+		goto err;
+	init = kzalloc(sizeof(*init), GFP_KERNEL);
+	if (!init)
+		goto err_init;
+	init->name = kstrdup(clk_name, GFP_KERNEL);
+	init->ops = &hi3620_clkmux_ops;
+	init->flags = CLK_SET_RATE_PARENT;
+	init->parent_names = parent_names;
+	init->num_parents = num_parents;
+
+	mclk->reg = hs_clk.sctrl + rdata[0];
+	/* enable_mask bits are in higher 16bits */
+	mclk->mbits = rdata[1] << 16;
+	mclk->shift = ffs(rdata[1]) - 1;
+	mclk->width = fls(rdata[1]) - ffs(rdata[1]) + 1;
+	mclk->lock = &hs_clk.lock;
+	mclk->hw.init = init;
+
+	clk = clk_register(NULL, &mclk->hw);
+	if (IS_ERR(clk))
+		goto err_clk;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+
+	return;
+err_clk:
+	kfree(init);
+err_init:
+	kfree(mclk);
+err:
+	kfree(parent_names);
+}
+
+static void __init hs_clkgate_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, **parent_names, *name;
+	unsigned long flags = 0;
+	u32 data[2];
+
+	if (!hs_clk.sctrl)
+		return;
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+	if (of_property_read_u32_array(np, "hisilicon,clkgate",
+				       &data[0], 2))
+		return;
+	if (of_property_read_bool(np, "hisilicon,clkgate-inverted"))
+		flags = CLK_GATE_SET_TO_DISABLE;
+	/* gate only has the fixed parent */
+	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		return;
+	parent_names[0] = of_clk_get_parent_name(np, 0);
+
+	clk = clk_register_gate(NULL, clk_name, parent_names[0], CLK_IS_BASIC,
+				hs_clk.sctrl + data[0], (u8)data[1], flags,
+				&hs_clk.lock);
+	if (IS_ERR(clk))
+		goto err;
+	if (!of_property_read_string(np, "clock-names", &name))
+		clk_register_clkdev(clk, name, NULL);
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+err:
+	kfree(parent_names);
+}
+
+void __init hs_fixed_factor_clk_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, **parent_names;
+	u32 data[2];
+
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+	if (of_property_read_u32_array(np, "hisilicon,fixed-factor",
+				       data, 2))
+		return ;
+	/* gate only has the fixed parent */
+	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		return;
+	parent_names[0] = of_clk_get_parent_name(np, 0);
+
+	clk = clk_register_fixed_factor(NULL, clk_name, parent_names[0],
+					CLK_IS_BASIC, data[0], data[1]);
+	if (IS_ERR(clk))
+		goto err;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+err:
+	kfree(parent_names);
+}
+
+void __init hs_divider_clk_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, **parent_names;
+	struct clk_div_table *table;
+	u8 shift, width;
+	unsigned int table_num;
+	int i;
+	u32 data[2];
+	const char *propname = "hisilicon,clkdiv-table";
+	const char *cellname = "#hisilicon,clkdiv-table-cells";
+	struct of_phandle_args div_table;
+
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		return;
+	if (of_property_read_u32_array(np, "hisilicon,clkdiv",
+				       &data[0], 2))
+		return;
+
+	/*process the div_table*/
+	for (i = 0; ; i++) {
+		if (of_parse_phandle_with_args(np, propname, cellname,
+					       i, &div_table))
+			break;
+	}
+
+	/*table ends with <0, 0>, so plus one to table_num*/
+	table_num = i + 1;
+
+	table = kzalloc(sizeof(struct clk_div_table) * table_num, GFP_KERNEL);
+	if (!table)
+		return ;
+
+	for (i = 0; ; i++) {
+		if (of_parse_phandle_with_args(np, propname, cellname,
+					       i, &div_table))
+			break;
+
+		table[i].val = div_table.args[0];
+		table[i].div = div_table.args[1];
+	}
+
+	shift = ffs(data[1]) - 1;
+	width = fls(data[1]) - ffs(data[1]) + 1;
+
+	/* gate only has the fixed parent */
+	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		goto err;
+	parent_names[0] = of_clk_get_parent_name(np, 0);
+
+	clk = clk_register_divider_table(NULL, clk_name, parent_names[0],
+					 CLK_IS_BASIC, hs_clk.sctrl + data[0],
+					 shift, width, 0,
+					 table, &hs_clk.lock);
+	if (IS_ERR(clk))
+		goto err_par;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+err_par:
+	kfree(parent_names);
+err:
+	kfree(table);
+}
+
+static const __initconst struct of_device_id hs_clk_match[] = {
+	{
+		.compatible = "fixed-clock",
+		.data = of_fixed_clk_setup,
+	}, {
+		.compatible = "hisilicon,hi3620-clk-mux",
+		.data = hi3620_clkmux_setup,
+	}, {
+		.compatible = "hisilicon,hi3620-clk-gate",
+		.data = hi3620_clkgate_setup,
+	}, {
+		.compatible = "hisilicon,clk-gate",
+		.data = hs_clkgate_setup,
+	}, {
+		.compatible = "hisilicon,clk-div-table",
+		.data = hs_divider_clk_setup,
+	}, {
+		.compatible = "hisilicon,clk-fixed-factor",
+		.data = hs_fixed_factor_clk_setup,
+	},
+};
+
+void __init hs_init_clocks(void)
+{
+	struct device_node *node;
+
+	/*map pmctrl registers*/
+	node = of_find_compatible_node(NULL, NULL, "hisilicon,pmctrl");
+	hs_clk.pmctrl = of_iomap(node, 0);
+	WARN_ON(!hs_clk.pmctrl);
+
+	node = of_find_compatible_node(NULL, NULL, "hisilicon,sctrl");
+	hs_clk.sctrl = of_iomap(node, 0);
+
+	of_clk_init(hs_clk_match);
+}
-- 
1.7.10.4
