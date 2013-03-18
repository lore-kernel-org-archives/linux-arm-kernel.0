From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Mon, 18 Mar 2013 15:00:48 +0100
Subject: [PATCH v3 2/9] genirq: add mask_cache and pmask_cache into struct
 irq_chip_type
In-Reply-To: <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363615255-18200-3-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Today the same interrupt mask cache (stored within struct irq_chip_generic)
is shared between all the irq_chip_type instances. As there are instances
where each irq_chip_type uses a distinct mask register (as it is the case
for Orion SoCs), sharing a single mask cache may be incorrect.
So add a distinct pointer for each irq_chip_type, which for now
points to the original mask register within irq_chip_generic.
So no functional changes here.

Reported-by: Joey Oravec <joravec@drewtech.com>
Signed-off-by: Simon Guinot <sguinot@lacie.com>
Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 include/linux/irq.h       |    4 ++++
 kernel/irq/generic-chip.c |   16 ++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index fdf2c4a..05d7fbd 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -636,6 +636,8 @@ struct irq_chip_regs {
  * @regs:		Register offsets for this chip
  * @handler:		Flow handler associated with this chip
  * @type:		Chip can handle these flow types
+ * @mask_cache:		Cached mask register
+ * @pmask_cache:	Pointer to cached mask register
  *
  * A irq_generic_chip can have several instances of irq_chip_type when
  * it requires different functions and register offsets for different
@@ -646,6 +648,8 @@ struct irq_chip_type {
 	struct irq_chip_regs	regs;
 	irq_flow_handler_t	handler;
 	u32			type;
+	u32			mask_cache;
+	u32			*pmask_cache;
 };
 
 /**
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 0e6ba78..c8ec24d 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -39,7 +39,7 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	irq_reg_writel(mask, gc->reg_base + ct->regs.disable);
-	gc->mask_cache &= ~mask;
+	*ct->pmask_cache &= ~mask;
 	irq_gc_unlock(gc);
 }
 
@@ -57,8 +57,8 @@ void irq_gc_mask_set_bit(struct irq_data *d)
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache |= mask;
-	irq_reg_writel(gc->mask_cache, gc->reg_base + ct->regs.mask);
+	*ct->pmask_cache |= mask;
+	irq_reg_writel(*ct->pmask_cache, gc->reg_base + ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 
@@ -76,8 +76,8 @@ void irq_gc_mask_clr_bit(struct irq_data *d)
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	irq_reg_writel(gc->mask_cache, gc->reg_base + ct->regs.mask);
+	*ct->pmask_cache &= ~mask;
+	irq_reg_writel(*ct->pmask_cache, gc->reg_base + ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 
@@ -96,7 +96,7 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	irq_reg_writel(mask, gc->reg_base + ct->regs.enable);
-	gc->mask_cache |= mask;
+	*ct->pmask_cache |= mask;
 	irq_gc_unlock(gc);
 }
 
@@ -250,6 +250,10 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
 	if (flags & IRQ_GC_INIT_MASK_CACHE)
 		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
 
+	/* Initialize mask cache pointer */
+	for (i = 0; i < gc->num_ct; i++)
+		ct[i].pmask_cache = &gc->mask_cache;
+
 	for (i = gc->irq_base; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))
 			continue;
-- 
1.7.10.1
