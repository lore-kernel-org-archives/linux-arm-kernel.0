From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu,  5 Jan 2017 16:36:37 +1300
Subject: [PATCHv2 1/5] clk: mvebu: support for 98DX3236 SoC
In-Reply-To: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170105033641.6212-2-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 98DX3236, 98DX3336, 98DX4521 and variants have a different TCLK from
the Armada XP (200MHz vs 250MHz). The CPU core clock is fixed at 800MHz.

The clock gating options are a subset of those on the Armada XP.

The core clock divider is different to the Armada XP also.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v2:
- Update devicetree binding documentation for new compatible string

 .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   1 +
 drivers/clk/mvebu/Makefile                         |   2 +-
 drivers/clk/mvebu/armada-xp.c                      |  42 +++++
 drivers/clk/mvebu/clk-cpu.c                        |  33 +++-
 drivers/clk/mvebu/mv98dx3236-corediv.c             | 207 +++++++++++++++++++++
 5 files changed, 281 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/mvebu/mv98dx3236-corediv.c

diff --git a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
index 99c214660bdc..7f28506eaee7 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-cpu-clock.txt
@@ -3,6 +3,7 @@ Device Tree Clock bindings for cpu clock of Marvell EBU platforms
 Required properties:
 - compatible : shall be one of the following:
 	"marvell,armada-xp-cpu-clock" - cpu clocks for Armada XP
+	"marvell,mv98dx3236-cpu-clock" - cpu clocks for 98DX3236 SoC
 - reg : Address and length of the clock complex register set, followed
         by address and length of the PMU DFS registers
 - #clock-cells : should be set to 1.
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index d9ae97fb43c4..6a3681e3d6db 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_ARMADA_39X_CLK)	+= armada-39x.o
 obj-$(CONFIG_ARMADA_37XX_CLK)	+= armada-37xx-xtal.o
 obj-$(CONFIG_ARMADA_37XX_CLK)	+= armada-37xx-tbg.o
 obj-$(CONFIG_ARMADA_37XX_CLK)	+= armada-37xx-periph.o
-obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
+obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o mv98dx3236-corediv.o
 obj-$(CONFIG_ARMADA_AP806_SYSCON) += ap806-system-controller.o
 obj-$(CONFIG_ARMADA_CP110_SYSCON) += cp110-system-controller.o
 obj-$(CONFIG_DOVE_CLK)		+= dove.o dove-divider.o
diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index b3094315a3c0..0413bf8284e0 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -52,6 +52,12 @@ static u32 __init axp_get_tclk_freq(void __iomem *sar)
 	return 250000000;
 }
 
+/* MV98DX3236 TCLK frequency is fixed to 200MHz */
+static u32 __init mv98dx3236_get_tclk_freq(void __iomem *sar)
+{
+	return 200000000;
+}
+
 static const u32 axp_cpu_freqs[] __initconst = {
 	1000000000,
 	1066000000,
@@ -89,6 +95,12 @@ static u32 __init axp_get_cpu_freq(void __iomem *sar)
 	return cpu_freq;
 }
 
+/* MV98DX3236 CLK frequency is fixed to 800MHz */
+static u32 __init mv98dx3236_get_cpu_freq(void __iomem *sar)
+{
+	return 800000000;
+}
+
 static const int axp_nbclk_ratios[32][2] __initconst = {
 	{0, 1}, {1, 2}, {2, 2}, {2, 2},
 	{1, 2}, {1, 2}, {1, 1}, {2, 3},
@@ -158,6 +170,14 @@ static const struct coreclk_soc_desc axp_coreclks = {
 	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
 };
 
+static const struct coreclk_soc_desc mv98dx3236_coreclks = {
+	.get_tclk_freq = mv98dx3236_get_tclk_freq,
+	.get_cpu_freq = mv98dx3236_get_cpu_freq,
+	.get_clk_ratio = NULL,
+	.ratios = NULL,
+	.num_ratios = 0,
+};
+
 /*
  * Clock Gating Control
  */
@@ -195,6 +215,15 @@ static const struct clk_gating_soc_desc axp_gating_desc[] __initconst = {
 	{ }
 };
 
+static const struct clk_gating_soc_desc mv98dx3236_gating_desc[] __initconst = {
+	{ "ge1", NULL, 3, 0 },
+	{ "ge0", NULL, 4, 0 },
+	{ "pex00", NULL, 5, 0 },
+	{ "sdio", NULL, 17, 0 },
+	{ "xor0", NULL, 22, 0 },
+	{ }
+};
+
 static void __init axp_clk_init(struct device_node *np)
 {
 	struct device_node *cgnp =
@@ -206,3 +235,16 @@ static void __init axp_clk_init(struct device_node *np)
 		mvebu_clk_gating_setup(cgnp, axp_gating_desc);
 }
 CLK_OF_DECLARE(axp_clk, "marvell,armada-xp-core-clock", axp_clk_init);
+
+static void __init mv98dx3236_clk_init(struct device_node *np)
+{
+	struct device_node *cgnp =
+		of_find_compatible_node(NULL, NULL, "marvell,armada-xp-gating-clock");
+
+	mvebu_coreclk_setup(np, &mv98dx3236_coreclks);
+
+	if (cgnp)
+		mvebu_clk_gating_setup(cgnp, mv98dx3236_gating_desc);
+}
+CLK_OF_DECLARE(mv98dx3236_clk, "marvell,mv98dx3236-core-clock",
+	       mv98dx3236_clk_init);
diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 5837eb8a212f..29f295e7a36b 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -165,7 +165,9 @@ static const struct clk_ops cpu_ops = {
 	.set_rate = clk_cpu_set_rate,
 };
 
-static void __init of_cpu_clk_setup(struct device_node *node)
+/* Add parameter to allow this to support different clock operations. */
+static void __init _of_cpu_clk_setup(struct device_node *node,
+			const struct clk_ops *cpu_clk_ops)
 {
 	struct cpu_clk *cpuclk;
 	void __iomem *clock_complex_base = of_iomap(node, 0);
@@ -218,7 +220,7 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 		cpuclk[cpu].hw.init = &init;
 
 		init.name = cpuclk[cpu].clk_name;
-		init.ops = &cpu_ops;
+		init.ops = cpu_clk_ops;
 		init.flags = 0;
 		init.parent_names = &cpuclk[cpu].parent_name;
 		init.num_parents = 1;
@@ -243,5 +245,30 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 	iounmap(clock_complex_base);
 }
 
+/* Use this function to call the generic setup with the correct
+ * clock operation
+ */
+static void __init of_cpu_clk_setup(struct device_node *node)
+{
+	_of_cpu_clk_setup(node, &cpu_ops);
+}
+
 CLK_OF_DECLARE(armada_xp_cpu_clock, "marvell,armada-xp-cpu-clock",
-					 of_cpu_clk_setup);
+					of_cpu_clk_setup);
+
+/* Define the clock and operations for the mv98dx3236 - it cannot perform
+ * any operations.
+ */
+static const struct clk_ops mv98dx3236_cpu_ops = {
+	.recalc_rate = NULL,
+	.round_rate = NULL,
+	.set_rate = NULL,
+};
+
+static void __init of_mv98dx3236_cpu_clk_setup(struct device_node *node)
+{
+	_of_cpu_clk_setup(node, &mv98dx3236_cpu_ops);
+}
+
+CLK_OF_DECLARE(mv98dx3236_cpu_clock, "marvell,mv98dx3236-cpu-clock",
+					 of_mv98dx3236_cpu_clk_setup);
diff --git a/drivers/clk/mvebu/mv98dx3236-corediv.c b/drivers/clk/mvebu/mv98dx3236-corediv.c
new file mode 100644
index 000000000000..3060764a8e5d
--- /dev/null
+++ b/drivers/clk/mvebu/mv98dx3236-corediv.c
@@ -0,0 +1,207 @@
+/*
+ * MV98DX3236 Core divider clock
+ *
+ * Copyright (C) 2015 Allied Telesis Labs
+ *
+ * Based on armada-xp-corediv.c
+ * Copyright (C) 2015 Marvell
+ *
+ * John Thompson <john.thompson@alliedtelesis.co.nz>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include "common.h"
+
+#define CORE_CLK_DIV_RATIO_MASK		0xff
+
+#define CLK_DIV_RATIO_NAND_MASK 0x0f
+#define CLK_DIV_RATIO_NAND_OFFSET 6
+#define CLK_DIV_RATIO_NAND_FORCE_RELOAD_BIT 26
+
+#define RATIO_RELOAD_BIT BIT(10)
+#define RATIO_REG_OFFSET 0x08
+
+/*
+ * This structure represents one core divider clock for the clock
+ * framework, and is dynamically allocated for each core divider clock
+ * existing in the current SoC.
+ */
+struct clk_corediv {
+	struct clk_hw hw;
+	void __iomem *reg;
+	spinlock_t lock;
+};
+
+static struct clk_onecell_data clk_data;
+
+
+#define to_corediv_clk(p) container_of(p, struct clk_corediv, hw)
+
+static int mv98dx3236_corediv_is_enabled(struct clk_hw *hwclk)
+{
+	/* Core divider is always active */
+	return 1;
+}
+
+static int mv98dx3236_corediv_enable(struct clk_hw *hwclk)
+{
+	/* always succeeds */
+	return 0;
+}
+
+static void mv98dx3236_corediv_disable(struct clk_hw *hwclk)
+{
+	/* can't be disabled so is left alone */
+}
+
+static unsigned long mv98dx3236_corediv_recalc_rate(struct clk_hw *hwclk,
+					 unsigned long parent_rate)
+{
+	struct clk_corediv *corediv = to_corediv_clk(hwclk);
+	u32 reg, div;
+
+	reg = readl(corediv->reg + RATIO_REG_OFFSET);
+	div = (reg >> CLK_DIV_RATIO_NAND_OFFSET) & CLK_DIV_RATIO_NAND_MASK;
+	return parent_rate / div;
+}
+
+static long mv98dx3236_corediv_round_rate(struct clk_hw *hwclk,
+			       unsigned long rate, unsigned long *parent_rate)
+{
+	/* Valid ratio are 1:4, 1:5, 1:6 and 1:8 */
+	u32 div;
+
+	div = *parent_rate / rate;
+	if (div < 4)
+		div = 4;
+	else if (div > 6)
+		div = 8;
+
+	return *parent_rate / div;
+}
+
+static int mv98dx3236_corediv_set_rate(struct clk_hw *hwclk, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_corediv *corediv = to_corediv_clk(hwclk);
+	unsigned long flags = 0;
+	u32 reg, div;
+
+	div = parent_rate / rate;
+
+	spin_lock_irqsave(&corediv->lock, flags);
+
+	/* Write new divider to the divider ratio register */
+	reg = readl(corediv->reg + RATIO_REG_OFFSET);
+	reg &= ~(CLK_DIV_RATIO_NAND_MASK << CLK_DIV_RATIO_NAND_OFFSET);
+	reg |= (div & CLK_DIV_RATIO_NAND_MASK) << CLK_DIV_RATIO_NAND_OFFSET;
+	writel(reg, corediv->reg + RATIO_REG_OFFSET);
+
+	/* Set reload-force for this clock */
+	reg = readl(corediv->reg) | BIT(CLK_DIV_RATIO_NAND_FORCE_RELOAD_BIT);
+	writel(reg, corediv->reg);
+
+	/* Now trigger the clock update */
+	reg = readl(corediv->reg + RATIO_REG_OFFSET) | RATIO_RELOAD_BIT;
+	writel(reg, corediv->reg + RATIO_REG_OFFSET);
+
+	/*
+	 * Wait for clocks to settle down, and then clear all the
+	 * ratios request and the reload request.
+	 */
+	udelay(1000);
+	reg &= ~(CORE_CLK_DIV_RATIO_MASK | RATIO_RELOAD_BIT);
+	writel(reg, corediv->reg + RATIO_REG_OFFSET);
+	udelay(1000);
+
+	spin_unlock_irqrestore(&corediv->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops ops = {
+	.enable = mv98dx3236_corediv_enable,
+	.disable = mv98dx3236_corediv_disable,
+	.is_enabled = mv98dx3236_corediv_is_enabled,
+	.recalc_rate = mv98dx3236_corediv_recalc_rate,
+	.round_rate = mv98dx3236_corediv_round_rate,
+	.set_rate = mv98dx3236_corediv_set_rate,
+};
+
+static void __init mv98dx3236_corediv_clk_init(struct device_node *node)
+{
+	struct clk_init_data init;
+	struct clk_corediv *corediv;
+	struct clk **clks;
+	void __iomem *base;
+	const __be32 *off;
+	const char *parent_name;
+	const char *clk_name;
+	int len;
+	struct device_node *dfx_node;
+
+	dfx_node = of_parse_phandle(node, "base", 0);
+	if (WARN_ON(!dfx_node))
+		return;
+
+	off = of_get_property(node, "reg", &len);
+	if (WARN_ON(!off))
+		return;
+
+	base = of_iomap(dfx_node, 0);
+	if (WARN_ON(!base))
+		return;
+
+	of_node_put(dfx_node);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	clk_data.clk_num = 1;
+
+	/* clks holds the clock array */
+	clks = kcalloc(clk_data.clk_num, sizeof(struct clk *),
+				GFP_KERNEL);
+	if (WARN_ON(!clks))
+		goto err_unmap;
+	/* corediv holds the clock specific array */
+	corediv = kcalloc(clk_data.clk_num, sizeof(struct clk_corediv),
+				GFP_KERNEL);
+	if (WARN_ON(!corediv))
+		goto err_free_clks;
+
+	spin_lock_init(&corediv->lock);
+
+	of_property_read_string_index(node, "clock-output-names",
+					  0, &clk_name);
+
+	init.num_parents = 1;
+	init.parent_names = &parent_name;
+	init.name = clk_name;
+	init.ops = &ops;
+	init.flags = 0;
+
+	corediv[0].reg = (void *)((int)base + be32_to_cpu(*off));
+	corediv[0].hw.init = &init;
+
+	clks[0] = clk_register(NULL, &corediv[0].hw);
+	WARN_ON(IS_ERR(clks[0]));
+
+	clk_data.clks = clks;
+	of_clk_add_provider(node, of_clk_src_onecell_get, &clk_data);
+	return;
+
+err_free_clks:
+	kfree(clks);
+err_unmap:
+	iounmap(base);
+}
+
+CLK_OF_DECLARE(mv98dx3236_corediv_clk, "marvell,mv98dx3236-corediv-clock",
+	       mv98dx3236_corediv_clk_init);
-- 
2.11.0.24.ge6920cf
