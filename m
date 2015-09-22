From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Sep 2015 22:12:33 +0800
Subject: [PATCH 2/5] clk: berlin: add common clk driver for newer SoCs
In-Reply-To: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442931156-5877-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add berlin-clk driver for Marvell SoCs newer than BG2, BG2CD, BG2Q.
berlin_clk_register() is provided for registering such kind of clk.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clk/berlin/Makefile |   2 +-
 drivers/clk/berlin/clk.c    | 147 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/berlin/clk.h    |  38 ++++++++++++
 3 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/berlin/clk.c
 create mode 100644 drivers/clk/berlin/clk.h

diff --git a/drivers/clk/berlin/Makefile b/drivers/clk/berlin/Makefile
index 747700d..741ba22 100644
--- a/drivers/clk/berlin/Makefile
+++ b/drivers/clk/berlin/Makefile
@@ -1,4 +1,4 @@
-obj-y += pll.o berlin2-avpll.o berlin2-pll.o berlin2-div.o
+obj-y += pll.o clk.o berlin2-avpll.o berlin2-pll.o berlin2-div.o
 obj-$(CONFIG_MACH_BERLIN_BG2)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2CD)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2Q)	+= bg2q.o
diff --git a/drivers/clk/berlin/clk.c b/drivers/clk/berlin/clk.c
new file mode 100644
index 0000000..6d64faf
--- /dev/null
+++ b/drivers/clk/berlin/clk.c
@@ -0,0 +1,147 @@
+/*
+ * Copyright (c) 2013 Marvell Technology Group Ltd.
+ *
+ * Author: Jisheng Zhang <jszhang@marvell.com>
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
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define CLKEN		(1 << 0)
+#define CLKPLLSEL_MASK	7
+#define CLKPLLSEL_SHIFT	1
+#define CLKPLLSWITCH	(1 << 4)
+#define CLKSWITCH	(1 << 5)
+#define CLKD3SWITCH	(1 << 6)
+#define CLKSEL_MASK	7
+#define CLKSEL_SHIFT	7
+
+struct berlin_clk {
+	struct clk_hw hw;
+	void __iomem *base;
+};
+
+#define to_berlin_clk(hw)	container_of(hw, struct berlin_clk, hw)
+
+static u8 clk_div[] = {1, 2, 4, 6, 8, 12, 1, 1};
+
+static unsigned long berlin_clk_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	u32 val, divider;
+	struct berlin_clk *clk = to_berlin_clk(hw);
+
+	val = readl_relaxed(clk->base);
+	if (val & CLKD3SWITCH)
+		divider = 3;
+	else {
+		if (val & CLKSWITCH) {
+			val >>= CLKSEL_SHIFT;
+			val &= CLKSEL_MASK;
+			divider = clk_div[val];
+		} else
+			divider = 1;
+	}
+
+	return parent_rate / divider;
+}
+
+static u8 berlin_clk_get_parent(struct clk_hw *hw)
+{
+	u32 val;
+	struct berlin_clk *clk = to_berlin_clk(hw);
+
+	val = readl_relaxed(clk->base);
+	if (val & CLKPLLSWITCH) {
+		val >>= CLKPLLSEL_SHIFT;
+		val &= CLKPLLSEL_MASK;
+		return val;
+	}
+
+	return 0;
+}
+
+static int berlin_clk_enable(struct clk_hw *hw)
+{
+	u32 val;
+	struct berlin_clk *clk = to_berlin_clk(hw);
+
+	val = readl_relaxed(clk->base);
+	val |= CLKEN;
+	writel_relaxed(val, clk->base);
+
+	return 0;
+}
+
+static void berlin_clk_disable(struct clk_hw *hw)
+{
+	u32 val;
+	struct berlin_clk *clk = to_berlin_clk(hw);
+
+	val = readl_relaxed(clk->base);
+	val &= ~CLKEN;
+	writel_relaxed(val, clk->base);
+}
+
+static int berlin_clk_is_enabled(struct clk_hw *hw)
+{
+	u32 val;
+	struct berlin_clk *clk = to_berlin_clk(hw);
+
+	val = readl_relaxed(clk->base);
+	val &= CLKEN;
+
+	return val ? 1 : 0;
+}
+
+static const struct clk_ops berlin_clk_ops = {
+	.recalc_rate	= berlin_clk_recalc_rate,
+	.get_parent	= berlin_clk_get_parent,
+	.enable		= berlin_clk_enable,
+	.disable	= berlin_clk_disable,
+	.is_enabled	= berlin_clk_is_enabled,
+};
+
+struct clk * __init berlin_clk_register(const char *name, int num_parents,
+			const char **parent_names, unsigned long flags,
+			void __iomem *base)
+{
+	struct clk *clk;
+	struct berlin_clk *bclk;
+	struct clk_init_data init;
+
+	bclk = kzalloc(sizeof(*bclk), GFP_KERNEL);
+	if (!bclk)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &berlin_clk_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.flags = flags;
+
+	bclk->base = base;
+	bclk->hw.init = &init;
+
+	clk = clk_register(NULL, &bclk->hw);
+	if (IS_ERR(clk))
+		kfree(bclk);
+
+	return clk;
+}
diff --git a/drivers/clk/berlin/clk.h b/drivers/clk/berlin/clk.h
new file mode 100644
index 0000000..502689e
--- /dev/null
+++ b/drivers/clk/berlin/clk.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2015 Marvell Technology Group Ltd.
+ *
+ * Author: Jisheng Zhang <jszhang@marvell.com>
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
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __BERLIN_CLK_H
+#define __BERLIN_CLK_H
+
+struct gateclk_desc {
+	const char	*name;
+	const char	*parent_name;
+	u8		bit_idx;
+	unsigned long	flags;
+};
+
+struct clk_desc {
+	const char	*name;
+	u32		offset;
+	unsigned long	flags;
+};
+
+struct clk * __init berlin_clk_register(const char *name, int num_parents,
+			const char **parent_names, unsigned long flags,
+			void __iomem *base);
+#endif
-- 
2.5.3
