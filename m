From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri,  4 Sep 2015 09:41:45 +0000
Subject: [PATCH 1/6] soc: bcm2835: auxiliar devices enable infrastructure
In-Reply-To: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1441359711-2800-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835 SOC contains 3 auxiliar devices (spi1, spi2 and uart1)
that all are enabled via a shared register.

To serialize access to this shared register this soc-driver
is created that implements:
  bcm2835aux_enable(struct device *dev, const char *property);
  bcm2835aux_disable(struct device *dev, const char *property);

Which will read the property from the device tree of the device
and enable/disable that specific device as per device tree.

First use of this api will be spi-bcm2835aux.

This driver does not implement an interrupt-controller,
so only access to the auxiliar-device-enable register is required.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/soc/Kconfig                 |    1 +
 drivers/soc/Makefile                |    1 +
 drivers/soc/bcm/Kconfig             |   11 +++
 drivers/soc/bcm/Makefile            |    1 +
 drivers/soc/bcm/bcm2835-aux.c       |  154 +++++++++++++++++++++++++++++++++++
 include/linux/soc/bcm/bcm2835-aux.h |   23 ++++++
 6 files changed, 191 insertions(+)
 create mode 100644 drivers/soc/bcm/Kconfig
 create mode 100644 drivers/soc/bcm/Makefile
 create mode 100644 drivers/soc/bcm/bcm2835-aux.c
 create mode 100644 include/linux/soc/bcm/bcm2835-aux.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 96ddecb..5506e39 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"

+source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 7dc7c0d..c5744e1 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #

+obj-$(CONFIG_ARCH_BCM)		+= bcm/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
diff --git a/drivers/soc/bcm/Kconfig b/drivers/soc/bcm/Kconfig
new file mode 100644
index 0000000..e57e98f
--- /dev/null
+++ b/drivers/soc/bcm/Kconfig
@@ -0,0 +1,11 @@
+#
+# Broadcom SoC drivers
+#
+config SOC_BCM2835_AUX
+	tristate "Broadcom BCM2835 aux"
+	depends on OF
+	depends on ARCH_BCM2835 || COMPILE_TEST
+
+	help
+	  Support to enable/disable the BCM2835 auxiliar
+	  devices spi1, spi2, uart1
diff --git a/drivers/soc/bcm/Makefile b/drivers/soc/bcm/Makefile
new file mode 100644
index 0000000..370a872
--- /dev/null
+++ b/drivers/soc/bcm/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SOC_BCM2835_AUX) += bcm2835-aux.o
diff --git a/drivers/soc/bcm/bcm2835-aux.c b/drivers/soc/bcm/bcm2835-aux.c
new file mode 100644
index 0000000..5980d67
--- /dev/null
+++ b/drivers/soc/bcm/bcm2835-aux.c
@@ -0,0 +1,154 @@
+/*
+ * bcm2835-aux
+ *
+ * Copyright (C) 2015 Martin Sperl
+ *
+ * Author: Martin Sperl <kernel@martin.sperl.org>
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
+#include <linux/soc/bcm/bcm2835-aux.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+static DEFINE_SPINLOCK(bcm2835aux_lock);
+
+static struct platform_driver bcm2835aux_driver;
+
+static int bcm2835aux_dev_match(struct device *dev, void *data)
+{
+	struct device_node *dn = data;
+
+	return (dev->of_node == dn) ? 1 : 0;
+}
+
+static void *bcm2835aux_find_base(struct device *dev, const char *property)
+{
+	struct device *found = NULL;
+	struct device_node *np;
+
+	/* get the phandle of the device */
+	np = of_parse_phandle(dev->of_node, property, 0);
+	if (!np) {
+		dev_err(dev, "missing property %s\n", property);
+		return ERR_PTR(-ENODEV);
+	}
+
+	/* now find the device it points to */
+	found = driver_find_device(&bcm2835aux_driver.driver, NULL,
+				   np, bcm2835aux_dev_match);
+	if (!found) {
+		dev_err(dev, "device for phandle of %s not found\n",
+			property);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	/* now we got the device, so return the pointer */
+	return dev_get_drvdata(found);
+}
+
+static u32 bcm2835aux_find_mask(struct device *dev, const char *property)
+{
+	int err;
+	u32 mask;
+
+	err = of_property_read_u32_index(dev->of_node, property, 1, &mask);
+	if (err) {
+		dev_err(dev, "missing argument to %s: %d\n",
+			property, err);
+		return 0;
+	}
+
+	return mask;
+}
+
+static int bcm2835aux_bitset(struct device *dev, const char *property,
+			     bool set)
+{
+	u32 v, mask;
+	unsigned long flags;
+	void __iomem *base;
+
+	/* find the device */
+	base = bcm2835aux_find_base(dev, property);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* and extract the mask */
+	mask = bcm2835aux_find_mask(dev, property);
+	if (!mask)
+		return -ENOENT;
+
+	spin_lock_irqsave(&bcm2835aux_lock, flags);
+
+	v = readl(base);
+	if (set)
+		v |= mask;
+	else
+		v &= ~mask;
+
+	writel(v, base);
+
+	spin_unlock_irqrestore(&bcm2835aux_lock, flags);
+
+	return 0;
+}
+
+int bcm2835aux_enable(struct device *dev, const char *property)
+{
+	return bcm2835aux_bitset(dev, property, true);
+}
+EXPORT_SYMBOL_GPL(bcm2835aux_enable);
+
+int bcm2835aux_disable(struct device *dev, const char *property)
+{
+	return bcm2835aux_bitset(dev, property, false);
+}
+EXPORT_SYMBOL_GPL(bcm2835aux_disable);
+
+static int bcm2835aux_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOENT;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	platform_set_drvdata(pdev, base);
+
+	return 0;
+}
+
+static const struct of_device_id bcm2835aux_match[] = {
+	{ .compatible = "brcm,bcm2835-aux", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bcm2835aux_match);
+
+static struct platform_driver bcm2835aux_driver = {
+	.driver = {
+		.name           = "bcm2835-aux",
+		.of_match_table	= bcm2835aux_match,
+	},
+	.probe			= bcm2835aux_probe,
+};
+module_platform_driver(bcm2835aux_driver);
+
+MODULE_DESCRIPTION("enable/disable driver for aux-spi1/spi2/uart1 on Broadcom BCM2835");
+MODULE_AUTHOR("Martin Sperl <kernel@martin.sperl.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/bcm/bcm2835-aux.h b/include/linux/soc/bcm/bcm2835-aux.h
new file mode 100644
index 0000000..17a64c6
--- /dev/null
+++ b/include/linux/soc/bcm/bcm2835-aux.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2015 Martin Sperl
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
+#ifndef __BCM2835_AUX_H__
+#define __BCM2835_AUX_H__
+
+struct device;
+
+int bcm2835aux_enable(struct device *dev, const char *property);
+int bcm2835aux_disable(struct device *dev, const char *property);
+
+#endif
--
1.7.10.4
