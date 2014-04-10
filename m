From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 10 Apr 2014 10:21:00 +0200
Subject: [PATCH v2 1/4] reset: add driver for socfpga
Message-ID: <1397118063-21619-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a reset-controller driver for the socfpga platform.
The reset-controller has four banks with up to 32 entries all encapsulated in
one module block.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes since v1:
	- use BITS_PER_LONG everywhere instead of MAX_BANK_WIDTH
	- print pdev->dev.of_node->full_name on error
	- use proper IS_ERR/PTR_ERR

 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-socfpga.c | 147 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 drivers/reset/reset-socfpga.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index cc29832..ab64077 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_RESET_CONTROLLER) += core.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
+obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
new file mode 100644
index 0000000..bdcd2fa
--- /dev/null
+++ b/drivers/reset/reset-socfpga.c
@@ -0,0 +1,147 @@
+/*
+ * Copyright 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
+ *
+ * based on
+ * Allwinner SoCs Reset Controller driver
+ *
+ * Copyright 2013 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define NR_BANKS		4
+#define OFFSET_MODRST		0x10
+
+struct socfpga_reset_data {
+	spinlock_t			lock;
+	void __iomem			*membase;
+	struct reset_controller_dev	rcdev;
+};
+
+static int socfpga_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct socfpga_reset_data *data = container_of(rcdev,
+						     struct socfpga_reset_data,
+						     rcdev);
+	int bank = id / BITS_PER_LONG;
+	int offset = id % BITS_PER_LONG;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->membase + OFFSET_MODRST + (bank * NR_BANKS));
+	writel(reg | BIT(offset), data->membase + OFFSET_MODRST +
+				 (bank * NR_BANKS));
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int socfpga_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct socfpga_reset_data *data = container_of(rcdev,
+						     struct socfpga_reset_data,
+						     rcdev);
+
+	int bank = id / BITS_PER_LONG;
+	int offset = id % BITS_PER_LONG;
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->membase + OFFSET_MODRST + (bank * NR_BANKS));
+	writel(reg & ~BIT(offset), data->membase + OFFSET_MODRST +
+				  (bank * NR_BANKS));
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static struct reset_control_ops socfpga_reset_ops = {
+	.assert		= socfpga_reset_assert,
+	.deassert	= socfpga_reset_deassert,
+};
+
+static int socfpga_reset_probe(struct platform_device *pdev)
+{
+	struct socfpga_reset_data *data;
+	struct resource *res;
+	int ret;
+
+	/*
+	 * The binding was mainlined without the required property.
+	 * Do not continue, when we encounter an old DT.
+	 */
+	if (!of_find_property(pdev->dev.of_node, "#reset-cells", NULL)) {
+		dev_err(&pdev->dev, "%s missing #reset-cells property\n",
+			pdev->dev.of_node->full_name);
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->membase))
+		return PTR_ERR(data->membase);
+
+	spin_lock_init(&data->lock);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = NR_BANKS * BITS_PER_LONG;
+	data->rcdev.ops = &socfpga_reset_ops;
+	data->rcdev.of_node = pdev->dev.of_node;
+	reset_controller_register(&data->rcdev);
+
+	return 0;
+}
+
+static int socfpga_reset_remove(struct platform_device *pdev)
+{
+	struct socfpga_reset_data *data = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&data->rcdev);
+
+	return 0;
+}
+
+static const struct of_device_id socfpga_reset_dt_ids[] = {
+	{ .compatible = "altr,rst-mgr", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver socfpga_reset_driver = {
+	.probe	= socfpga_reset_probe,
+	.remove	= socfpga_reset_remove,
+	.driver = {
+		.name		= "socfpga-reset",
+		.owner		= THIS_MODULE,
+		.of_match_table	= socfpga_reset_dt_ids,
+	},
+};
+module_platform_driver(socfpga_reset_driver);
+
+MODULE_AUTHOR("Steffen Trumtrar <s.trumtrar@pengutronix.de");
+MODULE_DESCRIPTION("Socfpga Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
