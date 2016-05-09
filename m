From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:01:51 +0930
Subject: [PATCH 4/4] drivers/clk: Support Aspeed UART clock divisor
In-Reply-To: <1462797111-14271-1-git-send-email-joel@jms.id.au>
References: <1462797111-14271-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797111-14271-5-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Aspeed BMC SoCs have UART IP that derive their clocks from
a 24MHz reference. It's not clear where this reference comes from, so it
is hard coded in the driver.

This clock may be divided down by 13 if a certain register is set. This
driver reads this register and creates a struct clk for the UARTs to
consume.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/aspeed/Makefile   |  1 +
 drivers/clk/aspeed/clk-uart.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 drivers/clk/aspeed/clk-uart.c

diff --git a/drivers/clk/aspeed/Makefile b/drivers/clk/aspeed/Makefile
index 9ddb0f8f4356..9d5754c086eb 100644
--- a/drivers/clk/aspeed/Makefile
+++ b/drivers/clk/aspeed/Makefile
@@ -1,2 +1,3 @@
+obj-y += clk-uart.o
 obj-$(CONFIG_MACH_ASPEED_G4) += clk-g4.o
 obj-$(CONFIG_MACH_ASPEED_G5) += clk-g5.o
diff --git a/drivers/clk/aspeed/clk-uart.c b/drivers/clk/aspeed/clk-uart.c
new file mode 100644
index 000000000000..8cd23a758887
--- /dev/null
+++ b/drivers/clk/aspeed/clk-uart.c
@@ -0,0 +1,52 @@
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
+static void __init aspeed_of_uart_clk_init(struct device_node *node)
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
+	reg = readl(base);
+	iounmap(base);
+
+	/*
+	 * The documentation does not indicate where this 24MHz clock is
+	 * derived from.
+	 */
+	rate = 24000000;
+
+	if (reg & BIT(12))
+		rate /= 13;
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
+CLK_OF_DECLARE(aspeed_uart_clock, "aspeed,uart-clock",
+	       aspeed_of_uart_clk_init);
-- 
2.8.1
