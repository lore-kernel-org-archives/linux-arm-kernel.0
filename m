From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Nov 2013 14:48:21 +0100
Subject: [PATCH 4/7] ARM: sa1100: use hardware IRQ bit masks
Message-ID: <1384264101-6326-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By using the hardware IRQ number, and setting that to offset from
11 for the high GPIOs, we can get this number to match the bit
in the GPIO edge control registers for both low and high GPIOs
and we can simplify the code a bit.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-sa1100/irq.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index bf36b9abfaad..4b1e6bb60e5e 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -36,20 +36,9 @@ static int GPIO_IRQ_rising_edge;
 static int GPIO_IRQ_falling_edge;
 static int GPIO_IRQ_mask = (1 << 11) - 1;
 
-/*
- * To get the GPIO number from an IRQ number
- */
-#define GPIO_11_27_IRQ(i)	((i) - 21)
-#define GPIO11_27_MASK(irq)	(1 << GPIO_11_27_IRQ(irq))
-
 static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 {
-	unsigned int mask;
-
-	if (d->irq <= 10)
-		mask = 1 << d->irq;
-	else
-		mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 
 	if (type == IRQ_TYPE_PROBE) {
 		if ((GPIO_IRQ_rising_edge | GPIO_IRQ_falling_edge) & mask)
@@ -131,20 +120,19 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
 }
 
 /*
- * Like GPIO0 to 10, GPIO11-27 IRQs need to be handled specially.
- * In addition, the IRQs are all collected up into one bit in the
- * interrupt controller registers.
+ * GPIO 11 thru GPIO 27 IRQs need to be handled specially.
+ * These all trigger IRQ 11 on the interrupt controller, so we
+ * need to use the GPIO edge detect status register to see
+ * which GPIO was firing the IRQ.
  */
 static void sa1100_high_gpio_ack(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
-
-	GEDR = mask;
+	GEDR = BIT(d->hwirq);
 }
 
 static void sa1100_high_gpio_mask(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 
 	GPIO_IRQ_mask &= ~mask;
 
@@ -154,7 +142,7 @@ static void sa1100_high_gpio_mask(struct irq_data *d)
 
 static void sa1100_high_gpio_unmask(struct irq_data *d)
 {
-	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int mask = BIT(d->hwirq);
 
 	GPIO_IRQ_mask |= mask;
 
@@ -165,9 +153,9 @@ static void sa1100_high_gpio_unmask(struct irq_data *d)
 static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
 {
 	if (on)
-		PWER |= GPIO11_27_MASK(d->irq);
+		PWER |= BIT(d->hwirq);
 	else
-		PWER &= ~GPIO11_27_MASK(d->irq);
+		PWER &= ~BIT(d->hwirq);
 	return 0;
 }
 
@@ -392,7 +380,7 @@ void __init sa1100_init_irq(void)
 	/* Register IRQs 0-31 using a legacy irqdomain */
 	sc->domain = irq_domain_add_legacy(NULL, 32, 0, 0,
 					   &sa1100_sc_irqdomain_ops, sc);
-	sc->high_domain = irq_domain_add_legacy(NULL, 17, 32, 0,
+	sc->high_domain = irq_domain_add_legacy(NULL, 17, 32, 11,
 					   &sa1100_sc_high_irqdomain_ops, sc);
 	sa1100_init_gpio();
 }
-- 
1.8.3.1
