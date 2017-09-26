From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:17:11 +0200
Subject: [PATCH v2 01/10] pinctrl: move gpio-axp209 to pinctrl
In-Reply-To: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <e193f8efe9092171ebeffb77ab77422179fd3cab.1506428208.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To prepare the driver for the upcoming pinctrl features, move the GPIO
driver AXP209 from GPIO to pinctrl subsystem.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt       |  30 +-
 Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt |  30 +-
 drivers/gpio/Kconfig                                         |   6 +-
 drivers/gpio/Makefile                                        |   1 +-
 drivers/gpio/gpio-axp209.c                                   | 188 +-------
 drivers/pinctrl/Kconfig                                      |   6 +-
 drivers/pinctrl/Makefile                                     |   1 +-
 drivers/pinctrl/pinctrl-axp209.c                             | 188 +++++++-
 8 files changed, 225 insertions(+), 225 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-axp209.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
 delete mode 100644 drivers/gpio/gpio-axp209.c
 create mode 100644 drivers/pinctrl/pinctrl-axp209.c

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
deleted file mode 100644
index a661130..0000000
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-AXP209 GPIO controller
-
-This driver follows the usual GPIO bindings found in
-Documentation/devicetree/bindings/gpio/gpio.txt
-
-Required properties:
-- compatible: Should be "x-powers,axp209-gpio"
-- #gpio-cells: Should be two. The first cell is the pin number and the
-  second is the GPIO flags.
-- gpio-controller: Marks the device node as a GPIO controller.
-
-This node must be a subnode of the axp20x PMIC, documented in
-Documentation/devicetree/bindings/mfd/axp20x.txt
-
-Example:
-
-axp209: pmic at 34 {
-	compatible = "x-powers,axp209";
-	reg = <0x34>;
-	interrupt-parent = <&nmi_intc>;
-	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-	interrupt-controller;
-	#interrupt-cells = <1>;
-
-	axp_gpio: gpio {
-		compatible = "x-powers,axp209-gpio";
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
new file mode 100644
index 0000000..a661130
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
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
index 3f80f16..ad88178 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -122,12 +122,6 @@ config GPIO_ATH79
 	  Select this option to enable GPIO driver for
 	  Atheros AR71XX/AR724X/AR913X SoC devices.
 
-config GPIO_AXP209
-	tristate "X-Powers AXP209 PMIC GPIO Support"
-	depends on MFD_AXP20X
-	help
-	  Say yes to enable GPIO support for the AXP209 PMIC
-
 config GPIO_BCM_KONA
 	bool "Broadcom Kona GPIO"
 	depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index aeb70e9..f63631a 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_GPIO_AMDPT)	+= gpio-amdpt.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
-obj-$(CONFIG_GPIO_AXP209)	+= gpio-axp209.o
 obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
diff --git a/drivers/gpio/gpio-axp209.c b/drivers/gpio/gpio-axp209.c
deleted file mode 100644
index 4a346b7..0000000
--- a/drivers/gpio/gpio-axp209.c
+++ /dev/null
@@ -1,188 +0,0 @@
-/*
- * AXP20x GPIO driver
- *
- * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under  the terms of the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the License, or (at your
- * option) any later version.
- */
-
-#include <linux/bitops.h>
-#include <linux/device.h>
-#include <linux/gpio/driver.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/mfd/axp20x.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/regmap.h>
-#include <linux/slab.h>
-
-#define AXP20X_GPIO_FUNCTIONS		0x7
-#define AXP20X_GPIO_FUNCTION_OUT_LOW	0
-#define AXP20X_GPIO_FUNCTION_OUT_HIGH	1
-#define AXP20X_GPIO_FUNCTION_INPUT	2
-
-struct axp20x_gpio {
-	struct gpio_chip	chip;
-	struct regmap		*regmap;
-};
-
-static int axp20x_gpio_get_reg(unsigned offset)
-{
-	switch (offset) {
-	case 0:
-		return AXP20X_GPIO0_CTRL;
-	case 1:
-		return AXP20X_GPIO1_CTRL;
-	case 2:
-		return AXP20X_GPIO2_CTRL;
-	}
-
-	return -EINVAL;
-}
-
-static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
-{
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
-	int reg;
-
-	reg = axp20x_gpio_get_reg(offset);
-	if (reg < 0)
-		return reg;
-
-	return regmap_update_bits(gpio->regmap, reg,
-				  AXP20X_GPIO_FUNCTIONS,
-				  AXP20X_GPIO_FUNCTION_INPUT);
-}
-
-static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(gpio->regmap, AXP20X_GPIO20_SS, &val);
-	if (ret)
-		return ret;
-
-	return !!(val & BIT(offset + 4));
-}
-
-static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
-{
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
-	unsigned int val;
-	int reg, ret;
-
-	reg = axp20x_gpio_get_reg(offset);
-	if (reg < 0)
-		return reg;
-
-	ret = regmap_read(gpio->regmap, reg, &val);
-	if (ret)
-		return ret;
-
-	/*
-	 * This shouldn't really happen if the pin is in use already,
-	 * or if it's not in use yet, it doesn't matter since we're
-	 * going to change the value soon anyway. Default to output.
-	 */
-	if ((val & AXP20X_GPIO_FUNCTIONS) > 2)
-		return 0;
-
-	/*
-	 * The GPIO directions are the three lowest values.
-	 * 2 is input, 0 and 1 are output
-	 */
-	return val & 2;
-}
-
-static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
-			      int value)
-{
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
-	int reg;
-
-	reg = axp20x_gpio_get_reg(offset);
-	if (reg < 0)
-		return reg;
-
-	return regmap_update_bits(gpio->regmap, reg,
-				  AXP20X_GPIO_FUNCTIONS,
-				  value ? AXP20X_GPIO_FUNCTION_OUT_HIGH
-				  : AXP20X_GPIO_FUNCTION_OUT_LOW);
-}
-
-static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
-			    int value)
-{
-	axp20x_gpio_output(chip, offset, value);
-}
-
-static int axp20x_gpio_probe(struct platform_device *pdev)
-{
-	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
-	struct axp20x_gpio *gpio;
-	int ret;
-
-	if (!of_device_is_available(pdev->dev.of_node))
-		return -ENODEV;
-
-	if (!axp20x) {
-		dev_err(&pdev->dev, "Parent drvdata not set\n");
-		return -EINVAL;
-	}
-
-	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
-	if (!gpio)
-		return -ENOMEM;
-
-	gpio->chip.base			= -1;
-	gpio->chip.can_sleep		= true;
-	gpio->chip.parent		= &pdev->dev;
-	gpio->chip.label		= dev_name(&pdev->dev);
-	gpio->chip.owner		= THIS_MODULE;
-	gpio->chip.get			= axp20x_gpio_get;
-	gpio->chip.get_direction	= axp20x_gpio_get_direction;
-	gpio->chip.set			= axp20x_gpio_set;
-	gpio->chip.direction_input	= axp20x_gpio_input;
-	gpio->chip.direction_output	= axp20x_gpio_output;
-	gpio->chip.ngpio		= 3;
-
-	gpio->regmap = axp20x->regmap;
-
-	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register GPIO chip\n");
-		return ret;
-	}
-
-	dev_info(&pdev->dev, "AXP209 GPIO driver loaded\n");
-
-	return 0;
-}
-
-static const struct of_device_id axp20x_gpio_match[] = {
-	{ .compatible = "x-powers,axp209-gpio" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, axp20x_gpio_match);
-
-static struct platform_driver axp20x_gpio_driver = {
-	.probe		= axp20x_gpio_probe,
-	.driver = {
-		.name		= "axp20x-gpio",
-		.of_match_table	= axp20x_gpio_match,
-	},
-};
-
-module_platform_driver(axp20x_gpio_driver);
-
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-MODULE_DESCRIPTION("AXP20x PMIC GPIO driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 1778cf4..b125a21 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -63,6 +63,12 @@ config PINCTRL_AS3722
 	  open drain configuration for the GPIO pins of AS3722 devices. It also
 	  supports the GPIO functionality through gpiolib.
 
+config PINCTRL_AXP209
+	tristate "X-Powers AXP209 PMIC pinctrl and GPIO Support"
+	depends on MFD_AXP20X
+	help
+	  Say yes to enable pinctrl and GPIO support for the AXP209 PMIC
+
 config PINCTRL_BF54x
 	def_bool y if BF54x
 	select PINCTRL_ADI2
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index c16e279..9f621e5 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_GENERIC_PINCONF)	+= pinconf-generic.o
 obj-$(CONFIG_PINCTRL_ADI2)	+= pinctrl-adi2.o
 obj-$(CONFIG_PINCTRL_ARTPEC6)	+= pinctrl-artpec6.o
 obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
+obj-$(CONFIG_PINCTRL_AXP209)	+= pinctrl-axp209.o
 obj-$(CONFIG_PINCTRL_BF54x)	+= pinctrl-adi2-bf54x.o
 obj-$(CONFIG_PINCTRL_BF60x)	+= pinctrl-adi2-bf60x.o
 obj-$(CONFIG_PINCTRL_AT91)	+= pinctrl-at91.o
diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
new file mode 100644
index 0000000..4a346b7
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -0,0 +1,188 @@
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
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
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
+	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
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
+	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(gpio->regmap, AXP20X_GPIO20_SS, &val);
+	if (ret)
+		return ret;
+
+	return !!(val & BIT(offset + 4));
+}
+
+static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
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
+	/*
+	 * This shouldn't really happen if the pin is in use already,
+	 * or if it's not in use yet, it doesn't matter since we're
+	 * going to change the value soon anyway. Default to output.
+	 */
+	if ((val & AXP20X_GPIO_FUNCTIONS) > 2)
+		return 0;
+
+	/*
+	 * The GPIO directions are the three lowest values.
+	 * 2 is input, 0 and 1 are output
+	 */
+	return val & 2;
+}
+
+static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
+			      int value)
+{
+	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
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
+	gpio->chip.parent		= &pdev->dev;
+	gpio->chip.label		= dev_name(&pdev->dev);
+	gpio->chip.owner		= THIS_MODULE;
+	gpio->chip.get			= axp20x_gpio_get;
+	gpio->chip.get_direction	= axp20x_gpio_get_direction;
+	gpio->chip.set			= axp20x_gpio_set;
+	gpio->chip.direction_input	= axp20x_gpio_input;
+	gpio->chip.direction_output	= axp20x_gpio_output;
+	gpio->chip.ngpio		= 3;
+
+	gpio->regmap = axp20x->regmap;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
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
git-series 0.9.1
