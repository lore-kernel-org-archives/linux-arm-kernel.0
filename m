From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Mar 2016 11:26:17 +0200
Subject: [PATCH v4 5/5] clk: mvebu: new driver for Armada CP110 system
 controller
In-Reply-To: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459070777-18049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1459070777-18049-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada CP110 system controller provides, amongst other things, a
number of clocks for the platform: a small number of core clocks, and
then a number of gatable clocks, derived from some of the core
clocks. Those clocks are configured via registers of the CP110 System
Controller.

The CP110 is the other core HW block (next to the AP806) used in the
Marvel Armada 7K and 8K SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/mvebu/Kconfig                   |   3 +
 drivers/clk/mvebu/Makefile                  |   1 +
 drivers/clk/mvebu/cp110-system-controller.c | 265 ++++++++++++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 drivers/clk/mvebu/cp110-system-controller.c

diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index bf7ae00..3165da7 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -32,6 +32,9 @@ config ARMADA_XP_CLK
 config ARMADA_AP806_SYSCON
 	bool
 
+config ARMADA_CP110_SYSCON
+	bool
+
 config DOVE_CLK
 	bool
 	select MVEBU_CLK_COMMON
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index f4aa481..7172ef6 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARMADA_38X_CLK)	+= armada-38x.o
 obj-$(CONFIG_ARMADA_39X_CLK)	+= armada-39x.o
 obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
 obj-$(CONFIG_ARMADA_AP806_SYSCON) += ap806-system-controller.o
+obj-$(CONFIG_ARMADA_CP110_SYSCON) += cp110-system-controller.o
 obj-$(CONFIG_DOVE_CLK)		+= dove.o dove-divider.o
 obj-$(CONFIG_KIRKWOOD_CLK)	+= kirkwood.o
 obj-$(CONFIG_ORION_CLK)		+= orion.o
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
new file mode 100644
index 0000000..7b22503
--- /dev/null
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -0,0 +1,265 @@
+/*
+ * Marvell Armada CP110 System Controller
+ *
+ * Copyright (C) 2016 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/*
+ * CP110 has 5 core clocks:
+ *
+ *  - APLL		(1 Ghz)
+ *    - PPv2 core	(1/3 APLL)
+ *    - EIP		(1/2 APLL)
+ *      - Core		(1/2 EIP)
+ *
+ *  - NAND clock, which is either:
+ *    - Equal to the core clock
+ *    - 2/5 APLL
+ *
+ * CP110 has 32 gatable clocks, for the various peripherals in the IP:
+ *
+ *  - Most have the "Core" clocks as their parents
+ *  - The NAND gatable clock has NAND-core as its parent
+ *  - The PPv2 gatable clock has PPv2-core as its parent
+ *  - The EIP* gatable clocks have EIP as their parent
+ */
+
+#define pr_fmt(fmt) "cp110-system-controller: " fmt
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define CP110_PM_CLOCK_GATING_REG	0x220
+#define CP110_NAND_FLASH_CLK_CTRL_REG	0x700
+#define    NF_CLOCK_SEL_400_MASK	BIT(0)
+
+enum {
+	CP110_CLK_TYPE_CORE,
+	CP110_CLK_TYPE_GATABLE,
+};
+
+#define CP110_MAX_CORE_CLOCKS		5
+#define CP110_MAX_GATABLE_CLOCKS	32
+
+#define CP110_CLK_NUM \
+	(CP110_MAX_CORE_CLOCKS + CP110_MAX_GATABLE_CLOCKS)
+
+/* A few gatable clocks need special handling */
+#define CP110_GATE_NAND			2
+#define CP110_GATE_PPV2			3
+#define CP110_GATE_EIP150		25
+#define CP110_GATE_EIP197		26
+
+static struct clk *cp110_clks[CP110_CLK_NUM];
+
+static struct clk_onecell_data cp110_clk_data = {
+	.clks = cp110_clks,
+	.clk_num = CP110_CLK_NUM,
+};
+
+struct cp110_gate_clk {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	u8 bit_idx;
+};
+
+static int cp110_gate_enable(struct clk_hw *hw)
+{
+	struct cp110_gate_clk *gate =
+		container_of(hw, struct cp110_gate_clk, hw);
+
+	regmap_update_bits(gate->regmap, CP110_PM_CLOCK_GATING_REG,
+			   BIT(gate->bit_idx), BIT(gate->bit_idx));
+
+	return 0;
+}
+
+static void cp110_gate_disable(struct clk_hw *hw)
+{
+	struct cp110_gate_clk *gate =
+		container_of(hw, struct cp110_gate_clk, hw);
+	regmap_update_bits(gate->regmap, CP110_PM_CLOCK_GATING_REG,
+			   BIT(gate->bit_idx), 0);
+}
+
+static int cp110_gate_is_enabled(struct clk_hw *hw)
+{
+	struct cp110_gate_clk *gate =
+		container_of(hw, struct cp110_gate_clk, hw);
+	u32 val;
+
+	regmap_read(gate->regmap, CP110_PM_CLOCK_GATING_REG, &val);
+
+	return val & BIT(gate->bit_idx);
+}
+
+static const struct clk_ops cp110_gate_ops = {
+	.enable = cp110_gate_enable,
+	.disable = cp110_gate_disable,
+	.is_enabled = cp110_gate_is_enabled,
+};
+
+static struct clk *cp110_register_gate(const char *name, const char *parent_name,
+				       struct regmap *regmap, u8 bit_idx)
+{
+	struct cp110_gate_clk *gate;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &cp110_gate_ops;
+	init.flags = CLK_IS_BASIC;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	gate->regmap = regmap;
+	gate->bit_idx = bit_idx;
+	gate->hw.init = &init;
+
+	clk = clk_register(NULL, &gate->hw);
+	if (IS_ERR(clk))
+		kfree(gate);
+
+	return clk;
+}
+
+static struct clk *cp110_of_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct clk_onecell_data *clk_data = data;
+	unsigned int type = clkspec->args[0];
+	unsigned int idx = clkspec->args[1];
+
+	if (type == CP110_CLK_TYPE_CORE) {
+		if (idx > CP110_MAX_CORE_CLOCKS)
+			return ERR_PTR(-EINVAL);
+		return clk_data->clks[idx];
+	} else if (type == CP110_CLK_TYPE_GATABLE) {
+		if (idx > CP110_MAX_GATABLE_CLOCKS)
+			return ERR_PTR(-EINVAL);
+		return clk_data->clks[CP110_MAX_CORE_CLOCKS + idx];
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static void __init cp110_syscon_clk_init(struct device_node *np)
+{
+	struct regmap *regmap;
+	const char *name, *apll_name, *core_name, *eip_name, *nand_name;
+	u32 nand_clk_ctrl;
+	int clkidx = 0, i;
+
+	regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(regmap)) {
+		pr_err("cannot get regmap\n");
+		return;
+	}
+
+	if (regmap_read(regmap, CP110_NAND_FLASH_CLK_CTRL_REG, &nand_clk_ctrl)) {
+		pr_err("cannot read from regmap\n");
+		return;
+	}
+
+	/*
+	 * Register core clocks
+	 */
+
+        /* Register the APLL which is the root of the clk tree */
+	of_property_read_string_index(np, "core-clock-output-names",
+                                      0, &apll_name);
+        cp110_clks[0] =
+		clk_register_fixed_rate(NULL, apll_name, NULL, 0,
+					1000 * 1000 * 1000);
+
+        /* PPv2 is APLL/3 */
+	of_property_read_string_index(np, "core-clock-output-names",
+				      1, &name);
+        cp110_clks[1] =
+		clk_register_fixed_factor(NULL, name, apll_name,
+					  0, 1, 3);
+	clkidx++;
+
+        /* EIP clock is APLL/2 */
+	of_property_read_string_index(np, "core-clock-output-names",
+				      2, &eip_name);
+        cp110_clks[2] =
+		clk_register_fixed_factor(NULL, eip_name, apll_name, 0, 1, 2);
+	clkidx++;
+
+        /* Core clock is EIP/2 */
+	of_property_read_string_index(np, "core-clock-output-names",
+				      3, &core_name);
+        cp110_clks[3] =
+		clk_register_fixed_factor(NULL, core_name, eip_name, 0, 1, 2);
+	clkidx++;
+
+        /* NAND can be either APLL/2.5 or core clock */
+	of_property_read_string_index(np, "core-clock-output-names",
+				      4, &nand_name);
+        if (nand_clk_ctrl & NF_CLOCK_SEL_400_MASK)
+                cp110_clks[4] =
+			clk_register_fixed_factor(NULL, nand_name,
+						  apll_name, 0, 2, 5);
+        else
+                cp110_clks[4] =
+			clk_register_fixed_factor(NULL, nand_name,
+						  core_name, 0, 1, 1);
+
+	/*
+	 * Register gatable clocks
+	 */
+	for (i = 0; i < CP110_MAX_GATABLE_CLOCKS; i++) {
+		const char *parent;
+		int clkidx, ret;
+
+		ret = of_property_read_string_index(np, "gate-clock-output-names",
+						    i, &name);
+		/* Reached the end of the list? */
+		if (ret < 0)
+			break;
+
+		of_property_read_u32_index(np, "gate-clock-indices", i, &clkidx);
+
+		switch(clkidx) {
+		case CP110_GATE_NAND:
+			parent = nand_name;
+			break;
+		case CP110_GATE_PPV2:
+			parent = "ppv2-core";
+			break;
+		case CP110_GATE_EIP150:
+		case CP110_GATE_EIP197:
+			parent = "eip";
+			break;
+		default:
+			parent = "core";
+			break;
+		}
+
+		cp110_clks[CP110_MAX_CORE_CLOCKS + clkidx] =
+			cp110_register_gate(name, parent,
+					    regmap, clkidx);
+	}
+
+	of_clk_add_provider(np, cp110_of_clk_get, &cp110_clk_data);
+}
+
+CLK_OF_DECLARE(cp110_syscon_clk, "marvell,cp110-system-controller0",
+	       cp110_syscon_clk_init);
-- 
2.6.4
