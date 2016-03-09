From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 Mar 2016 11:50:11 +0100
Subject: [PATCH 1/4] gpio: Add AXP209 GPIO driver
In-Reply-To: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1457520614-32239-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP209 PMIC has a bunch of GPIOs accessible, that are usually used to
control LEDs or backlight.

Add a driver for them

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/gpio/gpio-axp209.txt       |  30 ++++
 drivers/gpio/Kconfig                               |   6 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-axp209.c                         | 166 +++++++++++++++++++++
 4 files changed, 203 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-axp209.txt
 create mode 100644 drivers/gpio/gpio-axp209.c

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
new file mode 100644
index 000000000000..a6611304dd3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -0,0 +1,30 @@
+AXP209 GPIO controller
+
+This driver follows the usual GPIO bindings found in
+Documentation/devicetree/bindings/gpio/gpio.txt
+
+Required properties:
+- compatible: Should be "x-powers,axp209-gpio"
+- #gpio-cells: Should be two. The first cell is the pin number and the
+  second is the GPIO flags.
+- gpio-controller: Marks the device node as a GPIO controller.
+
+This node must be a subnode of the axp20x PMIC, documented in
+Documentation/devicetree/bindings/mfd/axp20x.txt
+
+Example:
+
+axp209: pmic at 34 {
+	compatible = "x-powers,axp209";
+	reg = <0x34>;
+	interrupt-parent = <&nmi_intc>;
+	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp209-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1118fef45a86..cd5ab93ac197 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -136,6 +136,12 @@ config GPIO_ATH79
 	  Select this option to enable GPIO driver for
 	  Atheros AR71XX/AR724X/AR913X SoC devices.
 
+config GPIO_AXP209
+	tristate "X-Powers AXP209 PMIC GPIO Support"
+	depends on MFD_AXP20X
+	help
+	  Say yes to enable GPIO support for the AXP209 PMIC
+
 config GPIO_BCM_KONA
 	bool "Broadcom Kona GPIO"
 	depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 6f969df1431a..e9e7fbe80ab7 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
 obj-$(CONFIG_GPIO_AMDPT)	+= gpio-amdpt.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
+obj-$(CONFIG_GPIO_AXP209)	+= gpio-axp209.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
diff --git a/drivers/gpio/gpio-axp209.c b/drivers/gpio/gpio-axp209.c
new file mode 100644
index 000000000000..822f39faaadf
--- /dev/null
+++ b/drivers/gpio/gpio-axp209.c
@@ -0,0 +1,166 @@
+/*
+ * AXP20x GPIO driver
+ *
+ * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under  the terms of the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mfd/axp20x.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define AXP20X_GPIO_FUNCTIONS		0x7
+#define AXP20X_GPIO_FUNCTION_OUT_LOW	0
+#define AXP20X_GPIO_FUNCTION_OUT_HIGH	1
+#define AXP20X_GPIO_FUNCTION_INPUT	2
+
+struct axp20x_gpio {
+	struct gpio_chip	chip;
+	struct regmap		*regmap;
+};
+
+struct axp20x_gpio *to_axp20x_gpio(struct gpio_chip *chip)
+{
+	return container_of(chip, struct axp20x_gpio, chip);
+}
+
+static int axp20x_gpio_get_reg(unsigned offset)
+{
+	switch (offset) {
+	case 0:
+		return AXP20X_GPIO0_CTRL;
+	case 1:
+		return AXP20X_GPIO1_CTRL;
+	case 2:
+		return AXP20X_GPIO2_CTRL;
+	}
+
+	return -EINVAL;
+}
+
+static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct axp20x_gpio *gpio = to_axp20x_gpio(chip);
+	int reg;
+
+	reg = axp20x_gpio_get_reg(offset);
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(gpio->regmap, reg,
+				  AXP20X_GPIO_FUNCTIONS,
+				  AXP20X_GPIO_FUNCTION_INPUT);
+}
+
+static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct axp20x_gpio *gpio = to_axp20x_gpio(chip);
+	unsigned int val;
+	int reg, ret;
+
+	reg = axp20x_gpio_get_reg(offset);
+	if (reg < 0)
+		return reg;
+
+	ret = regmap_read(gpio->regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	return val & (1 << (offset + 4));
+}
+
+static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
+			      int value)
+{
+	struct axp20x_gpio *gpio = to_axp20x_gpio(chip);
+	int reg;
+
+	reg = axp20x_gpio_get_reg(offset);
+	if (reg < 0)
+		return reg;
+
+	return regmap_update_bits(gpio->regmap, reg,
+				  AXP20X_GPIO_FUNCTIONS,
+				  value ? AXP20X_GPIO_FUNCTION_OUT_HIGH
+				  : AXP20X_GPIO_FUNCTION_OUT_LOW);
+}
+
+static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
+			    int value)
+{
+	axp20x_gpio_output(chip, offset, value);
+}
+
+static int axp20x_gpio_probe(struct platform_device *pdev)
+{
+	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
+	struct axp20x_gpio *gpio;
+	int ret;
+
+	if (!of_device_is_available(pdev->dev.of_node))
+		return -ENODEV;
+
+	if (!axp20x) {
+		dev_err(&pdev->dev, "Parent drvdata not set\n");
+		return -EINVAL;
+	}
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	gpio->chip.base			= -1;
+	gpio->chip.can_sleep		= true;
+	gpio->chip.dev			= &pdev->dev;
+	gpio->chip.label		= dev_name(&pdev->dev);
+	gpio->chip.owner		= THIS_MODULE;
+	gpio->chip.get			= axp20x_gpio_get;
+	gpio->chip.set			= axp20x_gpio_set;
+	gpio->chip.direction_input	= axp20x_gpio_input;
+	gpio->chip.direction_output	= axp20x_gpio_output;
+	gpio->chip.ngpio		= 3;
+
+	gpio->regmap = axp20x->regmap;
+
+	ret = gpiochip_add(&gpio->chip);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register GPIO chip\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "AXP209 GPIO driver loaded\n");
+
+	return 0;
+}
+
+static const struct of_device_id axp20x_gpio_match[] = {
+	{ .compatible = "x-powers,axp209-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axp20x_gpio_match);
+
+static struct platform_driver axp20x_gpio_driver = {
+	.probe		= axp20x_gpio_probe,
+	.driver = {
+		.name		= "axp20x-gpio",
+		.of_match_table	= axp20x_gpio_match,
+	},
+};
+
+module_platform_driver(axp20x_gpio_driver);
+
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
+MODULE_DESCRIPTION("AXP20x PMIC GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.7.2
