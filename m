From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 22 Jun 2015 12:12:54 +0200
Subject: [PATCH v4 2/2] mfd: flexcom: add a driver for Atmel Flexible Serial
 Communication Unit
In-Reply-To: <cover.1434967670.git.cyrille.pitchen@atmel.com>
References: <cover.1434967670.git.cyrille.pitchen@atmel.com>
Message-ID: <dddf7a6d750967785255733a7931780b3c465d5f.1434967670.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver supports the new Atmel Flexcom. The Flexcom is a wrapper which
integrates one SPI controller, one I2C controller and one USART. Only one
function can be enabled at a time. This driver selects the function once
for all, when the Flexcom is probed, according to the value of the new
"atmel,flexcom-mode" device tree property.

This driver has chosen to present the Flexcom to the system as a MFD so
the implementation is seamless for the existing Atmel SPI, I2C and USART
drivers.

Also the Flexcom embeds FIFOs: the latest patches of the SPI, I2C and
USART drivers take advantage of this new feature.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/mfd/Kconfig         | 11 +++++
 drivers/mfd/Makefile        |  1 +
 drivers/mfd/atmel-flexcom.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 drivers/mfd/atmel-flexcom.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d5ad04d..9b33ad0 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -59,6 +59,17 @@ config MFD_AAT2870_CORE
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_ATMEL_FLEXCOM
+	tristate "Atmel Flexcom (Flexible Serial Communication Unit)"
+	select MFD_CORE
+	depends on OF
+	help
+	  Select this to get support for Atmel Flexcom. This is a wrapper
+	  which embeds a SPI controller, a I2C controller and a USART. Only
+	  one function can be used at a time. The choice is done at boot time
+	  by the probe function of this MFD driver according to a device tree
+	  property.
+
 config MFD_ATMEL_HLCDC
 	tristate "Atmel HLCDC (High-end LCD Controller)"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 0e5cfeb..c666bf5 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -160,6 +160,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
 obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
 obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
+obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
 obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
new file mode 100644
index 0000000..7e7d4b8
--- /dev/null
+++ b/drivers/mfd/atmel-flexcom.c
@@ -0,0 +1,98 @@
+/*
+ * Driver for Atmel Flexcom
+ *
+ * Copyright (C) 2015 Atmel Corporation
+ *
+ * Author: Cyrille Pitchen <cyrille.pitchen@atmel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+
+#define FX_MR		0x0
+#define FX_RHR		0x10
+#define FX_THR		0x20
+#define FX_VERSION	0xfc
+
+#define FX_MR_NO_COM	0
+#define FX_MR_USART	1
+#define FX_MR_SPI	2
+#define FX_MR_TWI	3
+
+
+static int atmel_flexcom_probe(struct platform_device *pdev)
+{
+	struct clk *clk;
+	struct resource *res;
+	unsigned char __iomem *map;
+	unsigned int version, mr;
+	const char *mode;
+	int err;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	map = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	err = of_property_read_string(pdev->dev.of_node,
+				      "atmel,flexcom-mode", &mode);
+	if (err)
+		return err;
+
+	if (!strcmp(mode, "usart"))
+		mr = FX_MR_USART;
+	else if (!strcmp(mode, "spi"))
+		mr = FX_MR_SPI;
+	else if (!strcmp(mode, "twi") || !strcmp(mode, "i2c"))
+		mr = FX_MR_TWI;
+	else
+		return -EINVAL;
+
+	err = clk_prepare_enable(clk);
+	if (err)
+		return err;
+	version = readl(map + FX_VERSION);
+	writel(mr, map + FX_MR);
+	clk_disable_unprepare(clk);
+
+	dev_info(&pdev->dev, "version: %#x, mode: %s\n", version, mode);
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+static const struct of_device_id atmel_flexcom_of_match[] = {
+	{ .compatible = "atmel,sama5d2-flexcom" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
+
+static struct platform_driver atmel_flexcom_driver = {
+	.driver		= {
+		.name	= "atmel_flexcom",
+		.of_match_table = atmel_flexcom_of_match,
+	},
+	.probe		= atmel_flexcom_probe,
+};
+
+module_platform_driver(atmel_flexcom_driver);
+
+MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@atmel.com>");
+MODULE_DESCRIPTION("Atmel Flexcom MFD driver");
+MODULE_LICENSE("GPL");
-- 
1.8.2.2
