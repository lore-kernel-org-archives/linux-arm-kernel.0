From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Nov 2015 14:43:27 +0800
Subject: [PATCH v5 6/9] mfd: axp20x: Add support for RSB based AXP223 PMIC
In-Reply-To: <1448606610-32647-1-git-send-email-wens@csie.org>
References: <1448606610-32647-1-git-send-email-wens@csie.org>
Message-ID: <1448606610-32647-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP223 is a new PMIC commonly paired with Allwinner A23/A33 SoCs.
It is functionally identical to AXP221; only the regulator default
voltage/status and the external host interface are different.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mfd/Kconfig        | 11 +++++++
 drivers/mfd/Makefile       |  1 +
 drivers/mfd/axp20x-rsb.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/axp20x.c       |  2 ++
 include/linux/mfd/axp20x.h |  1 +
 5 files changed, 93 insertions(+)
 create mode 100644 drivers/mfd/axp20x-rsb.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 804cd3dcce32..13c565103e96 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -107,6 +107,17 @@ config MFD_AXP20X_I2C
 	  components like regulators or the PEK (Power Enable Key) under the
 	  corresponding menus.
 
+config MFD_AXP20X_RSB
+	tristate "X-Powers AXP series PMICs with RSB"
+	select MFD_AXP20X
+	depends on SUNXI_RSB
+	help
+	  If you say Y here you get support for the X-Powers AXP series power
+	  management ICs (PMICs) controlled with RSB.
+	  This driver include only the core APIs. You have to select individual
+	  components like regulators or the PEK (Power Enable Key) under the
+	  corresponding menus.
+
 config MFD_CROS_EC
 	tristate "ChromeOS Embedded Controller"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index a6913007d667..caea6637d5e8 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_MFD_DA9052_SPI)	+= da9052-spi.o
 obj-$(CONFIG_MFD_DA9052_I2C)	+= da9052-i2c.o
 obj-$(CONFIG_MFD_AXP20X)	+= axp20x.o
 obj-$(CONFIG_MFD_AXP20X_I2C)	+= axp20x-i2c.o
+obj-$(CONFIG_MFD_AXP20X_RSB)	+= axp20x-rsb.o
 
 obj-$(CONFIG_MFD_LP3943)	+= lp3943.o
 obj-$(CONFIG_MFD_LP8788)	+= lp8788.o lp8788-irq.o
diff --git a/drivers/mfd/axp20x-rsb.c b/drivers/mfd/axp20x-rsb.c
new file mode 100644
index 000000000000..76ff02b96df0
--- /dev/null
+++ b/drivers/mfd/axp20x-rsb.c
@@ -0,0 +1,78 @@
+/*
+ * axp20x-rsb.c - RSB driver for the X-Powers' Power Management ICs
+ *
+ * AXP20x typically comprises an adaptive USB-Compatible PWM charger, BUCK DC-DC
+ * converters, LDOs, multiple 12-bit ADCs of voltage, current and temperature
+ * as well as configurable GPIOs.
+ *
+ * This driver supports the RSB variants.
+ *
+ * Author: Chen-Yu Tsai <wens@csie.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mfd/axp20x.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sunxi-rsb.h>
+
+static int axp20x_rsb_probe(struct sunxi_rsb_device *rdev)
+{
+	struct axp20x_dev *axp20x;
+	int ret;
+
+	axp20x = devm_kzalloc(&rdev->dev, sizeof(*axp20x), GFP_KERNEL);
+	if (!axp20x)
+		return -ENOMEM;
+
+	axp20x->dev = &rdev->dev;
+	axp20x->irq = rdev->irq;
+	sunxi_rsb_device_set_drvdata(rdev, axp20x);
+
+	ret = axp20x_match_device(axp20x);
+	if (ret)
+		return ret;
+
+	axp20x->regmap = devm_regmap_init_sunxi_rsb(rdev, axp20x->regmap_cfg);
+	if (IS_ERR(axp20x->regmap)) {
+		ret = PTR_ERR(axp20x->regmap);
+		dev_err(&rdev->dev, "regmap init failed: %d\n", ret);
+		return ret;
+	}
+
+	return axp20x_device_probe(axp20x);
+}
+
+static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
+{
+	struct axp20x_dev *axp20x = sunxi_rsb_device_get_drvdata(rdev);
+
+	return axp20x_device_remove(axp20x);
+}
+
+static const struct of_device_id axp20x_rsb_of_match[] = {
+	{ .compatible = "x-powers,axp223", .data = (void *)AXP223_ID },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, axp20x_rsb_of_match);
+
+static struct sunxi_rsb_driver axp20x_rsb_driver = {
+	.driver = {
+		.name	= "axp20x-rsb",
+		.of_match_table	= of_match_ptr(axp20x_rsb_of_match),
+	},
+	.probe	= axp20x_rsb_probe,
+	.remove	= axp20x_rsb_remove,
+};
+module_sunxi_rsb_driver(axp20x_rsb_driver);
+
+MODULE_DESCRIPTION("PMIC MFD sunXi RSB driver for AXP20X");
+MODULE_AUTHOR("Chen-Yu Tsai <wens@csie.org>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 54a00168da26..968d77fb95d8 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -33,6 +33,7 @@ static const char * const axp20x_model_names[] = {
 	"AXP202",
 	"AXP209",
 	"AXP221",
+	"AXP223",
 	"AXP288",
 };
 
@@ -616,6 +617,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
 		axp20x->regmap_irq_chip = &axp20x_regmap_irq_chip;
 		break;
 	case AXP221_ID:
+	case AXP223_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp22x_cells);
 		axp20x->cells = axp22x_cells;
 		axp20x->regmap_cfg = &axp22x_regmap_config;
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 00697c6ad8b0..d82e7d51372b 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -18,6 +18,7 @@ enum {
 	AXP202_ID,
 	AXP209_ID,
 	AXP221_ID,
+	AXP223_ID,
 	AXP288_ID,
 	NR_AXP20X_VARIANTS,
 };
-- 
2.6.2
