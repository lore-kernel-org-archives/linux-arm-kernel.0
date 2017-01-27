From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Fri, 27 Jan 2017 17:15:14 +0100
Subject: [PATCH 1/8] pinctrl: stm32: fix bad location of gpiochip_lock_as_irq
In-Reply-To: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1485533721-9019-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move gpio lock as irq from "domain alloc" callback to "domain activate"
callback. It will allow to use gpiolib sysfs correctly.

Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index efc4371..b145431 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -236,6 +236,15 @@ static void stm32_gpio_domain_activate(struct irq_domain *d,
 	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 
 	regmap_field_write(pctl->irqmux[irq_data->hwirq], bank->range.id);
+	gpiochip_lock_as_irq(&bank->gpio_chip, irq_data->hwirq);
+}
+
+static void stm32_gpio_domain_deactivate(struct irq_domain *d,
+				       struct irq_data *irq_data)
+{
+	struct stm32_gpio_bank *bank = d->host_data;
+
+	gpiochip_unlock_as_irq(&bank->gpio_chip, irq_data->hwirq);
 }
 
 static int stm32_gpio_domain_alloc(struct irq_domain *d,
@@ -243,11 +252,9 @@ static int stm32_gpio_domain_alloc(struct irq_domain *d,
 				   unsigned int nr_irqs, void *data)
 {
 	struct stm32_gpio_bank *bank = d->host_data;
-	struct stm32_pinctrl *pctl = dev_get_drvdata(bank->gpio_chip.parent);
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
-	int ret;
 
 	hwirq = fwspec->param[0];
 	parent_fwspec.fwnode = d->parent->fwnode;
@@ -258,35 +265,15 @@ static int stm32_gpio_domain_alloc(struct irq_domain *d,
 	irq_domain_set_hwirq_and_chip(d, virq, hwirq, &stm32_gpio_irq_chip,
 				      bank);
 
-	ret = gpiochip_lock_as_irq(&bank->gpio_chip, hwirq);
-	if (ret) {
-		dev_err(pctl->dev, "Unable to configure STM32 %s%ld as IRQ\n",
-			bank->gpio_chip.label, hwirq);
-		return ret;
-	}
-
-	ret = irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &parent_fwspec);
-	if (ret)
-		gpiochip_unlock_as_irq(&bank->gpio_chip, hwirq);
-
-	return ret;
-}
-
-static void stm32_gpio_domain_free(struct irq_domain *d, unsigned int virq,
-				   unsigned int nr_irqs)
-{
-	struct stm32_gpio_bank *bank = d->host_data;
-	struct irq_data *data = irq_get_irq_data(virq);
-
-	irq_domain_free_irqs_common(d, virq, nr_irqs);
-	gpiochip_unlock_as_irq(&bank->gpio_chip, data->hwirq);
+	return irq_domain_alloc_irqs_parent(d, virq, nr_irqs, &parent_fwspec);
 }
 
 static const struct irq_domain_ops stm32_gpio_domain_ops = {
 	.translate      = stm32_gpio_domain_translate,
 	.alloc          = stm32_gpio_domain_alloc,
-	.free           = stm32_gpio_domain_free,
+	.free           = irq_domain_free_irqs_common,
 	.activate	= stm32_gpio_domain_activate,
+	.deactivate	= stm32_gpio_domain_deactivate,
 };
 
 /* Pinctrl functions */
-- 
1.9.1
