From: simon@sequanux.org (Simon Guinot)
Date: Fri, 22 Jul 2011 02:49:18 +0200
Subject: [PATCH] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <20110720234537.GD16297@kw.sim.vm.gnt>
References: <20110720234537.GD16297@kw.sim.vm.gnt>
Message-ID: <1311295758-27493-1-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <sguinot@lacie.com>

This fixes a regression introduced by e59347a
"arm: orion: Use generic irq chip".

The same interrupt mask cache (stored within struct irq_chip_generic)
is shared between all the irq_chip_type instances. As each irq_chip_type
can use a distinct mask register, share a single mask cache is not
correct. This bug affects Orion SoCs, which have separate mask registers
for edge and level interrupts.

This patch move mask_cache from struct irq_chip_generic into struct
irq_chip_type. Note that the interrupt support for Samsung SoCs is also
slightly affected.

Reported-by: Joey Oravec <joravec@drewtech.com>
Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 arch/arm/plat-samsung/irq-vic-timer.c |    6 +++-
 include/linux/irq.h                   |    4 +-
 kernel/irq/generic-chip.c             |   38 +++++++++++++++++++-------------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-samsung/irq-vic-timer.c b/arch/arm/plat-samsung/irq-vic-timer.c
index f714d06..3bb0b26 100644
--- a/arch/arm/plat-samsung/irq-vic-timer.c
+++ b/arch/arm/plat-samsung/irq-vic-timer.c
@@ -31,9 +31,11 @@ static void s3c_irq_demux_vic_timer(unsigned int irq, struct irq_desc *desc)
 static void s3c_irq_timer_ack(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = gc->chip_types;
+
 	u32 mask = (1 << 5) << (d->irq - gc->irq_base);
 
-	irq_reg_writel(mask | gc->mask_cache, gc->reg_base);
+	irq_reg_writel(mask | ct->mask_cache, gc->reg_base);
 }
 
 /**
@@ -68,7 +70,7 @@ void __init s3c_init_vic_timer_irq(unsigned int num, unsigned int timer_irq)
 	irq_setup_generic_chip(s3c_tgc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 	/* Clear the upper bits of the mask_cache*/
-	s3c_tgc->mask_cache &= 0x1f;
+	ct->mask_cache &= 0x1f;
 
 	for (i = 0; i < num; i++, timer_irq++) {
 		irq_set_chained_handler(pirq[i], s3c_irq_demux_vic_timer);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index baa397e..5e5208e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -608,6 +608,7 @@ struct irq_chip_regs {
  * @regs:		Register offsets for this chip
  * @handler:		Flow handler associated with this chip
  * @type:		Chip can handle these flow types
+ * @mask_cache:		Cached mask register
  *
  * A irq_generic_chip can have several instances of irq_chip_type when
  * it requires different functions and register offsets for different
@@ -618,6 +619,7 @@ struct irq_chip_type {
 	struct irq_chip_regs	regs;
 	irq_flow_handler_t	handler;
 	u32			type;
+	u32			mask_cache;
 };
 
 /**
@@ -626,7 +628,6 @@ struct irq_chip_type {
  * @reg_base:		Register base address (virtual)
  * @irq_base:		Interrupt base nr for this chip
  * @irq_cnt:		Number of interrupts handled by this chip
- * @mask_cache:		Cached mask register
  * @type_cache:		Cached type register
  * @polarity_cache:	Cached polarity register
  * @wake_enabled:	Interrupt can wakeup from suspend
@@ -647,7 +648,6 @@ struct irq_chip_generic {
 	void __iomem		*reg_base;
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
-	u32			mask_cache;
 	u32			type_cache;
 	u32			polarity_cache;
 	u32			wake_enabled;
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 3a2cab4..e7d5c13 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -15,9 +15,9 @@
 static LIST_HEAD(gc_list);
 static DEFINE_RAW_SPINLOCK(gc_lock);
 
-static inline struct irq_chip_regs *cur_regs(struct irq_data *d)
+static inline struct irq_chip_type *to_irq_chip_type(struct irq_data *d)
 {
-	return &container_of(d->chip, struct irq_chip_type, chip)->regs;
+	return container_of(d->chip, struct irq_chip_type, chip);
 }
 
 /**
@@ -38,11 +38,12 @@ void irq_gc_noop(struct irq_data *d)
 void irq_gc_mask_disable_reg(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = to_irq_chip_type(d);
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->disable);
-	gc->mask_cache &= ~mask;
+	irq_reg_writel(mask, gc->reg_base + ct->regs.disable);
+	ct->mask_cache &= ~mask;
 	irq_gc_unlock(gc);
 }
 
@@ -56,11 +57,12 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
 void irq_gc_mask_set_bit(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = to_irq_chip_type(d);
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache |= mask;
-	irq_reg_writel(gc->mask_cache, gc->reg_base + cur_regs(d)->mask);
+	ct->mask_cache |= mask;
+	irq_reg_writel(ct->mask_cache, gc->reg_base + ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 
@@ -74,11 +76,12 @@ void irq_gc_mask_set_bit(struct irq_data *d)
 void irq_gc_mask_clr_bit(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = to_irq_chip_type(d);
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	irq_reg_writel(gc->mask_cache, gc->reg_base + cur_regs(d)->mask);
+	ct->mask_cache &= ~mask;
+	irq_reg_writel(ct->mask_cache, gc->reg_base + ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 
@@ -92,11 +95,12 @@ void irq_gc_mask_clr_bit(struct irq_data *d)
 void irq_gc_unmask_enable_reg(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = to_irq_chip_type(d);
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->enable);
-	gc->mask_cache |= mask;
+	irq_reg_writel(mask, gc->reg_base + ct->regs.enable);
+	ct->mask_cache |= mask;
 	irq_gc_unlock(gc);
 }
 
@@ -110,7 +114,7 @@ void irq_gc_ack_set_bit(struct irq_data *d)
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->ack);
+	irq_reg_writel(mask, gc->reg_base + to_irq_chip_type(d)->regs.ack);
 	irq_gc_unlock(gc);
 }
 
@@ -124,7 +128,7 @@ void irq_gc_ack_clr_bit(struct irq_data *d)
 	u32 mask = ~(1 << (d->irq - gc->irq_base));
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->ack);
+	irq_reg_writel(mask, gc->reg_base + to_irq_chip_type(d)->regs.ack);
 	irq_gc_unlock(gc);
 }
 
@@ -138,8 +142,8 @@ void irq_gc_mask_disable_reg_and_ack(struct irq_data *d)
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->mask);
-	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->ack);
+	irq_reg_writel(mask, gc->reg_base + to_irq_chip_type(d)->regs.mask);
+	irq_reg_writel(mask, gc->reg_base + to_irq_chip_type(d)->regs.ack);
 	irq_gc_unlock(gc);
 }
 
@@ -153,7 +157,7 @@ void irq_gc_eoi(struct irq_data *d)
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + cur_regs(d)->eoi);
+	irq_reg_writel(mask, gc->reg_base + to_irq_chip_type(d)->regs.eoi);
 	irq_gc_unlock(gc);
 }
 
@@ -243,7 +247,9 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
 
 	/* Init mask cache ? */
 	if (flags & IRQ_GC_INIT_MASK_CACHE)
-		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
+		for (i = 0; i < gc->num_ct; i++)
+			ct[i].mask_cache =
+				irq_reg_readl(gc->reg_base + ct[i].regs.mask);
 
 	for (i = gc->irq_base; msk; msk >>= 1, i++) {
 		if (!msk & 0x01)
-- 
1.7.5.1
