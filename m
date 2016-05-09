From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:01:49 +0930
Subject: [PATCH 2/4] drvers/clk: Support fourth generation Aspeed SoCs
In-Reply-To: <1462797111-14271-1-git-send-email-joel@jms.id.au>
References: <1462797111-14271-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797111-14271-3-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A basic driver to create fixed rate clock devices from strapping
registers.

The clocks on the ast2400 are derived from an external oscillator and
the frequency of this can be derived from the strapping of the
processor. The frequency of internal clocks can be derived from other
registers in the SCU (System Control Unit).

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/Makefile        |   1 +
 drivers/clk/aspeed/Makefile |   1 +
 drivers/clk/aspeed/clk-g4.c | 109 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 drivers/clk/aspeed/Makefile
 create mode 100644 drivers/clk/aspeed/clk-g4.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 46869d696e4d..8eaaef013a28 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_X86)			+= x86/
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
 obj-$(CONFIG_H8300)		+= h8300/
+obj-$(CONFIG_ARCH_ASPEED)		+= aspeed/
diff --git a/drivers/clk/aspeed/Makefile b/drivers/clk/aspeed/Makefile
new file mode 100644
index 000000000000..d3457fbe3019
--- /dev/null
+++ b/drivers/clk/aspeed/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MACH_ASPEED_G4) += clk-g4.o
diff --git a/drivers/clk/aspeed/clk-g4.c b/drivers/clk/aspeed/clk-g4.c
new file mode 100644
index 000000000000..91677e9177f5
--- /dev/null
+++ b/drivers/clk/aspeed/clk-g4.c
@@ -0,0 +1,109 @@
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
+static void __init aspeed_of_hpll_clk_init(struct device_node *node)
+{
+	struct clk *clk, *clkin_clk;
+	void __iomem *base;
+	int reg, rate, clkin;
+	const char *name = node->name;
+	const char *parent_name;
+	const int rates[][4] = {
+		{384, 360, 336, 408},
+		{400, 375, 350, 425},
+	};
+
+	of_property_read_string(node, "clock-output-names", &name);
+	parent_name = of_clk_get_parent_name(node, 0);
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: of_iomap failed\n", node->full_name);
+		return;
+	}
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
+	reg = (reg >> 8) & 0x2;
+
+	if (clkin == 48000000 || clkin == 24000000)
+		rate = rates[0][reg] * 1000000;
+	else if (clkin == 25000000)
+		rate = rates[1][reg] * 1000000;
+	else {
+		pr_err("%s: unknown clkin frequency %dHz\n",
+				node->full_name, clkin);
+		WARN_ON(1);
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
+CLK_OF_DECLARE(aspeed_hpll_clock, "aspeed,g4-hpll-clock",
+	       aspeed_of_hpll_clk_init);
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
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s: of_iomap failed\n", node->full_name);
+		return;
+	}
+	reg = readl(base);
+	iounmap(base);
+
+	hpll_clk = of_clk_get(node, 0);
+	if (IS_ERR(hpll_clk)) {
+		pr_err("%s: of_clk_get failed\n", node->full_name);
+		return;
+	}
+
+	reg = (reg >> 23) & 0x3;
+	rate = clk_get_rate(hpll_clk) / (2 + 2 * reg);
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
+CLK_OF_DECLARE(aspeed_apb_clock, "aspeed,g4-apb-clock",
+	       aspeed_of_apb_clk_init);
-- 
2.8.1
