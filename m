From: kamal@canonical.com (Kamal Mostafa)
Date: Mon, 26 Oct 2015 14:14:34 -0700
Subject: [3.16.y-ckt stable] Patch "irqchip/atmel-aic5: Use per chip mask
 caches in mask/unmask()" has been added to staging queue
Message-ID: <1445894074-1191-1-git-send-email-kamal@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    irqchip/atmel-aic5: Use per chip mask caches in mask/unmask()

to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree 
which can be found at:

    http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=linux-3.16.y-queue

This patch is scheduled to be released in version 3.19.8-ckt9.

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.16.y-ckt tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Kamal

------

>From 91631f5d71ee5f728703349d96d09080e46cae0a Mon Sep 17 00:00:00 2001
From: Ludovic Desroches <ludovic.desroches@atmel.com>
Date: Mon, 21 Sep 2015 15:46:04 +0200
Subject: irqchip/atmel-aic5: Use per chip mask caches in mask/unmask()

commit d32dc9aa10c739363c775baf4499416b2e0dc11f upstream.

When masking/unmasking interrupts, mask_cache is updated and used later
for suspend/resume. Unfortunately, it always was the mask_cache
associated with the first irq chip which was updated. So when performing
resume, only irqs 0-31 could be enabled.

Fixes: b1479ebb7720 ("irqchip: atmel-aic: Add atmel AIC/AIC5 drivers")
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: <sasha.levin@oracle.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <nicolas.ferre@atmel.com>
Cc: <alexandre.belloni@free-electrons.com>
Cc: <boris.brezillon@free-electrons.com>
Cc: <Wenyou.Yang@atmel.com>
Cc: <jason@lakedaemon.net>
Cc: <marc.zyngier@arm.com>
Link: http://lkml.kernel.org/r/1442843173-2390-1-git-send-email-ludovic.desroches at atmel.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 drivers/irqchip/irq-atmel-aic5.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index a2e8c3f..c2c578f 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -88,28 +88,36 @@ static void aic5_mask(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
 	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *gc = dgc->gc[0];
+	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);

-	/* Disable interrupt on AIC5 */
-	irq_gc_lock(gc);
+	/*
+	 * Disable interrupt on AIC5. We always take the lock of the
+	 * first irq chip as all chips share the same registers.
+	 */
+	irq_gc_lock(bgc);
 	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
 	irq_reg_writel(gc, 1, AT91_AIC5_IDCR);
 	gc->mask_cache &= ~d->mask;
-	irq_gc_unlock(gc);
+	irq_gc_unlock(bgc);
 }

 static void aic5_unmask(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
 	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *gc = dgc->gc[0];
+	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);

-	/* Enable interrupt on AIC5 */
-	irq_gc_lock(gc);
+	/*
+	 * Enable interrupt on AIC5. We always take the lock of the
+	 * first irq chip as all chips share the same registers.
+	 */
+	irq_gc_lock(bgc);
 	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
 	irq_reg_writel(gc, 1, AT91_AIC5_IECR);
 	gc->mask_cache |= d->mask;
-	irq_gc_unlock(gc);
+	irq_gc_unlock(bgc);
 }

 static int aic5_retrigger(struct irq_data *d)
--
1.9.1
