From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 22 Sep 2015 22:12:32 +0800
Subject: [PATCH 1/5] clk: berlin: add common pll driver
In-Reply-To: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
References: <1442931156-5877-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442931156-5877-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pll driver for Marvell SoCs newer than BG2, BG2CD, BG2Q.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/clk/berlin/Makefile |   2 +-
 drivers/clk/berlin/pll.c    | 119 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/berlin/pll.c

diff --git a/drivers/clk/berlin/Makefile b/drivers/clk/berlin/Makefile
index 2a36ab7..747700d 100644
--- a/drivers/clk/berlin/Makefile
+++ b/drivers/clk/berlin/Makefile
@@ -1,4 +1,4 @@
-obj-y += berlin2-avpll.o berlin2-pll.o berlin2-div.o
+obj-y += pll.o berlin2-avpll.o berlin2-pll.o berlin2-div.o
 obj-$(CONFIG_MACH_BERLIN_BG2)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2CD)	+= bg2.o
 obj-$(CONFIG_MACH_BERLIN_BG2Q)	+= bg2q.o
diff --git a/drivers/clk/berlin/pll.c b/drivers/clk/berlin/pll.c
new file mode 100644
index 0000000..9aad0b6
--- /dev/null
+++ b/drivers/clk/berlin/pll.c
@@ -0,0 +1,119 @@
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
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+
+#define PLL_CTRL0	0x0
+#define PLL_CTRL1	0x4
+#define PLL_CTRL2	0x8
+#define PLL_CTRL3	0xC
+#define PLL_CTRL4	0x10
+#define PLL_STATUS	0x14
+
+#define PLL_SOURCE_MAX	2
+
+struct berlin_pll {
+	struct clk_hw	hw;
+	void __iomem	*ctrl;
+	void __iomem	*bypass;
+	u8		bypass_shift;
+};
+
+#define to_berlin_pll(hw)       container_of(hw, struct berlin_pll, hw)
+
+static u8 vcodiv_berlin[] = {1, 2, 4, 8, 16, 32, 64, 128};
+
+static unsigned long berlin_pll_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
+{
+	u32 val, fbdiv, rfdiv, vcodivsel, bypass;
+	struct berlin_pll *pll = to_berlin_pll(hw);
+
+	bypass = readl_relaxed(pll->bypass);
+	if (bypass & (1 << pll->bypass_shift))
+		return parent_rate;
+
+	val = readl_relaxed(pll->ctrl + PLL_CTRL0);
+	fbdiv = (val >> 12) & 0x1FF;
+	rfdiv = (val >> 3) & 0x1FF;
+	val = readl_relaxed(pll->ctrl + PLL_CTRL1);
+	vcodivsel = (val >> 9) & 0x7;
+	return parent_rate * fbdiv * 4 / rfdiv /
+		vcodiv_berlin[vcodivsel];
+}
+
+static u8 berlin_pll_get_parent(struct clk_hw *hw)
+{
+	struct berlin_pll *pll = to_berlin_pll(hw);
+	u32 bypass = readl_relaxed(pll->bypass);
+
+	if (bypass & (1 << pll->bypass_shift))
+		return 1;
+	else
+		return 0;
+}
+
+static const struct clk_ops berlin_pll_ops = {
+	.recalc_rate	= berlin_pll_recalc_rate,
+	.get_parent	= berlin_pll_get_parent,
+};
+
+void __init berlin_pll_setup(struct device_node *np)
+{
+	struct clk_init_data init;
+	struct berlin_pll *pll;
+	const char *parent_names[PLL_SOURCE_MAX];
+	struct clk *clk;
+	int ret, num_parents;
+
+	num_parents = of_clk_get_parent_count(np);
+	if (num_parents <= 0 || num_parents > PLL_SOURCE_MAX)
+		return;
+
+	of_clk_parent_fill(np, parent_names, num_parents);
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (WARN_ON(!pll))
+		return;
+
+	pll->ctrl = of_iomap(np, 0);
+	pll->bypass = of_iomap(np, 1);
+	ret = of_property_read_u8(np, "bypass-shift", &pll->bypass_shift);
+	if (WARN_ON(!pll->ctrl || !pll->bypass || ret))
+		return;
+
+	init.name = np->name;
+	init.ops = &berlin_pll_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	pll->hw.init = &init;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (WARN_ON(IS_ERR(clk)))
+		return;
+
+	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	if (WARN_ON(ret))
+		return;
+}
+CLK_OF_DECLARE(berlin_pll, "marvell,berlin-pll", berlin_pll_setup);
-- 
2.5.3
