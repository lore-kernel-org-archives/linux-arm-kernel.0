From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 18 Dec 2013 18:03:02 +0100
Subject: [PATCH V2 4/4] ARM: socfpga: clk: split clk code
In-Reply-To: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1387386182-30923-5-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the different kinds of clocks into their own files. The reason is to aid
readability of the code. This also goes along with the other SoC-specific
clock drivers.

The split introduces new structs for the three types of clocks and uses them.
Other changes are not done to the code.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/clk/socfpga/Makefile     |   3 +
 drivers/clk/socfpga/clk-gate.c   | 223 +++++++++++++++++++++++++
 drivers/clk/socfpga/clk-periph.c |  94 +++++++++++
 drivers/clk/socfpga/clk-pll.c    | 111 +++++++++++++
 drivers/clk/socfpga/clk.c        | 346 +--------------------------------------
 drivers/clk/socfpga/clk.h        |  57 +++++++
 6 files changed, 490 insertions(+), 344 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate.c
 create mode 100644 drivers/clk/socfpga/clk-periph.c
 create mode 100644 drivers/clk/socfpga/clk-pll.c
 create mode 100644 drivers/clk/socfpga/clk.h

diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
index 0303c0b..7e2d15a 100644
--- a/drivers/clk/socfpga/Makefile
+++ b/drivers/clk/socfpga/Makefile
@@ -1 +1,4 @@
 obj-y += clk.o
+obj-y += clk-gate.o
+obj-y += clk-pll.o
+obj-y += clk-periph.o
diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
new file mode 100644
index 0000000..388bcac
--- /dev/null
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -0,0 +1,223 @@
+/*
+ *  Copyright 2011-2012 Calxeda, Inc.
+ *  Copyright (C) 2012-2013 Altera Corporation <www.altera.com>
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
+ * Based from clk-highbank.c
+ *
+ */
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include "clk.h"
+
+#define SOCFPGA_L4_MP_CLK		"l4_mp_clk"
+#define SOCFPGA_L4_SP_CLK		"l4_sp_clk"
+#define SOCFPGA_NAND_CLK		"nand_clk"
+#define SOCFPGA_NAND_X_CLK		"nand_x_clk"
+#define SOCFPGA_MMC_CLK			"sdmmc_clk"
+#define SOCFPGA_GPIO_DB_CLK_OFFSET	0xA8
+
+#define div_mask(width)	((1 << (width)) - 1)
+#define streq(a, b) (strcmp((a), (b)) == 0)
+
+/* SDMMC Group for System Manager defines */
+#define SYSMGR_SDMMCGRP_CTRL_OFFSET	0x108
+#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)	\
+	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
+
+#define to_socfpga_gate_clk(p) container_of(p, struct socfpga_gate_clk, hw.hw)
+
+static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
+{
+	u32 l4_src;
+	u32 perpll_src;
+
+	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
+		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
+		return l4_src &= 0x1;
+	}
+	if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
+		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
+		return !!(l4_src & 2);
+	}
+
+	perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
+	if (streq(hwclk->init->name, SOCFPGA_MMC_CLK))
+		return perpll_src &= 0x3;
+	if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
+			streq(hwclk->init->name, SOCFPGA_NAND_X_CLK))
+			return (perpll_src >> 2) & 3;
+
+	/* QSPI clock */
+	return (perpll_src >> 4) & 3;
+
+}
+
+static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
+{
+	u32 src_reg;
+
+	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
+		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
+		src_reg &= ~0x1;
+		src_reg |= parent;
+		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
+	} else if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
+		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
+		src_reg &= ~0x2;
+		src_reg |= (parent << 1);
+		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
+	} else {
+		src_reg = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
+		if (streq(hwclk->init->name, SOCFPGA_MMC_CLK)) {
+			src_reg &= ~0x3;
+			src_reg |= parent;
+		} else if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
+			streq(hwclk->init->name, SOCFPGA_NAND_X_CLK)) {
+			src_reg &= ~0xC;
+			src_reg |= (parent << 2);
+		} else {/* QSPI clock */
+			src_reg &= ~0x30;
+			src_reg |= (parent << 4);
+		}
+		writel(src_reg, clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
+	}
+
+	return 0;
+}
+
+static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
+	unsigned long parent_rate)
+{
+	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
+	u32 div = 1, val;
+
+	if (socfpgaclk->fixed_div)
+		div = socfpgaclk->fixed_div;
+	else if (socfpgaclk->div_reg) {
+		val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
+		val &= div_mask(socfpgaclk->width);
+		/* Check for GPIO_DB_CLK by its offset */
+		if ((int) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
+			div = val + 1;
+		else
+			div = (1 << val);
+	}
+
+	return parent_rate / div;
+}
+
+static int socfpga_clk_prepare(struct clk_hw *hwclk)
+{
+	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
+	struct regmap *sys_mgr_base_addr;
+	u32 hs_timing;
+
+	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
+		sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
+		if (IS_ERR(sys_mgr_base_addr)) {
+			pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
+			return -EINVAL;
+		}
+		hs_timing = SYSMGR_SDMMC_CTRL_SET(socfpgaclk->clk_phase[0],
+						socfpgaclk->clk_phase[1]);
+		regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
+						hs_timing);
+	}
+	return 0;
+}
+
+static struct clk_ops gateclk_ops = {
+	.prepare = socfpga_clk_prepare,
+	.recalc_rate = socfpga_clk_recalc_rate,
+	.get_parent = socfpga_clk_get_parent,
+	.set_parent = socfpga_clk_set_parent,
+};
+
+static void __init __socfpga_gate_init(struct device_node *node,
+	const struct clk_ops *ops)
+{
+	u32 clk_gate[2];
+	u32 div_reg[3];
+	u32 fixed_div;
+	struct clk *clk;
+	struct socfpga_gate_clk *socfpga_clk;
+	const char *clk_name = node->name;
+	const char *parent_name[SOCFPGA_MAX_PARENTS];
+	struct clk_init_data init;
+	int rc;
+	int i = 0;
+
+	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
+	if (WARN_ON(!socfpga_clk))
+		return;
+
+	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
+	if (rc)
+		clk_gate[0] = 0;
+
+	if (clk_gate[0]) {
+		socfpga_clk->hw.reg = clk_mgr_base_addr + clk_gate[0];
+		socfpga_clk->hw.bit_idx = clk_gate[1];
+
+		gateclk_ops.enable = clk_gate_ops.enable;
+		gateclk_ops.disable = clk_gate_ops.disable;
+	}
+
+	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
+	if (rc)
+		socfpga_clk->fixed_div = 0;
+	else
+		socfpga_clk->fixed_div = fixed_div;
+
+	rc = of_property_read_u32_array(node, "div-reg", div_reg, 3);
+	if (!rc) {
+		socfpga_clk->div_reg = clk_mgr_base_addr + div_reg[0];
+		socfpga_clk->shift = div_reg[1];
+		socfpga_clk->width = div_reg[2];
+	} else {
+		socfpga_clk->div_reg = 0;
+	}
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	init.name = clk_name;
+	init.ops = ops;
+	init.flags = 0;
+	while (i < SOCFPGA_MAX_PARENTS && (parent_name[i] =
+			of_clk_get_parent_name(node, i)) != NULL)
+		i++;
+
+	init.parent_names = parent_name;
+	init.num_parents = i;
+	socfpga_clk->hw.hw.init = &init;
+
+	clk = clk_register(NULL, &socfpga_clk->hw.hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(socfpga_clk);
+		return;
+	}
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (WARN_ON(rc))
+		return;
+}
+
+void __init socfpga_gate_init(struct device_node *node)
+{
+	__socfpga_gate_init(node, &gateclk_ops);
+}
diff --git a/drivers/clk/socfpga/clk-periph.c b/drivers/clk/socfpga/clk-periph.c
new file mode 100644
index 0000000..81623a3
--- /dev/null
+++ b/drivers/clk/socfpga/clk-periph.c
@@ -0,0 +1,94 @@
+/*
+ *  Copyright 2011-2012 Calxeda, Inc.
+ *  Copyright (C) 2012-2013 Altera Corporation <www.altera.com>
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
+ * Based from clk-highbank.c
+ *
+ */
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include "clk.h"
+
+#define to_socfpga_periph_clk(p) container_of(p, struct socfpga_periph_clk, hw.hw)
+
+static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
+					     unsigned long parent_rate)
+{
+	struct socfpga_periph_clk *socfpgaclk = to_socfpga_periph_clk(hwclk);
+	u32 div;
+
+	if (socfpgaclk->fixed_div)
+		div = socfpgaclk->fixed_div;
+	else
+		div = ((readl(socfpgaclk->hw.reg) & 0x1ff) + 1);
+
+	return parent_rate / div;
+}
+
+static const struct clk_ops periclk_ops = {
+	.recalc_rate = clk_periclk_recalc_rate,
+};
+
+static __init void __socfpga_periph_init(struct device_node *node,
+	const struct clk_ops *ops)
+{
+	u32 reg;
+	struct clk *clk;
+	struct socfpga_periph_clk *periph_clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	struct clk_init_data init;
+	int rc;
+	u32 fixed_div;
+
+	of_property_read_u32(node, "reg", &reg);
+
+	periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
+	if (WARN_ON(!periph_clk))
+		return;
+
+	periph_clk->hw.reg = clk_mgr_base_addr + reg;
+
+	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
+	if (rc)
+		periph_clk->fixed_div = 0;
+	else
+		periph_clk->fixed_div = fixed_div;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	init.name = clk_name;
+	init.ops = ops;
+	init.flags = 0;
+	parent_name = of_clk_get_parent_name(node, 0);
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	periph_clk->hw.hw.init = &init;
+
+	clk = clk_register(NULL, &periph_clk->hw.hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(periph_clk);
+		return;
+	}
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+
+void __init socfpga_periph_init(struct device_node *node)
+{
+	__socfpga_periph_init(node, &periclk_ops);
+}
diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
new file mode 100644
index 0000000..362004e
--- /dev/null
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -0,0 +1,111 @@
+/*
+ *  Copyright 2011-2012 Calxeda, Inc.
+ *  Copyright (C) 2012-2013 Altera Corporation <www.altera.com>
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
+ * Based from clk-highbank.c
+ *
+ */
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of.h>
+
+#include "clk.h"
+
+/* Clock bypass bits */
+#define MAINPLL_BYPASS		(1<<0)
+#define SDRAMPLL_BYPASS		(1<<1)
+#define SDRAMPLL_SRC_BYPASS	(1<<2)
+#define PERPLL_BYPASS		(1<<3)
+#define PERPLL_SRC_BYPASS	(1<<4)
+
+#define SOCFPGA_PLL_BG_PWRDWN		0
+#define SOCFPGA_PLL_EXT_ENA		1
+#define SOCFPGA_PLL_PWR_DOWN		2
+#define SOCFPGA_PLL_DIVF_MASK		0x0000FFF8
+#define SOCFPGA_PLL_DIVF_SHIFT		3
+#define SOCFPGA_PLL_DIVQ_MASK		0x003F0000
+#define SOCFPGA_PLL_DIVQ_SHIFT		16
+
+#define to_socfpga_clk(p) container_of(p, struct socfpga_pll, hw.hw)
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
+					 unsigned long parent_rate)
+{
+	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
+	unsigned long divf, divq, vco_freq, reg;
+	unsigned long bypass;
+
+	reg = readl(socfpgaclk->hw.reg);
+	bypass = readl(clk_mgr_base_addr + CLKMGR_BYPASS);
+	if (bypass & MAINPLL_BYPASS)
+		return parent_rate;
+
+	divf = (reg & SOCFPGA_PLL_DIVF_MASK) >> SOCFPGA_PLL_DIVF_SHIFT;
+	divq = (reg & SOCFPGA_PLL_DIVQ_MASK) >> SOCFPGA_PLL_DIVQ_SHIFT;
+	vco_freq = parent_rate * (divf + 1);
+	return vco_freq / (1 + divq);
+}
+
+static struct clk_ops clk_pll_ops = {
+	.recalc_rate = clk_pll_recalc_rate,
+};
+
+static __init struct clk *__socfpga_pll_init(struct device_node *node,
+	const struct clk_ops *ops)
+{
+	u32 reg;
+	struct clk *clk;
+	struct socfpga_pll *pll_clk;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	struct clk_init_data init;
+	int rc;
+
+	of_property_read_u32(node, "reg", &reg);
+
+	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
+	if (WARN_ON(!pll_clk))
+		return NULL;
+
+	pll_clk->hw.reg = clk_mgr_base_addr + reg;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	init.name = clk_name;
+	init.ops = ops;
+	init.flags = 0;
+	parent_name = of_clk_get_parent_name(node, 0);
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	pll_clk->hw.hw.init = &init;
+
+	pll_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
+	clk_pll_ops.enable = clk_gate_ops.enable;
+	clk_pll_ops.disable = clk_gate_ops.disable;
+
+	clk = clk_register(NULL, &pll_clk->hw.hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(pll_clk);
+		return NULL;
+	}
+	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	return clk;
+}
+
+void __init socfpga_pll_init(struct device_node *node)
+{
+	__socfpga_pll_init(node, &clk_pll_ops);
+}
diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index e1284fb..6217d5d 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -21,354 +21,12 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/regmap.h>
 
-/* Clock Manager offsets */
-#define CLKMGR_CTRL	0x0
-#define CLKMGR_BYPASS	0x4
-#define CLKMGR_L4SRC	0x70
-#define CLKMGR_PERPLL_SRC	0xAC
+#include "clk.h"
 
-/* Clock bypass bits */
-#define MAINPLL_BYPASS		(1<<0)
-#define SDRAMPLL_BYPASS		(1<<1)
-#define SDRAMPLL_SRC_BYPASS	(1<<2)
-#define PERPLL_BYPASS		(1<<3)
-#define PERPLL_SRC_BYPASS	(1<<4)
-
-#define SOCFPGA_PLL_BG_PWRDWN		0
-#define SOCFPGA_PLL_EXT_ENA		1
-#define SOCFPGA_PLL_PWR_DOWN		2
-#define SOCFPGA_PLL_DIVF_MASK		0x0000FFF8
-#define SOCFPGA_PLL_DIVF_SHIFT	3
-#define SOCFPGA_PLL_DIVQ_MASK		0x003F0000
-#define SOCFPGA_PLL_DIVQ_SHIFT	16
-#define SOCFPGA_MAX_PARENTS	3
-
-#define SOCFPGA_L4_MP_CLK		"l4_mp_clk"
-#define SOCFPGA_L4_SP_CLK		"l4_sp_clk"
-#define SOCFPGA_NAND_CLK		"nand_clk"
-#define SOCFPGA_NAND_X_CLK		"nand_x_clk"
-#define SOCFPGA_MMC_CLK			"sdmmc_clk"
-#define SOCFPGA_GPIO_DB_CLK_OFFSET	0xA8
-
-#define div_mask(width)	((1 << (width)) - 1)
-#define streq(a, b) (strcmp((a), (b)) == 0)
-
-/* SDMMC Group for System Manager defines */
-#define SYSMGR_SDMMCGRP_CTRL_OFFSET	0x108
-#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)	\
-	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
-
-static void __iomem *clk_mgr_base_addr;
-
-struct socfpga_clk {
-	struct clk_gate hw;
-	char *parent_name;
-	u32 fixed_div;
-	void __iomem *div_reg;
-	u32 width;	/* only valid if div_reg != 0 */
-	u32 shift;	/* only valid if div_reg != 0 */
-	u32 clk_phase[2];
-};
-#define to_socfpga_clk(p) container_of(p, struct socfpga_clk, hw.hw)
-
-static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
-					 unsigned long parent_rate)
-{
-	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
-	unsigned long divf, divq, vco_freq, reg;
-	unsigned long bypass;
-
-	reg = readl(socfpgaclk->hw.reg);
-	bypass = readl(clk_mgr_base_addr + CLKMGR_BYPASS);
-	if (bypass & MAINPLL_BYPASS)
-		return parent_rate;
-
-	divf = (reg & SOCFPGA_PLL_DIVF_MASK) >> SOCFPGA_PLL_DIVF_SHIFT;
-	divq = (reg & SOCFPGA_PLL_DIVQ_MASK) >> SOCFPGA_PLL_DIVQ_SHIFT;
-	vco_freq = parent_rate * (divf + 1);
-	return vco_freq / (1 + divq);
-}
-
-
-static struct clk_ops clk_pll_ops = {
-	.recalc_rate = clk_pll_recalc_rate,
-};
-
-static unsigned long clk_periclk_recalc_rate(struct clk_hw *hwclk,
-					     unsigned long parent_rate)
-{
-	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
-	u32 div;
-
-	if (socfpgaclk->fixed_div)
-		div = socfpgaclk->fixed_div;
-	else
-		div = ((readl(socfpgaclk->hw.reg) & 0x1ff) + 1);
-
-	return parent_rate / div;
-}
-
-static const struct clk_ops periclk_ops = {
-	.recalc_rate = clk_periclk_recalc_rate,
-};
-
-static __init struct clk *socfpga_clk_init(struct device_node *node,
-	const struct clk_ops *ops)
-{
-	u32 reg;
-	struct clk *clk;
-	struct socfpga_clk *socfpga_clk;
-	const char *clk_name = node->name;
-	const char *parent_name;
-	struct clk_init_data init;
-	int rc;
-	u32 fixed_div;
-
-	rc = of_property_read_u32(node, "reg", &reg);
-	if (WARN_ON(rc))
-		return NULL;
-
-	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
-	if (WARN_ON(!socfpga_clk))
-		return NULL;
-
-	socfpga_clk->hw.reg = clk_mgr_base_addr + reg;
-
-	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
-	if (rc)
-		socfpga_clk->fixed_div = 0;
-	else
-		socfpga_clk->fixed_div = fixed_div;
-
-	of_property_read_string(node, "clock-output-names", &clk_name);
-
-	init.name = clk_name;
-	init.ops = ops;
-	init.flags = 0;
-	parent_name = of_clk_get_parent_name(node, 0);
-	init.parent_names = &parent_name;
-	init.num_parents = 1;
-
-	socfpga_clk->hw.hw.init = &init;
-
-	if (streq(clk_name, "main_pll") ||
-		streq(clk_name, "periph_pll") ||
-		streq(clk_name, "sdram_pll")) {
-		socfpga_clk->hw.bit_idx = SOCFPGA_PLL_EXT_ENA;
-		clk_pll_ops.enable = clk_gate_ops.enable;
-		clk_pll_ops.disable = clk_gate_ops.disable;
-	}
-
-	clk = clk_register(NULL, &socfpga_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
-		kfree(socfpga_clk);
-		return NULL;
-	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	return clk;
-}
-
-static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
-{
-	u32 l4_src;
-	u32 perpll_src;
-
-	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
-		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		return l4_src &= 0x1;
-	}
-	if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
-		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		return !!(l4_src & 2);
-	}
-
-	perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-	if (streq(hwclk->init->name, SOCFPGA_MMC_CLK))
-		return perpll_src &= 0x3;
-	if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
-			streq(hwclk->init->name, SOCFPGA_NAND_X_CLK))
-			return (perpll_src >> 2) & 3;
-
-	/* QSPI clock */
-	return (perpll_src >> 4) & 3;
-
-}
-
-static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
-{
-	u32 src_reg;
-
-	if (streq(hwclk->init->name, SOCFPGA_L4_MP_CLK)) {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		src_reg &= ~0x1;
-		src_reg |= parent;
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
-	} else if (streq(hwclk->init->name, SOCFPGA_L4_SP_CLK)) {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		src_reg &= ~0x2;
-		src_reg |= (parent << 1);
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
-	} else {
-		src_reg = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-		if (streq(hwclk->init->name, SOCFPGA_MMC_CLK)) {
-			src_reg &= ~0x3;
-			src_reg |= parent;
-		} else if (streq(hwclk->init->name, SOCFPGA_NAND_CLK) ||
-			streq(hwclk->init->name, SOCFPGA_NAND_X_CLK)) {
-			src_reg &= ~0xC;
-			src_reg |= (parent << 2);
-		} else {/* QSPI clock */
-			src_reg &= ~0x30;
-			src_reg |= (parent << 4);
-		}
-		writel(src_reg, clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-	}
-
-	return 0;
-}
-
-static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
-	unsigned long parent_rate)
-{
-	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
-	u32 div = 1, val;
-
-	if (socfpgaclk->fixed_div)
-		div = socfpgaclk->fixed_div;
-	else if (socfpgaclk->div_reg) {
-		val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
-		val &= div_mask(socfpgaclk->width);
-		/* Check for GPIO_DB_CLK by its offset */
-		if ((int) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
-			div = val + 1;
-		else
-			div = (1 << val);
-	}
-
-	return parent_rate / div;
-}
-
-static int socfpga_clk_prepare(struct clk_hw *hwclk)
-{
-	struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
-	struct regmap *sys_mgr_base_addr;
-	u32 hs_timing;
-
-	if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
-		sys_mgr_base_addr = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
-		if (IS_ERR(sys_mgr_base_addr)) {
-			pr_err("%s: failed to find altr,sys-mgr regmap!\n", __func__);
-			return -EINVAL;
-		}
-		hs_timing = SYSMGR_SDMMC_CTRL_SET(socfpgaclk->clk_phase[0],
-						socfpgaclk->clk_phase[1]);
-		regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
-						hs_timing);
-	}
-	return 0;
-}
-
-static struct clk_ops gateclk_ops = {
-	.prepare = socfpga_clk_prepare,
-	.recalc_rate = socfpga_clk_recalc_rate,
-	.get_parent = socfpga_clk_get_parent,
-	.set_parent = socfpga_clk_set_parent,
-};
-
-static void __init socfpga_gate_clk_init(struct device_node *node,
-	const struct clk_ops *ops)
-{
-	u32 clk_gate[2];
-	u32 div_reg[3];
-	u32 clk_phase[2];
-	u32 fixed_div;
-	struct clk *clk;
-	struct socfpga_clk *socfpga_clk;
-	const char *clk_name = node->name;
-	const char *parent_name[SOCFPGA_MAX_PARENTS];
-	struct clk_init_data init;
-	int rc;
-	int i = 0;
-
-	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
-	if (WARN_ON(!socfpga_clk))
-		return;
-
-	rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
-	if (rc)
-		clk_gate[0] = 0;
-
-	if (clk_gate[0]) {
-		socfpga_clk->hw.reg = clk_mgr_base_addr + clk_gate[0];
-		socfpga_clk->hw.bit_idx = clk_gate[1];
-
-		gateclk_ops.enable = clk_gate_ops.enable;
-		gateclk_ops.disable = clk_gate_ops.disable;
-	}
-
-	rc = of_property_read_u32(node, "fixed-divider", &fixed_div);
-	if (rc)
-		socfpga_clk->fixed_div = 0;
-	else
-		socfpga_clk->fixed_div = fixed_div;
-
-	rc = of_property_read_u32_array(node, "div-reg", div_reg, 3);
-	if (!rc) {
-		socfpga_clk->div_reg = clk_mgr_base_addr + div_reg[0];
-		socfpga_clk->shift = div_reg[1];
-		socfpga_clk->width = div_reg[2];
-	} else {
-		socfpga_clk->div_reg = 0;
-	}
-
-	rc = of_property_read_u32_array(node, "clk-phase", clk_phase, 2);
-	if (!rc) {
-		socfpga_clk->clk_phase[0] = clk_phase[0];
-		socfpga_clk->clk_phase[1] = clk_phase[1];
-	}
-
-	of_property_read_string(node, "clock-output-names", &clk_name);
-
-	init.name = clk_name;
-	init.ops = ops;
-	init.flags = 0;
-	while (i < SOCFPGA_MAX_PARENTS && (parent_name[i] =
-			of_clk_get_parent_name(node, i)) != NULL)
-		i++;
-
-	init.parent_names = parent_name;
-	init.num_parents = i;
-	socfpga_clk->hw.hw.init = &init;
-
-	clk = clk_register(NULL, &socfpga_clk->hw.hw);
-	if (WARN_ON(IS_ERR(clk))) {
-		kfree(socfpga_clk);
-		return;
-	}
-	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	if (WARN_ON(rc))
-		return;
-}
-
-static void __init socfpga_pll_init(struct device_node *node)
-{
-	socfpga_clk_init(node, &clk_pll_ops);
-}
-
-static void __init socfpga_periph_init(struct device_node *node)
-{
-	socfpga_clk_init(node, &periclk_ops);
-}
-
-static void __init socfpga_gate_init(struct device_node *node)
-{
-	socfpga_gate_clk_init(node, &gateclk_ops);
-}
+void __iomem *clk_mgr_base_addr;
 
 static struct of_device_id socfpga_child_clocks[] = {
 	{ .compatible = "altr,socfpga-pll-clock", socfpga_pll_init, },
diff --git a/drivers/clk/socfpga/clk.h b/drivers/clk/socfpga/clk.h
new file mode 100644
index 0000000..d2e5401
--- /dev/null
+++ b/drivers/clk/socfpga/clk.h
@@ -0,0 +1,57 @@
+/*
+ * Copyright (c) 2013, Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * based on drivers/clk/tegra/clk.h
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef __SOCFPGA_CLK_H
+#define __SOCFPGA_CLK_H
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+/* Clock Manager offsets */
+#define CLKMGR_CTRL		0x0
+#define CLKMGR_BYPASS		0x4
+#define CLKMGR_L4SRC		0x70
+#define CLKMGR_PERPLL_SRC	0xAC
+
+#define SOCFPGA_MAX_PARENTS		3
+
+extern void __iomem *clk_mgr_base_addr;
+
+void __init socfpga_pll_init(struct device_node *node);
+void __init socfpga_periph_init(struct device_node *node);
+void __init socfpga_gate_init(struct device_node *node);
+
+struct socfpga_pll {
+	struct clk_gate	hw;
+};
+
+struct socfpga_gate_clk {
+	struct clk_gate hw;
+	char *parent_name;
+	u32 fixed_div;
+	void __iomem *div_reg;
+	u32 width;	/* only valid if div_reg != 0 */
+	u32 shift;	/* only valid if div_reg != 0 */
+	u32 clk_phase[2];
+};
+
+struct socfpga_periph_clk {
+	struct clk_gate hw;
+	char *parent_name;
+	u32 fixed_div;
+};
+
+#endif /* SOCFPGA_CLK_H */
-- 
1.8.5.1
