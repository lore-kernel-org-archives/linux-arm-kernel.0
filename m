From: avictor.za@gmail.com (Andrew Victor)
Date: Wed, 27 Apr 2011 15:09:02 +0200
Subject: AT91: Convert to fasteoi IRQ handler, and remove ARM irq_finish
Message-ID: <1303909742.18407.12.camel@redbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT91's AIC interrupt controller will internally mask the current
(and lower-priority) interrupts until software acknowledges that the
interrupt was handled by writing to the AIC_EOICR register.

This matches the "fasteoi" IRQ flow-handler, so convert the AT91 to use
handle_fasteoi_irq rather than handle_level_irq.

This also allows the irq_finish() call to be removed from the low-level
ARM IRQ handler.


Signed-off-by: Andrew Victor <linux@maxim.org.za>



diff -urN -x CVS linux-2.6.38/arch/arm/kernel/irq.c linux-2.6/arch/arm/kernel/irq.c
--- linux-2.6.38/arch/arm/kernel/irq.c	2011-04-27 12:28:25.609111745 +0200
+++ linux-2.6/arch/arm/kernel/irq.c	2011-04-27 14:20:32.784167994 +0200
@@ -42,13 +42,6 @@
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
 
 int show_interrupts(struct seq_file *p, void *v)
@@ -135,9 +128,6 @@
 		generic_handle_irq(irq);
 	}
 
-	/* AT91 specific workaround */
-	irq_finish(irq);
-
 	irq_exit();
 	set_irq_regs(old_regs);
 }
diff -urN -x CVS linux-2.6.38/arch/arm/mach-at91/gpio.c linux-2.6/arch/arm/mach-at91/gpio.c
--- linux-2.6.38/arch/arm/mach-at91/gpio.c	2011-04-27 12:28:26.157080664 +0200
+++ linux-2.6/arch/arm/mach-at91/gpio.c	2011-04-27 14:45:42.672364605 +0200
@@ -392,8 +392,6 @@
 	at91_gpio = get_irq_chip_data(irq);
 	pio = at91_gpio->regbase;
 
-	/* temporarily mask (level sensitive) parent IRQ */
-	desc->irq_data.chip->irq_ack(&desc->irq_data);
 	for (;;) {
 		/* Reading ISR acks pending (edge triggered) GPIO interrupts.
 		 * When there none are pending, we're finished unless we need
@@ -429,8 +427,8 @@
 			isr >>= 1;
 		}
 	}
-	desc->irq_data.chip->irq_unmask(&desc->irq_data);
-	/* now it may re-trigger */
+	/* acknowledge interrupt - now it may re-trigger */
+	desc->irq_data.chip->irq_eoi(&desc->irq_data);
 }
 
 /*--------------------------------------------------------------------------*/
diff -urN -x CVS linux-2.6.38/arch/arm/mach-at91/include/mach/irqs.h linux-2.6/arch/arm/mach-at91/include/mach/irqs.h
--- linux-2.6.38/arch/arm/mach-at91/include/mach/irqs.h	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6/arch/arm/mach-at91/include/mach/irqs.h	2011-04-27 14:20:48.471334804 +0200
@@ -28,13 +28,6 @@
 
 
 /*
- * Acknowledge interrupt with AIC after interrupt has been handled.
- *   (by kernel/irq.c)
- */
-#define irq_finish(irq) do { at91_sys_write(AT91_AIC_EOICR, 0); } while (0)
-
-
-/*
  * IRQ interrupt symbols are the AT91xxx_ID_* symbols
  * for IRQs handled directly through the AIC, or else the AT91_PIN_*
  * symbols in gpio.h for ones handled indirectly as GPIOs.
diff -urN -x CVS linux-2.6.38/arch/arm/mach-at91/irq.c linux-2.6/arch/arm/mach-at91/irq.c
--- linux-2.6.38/arch/arm/mach-at91/irq.c	2011-04-27 12:28:26.197078404 +0200
+++ linux-2.6/arch/arm/mach-at91/irq.c	2011-04-27 14:23:29.817625842 +0200
@@ -46,6 +46,12 @@
 	at91_sys_write(AT91_AIC_IECR, 1 << d->irq);
 }
 
+static void at91_aic_eoi(struct irq_data *d)
+{
+	/* Acknowledge with AIC after interrupt has been handled */
+	at91_sys_write(AT91_AIC_EOICR, 0);	
+}
+
 unsigned int at91_extern_irq;
 
 #define is_extern_irq(irq) ((1 << (irq)) & at91_extern_irq)
@@ -122,6 +128,7 @@
 	.irq_ack	= at91_aic_mask_irq,
 	.irq_mask	= at91_aic_mask_irq,
 	.irq_unmask	= at91_aic_unmask_irq,
+	.irq_eoi	= at91_aic_eoi,
 	.irq_set_type	= at91_aic_set_type,
 	.irq_set_wake	= at91_aic_set_wake,
 };
@@ -144,7 +151,7 @@
 		at91_sys_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
 
 		set_irq_chip(i, &at91_aic_chip);
-		set_irq_handler(i, handle_level_irq);
+		set_irq_handler(i, handle_fasteoi_irq);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 
 		/* Perform 8 End Of Interrupt Command to make sure AIC will not Lock out nIRQ */
