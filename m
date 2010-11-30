From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:40 +0100
Subject: [PATCH 05/54] ARM: LoCoMo: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132540.GF15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/common/locomo.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index 9dff07c..a026a6b 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -144,7 +144,7 @@ static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 	int req, i;
 
 	/* Acknowledge the parent IRQ */
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	/* check why this interrupt was generated */
 	req = locomo_readl(lchip->base + LOCOMO_ICR) & 0x0f00;
@@ -161,33 +161,33 @@ static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void locomo_ack_irq(unsigned int irq)
+static void locomo_ack_irq(struct irq_data *d)
 {
 }
 
-static void locomo_mask_irq(unsigned int irq)
+static void locomo_mask_irq(struct irq_data *d)
 {
-	struct locomo *lchip = get_irq_chip_data(irq);
+	struct locomo *lchip = irq_data_get_irq_chip_data(d);
 	unsigned int r;
 	r = locomo_readl(lchip->base + LOCOMO_ICR);
-	r &= ~(0x0010 << (irq - lchip->irq_base));
+	r &= ~(0x0010 << (d->irq - lchip->irq_base));
 	locomo_writel(r, lchip->base + LOCOMO_ICR);
 }
 
-static void locomo_unmask_irq(unsigned int irq)
+static void locomo_unmask_irq(struct irq_data *d)
 {
-	struct locomo *lchip = get_irq_chip_data(irq);
+	struct locomo *lchip = irq_data_get_irq_chip_data(d);
 	unsigned int r;
 	r = locomo_readl(lchip->base + LOCOMO_ICR);
-	r |= (0x0010 << (irq - lchip->irq_base));
+	r |= (0x0010 << (d->irq - lchip->irq_base));
 	locomo_writel(r, lchip->base + LOCOMO_ICR);
 }
 
 static struct irq_chip locomo_chip = {
-	.name	= "LOCOMO",
-	.ack	= locomo_ack_irq,
-	.mask	= locomo_mask_irq,
-	.unmask	= locomo_unmask_irq,
+	.name		= "LOCOMO",
+	.irq_ack	= locomo_ack_irq,
+	.irq_mask	= locomo_mask_irq,
+	.irq_unmask	= locomo_unmask_irq,
 };
 
 static void locomo_setup_irq(struct locomo *lchip)
-- 
1.7.1
