From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu,  6 Mar 2014 12:32:21 +0100
Subject: [PATCH V2 01/12] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
References: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394105552-9744-2-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

Changes since V1:
* added docs
* preparation for usb_x1 support by documenting two input clocks
* static-consted frqcr_tab
* bail out if num_clks == 0
* cosmetic fixes

Mike: if you are fine with this driver, it would be good if you could apply it.
Then, we can deal with the orthogonal dependencies in mach-shmobile seperately
and know that the driver is already in place when the rest gets resolved.
Thanks!

 .../bindings/clock/renesas,rz-cpg-clocks.txt       |  29 ++++++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-rz.c                      | 113 +++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-rz.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
new file mode 100644
index 000000000000..c8e8821f08f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt
@@ -0,0 +1,29 @@
+* Renesas RZ Clock Pulse Generator (CPG)
+
+The CPG generates core clocks for the RZ SoCs. It includes the PLL, variable
+CPU and GPU clocks, and several fixed ratio dividers.
+
+Required Properties:
+
+  - compatible: Must be one of
+    - "renesas,r7s72100-cpg-clocks" for the r7s72100 CPG
+    - "renesas,rz-cpg-clocks" for the generic RZ CPG
+  - reg: Base address and length of the memory resource used by the CPG
+  - clocks: References to possible parent clocks. Order must match clock modes
+    in the datasheet.
+  - #clock-cells: Must be 1
+  - clock-output-names: The names of the clocks. Supported clocks are "pll",
+    "i", and "g"
+
+
+Example
+-------
+
+	cpg_clocks: cpg_clocks at fcfe0000 {
+		#clock-cells = <1>;
+		compatible = "renesas,r7s72100-cpg-clocks",
+			     "renesas,rz-cpg-clocks";
+		reg = <0xfcfe0000 0x18>;
+		clocks = <&extal_clk>, <&usb_x1_clk>;
+		clock-output-names = "pll", "i", "g";
+	};
diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 9ecef140dba7..5404cb931ebf 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
+obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
diff --git a/drivers/clk/shmobile/clk-rz.c b/drivers/clk/shmobile/clk-rz.c
new file mode 100644
index 000000000000..2901db3ac5d3
--- /dev/null
+++ b/drivers/clk/shmobile/clk-rz.c
@@ -0,0 +1,113 @@
+/*
+ * rz Core CPG Clocks
+ *
+ * Copyright (C) 2013 Ideas On Board SPRL
+ * Copyright (C) 2014 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+struct rz_cpg {
+	struct clk_onecell_data data;
+	void __iomem *reg;
+};
+
+#define CPG_FRQCR	0x10
+#define CPG_FRQCR2	0x14
+
+/* -----------------------------------------------------------------------------
+ * Initialization
+ */
+
+static struct clk * __init
+rz_cpg_register_clock(struct device_node *np, struct rz_cpg *cpg, const char *name)
+{
+	u32 val;
+	unsigned mult;
+	static const unsigned frqcr_tab[4] = { 3, 2, 0, 1 };
+
+	if (strcmp(name, "pll") == 0) {
+		/* FIXME: cpg_mode should be read from GPIO. But no GPIO support yet */
+		unsigned cpg_mode = 0; /* hardcoded to EXTAL for now */
+		const char *parent_name = of_clk_get_parent_name(np, cpg_mode);
+
+		mult = cpg_mode ? (32 / 4) : 30;
+
+		return clk_register_fixed_factor(NULL, name, parent_name, 0, mult, 1);
+	}
+
+	/* FIXME:"i" and "g" are variable clocks with non-integer dividers (e.g. 2/3)
+	 * and the constraint that always g <= i. To get the rz platform started,
+	 * let them run@fixed current speed and implement the details later.
+	 */
+	if (strcmp(name, "i") == 0)
+		val = (clk_readl(cpg->reg + CPG_FRQCR) >> 8) & 3;
+	else if (strcmp(name, "g") == 0)
+		val = clk_readl(cpg->reg + CPG_FRQCR2) & 3;
+	else
+		return ERR_PTR(-EINVAL);
+
+	mult = frqcr_tab[val];
+	return clk_register_fixed_factor(NULL, name, "pll", 0, mult, 3);
+}
+
+static void __init rz_cpg_clocks_init(struct device_node *np)
+{
+	struct rz_cpg *cpg;
+	struct clk **clks;
+	unsigned i;
+	int num_clks;
+
+	num_clks = of_property_count_strings(np, "clock-output-names");
+	if (WARN(num_clks <= 0, "can't count CPG clocks\n"))
+		goto out;
+
+	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
+	if (WARN(!cpg, "out of memory!\n"))
+		goto out;
+
+	clks = kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
+	if (WARN(!clks, "out of memory!\n"))
+		goto free_cpg;
+
+	cpg->data.clks = clks;
+	cpg->data.clk_num = num_clks;
+
+	cpg->reg = of_iomap(np, 0);
+	if (WARN(!cpg->reg, "can't remap CPG registers!\n"))
+		goto free_clks;
+
+	for (i = 0; i < num_clks; ++i) {
+		const char *name;
+		struct clk *clk;
+
+		of_property_read_string_index(np, "clock-output-names", i, &name);
+
+		clk = rz_cpg_register_clock(np, cpg, name);
+		if (IS_ERR(clk))
+			pr_err("%s: failed to register %s %s clock (%ld)\n",
+			       __func__, np->name, name, PTR_ERR(clk));
+		else
+			cpg->data.clks[i] = clk;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+	return;
+
+free_clks:
+	kfree(clks);
+free_cpg:
+	kfree(cpg);
+out:
+	return;
+}
+CLK_OF_DECLARE(rz_cpg_clks, "renesas,rz-cpg-clocks", rz_cpg_clocks_init);
-- 
1.9.0
