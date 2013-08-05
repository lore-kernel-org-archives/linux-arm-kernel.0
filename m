From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 12:12:22 -0400
Subject: [PATCH 3/8] clk: keystone: common clk driver initialization
In-Reply-To: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375719147-7578-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375719147-7578-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise common clock drivers for Keystone 2 devices.

Cc: Mike Turquette <mturquette@linaro.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/clk/keystone/clk.c   |   34 ++++++++++++++++++++++++++++++++++
 include/linux/clk/keystone.h |    1 +
 2 files changed, 35 insertions(+)
 create mode 100644 drivers/clk/keystone/clk.c

diff --git a/drivers/clk/keystone/clk.c b/drivers/clk/keystone/clk.c
new file mode 100644
index 0000000..9001380
--- /dev/null
+++ b/drivers/clk/keystone/clk.c
@@ -0,0 +1,34 @@
+/*
+ * Common Clock initialization code for Keystone SOCs
+ *
+ * Copyright (C) 2013 Texas Instruments Inc.
+ *	Murali Karicheri <m-karicheri2@ti.com>
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/clk/keystone.h>
+
+static const __initconst struct of_device_id clk_match[] = {
+	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
+	{ .compatible = "fixed-factor-clock", .data =
+					 of_fixed_factor_clk_setup, },
+	{ .compatible = "keystone,pll-clk", .data = of_keystone_pll_clk_init, },
+	{ .compatible = "mux-clk", .data = of_mux_clk_setup, },
+	{ .compatible = "divider-clock", .data = of_divider_clk_setup, },
+	{ .compatible = "keystone,psc-clk", .data = of_keystone_psc_clk_init, },
+	{}
+};
+
+void __init of_keystone_clk_init()
+{
+	/* initialize clk providers from device tree */
+	of_clk_init(clk_match);
+}
diff --git a/include/linux/clk/keystone.h b/include/linux/clk/keystone.h
index 7b3e154..282e88f 100644
--- a/include/linux/clk/keystone.h
+++ b/include/linux/clk/keystone.h
@@ -15,5 +15,6 @@
 
 extern void of_keystone_pll_clk_init(struct device_node *node);
 extern void of_keystone_psc_clk_init(struct device_node *node);
+extern void of_keystone_clk_init(void);
 
 #endif /* __LINUX_CLK_KEYSTONE_H_ */
-- 
1.7.9.5
