From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:55 +0100
Subject: [PATCH 26/54] ARM: ks8695: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133655.GA15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-ks8695/irq.c |   43 ++++++++++++++++++++++---------------------
 1 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ks8695/irq.c b/arch/arm/mach-ks8695/irq.c
index e375c1d..7998cca 100644
--- a/arch/arm/mach-ks8695/irq.c
+++ b/arch/arm/mach-ks8695/irq.c
@@ -34,29 +34,29 @@
 #include <mach/regs-irq.h>
 #include <mach/regs-gpio.h>
 
-static void ks8695_irq_mask(unsigned int irqno)
+static void ks8695_irq_mask(struct irq_data *d)
 {
 	unsigned long inten;
 
 	inten = __raw_readl(KS8695_IRQ_VA + KS8695_INTEN);
-	inten &= ~(1 << irqno);
+	inten &= ~(1 << d->irq);
 
 	__raw_writel(inten, KS8695_IRQ_VA + KS8695_INTEN);
 }
 
-static void ks8695_irq_unmask(unsigned int irqno)
+static void ks8695_irq_unmask(struct irq_data *d)
 {
 	unsigned long inten;
 
 	inten = __raw_readl(KS8695_IRQ_VA + KS8695_INTEN);
-	inten |= (1 << irqno);
+	inten |= (1 << d->irq);
 
 	__raw_writel(inten, KS8695_IRQ_VA + KS8695_INTEN);
 }
 
-static void ks8695_irq_ack(unsigned int irqno)
+static void ks8695_irq_ack(struct irq_data *d)
 {
-	__raw_writel((1 << irqno), KS8695_IRQ_VA + KS8695_INTST);
+	__raw_writel((1 << d->irq), KS8695_IRQ_VA + KS8695_INTST);
 }
 
 
@@ -64,7 +64,7 @@ static struct irq_chip ks8695_irq_level_chip;
 static struct irq_chip ks8695_irq_edge_chip;
 
 
-static int ks8695_irq_set_type(unsigned int irqno, unsigned int type)
+static int ks8695_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	unsigned long ctrl, mode;
 	unsigned short level_triggered = 0;
@@ -93,7 +93,7 @@ static int ks8695_irq_set_type(unsigned int irqno, unsigned int type)
 			return -EINVAL;
 	}
 
-	switch (irqno) {
+	switch (d->irq) {
 		case KS8695_IRQ_EXTERN0:
 			ctrl &= ~IOPC_IOEINT0TM;
 			ctrl |= IOPC_IOEINT0_MODE(mode);
@@ -115,12 +115,12 @@ static int ks8695_irq_set_type(unsigned int irqno, unsigned int type)
 	}
 
 	if (level_triggered) {
-		set_irq_chip(irqno, &ks8695_irq_level_chip);
-		set_irq_handler(irqno, handle_level_irq);
+		set_irq_chip(d->irq, &ks8695_irq_level_chip);
+		set_irq_handler(d->irq, handle_level_irq);
 	}
 	else {
-		set_irq_chip(irqno, &ks8695_irq_edge_chip);
-		set_irq_handler(irqno, handle_edge_irq);
+		set_irq_chip(d->irq, &ks8695_irq_edge_chip);
+		set_irq_handler(d->irq, handle_edge_irq);
 	}
 
 	__raw_writel(ctrl, KS8695_GPIO_VA + KS8695_IOPC);
@@ -128,17 +128,17 @@ static int ks8695_irq_set_type(unsigned int irqno, unsigned int type)
 }
 
 static struct irq_chip ks8695_irq_level_chip = {
-	.ack		= ks8695_irq_mask,
-	.mask		= ks8695_irq_mask,
-	.unmask		= ks8695_irq_unmask,
-	.set_type	= ks8695_irq_set_type,
+	.irq_ack	= ks8695_irq_mask,
+	.irq_mask	= ks8695_irq_mask,
+	.irq_unmask	= ks8695_irq_unmask,
+	.irq_set_type	= ks8695_irq_set_type,
 };
 
 static struct irq_chip ks8695_irq_edge_chip = {
-	.ack		= ks8695_irq_ack,
-	.mask		= ks8695_irq_mask,
-	.unmask		= ks8695_irq_unmask,
-	.set_type	= ks8695_irq_set_type,
+	.irq_ack	= ks8695_irq_ack,
+	.irq_mask	= ks8695_irq_mask,
+	.irq_unmask	= ks8695_irq_unmask,
+	.irq_set_type	= ks8695_irq_set_type,
 };
 
 void __init ks8695_init_irq(void)
@@ -164,7 +164,8 @@ void __init ks8695_init_irq(void)
 
 			/* Edge-triggered interrupts */
 			default:
-				ks8695_irq_ack(irq);	/* clear pending bit */
+				/* clear pending bit */
+				ks8695_irq_ack(irq_get_irq_data(irq));
 				set_irq_chip(irq, &ks8695_irq_edge_chip);
 				set_irq_handler(irq, handle_edge_irq);
 		}
-- 
1.7.1
