From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:46:54 +0900
Subject: [PATCH 1/6] clk: shmobile: sh73a0 common clock framework
 implementation
In-Reply-To: <cover.1419809955.git.horms+renesas@verge.net.au>
References: <cover.1419809955.git.horms+renesas@verge.net.au>
Message-ID: <ae073881aa7d2f744fa703ae47371611780e4e44.1419809955.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Driver for the SH73A0's clocks that are too specific to be supported by a
generic driver.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Mike Turquette <mturquette@linaro.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/clock/renesas,sh73a0-cpg-clocks.txt   |  35 ++++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-sh73a0.c                  | 218 +++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-sh73a0.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
new file mode 100644
index 0000000..a8978ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,sh73a0-cpg-clocks.txt
@@ -0,0 +1,35 @@
+These bindings should be considered EXPERIMENTAL for now.
+
+* Renesas SH73A0 Clock Pulse Generator (CPG)
+
+The CPG generates core clocks for the SH73A0 SoC. It includes four PLLs
+and several fixed ratio dividers.
+
+Required Properties:
+
+  - compatible: Must be "renesas,sh73a0-cpg-clocks"
+
+  - reg: Base address and length of the memory resource used by the CPG
+
+  - clocks: Reference to the parent clocks ("extal1" and "extal2")
+
+  - #clock-cells: Must be 1
+
+  - clock-output-names: The names of the clocks. Supported clocks are "main",
+    "pll0", "pll1", "pll2", "pll3", "dsi0phy", "dsi1phy", "zg", "m3", "b",
+    "m1", "m2", "z", "zx", and "hp".
+
+
+Example
+-------
+
+        cpg_clocks: cpg_clocks at e6150000 {
+                compatible = "renesas,sh73a0-cpg-clocks";
+                reg = <0 0xe6150000 0 0x10000>;
+                clocks = <&extal1_clk>, <&extal2_clk>;
+                #clock-cells = <1>;
+                clock-output-names = "main", "pll0", "pll1", "pll2",
+                                     "pll3", "dsi0phy", "dsi1phy",
+                                     "zg", "m3", "b", "m1", "m2",
+                                     "z", "zx", "hp";
+        };
diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 960bf22..f83980f 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o
+obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
diff --git a/drivers/clk/shmobile/clk-sh73a0.c b/drivers/clk/shmobile/clk-sh73a0.c
new file mode 100644
index 0000000..8574a6d
--- /dev/null
+++ b/drivers/clk/shmobile/clk-sh73a0.c
@@ -0,0 +1,218 @@
+/*
+ * sh73a0 Core CPG Clocks
+ *
+ * Copyright (C) 2014  Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/shmobile.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/spinlock.h>
+
+struct sh73a0_cpg {
+	struct clk_onecell_data data;
+	spinlock_t lock;
+	void __iomem *reg;
+};
+
+#define CPG_FRQCRA	0x00
+#define CPG_FRQCRB	0x04
+#define CPG_SD0CKCR	0x74
+#define CPG_SD1CKCR	0x78
+#define CPG_SD2CKCR	0x7c
+#define CPG_PLLECR	0xd0
+#define CPG_PLL0CR	0xd8
+#define CPG_PLL1CR	0x28
+#define CPG_PLL2CR	0x2c
+#define CPG_PLL3CR	0xdc
+#define CPG_CKSCR	0xc0
+#define CPG_DSI0PHYCR	0x6c
+#define CPG_DSI1PHYCR	0x70
+
+#define CLK_ENABLE_ON_INIT BIT(0)
+
+struct div4_clk {
+	const char *name;
+	const char *parent;
+	unsigned int reg;
+	unsigned int shift;
+};
+
+static struct div4_clk div4_clks[] = {
+	{ "zg", "pll0", CPG_FRQCRA, 16 },
+	{ "m3", "pll1", CPG_FRQCRA, 12 },
+	{ "b",  "pll1", CPG_FRQCRA,  8 },
+	{ "m1", "pll1", CPG_FRQCRA,  4 },
+	{ "m2", "pll1", CPG_FRQCRA,  0 },
+	{ "zx", "pll1", CPG_FRQCRB, 12 },
+	{ "hp", "pll1", CPG_FRQCRB,  4 },
+	{ NULL, 0, 0, 0 },
+};
+
+static const struct clk_div_table div4_div_table[] = {
+	{ 0, 2 }, { 1, 3 }, { 2, 4 }, { 3, 6 }, { 4, 8 }, { 5, 12 },
+	{ 6, 16 }, { 7, 18 }, { 8, 24 }, { 10, 36 }, { 11, 48 },
+	{ 12, 7 }, { 0, 0 }
+};
+
+static const struct clk_div_table z_div_table[] = {
+	/* ZSEL == 0 */
+	{ 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 },
+	{ 6, 1 }, { 7, 1 }, { 8, 1 }, { 9, 1 }, { 10, 1 }, { 11, 1 },
+	{ 12, 1 }, { 13, 1 }, { 14, 1 }, { 15, 1 },
+	/* ZSEL == 1 */
+	{ 16, 2 }, { 17, 3 }, { 18, 4 }, { 19, 6 }, { 20, 8 }, { 21, 12 },
+	{ 22, 16 }, { 24, 24 }, { 27, 48 }, { 0, 0 }
+};
+
+static struct clk * __init
+sh73a0_cpg_register_clock(struct device_node *np, struct sh73a0_cpg *cpg,
+			     const char *name)
+{
+	const struct clk_div_table *table = NULL;
+	unsigned int shift, reg, width;
+	const char *parent_name;
+	unsigned int mult = 1;
+	unsigned int div = 1;
+
+	if (!strcmp(name, "main")) {
+		/* extal1, extal1_div2, extal2, extal2_div2 */
+		u32 parent_idx = (clk_readl(cpg->reg + CPG_CKSCR) >> 28) & 3;
+
+		parent_name = of_clk_get_parent_name(np, parent_idx >> 1);
+		div = (parent_idx & 1) + 1;
+	} else if (!strncmp(name, "pll", 3)) {
+		void __iomem *enable_reg = cpg->reg;
+		u32 enable_bit = name[3] - '0';
+
+		parent_name = "main";
+		switch (enable_bit) {
+		case 0:
+			enable_reg += CPG_PLL0CR;
+			break;
+		case 1:
+			enable_reg += CPG_PLL1CR;
+			break;
+		case 2:
+			enable_reg += CPG_PLL2CR;
+			break;
+		case 3:
+			enable_reg += CPG_PLL3CR;
+			break;
+		default:
+			return ERR_PTR(-EINVAL);
+		}
+		if (clk_readl(cpg->reg + CPG_PLLECR) & BIT(enable_bit)) {
+			mult = ((clk_readl(enable_reg) >> 24) & 0x3f) + 1;
+			/* handle CFG bit for PLL1 and PLL2 */
+			if (enable_bit == 1 || enable_bit == 2)
+				if (clk_readl(enable_reg) & BIT(20))
+					mult *= 2;
+		}
+	} else if (!strcmp(name, "dsi0phy") || !strcmp(name, "dsi1phy")) {
+		u32 phy_no = name[3] - '0';
+		void __iomem *dsi_reg = cpg->reg +
+			(phy_no ? CPG_DSI1PHYCR : CPG_DSI0PHYCR);
+
+		parent_name = phy_no ? "dsi1pck" : "dsi0pck";
+		mult = __raw_readl(dsi_reg);
+		if (!(mult & 0x8000))
+			mult = 1;
+		else
+			mult = (mult & 0x3f) + 1;
+	} else if (!strcmp(name, "z")) {
+		parent_name = "pll0";
+		table = z_div_table;
+		reg = CPG_FRQCRB;
+		shift = 24;
+		width = 5;
+	} else {
+		struct div4_clk *c;
+
+		for (c = div4_clks; c->name; c++) {
+			if (!strcmp(name, c->name)) {
+				parent_name = c->parent;
+				table = div4_div_table;
+				reg = c->reg;
+				shift = c->shift;
+				width = 4;
+				break;
+			}
+		}
+		if (!c->name)
+			return ERR_PTR(-EINVAL);
+	}
+
+	if (!table) {
+		return clk_register_fixed_factor(NULL, name, parent_name, 0,
+						 mult, div);
+	} else {
+		return clk_register_divider_table(NULL, name, parent_name, 0,
+						  cpg->reg + reg, shift, width, 0,
+						  table, &cpg->lock);
+	}
+}
+
+static void __init sh73a0_cpg_clocks_init(struct device_node *np)
+{
+	struct sh73a0_cpg *cpg;
+	struct clk **clks;
+	unsigned int i;
+	int num_clks;
+
+	num_clks = of_property_count_strings(np, "clock-output-names");
+	if (num_clks < 0) {
+		pr_err("%s: failed to count clocks\n", __func__);
+		return;
+	}
+
+	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
+	clks = kcalloc(num_clks, sizeof(*clks), GFP_KERNEL);
+	if (cpg == NULL || clks == NULL) {
+		/* We're leaking memory on purpose, there's no point in cleaning
+		 * up as the system won't boot anyway.
+		 */
+		return;
+	}
+
+	spin_lock_init(&cpg->lock);
+
+	cpg->data.clks = clks;
+	cpg->data.clk_num = num_clks;
+
+	cpg->reg = of_iomap(np, 0);
+	if (WARN_ON(cpg->reg == NULL))
+		return;
+
+	/* Set SDHI clocks to a known state */
+	clk_writel(0x108, cpg->reg + CPG_SD0CKCR);
+	clk_writel(0x108, cpg->reg + CPG_SD1CKCR);
+	clk_writel(0x108, cpg->reg + CPG_SD2CKCR);
+
+	for (i = 0; i < num_clks; ++i) {
+		const char *name;
+		struct clk *clk;
+
+		of_property_read_string_index(np, "clock-output-names", i,
+					      &name);
+
+		clk = sh73a0_cpg_register_clock(np, cpg, name);
+		if (IS_ERR(clk))
+			pr_err("%s: failed to register %s %s clock (%ld)\n",
+			       __func__, np->name, name, PTR_ERR(clk));
+		else
+			cpg->data.clks[i] = clk;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+}
+CLK_OF_DECLARE(sh73a0_cpg_clks, "renesas,sh73a0-cpg-clocks",
+	       sh73a0_cpg_clocks_init);
-- 
2.1.3
