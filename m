From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 27 Jan 2017 17:15:15 +0100
Subject: [PATCH 2/8] pinctrl: stm32: use gpio-ranges to declare bank range
In-Reply-To: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485533721-9019-3-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use device tree entries to declare gpio range. It will allow to use
no contiguous gpio bank and holes inside a bank.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index b145431..d0a968a 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -589,7 +589,7 @@ static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
 	}
 
 	range = pinctrl_find_gpio_range_from_pin(pctldev, g->pin);
-	bank = gpio_range_to_bank(range);
+	bank = gpiochip_get_data(range->gc);
 	pin = stm32_gpio_pin(g->pin);
 
 	mode = stm32_gpio_get_mode(function);
@@ -604,7 +604,7 @@ static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range, unsigned gpio,
 			bool input)
 {
-	struct stm32_gpio_bank *bank = gpio_range_to_bank(range);
+	struct stm32_gpio_bank *bank = gpiochip_get_data(range->gc);
 	int pin = stm32_gpio_pin(gpio);
 
 	stm32_pmx_set_mode(bank, pin, !input, 0);
@@ -761,7 +761,7 @@ static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
 	int offset, ret = 0;
 
 	range = pinctrl_find_gpio_range_from_pin(pctldev, pin);
-	bank = gpio_range_to_bank(range);
+	bank = gpiochip_get_data(range->gc);
 	offset = stm32_gpio_pin(pin);
 
 	switch (param) {
@@ -842,7 +842,7 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 	bool val;
 
 	range = pinctrl_find_gpio_range_from_pin_nolock(pctldev, pin);
-	bank = gpio_range_to_bank(range);
+	bank = gpiochip_get_data(range->gc);
 	offset = stm32_gpio_pin(pin);
 
 	stm32_pmx_get_mode(bank, offset, &mode, &alt);
@@ -900,10 +900,12 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	int bank_nr = pctl->nbanks;
 	struct stm32_gpio_bank *bank = &pctl->banks[bank_nr];
 	struct pinctrl_gpio_range *range = &bank->range;
+	struct of_phandle_args args;
 	struct device *dev = pctl->dev;
 	struct resource res;
 	struct reset_control *rstc;
-	int err, npins;
+	unsigned int npins;
+	int err;
 
 	rstc = of_reset_control_get(np, NULL);
 	if (!IS_ERR(rstc))
@@ -928,28 +930,32 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 		return err;
 	}
 
-	npins = pctl->match_data->npins;
-	npins -= bank_nr * STM32_GPIO_PINS_PER_BANK;
-	if (npins < 0)
-		return -EINVAL;
-	else if (npins > STM32_GPIO_PINS_PER_BANK)
+	if (of_property_read_u32(np, "ngpios", &npins))
 		npins = STM32_GPIO_PINS_PER_BANK;
 
 	bank->gpio_chip = stm32_gpio_template;
+
+	of_property_read_string(np, "st,bank-name", &bank->gpio_chip.label);
+
+	if (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args))
+		bank_nr = args.args[1] / STM32_GPIO_PINS_PER_BANK;
+	else {
+		range->name = bank->gpio_chip.label;
+		range->id = bank_nr;
+		range->pin_base = range->id * STM32_GPIO_PINS_PER_BANK;
+		range->base = range->id * STM32_GPIO_PINS_PER_BANK;
+		range->npins = npins;
+		range->gc = &bank->gpio_chip;
+		pinctrl_add_gpio_range(pctl->pctl_dev,
+				       &pctl->banks[bank_nr].range);
+	}
+
 	bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
 	bank->gpio_chip.ngpio = npins;
 	bank->gpio_chip.of_node = np;
 	bank->gpio_chip.parent = dev;
 	spin_lock_init(&bank->lock);
 
-	of_property_read_string(np, "st,bank-name", &range->name);
-	bank->gpio_chip.label = range->name;
-
-	range->id = bank_nr;
-	range->pin_base = range->base = range->id * STM32_GPIO_PINS_PER_BANK;
-	range->npins = bank->gpio_chip.ngpio;
-	range->gc = &bank->gpio_chip;
-
 	/* create irq hierarchical domain */
 	bank->fwnode = of_node_to_fwnode(np);
 
@@ -966,7 +972,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 		return err;
 	}
 
-	dev_info(dev, "%s bank added\n", range->name);
+	dev_info(dev, "%s bank added\n", bank->gpio_chip.label);
 	return 0;
 }
 
@@ -1085,30 +1091,6 @@ int stm32_pctl_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	for_each_child_of_node(np, child)
-		if (of_property_read_bool(child, "gpio-controller"))
-			banks++;
-
-	if (!banks) {
-		dev_err(dev, "at least one GPIO bank is required\n");
-		return -EINVAL;
-	}
-
-	pctl->banks = devm_kcalloc(dev, banks, sizeof(*pctl->banks),
-			GFP_KERNEL);
-	if (!pctl->banks)
-		return -ENOMEM;
-
-	for_each_child_of_node(np, child) {
-		if (of_property_read_bool(child, "gpio-controller")) {
-			ret = stm32_gpiolib_register_bank(pctl, child);
-			if (ret)
-				return ret;
-
-			pctl->nbanks++;
-		}
-	}
-
 	pins = devm_kcalloc(&pdev->dev, pctl->match_data->npins, sizeof(*pins),
 			    GFP_KERNEL);
 	if (!pins)
@@ -1133,8 +1115,28 @@ int stm32_pctl_probe(struct platform_device *pdev)
 		return PTR_ERR(pctl->pctl_dev);
 	}
 
-	for (i = 0; i < pctl->nbanks; i++)
-		pinctrl_add_gpio_range(pctl->pctl_dev, &pctl->banks[i].range);
+	for_each_child_of_node(np, child)
+		if (of_property_read_bool(child, "gpio-controller"))
+			banks++;
+
+	if (!banks) {
+		dev_err(dev, "at least one GPIO bank is required\n");
+		return -EINVAL;
+	}
+	pctl->banks = devm_kcalloc(dev, banks, sizeof(*pctl->banks),
+			GFP_KERNEL);
+	if (!pctl->banks)
+		return -ENOMEM;
+
+	for_each_child_of_node(np, child) {
+		if (of_property_read_bool(child, "gpio-controller")) {
+			ret = stm32_gpiolib_register_bank(pctl, child);
+			if (ret)
+				return ret;
+
+			pctl->nbanks++;
+		}
+	}
 
 	dev_info(dev, "Pinctrl STM32 initialized\n");
 
-- 
1.9.1
