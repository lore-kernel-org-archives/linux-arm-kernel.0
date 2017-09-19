From: opendmb@gmail.com (Doug Berger)
Date: Mon, 18 Sep 2017 17:59:59 -0700
Subject: [PATCH v4 2/3] irqchip: brcmstb-l2: Abstract register accesses
In-Reply-To: <20170919010000.32072-1-opendmb@gmail.com>
References: <20170919010000.32072-1-opendmb@gmail.com>
Message-ID: <20170919010000.32072-3-opendmb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added register block offsets to the brcmstb_l2_intc_data structure
for the status and mask registers to support reading the active
interupts in an abstracted way.  It seems like an irq_chip method
should have been provided for this, but it's not there yet.

Abstracted the implementation of the handler, suspend, and resume
functions to not use any hard coded register offsets.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Doug Berger <opendmb@gmail.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 48bd1a36c7d4..8d54cd7a090d 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -43,6 +43,8 @@
 struct brcmstb_l2_intc_data {
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
+	int status_offset;
+	int mask_offset;
 	bool can_wake;
 	u32 saved_mask; /* for suspend/resume */
 };
@@ -82,8 +84,8 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	status = irq_reg_readl(b->gc, CPU_STATUS) &
-		~(irq_reg_readl(b->gc, CPU_MASK_STATUS));
+	status = irq_reg_readl(b->gc, b->status_offset) &
+		~(irq_reg_readl(b->gc, b->mask_offset));
 
 	if (status == 0) {
 		raw_spin_lock(&desc->lock);
@@ -104,16 +106,17 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 static void brcmstb_l2_intc_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
 	/* Save the current mask */
-	b->saved_mask = irq_reg_readl(gc, CPU_MASK_STATUS);
+	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
 
 	if (b->can_wake) {
 		/* Program the wakeup mask */
-		irq_reg_writel(gc, ~gc->wake_active, CPU_MASK_SET);
-		irq_reg_writel(gc, gc->wake_active, CPU_MASK_CLEAR);
+		irq_reg_writel(gc, ~gc->wake_active, ct->regs.disable);
+		irq_reg_writel(gc, gc->wake_active, ct->regs.enable);
 	}
 	irq_gc_unlock(gc);
 }
@@ -121,15 +124,19 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
 static void brcmstb_l2_intc_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
-	/* Clear unmasked non-wakeup interrupts */
-	irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active, CPU_CLEAR);
+	if (ct->chip.irq_ack != irq_gc_noop) {
+		/* Clear unmasked non-wakeup interrupts */
+		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
+				ct->regs.ack);
+	}
 
 	/* Restore the saved mask */
-	irq_reg_writel(gc, b->saved_mask, CPU_MASK_SET);
-	irq_reg_writel(gc, ~b->saved_mask, CPU_MASK_CLEAR);
+	irq_reg_writel(gc, b->saved_mask, ct->regs.disable);
+	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
 	irq_gc_unlock(gc);
 }
 
@@ -199,6 +206,9 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	data->gc = irq_get_domain_generic_chip(data->domain, 0);
 	data->gc->reg_base = base;
 	data->gc->private = data;
+	data->status_offset = CPU_STATUS;
+	data->mask_offset = CPU_MASK_STATUS;
+
 	ct = data->gc->chip_types;
 
 	ct->chip.irq_ack = irq_gc_ack_set_bit;
@@ -207,6 +217,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_mask_ack = brcmstb_l2_mask_and_ack;
 	ct->regs.disable = CPU_MASK_SET;
+	ct->regs.mask = CPU_MASK_STATUS;
 
 	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
 	ct->regs.enable = CPU_MASK_CLEAR;
-- 
2.14.1
