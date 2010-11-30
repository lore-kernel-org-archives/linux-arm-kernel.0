From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:46 +0100
Subject: [PATCH 06/54] ARM: sa1111: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132546.GG15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/common/sa1111.c |   94 +++++++++++++++++++++++-----------------------
 1 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index c0258a8..d6c784e 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -210,7 +210,7 @@ sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 	sa1111_writel(stat0, mapbase + SA1111_INTSTATCLR0);
 
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	sa1111_writel(stat1, mapbase + SA1111_INTSTATCLR1);
 
@@ -228,35 +228,35 @@ sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
 			generic_handle_irq(i + sachip->irq_base);
 
 	/* For level-based interrupts */
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 #define SA1111_IRQMASK_LO(x)	(1 << (x - sachip->irq_base))
 #define SA1111_IRQMASK_HI(x)	(1 << (x - sachip->irq_base - 32))
 
-static void sa1111_ack_irq(unsigned int irq)
+static void sa1111_ack_irq(struct irq_data *d)
 {
 }
 
-static void sa1111_mask_lowirq(unsigned int irq)
+static void sa1111_mask_lowirq(struct irq_data *d)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned long ie0;
 
 	ie0 = sa1111_readl(mapbase + SA1111_INTEN0);
-	ie0 &= ~SA1111_IRQMASK_LO(irq);
+	ie0 &= ~SA1111_IRQMASK_LO(d->irq);
 	writel(ie0, mapbase + SA1111_INTEN0);
 }
 
-static void sa1111_unmask_lowirq(unsigned int irq)
+static void sa1111_unmask_lowirq(struct irq_data *d)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned long ie0;
 
 	ie0 = sa1111_readl(mapbase + SA1111_INTEN0);
-	ie0 |= SA1111_IRQMASK_LO(irq);
+	ie0 |= SA1111_IRQMASK_LO(d->irq);
 	sa1111_writel(ie0, mapbase + SA1111_INTEN0);
 }
 
@@ -267,11 +267,11 @@ static void sa1111_unmask_lowirq(unsigned int irq)
  * be triggered.  In fact, its very difficult, if not impossible to get
  * INTSET to re-trigger the interrupt.
  */
-static int sa1111_retrigger_lowirq(unsigned int irq)
+static int sa1111_retrigger_lowirq(struct irq_data *d)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
-	unsigned int mask = SA1111_IRQMASK_LO(irq);
+	unsigned int mask = SA1111_IRQMASK_LO(d->irq);
 	unsigned long ip0;
 	int i;
 
@@ -285,15 +285,15 @@ static int sa1111_retrigger_lowirq(unsigned int irq)
 
 	if (i == 8)
 		printk(KERN_ERR "Danger Will Robinson: failed to "
-			"re-trigger IRQ%d\n", irq);
+			"re-trigger IRQ%d\n", d->irq);
 	return i == 8 ? -1 : 0;
 }
 
-static int sa1111_type_lowirq(unsigned int irq, unsigned int flags)
+static int sa1111_type_lowirq(struct irq_data *d, unsigned int flags)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
-	unsigned int mask = SA1111_IRQMASK_LO(irq);
+	unsigned int mask = SA1111_IRQMASK_LO(d->irq);
 	unsigned long ip0;
 
 	if (flags == IRQ_TYPE_PROBE)
@@ -313,11 +313,11 @@ static int sa1111_type_lowirq(unsigned int irq, unsigned int flags)
 	return 0;
 }
 
-static int sa1111_wake_lowirq(unsigned int irq, unsigned int on)
+static int sa1111_wake_lowirq(struct irq_data *d, unsigned int on)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
-	unsigned int mask = SA1111_IRQMASK_LO(irq);
+	unsigned int mask = SA1111_IRQMASK_LO(d->irq);
 	unsigned long we0;
 
 	we0 = sa1111_readl(mapbase + SA1111_WAKEEN0);
@@ -332,33 +332,33 @@ static int sa1111_wake_lowirq(unsigned int irq, unsigned int on)
 
 static struct irq_chip sa1111_low_chip = {
 	.name		= "SA1111-l",
-	.ack		= sa1111_ack_irq,
-	.mask		= sa1111_mask_lowirq,
-	.unmask		= sa1111_unmask_lowirq,
-	.retrigger	= sa1111_retrigger_lowirq,
-	.set_type	= sa1111_type_lowirq,
-	.set_wake	= sa1111_wake_lowirq,
+	.irq_ack	= sa1111_ack_irq,
+	.irq_mask	= sa1111_mask_lowirq,
+	.irq_unmask	= sa1111_unmask_lowirq,
+	.irq_retrigger	= sa1111_retrigger_lowirq,
+	.irq_set_type	= sa1111_type_lowirq,
+	.irq_set_wake	= sa1111_wake_lowirq,
 };
 
-static void sa1111_mask_highirq(unsigned int irq)
+static void sa1111_mask_highirq(struct irq_data *d)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned long ie1;
 
 	ie1 = sa1111_readl(mapbase + SA1111_INTEN1);
-	ie1 &= ~SA1111_IRQMASK_HI(irq);
+	ie1 &= ~SA1111_IRQMASK_HI(d->irq);
 	sa1111_writel(ie1, mapbase + SA1111_INTEN1);
 }
 
-static void sa1111_unmask_highirq(unsigned int irq)
+static void sa1111_unmask_highirq(struct irq_data *d)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
 	unsigned long ie1;
 
 	ie1 = sa1111_readl(mapbase + SA1111_INTEN1);
-	ie1 |= SA1111_IRQMASK_HI(irq);
+	ie1 |= SA1111_IRQMASK_HI(d->irq);
 	sa1111_writel(ie1, mapbase + SA1111_INTEN1);
 }
 
@@ -369,11 +369,11 @@ static void sa1111_unmask_highirq(unsigned int irq)
  * be triggered.  In fact, its very difficult, if not impossible to get
  * INTSET to re-trigger the interrupt.
  */
-static int sa1111_retrigger_highirq(unsigned int irq)
+static int sa1111_retrigger_highirq(struct irq_data *d)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
-	unsigned int mask = SA1111_IRQMASK_HI(irq);
+	unsigned int mask = SA1111_IRQMASK_HI(d->irq);
 	unsigned long ip1;
 	int i;
 
@@ -387,15 +387,15 @@ static int sa1111_retrigger_highirq(unsigned int irq)
 
 	if (i == 8)
 		printk(KERN_ERR "Danger Will Robinson: failed to "
-			"re-trigger IRQ%d\n", irq);
+			"re-trigger IRQ%d\n", d->irq);
 	return i == 8 ? -1 : 0;
 }
 
-static int sa1111_type_highirq(unsigned int irq, unsigned int flags)
+static int sa1111_type_highirq(struct irq_data *d, unsigned int flags)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
-	unsigned int mask = SA1111_IRQMASK_HI(irq);
+	unsigned int mask = SA1111_IRQMASK_HI(d->irq);
 	unsigned long ip1;
 
 	if (flags == IRQ_TYPE_PROBE)
@@ -415,11 +415,11 @@ static int sa1111_type_highirq(unsigned int irq, unsigned int flags)
 	return 0;
 }
 
-static int sa1111_wake_highirq(unsigned int irq, unsigned int on)
+static int sa1111_wake_highirq(struct irq_data *d, unsigned int on)
 {
-	struct sa1111 *sachip = get_irq_chip_data(irq);
+	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
-	unsigned int mask = SA1111_IRQMASK_HI(irq);
+	unsigned int mask = SA1111_IRQMASK_HI(d->irq);
 	unsigned long we1;
 
 	we1 = sa1111_readl(mapbase + SA1111_WAKEEN1);
@@ -434,12 +434,12 @@ static int sa1111_wake_highirq(unsigned int irq, unsigned int on)
 
 static struct irq_chip sa1111_high_chip = {
 	.name		= "SA1111-h",
-	.ack		= sa1111_ack_irq,
-	.mask		= sa1111_mask_highirq,
-	.unmask		= sa1111_unmask_highirq,
-	.retrigger	= sa1111_retrigger_highirq,
-	.set_type	= sa1111_type_highirq,
-	.set_wake	= sa1111_wake_highirq,
+	.irq_ack	= sa1111_ack_irq,
+	.irq_mask	= sa1111_mask_highirq,
+	.irq_unmask	= sa1111_unmask_highirq,
+	.irq_retrigger	= sa1111_retrigger_highirq,
+	.irq_set_type	= sa1111_type_highirq,
+	.irq_set_wake	= sa1111_wake_highirq,
 };
 
 static void sa1111_setup_irq(struct sa1111 *sachip)
-- 
1.7.1
