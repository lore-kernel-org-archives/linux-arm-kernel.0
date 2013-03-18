From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:51 +0100
Subject: [PATCH v3 5/9] ARM: SAMSUNG: convert to usage of *pmask_cache within
 irq_chip_type
In-Reply-To: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363615255-18200-6-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have now introduced pmask_cache within irq_chip_type to also
handle per-chip-type mask registers, convert samsung irq-vic-timer driver
to use this new pointer.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 arch/arm/plat-samsung/irq-vic-timer.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
index f980cf3..a37ded2 100644
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -37,9 +37,11 @@ static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
 static void s3c_irq_timer_ack(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_irq_chip_type(d);
+
 	u32 mask = (1 << 5) << (d->irq - gc->irq_base);
 
-	irq_reg_writel(mask | gc->mask_cache, gc->reg_base);
+	irq_reg_writel(mask | *ct->pmask_cache, gc->reg_base);
 }
 
 /**
@@ -89,7 +91,7 @@ void __init s3c_init_vic_timer_irq(unsigned int num, unsigned int timer_irq)
 	irq_setup_generic_chip(s3c_tgc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 	/* Clear the upper bits of the mask_cache*/
-	s3c_tgc->mask_cache &= 0x1f;
+	*ct->pmask_cache &= 0x1f;
 
 	for (i = 0; i < num; i++, timer_irq++) {
 		irq_set_chained_handler(pirq[i], s3c_irq_demux_vic_timer);
-- 
1.7.10.1
