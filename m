From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:44 +0200
Subject: [PATCH v3 02/12] pinctrl: axp209: add pinctrl features
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-3-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The X-Powers AXP209 has 3 GPIOs. GPIO0/1 can each act either as a GPIO,
an ADC or a LDO regulator. GPIO2 can only act as a GPIO.

This adds the pinctrl features to the driver so GPIO0/1 can be used as
ADC or LDO regulator.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-axp209.txt |  28 +-
 drivers/pinctrl/pinctrl-axp209.c                   | 293 +++++++++++++++++++--
 2 files changed, 300 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
index a6611304dd3c..388c04492afd 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
@@ -1,4 +1,4 @@
-AXP209 GPIO controller
+AXP209 GPIO & pinctrl controller
 
 This driver follows the usual GPIO bindings found in
 Documentation/devicetree/bindings/gpio/gpio.txt
@@ -28,3 +28,29 @@ axp209: pmic at 34 {
 		#gpio-cells = <2>;
 	};
 };
+
+The GPIOs can be muxed to other functions and therefore, must be a subnode of
+axp_gpio.
+
+Example:
+
+&axp_gpio {
+	gpio0_adc: gpio0_adc {
+		pins = "GPIO0";
+		function = "adc";
+	};
+};
+
+&example_node {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_adc>;
+};
+
+GPIOs and their functions
+-------------------------
+
+GPIO	|	Functions
+------------------------
+GPIO0	|	gpio_in, gpio_out, ldo, adc
+GPIO1	|	gpio_in, gpio_out, ldo, adc
+GPIO2	|	gpio_in, gpio_out
diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 4a346b7b4172..96ef0cc28762 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -1,7 +1,8 @@
 /*
- * AXP20x GPIO driver
+ * AXP20x pinctrl and GPIO driver
  *
  * Copyright (C) 2016 Maxime Ripard <maxime.ripard@free-electrons.com>
+ * Copyright (C) 2017 Quentin Schulz <quentin.schulz@free-electrons.com>
  *
  * This program is free software; you can redistribute it and/or modify it
  * under  the terms of the GNU General  Public License as published by the
@@ -22,14 +23,57 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf-generic.h>
+
 #define AXP20X_GPIO_FUNCTIONS		0x7
 #define AXP20X_GPIO_FUNCTION_OUT_LOW	0
 #define AXP20X_GPIO_FUNCTION_OUT_HIGH	1
 #define AXP20X_GPIO_FUNCTION_INPUT	2
 
+#define AXP20X_FUNC_GPIO_OUT		0
+#define AXP20X_FUNC_GPIO_IN		1
+#define AXP20X_FUNC_LDO			2
+#define AXP20X_FUNC_ADC			3
+#define AXP20X_FUNCS_NB			4
+
+struct axp20x_pctrl_desc {
+	const struct pinctrl_pin_desc	*pins;
+	unsigned int			npins;
+	/* Stores the pins supporting LDO function. Bit offset is pin number. */
+	unsigned int			ldo_mask;
+	/* Stores the pins supporting ADC function. Bit offset is pin number. */
+	unsigned int			adc_mask;
+};
+
+struct axp20x_pinctrl_function {
+	const char	*name;
+	unsigned int	muxval;
+	const char	**groups;
+	unsigned int	ngroups;
+};
+
 struct axp20x_gpio {
 	struct gpio_chip	chip;
 	struct regmap		*regmap;
+	struct pinctrl_dev			*pctl_dev;
+	struct device				*dev;
+	const struct axp20x_pctrl_desc		*desc;
+	struct axp20x_pinctrl_function		funcs[AXP20X_FUNCS_NB];
+};
+
+static const struct pinctrl_pin_desc axp209_pins[] = {
+	PINCTRL_PIN(0, "GPIO0"),
+	PINCTRL_PIN(1, "GPIO1"),
+	PINCTRL_PIN(2, "GPIO2"),
+};
+
+static const struct axp20x_pctrl_desc axp20x_data = {
+	.pins	= axp209_pins,
+	.npins	= ARRAY_SIZE(axp209_pins),
+	.ldo_mask = BIT(0) | BIT(1),
+	.adc_mask = BIT(0) | BIT(1),
 };
 
 static int axp20x_gpio_get_reg(unsigned offset)
@@ -48,16 +92,7 @@ static int axp20x_gpio_get_reg(unsigned offset)
 
 static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
 {
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
+	return pinctrl_gpio_direction_input(chip->base + offset);
 }
 
 static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -105,29 +140,210 @@ static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
 			      int value)
 {
+	chip->set(chip, offset, value);
+
+	return 0;
+}
+
+static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
+			    int value)
+{
 	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
 	int reg;
 
 	reg = axp20x_gpio_get_reg(offset);
 	if (reg < 0)
+		return;
+
+	regmap_update_bits(gpio->regmap, reg,
+			   AXP20X_GPIO_FUNCTIONS,
+			   value ? AXP20X_GPIO_FUNCTION_OUT_HIGH :
+			   AXP20X_GPIO_FUNCTION_OUT_LOW);
+}
+
+static int axp20x_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset,
+			  u8 config)
+{
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	int reg;
+
+	reg = axp20x_gpio_get_reg(offset);
+	if (reg < 0)
 		return reg;
 
-	return regmap_update_bits(gpio->regmap, reg,
-				  AXP20X_GPIO_FUNCTIONS,
-				  value ? AXP20X_GPIO_FUNCTION_OUT_HIGH
-				  : AXP20X_GPIO_FUNCTION_OUT_LOW);
+	return regmap_update_bits(gpio->regmap, reg, AXP20X_GPIO_FUNCTIONS,
+				  config);
 }
 
-static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
-			    int value)
+static int axp20x_pmx_func_cnt(struct pinctrl_dev *pctldev)
+{
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+
+	return ARRAY_SIZE(gpio->funcs);
+}
+
+static const char *axp20x_pmx_func_name(struct pinctrl_dev *pctldev,
+					unsigned int selector)
 {
-	axp20x_gpio_output(chip, offset, value);
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+
+	return gpio->funcs[selector].name;
+}
+
+static int axp20x_pmx_func_groups(struct pinctrl_dev *pctldev,
+				  unsigned int selector,
+				  const char * const **groups,
+				  unsigned int *num_groups)
+{
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = gpio->funcs[selector].groups;
+	*num_groups = gpio->funcs[selector].ngroups;
+
+	return 0;
+}
+
+static int axp20x_pmx_set_mux(struct pinctrl_dev *pctldev,
+			      unsigned int function, unsigned int group)
+{
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int mask;
+
+	/* Every pin supports GPIO_OUT and GPIO_IN functions */
+	if (function <= AXP20X_FUNC_GPIO_IN)
+		return axp20x_pmx_set(pctldev, group,
+				      gpio->funcs[function].muxval);
+
+	if (function == AXP20X_FUNC_LDO)
+		mask = gpio->desc->ldo_mask;
+	else
+		mask = gpio->desc->adc_mask;
+
+	if (!(BIT(group) & mask))
+		return -EINVAL;
+
+	return axp20x_pmx_set(pctldev, group, gpio->funcs[function].muxval);
+}
+
+static int axp20x_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
+					 struct pinctrl_gpio_range *range,
+					 unsigned int offset, bool input)
+{
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+
+	if (input)
+		return axp20x_pmx_set(pctldev, offset,
+				      gpio->funcs[AXP20X_FUNC_GPIO_IN].muxval);
+
+	return axp20x_pmx_set(pctldev, offset,
+			      gpio->funcs[AXP20X_FUNC_GPIO_OUT].muxval);
+}
+
+static const struct pinmux_ops axp20x_pmx_ops = {
+	.get_functions_count	= axp20x_pmx_func_cnt,
+	.get_function_name	= axp20x_pmx_func_name,
+	.get_function_groups	= axp20x_pmx_func_groups,
+	.set_mux		= axp20x_pmx_set_mux,
+	.gpio_set_direction	= axp20x_pmx_gpio_set_direction,
+	.strict			= true,
+};
+
+static int axp20x_groups_cnt(struct pinctrl_dev *pctldev)
+{
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+
+	return gpio->desc->npins;
+}
+
+static int axp20x_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
+			     const unsigned int **pins, unsigned int *num_pins)
+{
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = (unsigned int *)&gpio->desc->pins[selector];
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const char *axp20x_group_name(struct pinctrl_dev *pctldev,
+				     unsigned int selector)
+{
+	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+
+	return gpio->desc->pins[selector].name;
+}
+
+static const struct pinctrl_ops axp20x_pctrl_ops = {
+	.dt_node_to_map		= pinconf_generic_dt_node_to_map_group,
+	.dt_free_map		= pinconf_generic_dt_free_map,
+	.get_groups_count	= axp20x_groups_cnt,
+	.get_group_name		= axp20x_group_name,
+	.get_group_pins		= axp20x_group_pins,
+};
+
+static void axp20x_funcs_groups_from_mask(struct device *dev, unsigned int mask,
+					  unsigned int mask_len,
+					  struct axp20x_pinctrl_function *func,
+					  const struct pinctrl_pin_desc *pins)
+{
+	unsigned long int mask_cpy = mask;
+	const char **group;
+	unsigned int ngroups = hweight8(mask);
+	int bit;
+
+	func->ngroups = ngroups;
+	if (func->ngroups > 0) {
+		func->groups = devm_kzalloc(dev, ngroups * sizeof(const char *),
+					    GFP_KERNEL);
+		group = func->groups;
+		for_each_set_bit(bit, &mask_cpy, mask_len) {
+			*group = pins[bit].name;
+			group++;
+		}
+	}
+}
+
+static void axp20x_build_funcs_groups(struct platform_device *pdev)
+{
+	struct axp20x_gpio *gpio = platform_get_drvdata(pdev);
+	int i, pin;
+
+	gpio->funcs[AXP20X_FUNC_GPIO_OUT].name = "gpio_out";
+	gpio->funcs[AXP20X_FUNC_GPIO_OUT].muxval = 0x0;
+	gpio->funcs[AXP20X_FUNC_GPIO_IN].name = "gpio_in";
+	gpio->funcs[AXP20X_FUNC_GPIO_IN].muxval = 0x2;
+	gpio->funcs[AXP20X_FUNC_LDO].name = "ldo";
+	gpio->funcs[AXP20X_FUNC_LDO].muxval = 0x3;
+	gpio->funcs[AXP20X_FUNC_ADC].name = "adc";
+	gpio->funcs[AXP20X_FUNC_ADC].muxval = 0x4;
+
+	/* Every pin supports GPIO_OUT and GPIO_IN functions */
+	for (i = 0; i <= AXP20X_FUNC_GPIO_IN; i++) {
+		gpio->funcs[i].ngroups = gpio->desc->npins;
+		gpio->funcs[i].groups = devm_kzalloc(&pdev->dev,
+						     gpio->desc->npins * sizeof(const char *),
+						     GFP_KERNEL);
+		for (pin = 0; pin < gpio->desc->npins; pin++)
+			gpio->funcs[i].groups[pin] = gpio->desc->pins[pin].name;
+	}
+
+	axp20x_funcs_groups_from_mask(&pdev->dev, gpio->desc->ldo_mask,
+				      gpio->desc->npins,
+				      &gpio->funcs[AXP20X_FUNC_LDO],
+				      gpio->desc->pins);
+
+	axp20x_funcs_groups_from_mask(&pdev->dev, gpio->desc->adc_mask,
+				      gpio->desc->npins,
+				      &gpio->funcs[AXP20X_FUNC_ADC],
+				      gpio->desc->pins);
 }
 
 static int axp20x_gpio_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct axp20x_gpio *gpio;
+	struct pinctrl_desc *pctrl_desc;
 	int ret;
 
 	if (!of_device_is_available(pdev->dev.of_node))
@@ -144,6 +360,8 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
 
 	gpio->chip.base			= -1;
 	gpio->chip.can_sleep		= true;
+	gpio->chip.request		= gpiochip_generic_request;
+	gpio->chip.free			= gpiochip_generic_free;
 	gpio->chip.parent		= &pdev->dev;
 	gpio->chip.label		= dev_name(&pdev->dev);
 	gpio->chip.owner		= THIS_MODULE;
@@ -154,15 +372,49 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
 	gpio->chip.direction_output	= axp20x_gpio_output;
 	gpio->chip.ngpio		= 3;
 
+	gpio->desc = &axp20x_data;
+
 	gpio->regmap = axp20x->regmap;
 
+	gpio->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, gpio);
+
+	axp20x_build_funcs_groups(pdev);
+
+	pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
+	if (!pctrl_desc)
+		return -ENOMEM;
+
+	pctrl_desc->name = dev_name(&pdev->dev);
+	pctrl_desc->owner = THIS_MODULE;
+	pctrl_desc->pins = gpio->desc->pins;
+	pctrl_desc->npins = gpio->desc->npins;
+	pctrl_desc->pctlops = &axp20x_pctrl_ops;
+	pctrl_desc->pmxops = &axp20x_pmx_ops;
+
+	gpio->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, gpio);
+	if (IS_ERR(gpio->pctl_dev)) {
+		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
+		return PTR_ERR(gpio->pctl_dev);
+	}
+
 	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register GPIO chip\n");
 		return ret;
 	}
 
-	dev_info(&pdev->dev, "AXP209 GPIO driver loaded\n");
+	ret = gpiochip_add_pin_range(&gpio->chip, dev_name(&pdev->dev),
+				     gpio->desc->pins->number,
+				     gpio->desc->pins->number,
+				     gpio->desc->npins);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add pin range\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "AXP209 pinctrl and GPIO driver loaded\n");
 
 	return 0;
 }
@@ -184,5 +436,6 @@ static struct platform_driver axp20x_gpio_driver = {
 module_platform_driver(axp20x_gpio_driver);
 
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
-MODULE_DESCRIPTION("AXP20x PMIC GPIO driver");
+MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
+MODULE_DESCRIPTION("AXP20x PMIC pinctrl and GPIO driver");
 MODULE_LICENSE("GPL");
-- 
2.11.0
