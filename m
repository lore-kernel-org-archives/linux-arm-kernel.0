From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:58 +0100
Subject: [PATCH 28/54] ARM: lpc32xx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133658.GC15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-lpc32xx/irq.c |   56 +++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index bd0df26..316ecbf 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -191,38 +191,38 @@ static void get_controller(unsigned int irq, unsigned int *base,
 	}
 }
 
-static void lpc32xx_mask_irq(unsigned int irq)
+static void lpc32xx_mask_irq(struct irq_data *d)
 {
 	unsigned int reg, ctrl, mask;
 
-	get_controller(irq, &ctrl, &mask);
+	get_controller(d->irq, &ctrl, &mask);
 
 	reg = __raw_readl(LPC32XX_INTC_MASK(ctrl)) & ~mask;
 	__raw_writel(reg, LPC32XX_INTC_MASK(ctrl));
 }
 
-static void lpc32xx_unmask_irq(unsigned int irq)
+static void lpc32xx_unmask_irq(struct irq_data *d)
 {
 	unsigned int reg, ctrl, mask;
 
-	get_controller(irq, &ctrl, &mask);
+	get_controller(d->irq, &ctrl, &mask);
 
 	reg = __raw_readl(LPC32XX_INTC_MASK(ctrl)) | mask;
 	__raw_writel(reg, LPC32XX_INTC_MASK(ctrl));
 }
 
-static void lpc32xx_ack_irq(unsigned int irq)
+static void lpc32xx_ack_irq(struct irq_data *d)
 {
 	unsigned int ctrl, mask;
 
-	get_controller(irq, &ctrl, &mask);
+	get_controller(d->irq, &ctrl, &mask);
 
 	__raw_writel(mask, LPC32XX_INTC_RAW_STAT(ctrl));
 
 	/* Also need to clear pending wake event */
-	if (lpc32xx_events[irq].mask != 0)
-		__raw_writel(lpc32xx_events[irq].mask,
-			lpc32xx_events[irq].event_group->rawstat_reg);
+	if (lpc32xx_events[d->irq].mask != 0)
+		__raw_writel(lpc32xx_events[d->irq].mask,
+			lpc32xx_events[d->irq].event_group->rawstat_reg);
 }
 
 static void __lpc32xx_set_irq_type(unsigned int irq, int use_high_level,
@@ -261,27 +261,27 @@ static void __lpc32xx_set_irq_type(unsigned int irq, int use_high_level,
 	}
 }
 
-static int lpc32xx_set_irq_type(unsigned int irq, unsigned int type)
+static int lpc32xx_set_irq_type(struct irq_data *d, unsigned int type)
 {
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		/* Rising edge sensitive */
-		__lpc32xx_set_irq_type(irq, 1, 1);
+		__lpc32xx_set_irq_type(d->irq, 1, 1);
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
 		/* Falling edge sensitive */
-		__lpc32xx_set_irq_type(irq, 0, 1);
+		__lpc32xx_set_irq_type(d->irq, 0, 1);
 		break;
 
 	case IRQ_TYPE_LEVEL_LOW:
 		/* Low level sensitive */
-		__lpc32xx_set_irq_type(irq, 0, 0);
+		__lpc32xx_set_irq_type(d->irq, 0, 0);
 		break;
 
 	case IRQ_TYPE_LEVEL_HIGH:
 		/* High level sensitive */
-		__lpc32xx_set_irq_type(irq, 1, 0);
+		__lpc32xx_set_irq_type(d->irq, 1, 0);
 		break;
 
 	/* Other modes are not supported */
@@ -290,33 +290,33 @@ static int lpc32xx_set_irq_type(unsigned int irq, unsigned int type)
 	}
 
 	/* Ok to use the level handler for all types */
-	set_irq_handler(irq, handle_level_irq);
+	set_irq_handler(d->irq, handle_level_irq);
 
 	return 0;
 }
 
-static int lpc32xx_irq_wake(unsigned int irqno, unsigned int state)
+static int lpc32xx_irq_wake(struct irq_data *d, unsigned int state)
 {
 	unsigned long eventreg;
 
-	if (lpc32xx_events[irqno].mask != 0) {
-		eventreg = __raw_readl(lpc32xx_events[irqno].
+	if (lpc32xx_events[d->irq].mask != 0) {
+		eventreg = __raw_readl(lpc32xx_events[d->irq].
 			event_group->enab_reg);
 
 		if (state)
-			eventreg |= lpc32xx_events[irqno].mask;
+			eventreg |= lpc32xx_events[d->irq].mask;
 		else
-			eventreg &= ~lpc32xx_events[irqno].mask;
+			eventreg &= ~lpc32xx_events[d->irq].mask;
 
 		__raw_writel(eventreg,
-			lpc32xx_events[irqno].event_group->enab_reg);
+			lpc32xx_events[d->irq].event_group->enab_reg);
 
 		return 0;
 	}
 
 	/* Clear event */
-	__raw_writel(lpc32xx_events[irqno].mask,
-		lpc32xx_events[irqno].event_group->rawstat_reg);
+	__raw_writel(lpc32xx_events[d->irq].mask,
+		lpc32xx_events[d->irq].event_group->rawstat_reg);
 
 	return -ENODEV;
 }
@@ -336,11 +336,11 @@ static void __init lpc32xx_set_default_mappings(unsigned int apr,
 }
 
 static struct irq_chip lpc32xx_irq_chip = {
-	.ack = lpc32xx_ack_irq,
-	.mask = lpc32xx_mask_irq,
-	.unmask = lpc32xx_unmask_irq,
-	.set_type = lpc32xx_set_irq_type,
-	.set_wake = lpc32xx_irq_wake
+	.irq_ack = lpc32xx_ack_irq,
+	.irq_mask = lpc32xx_mask_irq,
+	.irq_unmask = lpc32xx_unmask_irq,
+	.irq_set_type = lpc32xx_set_irq_type,
+	.irq_set_wake = lpc32xx_irq_wake
 };
 
 static void lpc32xx_sic1_handler(unsigned int irq, struct irq_desc *desc)
-- 
1.7.1
