From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 31 May 2012 16:31:44 +0200
Subject: [PATCH v2] ARM: at91: aic can use fast eoi handler type
Message-ID: <1338474704-16665-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The Advanced Interrupt Controller allows to use the fast EOI handler type.
It lets remove the Atmel specific workaround into arch/arm/kernel/irq.c used
to indicate to the AIC the end of the interrupt treatment.
Removing irq_finish from handle_IRQ involves to manage it in the gpio irq
handler.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi,

This patch removes the at91 workaround from handle_IRQ.

I tested it on at91sam9m10g45 but if you see some potential issues please let
me know.

v2:
- remove stuff which is no more used thanks to Will's patch: irq_finish macro,
irq_ack.
- gpio controller was using irq_ack instead of irq_mask.
- gpio irq handler has to mark the end of interrupt since it is no more done
in handle_IRQ.

 arch/arm/kernel/irq.c                  |   10 ----------
 arch/arm/mach-at91/gpio.c              |    3 ++-
 arch/arm/mach-at91/include/mach/irqs.h |    7 -------
 arch/arm/mach-at91/irq.c               |   15 ++++++++++++---
 4 files changed, 14 insertions(+), 21 deletions(-)

Regards

Ludovic

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 71ccdbf..3e50d71 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -40,13 +40,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
-/*
- * No architecture-specific irq_finish function defined in arm/arch/irqs.h.
- */
-#ifndef irq_finish
-#define irq_finish(irq) do { } while (0)
-#endif
-
 unsigned long irq_err_count;
 
 int arch_show_interrupts(struct seq_file *p, int prec)
@@ -85,9 +78,6 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 		generic_handle_irq(irq);
 	}
 
-	/* AT91 specific workaround */
-	irq_finish(irq);
-
 	irq_exit();
 	set_irq_regs(old_regs);
 }
diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index 325837a..a8bd715 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -593,7 +593,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 	int		n;
 
 	/* temporarily mask (level sensitive) parent IRQ */
-	chip->irq_ack(idata);
+	chip->irq_mask(idata);
 	for (;;) {
 		/* Reading ISR acks pending (edge triggered) GPIO interrupts.
 		 * When there none are pending, we're finished unless we need
@@ -614,6 +614,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 			n = find_next_bit(&isr, BITS_PER_LONG, n + 1);
 		}
 	}
+	chip->irq_eoi(idata);
 	chip->irq_unmask(idata);
 	/* now it may re-trigger */
 }
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
index 601b4ee..3aa18a6 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -55,6 +55,15 @@ static void at91_aic_unmask_irq(struct irq_data *d)
 	at91_aic_write(AT91_AIC_IECR, 1 << d->hwirq);
 }
 
+static void at91_aic_eoi(struct irq_data *d)
+{
+	/*
+	 * Mark end-of-interrupt on AIC, the controller doesn't care about
+	 * the value written in this register.
+	 */
+	at91_aic_write(AT91_AIC_EOICR, 0);
+}
+
 unsigned int at91_extern_irq;
 
 #define is_extern_irq(hwirq) ((1 << (hwirq)) & at91_extern_irq)
@@ -128,11 +137,11 @@ void at91_irq_resume(void)
 
 static struct irq_chip at91_aic_chip = {
 	.name		= "AIC",
-	.irq_ack	= at91_aic_mask_irq,
 	.irq_mask	= at91_aic_mask_irq,
 	.irq_unmask	= at91_aic_unmask_irq,
 	.irq_set_type	= at91_aic_set_type,
 	.irq_set_wake	= at91_aic_set_wake,
+	.irq_eoi	= at91_aic_eoi,
 };
 
 static void __init at91_aic_hw_init(unsigned int spu_vector)
@@ -171,7 +180,7 @@ static int at91_aic_irq_map(struct irq_domain *h, unsigned int virq,
 	/* Active Low interrupt, without priority */
 	at91_aic_write(AT91_AIC_SMR(hw), AT91_AIC_SRCTYPE_LOW);
 
-	irq_set_chip_and_handler(virq, &at91_aic_chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &at91_aic_chip, handle_fasteoi_irq);
 	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
 
 	return 0;
@@ -271,7 +280,7 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 		/* Active Low interrupt, with the specified priority */
 		at91_aic_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
 
-		irq_set_chip_and_handler(i, &at91_aic_chip, handle_level_irq);
+		irq_set_chip_and_handler(i, &at91_aic_chip, handle_fasteoi_irq);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
 
-- 
1.7.5.4
