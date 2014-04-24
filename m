From: alexanders83@web.de (Alexander Stein)
Date: Thu, 24 Apr 2014 19:55:39 +0200
Subject: [PATCH v2] pinctrl/at91: Fix lockup when IRQ on PIOC and PIOD occurs
In-Reply-To: <1398289203-2407-1-git-send-email-alexanders83@web.de>
References: <1398289203-2407-1-git-send-email-alexanders83@web.de>
Message-ID: <1398362139-25551-1-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 80cc3732 (pinctrl/at91: convert driver to use gpiolib irqchip)
gpiochip_set_chained_irqchip is called for PIOC, PIOD and PIOE. The
associated GPIO chip for the IRQ chip is overwritten each time, because
they share the same hard IRQ line.
Thus if an IRQ occurs on PIOC or PIOD, gpio_irq_handler will only check on
PIOE (the assigned GPIO chip) where no event occured. Thus the IRQ will
not be cleared, retriggering the ISR.
Fix that (like done before) by only set the PIOC GPIO chip to the IRQ chip
and walk the list in the irq handler.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
Changes in v2:
* Fix git SHA1 in commit message (used local one)
* Switch to the next gpio_chip when walking the list

Now really tested with evtest on inputs with IRQ on PIO A, B, D and E!
I don't have any useable GPIO on PIO C though.

 drivers/pinctrl/pinctrl-at91.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 64a8f8f..d90ae02 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1453,6 +1453,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 				break;
 			at91_gpio = at91_gpio->next;
 			pio = at91_gpio->regbase;
+			gpio_chip = &at91_gpio->chip;
 			continue;
 		}
 
@@ -1468,6 +1469,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 static int at91_gpio_of_irq_setup(struct device_node *node,
 				  struct at91_gpio_chip *at91_gpio)
 {
+	struct at91_gpio_chip   *prev = NULL;
 	struct irq_data		*d = irq_get_irq_data(at91_gpio->pioc_virq);
 	int ret;
 
@@ -1493,6 +1495,17 @@ static int at91_gpio_of_irq_setup(struct device_node *node,
 		panic("at91_gpio.%d: couldn't allocate irq domain (DT).\n",
 			at91_gpio->pioc_idx);
 
+	/* Setup chained handler */
+	if (at91_gpio->pioc_idx)
+		prev = gpio_chips[at91_gpio->pioc_idx - 1];
+
+	/* The top level handler handles one bank of GPIOs, except
+	 * on some SoC it can handle up to three...
+	 * We only set up the handler for the first of the list.
+	 */
+	if (prev && prev->next == at91_gpio)
+		return 0;
+
 	/* Then register the chain on the parent IRQ */
 	gpiochip_set_chained_irqchip(&at91_gpio->chip,
 				     &gpio_irqchip,
-- 
1.9.2
