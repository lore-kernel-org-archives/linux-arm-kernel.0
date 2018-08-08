From: marek.behun@nic.cz (=?UTF-8?q?Marek=20Beh=C3=BAn?=)
Date: Wed,  8 Aug 2018 17:27:02 +0200
Subject: [PATCH v1 3/7] drivers: gpio: Add support for Turris Mox SFP GPIOs
In-Reply-To: <20180808152706.21727-1-marek.behun@nic.cz>
References: <20180808152706.21727-1-marek.behun@nic.cz>
Message-ID: <20180808152706.21727-4-marek.behun@nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SFP cage GPIOs on the SFP cage module of Turris Mox can be
configured via the moxtet bus.

This driver supports those GPIOs so that they can be used by phylink.

Signed-off-by: Marek Behun <marek.behun@nic.cz>

 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet-sfp.txt
 create mode 100644 drivers/gpio/gpio-moxtet-sfp.c

diff --git a/Documentation/devicetree/bindings/gpio/gpio-moxtet-sfp.txt b/Documentation/devicetree/bindings/gpio/gpio-moxtet-sfp.txt
new file mode 100644
index 000000000000..a8267aef7d2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-moxtet-sfp.txt
@@ -0,0 +1,16 @@
+GPIO configuration of the SFP cage found on Turris Mox (over Moxtet bus)
+
+Required properties:
+ - compatible		: Should be "cznic,moxtet-sfp".
+ - gpio-controller	: Marks the device node as a GPIO controller.
+ - #gpio-cells		: Should be two. For consumer use see gpio.txt.
+
+Example:
+
+	moxtet_sfp: moxtet-sfp at 0 {
+		compatible = "cznic,moxtet-sfp";
+		gpio-controller;
+		#gpio-cells;
+		reg = <0>;
+		moxtet,id = <1>;
+	}
diff --git a/MAINTAINERS b/MAINTAINERS
index 27ca12e8309a..cfac1b21596c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1383,6 +1383,7 @@ M:	Marek Behun <marek.behun@nic.cz>
 W:	http://mox.turris.cz
 S:	Maintained
 F:	include/mfd/moxtet.h
+F:	drivers/gpio/gpio-moxtet-sfp.c
 F:	drivers/mfd/moxtet.c
 
 ARM/EBSA110 MACHINE SUPPORT
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 71c0ab46f216..bd6e52de99c5 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1048,6 +1048,15 @@ config GPIO_MAX77620
 	  driver also provides interrupt support for each of the gpios.
 	  Say yes here to enable the max77620 to be used as gpio controller.
 
+config GPIO_MOXTET_SFP
+	tristate "Turris Mox SFP GPIO expander"
+	depends on MFD_MOXTET
+	help
+	  Say yes here if you are building for the Turris Mox router.
+	  This is the driver needed for configuring the GPIOs found on the
+	  module with SFP cage of the Turris Mox router.
+	  This driver uses the Moxtet bus.
+
 config GPIO_MSIC
 	bool "Intel MSIC mixed signal gpio support"
 	depends on (X86 || COMPILE_TEST) && MFD_INTEL_MSIC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 1324c8f966a7..ba464186c468 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -84,7 +84,8 @@ obj-$(CONFIG_GPIO_MC33880)	+= gpio-mc33880.o
 obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
-obj-$(CONFIG_GPIO_MOCKUP)      += gpio-mockup.o
+obj-$(CONFIG_GPIO_MOCKUP)	+= gpio-mockup.o
+obj-$(CONFIG_GPIO_MOXTET_SFP)	+= gpio-moxtet-sfp.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
 obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
@@ -100,7 +101,7 @@ obj-$(CONFIG_GPIO_PCI_IDIO_16)	+= gpio-pci-idio-16.o
 obj-$(CONFIG_GPIO_PCIE_IDIO_24)	+= gpio-pcie-idio-24.o
 obj-$(CONFIG_GPIO_PISOSR)	+= gpio-pisosr.o
 obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
-obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)	+= gpio-pmic-eic-sprd.o
+obj-$(CONFIG_GPIO_PMIC_EIC_SPRD)+= gpio-pmic-eic-sprd.o
 obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
diff --git a/drivers/gpio/gpio-moxtet-sfp.c b/drivers/gpio/gpio-moxtet-sfp.c
new file mode 100644
index 000000000000..87ba73bf55c5
--- /dev/null
+++ b/drivers/gpio/gpio-moxtet-sfp.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Turris Mox SFP - GPIOs on the SFP cage found on Turris Mox SFP module
+ *
+ *  Copyright (C) 2018 Marek Behun <marek.behun@nic.cz>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
+#include <linux/mfd/moxtet.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+
+#define MOXTET_SFP_IN_GPIOS	3
+
+struct moxtet_sfp_chip {
+	struct device		*dev;
+	struct gpio_chip	gpio_chip;
+	struct gpio_desc	*gpiod_oe;
+	u8			state;
+};
+
+static int moxtet_sfp_get_value(struct gpio_chip *gc, unsigned int offset)
+{
+	struct moxtet_sfp_chip *chip = gpiochip_get_data(gc);
+	int ret;
+
+	if (offset < MOXTET_SFP_IN_GPIOS) {
+		ret = moxtet_device_read(chip->dev);
+	} else {
+		offset -= MOXTET_SFP_IN_GPIOS;
+		ret = moxtet_device_written(chip->dev);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return (ret >> offset) & 1;
+}
+
+static void moxtet_sfp_set_value(struct gpio_chip *gc, unsigned int offset,
+				 int val)
+{
+	struct moxtet_sfp_chip *chip = gpiochip_get_data(gc);
+	int ret;
+
+	if (offset < MOXTET_SFP_IN_GPIOS)
+		return;
+
+	offset -= MOXTET_SFP_IN_GPIOS;
+
+	ret = moxtet_device_written(chip->dev);
+	if (ret < 0)
+		return;
+
+	if (val)
+		ret |= (1 << offset);
+	else
+		ret &= ~(1 << offset);
+
+	moxtet_device_write(chip->dev, ret);
+}
+
+static int moxtet_sfp_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return offset < MOXTET_SFP_IN_GPIOS;
+}
+
+static int moxtet_sfp_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	if (offset >= MOXTET_SFP_IN_GPIOS)
+		return -EINVAL;
+	return 0;
+}
+
+static int moxtet_sfp_direction_output(struct gpio_chip *gc,
+				       unsigned int offset, int val)
+{
+	if (offset < MOXTET_SFP_IN_GPIOS)
+		return -EINVAL;
+
+	moxtet_sfp_set_value(gc, offset, val);
+	return 0;
+}
+
+static int moxtet_sfp_probe(struct device *dev)
+{
+	struct moxtet_sfp_chip *chip;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = dev;
+	chip->gpio_chip.parent = dev;
+
+	dev_set_drvdata(dev, chip);
+
+	chip->gpiod_oe = devm_gpiod_get_optional(dev, "enable",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(chip->gpiod_oe))
+		return PTR_ERR(chip->gpiod_oe);
+
+	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
+
+	chip->gpio_chip.label = dev_name(dev);
+	chip->gpio_chip.get_direction = moxtet_sfp_get_direction;
+	chip->gpio_chip.direction_input = moxtet_sfp_direction_input;
+	chip->gpio_chip.direction_output = moxtet_sfp_direction_output;
+	chip->gpio_chip.get = moxtet_sfp_get_value;
+	chip->gpio_chip.set = moxtet_sfp_set_value;
+	chip->gpio_chip.base = -1;
+
+	chip->gpio_chip.ngpio = 5;
+
+	chip->gpio_chip.can_sleep = true;
+	chip->gpio_chip.owner = THIS_MODULE;
+
+	return gpiochip_add_data(&chip->gpio_chip, chip);
+}
+
+static int moxtet_sfp_remove(struct device *dev)
+{
+	struct moxtet_sfp_chip *chip = dev_get_drvdata(dev);
+
+	gpiod_set_value_cansleep(chip->gpiod_oe, 0);
+	gpiochip_remove(&chip->gpio_chip);
+
+	return 0;
+}
+
+static const struct of_device_id moxtet_sfp_dt_ids[] = {
+	{ .compatible = "cznic,moxtet-sfp" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, moxtet_sfp_dt_ids);
+
+static const enum turris_mox_module_id moxtet_sfp_id_table[] = {
+	TURRIS_MOX_MODULE_SFP,
+	0
+};
+
+static struct moxtet_driver moxtet_sfp_driver = {
+	.driver = {
+		.name		= "moxtet-sfp",
+		.of_match_table	= moxtet_sfp_dt_ids,
+		.probe		= moxtet_sfp_probe,
+		.remove		= moxtet_sfp_remove,
+	},
+	.id_table	= moxtet_sfp_id_table,
+};
+module_moxtet_driver(moxtet_sfp_driver);
+
+MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_DESCRIPTION("GPIO configuration of the SFP cage found on Turris Mox");
+MODULE_LICENSE("GPL v2");
-- 
2.16.4
