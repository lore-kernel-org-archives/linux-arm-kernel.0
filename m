From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:11 +0900
Subject: [PATCH 11/16] ARM: shmobile: r8a7778: common clock framework CPG
 driver
In-Reply-To: <cover.1425518337.git.horms+renesas@verge.net.au>
References: <cover.1425518337.git.horms+renesas@verge.net.au>
Message-ID: <6232c51cb370919b116e0aea38d12aa33aae2fa9.1425518337.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Driver for the r8a7778's clocks that depend on the mode bits.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Michael Turquette <mturquette@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |  25 ++++
 drivers/clk/shmobile/Makefile                      |   1 +
 drivers/clk/shmobile/clk-r8a7778.c                 | 143 +++++++++++++++++++++
 include/linux/clk/shmobile.h                       |   1 +
 4 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
 create mode 100644 drivers/clk/shmobile/clk-r8a7778.c

diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
new file mode 100644
index 0000000..2f3747f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,r8a7778-cpg-clocks.txt
@@ -0,0 +1,25 @@
+* Renesas R8A7778 Clock Pulse Generator (CPG)
+
+The CPG generates core clocks for the R8A7778. It includes two PLLs and
+several fixed ratio dividers
+
+Required Properties:
+
+  - compatible: Must be "renesas,r8a7778-cpg-clocks"
+  - reg: Base address and length of the memory resource used by the CPG
+  - #clock-cells: Must be 1
+  - clock-output-names: The names of the clocks. Supported clocks are
+    "plla", "pllb", "b", "out", "p", "s", and "s1".
+
+
+Example
+-------
+
+	cpg_clocks: cpg_clocks at ffc80000 {
+		compatible = "renesas,r8a7778-cpg-clocks";
+		reg = <0xffc80000 0x80>;
+		#clock-cells = <1>;
+		clocks = <&extal_clk>;
+		clock-output-names = "plla", "pllb", "b",
+				     "out", "p", "s", "s1";
+	};
diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 0689d7f..97c71c8 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
 obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7778)		+= clk-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
diff --git a/drivers/clk/shmobile/clk-r8a7778.c b/drivers/clk/shmobile/clk-r8a7778.c
new file mode 100644
index 0000000..cb33b57
--- /dev/null
+++ b/drivers/clk/shmobile/clk-r8a7778.c
@@ -0,0 +1,143 @@
+/*
+ * r8a7778 Core CPG Clocks
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
+#include <linux/of_address.h>
+
+struct r8a7778_cpg {
+	struct clk_onecell_data data;
+	spinlock_t lock;
+	void __iomem *reg;
+};
+
+/* PLL multipliers per bits 11, 12, and 18 of MODEMR */
+struct {
+	unsigned long plla_mult;
+	unsigned long pllb_mult;
+} r8a7778_rates[] __initdata = {
+	[0] = { 21, 21 },
+	[1] = { 24, 24 },
+	[2] = { 28, 28 },
+	[3] = { 32, 32 },
+	[5] = { 24, 21 },
+	[6] = { 28, 21 },
+	[7] = { 32, 24 },
+};
+
+/* Clock dividers per bits 1 and 2 of MODEMR */
+struct {
+	const char *name;
+	unsigned int div[4];
+} r8a7778_divs[6] __initdata = {
+	{ "b",   { 12, 12, 16, 18 } },
+	{ "out", { 12, 12, 16, 18 } },
+	{ "p",   { 16, 12, 16, 12 } },
+	{ "s",   { 4,  3,  4,  3  } },
+	{ "s1",  { 8,  6,  8,  6  } },
+};
+
+static u32 cpg_mode_rates __initdata;
+static u32 cpg_mode_divs __initdata;
+
+static struct clk * __init
+r8a7778_cpg_register_clock(struct device_node *np, struct r8a7778_cpg *cpg,
+			     const char *name)
+{
+	if (!strcmp(name, "plla")) {
+		return clk_register_fixed_factor(NULL, "plla",
+			of_clk_get_parent_name(np, 0), 0,
+			r8a7778_rates[cpg_mode_rates].plla_mult, 1);
+	} else if (!strcmp(name, "pllb")) {
+		return clk_register_fixed_factor(NULL, "pllb",
+			of_clk_get_parent_name(np, 0), 0,
+			r8a7778_rates[cpg_mode_rates].pllb_mult, 1);
+	} else {
+		unsigned int i;
+
+		for (i = 0; i < ARRAY_SIZE(r8a7778_divs); i++) {
+			if (!strcmp(name, r8a7778_divs[i].name)) {
+				return clk_register_fixed_factor(NULL,
+					r8a7778_divs[i].name,
+					"plla", 0, 1,
+					r8a7778_divs[i].div[cpg_mode_divs]);
+			}
+		}
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+
+static void __init r8a7778_cpg_clocks_init(struct device_node *np)
+{
+	struct r8a7778_cpg *cpg;
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
+	for (i = 0; i < num_clks; ++i) {
+		const char *name;
+		struct clk *clk;
+
+		of_property_read_string_index(np, "clock-output-names", i,
+					      &name);
+
+		clk = r8a7778_cpg_register_clock(np, cpg, name);
+		if (IS_ERR(clk))
+			pr_err("%s: failed to register %s %s clock (%ld)\n",
+			       __func__, np->name, name, PTR_ERR(clk));
+		else
+			cpg->data.clks[i] = clk;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+}
+
+CLK_OF_DECLARE(r8a7778_cpg_clks, "renesas,r8a7778-cpg-clocks",
+	       r8a7778_cpg_clocks_init);
+
+void __init r8a7778_clocks_init(u32 mode)
+{
+	BUG_ON(!(mode & BIT(19)));
+
+	cpg_mode_rates = (!!(mode & BIT(18)) << 2) |
+			 (!!(mode & BIT(12)) << 1) |
+			 (!!(mode & BIT(11)));
+	cpg_mode_divs = (!!(mode & BIT(2)) << 1) |
+			(!!(mode & BIT(1)));
+
+	of_clk_init(NULL);
+}
diff --git a/include/linux/clk/shmobile.h b/include/linux/clk/shmobile.h
index 9f8a140..63a8159 100644
--- a/include/linux/clk/shmobile.h
+++ b/include/linux/clk/shmobile.h
@@ -16,6 +16,7 @@
 
 #include <linux/types.h>
 
+void r8a7778_clocks_init(u32 mode);
 void r8a7779_clocks_init(u32 mode);
 void rcar_gen2_clocks_init(u32 mode);
 
-- 
2.1.4
