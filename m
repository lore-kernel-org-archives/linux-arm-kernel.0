From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Jul 2015 23:14:30 +0200
Subject: [PATCH 7/7] clk: sunxi: Add a simple gates driver
In-Reply-To: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1437945270-32014-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1437945270-32014-8-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gates were handled with a common piece of framework that was
registering all gates array, that was not using the CLK_OF_DECLARE logic,
and was not using clock-indices but some private masks that were pretty
much equivalent.

Move this code in a new driver that handles all the gates array and solves
both these issues.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi/Makefile           |   1 +
 drivers/clk/sunxi/clk-simple-gates.c | 159 +++++++++++++++++++++++++++++++
 drivers/clk/sunxi/clk-sunxi.c        | 177 -----------------------------------
 3 files changed, 160 insertions(+), 177 deletions(-)
 create mode 100644 drivers/clk/sunxi/clk-simple-gates.c

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 058f273d6154..f5a35b82cc1a 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -6,6 +6,7 @@ obj-y += clk-sunxi.o clk-factors.o
 obj-y += clk-a10-hosc.o
 obj-y += clk-a20-gmac.o
 obj-y += clk-mod0.o
+obj-y += clk-simple-gates.o
 obj-y += clk-sun8i-mbus.o
 obj-y += clk-sun9i-core.o
 obj-y += clk-sun9i-mmc.o
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
new file mode 100644
index 000000000000..1a3963a8a686
--- /dev/null
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -0,0 +1,159 @@
+/*
+ * Copyright 2015 Maxime Ripard
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
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+#include <linux/log2.h>
+
+static DEFINE_SPINLOCK(gates_lock);
+
+static void __init sunxi_simple_gates_setup(struct device_node *node,
+					    const int protected[],
+					    int nprotected)
+{
+	struct clk_onecell_data *clk_data;
+	const char *clk_parent, *clk_name;
+	struct property *prop;
+	struct resource res;
+	void __iomem *clk_reg;
+	void __iomem *reg;
+	const __be32 *p;
+	int number, i = 0, j;
+	u8 clk_bit;
+	u32 index;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg))
+		return;
+
+	clk_parent = of_clk_get_parent_name(node, 0);
+
+	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	if (!clk_data)
+		goto err_unmap;
+
+	number = of_property_count_u32_elems(node, "clock-indices");
+	of_property_read_u32_index(node, "clock-indices", number - 1, &number);
+
+	clk_data->clks = kcalloc(number + 1, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_data->clks)
+		goto err_free_data;
+
+	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
+		of_property_read_string_index(node, "clock-output-names",
+					      i, &clk_name);
+
+		clk_reg = reg + 4 * (index / 32);
+		clk_bit = index % 32;
+
+		clk_data->clks[index] = clk_register_gate(NULL, clk_name,
+							  clk_parent, 0,
+							  clk_reg,
+							  clk_bit,
+							  0, &gates_lock);
+		i++;
+
+		if (IS_ERR(clk_data->clks[index])) {
+			WARN_ON(true);
+			continue;
+		}
+
+		for (j = 0; j < nprotected; j++)
+			if (protected[j] == index)
+				clk_prepare_enable(clk_data->clks[index]);
+
+	}
+
+	clk_data->clk_num = number + 1;
+	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+
+	return;
+
+err_free_data:
+	kfree(clk_data);
+err_unmap:
+	iounmap(reg);
+	of_address_to_resource(node, 0, &res);
+	release_mem_region(res.start, resource_size(&res));
+}
+
+static void __init sunxi_simple_gates_init(struct device_node *node)
+{
+	sunxi_simple_gates_setup(node, NULL, 0);
+}
+
+CLK_OF_DECLARE(sun4i_a10_apb0, "allwinner,sun4i-a10-apb0-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun4i_a10_apb1, "allwinner,sun4i-a10-apb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun4i_a10_axi, "allwinner,sun4i-a10-axi-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun5i_a10s_apb0, "allwinner,sun5i-a10s-apb0-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun5i_a10s_apb1, "allwinner,sun5i-a10s-apb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun5i_a13_apb0, "allwinner,sun5i-a13-apb0-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun5i_a13_apb1, "allwinner,sun5i-a13-apb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun6i_a31_ahb1, "allwinner,sun6i-a31-ahb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun6i_a31_apb1, "allwinner,sun6i-a31-apb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun6i_a31_apb2, "allwinner,sun6i-a31-apb2-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun7i_a20_apb0, "allwinner,sun7i-a20-apb0-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun7i_a20_apb1, "allwinner,sun7i-a20-apb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun8i_a23_ahb1, "allwinner,sun8i-a23-ahb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun8i_a23_apb1, "allwinner,sun8i-a23-apb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun8i_a23_apb2, "allwinner,sun8i-a23-apb2-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun9i_a80_ahb0, "allwinner,sun9i-a80-ahb0-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun9i_a80_ahb1, "allwinner,sun9i-a80-ahb1-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun9i_a80_ahb2, "allwinner,sun9i-a80-ahb2-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-gates-clk",
+	       sunxi_simple_gates_init);
+CLK_OF_DECLARE(sun9i_a80_apb1, "allwinner,sun9i-a80-apb1-gates-clk",
+	       sunxi_simple_gates_init);
+
+static const int sun4i_a10_ahb_critical_clocks[] __initdata = {
+	14,	/* ahb_sdram */
+};
+
+static void __init sun4i_a10_ahb_init(struct device_node *node)
+{
+	sunxi_simple_gates_setup(node, sun4i_a10_ahb_critical_clocks,
+				 ARRAY_SIZE(sun4i_a10_ahb_critical_clocks));
+}
+CLK_OF_DECLARE(sun4i_a10_ahb, "allwinner,sun4i-a10-ahb-gates-clk",
+	       sun4i_a10_ahb_init);
+CLK_OF_DECLARE(sun5i_a10s_ahb, "allwinner,sun5i-a10s-ahb-gates-clk",
+	       sun4i_a10_ahb_init);
+CLK_OF_DECLARE(sun5i_a13_ahb, "allwinner,sun5i-a13-ahb-gates-clk",
+	       sun4i_a10_ahb_init);
+CLK_OF_DECLARE(sun7i_a20_ahb, "allwinner,sun7i-a20-ahb-gates-clk",
+	       sun4i_a10_ahb_init);
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index abf7b37faf73..1fec91093fcd 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -900,150 +900,6 @@ struct gates_data {
 	DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
 };
 
-static const struct gates_data sun4i_axi_gates_data __initconst = {
-	.mask = {1},
-};
-
-static const struct gates_data sun4i_ahb_gates_data __initconst = {
-	.mask = {0x7F77FFF, 0x14FB3F},
-};
-
-static const struct gates_data sun5i_a10s_ahb_gates_data __initconst = {
-	.mask = {0x147667e7, 0x185915},
-};
-
-static const struct gates_data sun5i_a13_ahb_gates_data __initconst = {
-	.mask = {0x107067e7, 0x185111},
-};
-
-static const struct gates_data sun6i_a31_ahb1_gates_data __initconst = {
-	.mask = {0xEDFE7F62, 0x794F931},
-};
-
-static const struct gates_data sun7i_a20_ahb_gates_data __initconst = {
-	.mask = { 0x12f77fff, 0x16ff3f },
-};
-
-static const struct gates_data sun8i_a23_ahb1_gates_data __initconst = {
-	.mask = {0x25386742, 0x2505111},
-};
-
-static const struct gates_data sun9i_a80_ahb0_gates_data __initconst = {
-	.mask = {0xF5F12B},
-};
-
-static const struct gates_data sun9i_a80_ahb1_gates_data __initconst = {
-	.mask = {0x1E20003},
-};
-
-static const struct gates_data sun9i_a80_ahb2_gates_data __initconst = {
-	.mask = {0x9B7},
-};
-
-static const struct gates_data sun4i_apb0_gates_data __initconst = {
-	.mask = {0x4EF},
-};
-
-static const struct gates_data sun5i_a10s_apb0_gates_data __initconst = {
-	.mask = {0x469},
-};
-
-static const struct gates_data sun5i_a13_apb0_gates_data __initconst = {
-	.mask = {0x61},
-};
-
-static const struct gates_data sun7i_a20_apb0_gates_data __initconst = {
-	.mask = { 0x4ff },
-};
-
-static const struct gates_data sun9i_a80_apb0_gates_data __initconst = {
-	.mask = {0xEB822},
-};
-
-static const struct gates_data sun4i_apb1_gates_data __initconst = {
-	.mask = {0xFF00F7},
-};
-
-static const struct gates_data sun5i_a10s_apb1_gates_data __initconst = {
-	.mask = {0xf0007},
-};
-
-static const struct gates_data sun5i_a13_apb1_gates_data __initconst = {
-	.mask = {0xa0007},
-};
-
-static const struct gates_data sun6i_a31_apb1_gates_data __initconst = {
-	.mask = {0x3031},
-};
-
-static const struct gates_data sun8i_a23_apb1_gates_data __initconst = {
-	.mask = {0x3021},
-};
-
-static const struct gates_data sun6i_a31_apb2_gates_data __initconst = {
-	.mask = {0x3F000F},
-};
-
-static const struct gates_data sun7i_a20_apb1_gates_data __initconst = {
-	.mask = { 0xff80ff },
-};
-
-static const struct gates_data sun9i_a80_apb1_gates_data __initconst = {
-	.mask = {0x3F001F},
-};
-
-static const struct gates_data sun8i_a23_apb2_gates_data __initconst = {
-	.mask = {0x1F0007},
-};
-
-static void __init sunxi_gates_clk_setup(struct device_node *node,
-					 struct gates_data *data)
-{
-	struct clk_onecell_data *clk_data;
-	const char *clk_parent;
-	const char *clk_name;
-	void __iomem *reg;
-	int qty;
-	int i = 0;
-	int j = 0;
-
-	reg = of_iomap(node, 0);
-
-	clk_parent = of_clk_get_parent_name(node, 0);
-
-	/* Worst-case size approximation and memory allocation */
-	qty = find_last_bit(data->mask, SUNXI_GATES_MAX_SIZE);
-	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
-	if (!clk_data)
-		return;
-	clk_data->clks = kzalloc((qty+1) * sizeof(struct clk *), GFP_KERNEL);
-	if (!clk_data->clks) {
-		kfree(clk_data);
-		return;
-	}
-
-	for_each_set_bit(i, data->mask, SUNXI_GATES_MAX_SIZE) {
-		of_property_read_string_index(node, "clock-output-names",
-					      j, &clk_name);
-
-		clk_data->clks[i] = clk_register_gate(NULL, clk_name,
-						      clk_parent, 0,
-						      reg + 4 * (i/32), i % 32,
-						      0, &clk_lock);
-		WARN_ON(IS_ERR(clk_data->clks[i]));
-		clk_register_clkdev(clk_data->clks[i], clk_name, NULL);
-
-		j++;
-	}
-
-	/* Adjust to the real max */
-	clk_data->clk_num = i;
-
-	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
-}
-
-
-
 /**
  * sunxi_divs_clk_setup() helper data
  */
@@ -1281,34 +1137,6 @@ static const struct of_device_id clk_mux_match[] __initconst = {
 	{}
 };
 
-/* Matches for gate clocks */
-static const struct of_device_id clk_gates_match[] __initconst = {
-	{.compatible = "allwinner,sun4i-a10-axi-gates-clk", .data = &sun4i_axi_gates_data,},
-	{.compatible = "allwinner,sun4i-a10-ahb-gates-clk", .data = &sun4i_ahb_gates_data,},
-	{.compatible = "allwinner,sun5i-a10s-ahb-gates-clk", .data = &sun5i_a10s_ahb_gates_data,},
-	{.compatible = "allwinner,sun5i-a13-ahb-gates-clk", .data = &sun5i_a13_ahb_gates_data,},
-	{.compatible = "allwinner,sun6i-a31-ahb1-gates-clk", .data = &sun6i_a31_ahb1_gates_data,},
-	{.compatible = "allwinner,sun7i-a20-ahb-gates-clk", .data = &sun7i_a20_ahb_gates_data,},
-	{.compatible = "allwinner,sun8i-a23-ahb1-gates-clk", .data = &sun8i_a23_ahb1_gates_data,},
-	{.compatible = "allwinner,sun9i-a80-ahb0-gates-clk", .data = &sun9i_a80_ahb0_gates_data,},
-	{.compatible = "allwinner,sun9i-a80-ahb1-gates-clk", .data = &sun9i_a80_ahb1_gates_data,},
-	{.compatible = "allwinner,sun9i-a80-ahb2-gates-clk", .data = &sun9i_a80_ahb2_gates_data,},
-	{.compatible = "allwinner,sun4i-a10-apb0-gates-clk", .data = &sun4i_apb0_gates_data,},
-	{.compatible = "allwinner,sun5i-a10s-apb0-gates-clk", .data = &sun5i_a10s_apb0_gates_data,},
-	{.compatible = "allwinner,sun5i-a13-apb0-gates-clk", .data = &sun5i_a13_apb0_gates_data,},
-	{.compatible = "allwinner,sun7i-a20-apb0-gates-clk", .data = &sun7i_a20_apb0_gates_data,},
-	{.compatible = "allwinner,sun9i-a80-apb0-gates-clk", .data = &sun9i_a80_apb0_gates_data,},
-	{.compatible = "allwinner,sun4i-a10-apb1-gates-clk", .data = &sun4i_apb1_gates_data,},
-	{.compatible = "allwinner,sun5i-a10s-apb1-gates-clk", .data = &sun5i_a10s_apb1_gates_data,},
-	{.compatible = "allwinner,sun5i-a13-apb1-gates-clk", .data = &sun5i_a13_apb1_gates_data,},
-	{.compatible = "allwinner,sun6i-a31-apb1-gates-clk", .data = &sun6i_a31_apb1_gates_data,},
-	{.compatible = "allwinner,sun7i-a20-apb1-gates-clk", .data = &sun7i_a20_apb1_gates_data,},
-	{.compatible = "allwinner,sun8i-a23-apb1-gates-clk", .data = &sun8i_a23_apb1_gates_data,},
-	{.compatible = "allwinner,sun9i-a80-apb1-gates-clk", .data = &sun9i_a80_apb1_gates_data,},
-	{.compatible = "allwinner,sun6i-a31-apb2-gates-clk", .data = &sun6i_a31_apb2_gates_data,},
-	{.compatible = "allwinner,sun8i-a23-apb2-gates-clk", .data = &sun8i_a23_apb2_gates_data,},
-	{}
-};
 
 static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_match,
 					      void *function)
@@ -1340,9 +1168,6 @@ static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
 	/* Register mux clocks */
 	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
 
-	/* Register gate clocks */
-	of_sunxi_table_clock_setup(clk_gates_match, sunxi_gates_clk_setup);
-
 	/* Protect the clocks that needs to stay on */
 	for (i = 0; i < nclocks; i++) {
 		struct clk *clk = clk_get(NULL, clocks[i]);
@@ -1354,7 +1179,6 @@ static void __init sunxi_init_clocks(const char *clocks[], int nclocks)
 
 static const char *sun4i_a10_critical_clocks[] __initdata = {
 	"pll5_ddr",
-	"ahb_sdram",
 };
 
 static void __init sun4i_a10_init_clocks(struct device_node *node)
@@ -1367,7 +1191,6 @@ CLK_OF_DECLARE(sun4i_a10_clk_init, "allwinner,sun4i-a10", sun4i_a10_init_clocks)
 static const char *sun5i_critical_clocks[] __initdata = {
 	"cpu",
 	"pll5_ddr",
-	"ahb_sdram",
 };
 
 static void __init sun5i_init_clocks(struct device_node *node)
-- 
2.4.6
