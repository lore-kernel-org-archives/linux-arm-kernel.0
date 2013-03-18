From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:52 +0100
Subject: [PATCH v3 6/9] genirq: rename mask_cache to shared_mask_cache
In-Reply-To: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363615255-18200-7-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

after introducing pmask_cached pointer within irq_chip_type, rename
mask_cache into shared_mask_cache so to state clearly that drivers
should not use it anymore, but should only access *pmask_cache from
irq_chip_type instead.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 include/linux/irq.h       |    4 ++--
 kernel/irq/generic-chip.c |    5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 05d7fbd..5aca310 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -658,7 +658,7 @@ struct irq_chip_type {
  * @reg_base:		Register base address (virtual)
  * @irq_base:		Interrupt base nr for this chip
  * @irq_cnt:		Number of interrupts handled by this chip
- * @mask_cache:		Cached mask register
+ * @shared_mask_cache:	Cached mask register shared among all irq_chip_type's
  * @type_cache:		Cached type register
  * @polarity_cache:	Cached polarity register
  * @wake_enabled:	Interrupt can wakeup from suspend
@@ -679,7 +679,7 @@ struct irq_chip_generic {
 	void __iomem		*reg_base;
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
-	u32			mask_cache;
+	u32			shared_mask_cache;
 	u32			type_cache;
 	u32			polarity_cache;
 	u32			wake_enabled;
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index c8ec24d..b5cb991 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -248,11 +248,12 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
 
 	/* Init mask cache ? */
 	if (flags & IRQ_GC_INIT_MASK_CACHE)
-		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
+		gc->shared_mask_cache =
+			irq_reg_readl(gc->reg_base + ct->regs.mask);
 
 	/* Initialize mask cache pointer */
 	for (i = 0; i < gc->num_ct; i++)
-		ct[i].pmask_cache = &gc->mask_cache;
+		ct[i].pmask_cache = &gc->shared_mask_cache;
 
 	for (i = gc->irq_base; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))
-- 
1.7.10.1
