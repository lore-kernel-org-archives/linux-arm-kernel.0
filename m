From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:45 +0200
Subject: [PATCH v3 03/12] pinctrl: axp209: rename everything from gpio to pctl
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-4-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver used to do only GPIO features of the GPIOs in X-Powers
AXP20X. Now that we have migrated everything to the pinctrl subsystem
and added pinctrl features, rename everything related to pinctrl from
gpio to pctl to ease the understanding of differences between GPIO
and pinctrl features.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/pinctrl/pinctrl-axp209.c | 178 +++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 96ef0cc28762..3ddeba45feed 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -54,7 +54,7 @@ struct axp20x_pinctrl_function {
 	unsigned int	ngroups;
 };
 
-struct axp20x_gpio {
+struct axp20x_pctl {
 	struct gpio_chip	chip;
 	struct regmap		*regmap;
 	struct pinctrl_dev			*pctl_dev;
@@ -97,11 +97,11 @@ static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
 
 static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
+	struct axp20x_pctl *pctl = gpiochip_get_data(chip);
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read(gpio->regmap, AXP20X_GPIO20_SS, &val);
+	ret = regmap_read(pctl->regmap, AXP20X_GPIO20_SS, &val);
 	if (ret)
 		return ret;
 
@@ -110,7 +110,7 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
+	struct axp20x_pctl *pctl = gpiochip_get_data(chip);
 	unsigned int val;
 	int reg, ret;
 
@@ -118,7 +118,7 @@ static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	if (reg < 0)
 		return reg;
 
-	ret = regmap_read(gpio->regmap, reg, &val);
+	ret = regmap_read(pctl->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -148,14 +148,14 @@ static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
 static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
 			    int value)
 {
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
+	struct axp20x_pctl *pctl = gpiochip_get_data(chip);
 	int reg;
 
 	reg = axp20x_gpio_get_reg(offset);
 	if (reg < 0)
 		return;
 
-	regmap_update_bits(gpio->regmap, reg,
+	regmap_update_bits(pctl->regmap, reg,
 			   AXP20X_GPIO_FUNCTIONS,
 			   value ? AXP20X_GPIO_FUNCTION_OUT_HIGH :
 			   AXP20X_GPIO_FUNCTION_OUT_LOW);
@@ -164,30 +164,30 @@ static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
 static int axp20x_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset,
 			  u8 config)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	int reg;
 
 	reg = axp20x_gpio_get_reg(offset);
 	if (reg < 0)
 		return reg;
 
-	return regmap_update_bits(gpio->regmap, reg, AXP20X_GPIO_FUNCTIONS,
+	return regmap_update_bits(pctl->regmap, reg, AXP20X_GPIO_FUNCTIONS,
 				  config);
 }
 
 static int axp20x_pmx_func_cnt(struct pinctrl_dev *pctldev)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	return ARRAY_SIZE(gpio->funcs);
+	return ARRAY_SIZE(pctl->funcs);
 }
 
 static const char *axp20x_pmx_func_name(struct pinctrl_dev *pctldev,
 					unsigned int selector)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	return gpio->funcs[selector].name;
+	return pctl->funcs[selector].name;
 }
 
 static int axp20x_pmx_func_groups(struct pinctrl_dev *pctldev,
@@ -195,10 +195,10 @@ static int axp20x_pmx_func_groups(struct pinctrl_dev *pctldev,
 				  const char * const **groups,
 				  unsigned int *num_groups)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups = gpio->funcs[selector].groups;
-	*num_groups = gpio->funcs[selector].ngroups;
+	*groups = pctl->funcs[selector].groups;
+	*num_groups = pctl->funcs[selector].ngroups;
 
 	return 0;
 }
@@ -206,37 +206,37 @@ static int axp20x_pmx_func_groups(struct pinctrl_dev *pctldev,
 static int axp20x_pmx_set_mux(struct pinctrl_dev *pctldev,
 			      unsigned int function, unsigned int group)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	unsigned int mask;
 
 	/* Every pin supports GPIO_OUT and GPIO_IN functions */
 	if (function <= AXP20X_FUNC_GPIO_IN)
 		return axp20x_pmx_set(pctldev, group,
-				      gpio->funcs[function].muxval);
+				      pctl->funcs[function].muxval);
 
 	if (function == AXP20X_FUNC_LDO)
-		mask = gpio->desc->ldo_mask;
+		mask = pctl->desc->ldo_mask;
 	else
-		mask = gpio->desc->adc_mask;
+		mask = pctl->desc->adc_mask;
 
 	if (!(BIT(group) & mask))
 		return -EINVAL;
 
-	return axp20x_pmx_set(pctldev, group, gpio->funcs[function].muxval);
+	return axp20x_pmx_set(pctldev, group, pctl->funcs[function].muxval);
 }
 
 static int axp20x_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					 struct pinctrl_gpio_range *range,
 					 unsigned int offset, bool input)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
 	if (input)
 		return axp20x_pmx_set(pctldev, offset,
-				      gpio->funcs[AXP20X_FUNC_GPIO_IN].muxval);
+				      pctl->funcs[AXP20X_FUNC_GPIO_IN].muxval);
 
 	return axp20x_pmx_set(pctldev, offset,
-			      gpio->funcs[AXP20X_FUNC_GPIO_OUT].muxval);
+			      pctl->funcs[AXP20X_FUNC_GPIO_OUT].muxval);
 }
 
 static const struct pinmux_ops axp20x_pmx_ops = {
@@ -250,17 +250,17 @@ static const struct pinmux_ops axp20x_pmx_ops = {
 
 static int axp20x_groups_cnt(struct pinctrl_dev *pctldev)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	return gpio->desc->npins;
+	return pctl->desc->npins;
 }
 
 static int axp20x_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
 			     const unsigned int **pins, unsigned int *num_pins)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	*pins = (unsigned int *)&gpio->desc->pins[selector];
+	*pins = (unsigned int *)&pctl->desc->pins[selector];
 	*num_pins = 1;
 
 	return 0;
@@ -269,9 +269,9 @@ static int axp20x_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
 static const char *axp20x_group_name(struct pinctrl_dev *pctldev,
 				     unsigned int selector)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	return gpio->desc->pins[selector].name;
+	return pctl->desc->pins[selector].name;
 }
 
 static const struct pinctrl_ops axp20x_pctrl_ops = {
@@ -306,43 +306,43 @@ static void axp20x_funcs_groups_from_mask(struct device *dev, unsigned int mask,
 
 static void axp20x_build_funcs_groups(struct platform_device *pdev)
 {
-	struct axp20x_gpio *gpio = platform_get_drvdata(pdev);
+	struct axp20x_pctl *pctl = platform_get_drvdata(pdev);
 	int i, pin;
 
-	gpio->funcs[AXP20X_FUNC_GPIO_OUT].name = "gpio_out";
-	gpio->funcs[AXP20X_FUNC_GPIO_OUT].muxval = 0x0;
-	gpio->funcs[AXP20X_FUNC_GPIO_IN].name = "gpio_in";
-	gpio->funcs[AXP20X_FUNC_GPIO_IN].muxval = 0x2;
-	gpio->funcs[AXP20X_FUNC_LDO].name = "ldo";
-	gpio->funcs[AXP20X_FUNC_LDO].muxval = 0x3;
-	gpio->funcs[AXP20X_FUNC_ADC].name = "adc";
-	gpio->funcs[AXP20X_FUNC_ADC].muxval = 0x4;
+	pctl->funcs[AXP20X_FUNC_GPIO_OUT].name = "gpio_out";
+	pctl->funcs[AXP20X_FUNC_GPIO_OUT].muxval = 0x0;
+	pctl->funcs[AXP20X_FUNC_GPIO_IN].name = "gpio_in";
+	pctl->funcs[AXP20X_FUNC_GPIO_IN].muxval = 0x2;
+	pctl->funcs[AXP20X_FUNC_LDO].name = "ldo";
+	pctl->funcs[AXP20X_FUNC_LDO].muxval = 0x3;
+	pctl->funcs[AXP20X_FUNC_ADC].name = "adc";
+	pctl->funcs[AXP20X_FUNC_ADC].muxval = 0x4;
 
 	/* Every pin supports GPIO_OUT and GPIO_IN functions */
 	for (i = 0; i <= AXP20X_FUNC_GPIO_IN; i++) {
-		gpio->funcs[i].ngroups = gpio->desc->npins;
-		gpio->funcs[i].groups = devm_kzalloc(&pdev->dev,
-						     gpio->desc->npins * sizeof(const char *),
+		pctl->funcs[i].ngroups = pctl->desc->npins;
+		pctl->funcs[i].groups = devm_kzalloc(&pdev->dev,
+						     pctl->desc->npins * sizeof(const char *),
 						     GFP_KERNEL);
-		for (pin = 0; pin < gpio->desc->npins; pin++)
-			gpio->funcs[i].groups[pin] = gpio->desc->pins[pin].name;
+		for (pin = 0; pin < pctl->desc->npins; pin++)
+			pctl->funcs[i].groups[pin] = pctl->desc->pins[pin].name;
 	}
 
-	axp20x_funcs_groups_from_mask(&pdev->dev, gpio->desc->ldo_mask,
-				      gpio->desc->npins,
-				      &gpio->funcs[AXP20X_FUNC_LDO],
-				      gpio->desc->pins);
+	axp20x_funcs_groups_from_mask(&pdev->dev, pctl->desc->ldo_mask,
+				      pctl->desc->npins,
+				      &pctl->funcs[AXP20X_FUNC_LDO],
+				      pctl->desc->pins);
 
-	axp20x_funcs_groups_from_mask(&pdev->dev, gpio->desc->adc_mask,
-				      gpio->desc->npins,
-				      &gpio->funcs[AXP20X_FUNC_ADC],
-				      gpio->desc->pins);
+	axp20x_funcs_groups_from_mask(&pdev->dev, pctl->desc->adc_mask,
+				      pctl->desc->npins,
+				      &pctl->funcs[AXP20X_FUNC_ADC],
+				      pctl->desc->pins);
 }
 
-static int axp20x_gpio_probe(struct platform_device *pdev)
+static int axp20x_pctl_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
-	struct axp20x_gpio *gpio;
+	struct axp20x_pctl *pctl;
 	struct pinctrl_desc *pctrl_desc;
 	int ret;
 
@@ -354,31 +354,31 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
-	if (!gpio)
+	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
 		return -ENOMEM;
 
-	gpio->chip.base			= -1;
-	gpio->chip.can_sleep		= true;
-	gpio->chip.request		= gpiochip_generic_request;
-	gpio->chip.free			= gpiochip_generic_free;
-	gpio->chip.parent		= &pdev->dev;
-	gpio->chip.label		= dev_name(&pdev->dev);
-	gpio->chip.owner		= THIS_MODULE;
-	gpio->chip.get			= axp20x_gpio_get;
-	gpio->chip.get_direction	= axp20x_gpio_get_direction;
-	gpio->chip.set			= axp20x_gpio_set;
-	gpio->chip.direction_input	= axp20x_gpio_input;
-	gpio->chip.direction_output	= axp20x_gpio_output;
-	gpio->chip.ngpio		= 3;
+	pctl->chip.base			= -1;
+	pctl->chip.can_sleep		= true;
+	pctl->chip.request		= gpiochip_generic_request;
+	pctl->chip.free			= gpiochip_generic_free;
+	pctl->chip.parent		= &pdev->dev;
+	pctl->chip.label		= dev_name(&pdev->dev);
+	pctl->chip.owner		= THIS_MODULE;
+	pctl->chip.get			= axp20x_gpio_get;
+	pctl->chip.get_direction	= axp20x_gpio_get_direction;
+	pctl->chip.set			= axp20x_gpio_set;
+	pctl->chip.direction_input	= axp20x_gpio_input;
+	pctl->chip.direction_output	= axp20x_gpio_output;
+	pctl->chip.ngpio		= 3;
 
-	gpio->desc = &axp20x_data;
+	pctl->desc = &axp20x_data;
 
-	gpio->regmap = axp20x->regmap;
+	pctl->regmap = axp20x->regmap;
 
-	gpio->dev = &pdev->dev;
+	pctl->dev = &pdev->dev;
 
-	platform_set_drvdata(pdev, gpio);
+	platform_set_drvdata(pdev, pctl);
 
 	axp20x_build_funcs_groups(pdev);
 
@@ -388,27 +388,27 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
 
 	pctrl_desc->name = dev_name(&pdev->dev);
 	pctrl_desc->owner = THIS_MODULE;
-	pctrl_desc->pins = gpio->desc->pins;
-	pctrl_desc->npins = gpio->desc->npins;
+	pctrl_desc->pins = pctl->desc->pins;
+	pctrl_desc->npins = pctl->desc->npins;
 	pctrl_desc->pctlops = &axp20x_pctrl_ops;
 	pctrl_desc->pmxops = &axp20x_pmx_ops;
 
-	gpio->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, gpio);
-	if (IS_ERR(gpio->pctl_dev)) {
+	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
+	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
-		return PTR_ERR(gpio->pctl_dev);
+		return PTR_ERR(pctl->pctl_dev);
 	}
 
-	ret = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
+	ret = devm_gpiochip_add_data(&pdev->dev, &pctl->chip, pctl);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register GPIO chip\n");
 		return ret;
 	}
 
-	ret = gpiochip_add_pin_range(&gpio->chip, dev_name(&pdev->dev),
-				     gpio->desc->pins->number,
-				     gpio->desc->pins->number,
-				     gpio->desc->npins);
+	ret = gpiochip_add_pin_range(&pctl->chip, dev_name(&pdev->dev),
+				     pctl->desc->pins->number,
+				     pctl->desc->pins->number,
+				     pctl->desc->npins);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add pin range\n");
 		return ret;
@@ -419,21 +419,21 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id axp20x_gpio_match[] = {
+static const struct of_device_id axp20x_pctl_match[] = {
 	{ .compatible = "x-powers,axp209-gpio" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, axp20x_gpio_match);
+MODULE_DEVICE_TABLE(of, axp20x_pctl_match);
 
-static struct platform_driver axp20x_gpio_driver = {
-	.probe		= axp20x_gpio_probe,
+static struct platform_driver axp20x_pctl_driver = {
+	.probe		= axp20x_pctl_probe,
 	.driver = {
 		.name		= "axp20x-gpio",
-		.of_match_table	= axp20x_gpio_match,
+		.of_match_table	= axp20x_pctl_match,
 	},
 };
 
-module_platform_driver(axp20x_gpio_driver);
+module_platform_driver(axp20x_pctl_driver);
 
 MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
-- 
2.11.0
