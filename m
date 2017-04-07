From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 7 Apr 2017 14:42:58 +0200
Subject: [PATCH v2 1/7] pinctrl: stm32: add possibility to use gpio-ranges to
 declare bank range
In-Reply-To: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1491568984-20169-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use device tree entries to declare gpio range. It will allow to use
no contiguous gpio bank and holes inside a bank.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index abc405b..d3c5f5d 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -71,6 +71,7 @@ struct stm32_gpio_bank {
 	struct pinctrl_gpio_range range;
 	struct fwnode_handle *fwnode;
 	struct irq_domain *domain;
+	u32 bank_nr;
 };
 
 struct stm32_pinctrl {
@@ -138,6 +139,17 @@ static inline void __stm32_gpio_set(struct stm32_gpio_bank *bank,
 
 static int stm32_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
+	struct stm32_gpio_bank *bank = gpiochip_get_data(chip);
+	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
+	struct pinctrl_gpio_range *range;
+	int pin = offset + (bank->bank_nr * STM32_GPIO_PINS_PER_BANK);
+
+	range = pinctrl_find_gpio_range_from_pin_nolock(pctl->pctl_dev, pin);
+	if (!range) {
+		dev_err(pctl->dev, "pin %d not in range.\n", pin);
+		return -EINVAL;
+	}
+
 	return pinctrl_request_gpio(chip->base + offset);
 }
 
@@ -235,7 +247,7 @@ static void stm32_gpio_domain_activate(struct irq_domain *d,
 	struct stm32_gpio_bank *bank = d->host_data;
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 
-	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->range.id);
+	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->bank_nr);
 	gpiochip_lock_as_irq(&bank->gpio_chip, irq_data->hwirq);
 }
 
@@ -589,7 +601,7 @@ static int stm32_pmx_set_mux(struct pinctrl_dev *pctldev,
 	}
 
 	range = pinctrl_find_gpio_range_from_pin(pctldev, g->pin);
-	bank = gpio_range_to_bank(range);
+	bank = gpiochip_get_data(range->gc);
 	pin = stm32_gpio_pin(g->pin);
 
 	mode = stm32_gpio_get_mode(function);
@@ -604,7 +616,7 @@ static int stm32_pmx_gpio_set_direction(struct pinctrl_dev *pctldev,
 			struct pinctrl_gpio_range *range, unsigned gpio,
 			bool input)
 {
-	struct stm32_gpio_bank *bank = gpio_range_to_bank(range);
+	struct stm32_gpio_bank *bank = gpiochip_get_data(range->gc);
 	int pin = stm32_gpio_pin(gpio);
 
 	stm32_pmx_set_mode(bank, pin, !input, 0);
@@ -762,7 +774,7 @@ static int stm32_pconf_parse_conf(struct pinctrl_dev *pctldev,
 	int offset, ret = 0;
 
 	range = pinctrl_find_gpio_range_from_pin(pctldev, pin);
-	bank = gpio_range_to_bank(range);
+	bank = gpiochip_get_data(range->gc);
 	offset = stm32_gpio_pin(pin);
 
 	switch (param) {
@@ -843,7 +855,7 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 	bool val;
 
 	range = pinctrl_find_gpio_range_from_pin_nolock(pctldev, pin);
-	bank = gpio_range_to_bank(range);
+	bank = gpiochip_get_data(range->gc);
 	offset = stm32_gpio_pin(pin);
 
 	stm32_pmx_get_mode(bank, offset, &mode, &alt);
@@ -898,13 +910,14 @@ static void stm32_pconf_dbg_show(struct pinctrl_dev *pctldev,
 static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	struct device_node *np)
 {
-	int bank_nr = pctl->nbanks;
-	struct stm32_gpio_bank *bank = &pctl->banks[bank_nr];
+	struct stm32_gpio_bank *bank = &pctl->banks[pctl->nbanks];
 	struct pinctrl_gpio_range *range = &bank->range;
+	struct of_phandle_args args;
 	struct device *dev = pctl->dev;
 	struct resource res;
 	struct reset_control *rstc;
-	int err, npins;
+	int npins = STM32_GPIO_PINS_PER_BANK;
+	int bank_nr, err;
 
 	rstc = of_reset_control_get(np, NULL);
 	if (!IS_ERR(rstc))
@@ -929,28 +942,33 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 		return err;
 	}
 
-	npins = pctl->match_data->npins;
-	npins -= bank_nr * STM32_GPIO_PINS_PER_BANK;
-	if (npins < 0)
-		return -EINVAL;
-	else if (npins > STM32_GPIO_PINS_PER_BANK)
-		npins = STM32_GPIO_PINS_PER_BANK;
-
 	bank->gpio_chip = stm32_gpio_template;
+
+	of_property_read_string(np, "st,bank-name", &bank->gpio_chip.label);
+
+	if (!of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args)) {
+		bank_nr = args.args[1] / STM32_GPIO_PINS_PER_BANK;
+		bank->gpio_chip.base = args.args[1];
+	} else {
+		bank_nr = pctl->nbanks;
+		bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
+		range->name = bank->gpio_chip.label;
+		range->id = bank_nr;
+		range->pin_base = range->id * STM32_GPIO_PINS_PER_BANK;
+		range->base = range->id * STM32_GPIO_PINS_PER_BANK;
+		range->npins = npins;
+		range->gc = &bank->gpio_chip;
+		pinctrl_add_gpio_range(pctl->pctl_dev,
+				       &pctl->banks[bank_nr].range);
+	}
 	bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
+
 	bank->gpio_chip.ngpio = npins;
 	bank->gpio_chip.of_node = np;
 	bank->gpio_chip.parent = dev;
+	bank->bank_nr = bank_nr;
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
 
@@ -967,7 +985,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 		return err;
 	}
 
-	dev_info(dev, "%s bank added\n", range->name);
+	dev_info(dev, "%s bank added\n", bank->gpio_chip.label);
 	return 0;
 }
 
@@ -1086,30 +1104,6 @@ int stm32_pctl_probe(struct platform_device *pdev)
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
@@ -1129,13 +1123,34 @@ int stm32_pctl_probe(struct platform_device *pdev)
 
 	pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, &pctl->pctl_desc,
 					       pctl);
+
 	if (IS_ERR(pctl->pctl_dev)) {
 		dev_err(&pdev->dev, "Failed pinctrl registration\n");
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
