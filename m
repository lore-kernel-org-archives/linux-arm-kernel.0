From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 20 Aug 2013 10:31:12 +0800
Subject: [PATCH v7 10/11] ARM: hi3xxx: add clk-hi3716
In-Reply-To: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
References: <1376965873-14431-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1376965873-14431-11-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Zhang Mingjun <zhang.mingjun@linaro.org>
---
 Documentation/devicetree/bindings/clock/hi3716.txt | 121 ++++++++++
 drivers/clk/Makefile                               |   2 +-
 drivers/clk/clk-hi3716.c                           | 268 +++++++++++++++++++++
 3 files changed, 390 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3716.txt
 create mode 100644 drivers/clk/clk-hi3716.c

diff --git a/Documentation/devicetree/bindings/clock/hi3716.txt b/Documentation/devicetree/bindings/clock/hi3716.txt
new file mode 100644
index 0000000..60af61e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hi3716.txt
@@ -0,0 +1,121 @@
+Device Tree Clock bindings for hi3716
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Clock control register
+Required properties:
+- compatible : "hisilicon,clkbase"
+- reg : Address and size of clkbase.
+
+Device Clocks
+
+Device clocks are required to have one or both of the following sets of
+properties:
+
+
+Gated device clocks:
+
+Required properties:
+- compatible : "hisilicon,hi3716-clk-gate"
+- gate-reg : shall be the register offset from clkbase and enable bit, reset bit
+- clock-output-names : shall be reference name
+
+
+Mux device clocks:
+
+Required properties:
+- compatible : "hisilicon,hi3716-clk-mux"
+- mux-reg : shall be the register offset from clkbase and mux_shift mux_width
+- mux-table : shall be reg value to be choose clocks accordingly
+- clock-output-names : shall be reference name
+
+
+Fixed divisor device clocks:
+
+Required properties:
+- compatible : "hisilicon,hi3716-fixed-divider"
+- div-table : shall be divisor sequence
+- clock-output-names : shall be reference name according to divisor
+
+
+Fixed pll clocks:
+
+Required properties:
+- compatible : "hisilicon,hi3716-fixed-pll"
+- clock-frequency : shall be output clock frequence sequence
+- clock-output-names : shall be reference name according to clock-frequnce
+
+For example:
+	clkbase at f8a22000 {
+		compatible = "hisilicon,clkbase";
+		reg = <0xf8a22000 0x1000>;
+	};
+
+	osc24m: osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "osc24mhz";
+	};
+
+	bpll: bpll {
+		compatible = "hisilicon,hi3716-fixed-pll";
+		#clock-cells = <1>;
+		clocks = <&osc24m>;
+		clock-frequency = <1200000000>,
+				  <600000000>,
+				  <300000000>,
+				  <200000000>,
+				  <150000000>;
+		clock-output-names = "bpll_fout0",
+				     "bpll_fout1",
+				     "bpll_fout2",
+				     "bpll_fout3",
+				     "bpll_fout4";
+	};
+
+	bpll_fout0_div: bpll_fout0_div {/* 1200Mhz */
+		compatible = "hisilicon,hi3716-fixed-divider";
+		#clock-cells = <1>;
+		clocks = <&bpll 0>;
+		div-table = <3 14 25 50>;
+		clock-output-names = "fout0_400m", "fout0_86m",
+					"fout0_48m", "fout0_24m";
+	};
+
+	bpll_fout3_div: bpll_fout3_div {
+		compatible = "hisilicon,hi3716-fixed-divider";
+		#clock-cells = <1>;
+		clocks = <&bpll 3>;
+		div-table = <2 4 5 8>;
+		clock-output-names = "fout3_100m", "fout3_50m",
+					"fout3_40m", "fout3_25m";
+	};
+
+	clk_sfc_mux: clk_sfc_mux {
+		compatible = "hisilicon,hi3716-clk-mux";
+		#clock-cells = <0>;
+		/* clks: 24M 75M 100M 150M 200M */
+		clocks = <&osc24m>, <&bpll_fout2_div>,
+		       <&bpll_fout3_div 0>, <&bpll 4>, <&bpll 3>;
+
+		/* offset mux_shift mux_width */
+		mux-reg = <0x5c 8 3>;
+		/* mux reg value to choose clks */
+		mux-table = <0 7 6 4 5>;
+
+		clock-output-names = "sfc_mux";
+	};
+
+	clk_sfc: clk_sfc {
+		compatible = "hisilicon,hi3716-clk-gate";
+		#clock-cells = <0>;
+		clocks = <&clk_sfc_mux>;
+
+		/* offset, enable, reset */
+		gate-reg = <0x5c 0 4>;
+
+		clock-output-names = "sfc";
+	};
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 2451ce6..b652b3d 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 # SoCs specific
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
 obj-$(CONFIG_ARCH_NOMADIK)	+= clk-nomadik.o
-obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3xxx.o
+obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3xxx.o clk-hi3716.o
 obj-$(CONFIG_ARCH_HIGHBANK)	+= clk-highbank.o
 obj-$(CONFIG_ARCH_NSPIRE)	+= clk-nspire.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
diff --git a/drivers/clk/clk-hi3716.c b/drivers/clk/clk-hi3716.c
new file mode 100644
index 0000000..887ffe9
--- /dev/null
+++ b/drivers/clk/clk-hi3716.c
@@ -0,0 +1,268 @@
+/*
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2013 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+static DEFINE_SPINLOCK(_lock);
+
+static void __iomem *clk_base;
+
+struct hi3716_clk {
+	struct		clk_gate gate;
+	void __iomem	*reg;
+	u8		reset_bit;
+};
+
+#define MAX_NUMS	10
+
+static struct hi3716_clk *to_clk_hi3716(struct clk_hw *hw)
+{
+	return container_of(hw, struct hi3716_clk, gate.hw);
+}
+
+static void __init hi3716_map_io(void)
+{
+	struct device_node *node;
+
+	if (clk_base)
+		return;
+
+	node = of_find_compatible_node(NULL, NULL, "hisilicon,clkbase");
+	if (node)
+		clk_base = of_iomap(node, 0);
+	WARN_ON(!clk_base);
+}
+
+static int hi3716_clkgate_prepare(struct clk_hw *hw)
+{
+	struct hi3716_clk *clk = to_clk_hi3716(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(&_lock, flags);
+
+	reg = readl_relaxed(clk->reg);
+	reg &= ~BIT(clk->reset_bit);
+	writel_relaxed(reg, clk->reg);
+
+	spin_unlock_irqrestore(&_lock, flags);
+
+	return 0;
+}
+
+static void hi3716_clkgate_unprepare(struct clk_hw *hw)
+{
+	struct hi3716_clk *clk = to_clk_hi3716(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(&_lock, flags);
+
+	reg = readl_relaxed(clk->reg);
+	reg |= BIT(clk->reset_bit);
+	writel_relaxed(reg, clk->reg);
+
+	spin_unlock_irqrestore(&_lock, flags);
+}
+
+static struct clk_ops hi3716_clkgate_ops = {
+	.prepare	= hi3716_clkgate_prepare,
+	.unprepare	= hi3716_clkgate_unprepare,
+};
+
+void __init hi3716_clkgate_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct hi3716_clk *p_clk;
+	struct clk_init_data init;
+	const char *parent_name;
+	u32 array[3];	/* reg, enable_bit, reset_bit */
+	int err;
+
+	hi3716_map_io();
+	err = of_property_read_u32_array(node, "gate-reg", &array[0], 3);
+	if (WARN_ON(err))
+		return;
+
+	err = of_property_read_string(node, "clock-output-names", &init.name);
+	if (WARN_ON(err))
+		return;
+
+	p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
+	if (WARN_ON(!p_clk))
+		return;
+
+	hi3716_clkgate_ops.enable = clk_gate_ops.enable;
+	hi3716_clkgate_ops.disable = clk_gate_ops.disable;
+	hi3716_clkgate_ops.is_enabled = clk_gate_ops.is_enabled;
+
+	init.ops = &hi3716_clkgate_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	parent_name = of_clk_get_parent_name(node, 0);
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	p_clk->reg = p_clk->gate.reg = clk_base + array[0];
+	p_clk->gate.bit_idx = array[1];
+	p_clk->gate.flags = 0;
+	p_clk->gate.lock = &_lock;
+	p_clk->gate.hw.init = &init;
+	p_clk->reset_bit = array[2];
+
+	clk = clk_register(NULL, &p_clk->gate.hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(p_clk);
+		return;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+
+static void __init hi3716_clkmux_setup(struct device_node *node)
+{
+	int num = 0, err;
+	void __iomem *reg;
+	unsigned int shift, width;
+	u32 array[3];	/* reg, mux_shift, mux_width */
+	u32 *table = NULL;
+	const char *clk_name = node->name;
+	const char *parents[MAX_NUMS];
+	struct clk *clk;
+
+	hi3716_map_io();
+	err = of_property_read_string(node, "clock-output-names", &clk_name);
+	if (WARN_ON(err))
+		return;
+
+	err = of_property_read_u32_array(node, "mux-reg", &array[0], 3);
+	if (WARN_ON(err))
+		return;
+
+	reg = clk_base + array[0];
+	shift = array[1];
+	width = array[2];
+
+	while ((num < MAX_NUMS) &&
+		((parents[num] = of_clk_get_parent_name(node, num)) != NULL))
+		num++;
+	if (!num)
+		return;
+
+	table = kzalloc(sizeof(u32 *) * num, GFP_KERNEL);
+	if (WARN_ON(!table))
+		return;
+
+	err = of_property_read_u32_array(node, "mux-table", table, num);
+	if (WARN_ON(err))
+		goto err;
+
+	clk = clk_register_mux_table(NULL, clk_name, parents, num,
+			CLK_SET_RATE_PARENT, reg, shift, BIT(width) - 1,
+			0, table, &_lock);
+	if (WARN_ON(IS_ERR(clk)))
+		goto err;
+
+	clk_register_clkdev(clk, clk_name, NULL);
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return;
+
+err:
+	kfree(table);
+	return;
+}
+
+static void __init hi3716_fixed_pll_setup(struct device_node *node)
+{
+	const char *clk_name, *parent_name;
+	struct clk *clks[MAX_NUMS];
+	u32 rate[MAX_NUMS];
+	struct clk_onecell_data *clk_data;
+	int i, err, nums = 0;
+
+	nums = of_property_count_strings(node, "clock-output-names");
+	if (WARN_ON((nums < 0) || (nums > MAX_NUMS)))
+		return;
+
+	err = of_property_read_u32_array(node, "clock-frequency",
+						&rate[0], nums);
+	WARN_ON(err);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	for (i = 0; i < nums; i++) {
+		err = of_property_read_string_index(node, "clock-output-names",
+				i, &clk_name);
+		WARN_ON(err);
+
+		clks[i] = clk_register_fixed_rate(NULL, clk_name,
+					parent_name, 0, rate[i]);
+		WARN_ON(IS_ERR(clks[i]));
+	}
+
+	clk_data = kzalloc(sizeof(*clk_data) + nums * sizeof(struct clk *),
+			GFP_KERNEL);
+	if (WARN_ON(!clk_data))
+		return;
+
+	memcpy(&clk_data[1], clks, nums * sizeof(struct clk *));
+	clk_data->clks = (struct clk **)&clk_data[1];
+	clk_data->clk_num = nums;
+	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+void __init hi3716_fixed_divider_setup(struct device_node *node)
+{
+	const char *clk_parent;
+	const char *clk_name;
+	u32 div[MAX_NUMS];
+	struct clk *clks[MAX_NUMS];
+	struct clk_onecell_data *clk_data;
+	int err, i, nums = 0;
+
+	clk_parent = of_clk_get_parent_name(node, 0);
+
+	nums = of_property_count_strings(node, "clock-output-names");
+	if (WARN_ON((nums < 0) || (nums > MAX_NUMS)))
+		return;
+
+	err = of_property_read_u32_array(node, "div-table", &div[0], nums);
+	WARN_ON(err);
+
+	for (i = 0; i < nums; i++) {
+		err = of_property_read_string_index(node,
+				"clock-output-names", i, &clk_name);
+		WARN_ON(err);
+
+		clks[i] = clk_register_fixed_factor(NULL, clk_name,
+				clk_parent, CLK_SET_RATE_PARENT, 1, div[i]);
+		WARN_ON(IS_ERR(clks[i]));
+	}
+
+	clk_data = kzalloc(sizeof(*clk_data) + nums * sizeof(struct clk *),
+			GFP_KERNEL);
+	if (WARN_ON(!clk_data))
+		return;
+
+	memcpy(&clk_data[1], clks, nums * sizeof(struct clk *));
+	clk_data->clks = (struct clk **)&clk_data[1];
+	clk_data->clk_num = nums;
+	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+CLK_OF_DECLARE(hi3716_fixed_rate, "fixed-clock", of_fixed_clk_setup)
+CLK_OF_DECLARE(hi3716_fixed_pll, "hisilicon,hi3716-fixed-pll", hi3716_fixed_pll_setup)
+CLK_OF_DECLARE(hi3716_divider, "hisilicon,hi3716-fixed-divider", hi3716_fixed_divider_setup)
+CLK_OF_DECLARE(hi3716_mux, "hisilicon,hi3716-clk-mux", hi3716_clkmux_setup)
+CLK_OF_DECLARE(hi3716_gate, "hisilicon,hi3716-clk-gate", hi3716_clkgate_setup)
-- 
1.8.1.2
