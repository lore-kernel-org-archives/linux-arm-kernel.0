From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 11 Aug 2017 15:06:14 +0200
Subject: [PATCH v2 1/5] reset: add reset-simple to unify socfpga, stm32, sunxi,
 and zx2967
In-Reply-To: <20170811130618.3676-1-p.zabel@pengutronix.de>
References: <20170811130618.3676-1-p.zabel@pengutronix.de>
Message-ID: <20170811130618.3676-2-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split reusable parts out of the sunxi driver, to add a driver for simple
reset controllers with reset lines that can be controlled by toggling
bits in exclusive, contiguous register ranges using read-modify-write
cycles under a spinlock. The separate sunxi driver still remains to
register the early reset controllers, but it reuses the reset-simple
ops.

The following patches will replace compatible reset drivers with
reset-simple, extending it where necessary.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
- Turn reset-simple into a complete platform driver.
- Move common code out of assert and deassert ops into a helper function.
- Add inverted flag to support both clear- and set-to-assert reset bits.
- Remove status readback, will be added in the next patch.
- Split out SoCFPGA and STM32 conversion into separate patches.
---
 drivers/reset/Kconfig        |  11 ++++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-simple.c | 129 +++++++++++++++++++++++++++++++++++++++++++
 drivers/reset/reset-simple.h |  32 +++++++++++
 drivers/reset/reset-sunxi.c  | 104 ++--------------------------------
 5 files changed, 179 insertions(+), 98 deletions(-)
 create mode 100644 drivers/reset/reset-simple.c
 create mode 100644 drivers/reset/reset-simple.h

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 52d5251660b9b..f7ba01a71daee 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -68,6 +68,16 @@ config RESET_PISTACHIO
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
 	default ARCH_SOCFPGA
@@ -83,6 +93,7 @@ config RESET_STM32
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
 	default ARCH_SUNXI
+	select RESET_SIMPLE
 	help
 	  This enables the reset driver for Allwinner SoCs.
 
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index b62783f50fe5b..ab4af99c3dfdc 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
+obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
new file mode 100644
index 0000000000000..08fc79d79e86d
--- /dev/null
+++ b/drivers/reset/reset-simple.c
@@ -0,0 +1,129 @@
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
+static int reset_simple_set(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool assert)
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
+	if (assert ^ data->inverted)
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
+	return reset_simple_set(rcdev, id, true);
+}
+
+static int reset_simple_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return reset_simple_set(rcdev, id, false);
+}
+
+const struct reset_control_ops reset_simple_ops = {
+	.assert		= reset_simple_assert,
+	.deassert	= reset_simple_deassert,
+};
+
+struct reset_simple_devdata {
+	bool inverted;
+};
+
+static const struct reset_simple_devdata reset_simple_inverted = {
+	.inverted = true,
+};
+
+static const struct of_device_id reset_simple_dt_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-clock-reset",
+		.data = &reset_simple_inverted },
+	{ /* sentinel */ },
+};
+
+static int reset_simple_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *of_id =
+		of_match_device(of_match_ptr(reset_simple_dt_ids), dev);
+	const struct reset_simple_devdata *devdata = of_id->data;
+	struct reset_simple_data *data;
+	void __iomem *membase;
+	struct resource *res;
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
+		data->inverted = devdata->inverted;
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
index 0000000000000..a26dc62b2f349
--- /dev/null
+++ b/drivers/reset/reset-simple.h
@@ -0,0 +1,32 @@
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
+struct reset_simple_data {
+	spinlock_t			lock;
+	void __iomem			*membase;
+	struct reset_controller_dev	rcdev;
+	bool				inverted;
+};
+
+extern const struct reset_control_ops reset_simple_ops;
+
+#endif /* __RESET_SIMPLE_H__ */
diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index 2c7dd1fd08df6..320e4e76ea8cd 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -22,64 +22,11 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-struct sunxi_reset_data {
-	spinlock_t			lock;
-	void __iomem			*membase;
-	struct reset_controller_dev	rcdev;
-};
-
-static int sunxi_reset_assert(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	struct sunxi_reset_data *data = container_of(rcdev,
-						     struct sunxi_reset_data,
-						     rcdev);
-	int reg_width = sizeof(u32);
-	int bank = id / (reg_width * BITS_PER_BYTE);
-	int offset = id % (reg_width * BITS_PER_BYTE);
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(data->membase + (bank * reg_width));
-	writel(reg & ~BIT(offset), data->membase + (bank * reg_width));
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
-}
-
-static int sunxi_reset_deassert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	struct sunxi_reset_data *data = container_of(rcdev,
-						     struct sunxi_reset_data,
-						     rcdev);
-	int reg_width = sizeof(u32);
-	int bank = id / (reg_width * BITS_PER_BYTE);
-	int offset = id % (reg_width * BITS_PER_BYTE);
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(data->membase + (bank * reg_width));
-	writel(reg | BIT(offset), data->membase + (bank * reg_width));
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
-}
-
-static const struct reset_control_ops sunxi_reset_ops = {
-	.assert		= sunxi_reset_assert,
-	.deassert	= sunxi_reset_deassert,
-};
+#include "reset-simple.h"
 
 static int sunxi_reset_init(struct device_node *np)
 {
-	struct sunxi_reset_data *data;
+	struct reset_simple_data *data;
 	struct resource res;
 	resource_size_t size;
 	int ret;
@@ -108,8 +55,9 @@ static int sunxi_reset_init(struct device_node *np)
 
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.nr_resets = size * 8;
-	data->rcdev.ops = &sunxi_reset_ops;
+	data->rcdev.ops = &reset_simple_ops;
 	data->rcdev.of_node = np;
+	data->inverted = true;
 
 	return reset_controller_register(&data->rcdev);
 
@@ -122,6 +70,8 @@ static int sunxi_reset_init(struct device_node *np)
  * These are the reset controller we need to initialize early on in
  * our system, before we can even think of using a regular device
  * driver for it.
+ * The controllers that we can register through the regular device
+ * model are handled by the simple reset driver directly.
  */
 static const struct of_device_id sunxi_early_reset_dt_ids[] __initconst = {
 	{ .compatible = "allwinner,sun6i-a31-ahb1-reset", },
@@ -135,45 +85,3 @@ void __init sun6i_reset_init(void)
 	for_each_matching_node(np, sunxi_early_reset_dt_ids)
 		sunxi_reset_init(np);
 }
-
-/*
- * And these are the controllers we can register through the regular
- * device model.
- */
-static const struct of_device_id sunxi_reset_dt_ids[] = {
-	 { .compatible = "allwinner,sun6i-a31-clock-reset", },
-	 { /* sentinel */ },
-};
-
-static int sunxi_reset_probe(struct platform_device *pdev)
-{
-	struct sunxi_reset_data *data;
-	struct resource *res;
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->membase = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(data->membase))
-		return PTR_ERR(data->membase);
-
-	spin_lock_init(&data->lock);
-
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = resource_size(res) * 8;
-	data->rcdev.ops = &sunxi_reset_ops;
-	data->rcdev.of_node = pdev->dev.of_node;
-
-	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
-}
-
-static struct platform_driver sunxi_reset_driver = {
-	.probe	= sunxi_reset_probe,
-	.driver = {
-		.name		= "sunxi-reset",
-		.of_match_table	= sunxi_reset_dt_ids,
-	},
-};
-builtin_platform_driver(sunxi_reset_driver);
-- 
2.11.0
