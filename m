From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue,  5 Nov 2013 09:55:08 -0300
Subject: [PATCH v3 01/28] clk: mvebu: Add Core Divider clock
In-Reply-To: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383656135-8627-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383656135-8627-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit introduces a new group of clocks present in Armada 370/XP
SoCs (called "Core Divider" clocks) and add a provider for them.
The only clock supported for now is the NAND clock (ndclk), but the
infrastructure to add the rest is already set.

Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clk/mvebu/Kconfig       |   5 +
 drivers/clk/mvebu/Makefile      |   1 +
 drivers/clk/mvebu/clk-corediv.c | 223 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 229 insertions(+)
 create mode 100644 drivers/clk/mvebu/clk-corediv.c

diff --git a/drivers/clk/mvebu/Kconfig b/drivers/clk/mvebu/Kconfig
index 0b0f3e7..c339b82 100644
--- a/drivers/clk/mvebu/Kconfig
+++ b/drivers/clk/mvebu/Kconfig
@@ -4,15 +4,20 @@ config MVEBU_CLK_COMMON
 config MVEBU_CLK_CPU
 	bool
 
+config MVEBU_CLK_COREDIV
+	bool
+
 config ARMADA_370_CLK
 	bool
 	select MVEBU_CLK_COMMON
 	select MVEBU_CLK_CPU
+	select MVEBU_CLK_COREDIV
 
 config ARMADA_XP_CLK
 	bool
 	select MVEBU_CLK_COMMON
 	select MVEBU_CLK_CPU
+	select MVEBU_CLK_COREDIV
 
 config DOVE_CLK
 	bool
diff --git a/drivers/clk/mvebu/Makefile b/drivers/clk/mvebu/Makefile
index 1c7e70c..21bbfb4 100644
--- a/drivers/clk/mvebu/Makefile
+++ b/drivers/clk/mvebu/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_MVEBU_CLK_COMMON)	+= common.o
 obj-$(CONFIG_MVEBU_CLK_CPU) 	+= clk-cpu.o
+obj-$(CONFIG_MVEBU_CLK_COREDIV)	+= clk-corediv.o
 
 obj-$(CONFIG_ARMADA_370_CLK)	+= armada-370.o
 obj-$(CONFIG_ARMADA_XP_CLK)	+= armada-xp.o
diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
new file mode 100644
index 0000000..7162615
--- /dev/null
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -0,0 +1,223 @@
+/*
+ * MVEBU Core divider clock
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include "common.h"
+
+#define CORE_CLK_DIV_RATIO_MASK		0xff
+#define CORE_CLK_DIV_RATIO_RELOAD	BIT(8)
+#define CORE_CLK_DIV_ENABLE_OFFSET	24
+#define CORE_CLK_DIV_RATIO_OFFSET	0x8
+
+struct clk_corediv_desc {
+	unsigned int mask;
+	unsigned int offset;
+	unsigned int fieldbit;
+};
+
+struct clk_corediv {
+	struct clk_hw hw;
+	void __iomem *reg;
+	struct clk_corediv_desc desc;
+	spinlock_t lock;
+};
+
+static struct clk_onecell_data clk_data;
+
+static const struct clk_corediv_desc mvebu_corediv_desc[] __initconst = {
+	{ .mask = 0x3f, .offset = 8, .fieldbit = 1 }, /* NAND clock */
+};
+
+#define to_corediv_clk(p) container_of(p, struct clk_corediv, hw)
+
+static int clk_corediv_is_enabled(struct clk_hw *hwclk)
+{
+	struct clk_corediv *corediv = to_corediv_clk(hwclk);
+	struct clk_corediv_desc *desc = &corediv->desc;
+	u32 enable_mask = BIT(desc->fieldbit) << CORE_CLK_DIV_ENABLE_OFFSET;
+
+	return !!(readl(corediv->reg) & enable_mask);
+}
+
+static int clk_corediv_enable(struct clk_hw *hwclk)
+{
+	struct clk_corediv *corediv = to_corediv_clk(hwclk);
+	struct clk_corediv_desc *desc = &corediv->desc;
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(&corediv->lock, flags);
+
+	reg = readl(corediv->reg);
+	reg |= (BIT(desc->fieldbit) << CORE_CLK_DIV_ENABLE_OFFSET);
+	writel(reg, corediv->reg);
+
+	spin_unlock_irqrestore(&corediv->lock, flags);
+
+	return 0;
+}
+
+static void clk_corediv_disable(struct clk_hw *hwclk)
+{
+	struct clk_corediv *corediv = to_corediv_clk(hwclk);
+	struct clk_corediv_desc *desc = &corediv->desc;
+	unsigned long flags = 0;
+	u32 reg;
+
+	spin_lock_irqsave(&corediv->lock, flags);
+
+	reg = readl(corediv->reg);
+	reg &= ~(BIT(desc->fieldbit) << CORE_CLK_DIV_ENABLE_OFFSET);
+	writel(reg, corediv->reg);
+
+	spin_unlock_irqrestore(&corediv->lock, flags);
+}
+
+static unsigned long clk_corediv_recalc_rate(struct clk_hw *hwclk,
+					 unsigned long parent_rate)
+{
+	struct clk_corediv *corediv = to_corediv_clk(hwclk);
+	struct clk_corediv_desc *desc = &corediv->desc;
+	u32 reg, div;
+
+	reg = readl(corediv->reg + CORE_CLK_DIV_RATIO_OFFSET);
+	div = (reg >> desc->offset) & desc->mask;
+	return parent_rate / div;
+}
+
+static long clk_corediv_round_rate(struct clk_hw *hwclk, unsigned long rate,
+			       unsigned long *parent_rate)
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
+static int clk_corediv_set_rate(struct clk_hw *hwclk, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_corediv *corediv = to_corediv_clk(hwclk);
+	struct clk_corediv_desc *desc = &corediv->desc;
+	unsigned long flags = 0;
+	u32 reg, div;
+
+	div = parent_rate / rate;
+
+	spin_lock_irqsave(&corediv->lock, flags);
+
+	/* Write new divider to the divider ratio register */
+	reg = readl(corediv->reg + CORE_CLK_DIV_RATIO_OFFSET);
+	reg &= ~(desc->mask << desc->offset);
+	reg |= (div & desc->mask) << desc->offset;
+	writel(reg, corediv->reg + CORE_CLK_DIV_RATIO_OFFSET);
+
+	/* Set reload-force for this clock */
+	reg = readl(corediv->reg) | BIT(desc->fieldbit);
+	writel(reg, corediv->reg);
+
+	/* Now trigger the clock update */
+	reg = readl(corediv->reg) | CORE_CLK_DIV_RATIO_RELOAD;
+	writel(reg, corediv->reg);
+
+	/*
+	 * Wait for clocks to settle down, and then clear all the
+	 * ratios request and the reload request.
+	 */
+	udelay(1000);
+	reg &= ~(CORE_CLK_DIV_RATIO_MASK | CORE_CLK_DIV_RATIO_RELOAD);
+	writel(reg, corediv->reg);
+	udelay(1000);
+
+	spin_unlock_irqrestore(&corediv->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops corediv_ops = {
+	.enable = clk_corediv_enable,
+	.disable = clk_corediv_disable,
+	.is_enabled = clk_corediv_is_enabled,
+	.recalc_rate = clk_corediv_recalc_rate,
+	.round_rate = clk_corediv_round_rate,
+	.set_rate = clk_corediv_set_rate,
+};
+
+static void __init mvebu_corediv_clk_init(struct device_node *node)
+{
+	struct clk_init_data init;
+	struct clk_corediv *corediv;
+	struct clk **clks;
+	void __iomem *base;
+	const char *parent_name;
+	const char *clk_name;
+	int i;
+
+	base = of_iomap(node, 0);
+	if (WARN_ON(!base))
+		return;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	clk_data.clk_num = ARRAY_SIZE(mvebu_corediv_desc);
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
+	for (i = 0; i < clk_data.clk_num; i++) {
+		of_property_read_string_index(node, "clock-output-names",
+					      i, &clk_name);
+		init.num_parents = 1;
+		init.parent_names = &parent_name;
+		init.name = clk_name;
+		init.ops = &corediv_ops;
+		init.flags = 0;
+
+		corediv[i].desc = mvebu_corediv_desc[i];
+		corediv[i].reg = base;
+		corediv[i].hw.init = &init;
+
+		clks[i] = clk_register(NULL, &corediv[i].hw);
+		WARN_ON(IS_ERR(clks[i]));
+	}
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
+CLK_OF_DECLARE(mvebu_corediv_clk, "marvell,armada-370-corediv-clock",
+	       mvebu_corediv_clk_init);
-- 
1.8.1.5
