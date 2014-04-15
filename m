From: alexanders83@web.de (Alexander Stein)
Date: Tue, 15 Apr 2014 22:09:41 +0200
Subject: [PATCH] pinctrl/at91: convert driver to use gpiolib irqchip
Message-ID: <1397592581-20251-1-git-send-email-alexanders83@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts the AT91 pin control driver to register its
chained irq handler and irqchip using the helpers in the
gpiolib core.

Signed-off-by: Alexander Stein <alexanders83@web.de>
---
This fixes the problem I come up with the patch
> gpio/at91: free GPIO after configuring as input
This uses irqchip helpers similar to 
> e0bc34a ("pinctrl: nomadik: convert driver to use gpiolib irqchip")

Tested on a device tree based AT91SAM9263 board using GPIO buttons on
PIO A and PIO E using evtest.
 drivers/pinctrl/Kconfig        |   3 +
 drivers/pinctrl/pinctrl-at91.c | 135 +++++++++--------------------------------
 2 files changed, 33 insertions(+), 105 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index e493240..23a61c9 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -84,6 +84,9 @@ config PINCTRL_AT91
 	depends on ARCH_AT91
 	select PINMUX
 	select PINCONF
+	select GPIOLIB
+	select OF_GPIO
+	select GPIOLIB_IRQCHIP
 	help
 	  Say Y here to enable the at91 pinctrl driver
 
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index f7f3b1f..64a8f8f 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -16,9 +16,6 @@
 #include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/irqchip/chained_irq.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/pinctrl/machine.h>
@@ -47,7 +44,6 @@ struct at91_gpio_chip {
 	int			pioc_idx;	/* PIO bank index */
 	void __iomem		*regbase;	/* PIO bank virtual address */
 	struct clk		*clock;		/* associated clock */
-	struct irq_domain	*domain;	/* associated irq domain */
 	struct at91_pinctrl_mux_ops *ops;	/* ops */
 };
 
@@ -1192,21 +1188,6 @@ static int at91_gpio_direction_output(struct gpio_chip *chip, unsigned offset,
 	return 0;
 }
 
-static int at91_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	struct at91_gpio_chip *at91_gpio = to_at91_gpio_chip(chip);
-	int virq;
-
-	if (offset < chip->ngpio)
-		virq = irq_create_mapping(at91_gpio->domain, offset);
-	else
-		virq = -ENXIO;
-
-	dev_dbg(chip->dev, "%s: request IRQ for GPIO %d, return %d\n",
-				chip->label, offset + chip->base, virq);
-	return virq;
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void at91_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 {
@@ -1335,6 +1316,11 @@ static int alt_gpio_irq_type(struct irq_data *d, unsigned type)
 	return 0;
 }
 
+static void gpio_orq_ack(struct irq_data *d)
+{
+	/* the interrupt is already cleared before by reading ISR */
+}
+
 static unsigned int gpio_irq_startup(struct irq_data *d)
 {
 	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(d);
@@ -1434,6 +1420,7 @@ void at91_pinctrl_gpio_resume(void)
 
 static struct irq_chip gpio_irqchip = {
 	.name		= "GPIO",
+	.irq_ack	= gpio_orq_ack,
 	.irq_startup	= gpio_irq_startup,
 	.irq_shutdown	= gpio_irq_shutdown,
 	.irq_disable	= gpio_irq_mask,
@@ -1445,9 +1432,11 @@ static struct irq_chip gpio_irqchip = {
 
 static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irq_data *idata = irq_desc_get_irq_data(desc);
-	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(idata);
+	struct irq_chip *chip = irq_get_chip(irq);
+	struct gpio_chip *gpio_chip = irq_desc_get_handler_data(desc);
+	struct at91_gpio_chip *at91_gpio = container_of(gpio_chip,
+					   struct at91_gpio_chip, chip);
+
 	void __iomem	*pio = at91_gpio->regbase;
 	unsigned long	isr;
 	int		n;
@@ -1468,81 +1457,19 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 		}
 
 		for_each_set_bit(n, &isr, BITS_PER_LONG) {
-			generic_handle_irq(irq_find_mapping(at91_gpio->domain, n));
+			generic_handle_irq(irq_find_mapping(
+					   gpio_chip->irqdomain, n));
 		}
 	}
 	chained_irq_exit(chip, desc);
 	/* now it may re-trigger */
 }
 
-/*
- * This lock class tells lockdep that GPIO irqs are in a different
- * category than their parents, so it won't report false recursion.
- */
-static struct lock_class_key gpio_lock_class;
-
-static int at91_gpio_irq_map(struct irq_domain *h, unsigned int virq,
-							irq_hw_number_t hw)
-{
-	struct at91_gpio_chip	*at91_gpio = h->host_data;
-	void __iomem		*pio = at91_gpio->regbase;
-	u32			mask = 1 << hw;
-
-	irq_set_lockdep_class(virq, &gpio_lock_class);
-
-	/*
-	 * Can use the "simple" and not "edge" handler since it's
-	 * shorter, and the AIC handles interrupts sanely.
-	 */
-	irq_set_chip(virq, &gpio_irqchip);
-	if ((at91_gpio->ops == &at91sam9x5_ops) &&
-	    (readl_relaxed(pio + PIO_AIMMR) & mask) &&
-	    (readl_relaxed(pio + PIO_ELSR) & mask))
-		irq_set_handler(virq, handle_level_irq);
-	else
-		irq_set_handler(virq, handle_simple_irq);
-	set_irq_flags(virq, IRQF_VALID);
-	irq_set_chip_data(virq, at91_gpio);
-
-	return 0;
-}
-
-static int at91_gpio_irq_domain_xlate(struct irq_domain *d,
-				      struct device_node *ctrlr,
-				      const u32 *intspec, unsigned int intsize,
-				      irq_hw_number_t *out_hwirq,
-				      unsigned int *out_type)
-{
-	struct at91_gpio_chip *at91_gpio = d->host_data;
-	int ret;
-	int pin = at91_gpio->chip.base + intspec[0];
-
-	if (WARN_ON(intsize < 2))
-		return -EINVAL;
-	*out_hwirq = intspec[0];
-	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
-
-	ret = gpio_request(pin, ctrlr->full_name);
-	if (ret)
-		return ret;
-
-	ret = gpio_direction_input(pin);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static struct irq_domain_ops at91_gpio_ops = {
-	.map	= at91_gpio_irq_map,
-	.xlate	= at91_gpio_irq_domain_xlate,
-};
-
 static int at91_gpio_of_irq_setup(struct device_node *node,
 				  struct at91_gpio_chip *at91_gpio)
 {
-	struct at91_gpio_chip	*prev = NULL;
 	struct irq_data		*d = irq_get_irq_data(at91_gpio->pioc_virq);
+	int ret;
 
 	at91_gpio->pioc_hwirq = irqd_to_hwirq(d);
 
@@ -1552,26 +1479,25 @@ static int at91_gpio_of_irq_setup(struct device_node *node,
 	/* Disable irqs of this PIO controller */
 	writel_relaxed(~0, at91_gpio->regbase + PIO_IDR);
 
-	/* Setup irq domain */
-	at91_gpio->domain = irq_domain_add_linear(node, at91_gpio->chip.ngpio,
-						&at91_gpio_ops, at91_gpio);
-	if (!at91_gpio->domain)
+	/*
+	 * Let the generic code handle this edge IRQ, the the chained
+	 * handler will perform the actual work of handling the parent
+	 * interrupt.
+	 */
+	ret = gpiochip_irqchip_add(&at91_gpio->chip,
+				   &gpio_irqchip,
+				   0,
+				   handle_edge_irq,
+				   IRQ_TYPE_EDGE_BOTH);
+	if (ret)
 		panic("at91_gpio.%d: couldn't allocate irq domain (DT).\n",
 			at91_gpio->pioc_idx);
 
-	/* Setup chained handler */
-	if (at91_gpio->pioc_idx)
-		prev = gpio_chips[at91_gpio->pioc_idx - 1];
-
-	/* The top level handler handles one bank of GPIOs, except
-	 * on some SoC it can handle up to three...
-	 * We only set up the handler for the first of the list.
-	 */
-	if (prev && prev->next == at91_gpio)
-		return 0;
-
-	irq_set_chip_data(at91_gpio->pioc_virq, at91_gpio);
-	irq_set_chained_handler(at91_gpio->pioc_virq, gpio_irq_handler);
+	/* Then register the chain on the parent IRQ */
+	gpiochip_set_chained_irqchip(&at91_gpio->chip,
+				     &gpio_irqchip,
+				     at91_gpio->pioc_virq,
+				     gpio_irq_handler);
 
 	return 0;
 }
@@ -1585,7 +1511,6 @@ static struct gpio_chip at91_gpio_template = {
 	.get			= at91_gpio_get,
 	.direction_output	= at91_gpio_direction_output,
 	.set			= at91_gpio_set,
-	.to_irq			= at91_gpio_to_irq,
 	.dbg_show		= at91_gpio_dbg_show,
 	.can_sleep		= false,
 	.ngpio			= MAX_NB_GPIO_PER_BANK,
-- 
1.9.2
