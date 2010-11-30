From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:09 +0100
Subject: [PATCH 37/54] ARM: pnx4008: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134109.GL15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-pnx4008/irq.c |   62 +++++++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-pnx4008/irq.c b/arch/arm/mach-pnx4008/irq.c
index a9ce02b..c69c180 100644
--- a/arch/arm/mach-pnx4008/irq.c
+++ b/arch/arm/mach-pnx4008/irq.c
@@ -36,44 +36,44 @@
 
 static u8 pnx4008_irq_type[NR_IRQS] = PNX4008_IRQ_TYPES;
 
-static void pnx4008_mask_irq(unsigned int irq)
+static void pnx4008_mask_irq(struct irq_data *d)
 {
-	__raw_writel(__raw_readl(INTC_ER(irq)) & ~INTC_BIT(irq), INTC_ER(irq));	/* mask interrupt */
+	__raw_writel(__raw_readl(INTC_ER(d->irq)) & ~INTC_BIT(d->irq), INTC_ER(d->irq));	/* mask interrupt */
 }
 
-static void pnx4008_unmask_irq(unsigned int irq)
+static void pnx4008_unmask_irq(struct irq_data *d)
 {
-	__raw_writel(__raw_readl(INTC_ER(irq)) | INTC_BIT(irq), INTC_ER(irq));	/* unmask interrupt */
+	__raw_writel(__raw_readl(INTC_ER(d->irq)) | INTC_BIT(d->irq), INTC_ER(d->irq));	/* unmask interrupt */
 }
 
-static void pnx4008_mask_ack_irq(unsigned int irq)
+static void pnx4008_mask_ack_irq(struct irq_data *d)
 {
-	__raw_writel(__raw_readl(INTC_ER(irq)) & ~INTC_BIT(irq), INTC_ER(irq));	/* mask interrupt */
-	__raw_writel(INTC_BIT(irq), INTC_SR(irq));	/* clear interrupt status */
+	__raw_writel(__raw_readl(INTC_ER(d->irq)) & ~INTC_BIT(d->irq), INTC_ER(d->irq));	/* mask interrupt */
+	__raw_writel(INTC_BIT(d->irq), INTC_SR(d->irq));	/* clear interrupt status */
 }
 
-static int pnx4008_set_irq_type(unsigned int irq, unsigned int type)
+static int pnx4008_set_irq_type(struct irq_data *d, unsigned int type)
 {
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
-		__raw_writel(__raw_readl(INTC_ATR(irq)) | INTC_BIT(irq), INTC_ATR(irq));	/*edge sensitive */
-		__raw_writel(__raw_readl(INTC_APR(irq)) | INTC_BIT(irq), INTC_APR(irq));	/*rising edge */
-		set_irq_handler(irq, handle_edge_irq);
+		__raw_writel(__raw_readl(INTC_ATR(d->irq)) | INTC_BIT(d->irq), INTC_ATR(d->irq));	/*edge sensitive */
+		__raw_writel(__raw_readl(INTC_APR(d->irq)) | INTC_BIT(d->irq), INTC_APR(d->irq));	/*rising edge */
+		set_irq_handler(d->irq, handle_edge_irq);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
-		__raw_writel(__raw_readl(INTC_ATR(irq)) | INTC_BIT(irq), INTC_ATR(irq));	/*edge sensitive */
-		__raw_writel(__raw_readl(INTC_APR(irq)) & ~INTC_BIT(irq), INTC_APR(irq));	/*falling edge */
-		set_irq_handler(irq, handle_edge_irq);
+		__raw_writel(__raw_readl(INTC_ATR(d->irq)) | INTC_BIT(d->irq), INTC_ATR(d->irq));	/*edge sensitive */
+		__raw_writel(__raw_readl(INTC_APR(d->irq)) & ~INTC_BIT(d->irq), INTC_APR(d->irq));	/*falling edge */
+		set_irq_handler(d->irq, handle_edge_irq);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		__raw_writel(__raw_readl(INTC_ATR(irq)) & ~INTC_BIT(irq), INTC_ATR(irq));	/*level sensitive */
-		__raw_writel(__raw_readl(INTC_APR(irq)) & ~INTC_BIT(irq), INTC_APR(irq));	/*low level */
-		set_irq_handler(irq, handle_level_irq);
+		__raw_writel(__raw_readl(INTC_ATR(d->irq)) & ~INTC_BIT(d->irq), INTC_ATR(d->irq));	/*level sensitive */
+		__raw_writel(__raw_readl(INTC_APR(d->irq)) & ~INTC_BIT(d->irq), INTC_APR(d->irq));	/*low level */
+		set_irq_handler(d->irq, handle_level_irq);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
-		__raw_writel(__raw_readl(INTC_ATR(irq)) & ~INTC_BIT(irq), INTC_ATR(irq));	/*level sensitive */
-		__raw_writel(__raw_readl(INTC_APR(irq)) | INTC_BIT(irq), INTC_APR(irq));	/* high level */
-		set_irq_handler(irq, handle_level_irq);
+		__raw_writel(__raw_readl(INTC_ATR(d->irq)) & ~INTC_BIT(d->irq), INTC_ATR(d->irq));	/*level sensitive */
+		__raw_writel(__raw_readl(INTC_APR(d->irq)) | INTC_BIT(d->irq), INTC_APR(d->irq));	/* high level */
+		set_irq_handler(d->irq, handle_level_irq);
 		break;
 
 	/* IRQ_TYPE_EDGE_BOTH is not supported */
@@ -85,10 +85,10 @@ static int pnx4008_set_irq_type(unsigned int irq, unsigned int type)
 }
 
 static struct irq_chip pnx4008_irq_chip = {
-	.ack = pnx4008_mask_ack_irq,
-	.mask = pnx4008_mask_irq,
-	.unmask = pnx4008_unmask_irq,
-	.set_type = pnx4008_set_irq_type,
+	.irq_ack = pnx4008_mask_ack_irq,
+	.irq_mask = pnx4008_mask_irq,
+	.irq_unmask = pnx4008_unmask_irq,
+	.irq_set_type = pnx4008_set_irq_type,
 };
 
 void __init pnx4008_init_irq(void)
@@ -99,14 +99,18 @@ void __init pnx4008_init_irq(void)
 	for (i = 0; i < NR_IRQS; i++) {
 		set_irq_flags(i, IRQF_VALID);
 		set_irq_chip(i, &pnx4008_irq_chip);
-		pnx4008_set_irq_type(i, pnx4008_irq_type[i]);
+		pnx4008_set_irq_type(irq_get_irq_data(i), pnx4008_irq_type[i]);
 	}
 
 	/* configure and enable IRQ 0,1,30,31 (cascade interrupts) */
-	pnx4008_set_irq_type(SUB1_IRQ_N, pnx4008_irq_type[SUB1_IRQ_N]);
-	pnx4008_set_irq_type(SUB2_IRQ_N, pnx4008_irq_type[SUB2_IRQ_N]);
-	pnx4008_set_irq_type(SUB1_FIQ_N, pnx4008_irq_type[SUB1_FIQ_N]);
-	pnx4008_set_irq_type(SUB2_FIQ_N, pnx4008_irq_type[SUB2_FIQ_N]);
+	pnx4008_set_irq_type(irq_get_irq_data(SUB1_IRQ_N),
+			     pnx4008_irq_type[SUB1_IRQ_N]);
+	pnx4008_set_irq_type(irq_get_irq_data(SUB2_IRQ_N),
+			     pnx4008_irq_type[SUB2_IRQ_N]);
+	pnx4008_set_irq_type(irq_get_irq_data(SUB1_FIQ_N),
+			     pnx4008_irq_type[SUB1_FIQ_N]);
+	pnx4008_set_irq_type(irq_get_irq_data(SUB2_FIQ_N),
+			     pnx4008_irq_type[SUB2_FIQ_N]);
 
 	/* mask all others */
 	__raw_writel((1 << SUB2_FIQ_N) | (1 << SUB1_FIQ_N) |
-- 
1.7.1
