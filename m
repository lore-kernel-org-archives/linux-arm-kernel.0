From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Fri, 15 Mar 2013 20:36:15 +0100
Subject: [PATCH 2/2] genirq: move mask_cache into struct irq_chip_type
In-Reply-To: <1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363376175-22312-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <1363376175-22312-3-git-send-email-gerlando.falauto@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a regression introduced by e59347a
"arm: orion: Use generic irq chip".

The same interrupt mask cache (stored within struct irq_chip_generic)
is shared between all the irq_chip_type instances. As each irq_chip_type
can use a distinct mask register, sharing a single mask cache may not be
correct. For instance in the case of Orion SoCs, which have separate
mask registers for edge and level interrupts.

This patch moves mask_cache from struct irq_chip_generic into struct
irq_chip_type. Note that the interrupt support for Samsung SoCs is also
slightly affected.

Since there are also cases where all irq_chip_type instances share a
common mask register, introduce a pointer to the mask register cache and
a new flag IRQ_GC_SEPARATE_MASK_REGISTERS to explicitly enable this separate
treatment. When this flag is not set, pointers for all irq_chip_type
instances point to the the mask register for the first instance so
essentially the old behavior is retained.

Reported-by: Joey Oravec <joravec@drewtech.com>
Signed-off-by: Simon Guinot <sguinot@lacie.com>
Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
---
 arch/arm/plat-orion/gpio.c            |    3 ++-
 arch/arm/plat-samsung/irq-vic-timer.c |    6 ++++--
 arch/mips/jz4740/irq.c                |    3 ++-
 drivers/gpio/gpio-mvebu.c             |   23 ++++++++++++++---------
 include/linux/irq.h                   |    7 +++++--
 kernel/irq/generic-chip.c             |   30 +++++++++++++++++++++---------
 6 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index c29ee7e..a4dc04a 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -522,7 +522,8 @@ void __init orion_gpio_init(struct device_node *np,
 	ct->handler = handle_edge_irq;
 	ct->chip.name = ochip->chip.label;
 
-	irq_setup_generic_chip(gc, IRQ_MSK(ngpio), IRQ_GC_INIT_MASK_CACHE,
+	irq_setup_generic_chip(gc, IRQ_MSK(ngpio), IRQ_GC_INIT_MASK_CACHE |
+			       IRQ_GC_SEPARATE_MASK_REGISTERS,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 
 	/* Setup irq domain on top of the generic chip. */
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
diff --git a/arch/mips/jz4740/irq.c b/arch/mips/jz4740/irq.c
index fc57ded..228ee33 100644
--- a/arch/mips/jz4740/irq.c
+++ b/arch/mips/jz4740/irq.c
@@ -68,7 +68,8 @@ void jz4740_irq_suspend(struct irq_data *data)
 void jz4740_irq_resume(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	jz4740_irq_set_mask(gc, gc->mask_cache);
+	struct irq_chip_type *ct = irq_data_get_irq_chip_type(data);
+	jz4740_irq_set_mask(gc, *ct->pmask_cache);
 }
 
 static struct irqaction jz4740_cascade_action = {
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6819d63..31ae5c4 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -301,48 +301,52 @@ static void mvebu_gpio_irq_ack(struct irq_data *d)
 static void mvebu_gpio_edge_irq_mask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
+	*ct->pmask_cache &= ~mask;
+	writel_relaxed(*ct->pmask_cache, mvebu_gpioreg_edge_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_edge_irq_unmask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache |= mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_edge_mask(mvchip));
+	*ct->pmask_cache |= mask;
+	writel_relaxed(*ct->pmask_cache, mvebu_gpioreg_edge_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_level_irq_mask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache &= ~mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_level_mask(mvchip));
+	*ct->pmask_cache &= ~mask;
+	writel_relaxed(*ct->pmask_cache, mvebu_gpioreg_level_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
 static void mvebu_gpio_level_irq_unmask(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct mvebu_gpio_chip *mvchip = gc->private;
 	u32 mask = 1 << (d->irq - gc->irq_base);
 
 	irq_gc_lock(gc);
-	gc->mask_cache |= mask;
-	writel_relaxed(gc->mask_cache, mvebu_gpioreg_level_mask(mvchip));
+	*ct->pmask_cache |= mask;
+	writel_relaxed(*ct->pmask_cache, mvebu_gpioreg_level_mask(mvchip));
 	irq_gc_unlock(gc);
 }
 
@@ -649,7 +653,8 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	ct->handler = handle_edge_irq;
 	ct->chip.name = mvchip->chip.label;
 
-	irq_setup_generic_chip(gc, IRQ_MSK(ngpios), 0,
+	irq_setup_generic_chip(gc, IRQ_MSK(ngpios),
+			       IRQ_GC_SEPARATE_MASK_REGISTERS,
 			       IRQ_NOREQUEST, IRQ_LEVEL | IRQ_NOPROBE);
 
 	/* Setup irq domain on top of the generic chip. */
diff --git a/include/linux/irq.h b/include/linux/irq.h
index fdf2c4a..063fffb 100644
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
@@ -654,7 +658,6 @@ struct irq_chip_type {
  * @reg_base:		Register base address (virtual)
  * @irq_base:		Interrupt base nr for this chip
  * @irq_cnt:		Number of interrupts handled by this chip
- * @mask_cache:		Cached mask register
  * @type_cache:		Cached type register
  * @polarity_cache:	Cached polarity register
  * @wake_enabled:	Interrupt can wakeup from suspend
@@ -675,7 +678,6 @@ struct irq_chip_generic {
 	void __iomem		*reg_base;
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
-	u32			mask_cache;
 	u32			type_cache;
 	u32			polarity_cache;
 	u32			wake_enabled;
@@ -696,6 +698,7 @@ struct irq_chip_generic {
 enum irq_gc_flags {
 	IRQ_GC_INIT_MASK_CACHE		= 1 << 0,
 	IRQ_GC_INIT_NESTED_LOCK		= 1 << 1,
+	IRQ_GC_SEPARATE_MASK_REGISTERS  = 1 << 2,
 };
 
 /* Generic chip callback functions */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 0e6ba78..3daeed3 100644
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
 
@@ -246,9 +246,21 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
 	list_add_tail(&gc->list, &gc_list);
 	raw_spin_unlock(&gc_lock);
 
-	/* Init mask cache ? */
-	if (flags & IRQ_GC_INIT_MASK_CACHE)
-		gc->mask_cache = irq_reg_readl(gc->reg_base + ct->regs.mask);
+	for (i = 0; i < gc->num_ct; i++) {
+		if (flags & IRQ_GC_SEPARATE_MASK_REGISTERS)
+			/* Define mask cache pointer */
+			ct[i].pmask_cache = &ct[i].mask_cache;
+		else
+			/* They all point to the same mask cache */
+			ct[i].pmask_cache = &ct[0].mask_cache;
+
+		/* Init mask cache ? */
+		if ((flags & IRQ_GC_INIT_MASK_CACHE)
+		 && ((flags & IRQ_GC_SEPARATE_MASK_REGISTER)
+		  || (i == 0)))
+			*ct[i].pmask_cache =
+				irq_reg_readl(gc->reg_base + ct[i].regs.mask);
+	}
 
 	for (i = gc->irq_base; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))
-- 
1.7.10.1
