From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jul 2018 14:57:36 +0200
Subject: [PATCH 1/2] pinctrl: stm32: fix bank io port number
In-Reply-To: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1531745857-5561-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the exti line is not in line with the bank number (that is the case
when there is an hole between two banks, for example GPIOK and then GPIOZ),
use "st,bank-ioport" DT property to get the right exti line.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
index 9a06e1f..60c678a 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
@@ -55,6 +55,8 @@ Optional properties:
    NOTE: If "gpio-ranges" is used for a gpio controller, all gpio-controller
    have to use a "gpio-ranges" entry.
    More details in Documentation/devicetree/bindings/gpio/gpio.txt.
+ - st,bank-ioport: should correspond to the EXTI IOport selection (EXTI line
+   used to select GPIOs as interrupts).
 
 Example 1:
 #include <dt-bindings/pinctrl/stm32f429-pinfunc.h>
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index dfed609..eb6ae14 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -73,6 +73,7 @@ struct stm32_gpio_bank {
 	struct fwnode_handle *fwnode;
 	struct irq_domain *domain;
 	u32 bank_nr;
+	u32 bank_ioport_nr;
 };
 
 struct stm32_pinctrl {
@@ -298,7 +299,7 @@ static int stm32_gpio_domain_activate(struct irq_domain *d,
 	struct stm32_gpio_bank *bank = d->host_data;
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 
-	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->bank_nr);
+	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->bank_ioport_nr);
 	return 0;
 }
 
@@ -948,6 +949,7 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 	struct device_node *np)
 {
 	struct stm32_gpio_bank *bank = &pctl->banks[pctl->nbanks];
+	int bank_ioport_nr;
 	struct pinctrl_gpio_range *range = &bank->range;
 	struct of_phandle_args args;
 	struct device *dev = pctl->dev;
@@ -998,12 +1000,17 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
 		pinctrl_add_gpio_range(pctl->pctl_dev,
 				       &pctl->banks[bank_nr].range);
 	}
+
+	if (of_property_read_u32(np, "st,bank-ioport", &bank_ioport_nr))
+		bank_ioport_nr = bank_nr;
+
 	bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
 
 	bank->gpio_chip.ngpio = npins;
 	bank->gpio_chip.of_node = np;
 	bank->gpio_chip.parent = dev;
 	bank->bank_nr = bank_nr;
+	bank->bank_ioport_nr = bank_ioport_nr;
 	spin_lock_init(&bank->lock);
 
 	/* create irq hierarchical domain */
-- 
2.7.4
