From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:40:55 +0100
Subject: [PATCH 31/54] ARM: mx3: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134055.GF15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-mx3/mach-mx31ads.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index b993b9b..88b97d6 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -162,9 +162,9 @@ static void mx31ads_expio_irq_handler(u32 irq, struct irq_desc *desc)
  * Disable an expio pin's interrupt by setting the bit in the imr.
  * @param irq           an expio virtual irq number
  */
-static void expio_mask_irq(u32 irq)
+static void expio_mask_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
 	/* mask the interrupt */
 	__raw_writew(1 << expio, PBC_INTMASK_CLEAR_REG);
 	__raw_readw(PBC_INTMASK_CLEAR_REG);
@@ -174,9 +174,9 @@ static void expio_mask_irq(u32 irq)
  * Acknowledge an expanded io pin's interrupt by clearing the bit in the isr.
  * @param irq           an expanded io virtual irq number
  */
-static void expio_ack_irq(u32 irq)
+static void expio_ack_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
 	/* clear the interrupt status */
 	__raw_writew(1 << expio, PBC_INTSTATUS_REG);
 }
@@ -185,18 +185,18 @@ static void expio_ack_irq(u32 irq)
  * Enable a expio pin's interrupt by clearing the bit in the imr.
  * @param irq           a expio virtual irq number
  */
-static void expio_unmask_irq(u32 irq)
+static void expio_unmask_irq(struct irq_data *d)
 {
-	u32 expio = MXC_IRQ_TO_EXPIO(irq);
+	u32 expio = MXC_IRQ_TO_EXPIO(d->irq);
 	/* unmask the interrupt */
 	__raw_writew(1 << expio, PBC_INTMASK_SET_REG);
 }
 
 static struct irq_chip expio_irq_chip = {
 	.name = "EXPIO(CPLD)",
-	.ack = expio_ack_irq,
-	.mask = expio_mask_irq,
-	.unmask = expio_unmask_irq,
+	.irq_ack = expio_ack_irq,
+	.irq_mask = expio_mask_irq,
+	.irq_unmask = expio_unmask_irq,
 };
 
 static void __init mx31ads_init_expio(void)
-- 
1.7.1
