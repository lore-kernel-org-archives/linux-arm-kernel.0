From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Mon, 12 Oct 2009 03:57:28 +0530
Subject: [PATCH v3 2/7] [ARM]: U8500 clock framework
Message-ID: <1255300048.21542.406.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

This adds basic clock framework to the U8500 platform.
At the moment it just uses the clock lookup table
and add the each entry to the clkdevice. More complex
clock management to follow soon.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---
 arch/arm/mach-ux500/clock.c                        |   95 ++++++++++++++++++++
 .../include/mach/clkdev.h                          |    0
 2 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/clock.c
 copy arch/arm/{mach-bcmring => mach-ux500}/include/mach/clkdev.h (100%)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
new file mode 100644
index 0000000..20b6ebb
--- /dev/null
+++ b/arch/arm/mach-ux500/clock.c
@@ -0,0 +1,95 @@
+/*
+ *  Copyright (C) 2009 ST-Ericsson
+ * 	heavily based on realview platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/mutex.h>
+
+#include <asm/clkdev.h>
+
+/* currently the clk structure
+ * just supports rate. This would
+ * be extended as and when new devices are
+ * added - TODO
+ */
+struct clk {
+	unsigned long		rate;
+};
+
+int clk_enable(struct clk *clk)
+{
+	return 0;
+}
+EXPORT_SYMBOL(clk_enable);
+
+void clk_disable(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(clk_disable);
+
+unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+EXPORT_SYMBOL(clk_get_rate);
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	/*TODO*/
+	return rate;
+}
+EXPORT_SYMBOL(clk_round_rate);
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	clk->rate = rate;
+	return 0;
+}
+EXPORT_SYMBOL(clk_set_rate);
+
+/* ssp clock */
+static struct clk ssp_clk = {
+	.rate = 48000000,
+};
+
+/* fixed clock */
+static struct clk f38_clk = {
+	.rate = 38400000,
+};
+
+static struct clk_lookup lookups[] = {
+	{
+		/* UART0 */
+		.dev_id		= "uart0",
+		.clk		= &f38_clk,
+	}, {	/* UART1 */
+		.dev_id		= "uart1",
+		.clk		= &f38_clk,
+	}, {	/* UART2 */
+		.dev_id		= "uart2",
+		.clk		= &f38_clk,
+	}, {	/* SSP */
+		.dev_id		= "pl022",
+		.clk		= &ssp_clk,
+	}
+};
+
+static int __init clk_init(void)
+{
+	int i;
+
+	/* register the clock lookups */
+	for (i = 0; i < ARRAY_SIZE(lookups); i++)
+		clkdev_add(&lookups[i]);
+	return 0;
+}
+arch_initcall(clk_init);
diff --git a/arch/arm/mach-bcmring/include/mach/clkdev.h b/arch/arm/mach-ux500/include/mach/clkdev.h
similarity index 100%
copy from arch/arm/mach-bcmring/include/mach/clkdev.h
copy to arch/arm/mach-ux500/include/mach/clkdev.h
-- 
1.6.3.GIT
