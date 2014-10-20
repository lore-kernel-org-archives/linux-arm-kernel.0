From: carlo@caione.org (Carlo Caione)
Date: Mon, 20 Oct 2014 13:19:43 +0200
Subject: [PATCH v3 1/3] ARM: meson: reset: Add reset controller for MesonX SoCs
In-Reply-To: <1413803985-8363-1-git-send-email-carlo@caione.org>
References: <1413803985-8363-1-git-send-email-carlo@caione.org>
Message-ID: <1413803985-8363-2-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the reset controller found on the Amlogic
MesonX SoCs. For several devices in the AO (Always-On) power domain, it
is possible to reset them by programming a specific bit in a register.

Signed-off-by: Carlo Caione <carlo@caione.org>

---

Hi Philipp,
from the documentation and the sources I have, it seems that in the register
together with the bits for resetting the ICs there are also bits for turning
the ICs on and off. I really wanted to avoid create a new of_xlate function
just to map the reset IDs to the correct bit in the register so I left the
nr_resets to BITS_PER_LONG and I'm using the default of_xlate.
This way I can also avoid to use obscure reset IDs to be remapped when I can
use directly the bit number in the register as reset ID.

---
 drivers/reset/Makefile      |   1 +
 drivers/reset/reset-meson.c | 138 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)
 create mode 100644 drivers/reset/reset-meson.c

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 60fed3d..74f2372 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_RESET_CONTROLLER) += core.o
 obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
+obj-$(CONFIG_ARCH_MESON) += reset-meson.o
 obj-$(CONFIG_ARCH_STI) += sti/
diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
new file mode 100644
index 0000000..4435630
--- /dev/null
+++ b/drivers/reset/reset-meson.c
@@ -0,0 +1,138 @@
+/*
+ * Copyright 2014 Carlo Caione <carlo@caione.org>
+ *
+ * based on
+ * Socfpga Reset Controller driver
+ *
+ * Copyright 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
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
+struct meson_reset_data {
+	spinlock_t			lock;
+	void __iomem			*membase;
+	struct reset_controller_dev	rcdev;
+};
+
+static int meson_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct meson_reset_data *data = container_of(rcdev,
+						     struct meson_reset_data,
+						     rcdev);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->membase);
+	writel(reg | BIT(id), data->membase);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int meson_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct meson_reset_data *data = container_of(rcdev,
+						     struct meson_reset_data,
+						     rcdev);
+
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->membase);
+	writel(reg & ~BIT(id), data->membase);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int meson_reset_dev(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	int err;
+
+	err = meson_reset_assert(rcdev, id);
+	if (err)
+		return err;
+
+	return meson_reset_deassert(rcdev, id);
+}
+
+static struct reset_control_ops meson_reset_ops = {
+	.assert		= meson_reset_assert,
+	.deassert	= meson_reset_deassert,
+	.reset		= meson_reset_dev,
+};
+
+static int meson_reset_probe(struct platform_device *pdev)
+{
+	struct meson_reset_data *data;
+	struct resource *res;
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
+	platform_set_drvdata(pdev, data);
+
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = BITS_PER_LONG;
+	data->rcdev.ops = &meson_reset_ops;
+	data->rcdev.of_node = pdev->dev.of_node;
+
+	return reset_controller_register(&data->rcdev);
+}
+
+static int meson_reset_remove(struct platform_device *pdev)
+{
+	struct meson_reset_data *data = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&data->rcdev);
+
+	return 0;
+}
+
+static const struct of_device_id meson_reset_dt_ids[] = {
+	{ .compatible = "amlogic,meson6-rst-mgr-ao", },
+	{ /* sentinel */ },
+};
+
+static struct platform_driver meson_reset_driver = {
+	.probe	= meson_reset_probe,
+	.remove	= meson_reset_remove,
+	.driver = {
+		.name		= "meson-reset",
+		.of_match_table	= meson_reset_dt_ids,
+	},
+};
+module_platform_driver(meson_reset_driver);
+
+MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
+MODULE_DESCRIPTION("Meson Reset Controller Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.1
