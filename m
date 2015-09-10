From: eric@anholt.net (Eric Anholt)
Date: Thu, 10 Sep 2015 15:22:29 -0700
Subject: [PATCH 2/3] clk: bcm2835: Add a driver for the auxiliary peripheral
 clock gates.
In-Reply-To: <1441923750-19404-1-git-send-email-eric@anholt.net>
References: <1441923750-19404-1-git-send-email-eric@anholt.net>
Message-ID: <1441923750-19404-3-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are a pair of SPI masters and a mini UART that were last minute
additions.  As a result, they didn't get integrated in the same way as
the other gates off of the VPU clock in CPRMAN.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/clk/bcm/Makefile          |  1 +
 drivers/clk/bcm/clk-bcm2835-aux.c | 80 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100644 drivers/clk/bcm/clk-bcm2835-aux.c

diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index ee2349b..3082d68 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -4,4 +4,5 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
 obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
+obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835-aux.o
 obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
new file mode 100644
index 0000000..1efa6fb
--- /dev/null
+++ b/drivers/clk/bcm/clk-bcm2835-aux.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2015 Broadcom
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/bcm2835.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/bcm2835-aux.h>
+
+static int bcm2835_aux_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct clk_onecell_data *onecell;
+	const char *parent;
+	struct clk *parent_clk;
+	void __iomem *reg;
+
+	parent_clk = of_clk_get(dev->of_node, 0);
+	if (IS_ERR(parent_clk))
+		return PTR_ERR(parent_clk);
+	parent = __clk_get_name(parent_clk);
+
+	reg = of_iomap(dev->of_node, 0);
+	if (!reg)
+		return -ENODEV;
+
+	onecell = kmalloc(sizeof(*onecell), GFP_KERNEL);
+	if (!onecell)
+		return -ENOMEM;
+	onecell->clk_num = BCM2835_AUX_CLOCK_COUNT;
+	onecell->clks = kzalloc(sizeof(*onecell->clks) *
+				BCM2835_AUX_CLOCK_COUNT, GFP_KERNEL);
+	if (!onecell->clks)
+		return -ENOMEM;
+
+	onecell->clks[BCM2835_AUX_CLOCK_UART] =
+		clk_register_gate(dev, "aux_uart", parent, 0, reg, 0, 0, NULL);
+
+	onecell->clks[BCM2835_AUX_CLOCK_SPI1] =
+		clk_register_gate(dev, "aux_spi1", parent, 0, reg, 1, 0, NULL);
+
+	onecell->clks[BCM2835_AUX_CLOCK_SPI2] =
+		clk_register_gate(dev, "aux_spi2", parent, 0, reg, 2, 0, NULL);
+
+	return of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
+				   onecell);
+}
+
+static const struct of_device_id bcm2835_aux_clk_of_match[] = {
+	{ .compatible = "brcm,bcm2835-aux-clock", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, bcm2835_aux_clk_of_match);
+
+static struct platform_driver bcm2835_aux_clk_driver = {
+	.driver = {
+		.name = "bcm2835-aux-clk",
+		.of_match_table = bcm2835_aux_clk_of_match,
+	},
+	.probe          = bcm2835_aux_clk_probe,
+};
+builtin_platform_driver(bcm2835_aux_clk_driver);
+
+MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
+MODULE_DESCRIPTION("BCM2835 auxiliary peripheral clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
