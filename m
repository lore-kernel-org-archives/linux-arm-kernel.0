From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 May 2012 08:38:20 +0100
Subject: [RFC PATCH 1/2] ARM: at91: use EOI flow control for interrupt handling
In-Reply-To: <1338449901-10288-1-git-send-email-will.deacon@arm.com>
References: <1338449901-10288-1-git-send-email-will.deacon@arm.com>
Message-ID: <1338449901-10288-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the at91 interrupt handling to use EOI flow control
in preparation for removing the irq_finish hook on ARM.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-at91/include/mach/irqs.h |    8 --------
 arch/arm/mach-at91/irq.c               |   12 +++++++++---
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
index ac8b7df..592cb43 100644
--- a/arch/arm/mach-at91/include/mach/irqs.h
+++ b/arch/arm/mach-at91/include/mach/irqs.h
@@ -26,14 +26,6 @@
 
 #define NR_AIC_IRQS 32
 
-
-/*
- * Acknowledge interrupt with AIC after interrupt has been handled.
- *   (by kernel/irq.c)
- */
-#define irq_finish(irq) do { at91_aic_write(AT91_AIC_EOICR, 0); } while (0)
-
-
 /*
  * IRQ interrupt symbols are the AT91xxx_ID_* symbols
  * for IRQs handled directly through the AIC, or else the AT91_PIN_*
diff --git a/arch/arm/mach-at91/irq.c b/arch/arm/mach-at91/irq.c
index cfcfcbe..3095fe0 100644
--- a/arch/arm/mach-at91/irq.c
+++ b/arch/arm/mach-at91/irq.c
@@ -55,6 +55,12 @@ static void at91_aic_unmask_irq(struct irq_data *d)
 	at91_aic_write(AT91_AIC_IECR, 1 << d->hwirq);
 }
 
+static void at91_aic_eoi_irq(struct irq_data *d)
+{
+	/* Mark end-of-interrupt on AIC */
+	at91_aic_write(AT91_AIC_EOICR, 1 << d->hwirq);
+}
+
 unsigned int at91_extern_irq;
 
 #define is_extern_irq(hwirq) ((1 << (hwirq)) & at91_extern_irq)
@@ -128,9 +134,9 @@ void at91_irq_resume(void)
 
 static struct irq_chip at91_aic_chip = {
 	.name		= "AIC",
-	.irq_ack	= at91_aic_mask_irq,
 	.irq_mask	= at91_aic_mask_irq,
 	.irq_unmask	= at91_aic_unmask_irq,
+	.irq_eoi	= at91_aic_eoi_irq,
 	.irq_set_type	= at91_aic_set_type,
 	.irq_set_wake	= at91_aic_set_wake,
 };
@@ -171,7 +177,7 @@ static int at91_aic_irq_map(struct irq_domain *h, unsigned int virq,
 	/* Active Low interrupt, without priority */
 	at91_aic_write(AT91_AIC_SMR(hw), AT91_AIC_SRCTYPE_LOW);
 
-	irq_set_chip_and_handler(virq, &at91_aic_chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &at91_aic_chip, handle_fasteoi_irq);
 	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);
 
 	return 0;
@@ -238,7 +244,7 @@ void __init at91_aic_init(unsigned int priority[NR_AIC_IRQS])
 		/* Active Low interrupt, with the specified priority */
 		at91_aic_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
 
-		irq_set_chip_and_handler(i, &at91_aic_chip, handle_level_irq);
+		irq_set_chip_and_handler(i, &at91_aic_chip, handle_fasteoi_irq);
 		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
 	}
 
-- 
1.7.3.4
