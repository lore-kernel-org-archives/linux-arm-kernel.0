From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Thu, 15 May 2014 14:20:37 +0200
Subject: [PATCH] clk: shmobile: Add R8A7740-specific clock support
Message-ID: <1400156437-19694-1-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver for the R8A7740's clocks that are too specific to be supported by a
generic driver.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 .../bindings/clock/renesas,r8a7740-cpg-clocks.txt  |  39 ++++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7740.c                 | 196 +++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a7740.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
new file mode 100644
index 0000000..c009d13
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a7740-cpg-clocks.txt
@@ -0,0 +1,39 @@
+* Renesas R8A7740  Clock Pulse Generator (CPG)
+
+The CPG generates core clocks for the R8A7740 SoC. It includes three PLLs
+and several fixed ratio and variable ratio dividers.
+
+Required Properties:
+
+  - compatible: Must be "renesas,r8a7740-cpg-clocks"
+
+  - reg: Base address and length of the memory resource used by the CPG
+
+  - clocks: Reference to the two parent clocks
+  - #clock-cells: Must be 1
+  - clock-output-names: The names of the clocks. Supported clocks are
+    "system", "pllc0", "pllc1", "pllc2", "r", "usb24s", "i", "zg", "b",
+    "m1", "hp", "hpp", "usbp", "s", "zb", "m3", and "cp".
+
+  - renesas,mode: board-specific settings of the MD_CK* bits
+
+
+Example
+-------
+
+cpg_clocks: cpg_clocks at e6150000 {
+        compatible = "renesas,r8a7740-cpg-clocks";
+        reg = <0xe6150000 0x10000>;
+        clocks = <&extal1_clk>, <&extalr_clk>;
+        #clock-cells = <1>;
+        clock-output-names = "system", "pllc0", "pllc1",
+                             "pllc2", "r",
+                             "usb24s",
+                             "i", "zg", "b", "m1", "hp",
+                             "hpp", "usbp", "s", "zb", "m3",
+                             "cp";
+};
+
+&cpg_clocks {
+	renesas,mode = <0x05>;
+};
diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 5404cb9..20388e8 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
+obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
diff --git a/drivers/clk/shmobile/clk-r8a7740.c b/drivers/clk/shmobile/clk-r8a7740.c
new file mode 100644
index 0000000..5c2ab00
--- /dev/null
+++ b/drivers/clk/shmobile/clk-r8a7740.c
@@ -0,0 +1,196 @@
+/*
+ * r8a7740 Core CPG Clocks
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
+struct r8a7740_cpg {
+	struct clk_onecell_data data;
+	spinlock_t lock;
+	void __iomem *reg;
+};
+
+#define CPG_FRQCRA	0
+#define CPG_FRQCRB	4
+#define CPG_PLLC2CR	0x2c
+#define CPG_USBCKCR	0x8c
+#define CPG_FRQCRC	0xe0
+
+#define CLK_ENABLE_ON_INIT BIT(0)
+
+struct div4_clk {
+	const char *name;
+	unsigned int reg;
+	unsigned int shift;
+	unsigned int mask;
+	int flags;
+};
+
+static struct div4_clk div4_clks[] = {
+	{ "i", CPG_FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT },
+	{ "zg", CPG_FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT },
+	{ "b", CPG_FRQCRA,  8, 0x6fff, CLK_ENABLE_ON_INIT },
+	{ "m1", CPG_FRQCRA,  4, 0x6fff, CLK_ENABLE_ON_INIT },
+	{ "hp", CPG_FRQCRB,  4, 0x6fff, 0 },
+	{ "hpp", CPG_FRQCRC, 20, 0x6fff, 0 },
+	{ "usbp", CPG_FRQCRC, 16, 0x6fff, 0 },
+	{ "s", CPG_FRQCRC, 12, 0x6fff, 0 },
+	{ "zb", CPG_FRQCRC,  8, 0x6fff, 0 },
+	{ "m3", CPG_FRQCRC,  4, 0x6fff, 0 },
+	{ "cp", CPG_FRQCRC,  0, 0x6fff, 0 },
+	{ NULL, 0, 0, 0, 0 },
+};
+
+static const struct clk_div_table div4_div_table[] = {
+	{ 0, 2 }, { 1, 3 }, { 2, 4 }, { 3, 6 }, { 4, 8 }, { 5, 12 },
+	{ 6, 16 }, { 7, 18 }, { 8, 24 }, { 9, 32 }, { 10, 36 }, { 11, 48 },
+	{ 13, 72 }, { 14, 96 }, { 0, 0 }
+};
+
+static u32 cpg_mode __initdata;
+
+static struct clk * __init
+r8a7740_cpg_register_clock(struct device_node *np, struct r8a7740_cpg *cpg,
+			     const char *name)
+{
+	const struct clk_div_table *table = NULL;
+	const char *parent_name;
+	unsigned int shift, reg;
+	unsigned int mult = 1;
+	unsigned int div = 1;
+
+	if (!strcmp(name, "r")) {
+		switch (cpg_mode & (BIT(2) | BIT(1))) {
+		case BIT(1) | BIT(2):
+			parent_name = of_clk_get_parent_name(np, 0);
+			div = 2048;
+			break;
+		case BIT(2):
+			parent_name = of_clk_get_parent_name(np, 0);
+			div = 1024;
+			break;
+		default:
+			parent_name = of_clk_get_parent_name(np, 1);
+			break;
+		}
+	} else if (!strcmp(name, "system")) {
+		parent_name = of_clk_get_parent_name(np, 0);
+		if (cpg_mode & BIT(1))
+			div = 2;
+	} else if (!strcmp(name, "pllc0")) {
+		/* PLLC0/1 are configurable multiplier clocks. Register them as
+		 * fixed factor clocks for now as there's no generic multiplier
+		 * clock implementation and we currently have no need to change
+		 * the multiplier value.
+		 */
+		u32 value = clk_readl(cpg->reg + CPG_FRQCRC);
+		parent_name = "system";
+		mult = ((value >> 24) & 0x7f) + 1;
+	} else if (!strcmp(name, "pllc1")) {
+		u32 value = clk_readl(cpg->reg + CPG_FRQCRA);
+		parent_name = "system";
+		mult = ((value >> 24) & 0x7f) + 1;
+		div = 2;
+	} else if (!strcmp(name, "pllc2")) {
+		u32 value = clk_readl(cpg->reg + CPG_PLLC2CR);
+		parent_name = "system";
+		mult = ((value >> 24) & 0x3f) + 1;
+	} else if (!strcmp(name, "usb24s")) {
+		u32 value = clk_readl(cpg->reg + CPG_USBCKCR);
+		if (value & BIT(7))
+			parent_name = "extal2";
+		else
+			parent_name = "system";
+		if (!(value & BIT(6)))
+			div = 2;
+	} else {
+		struct div4_clk *c;
+		for (c = div4_clks; c->name; c++) {
+			if (!strcmp(name, c->name)) {
+				parent_name = "pllc1";
+				table = div4_div_table;
+				reg = c->reg;
+				shift = c->shift;
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
+						  cpg->reg + reg, shift, 4, 0,
+						  table, &cpg->lock);
+	}
+}
+
+static void __init r8a7740_cpg_clocks_init(struct device_node *np)
+{
+	struct r8a7740_cpg *cpg;
+	struct clk **clks;
+	unsigned int i;
+	int num_clks;
+
+	if (of_property_read_u32(np, "renesas,mode", &cpg_mode))
+		pr_warn("%s: missing renesas,mode property\n", __func__);
+
+	num_clks = of_property_count_strings(np, "clock-output-names");
+	if (num_clks < 0) {
+		pr_err("%s: failed to count clocks\n", __func__);
+		return;
+	}
+
+	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
+	clks = kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
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
+	for (i = 0; i < num_clks; ++i) {
+		const char *name;
+		struct clk *clk;
+
+		of_property_read_string_index(np, "clock-output-names", i,
+					      &name);
+
+		clk = r8a7740_cpg_register_clock(np, cpg, name);
+		if (IS_ERR(clk))
+			pr_err("%s: failed to register %s %s clock (%ld)\n",
+			       __func__, np->name, name, PTR_ERR(clk));
+		else
+			cpg->data.clks[i] = clk;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+}
+CLK_OF_DECLARE(r8a7740_cpg_clks, "renesas,r8a7740-cpg-clocks",
+	       r8a7740_cpg_clocks_init);
-- 
1.8.4.5
