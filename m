From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 22 Feb 2016 18:20:51 +0000
Subject: [PATCH v3 06/10] clk: sunxi: add generic multi-parent bus clock gates
 driver
In-Reply-To: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
References: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1456165255-31013-7-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H3 SoC introduced bus clock gates with potentially
different parents per clock gate. The H3 driver chose to hardcode the
actual parent clock relation in the code.
Add a new driver (which has the potential to drive the H3 and also
the simple clock gates as well) which uses the power of DT to describe
this relationship in an elegant and flexible way.
Using one subnode for every parent clock we get away with a single
DT compatible match, which can be used as a fallback value in the
actual DTs without the need to add specific compatible strings to the
code.  This avoids adding a new driver or function for every new SoC.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/clk/sunxi/Makefile          |   1 +
 drivers/clk/sunxi/clk-multi-gates.c | 105 ++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 drivers/clk/sunxi/clk-multi-gates.c

diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 3fd7901..3a9dc31 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -11,6 +11,7 @@ obj-y += clk-a10-ve.o
 obj-y += clk-a20-gmac.o
 obj-y += clk-mod0.o
 obj-y += clk-simple-gates.o
+obj-y += clk-multi-gates.o
 obj-y += clk-sun8i-bus-gates.o
 obj-y += clk-sun8i-mbus.o
 obj-y += clk-sun9i-core.o
diff --git a/drivers/clk/sunxi/clk-multi-gates.c b/drivers/clk/sunxi/clk-multi-gates.c
new file mode 100644
index 0000000..76e715a
--- /dev/null
+++ b/drivers/clk/sunxi/clk-multi-gates.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2016 ARM Ltd.
+ *
+ * Based on clk-sun8i-bus-gates.c, which is:
+ *  Copyright (C) 2015 Jens Kuske <jenskuske@gmail.com>
+ * Based on clk-simple-gates.c, which is:
+ *  Copyright 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
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
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+static DEFINE_SPINLOCK(gates_lock);
+
+static void __init sunxi_parse_parent(struct device_node *node,
+				      struct clk_onecell_data *clk_data,
+				      void __iomem *reg)
+{
+	const char *parent = of_clk_get_parent_name(node, 0);
+	const char *clk_name;
+	struct property *prop;
+	struct clk *clk;
+	const __be32 *p;
+	int index, i = 0;
+
+	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
+		of_property_read_string_index(node, "clock-output-names",
+					      i, &clk_name);
+
+		clk = clk_register_gate(NULL, clk_name, parent, 0,
+					reg + 4 * (index / 32), index % 32,
+					0, &gates_lock);
+		i++;
+		if (IS_ERR(clk)) {
+			pr_warn("could not register gate clock \"%s\"\n",
+				clk_name);
+			continue;
+		}
+		if (clk_data->clks[index])
+			pr_warn("bus-gate clock %s: index #%d already registered as %s\n",
+				clk_name, index, "?");
+		else
+			clk_data->clks[index] = clk;
+	}
+}
+
+static void __init sunxi_multi_bus_gates_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *child;
+	struct property *prop;
+	struct resource res;
+	void __iomem *reg;
+	const __be32 *p;
+	int number = 0;
+	int index;
+
+	reg = of_io_request_and_map(node, 0, of_node_full_name(node));
+	if (IS_ERR(reg))
+		return;
+
+	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
+	if (!clk_data)
+		goto err_unmap;
+
+	for_each_child_of_node(node, child)
+		of_property_for_each_u32(child, "clock-indices", prop, p, index)
+			number = max(number, index);
+
+	clk_data->clks = kcalloc(number + 1, sizeof(struct clk *), GFP_KERNEL);
+	if (!clk_data->clks)
+		goto err_free_data;
+
+	for_each_child_of_node(node, child)
+		sunxi_parse_parent(child, clk_data, reg);
+
+	clk_data->clk_num = number + 1;
+	if (of_clk_add_provider(node, of_clk_src_onecell_get, clk_data))
+		pr_err("registering bus-gate clock %s failed\n", node->name);
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
+CLK_OF_DECLARE(sunxi_multi_bus_gates, "allwinner,sunxi-multi-bus-gates-clk",
+	       sunxi_multi_bus_gates_init);
-- 
2.6.4
