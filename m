From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 25 Feb 2013 11:44:26 -0300
Subject: [PATCH v2 1/3] clk: arm: sunxi: Add a new clock driver for sunxi SOCs
In-Reply-To: <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1361803468-9899-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1361803468-9899-2-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit implements the base CPU clocks for sunxi devices. It has
been tested using a slightly modified cpufreq driver from the
linux-sunxi 3.0 tree.

Additionally, document the new bindings introduced by this patch.

Idling:
    / # cat /sys/kernel/debug/clk/clk_summary
       clock                        enable_cnt  prepare_cnt  rate
    ---------------------------------------------------------------------
     osc32k                         0           0            32768
     osc24M_fixed                   0           0            24000000
        osc24M                      0           0            24000000
           apb1_mux                 0           0            24000000
              apb1                  0           0            24000000
           pll1                     0           0            60000000
              cpu                   0           0            60000000
                 axi                0           0            60000000
                    ahb             0           0            60000000
                       apb0         0           0            30000000
     dummy                          0           0            0

After "yes >/dev/null &":
    / # cat /sys/kernel/debug/clk/clk_summary
       clock                        enable_cnt  prepare_cnt  rate
    ---------------------------------------------------------------------
     osc32k                         0           0            32768
     osc24M_fixed                   0           0            24000000
        osc24M                      0           0            24000000
           apb1_mux                 0           0            24000000
              apb1                  0           0            24000000
           pll1                     0           0            1008000000
              cpu                   0           0            1008000000
                 axi                0           0            336000000
                    ahb             0           0            168000000
                       apb0         0           0            84000000
     dummy                          0           0            0

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 Documentation/devicetree/bindings/clock/sunxi.txt |  44 +++
 drivers/clk/Makefile                              |   1 +
 drivers/clk/sunxi/Makefile                        |   5 +
 drivers/clk/sunxi/clk-factors.c                   | 180 +++++++++++
 drivers/clk/sunxi/clk-factors.h                   |  27 ++
 drivers/clk/sunxi/clk-sunxi.c                     | 362 ++++++++++++++++++++++
 drivers/clocksource/sunxi_timer.c                 |   4 +-
 include/linux/clk/sunxi.h                         |  22 ++
 8 files changed, 643 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/sunxi.txt
 create mode 100644 drivers/clk/sunxi/Makefile
 create mode 100644 drivers/clk/sunxi/clk-factors.c
 create mode 100644 drivers/clk/sunxi/clk-factors.h
 create mode 100644 drivers/clk/sunxi/clk-sunxi.c
 create mode 100644 include/linux/clk/sunxi.h

diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
new file mode 100644
index 0000000..b23cfbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sunxi.txt
@@ -0,0 +1,44 @@
+Device Tree Clock bindings for arch-sunxi
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of the following:
+	"allwinner,sunxi-osc-clk" - for a gatable oscillator
+	"allwinner,sunxi-pll1-clk" - for the main PLL clock
+	"allwinner,sunxi-cpu-clk" - for the CPU multiplexer clock
+	"allwinner,sunxi-axi-clk" - for the sunxi AXI clock
+	"allwinner,sunxi-ahb-clk" - for the sunxi AHB clock
+	"allwinner,sunxi-apb0-clk" - for the sunxi APB0 clock
+	"allwinner,sunxi-apb1-clk" - for the sunxi APB1 clock
+	"allwinner,sunxi-apb1-mux-clk" - for the sunxi APB1 clock muxing
+
+Required properties for all clocks:
+- reg : shall be the control register address for the clock.
+- clocks : shall be the input parent clock(s) phandle for the clock
+- #clock-cells : from common clock binding; shall be set to 0.
+
+For example:
+
+osc24M: osc24M at 01c20050 {
+	#clock-cells = <0>;
+	compatible = "allwinner,sunxi-osc-clk";
+	reg = <0x01c20050 0x4>;
+	clocks = <&osc24M_fixed>;
+};
+
+pll1: pll1 at 01c20000 {
+	#clock-cells = <0>;
+	compatible = "allwinner,sunxi-pll1-clk";
+	reg = <0x01c20000 0x4>;
+	clocks = <&osc24M>;
+};
+
+cpu: cpu at 01c20054 {
+	#clock-cells = <0>;
+	compatible = "allwinner,sunxi-cpu-clk";
+	reg = <0x01c20054 0x4>;
+	clocks = <&osc32k>, <&osc24M>, <&pll1>;
+};
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 300d477..db8b11b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -23,6 +23,7 @@ ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)		+= mmp/
 endif
 obj-$(CONFIG_MACH_LOONGSON1)	+= clk-ls1x.o
+obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= clk-zynq.o
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
new file mode 100644
index 0000000..b5bac91
--- /dev/null
+++ b/drivers/clk/sunxi/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for sunxi specific clk
+#
+
+obj-y += clk-sunxi.o clk-factors.o
diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
new file mode 100644
index 0000000..88523f9
--- /dev/null
+++ b/drivers/clk/sunxi/clk-factors.c
@@ -0,0 +1,180 @@
+/*
+ * Copyright (C) 2013 Emilio L?pez <emilio@elopez.com.ar>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Adjustable factor-based clock implementation
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/string.h>
+
+#include <linux/delay.h>
+
+#include "clk-factors.h"
+
+/*
+ * DOC: basic adjustable factor-based clock that cannot gate
+ *
+ * Traits of this clock:
+ * prepare - clk_prepare only ensures that parents are prepared
+ * enable - clk_enable only ensures that parents are enabled
+ * rate - rate is adjustable.
+ *        clk->rate = (parent->rate * N * (K + 1) >> P) / (M + 1)
+ * parent - fixed parent.  No clk_set_parent support
+ */
+
+struct clk_factors {
+	struct clk_hw hw;
+	void __iomem *reg;
+	struct clk_factors_config *config;
+	void (*get_factors) (u32 *rate, u32 parent, u8 *n, u8 *k, u8 *m, u8 *p);
+	spinlock_t *lock;
+};
+
+#define to_clk_factors(_hw) container_of(_hw, struct clk_factors, hw)
+
+#define SETMASK(len, pos)		(((-1U) >> (31-len))  << (pos))
+#define CLRMASK(len, pos)		(~(SETMASK(len, pos)))
+#define FACTOR_GET(bit, len, reg)	(((reg) & SETMASK(len, bit)) >> (bit))
+
+#define FACTOR_SET(bit, len, reg, val) \
+	(((reg) & CLRMASK(len, bit)) | (val << (bit)))
+
+static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	u8 n = 1, k = 0, p = 0, m = 0;
+	u32 reg;
+	unsigned long rate;
+	struct clk_factors *factors = to_clk_factors(hw);
+	struct clk_factors_config *config = factors->config;
+
+	/* Fetch the register value */
+	reg = readl(factors->reg);
+
+	/* Get each individual factor if applicable */
+	if (config->nwidth != SUNXI_FACTORS_NOT_APPLICABLE)
+		n = FACTOR_GET(config->nshift, config->nwidth, reg);
+	if (config->kwidth != SUNXI_FACTORS_NOT_APPLICABLE)
+		k = FACTOR_GET(config->kshift, config->kwidth, reg);
+	if (config->mwidth != SUNXI_FACTORS_NOT_APPLICABLE)
+		m = FACTOR_GET(config->mshift, config->mwidth, reg);
+	if (config->pwidth != SUNXI_FACTORS_NOT_APPLICABLE)
+		p = FACTOR_GET(config->pshift, config->pwidth, reg);
+
+	/* Calculate the rate */
+	rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
+
+	return rate;
+}
+
+static long clk_factors_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
+{
+	struct clk_factors *factors = to_clk_factors(hw);
+	factors->get_factors((u32 *)&rate, (u32)*parent_rate,
+			     NULL, NULL, NULL, NULL);
+
+	return rate;
+}
+
+static int clk_factors_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	u8 n, k, m, p;
+	u32 reg;
+	struct clk_factors *factors = to_clk_factors(hw);
+	struct clk_factors_config *config = factors->config;
+	unsigned long flags = 0;
+
+	factors->get_factors((u32 *)&rate, (u32)parent_rate, &n, &k, &m, &p);
+
+	if (factors->lock)
+		spin_lock_irqsave(factors->lock, flags);
+
+	/* Fetch the register value */
+	reg = readl(factors->reg);
+
+	/* Set up the new factors - macros do not do anything if width is 0 */
+	reg = FACTOR_SET(config->nshift, config->nwidth, reg, n);
+	reg = FACTOR_SET(config->kshift, config->kwidth, reg, k);
+	reg = FACTOR_SET(config->mshift, config->mwidth, reg, m);
+	reg = FACTOR_SET(config->pshift, config->pwidth, reg, p);
+
+	/* Apply them now */
+	writel(reg, factors->reg);
+
+	/* delay 500us so pll stabilizes */
+	__delay((rate >> 20) * 500 / 2);
+
+	if (factors->lock)
+		spin_unlock_irqrestore(factors->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops clk_factors_ops = {
+	.recalc_rate = clk_factors_recalc_rate,
+	.round_rate = clk_factors_round_rate,
+	.set_rate = clk_factors_set_rate,
+};
+
+/**
+ * clk_register_factors - register a factors clock with
+ * the clock framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_name: name of clock's parent
+ * @flags: framework-specific flags
+ * @reg: register address to adjust factors
+ * @config: shift and width of factors n, k, m and p
+ * @get_factors: function to calculate the factors for a given frequency
+ * @lock: shared register lock for this clock
+ */
+struct clk *clk_register_factors(struct device *dev, const char *name,
+				 const char *parent_name,
+				 unsigned long flags, void __iomem *reg,
+				 struct clk_factors_config *config,
+				 void (*get_factors)(u32 *rate, u32 parent,
+						     u8 *n, u8 *k, u8 *m, u8 *p),
+				 spinlock_t *lock)
+{
+	struct clk_factors *factors;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	/* allocate the factors */
+	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
+	if (!factors) {
+		pr_err("%s: could not allocate factors clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &clk_factors_ops;
+	init.flags = flags;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	/* struct clk_factors assignments */
+	factors->reg = reg;
+	factors->config = config;
+	factors->lock = lock;
+	factors->hw.init = &init;
+	factors->get_factors = get_factors;
+
+	/* register the clock */
+	clk = clk_register(dev, &factors->hw);
+
+	if (IS_ERR(clk))
+		kfree(factors);
+
+	return clk;
+}
diff --git a/drivers/clk/sunxi/clk-factors.h b/drivers/clk/sunxi/clk-factors.h
new file mode 100644
index 0000000..f49851c
--- /dev/null
+++ b/drivers/clk/sunxi/clk-factors.h
@@ -0,0 +1,27 @@
+#ifndef __MACH_SUNXI_CLK_FACTORS_H
+#define __MACH_SUNXI_CLK_FACTORS_H
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+#define SUNXI_FACTORS_NOT_APPLICABLE	(0)
+
+struct clk_factors_config {
+	u8 nshift;
+	u8 nwidth;
+	u8 kshift;
+	u8 kwidth;
+	u8 mshift;
+	u8 mwidth;
+	u8 pshift;
+	u8 pwidth;
+};
+
+struct clk *clk_register_factors(struct device *dev, const char *name,
+				 const char *parent_name,
+				 unsigned long flags, void __iomem *reg,
+				 struct clk_factors_config *config,
+				 void (*get_factors) (u32 *rate, u32 parent_rate,
+						      u8 *n, u8 *k, u8 *m, u8 *p),
+				 spinlock_t *lock);
+#endif
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
new file mode 100644
index 0000000..d4ad1c2
--- /dev/null
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -0,0 +1,362 @@
+/*
+ * Copyright 2013 Emilio L?pez
+ *
+ * Emilio L?pez <emilio@elopez.com.ar>
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
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/sunxi.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include "clk-factors.h"
+
+static DEFINE_SPINLOCK(clk_lock);
+
+/**
+ * sunxi_osc_clk_setup() - Setup function for gatable oscillator
+ */
+
+#define SUNXI_OSC24M_GATE	0
+
+static void __init sunxi_osc_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent;
+	void *reg;
+
+	reg = of_iomap(node, 0);
+
+	parent = of_clk_get_parent_name(node, 0);
+
+	clk = clk_register_gate(NULL, clk_name, parent, CLK_IGNORE_UNUSED,
+				reg, SUNXI_OSC24M_GATE, 0, &clk_lock);
+
+	if (clk) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		clk_register_clkdev(clk, clk_name, NULL);
+	}
+}
+
+
+
+/**
+ * sunxi_get_pll1_factors() - calculates n, k, m, p factors for PLL1
+ * PLL1 rate is calculated as follows
+ * rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
+ * parent_rate is always 24Mhz
+ */
+
+static void sunxi_get_pll1_factors(u32 *freq, u32 parent_rate,
+				   u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 div;
+
+	/* Normalize value to a 6M multiple */
+	div = *freq / 6000000;
+	*freq = 6000000 * div;
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	/* m is always zero for pll1 */
+	*m = 0;
+
+	/* k is 1 only on these cases */
+	if (*freq >= 768000000 || *freq == 42000000 || *freq == 54000000)
+		*k = 1;
+	else
+		*k = 0;
+
+	/* p will be 3 for divs under 10 */
+	if (div < 10)
+		*p = 3;
+
+	/* p will be 2 for divs between 10 - 20 and odd divs under 32 */
+	else if (div < 20 || (div < 32 && (div & 1)))
+		*p = 2;
+
+	/* p will be 1 for even divs under 32, divs under 40 and odd pairs
+	 * of divs between 40-62 */
+	else if (div < 40 || (div < 64 && (div & 2)))
+		*p = 1;
+
+	/* any other entries have p = 0 */
+	else
+		*p = 0;
+
+	/* calculate a suitable n based on k and p */
+	div <<= *p;
+	div /= (*k + 1);
+	*n = div / 4;
+}
+
+
+
+/**
+ * sunxi_get_apb1_factors() - calculates m, p factors for APB1
+ * APB1 rate is calculated as follows
+ * rate = (parent_rate >> p) / (m + 1);
+ */
+
+static void sunxi_get_apb1_factors(u32 *freq, u32 parent_rate,
+				   u8 *n, u8 *k, u8 *m, u8 *p)
+{
+	u8 calcm, calcp;
+
+	if (parent_rate < *freq)
+		*freq = parent_rate;
+
+	parent_rate = (parent_rate + (*freq - 1)) / *freq;
+
+	/* Invalid rate! */
+	if (parent_rate > 32)
+		return;
+
+	if (parent_rate <= 4)
+		calcp = 0;
+	else if (parent_rate <= 8)
+		calcp = 1;
+	else if (parent_rate <= 16)
+		calcp = 2;
+	else
+		calcp = 3;
+
+	calcm = (parent_rate >> calcp) - 1;
+
+	*freq = (parent_rate >> calcp) / (calcm + 1);
+
+	/* we were called to round the frequency, we can now return */
+	if (n == NULL)
+		return;
+
+	*m = calcm;
+	*p = calcp;
+}
+
+
+
+/**
+ * sunxi_factors_clk_setup() - Setup function for factor clocks
+ */
+
+struct factors_data {
+	struct clk_factors_config *table;
+	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
+};
+
+static struct clk_factors_config pll1_config = {
+	.nshift = 8,
+	.nwidth = 5,
+	.kshift = 4,
+	.kwidth = 2,
+	.mshift = 0,
+	.mwidth = 2,
+	.pshift = 16,
+	.pwidth = 2,
+};
+
+static struct clk_factors_config apb1_config = {
+	.mshift = 0,
+	.mwidth = 5,
+	.pshift = 16,
+	.pwidth = 2,
+};
+
+static const __initconst struct factors_data pll1_data = {
+	.table = &pll1_config,
+	.getter = sunxi_get_pll1_factors,
+};
+
+static const __initconst struct factors_data apb1_data = {
+	.table = &apb1_config,
+	.getter = sunxi_get_apb1_factors,
+};
+
+static void __init sunxi_factors_clk_setup(struct device_node *node,
+					   struct factors_data *data)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *parent;
+	void *reg;
+
+	reg = of_iomap(node, 0);
+
+	parent = of_clk_get_parent_name(node, 0);
+
+	clk = clk_register_factors(NULL, clk_name, parent, CLK_IGNORE_UNUSED,
+				   reg, data->table, data->getter, &clk_lock);
+
+	if (clk) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		clk_register_clkdev(clk, clk_name, NULL);
+	}
+}
+
+
+
+/**
+ * sunxi_mux_clk_setup() - Setup function for muxes
+ */
+
+#define SUNXI_MUX_GATE_WIDTH	2
+
+struct mux_data {
+	u8 shift;
+};
+
+static const __initconst struct mux_data cpu_data = {
+	.shift = 16,
+};
+
+static const __initconst struct mux_data apb1_mux_data = {
+	.shift = 24,
+};
+
+static void __init sunxi_mux_clk_setup(struct device_node *node,
+				       struct mux_data *data)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char **parents = kmalloc(sizeof(char *) * 5, GFP_KERNEL);
+	void *reg;
+	int i = 0;
+
+	reg = of_iomap(node, 0);
+
+	while (i < 5 && (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
+		i++;
+
+	clk = clk_register_mux(NULL, clk_name, parents, i, 0, reg,
+			       data->shift, SUNXI_MUX_GATE_WIDTH,
+			       0, &clk_lock);
+
+	if (clk) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		clk_register_clkdev(clk, clk_name, NULL);
+	}
+}
+
+
+
+/**
+ * sunxi_divider_clk_setup() - Setup function for simple divider clocks
+ */
+
+#define SUNXI_DIVISOR_WIDTH	2
+
+struct div_data {
+	u8 shift;
+	u8 pow;
+};
+
+static const __initconst struct div_data axi_data = {
+	.shift = 0,
+	.pow = 0,
+};
+
+static const __initconst struct div_data ahb_data = {
+	.shift = 4,
+	.pow = 1,
+};
+
+static const __initconst struct div_data apb0_data = {
+	.shift = 8,
+	.pow = 1,
+};
+
+static void __init sunxi_divider_clk_setup(struct device_node *node,
+					   struct div_data *data)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	const char *clk_parent;
+	void *reg;
+
+	reg = of_iomap(node, 0);
+
+	clk_parent = of_clk_get_parent_name(node, 0);
+
+	clk = clk_register_divider(NULL, clk_name, clk_parent, 0,
+				   reg, data->shift, SUNXI_DIVISOR_WIDTH,
+				   data->pow ? CLK_DIVIDER_POWER_OF_TWO : 0,
+				   &clk_lock);
+	if (clk) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		clk_register_clkdev(clk, clk_name, NULL);
+	}
+}
+
+
+/* Matches for of_clk_init */
+static const __initconst struct of_device_id clk_match[] = {
+	{.compatible = "fixed-clock", .data = of_fixed_clk_setup,},
+	{.compatible = "allwinner,sunxi-osc-clk", .data = sunxi_osc_clk_setup,},
+	{}
+};
+
+/* Matches for factors clocks */
+static const __initconst struct of_device_id clk_factors_match[] = {
+	{.compatible = "allwinner,sunxi-pll1-clk", .data = &pll1_data,},
+	{.compatible = "allwinner,sunxi-apb1-clk", .data = &apb1_data,},
+	{}
+};
+
+/* Matches for divider clocks */
+static const __initconst struct of_device_id clk_div_match[] = {
+	{.compatible = "allwinner,sunxi-axi-clk", .data = &axi_data,},
+	{.compatible = "allwinner,sunxi-ahb-clk", .data = &ahb_data,},
+	{.compatible = "allwinner,sunxi-apb0-clk", .data = &apb0_data,},
+	{}
+};
+
+/* Matches for mux clocks */
+static const __initconst struct of_device_id clk_mux_match[] = {
+	{.compatible = "allwinner,sunxi-cpu-clk", .data = &cpu_data,},
+	{.compatible = "allwinner,sunxi-apb1-mux-clk", .data = &apb1_mux_data,},
+	{}
+};
+
+static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_match,
+					      void *function)
+{
+	struct device_node *np;
+	const struct div_data *data;
+	const struct of_device_id *match;
+	void (*setup_function)(struct device_node *, const void *) = function;
+
+	for_each_matching_node(np, clk_match) {
+		match = of_match_node(clk_match, np);
+		data = match->data;
+		setup_function(np, data);
+	}
+}
+
+void __init sunxi_init_clocks(void)
+{
+	/* Register all the simple sunxi clocks on DT */
+	of_clk_init(clk_match);
+
+	/* Register factor clocks */
+	of_sunxi_table_clock_setup(clk_factors_match, sunxi_factors_clk_setup);
+
+	/* Register divider clocks */
+	of_sunxi_table_clock_setup(clk_div_match, sunxi_divider_clk_setup);
+
+	/* Register mux clocks */
+	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
+}
diff --git a/drivers/clocksource/sunxi_timer.c b/drivers/clocksource/sunxi_timer.c
index 4086b91..0ce85e2 100644
--- a/drivers/clocksource/sunxi_timer.c
+++ b/drivers/clocksource/sunxi_timer.c
@@ -23,7 +23,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/sunxi_timer.h>
-#include <linux/clk-provider.h>
+#include <linux/clk/sunxi.h>
 
 #define TIMER_CTL_REG		0x00
 #define TIMER_CTL_ENABLE		(1 << 0)
@@ -123,7 +123,7 @@ void __init sunxi_timer_init(void)
 	if (irq <= 0)
 		panic("Can't parse IRQ");
 
-	of_clk_init(NULL);
+	sunxi_init_clocks();
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk))
diff --git a/include/linux/clk/sunxi.h b/include/linux/clk/sunxi.h
new file mode 100644
index 0000000..e074fdd
--- /dev/null
+++ b/include/linux/clk/sunxi.h
@@ -0,0 +1,22 @@
+/*
+ * Copyright 2012 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
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
+#ifndef __LINUX_CLK_SUNXI_H_
+#define __LINUX_CLK_SUNXI_H_
+
+void __init sunxi_init_clocks(void);
+
+#endif
-- 
1.8.2.rc0
