From: balbi@ti.com (Felipe Balbi)
Date: Wed, 5 Jan 2011 08:46:18 +0200
Subject: [PATCH] arm: omap: gpio: don't access irq_desc array directly
Message-ID: <mailman.103.1294210052.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of accessing the irq_desc array directly
we can use irq_to_desc(irq). That will allow us to,
if wanted, select SPARSE_IRQ and irq_descs will be
added to a radix tree, instead of a array.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/gpio.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 1f98e0b..197a6c0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -756,8 +756,10 @@ static int gpio_irq_type(unsigned irq, unsigned type)
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
 	if (retval == 0) {
-		irq_desc[irq].status &= ~IRQ_TYPE_SENSE_MASK;
-		irq_desc[irq].status |= type;
+		struct irq_desc *d = irq_to_desc(irq);
+
+		d->status &= ~IRQ_TYPE_SENSE_MASK;
+		d->status |= type;
 	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -1671,7 +1673,9 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 
 	for (j = bank->virtual_irq_start;
 		     j < bank->virtual_irq_start + bank_width; j++) {
-		lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
+		struct irq_desc *d = irq_to_desc(j);
+
+		lockdep_set_class(&d->lock, &gpio_lock_class);
 		set_irq_chip_data(j, bank);
 		if (bank_is_mpuio(bank))
 			set_irq_chip(j, &mpuio_irq_chip);
-- 
1.7.3.4.598.g85356


--b5gNqxB1S1yM7hjW--
