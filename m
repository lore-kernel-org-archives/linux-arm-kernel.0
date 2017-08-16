From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 16 Aug 2017 11:46:58 +0200
Subject: [PATCH v3 2/5] reset: socfpga: use the reset-simple driver
In-Reply-To: <20170816094701.30678-1-p.zabel@pengutronix.de>
References: <20170816094701.30678-1-p.zabel@pengutronix.de>
Message-ID: <20170816094701.30678-3-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset line status readback, inverted status support, and socfpga
device tree quirks to the simple reset driver, and use it to replace
the socfpga driver.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 - Rename "status_inverted" properties to "status_active_low".
 - Add reg_offset and nr_reset override to struct reset_simple_devdata.
 - Drop socfpga special case, instead check "altr,modrst-offset" device
   tree property if a default reg_offset is set.
---
 drivers/reset/Kconfig         |  10 +--
 drivers/reset/Makefile        |   1 -
 drivers/reset/reset-simple.c  |  50 +++++++++++++-
 drivers/reset/reset-simple.h  |   4 ++
 drivers/reset/reset-socfpga.c | 154 ------------------------------------------
 5 files changed, 55 insertions(+), 164 deletions(-)
 delete mode 100644 drivers/reset/reset-socfpga.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index f7ba01a71daee..78a8f6057985b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -70,19 +70,13 @@ config RESET_PISTACHIO
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST
-	default ARCH_SUNXI
+	default ARCH_SOCFPGA || ARCH_SUNXI
 	help
 	  This enables a simple reset controller driver for reset lines that
 	  that can be asserted and deasserted by toggling bits in a contiguous,
 	  exclusive register space.
 
-	  Currently this driver supports Allwinner SoCs.
-
-config RESET_SOCFPGA
-	bool "SoCFPGA Reset Driver" if COMPILE_TEST
-	default ARCH_SOCFPGA
-	help
-	  This enables the reset controller driver for Altera SoCFPGAs.
+	  Currently this driver supports Altera SoCFPGAs and Allwinner SoCs.
 
 config RESET_STM32
 	bool "STM32 Reset Driver" if COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index ab4af99c3dfdc..25f5f722dec01 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
-obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 70c57c0758c39..84b08ce4def01 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -68,25 +68,58 @@ static int reset_simple_deassert(struct reset_controller_dev *rcdev,
 	return reset_simple_set(rcdev, id, false);
 }
 
+static int reset_simple_status(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct reset_simple_data *data = to_reset_simple_data(rcdev);
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	u32 reg;
+
+	reg = readl(data->membase + (bank * reg_width));
+
+	return !(reg & BIT(offset)) ^ !data->status_active_low;
+}
+
 const struct reset_control_ops reset_simple_ops = {
 	.assert		= reset_simple_assert,
 	.deassert	= reset_simple_deassert,
+	.status		= reset_simple_status,
 };
 
 /**
  * struct reset_simple_devdata - simple reset controller properties
+ * @reg_offset: offset between base address and first reset register.
+ * @nr_resets: number of resets. If not set, default to resource size in bits.
  * @active_low: if true, bits are cleared to assert the reset. Otherwise, bits
  *              are set to assert the reset.
+ * @status_active_low: if true, bits read back as cleared while the reset is
+ *                     asserted. Otherwise, bits read back as set while the
+ *                     reset is asserted.
  */
 struct reset_simple_devdata {
+	u32 reg_offset;
+	u32 nr_resets;
 	bool active_low;
+	bool status_active_low;
+};
+
+#define SOCFPGA_NR_BANKS	8
+
+static const struct reset_simple_devdata reset_simple_socfpga = {
+	.reg_offset = 0x10,
+	.nr_resets = SOCFPGA_NR_BANKS * 32,
+	.status_active_low = true,
 };
 
 static const struct reset_simple_devdata reset_simple_active_low = {
 	.active_low = true,
+	.status_active_low = true,
 };
 
 static const struct of_device_id reset_simple_dt_ids[] = {
+	{ .compatible = "altr,rst-mgr", .data = &reset_simple_socfpga },
 	{ .compatible = "allwinner,sun6i-a31-clock-reset",
 		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
@@ -118,8 +151,23 @@ static int reset_simple_probe(struct platform_device *pdev)
 	data->rcdev.ops = &reset_simple_ops;
 	data->rcdev.of_node = dev->of_node;
 
-	if (devdata)
+	if (devdata) {
+		u32 reg_offset = devdata->reg_offset;
+
+		if (reg_offset &&
+		    of_property_read_u32(dev->of_node, "altr,modrst-offset",
+					 &reg_offset)) {
+			dev_warn(dev,
+				 "missing altr,modrst-offset property, assuming 0x%x!\n",
+				 reg_offset);
+		}
+
+		data->membase += reg_offset;
+		if (devdata->nr_resets)
+			data->rcdev.nr_resets = devdata->nr_resets;
 		data->active_low = devdata->active_low;
+		data->status_active_low = devdata->status_active_low;
+	}
 
 	return devm_reset_controller_register(dev, &data->rcdev);
 }
diff --git a/drivers/reset/reset-simple.h b/drivers/reset/reset-simple.h
index 39af2014b5f12..8a496022baeff 100644
--- a/drivers/reset/reset-simple.h
+++ b/drivers/reset/reset-simple.h
@@ -28,12 +28,16 @@
  * @active_low: if true, bits are cleared to assert the reset. Otherwise, bits
  *              are set to assert the reset. Note that this says nothing about
  *              the voltage level of the actual reset line.
+ * @status_active_low: if true, bits read back as cleared while the reset is
+ *                     asserted. Otherwise, bits read back as set while the
+ *                     reset is asserted.
  */
 struct reset_simple_data {
 	spinlock_t			lock;
 	void __iomem			*membase;
 	struct reset_controller_dev	rcdev;
 	bool				active_low;
+	bool				status_active_low;
 };
 
 extern const struct reset_control_ops reset_simple_ops;
diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
deleted file mode 100644
index 07224c0198920..0000000000000
--- a/drivers/reset/reset-socfpga.c
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- * Socfpga Reset Controller Driver
- *
- * Copyright 2014 Steffen Trumtrar <s.trumtrar@pengutronix.de>
- *
- * based on
- * Allwinner SoCs Reset Controller driver
- *
- * Copyright 2013 Maxime Ripard
- *
- * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/reset-controller.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-#define BANK_INCREMENT		4
-#define NR_BANKS		8
-
-struct socfpga_reset_data {
-	spinlock_t			lock;
-	void __iomem			*membase;
-	struct reset_controller_dev	rcdev;
-};
-
-static int socfpga_reset_assert(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	struct socfpga_reset_data *data = container_of(rcdev,
-						     struct socfpga_reset_data,
-						     rcdev);
-	int bank = id / BITS_PER_LONG;
-	int offset = id % BITS_PER_LONG;
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(data->membase + (bank * BANK_INCREMENT));
-	writel(reg | BIT(offset), data->membase + (bank * BANK_INCREMENT));
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
-}
-
-static int socfpga_reset_deassert(struct reset_controller_dev *rcdev,
-				  unsigned long id)
-{
-	struct socfpga_reset_data *data = container_of(rcdev,
-						     struct socfpga_reset_data,
-						     rcdev);
-
-	int bank = id / BITS_PER_LONG;
-	int offset = id % BITS_PER_LONG;
-	unsigned long flags;
-	u32 reg;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	reg = readl(data->membase + (bank * BANK_INCREMENT));
-	writel(reg & ~BIT(offset), data->membase + (bank * BANK_INCREMENT));
-
-	spin_unlock_irqrestore(&data->lock, flags);
-
-	return 0;
-}
-
-static int socfpga_reset_status(struct reset_controller_dev *rcdev,
-				unsigned long id)
-{
-	struct socfpga_reset_data *data = container_of(rcdev,
-						struct socfpga_reset_data, rcdev);
-	int bank = id / BITS_PER_LONG;
-	int offset = id % BITS_PER_LONG;
-	u32 reg;
-
-	reg = readl(data->membase + (bank * BANK_INCREMENT));
-
-	return !(reg & BIT(offset));
-}
-
-static const struct reset_control_ops socfpga_reset_ops = {
-	.assert		= socfpga_reset_assert,
-	.deassert	= socfpga_reset_deassert,
-	.status		= socfpga_reset_status,
-};
-
-static int socfpga_reset_probe(struct platform_device *pdev)
-{
-	struct socfpga_reset_data *data;
-	struct resource *res;
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	u32 modrst_offset;
-
-	/*
-	 * The binding was mainlined without the required property.
-	 * Do not continue, when we encounter an old DT.
-	 */
-	if (!of_find_property(pdev->dev.of_node, "#reset-cells", NULL)) {
-		dev_err(&pdev->dev, "%s missing #reset-cells property\n",
-			pdev->dev.of_node->full_name);
-		return -EINVAL;
-	}
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
-	if (of_property_read_u32(np, "altr,modrst-offset", &modrst_offset)) {
-		dev_warn(dev, "missing altr,modrst-offset property, assuming 0x10!\n");
-		modrst_offset = 0x10;
-	}
-	data->membase += modrst_offset;
-
-	spin_lock_init(&data->lock);
-
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = NR_BANKS * BITS_PER_LONG;
-	data->rcdev.ops = &socfpga_reset_ops;
-	data->rcdev.of_node = pdev->dev.of_node;
-
-	return devm_reset_controller_register(dev, &data->rcdev);
-}
-
-static const struct of_device_id socfpga_reset_dt_ids[] = {
-	{ .compatible = "altr,rst-mgr", },
-	{ /* sentinel */ },
-};
-
-static struct platform_driver socfpga_reset_driver = {
-	.probe	= socfpga_reset_probe,
-	.driver = {
-		.name		= "socfpga-reset",
-		.of_match_table	= socfpga_reset_dt_ids,
-	},
-};
-builtin_platform_driver(socfpga_reset_driver);
-- 
2.11.0
