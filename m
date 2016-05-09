From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:01:50 +0930
Subject: [PATCH 3/4] drvers/clk: Support fifth generation Aspeed SoCs
In-Reply-To: <1462797111-14271-1-git-send-email-joel@jms.id.au>
References: <1462797111-14271-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797111-14271-4-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A basic driver to create fixed rate clock devices from strapping
registers.

Like the ast2400, the ast2500 clocks are derived from an external
oscillator and the frequency of this can be determined from the
strapping of the processor.

The frequency of internal clocks can be derived from other registers in
the SCU (System Control Unit). The layout of the internal clocks is a
bit different to the ast2400, as are the divisor reigisters, so it has
it's own driver.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/aspeed/Makefile |   1 +
 drivers/clk/aspeed/clk-g5.c | 189 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+)
 create mode 100644 drivers/clk/aspeed/clk-g5.c

diff --git a/drivers/clk/aspeed/Makefile b/drivers/clk/aspeed/Makefile
index d3457fbe3019..9ddb0f8f4356 100644
--- a/drivers/clk/aspeed/Makefile
+++ b/drivers/clk/aspeed/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MACH_ASPEED_G4) += clk-g4.o
+obj-$(CONFIG_MACH_ASPEED_G5) += clk-g5.o
diff --git a/drivers/clk/aspeed/clk-g5.c b/drivers/clk/aspeed/clk-g5.c
new file mode 100644
index 000000000000..812fd9accf30
--- /dev/null
+++ b/drivers/clk/aspeed/clk-g5.c
@@ -0,0 +1,189 @@
+/*
+ * Copyright 2016 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/clkdev.h>
+
+static void __init aspeed_of_clkin_clk_init(struct device_node *node)
+{
+	struct clk *clk;
+	void __iomem *base;
+	int reg, rate;
+	const char *name = node->name;
+
+	of_property_read_string(node, "clock-output-names", &name);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: of_iomap failed\n", node->full_name);
+		return;
+	}
+	/* Strap register SCU70 */
+	reg = readl(base) & BIT(23);
+	iounmap(base);
+
+	if (reg)
+		rate = 25 * 1000 * 1000;
+	else
+		rate = 24 * 1000 * 1000;
+
+	clk = clk_register_fixed_rate(NULL, name, NULL, 0, rate);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register clock\n", node->full_name);
+		return;
+	}
+
+	clk_register_clkdev(clk, NULL, name);
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(aspeed_clkin_clock, "aspeed,g5-clkin-clock",
+	       aspeed_of_clkin_clk_init);
+
+
+static void __init aspeed_of_hpll_clk_init(struct device_node *node)
+{
+	struct clk *clk, *clkin_clk;
+	void __iomem *base;
+	int reg, rate, clkin;
+	const char *name = node->name;
+	const char *parent_name;
+
+	of_property_read_string(node, "clock-output-names", &name);
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: of_iomap failed\n", node->full_name);
+		return;
+	}
+	/* H-PLL parameter register SCU24 */
+	reg = readl(base);
+	iounmap(base);
+
+	clkin_clk = of_clk_get(node, 0);
+	if (IS_ERR(clkin_clk)) {
+		pr_err("%s: of_clk_get failed\n", node->full_name);
+		return;
+	}
+
+	clkin = clk_get_rate(clkin_clk);
+
+	if (reg & BIT(21)) {
+		rate = 0;
+	} else if (reg & BIT(20)) {
+		rate = clkin;
+	} else {
+		int p = (reg >> 13) & 0x3f;
+		int m = (reg >> 5) & 0xff;
+		int n = reg & 0x1f;
+
+		rate = clkin * ((m + 1) / (n + 1)) / (p + 1);
+	}
+
+	clk = clk_register_fixed_rate(NULL, name, parent_name, 0, rate);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register clock\n", node->full_name);
+		return;
+	}
+
+	clk_register_clkdev(clk, NULL, name);
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(aspeed_hpll_clock, "aspeed,g5-hpll-clock",
+	       aspeed_of_hpll_clk_init);
+
+
+static void __init aspeed_of_ahb_clk_init(struct device_node *node)
+{
+	struct clk *clk, *hpll_clk;
+	void __iomem *base;
+	int reg, rate, hpll;
+	const char *name = node->name;
+	const char *parent_name;
+
+	of_property_read_string(node, "clock-output-names", &name);
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	/* Strap register SCU70 */
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: of_iomap failed\n", node->full_name);
+		return;
+	}
+	reg = (readl(base) >> 9) & 0x03;
+	iounmap(base);
+
+	/* A value of zero is undefined */
+	WARN_ON(reg == 0);
+
+	hpll_clk = of_clk_get(node, 0);
+	if (IS_ERR(hpll_clk)) {
+		pr_err("%s: of_clk_get failed\n", node->full_name);
+		return;
+	}
+
+	hpll = clk_get_rate(hpll_clk);
+
+	rate = hpll / 2 / (reg + 1);
+
+	clk = clk_register_fixed_rate(NULL, name, parent_name, 0, rate);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register clock\n", node->full_name);
+		return;
+	}
+
+	clk_register_clkdev(clk, NULL, name);
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(aspeed_ahb_clock, "aspeed,g5-ahb-clock",
+	       aspeed_of_ahb_clk_init);
+
+
+static void __init aspeed_of_apb_clk_init(struct device_node *node)
+{
+	struct clk *clk, *hpll_clk;
+	void __iomem *base;
+	int reg, rate;
+	const char *name = node->name;
+	const char *parent_name;
+
+	of_property_read_string(node, "clock-output-names", &name);
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	/* Clock selection register SCU08 */
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: of_iomap failed\n", node->full_name);
+		return;
+	}
+	reg = readl(base) >> 23 & 0x3;
+	iounmap(base);
+
+	hpll_clk = of_clk_get(node, 0);
+	if (IS_ERR(hpll_clk)) {
+		pr_err("%s: of_clk_get failed\n", node->full_name);
+		return;
+	}
+
+	rate = clk_get_rate(hpll_clk) / (4 * (reg + 1));
+
+	clk = clk_register_fixed_rate(NULL, name, parent_name, 0, rate);
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed to register clock\n", node->full_name);
+		return;
+	}
+
+	clk_register_clkdev(clk, NULL, name);
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+CLK_OF_DECLARE(aspeed_apb_clock, "aspeed,g5-apb-clock",
+	       aspeed_of_apb_clk_init);
-- 
2.8.1
