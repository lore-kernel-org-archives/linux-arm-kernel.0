From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:41:04 +0100
Subject: [PATCH 33/54] ARM: ns9xxx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130134104.GH15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-ns9xxx/board-a9m9750dev.c |   28 ++++++++++++++--------------
 arch/arm/mach-ns9xxx/irq.c              |   28 ++++++++++++++--------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-ns9xxx/board-a9m9750dev.c b/arch/arm/mach-ns9xxx/board-a9m9750dev.c
index b45bb3b..0c0d524 100644
--- a/arch/arm/mach-ns9xxx/board-a9m9750dev.c
+++ b/arch/arm/mach-ns9xxx/board-a9m9750dev.c
@@ -37,44 +37,44 @@ void __init board_a9m9750dev_map_io(void)
 		     ARRAY_SIZE(board_a9m9750dev_io_desc));
 }
 
-static void a9m9750dev_fpga_ack_irq(unsigned int irq)
+static void a9m9750dev_fpga_ack_irq(struct irq_data *d)
 {
 	/* nothing */
 }
 
-static void a9m9750dev_fpga_mask_irq(unsigned int irq)
+static void a9m9750dev_fpga_mask_irq(struct irq_data *d)
 {
 	u8 ier;
 
 	ier = __raw_readb(FPGA_IER);
 
-	ier &= ~(1 << (irq - FPGA_IRQ(0)));
+	ier &= ~(1 << (d->irq - FPGA_IRQ(0)));
 
 	__raw_writeb(ier, FPGA_IER);
 }
 
-static void a9m9750dev_fpga_maskack_irq(unsigned int irq)
+static void a9m9750dev_fpga_maskack_irq(struct irq_data *d)
 {
-	a9m9750dev_fpga_mask_irq(irq);
-	a9m9750dev_fpga_ack_irq(irq);
+	a9m9750dev_fpga_mask_irq(d);
+	a9m9750dev_fpga_ack_irq(d);
 }
 
-static void a9m9750dev_fpga_unmask_irq(unsigned int irq)
+static void a9m9750dev_fpga_unmask_irq(struct irq_data *d)
 {
 	u8 ier;
 
 	ier = __raw_readb(FPGA_IER);
 
-	ier |= 1 << (irq - FPGA_IRQ(0));
+	ier |= 1 << (d->irq - FPGA_IRQ(0));
 
 	__raw_writeb(ier, FPGA_IER);
 }
 
 static struct irq_chip a9m9750dev_fpga_chip = {
-	.ack		= a9m9750dev_fpga_ack_irq,
-	.mask		= a9m9750dev_fpga_mask_irq,
-	.mask_ack	= a9m9750dev_fpga_maskack_irq,
-	.unmask		= a9m9750dev_fpga_unmask_irq,
+	.irq_ack	= a9m9750dev_fpga_ack_irq,
+	.irq_mask	= a9m9750dev_fpga_mask_irq,
+	.irq_mask_ack	= a9m9750dev_fpga_maskack_irq,
+	.irq_unmask	= a9m9750dev_fpga_unmask_irq,
 };
 
 static void a9m9750dev_fpga_demux_handler(unsigned int irq,
@@ -82,7 +82,7 @@ static void a9m9750dev_fpga_demux_handler(unsigned int irq,
 {
 	u8 stat = __raw_readb(FPGA_ISR);
 
-	desc->chip->mask_ack(irq);
+	desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
 
 	while (stat != 0) {
 		int irqno = fls(stat) - 1;
@@ -92,7 +92,7 @@ static void a9m9750dev_fpga_demux_handler(unsigned int irq,
 		generic_handle_irq(FPGA_IRQ(irqno));
 	}
 
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 void __init board_a9m9750dev_init_irq(void)
diff --git a/arch/arm/mach-ns9xxx/irq.c b/arch/arm/mach-ns9xxx/irq.c
index 038f24d..389fa5c 100644
--- a/arch/arm/mach-ns9xxx/irq.c
+++ b/arch/arm/mach-ns9xxx/irq.c
@@ -22,40 +22,40 @@
 #define irq2prio(i) (i)
 #define prio2irq(p) (p)
 
-static void ns9xxx_mask_irq(unsigned int irq)
+static void ns9xxx_mask_irq(struct irq_data *d)
 {
 	/* XXX: better use cpp symbols */
-	int prio = irq2prio(irq);
+	int prio = irq2prio(d->irq);
 	u32 ic = __raw_readl(SYS_IC(prio / 4));
 	ic &= ~(1 << (7 + 8 * (3 - (prio & 3))));
 	__raw_writel(ic, SYS_IC(prio / 4));
 }
 
-static void ns9xxx_ack_irq(unsigned int irq)
+static void ns9xxx_ack_irq(struct irq_data *d)
 {
 	__raw_writel(0, SYS_ISRADDR);
 }
 
-static void ns9xxx_maskack_irq(unsigned int irq)
+static void ns9xxx_maskack_irq(struct irq_data *d)
 {
-	ns9xxx_mask_irq(irq);
-	ns9xxx_ack_irq(irq);
+	ns9xxx_mask_irq(d);
+	ns9xxx_ack_irq(d);
 }
 
-static void ns9xxx_unmask_irq(unsigned int irq)
+static void ns9xxx_unmask_irq(struct irq_data *d)
 {
 	/* XXX: better use cpp symbols */
-	int prio = irq2prio(irq);
+	int prio = irq2prio(d->irq);
 	u32 ic = __raw_readl(SYS_IC(prio / 4));
 	ic |= 1 << (7 + 8 * (3 - (prio & 3)));
 	__raw_writel(ic, SYS_IC(prio / 4));
 }
 
 static struct irq_chip ns9xxx_chip = {
-	.ack		= ns9xxx_ack_irq,
-	.mask		= ns9xxx_mask_irq,
-	.mask_ack	= ns9xxx_maskack_irq,
-	.unmask		= ns9xxx_unmask_irq,
+	.irq_ack	= ns9xxx_ack_irq,
+	.irq_mask	= ns9xxx_mask_irq,
+	.irq_mask_ack	= ns9xxx_maskack_irq,
+	.irq_unmask	= ns9xxx_unmask_irq,
 };
 
 #if 0
@@ -92,10 +92,10 @@ static void handle_prio_irq(unsigned int irq, struct irq_desc *desc)
 
 	if (desc->status & IRQ_DISABLED)
 out_mask:
-		desc->chip->mask(irq);
+		desc->irq_data.chip->irq_mask(&desc->irq_data);
 
 	/* ack unconditionally to unmask lower prio irqs */
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	raw_spin_unlock(&desc->lock);
 }
-- 
1.7.1
