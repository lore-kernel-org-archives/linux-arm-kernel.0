From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 21 Sep 2015 15:46:04 +0200
Subject: [PATCH 1/3] irqchip: atmel-aic5: fix bug with mask/unmask
Message-ID: <1442843173-2390-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When masking/unmasking interrupts, mask_cache is updated and used later
for suspend/resume. Unfortunately, it always was the mask_cache
associated with the first irq chip which was updated. So when performing
resume, only irqs 0-31 could be enabled and maybe not the good ones!

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: b1479ebb7720 ("irqchip: atmel-aic: Add atmel AIC/AIC5 drivers")
Cc: stable at vger.kernel.org #3.18
---

Sasha,

This fix won't apply without conflicts because of irq_reg_writel changes. I
can provide you a fix for 3.18 if you need.

Regards

Ludovic


 drivers/irqchip/irq-atmel-aic5.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 9da9942..6c5fd25 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -88,28 +88,30 @@ static void aic5_mask(struct irq_data *d)
 {
 	struct irq_domain *domain = d->domain;
 	struct irq_domain_chip_generic *dgc = domain->gc;
-	struct irq_chip_generic *gc = dgc->gc[0];
+	struct irq_chip_generic *bgc = dgc->gc[0];
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
 	/* Disable interrupt on AIC5 */
-	irq_gc_lock(gc);
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
 
 	/* Enable interrupt on AIC5 */
-	irq_gc_lock(gc);
+	irq_gc_lock(bgc);
 	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
 	irq_reg_writel(gc, 1, AT91_AIC5_IECR);
 	gc->mask_cache |= d->mask;
-	irq_gc_unlock(gc);
+	irq_gc_unlock(bgc);
 }
 
 static int aic5_retrigger(struct irq_data *d)
-- 
2.5.0
