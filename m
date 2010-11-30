From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:20 +0100
Subject: [PATCH 48/54] ARM: w90x900: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134120.GW15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-w90x900/irq.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-w90x900/irq.c b/arch/arm/mach-w90x900/irq.c
index 0ce9d8e..9c35010 100644
--- a/arch/arm/mach-w90x900/irq.c
+++ b/arch/arm/mach-w90x900/irq.c
@@ -92,15 +92,15 @@ static void nuc900_group_enable(struct group_irq *gpirq, int enable)
 	__raw_writel(regval, REG_AIC_GEN);
 }
 
-static void nuc900_irq_mask(unsigned int irq)
+static void nuc900_irq_mask(struct irq_data *d)
 {
 	struct group_irq *group_irq;
 
 	group_irq = NULL;
 
-	__raw_writel(1 << irq, REG_AIC_MDCR);
+	__raw_writel(1 << d->irq, REG_AIC_MDCR);
 
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_GROUP0:
 		group_irq = &group_nirq0;
 		break;
@@ -143,20 +143,20 @@ static void nuc900_irq_mask(unsigned int irq)
  * to REG_AIC_EOSCR for ACK
  */
 
-static void nuc900_irq_ack(unsigned int irq)
+static void nuc900_irq_ack(struct irq_data *d)
 {
 	__raw_writel(0x01, REG_AIC_EOSCR);
 }
 
-static void nuc900_irq_unmask(unsigned int irq)
+static void nuc900_irq_unmask(struct irq_data *d)
 {
 	struct group_irq *group_irq;
 
 	group_irq = NULL;
 
-	__raw_writel(1 << irq, REG_AIC_MECR);
+	__raw_writel(1 << d->irq, REG_AIC_MECR);
 
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_GROUP0:
 		group_irq = &group_nirq0;
 		break;
@@ -195,9 +195,9 @@ static void nuc900_irq_unmask(unsigned int irq)
 }
 
 static struct irq_chip nuc900_irq_chip = {
-	.ack	   = nuc900_irq_ack,
-	.mask	   = nuc900_irq_mask,
-	.unmask	   = nuc900_irq_unmask,
+	.irq_ack	= nuc900_irq_ack,
+	.irq_mask	= nuc900_irq_mask,
+	.irq_unmask	= nuc900_irq_unmask,
 };
 
 void __init nuc900_init_irq(void)
-- 
1.7.1
