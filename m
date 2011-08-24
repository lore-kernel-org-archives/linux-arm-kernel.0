From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Aug 2011 14:15:52 +0100
Subject: [PATCH 04/11] clk: Add simple gated clock
In-Reply-To: <1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110824131324.GB16520@opensource.wolfsonmicro.com>
	<1314191759-16941-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1314191759-16941-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jeremy.kerr@canonical.com>

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/Kconfig    |    4 ++++
 drivers/clk/Makefile   |    1 +
 drivers/clk/clk-gate.c |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h    |   13 +++++++++++++
 4 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clk/clk-gate.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index d8313d7..a78967c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -12,3 +12,7 @@ config GENERIC_CLK
 config GENERIC_CLK_FIXED
 	bool
 	depends on GENERIC_CLK
+
+config GENERIC_CLK_GATE
+	bool
+	depends on GENERIC_CLK
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 9a3325a..d186446 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_CLKDEV_LOOKUP)	+= clkdev.o
 obj-$(CONFIG_GENERIC_CLK)	+= clk.o
 obj-$(CONFIG_GENERIC_CLK_FIXED)	+= clk-fixed.o
+obj-$(CONFIG_GENERIC_CLK_GATE)	+= clk-gate.o
diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
new file mode 100644
index 0000000..833e0da
--- /dev/null
+++ b/drivers/clk/clk-gate.c
@@ -0,0 +1,41 @@
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <asm/io.h>
+
+#define to_clk_gate(clk) container_of(clk, struct clk_gate, hw)
+
+static unsigned long clk_gate_get_rate(struct clk_hw *clk)
+{
+	return clk_get_rate(clk_get_parent(clk->clk));
+}
+
+static int clk_gate_enable(struct clk_hw *clk)
+{
+	struct clk_gate *gate = to_clk_gate(clk);
+	u32 reg;
+
+	reg = __raw_readl(gate->reg);
+	reg |= 1 << gate->bit_idx;
+	__raw_writel(reg, gate->reg);
+
+	return 0;
+}
+
+static void clk_gate_disable(struct clk_hw *clk)
+{
+	struct clk_gate *gate = to_clk_gate(clk);
+	u32 reg;
+
+	reg = __raw_readl(gate->reg);
+	reg &= ~(1 << gate->bit_idx);
+	__raw_writel(reg, gate->reg);
+}
+
+struct clk_hw_ops clk_gate_ops = {
+	.recalc_rate = clk_gate_get_rate,
+	.enable = clk_gate_enable,
+	.disable = clk_gate_disable,
+};
+EXPORT_SYMBOL_GPL(clk_gate_ops);
+
diff --git a/include/linux/clk.h b/include/linux/clk.h
index fd62e86..7c26135 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -124,6 +124,19 @@ extern struct clk_hw_ops clk_fixed_ops;
 
 #endif /* CONFIG_GENERIC_CLK_FIXED */
 
+#ifdef CONFIG_GENERIC_CLK_GATE
+
+struct clk_gate {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		bit_idx;
+};
+
+extern struct clk_hw_ops clk_gate_ops;
+
+#endif /* CONFIG_GENERIC_CLK_GATE */
+
+
 #else /* !CONFIG_GENERIC_CLK */
 
 /*
-- 
1.7.5.4
