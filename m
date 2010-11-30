From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:08 +0100
Subject: [PATCH 36/54] ARM: omap2: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134108.GK15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-omap2/irq.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 32eeabe..3d17ef6 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -100,13 +100,14 @@ static int omap_check_spurious(unsigned int irq)
 }
 
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
-static void omap_ack_irq(unsigned int irq)
+static void omap_ack_irq(struct irq_data *d)
 {
 	intc_bank_write_reg(0x1, &irq_banks[0], INTC_CONTROL);
 }
 
-static void omap_mask_irq(unsigned int irq)
+static void omap_mask_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
 	if (cpu_is_omap34xx()) {
@@ -128,8 +129,9 @@ static void omap_mask_irq(unsigned int irq)
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_SET0 + offset);
 }
 
-static void omap_unmask_irq(unsigned int irq)
+static void omap_unmask_irq(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
 	int offset = irq & (~(IRQ_BITS_PER_REG - 1));
 
 	irq &= (IRQ_BITS_PER_REG - 1);
@@ -137,17 +139,17 @@ static void omap_unmask_irq(unsigned int irq)
 	intc_bank_write_reg(1 << irq, &irq_banks[0], INTC_MIR_CLEAR0 + offset);
 }
 
-static void omap_mask_ack_irq(unsigned int irq)
+static void omap_mask_ack_irq(struct irq_data *d)
 {
-	omap_mask_irq(irq);
-	omap_ack_irq(irq);
+	omap_mask_irq(d);
+	omap_ack_irq(d);
 }
 
 static struct irq_chip omap_irq_chip = {
-	.name	= "INTC",
-	.ack	= omap_mask_ack_irq,
-	.mask	= omap_mask_irq,
-	.unmask	= omap_unmask_irq,
+	.name		= "INTC",
+	.irq_ack	= omap_mask_ack_irq,
+	.irq_mask	= omap_mask_irq,
+	.irq_unmask	= omap_unmask_irq,
 };
 
 static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
-- 
1.7.1
