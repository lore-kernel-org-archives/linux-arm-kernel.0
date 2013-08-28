From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 28 Aug 2013 21:10:48 +0800
Subject: [PATCH v9 1/7] clk: hi3xxx: add clock support
In-Reply-To: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
References: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1377695454-29109-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock support with device tree on Hisilicon SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
---
 .../devicetree/bindings/clock/hisilicon.txt        | 118 +++++++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/hisilicon/Makefile                     |   2 +
 drivers/clk/hisilicon/clk-hi3xxx.c                 | 272 +++++++++++++++++++++
 drivers/clk/hisilicon/clk-hi3xxx.h                 |  34 +++
 drivers/clk/hisilicon/clkgate-seperated.c          | 129 ++++++++++
 6 files changed, 556 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hisilicon.txt
 create mode 100644 drivers/clk/hisilicon/Makefile
 create mode 100644 drivers/clk/hisilicon/clk-hi3xxx.c
 create mode 100644 drivers/clk/hisilicon/clk-hi3xxx.h
 create mode 100644 drivers/clk/hisilicon/clkgate-seperated.c

diff --git a/Documentation/devicetree/bindings/clock/hisilicon.txt b/Documentation/devicetree/bindings/clock/hisilicon.txt
new file mode 100644
index 0000000..2c42062
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hisilicon.txt
@@ -0,0 +1,118 @@
+Device Tree Clock bindings for arch-hi3xxx
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+All the mux, gate & divider are in clock container of DTS file.
+
+Required properties for mux clocks:
+ - compatible : shall be "hisilicon,clk-mux".
+ - clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+ - clock-output-names : shall be reference name.
+ - #clock-cells : from common clock binding; shall be set to 0.
+ - reg : the mux register address. It should be the offset of the container.
+ - clkmux-mask : mask bits of the mux register.
+ - clkmux-table : array of mux select bits.
+
+Optional properties for mux clocks:
+ - clkmux-hiword-mask : indicates that the bit[31:16] are the hiword mask
+	of mux selected bits (bit[15:0]). The bit[15:0] is valid only when
+	bit[31:16] is set.
+
+
+
+Required properties for gate clocks:
+ - compatible : shall be "hisilicon,clk-gate".
+ - clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+ - clock-output-names : shall be reference name.
+ - #clock-cells : from common clock binding; shall be set to 0.
+ - reg : the mux register address. It should be the offset of the container.
+ - clkgate : bit index to control the clock gate in the gate register.
+
+Optional properties for gate clocks:
+ - clkgate-inverted : it indicates that setting 0 could enable the clock gate
+	and setting 1 could disable the clock gate.
+ - clkgate-seperated-reg : it indicates that there're three continuous
+	registers (enable, disable & status) for the same clock gate.
+
+
+
+Required properties for divider clocks:
+ - compatible : shall be "hisilicon,clk-div".
+ - clocks : shall be the input parent clock phandle for the clock. This should
+	be the reference clock.
+ - clock-output-names : shall be reference name.
+ - reg : the divider register address. It should be the offset of the
+	container.
+ - clkdiv-mask : mask bits of the divider register.
+ - clkdiv-min : the minimum divider of the clock divider.
+ - clkdiv-max : the maximum divider of the clock divider.
+
+Optional properties for divider clocks:
+ - clkdiv-hiword-mask : indicates that the bit[31:16] are the hiword mask
+	of divider selected bits (bit[15:0]). The bit[15:0] is valid only when
+	bit[31:16] is set.
+
+
+
+For example:
+	sysctrl: system-controller at fc802000 {
+		compatible = "hisilicon,sysctrl";
+		reg = <0xfc802000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+
+		timer0_mux: timer0_mux {
+			compatible = "hisilicon,clk-mux";
+			#clock-cells = <0>;
+			clocks = <&osc32k &timerclk01>;
+			clock-output-names = "timer0_mux";
+			reg = <0>;
+			clkmux-mask = <0x8000>;
+			clkmux-table = <0 0x8000>;
+		};
+		uart0_mux: uart0_mux {
+			compatible = "hisilicon,clk-mux";
+			#clock-cells = <0>;
+			clocks = <&osc26m &pclk>;
+			clock-output-names = "uart0_mux";
+			reg = <0x100>;
+			clkmux-mask = <0x80>;
+			/* each item value */
+			clkmux-table = <0 0x80>;
+			clkmux-hiword-mask;
+		};
+		timclk0: timclk0 {
+			compatible = "hisilicon,clk-gate";
+			#clock-cells = <0>;
+			clocks = <&timer0_mux>;
+			clock-output-names = "timclk0";
+			clkgate-inverted;
+			reg = <0>;
+			clkgate = <16>;
+		};
+		timerclk01: timerclk01 {
+			compatible = "hisilicon,clk-gate";
+			#clock-cells = <0>;
+			clocks = <&timer_rclk01>;
+			clock-output-names = "timerclk01";
+			reg = <0x20>;
+			clkgate = <0>;
+			clkgate-seperated-reg;
+		};
+		mmc1_div: mmc1_div {
+			compatible = "hisilicon,clk-div";
+			#clock-cells = <0>;
+			clocks = <&mmc1_mux>;
+			clock-output-names = "mmc1_div";
+			reg = <0x108>;
+			clkdiv-mask = <0x1e0>;
+			clkdiv-min = <1>;
+			clkdiv-max = <16>;
+			clkdiv-hiword-mask;
+		};
+	};
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4038c2b..2a06b5c 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 # SoCs specific
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
 obj-$(CONFIG_ARCH_NOMADIK)	+= clk-nomadik.o
+obj-$(CONFIG_ARCH_HI3xxx)	+= hisilicon/
 obj-$(CONFIG_ARCH_HIGHBANK)	+= clk-highbank.o
 obj-$(CONFIG_ARCH_NSPIRE)	+= clk-nspire.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
new file mode 100644
index 0000000..1ed6a3c
--- /dev/null
+++ b/drivers/clk/hisilicon/Makefile
@@ -0,0 +1,2 @@
+
+obj-y	+= clk-hi3xxx.o clkgate-seperated.o
diff --git a/drivers/clk/hisilicon/clk-hi3xxx.c b/drivers/clk/hisilicon/clk-hi3xxx.c
new file mode 100644
index 0000000..87ae12b
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hi3xxx.c
@@ -0,0 +1,272 @@
+/*
+ * Hisilicon Hi3xxx clock driver
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
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#include "clk-hi3xxx.h"
+
+static void __iomem *hi3xxx_clk_base = NULL;
+
+static DEFINE_SPINLOCK(hi3xxx_clk_lock);
+
+static const struct of_device_id hi3xxx_of_match[] = {
+	{ .compatible = "hisilicon,sysctrl" },
+};
+
+static void __iomem __init *hi3xxx_init_clocks(struct device_node *np)
+{
+	struct device_node *parent;
+	const struct of_device_id *match;
+	void __iomem *ret = NULL;
+
+	parent = of_get_parent(np);
+	if (!parent) {
+		pr_warn("Can't find parent node of these clocks\n");
+		goto out;
+	}
+	match = of_match_node(hi3xxx_of_match, parent);
+	if (!match) {
+		pr_warn("Can't find the right parent\n");
+		goto out;
+	}
+
+	if (!hi3xxx_clk_base) {
+		ret = of_iomap(parent, 0);
+		WARN_ON(!ret);
+		hi3xxx_clk_base = ret;
+	} else {
+		ret = hi3xxx_clk_base;
+	}
+out:
+	return ret;
+}
+
+static void __init hi3xxx_clkgate_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, **parent_names, *name;
+	const __be32 *prop;
+	unsigned long flags = 0;
+	u32 bit_idx;
+	void __iomem *base, *reg;
+
+	base = hi3xxx_init_clocks(np);
+	if (!base)
+		goto err;
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		goto err;
+	if (of_property_read_u32(np, "clkgate", &bit_idx))
+		goto err;
+	prop = of_get_address(np, 0, NULL, NULL);
+	if (!prop)
+		goto err;
+	reg = base + be32_to_cpu(*prop);
+
+	/* gate only has the fixed parent */
+	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		goto err;
+	parent_names[0] = of_clk_get_parent_name(np, 0);
+
+	if (of_property_read_bool(np, "clkgate-seperated-reg")) {
+		clk = hi3xxx_register_clkgate_sep(NULL, clk_name, parent_names[0],
+						  0, reg, (u8)bit_idx, flags,
+						  &hi3xxx_clk_lock);
+	} else {
+		if (of_property_read_bool(np, "clkgate-inverted"))
+			flags |= CLK_GATE_SET_TO_DISABLE;
+		clk = clk_register_gate(NULL, clk_name, parent_names[0], 0, reg,
+					(u8)bit_idx, flags, &hi3xxx_clk_lock);
+	}
+	if (IS_ERR(clk))
+		goto err_clk;
+	if (!of_property_read_string(np, "clock-names", &name))
+		clk_register_clkdev(clk, name, NULL);
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+err_clk:
+	kfree(parent_names);
+err:
+	pr_err("Fail on registering hi3xxx clkgate node.\n");
+}
+CLK_OF_DECLARE(hi3xxx_gate, "hisilicon,clk-gate", hi3xxx_clkgate_setup)
+
+static int __init hi3xxx_parse_mux(struct device_node *np,
+				   u8 *num_parents,
+				   u32 *table)
+{
+	int i, cnt, ret;
+
+	/* get the count of items in mux */
+	for (i = 0, cnt = 0; ; i++, cnt++) {
+		/* parent's #clock-cells property is always 0 */
+		if (!of_parse_phandle(np, "clocks", i))
+			break;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (!of_clk_get_parent_name(np, i))
+			return -ENOENT;
+	}
+	*num_parents = cnt;
+	table = kzalloc(sizeof(u32 *) * cnt, GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+	ret = of_property_read_u32_array(np, "clkmux-table",
+					 table, cnt);
+	if (ret)
+		goto err;
+	return 0;
+err:
+	kfree(table);
+	return ret;
+}
+
+static void __init hi3xxx_clkmux_setup(struct device_node *np)
+{
+	struct clk *clk;
+	const char *clk_name, **parent_names = NULL;
+	const __be32 *prop;
+	u32 mask, *table = NULL;
+	u8 num_parents, shift, clk_mux_flags = 0;
+	void __iomem *reg, *base;
+	int i, ret;
+
+	base = hi3xxx_init_clocks(np);
+	if (!base)
+		goto err;
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		goto err;
+	prop = of_get_address(np, 0, NULL, NULL);
+	if (!prop)
+		goto err;
+	reg = base + be32_to_cpu(*prop);
+	if (of_property_read_u32(np, "clkmux-mask", &mask))
+		goto err;
+	if (of_property_read_bool(np, "clkmux-hiword-mask"))
+		clk_mux_flags = CLK_MUX_HIWORD_MASK;
+
+	ret = hi3xxx_parse_mux(np, &num_parents, table);
+	if (ret)
+		goto err;
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+	if (!parent_names)
+		goto err_table;
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(np, i);
+
+	shift = ffs(mask) - 1;
+	mask = mask >> shift;
+	clk = clk_register_mux_table(NULL, clk_name, parent_names, num_parents,
+				     CLK_SET_RATE_PARENT, reg, shift, mask,
+				     clk_mux_flags, table, &hi3xxx_clk_lock);
+	if (IS_ERR(clk))
+		goto err_clk;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+
+	return;
+err_clk:
+	kfree(parent_names);
+err_table:
+	kfree(table);
+err:
+	pr_err("Fail on registering hi3xxx clkmux node.\n");
+}
+CLK_OF_DECLARE(hi3xxx_mux, "hisilicon,clk-mux", hi3xxx_clkmux_setup)
+
+static void __init hi3xxx_clkdiv_setup(struct device_node *np, int mode)
+{
+	struct clk *clk;
+	const char *clk_name, **parent_names;
+	const __be32 *prop;
+	struct clk_div_table *table;
+	unsigned int table_num;
+	u32 min, max, mask;
+	u8 shift, width, clk_div_flags = 0;
+	void __iomem *reg, *base;
+	int i;
+
+	base = hi3xxx_init_clocks(np);
+	if (!base)
+		goto err;
+
+	if (of_property_read_string(np, "clock-output-names", &clk_name))
+		goto err;
+	if (of_property_read_u32(np, "clkdiv-mask", &mask))
+		goto err;
+	if (of_property_read_u32(np, "clkdiv-min", &min))
+		goto err;
+	if (of_property_read_u32(np, "clkdiv-max", &max))
+		goto err;
+	if (of_property_read_bool(np, "clkdiv-hiword-mask"))
+		clk_div_flags = CLK_DIVIDER_HIWORD_MASK;
+
+	prop = of_get_address(np, 0, NULL, NULL);
+	if (!prop)
+		goto err;
+	reg = base + be32_to_cpu(*prop);
+
+	table_num = max - min + 1;
+	table = kzalloc(sizeof(*table) * table_num, GFP_KERNEL);
+	if (!table)
+		goto err;
+
+	for (i = 0; i < table_num; i++) {
+		table[i].div = min + i;
+		table[i].val = table[i].div - 1;
+	}
+
+	/* gate only has the fixed parent */
+	parent_names = kzalloc(sizeof(char *), GFP_KERNEL);
+	if (!parent_names)
+		goto err_par;
+	parent_names[0] = of_clk_get_parent_name(np, 0);
+	shift = ffs(mask) - 1;
+	width = fls(mask) - ffs(mask) + 1;
+	clk = clk_register_divider_table(NULL, clk_name, parent_names[0], 0,
+					 reg, shift, width, clk_div_flags,
+					 table, &hi3xxx_clk_lock);
+	if (IS_ERR(clk))
+		goto err_clk;
+	of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	return;
+err_clk:
+	kfree(parent_names);
+err_par:
+	kfree(table);
+err:
+	pr_err("Fail on registering hi3xxx clkdiv node\n");
+}
+CLK_OF_DECLARE(hi3xxx_div, "hisilicon,clk-div", hi3xxx_clkdiv_setup)
diff --git a/drivers/clk/hisilicon/clk-hi3xxx.h b/drivers/clk/hisilicon/clk-hi3xxx.h
new file mode 100644
index 0000000..52c4d22
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hi3xxx.h
@@ -0,0 +1,34 @@
+/*
+ * Hisilicon Hi3620 clock gate driver
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
+#ifndef	__HI3XXX_CLKGATE_SEPERATED
+#define	__HI3XXX_CLKGATE_SEPERATED
+
+extern struct clk *hi3xxx_register_clkgate_sep(struct device *, const char *,
+				const char *, unsigned long,
+				void __iomem *, u8,
+				u8, spinlock_t *);
+
+#endif	/* __HI3XXX_CLKGATE_SEPERATED */
diff --git a/drivers/clk/hisilicon/clkgate-seperated.c b/drivers/clk/hisilicon/clkgate-seperated.c
new file mode 100644
index 0000000..1d7b0da
--- /dev/null
+++ b/drivers/clk/hisilicon/clkgate-seperated.c
@@ -0,0 +1,129 @@
+/*
+ * Hisilicon Hi3620 clock gate driver
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
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#include "clk-hi3xxx.h"
+
+/* Hi3620 clock gate register offset */
+#define CLKGATE_SEPERATED_ENABLE		0x0
+#define CLKGATE_SEPERATED_DISABLE		0x4
+#define CLKGATE_SEPERATED_STATUS		0x8
+
+struct clkgate_seperated {
+	struct clk_hw	hw;
+	void __iomem	*enable;	/* enable register */
+	u8		bit_idx;	/* bits in enable/disable register */
+	u8		flags;
+	spinlock_t	*lock;
+};
+
+static int clkgate_seperated_enable(struct clk_hw *hw)
+{
+	struct clkgate_seperated *sclk;
+	unsigned long flags = 0;
+	u32 reg;
+
+	sclk = container_of(hw, struct clkgate_seperated, hw);
+	if (sclk->lock)
+		spin_lock_irqsave(sclk->lock, flags);
+	reg = BIT(sclk->bit_idx);
+	writel_relaxed(reg, sclk->enable);
+	readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	if (sclk->lock)
+		spin_unlock_irqrestore(sclk->lock, flags);
+	return 0;
+}
+
+static void clkgate_seperated_disable(struct clk_hw *hw)
+{
+	struct clkgate_seperated *sclk;
+	unsigned long flags = 0;
+	u32 reg;
+
+	sclk = container_of(hw, struct clkgate_seperated, hw);
+	if (sclk->lock)
+		spin_lock_irqsave(sclk->lock, flags);
+	reg = BIT(sclk->bit_idx);
+	writel_relaxed(reg, sclk->enable + CLKGATE_SEPERATED_DISABLE);
+	readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	if (sclk->lock)
+		spin_unlock_irqrestore(sclk->lock, flags);
+}
+
+static int clkgate_seperated_is_enabled(struct clk_hw *hw)
+{
+	struct clkgate_seperated *sclk;
+	u32 reg;
+
+	sclk = container_of(hw, struct clkgate_seperated, hw);
+	reg = readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	reg &= BIT(sclk->bit_idx);
+
+	return reg ? 1 : 0;
+}
+
+static struct clk_ops clkgate_seperated_ops = {
+	.enable		= clkgate_seperated_enable,
+	.disable	= clkgate_seperated_disable,
+	.is_enabled	= clkgate_seperated_is_enabled,
+};
+
+struct clk *hi3xxx_register_clkgate_sep(struct device *dev, const char *name,
+				const char *parent_name, unsigned long flags,
+				void __iomem *reg, u8 bit_idx,
+				u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clkgate_seperated *sclk;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	sclk = kzalloc(sizeof(struct clkgate_seperated), GFP_KERNEL);
+	if (!sclk) {
+		pr_err("%s: fail to allocate seperated gated clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &clkgate_seperated_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	sclk->enable = reg + CLKGATE_SEPERATED_ENABLE;
+	sclk->bit_idx = bit_idx;
+	sclk->flags = clk_gate_flags;
+	sclk->hw.init = &init;
+
+	clk = clk_register(dev, &sclk->hw);
+	if (IS_ERR(clk))
+		kfree(sclk);
+	return clk;
+}
-- 
1.8.1.2
