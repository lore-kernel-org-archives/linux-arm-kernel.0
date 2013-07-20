From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sat, 20 Jul 2013 16:51:33 +0200
Subject: [PATCH] pinctrl: at91: choose appropriate handler for level interrupts
Message-ID: <1374331893-16009-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation handle both edge and level interrupts with the
'handle_simple_irq' handler.

Level interrupts are active as long as the pin stays at the configured
level (low or high). In this case we have to use 'handle_level_irq' which
mask the interrupt until the handle has treated it.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/pinctrl/pinctrl-at91.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5d7529e..76e108d 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1241,18 +1241,22 @@ static int alt_gpio_irq_type(struct irq_data *d, unsigned type)
 
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
+		irq_set_handler(d->irq, handle_simple_irq);
 		writel_relaxed(mask, pio + PIO_ESR);
 		writel_relaxed(mask, pio + PIO_REHLSR);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
+		irq_set_handler(d->irq, handle_simple_irq);
 		writel_relaxed(mask, pio + PIO_ESR);
 		writel_relaxed(mask, pio + PIO_FELLSR);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
+		irq_set_handler(d->irq, handle_level_irq);
 		writel_relaxed(mask, pio + PIO_LSR);
 		writel_relaxed(mask, pio + PIO_FELLSR);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_handler(d->irq, handle_level_irq);
 		writel_relaxed(mask, pio + PIO_LSR);
 		writel_relaxed(mask, pio + PIO_REHLSR);
 		break;
@@ -1261,6 +1265,7 @@ static int alt_gpio_irq_type(struct irq_data *d, unsigned type)
 		 * disable additional interrupt modes:
 		 * fall back to default behavior
 		 */
+		irq_set_handler(d->irq, handle_simple_irq);
 		writel_relaxed(mask, pio + PIO_AIMDR);
 		return 0;
 	case IRQ_TYPE_NONE:
@@ -1402,6 +1407,8 @@ static int at91_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 							irq_hw_number_t hw)
 {
 	struct at91_gpio_chip	*at91_gpio = h->host_data;
+	void __iomem		*pio = at91_gpio->regbase;
+	u32			mask = 1 << hw;
 
 	irq_set_lockdep_class(virq, &gpio_lock_class);
 
@@ -1409,8 +1416,13 @@ static int at91_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 	 * Can use the "simple" and not "edge" handler since it's
 	 * shorter, and the AIC handles interrupts sanely.
 	 */
-	irq_set_chip_and_handler(virq, &gpio_irqchip,
-				 handle_simple_irq);
+	irq_set_chip(virq, &gpio_irqchip);
+	if ((at91_gpio->ops == &at91sam9x5_ops) &&
+	    (readl_relaxed(pio + PIO_AIMMR) & mask) &&
+	    (readl_relaxed(pio + PIO_ELSR) & mask))
+		irq_set_handler(virq, handle_level_irq);
+	else
+		irq_set_handler(virq, handle_simple_irq);
 	set_irq_flags(virq, IRQF_VALID);
 	irq_set_chip_data(virq, at91_gpio);
 
-- 
1.7.9.5
