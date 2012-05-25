From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 25 May 2012 14:55:11 +0200
Subject: [PATCH] ARM: at91: aic can use fast eoi handler type
Message-ID: <1337950511-2049-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The Advanced Interrupt Controller allows to use the fast EOI handler type.
It lets remove the Atmel specific workaround into arch/arm/kernel/irq.c used
to indicate to the AIC the end of the interrupt treatment.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/kernel/irq.c                  |    3 ---
 arch/arm/mach-at91/gpio.c              |   10 ++++++++--
 arch/arm/mach-at91/include/mach/irqs.h |    7 -------
 arch/arm/mach-at91/irq.c               |   10 ++++++++--
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 71ccdbf..6236d1a 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -85,9 +85,6 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 		generic_handle_irq(irq);
 	}
 
-	/* AT91 specific workaround */
-	irq_finish(irq);
-
 	irq_exit();
 	set_irq_regs(old_regs);
 }
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 325837a..ee38e6d 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -520,6 +520,11 @@ static void gpio_irq_unmask(struct irq_data *d)
 		__raw_writel(mask, pio + PIO_IER);
 }
 
+static void gpio_irq_eoi(struct irq_data *d)
+{
+	at91_aic_write(AT91_AIC_EOICR, 0);
+}
+
 static int gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	switch (type) {
@@ -581,6 +586,7 @@ static struct irq_chip gpio_irqchip = {
 	.irq_unmask	= gpio_irq_unmask,
 	/* .irq_set_type is set dynamically */
 	.irq_set_wake	= gpio_irq_set_wake,
+	.irq_eoi	= gpio_irq_eoi,
 };
 
 static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
@@ -725,7 +731,7 @@ static int at91_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 	 * shorter, and the AIC handles interrupts sanely.
 	 */
 	irq_set_chip_and_handler(virq, &gpio_irqchip,
-				 handle_simple_irq);
+				 handle_fasteoi_irq);
 	set_irq_flags(virq, IRQF_VALID);
 	irq_set_chip_data(virq, at91_gpio);
 
@@ -839,7 +845,7 @@ void __init at91_gpio_irq_setup(void)
 			 * shorter, and the AIC handles interrupts sanely.
 			 */
 			irq_set_chip_and_handler(virq, &gpio_irqchip,
-						 handle_simple_irq);
+						 handle_fasteoi_irq);
 			set_irq_flags(virq, IRQF_VALID);
 			irq_set_chip_data(virq, this);
 
diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
index ac8b7df..2d510ee 100644
--- a/arch/arm/mach-at91/include/mach/irqs.h
+++ b/arch/arm/mach-at91/include/mach/irqs.h
@@ -28,13 +28,6 @@
 
 
 /*
- * Acknowledge interrupt with AIC after interrupt has been handled.
- *   (by kernel/irq.c)
- */
-#define irq_finish(irq) do { at91_aic_write(AT91_AIC_EOICR, 0); } while (0)
-
-
-/*
  * IRQ interrupt symbols are the AT91xxx_ID_* symbols
  * for IRQs handled directly through the AIC, or else the AT91_PIN_*
  * symbols in gpio.h for ones handled indirectly as GPIOs.
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index 601b4ee..40714f1 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -55,6 +55,11 @@ static void at91_aic_unmask_irq(struct irq_data *d)
 	at91_aic_write(AT91_AIC_IECR, 1 << d->hwirq);
 }
 
+static void at91_aic_eoi(struct irq_data *d)
+{
+	at91_aic_write(AT91_AIC_EOICR, 0);
+}
+
 unsigned int at91_extern_irq;
 
 #define is_extern_irq(hwirq) ((1 << (hwirq)) & at91_extern_irq)
@@ -133,6 +138,7 @@ static struct irq_chip at91_aic_chip = {
 	.irq_unmask	= at91_aic_unmask_irq,
 	.irq_set_type	= at91_aic_set_type,
 	.irq_set_wake	= at91_aic_set_wake,
+	.irq_eoi	= at91_aic_eoi,
 };
 
 static void __init at91_aic_hw_init(unsigned int spu_vector)
@@ -171,7 +177,7 @@ static int at91_aic_irq_map(struct irq_domain *h, unsigned int virq,
 	/* Active Low interrupt, without priority */
 	at91_aic_write(AT91_AIC_SMR(hw), AT91_AIC_SRCTYPE_LOW);
 
-	irq_set_chip_and_handler(virq, &at91_aic_chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &at91_aic_chip, handle_fasteoi_irq);
 	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
 
 	return 0;
@@ -271,7 +277,7 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 		/* Active Low interrupt, with the specified priority */
 		at91_aic_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
 
-		irq_set_chip_and_handler(i, &at91_aic_chip, handle_level_irq);
+		irq_set_chip_and_handler(i, &at91_aic_chip, handle_fasteoi_irq);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
 
-- 
1.7.5.4
