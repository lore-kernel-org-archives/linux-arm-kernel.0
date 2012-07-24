From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Tue, 24 Jul 2012 08:17:43 +0200
Subject: [PATCH] arm: at91: do not use irq_find_mapping for linear domain
Message-ID: <1343110663-14385-1-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a gpio chip is registered through device tree, it declares an irq
domain of the "linear" type. irq_find_mapping should not be used when
translating between hw irq and linux irq numbers for such domains. So,
replace irq_find_mapping with irq_linear_revmap.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/mach-at91/gpio.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 325837a..c98bb3c 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -39,6 +39,7 @@ struct at91_gpio_chip {
 	int			pioc_idx;	/* PIO bank index */
 	void __iomem		*regbase;	/* PIO bank virtual address */
 	struct clk		*clock;		/* associated clock */
+	bool			linear_domain;
 	struct irq_domain	*domain;	/* associated irq domain */
 };
 
@@ -583,6 +584,14 @@ static struct irq_chip gpio_irqchip = {
 	.irq_set_wake	= gpio_irq_set_wake,
 };
 
+static unsigned gpio_revmap(struct at91_gpio_chip *at91_gpio, unsigned hwirq)
+{
+	if (at91_gpio->linear_domain)
+		return irq_linear_revmap(at91_gpio->domain, hwirq);
+
+	return irq_find_mapping(at91_gpio->domain, hwirq);
+}
+
 static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct irq_data *idata = irq_desc_get_irq_data(desc);
@@ -610,7 +619,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 
 		n = find_first_bit(&isr, BITS_PER_LONG);
 		while (n < BITS_PER_LONG) {
-			generic_handle_irq(irq_find_mapping(at91_gpio->domain, n));
+			generic_handle_irq(gpio_revmap(at91_gpio, n));
 			n = find_next_bit(&isr, BITS_PER_LONG, n + 1);
 		}
 	}
@@ -759,6 +768,7 @@ int __init at91_gpio_of_irq_setup(struct device_node *node,
 	if (!at91_gpio->domain)
 		panic("at91_gpio.%d: couldn't allocate irq domain (DT).\n",
 			at91_gpio->pioc_idx);
+	at91_gpio->linear_domain = true;
 
 	/* Setup chained handler */
 	if (at91_gpio->pioc_idx)
@@ -800,6 +810,7 @@ static void __init at91_gpio_irqdomain(struct at91_gpio_chip *at91_gpio)
 	at91_gpio->domain = irq_domain_add_legacy(NULL, at91_gpio->chip.ngpio,
 						  irq_base, 0,
 						  &irq_domain_simple_ops, NULL);
+	at91_gpio->linear_domain = false;
 	if (!at91_gpio->domain)
 		panic("at91_gpio.%d: couldn't allocate irq domain.\n",
 			at91_gpio->pioc_idx);
-- 
1.7.2.5
