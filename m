From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 17 Oct 2017 15:03:02 +0200
Subject: [PATCH v4 1/5] reset: add reset-simple to unify socfpga, stm32, sunxi,
 and zx2967
In-Reply-To: <20171017130306.881-1-p.zabel@pengutronix.de>
References: <20171017130306.881-1-p.zabel@pengutronix.de>
Message-ID: <20171017130306.881-2-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Copy reusable parts from the sunxi driver, to add a driver for simple
reset controllers with reset lines that can be controlled by toggling
bits in exclusive, contiguous register ranges using read-modify-write
cycles under a spinlock.

The following patches will replace compatible reset drivers with
reset-simple, extending it where necessary.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Alexandru Gagniuc <alex.g@adaptrum.com>
---
Changes since v3:
 - Split patch 1 into reset-simple and reset-sunxi parts.
 - Renamed reset_simple_set to reset_simple_update
---
 drivers/reset/Kconfig        |  10 ++++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-simple.c | 134 +++++++++++++++++++++++++++++++++++++++++++
 drivers/reset/reset-simple.h |  41 +++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 drivers/reset/reset-simple.c
 create mode 100644 drivers/reset/reset-simple.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 1c88af2947245..392e65187cd5a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -75,6 +75,16 @@ config RESET_PISTACHIO
 	help
 	  This enables the reset driver for ImgTec Pistachio SoCs.
 
+config RESET_SIMPLE
+	bool "Simple Reset Controller Driver" if COMPILE_TEST
+	default ARCH_SUNXI
+	help
+	  This enables a simple reset controller driver for reset lines that
+	  that can be asserted and deasserted by toggling bits in a contiguous,
+	  exclusive register space.
+
+	  Currently this driver supports Allwinner SoCs.
+
 config RESET_SOCFPGA
 	bool "SoCFPGA Reset Driver" if COMPILE_TEST
 	default ARCH_SOCFPGA || ARCH_STRATIX10
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index af1c15c330b30..ddd3eeb193567 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
new file mode 100644
index 0000000000000..a5119457cec61
--- /dev/null
+++ b/drivers/reset/reset-simple.c
@@ -0,0 +1,134 @@
+/*
+ * Simple Reset Controller Driver
+ *
+ * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
+ *
+ * Based on Allwinner SoCs Reset Controller driver
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
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+
+#include "reset-simple.h"
+
+static inline struct reset_simple_data *
+to_reset_simple_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct reset_simple_data, rcdev);
+}
+
+static int reset_simple_update(struct reset_controller_dev *rcdev,
+			       unsigned long id, bool assert)
+{
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	reg = readl(data->membase + (bank * reg_width));
+	if (assert ^ data->active_low)
+		reg |= BIT(offset);
+	else
+		reg &= ~BIT(offset);
+	writel(reg, data->membase + (bank * reg_width));
+
+	spin_unlock_irqrestore(&data->lock, flags);
+
+	return 0;
+}
+
+static int reset_simple_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return reset_simple_update(rcdev, id, true);
+}
+
+static int reset_simple_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return reset_simple_update(rcdev, id, false);
+}
+
+const struct reset_control_ops reset_simple_ops = {
+	.assert		= reset_simple_assert,
+	.deassert	= reset_simple_deassert,
+};
+
+/**
+ * struct reset_simple_devdata - simple reset controller properties
+ * @active_low: if true, bits are cleared to assert the reset. Otherwise, bits
+ *              are set to assert the reset.
+ */
+struct reset_simple_devdata {
+	bool active_low;
+};
+
+static const struct reset_simple_devdata reset_simple_active_low = {
+	.active_low = true,
+};
+
+static const struct of_device_id reset_simple_dt_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-clock-reset",
+		.data = &reset_simple_active_low },
+	{ /* sentinel */ },
+};
+
+static int reset_simple_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct reset_simple_devdata *devdata;
+	struct reset_simple_data *data;
+	void __iomem *membase;
+	struct resource *res;
+
+	devdata = of_device_get_match_data(dev);
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	membase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(membase))
+		return PTR_ERR(membase);
+
+	spin_lock_init(&data->lock);
+	data->membase = membase;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
+	data->rcdev.ops = &reset_simple_ops;
+	data->rcdev.of_node = dev->of_node;
+
+	if (devdata)
+		data->active_low = devdata->active_low;
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
+static struct platform_driver reset_simple_driver = {
+	.probe	= reset_simple_probe,
+	.driver = {
+		.name		= "simple-reset",
+		.of_match_table	= reset_simple_dt_ids,
+	},
+};
+builtin_platform_driver(reset_simple_driver);
diff --git a/drivers/reset/reset-simple.h b/drivers/reset/reset-simple.h
new file mode 100644
index 0000000000000..39af2014b5f12
--- /dev/null
+++ b/drivers/reset/reset-simple.h
@@ -0,0 +1,41 @@
+/*
+ * Simple Reset Controller ops
+ *
+ * Based on Allwinner SoCs Reset Controller driver
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
+#ifndef __RESET_SIMPLE_H__
+#define __RESET_SIMPLE_H__
+
+#include <linux/io.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+
+/**
+ * struct reset_simple_data - driver data for simple reset controllers
+ * @lock: spinlock to protect registers during read-modify-write cycles
+ * @membase: memory mapped I/O register range
+ * @rcdev: reset controller device base structure
+ * @active_low: if true, bits are cleared to assert the reset. Otherwise, bits
+ *              are set to assert the reset. Note that this says nothing about
+ *              the voltage level of the actual reset line.
+ */
+struct reset_simple_data {
+	spinlock_t			lock;
+	void __iomem			*membase;
+	struct reset_controller_dev	rcdev;
+	bool				active_low;
+};
+
+extern const struct reset_control_ops reset_simple_ops;
+
+#endif /* __RESET_SIMPLE_H__ */
-- 
2.11.0
