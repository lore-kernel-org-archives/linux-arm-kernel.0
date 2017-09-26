From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:17:14 +0200
Subject: [PATCH v2 04/10] pinctrl: axp209: rename everything from gpio to pctl
In-Reply-To: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <b4b642e7134a9031a73204c56f1e8515d12e9d65.1506428208.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver used to do only GPIO features of the GPIOs in X-Powers
AXP20X. Now that we have migrated everything to the pinctrl subsystem
and added pinctrl features, rename everything related to pinctrl from
gpio to pctl to ease the understanding of differences between GPIO
and pinctrl features.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/pinctrl/pinctrl-axp209.c | 198 ++++++++++++++++----------------
 1 file changed, 99 insertions(+), 99 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 4bbcba2..4be1aca 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -79,7 +79,7 @@ struct axp20x_pinctrl_function {
 	unsigned int	ngroups;
 };
 
-struct axp20x_gpio {
+struct axp20x_pctl {
 	struct gpio_chip	chip;
 	struct regmap		*regmap;
 	struct pinctrl_dev			*pctl_dev;
@@ -119,11 +119,11 @@ static int axp20x_gpio_input(struct gpio_chip *chip, unsigned offset)
 
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
 
@@ -132,12 +132,12 @@ static int axp20x_gpio_get(struct gpio_chip *chip, unsigned offset)
 
 static int axp20x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
-	int reg = (int)gpio->desc->pins[offset].pin.drv_data;
+	struct axp20x_pctl *pctl = gpiochip_get_data(chip);
+	int reg = (int)pctl->desc->pins[offset].pin.drv_data;
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read(gpio->regmap, reg, &val);
+	ret = regmap_read(pctl->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -167,10 +167,10 @@ static int axp20x_gpio_output(struct gpio_chip *chip, unsigned offset,
 static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
 			    int value)
 {
-	struct axp20x_gpio *gpio = gpiochip_get_data(chip);
-	int reg = (int)gpio->desc->pins[offset].pin.drv_data;
+	struct axp20x_pctl *pctl = gpiochip_get_data(chip);
+	int reg = (int)pctl->desc->pins[offset].pin.drv_data;
 
-	regmap_update_bits(gpio->regmap, reg,
+	regmap_update_bits(pctl->regmap, reg,
 			   AXP20X_GPIO_FUNCTIONS,
 			   value ? AXP20X_GPIO_FUNCTION_OUT_HIGH :
 			   AXP20X_GPIO_FUNCTION_OUT_LOW);
@@ -179,26 +179,26 @@ static void axp20x_gpio_set(struct gpio_chip *chip, unsigned offset,
 static int axp20x_pmx_set(struct pinctrl_dev *pctldev, unsigned int offset,
 			  u8 config)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
-	int reg = (int)gpio->desc->pins[offset].pin.drv_data;
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	int reg = (int)pctl->desc->pins[offset].pin.drv_data;
 
-	return regmap_update_bits(gpio->regmap, reg, AXP20X_GPIO_FUNCTIONS,
+	return regmap_update_bits(pctl->regmap, reg, AXP20X_GPIO_FUNCTIONS,
 				  config);
 }
 
 static int axp20x_pmx_func_cnt(struct pinctrl_dev *pctldev)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	return gpio->nfunctions;
+	return pctl->nfunctions;
 }
 
 static const char *axp20x_pmx_func_name(struct pinctrl_dev *pctldev,
 					unsigned int selector)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	return gpio->functions[selector].name;
+	return pctl->functions[selector].name;
 }
 
 static int axp20x_pmx_func_groups(struct pinctrl_dev *pctldev,
@@ -206,24 +206,24 @@ static int axp20x_pmx_func_groups(struct pinctrl_dev *pctldev,
 				  const char * const **groups,
 				  unsigned int *num_groups)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	*groups = gpio->functions[selector].groups;
-	*num_groups = gpio->functions[selector].ngroups;
+	*groups = pctl->functions[selector].groups;
+	*num_groups = pctl->functions[selector].ngroups;
 
 	return 0;
 }
 
 static struct axp20x_desc_function *
-axp20x_pinctrl_desc_find_func_by_name(struct axp20x_gpio *gpio,
+axp20x_pinctrl_desc_find_func_by_name(struct axp20x_pctl *pctl,
 				      const char *group, const char *func)
 {
 	const struct axp20x_desc_pin *pin;
 	struct axp20x_desc_function *desc_func;
 	int i;
 
-	for (i = 0; i < gpio->desc->npins; i++) {
-		pin = &gpio->desc->pins[i];
+	for (i = 0; i < pctl->desc->npins; i++) {
+		pin = &pctl->desc->pins[i];
 
 		if (!strcmp(pin->pin.name, group)) {
 			desc_func = pin->functions;
@@ -250,11 +250,11 @@ axp20x_pinctrl_desc_find_func_by_name(struct axp20x_gpio *gpio,
 static int axp20x_pmx_set_mux(struct pinctrl_dev *pctldev,
 			      unsigned int function, unsigned int group)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
-	struct axp20x_pinctrl_group *g = gpio->groups + group;
-	struct axp20x_pinctrl_function *func = gpio->functions + function;
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pinctrl_group *g = pctl->groups + group;
+	struct axp20x_pinctrl_function *func = pctl->functions + function;
 	struct axp20x_desc_function *desc_func =
-		axp20x_pinctrl_desc_find_func_by_name(gpio, g->name,
+		axp20x_pinctrl_desc_find_func_by_name(pctl, g->name,
 						      func->name);
 	if (!desc_func)
 		return -EINVAL;
@@ -263,15 +263,15 @@ static int axp20x_pmx_set_mux(struct pinctrl_dev *pctldev,
 }
 
 static struct axp20x_desc_function *
-axp20x_pctl_desc_find_func_by_pin(struct axp20x_gpio *gpio, unsigned int offset,
+axp20x_pctl_desc_find_func_by_pin(struct axp20x_pctl *pctl, unsigned int offset,
 				  const char *func)
 {
 	const struct axp20x_desc_pin *pin;
 	struct axp20x_desc_function *desc_func;
 	int i;
 
-	for (i = 0; i < gpio->desc->npins; i++) {
-		pin = &gpio->desc->pins[i];
+	for (i = 0; i < pctl->desc->npins; i++) {
+		pin = &pctl->desc->pins[i];
 
 		if (pin->pin.number == offset) {
 			desc_func = pin->functions;
@@ -292,7 +292,7 @@ static int axp20x_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 					 struct pinctrl_gpio_range *range,
 					 unsigned int offset, bool input)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 	struct axp20x_desc_function *desc_func;
 	const char *func;
 
@@ -301,7 +301,7 @@ static int axp20x_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 	else
 		func = "gpio_out";
 
-	desc_func = axp20x_pctl_desc_find_func_by_pin(gpio, offset, func);
+	desc_func = axp20x_pctl_desc_find_func_by_pin(pctl, offset, func);
 	if (!desc_func)
 		return -EINVAL;
 
@@ -319,16 +319,16 @@ static const struct pinmux_ops axp20x_pmx_ops = {
 
 static int axp20x_groups_cnt(struct pinctrl_dev *pctldev)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	return gpio->ngroups;
+	return pctl->ngroups;
 }
 
 static int axp20x_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
 			     const unsigned int **pins, unsigned int *num_pins)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
-	struct axp20x_pinctrl_group *g = gpio->groups + selector;
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pinctrl_group *g = pctl->groups + selector;
 
 	*pins = (unsigned int *)&g->pin;
 	*num_pins = 1;
@@ -339,9 +339,9 @@ static int axp20x_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
 static const char *axp20x_group_name(struct pinctrl_dev *pctldev,
 				     unsigned int selector)
 {
-	struct axp20x_gpio *gpio = pinctrl_dev_get_drvdata(pctldev);
+	struct axp20x_pctl *pctl = pinctrl_dev_get_drvdata(pctldev);
 
-	return gpio->groups[selector].name;
+	return pctl->groups[selector].name;
 }
 
 static const struct pinctrl_ops axp20x_pctrl_ops = {
@@ -353,9 +353,9 @@ static const struct pinctrl_ops axp20x_pctrl_ops = {
 };
 
 static struct axp20x_pinctrl_function *
-axp20x_pinctrl_function_by_name(struct axp20x_gpio *gpio, const char *name)
+axp20x_pinctrl_function_by_name(struct axp20x_pctl *pctl, const char *name)
 {
-	struct axp20x_pinctrl_function *func = gpio->functions;
+	struct axp20x_pinctrl_function *func = pctl->functions;
 
 	while (func->name) {
 		if (!strcmp(func->name, name))
@@ -366,10 +366,10 @@ axp20x_pinctrl_function_by_name(struct axp20x_gpio *gpio, const char *name)
 	return NULL;
 }
 
-static int axp20x_pinctrl_add_function(struct axp20x_gpio *gpio,
+static int axp20x_pinctrl_add_function(struct axp20x_pctl *pctl,
 				       const char *name)
 {
-	struct axp20x_pinctrl_function *func = gpio->functions;
+	struct axp20x_pinctrl_function *func = pctl->functions;
 
 	while (func->name) {
 		if (!strcmp(func->name, name)) {
@@ -383,7 +383,7 @@ static int axp20x_pinctrl_add_function(struct axp20x_gpio *gpio,
 	func->name = name;
 	func->ngroups = 1;
 
-	gpio->nfunctions++;
+	pctl->nfunctions++;
 
 	return 0;
 }
@@ -391,13 +391,13 @@ static int axp20x_pinctrl_add_function(struct axp20x_gpio *gpio,
 static int axp20x_attach_group_function(struct platform_device *pdev,
 					const struct axp20x_desc_pin *pin)
 {
-	struct axp20x_gpio *gpio = platform_get_drvdata(pdev);
+	struct axp20x_pctl *pctl = platform_get_drvdata(pdev);
 	struct axp20x_desc_function *desc_func = pin->functions;
 	struct axp20x_pinctrl_function *func;
 	const char **func_grp;
 
 	while (desc_func->name) {
-		func = axp20x_pinctrl_function_by_name(gpio, desc_func->name);
+		func = axp20x_pinctrl_function_by_name(pctl, desc_func->name);
 		if (!func)
 			return -EINVAL;
 
@@ -422,48 +422,48 @@ static int axp20x_attach_group_function(struct platform_device *pdev,
 
 static int axp20x_build_state(struct platform_device *pdev)
 {
-	struct axp20x_gpio *gpio = platform_get_drvdata(pdev);
-	unsigned int npins = gpio->desc->npins;
+	struct axp20x_pctl *pctl = platform_get_drvdata(pdev);
+	unsigned int npins = pctl->desc->npins;
 	const struct axp20x_desc_pin *pin;
 	struct axp20x_desc_function *func;
 	int i, ret;
 
-	gpio->ngroups = npins;
-	gpio->groups = devm_kzalloc(&pdev->dev,
-				    gpio->ngroups * sizeof(*gpio->groups),
+	pctl->ngroups = npins;
+	pctl->groups = devm_kzalloc(&pdev->dev,
+				    pctl->ngroups * sizeof(*pctl->groups),
 				    GFP_KERNEL);
-	if (!gpio->groups)
+	if (!pctl->groups)
 		return -ENOMEM;
 
 	for (i = 0; i < npins; i++) {
-		gpio->groups[i].name = gpio->desc->pins[i].pin.name;
-		gpio->groups[i].pin = gpio->desc->pins[i].pin.number;
+		pctl->groups[i].name = pctl->desc->pins[i].pin.name;
+		pctl->groups[i].pin = pctl->desc->pins[i].pin.number;
 	}
 
 	/* We assume 4 functions per pin should be enough as a default max */
-	gpio->functions = devm_kzalloc(&pdev->dev,
-				       npins * 4 * sizeof(*gpio->functions),
+	pctl->functions = devm_kzalloc(&pdev->dev,
+				       npins * 4 * sizeof(*pctl->functions),
 				       GFP_KERNEL);
-	if (!gpio->functions)
+	if (!pctl->functions)
 		return -ENOMEM;
 
 	/* Create a list of uniquely named functions */
 	for (i = 0; i < npins; i++) {
-		pin = &gpio->desc->pins[i];
+		pin = &pctl->desc->pins[i];
 		func = pin->functions;
 
 		while (func->name) {
-			axp20x_pinctrl_add_function(gpio, func->name);
+			axp20x_pinctrl_add_function(pctl, func->name);
 			func++;
 		}
 	}
 
-	gpio->functions = krealloc(gpio->functions,
-				   gpio->nfunctions * sizeof(*gpio->functions),
+	pctl->functions = krealloc(pctl->functions,
+				   pctl->nfunctions * sizeof(*pctl->functions),
 				   GFP_KERNEL);
 
 	for (i = 0; i < npins; i++) {
-		pin = &gpio->desc->pins[i];
+		pin = &pctl->desc->pins[i];
 		ret = axp20x_attach_group_function(pdev, pin);
 		if (ret)
 			return ret;
@@ -472,10 +472,10 @@ static int axp20x_build_state(struct platform_device *pdev)
 	return 0;
 }
 
-static int axp20x_gpio_probe(struct platform_device *pdev)
+static int axp20x_pctl_probe(struct platform_device *pdev)
 {
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
-	struct axp20x_gpio *gpio;
+	struct axp20x_pctl *pctl;
 	struct pinctrl_desc *pctrl_desc;
 	struct pinctrl_pin_desc *pins;
 	int ret, i;
@@ -488,42 +488,42 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
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
 
-	gpio->regmap = axp20x->regmap;
+	pctl->regmap = axp20x->regmap;
 
-	gpio->desc = &axp20x_pinctrl_data;
-	gpio->dev = &pdev->dev;
+	pctl->desc = &axp20x_pinctrl_data;
+	pctl->dev = &pdev->dev;
 
-	platform_set_drvdata(pdev, gpio);
+	platform_set_drvdata(pdev, pctl);
 
 	ret = axp20x_build_state(pdev);
 	if (ret)
 		return ret;
 
-	pins = devm_kzalloc(&pdev->dev, gpio->desc->npins * sizeof(*pins),
+	pins = devm_kzalloc(&pdev->dev, pctl->desc->npins * sizeof(*pins),
 			    GFP_KERNEL);
 	if (!pins)
 		return -ENOMEM;
 
-	for (i = 0; i < gpio->desc->npins; i++)
-		pins[i] = gpio->desc->pins[i].pin;
+	for (i = 0; i < pctl->desc->npins; i++)
+		pins[i] = pctl->desc->pins[i].pin;
 
 	pctrl_desc = devm_kzalloc(&pdev->dev, sizeof(*pctrl_desc), GFP_KERNEL);
 	if (!pctrl_desc)
@@ -532,26 +532,26 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
 	pctrl_desc->name = dev_name(&pdev->dev);
 	pctrl_desc->owner = THIS_MODULE;
 	pctrl_desc->pins = pins;
-	pctrl_desc->npins = gpio->desc->npins;
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
-				     gpio->desc->pins->pin.number,
-				     gpio->desc->pins->pin.number,
-				     gpio->desc->npins);
+	ret = gpiochip_add_pin_range(&pctl->chip, dev_name(&pdev->dev),
+				     pctl->desc->pins->pin.number,
+				     pctl->desc->pins->pin.number,
+				     pctl->desc->npins);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add pin range\n");
 		return ret;
@@ -562,21 +562,21 @@ static int axp20x_gpio_probe(struct platform_device *pdev)
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
git-series 0.9.1
