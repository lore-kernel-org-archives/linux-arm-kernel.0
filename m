From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:25 +0100
Subject: [PATCH 53/54] ARM: plat-spear: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134125.GB15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/plat-spear/shirq.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/plat-spear/shirq.c b/arch/arm/plat-spear/shirq.c
index 2172d69..7818903 100644
--- a/arch/arm/plat-spear/shirq.c
+++ b/arch/arm/plat-spear/shirq.c
@@ -20,10 +20,10 @@
 struct spear_shirq *shirq;
 static DEFINE_SPINLOCK(lock);
 
-static void shirq_irq_mask(unsigned irq)
+static void shirq_irq_mask(struct irq_data *d)
 {
-	struct spear_shirq *shirq = get_irq_chip_data(irq);
-	u32 val, id = irq - shirq->dev_config[0].virq;
+	struct spear_shirq *shirq = irq_data_get_irq_chip_data(d);
+	u32 val, id = d->irq - shirq->dev_config[0].virq;
 	unsigned long flags;
 
 	if ((shirq->regs.enb_reg == -1) || shirq->dev_config[id].enb_mask == -1)
@@ -39,10 +39,10 @@ static void shirq_irq_mask(unsigned irq)
 	spin_unlock_irqrestore(&lock, flags);
 }
 
-static void shirq_irq_unmask(unsigned irq)
+static void shirq_irq_unmask(struct irq_data *d)
 {
-	struct spear_shirq *shirq = get_irq_chip_data(irq);
-	u32 val, id = irq - shirq->dev_config[0].virq;
+	struct spear_shirq *shirq = irq_data_get_irq_chip_data(d);
+	u32 val, id = d->irq - shirq->dev_config[0].virq;
 	unsigned long flags;
 
 	if ((shirq->regs.enb_reg == -1) || shirq->dev_config[id].enb_mask == -1)
@@ -60,9 +60,9 @@ static void shirq_irq_unmask(unsigned irq)
 
 static struct irq_chip shirq_chip = {
 	.name		= "spear_shirq",
-	.ack		= shirq_irq_mask,
-	.mask		= shirq_irq_mask,
-	.unmask		= shirq_irq_unmask,
+	.irq_ack	= shirq_irq_mask,
+	.irq_mask	= shirq_irq_mask,
+	.irq_unmask	= shirq_irq_unmask,
 };
 
 static void shirq_handler(unsigned irq, struct irq_desc *desc)
@@ -70,7 +70,7 @@ static void shirq_handler(unsigned irq, struct irq_desc *desc)
 	u32 i, val, mask;
 	struct spear_shirq *shirq = get_irq_data(irq);
 
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 	while ((val = readl(shirq->regs.base + shirq->regs.status_reg) &
 				shirq->regs.status_reg_mask)) {
 		for (i = 0; (i < shirq->dev_count) && val; i++) {
@@ -92,7 +92,7 @@ static void shirq_handler(unsigned irq, struct irq_desc *desc)
 			writel(mask, shirq->regs.base + shirq->regs.clear_reg);
 		}
 	}
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 int spear_shirq_register(struct spear_shirq *shirq)
-- 
1.7.1
