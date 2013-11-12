From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:48:29 +0100
Subject: [PATCH 5/7] ARM: sa1100: move GPIO masks to state container
Message-ID: <1384264109-6361-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the masks for the GPIO edges into the SC state container
so that we can get rid of the file-local variables. Define the
default-on mask for GPIOs 0 thru 11 by a hex value instead of
BIT(11) - 1 as the inverse of this hex value is used in the
sa1100_high_gpio_handler() function.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/irq.c | 98 +++++++++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 4b1e6bb60e5e..5463ba521ac7 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -27,36 +27,53 @@
 
 #include "generic.h"
 
-/*
- * SA1100 GPIO edge detection for IRQs:
- * IRQs are generated on Falling-Edge, Rising-Edge, or both.
- * Use this instead of directly setting GRER/GFER.
+/**
+ * struct sa1100_sc - SA1100 interrupt controller
+ * @domain: irqdomain used to map the irqs for these chips
+ * @low_gpio_chip: irqchip to handle hardware IRQs 0-10
+ * @normal_chip: irqchip to handle hardware IRQs 12-31
+ * @high_domain: irqdomain for the high GPIO IRQs
+ * @high_gpio_chip: irqchip handling the cascaded IRQs off
+ * IRQ 11 on the normal chip.
+ * @gpio_rising: whether the IRQ for the GPIO corresponding to the
+ * bit in this word should trigger on rising edges.
+ * @gpio_falling: whether the IRQ for the GPIO corresponding to the
+ * bit in this word should trigger on falling edges.
+ * @gpio_mask: whether this GPIO is masked off.
  */
-static int GPIO_IRQ_rising_edge;
-static int GPIO_IRQ_falling_edge;
-static int GPIO_IRQ_mask = (1 << 11) - 1;
+struct sa1100_sc {
+	struct irq_domain *domain;
+	struct irq_chip low_gpio_chip;
+	struct irq_chip normal_chip;
+	struct irq_domain *high_domain;
+	struct irq_chip high_gpio_chip;
+	u32 gpio_rising;
+	u32 gpio_falling;
+	u32 gpio_mask;
+};
 
 static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 {
+	struct sa1100_sc *sc = irq_data_get_irq_chip_data(d);
 	unsigned int mask = BIT(d->hwirq);
 
 	if (type == IRQ_TYPE_PROBE) {
-		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
+		if ((sc->gpio_rising | sc->gpio_falling) & mask)
 			return 0;
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
 	}
 
-	if (type & IRQ_TYPE_EDGE_RISING) {
-		GPIO_IRQ_rising_edge |= mask;
-	} else
-		GPIO_IRQ_rising_edge &= ~mask;
-	if (type & IRQ_TYPE_EDGE_FALLING) {
-		GPIO_IRQ_falling_edge |= mask;
-	} else
-		GPIO_IRQ_falling_edge &= ~mask;
+	if (type & IRQ_TYPE_EDGE_RISING)
+		sc->gpio_rising |= mask;
+	else
+		sc->gpio_rising &= ~mask;
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		sc->gpio_falling |= mask;
+	else
+		sc->gpio_falling &= ~mask;
 
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+	GRER = sc->gpio_rising & sc->gpio_mask;
+	GFER = sc->gpio_falling & sc->gpio_mask;
 
 	return 0;
 }
@@ -132,22 +149,23 @@ static void sa1100_high_gpio_ack(struct irq_data *d)
 
 static void sa1100_high_gpio_mask(struct irq_data *d)
 {
+	struct sa1100_sc *sc = irq_data_get_irq_chip_data(d);
 	unsigned int mask = BIT(d->hwirq);
 
-	GPIO_IRQ_mask &= ~mask;
-
+	sc->gpio_mask &= ~mask;
 	GRER &= ~mask;
 	GFER &= ~mask;
 }
 
 static void sa1100_high_gpio_unmask(struct irq_data *d)
 {
+	struct sa1100_sc *sc = irq_data_get_irq_chip_data(d);
 	unsigned int mask = BIT(d->hwirq);
 
-	GPIO_IRQ_mask |= mask;
+	sc->gpio_mask |= mask;
 
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+	GRER = sc->gpio_rising & sc->gpio_mask;
+	GFER = sc->gpio_falling & sc->gpio_mask;
 }
 
 static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
@@ -188,23 +206,6 @@ static int sa1100_set_wake(struct irq_data *d, unsigned int on)
 	return -EINVAL;
 }
 
-/**
- * struct sa1100_sc - SA1100 interrupt controller
- * @domain: irqdomain used to map the irqs for these chips
- * @low_gpio_chip: irqchip to handle hardware IRQs 0-10
- * @normal_chip: irqchip to handle hardware IRQs 12-31
- * @high_domain: irqdomain for the high GPIO IRQs
- * @high_gpio_chip: irqchip handling the cascaded IRQs off
- * IRQ 11 on the normal chip.
- */
-struct sa1100_sc {
-	struct irq_domain *domain;
-	struct irq_chip low_gpio_chip;
-	struct irq_chip normal_chip;
-	struct irq_domain *high_domain;
-	struct irq_chip high_gpio_chip;
-};
-
 static struct sa1100_sc sa1100_sc = {
 	.low_gpio_chip = {
 		.name		= "GPIO-l",
@@ -229,6 +230,13 @@ static struct sa1100_sc sa1100_sc = {
 		.irq_set_type	= sa1100_gpio_type,
 		.irq_set_wake	= sa1100_high_gpio_wake,
 	},
+	/*
+	 * This will enable IRQ on GPIOs 0 thru 11 by default, so
+	 * that they always fall through to the normal IRQ controller
+	 * where they can be masked on/off using that IRQ controllers
+	 * mask operations.
+	 */
+	.gpio_mask = 0x000007ff,
 };
 
 asmlinkage void __exception_irq_entry sa1100_handle_irq(struct pt_regs *regs)
@@ -298,6 +306,7 @@ static struct sa1100irq_state {
 
 static int sa1100irq_suspend(void)
 {
+	struct sa1100_sc *sc = &sa1100_sc;
 	struct sa1100irq_state *st = &sa1100irq_state;
 
 	st->saved = 1;
@@ -315,8 +324,8 @@ static int sa1100irq_suspend(void)
 	/*
 	 * Set the appropriate edges for wakeup.
 	 */
-	GRER = PWER & GPIO_IRQ_rising_edge;
-	GFER = PWER & GPIO_IRQ_falling_edge;
+	GRER = PWER & sc->gpio_rising;
+	GFER = PWER & sc->gpio_falling;
 
 	/*
 	 * Clear any pending GPIO interrupts.
@@ -328,14 +337,15 @@ static int sa1100irq_suspend(void)
 
 static void sa1100irq_resume(void)
 {
+	struct sa1100_sc *sc = &sa1100_sc;
 	struct sa1100irq_state *st = &sa1100irq_state;
 
 	if (st->saved) {
 		ICCR = st->iccr;
 		ICLR = st->iclr;
 
-		GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-		GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+		GRER = sc->gpio_rising & sc->gpio_mask;
+		GFER = sc->gpio_falling & sc->gpio_mask;
 
 		ICMR = st->icmr;
 	}
-- 
1.8.3.1
