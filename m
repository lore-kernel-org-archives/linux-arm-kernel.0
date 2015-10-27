From: kamal@canonical.com (Kamal Mostafa)
Date: Tue, 27 Oct 2015 14:29:54 -0700
Subject: [PATCH 3.19.y-ckt 54/86] irqchip/atmel-aic5: Use per chip mask caches
 in mask/unmask()
In-Reply-To: <1445981426-19727-1-git-send-email-kamal@canonical.com>
References: <1445981426-19727-1-git-send-email-kamal@canonical.com>
Message-ID: <1445981426-19727-55-git-send-email-kamal@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

3.19.8-ckt9 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ludovic Desroches <ludovic.desroches@atmel.com>

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
