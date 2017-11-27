From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 18:38:56 +0000
Subject: [PATCH 5/6] ARM: sa1111: use an irqdomain for SA1111 interrupts
In-Reply-To: <20171127183811.GM31757@n2100.armlinux.org.uk>
References: <20171127183811.GM31757@n2100.armlinux.org.uk>
Message-ID: <E1eJOIy-0006on-LY@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use an IRQ domain for SA1111 interrupts, which allows us to separate the
hardware interrupt number from the Linux interrupt number.  We can then
use the hardware interrupt number stored in the irq_data to calculate
the register offsets and mask.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c | 79 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 36c2162c95af..d6a0ce7b51cf 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -108,6 +108,7 @@ struct sa1111 {
 	spinlock_t	lock;
 	void __iomem	*base;
 	struct sa1111_platform_data *pdata;
+	struct irq_domain *irqdomain;
 	struct gpio_chip gc;
 #ifdef CONFIG_PM
 	void		*saved_state;
@@ -193,6 +194,14 @@ static struct sa1111_dev_info sa1111_devices[] = {
 	},
 };
 
+static void sa1111_handle_irqdomain(struct irq_domain *irqdomain, int irq)
+{
+	struct irq_desc *d = irq_to_desc(irq_linear_revmap(irqdomain, irq));
+
+	if (d)
+		generic_handle_irq_desc(d);
+}
+
 /*
  * SA1111 interrupt support.  Since clearing an IRQ while there are
  * active IRQs causes the interrupt output to pulse, the upper levels
@@ -202,6 +211,7 @@ static void sa1111_irq_handler(struct irq_desc *desc)
 {
 	unsigned int stat0, stat1, i;
 	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
+	struct irq_domain *irqdomain;
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
 
 	stat0 = readl_relaxed(mapbase + SA1111_INTSTATCLR0);
@@ -218,33 +228,28 @@ static void sa1111_irq_handler(struct irq_desc *desc)
 		return;
 	}
 
+	irqdomain = sachip->irqdomain;
+
 	for (i = 0; stat0; i++, stat0 >>= 1)
 		if (stat0 & 1)
-			generic_handle_irq(i + sachip->irq_base);
+			sa1111_handle_irqdomain(irqdomain, i);
 
 	for (i = 32; stat1; i++, stat1 >>= 1)
 		if (stat1 & 1)
-			generic_handle_irq(i + sachip->irq_base);
+			sa1111_handle_irqdomain(irqdomain, i);
 
 	/* For level-based interrupts */
 	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
-#define SA1111_IRQMASK_LO(x)	(1 << (x - sachip->irq_base))
-#define SA1111_IRQMASK_HI(x)	(1 << (x - sachip->irq_base - 32))
-
 static u32 sa1111_irqmask(struct irq_data *d)
 {
-	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
-
-	return BIT((d->irq - sachip->irq_base) & 31);
+	return BIT(irqd_to_hwirq(d) & 31);
 }
 
 static int sa1111_irqbank(struct irq_data *d)
 {
-	struct sa1111 *sachip = irq_data_get_irq_chip_data(d);
-
-	return ((d->irq - sachip->irq_base) / 32) * 4;
+	return (irqd_to_hwirq(d) / 32) * 4;
 }
 
 static void sa1111_ack_irq(struct irq_data *d)
@@ -350,10 +355,26 @@ static struct irq_chip sa1111_irq_chip = {
 	.irq_set_wake	= sa1111_wake_irq,
 };
 
+static int sa1111_irqdomain_map(struct irq_domain *d, unsigned int irq,
+	irq_hw_number_t hwirq)
+{
+	struct sa1111 *sachip = d->host_data;
+
+	irq_set_chip_data(irq, sachip);
+	irq_set_chip_and_handler(irq, &sa1111_irq_chip, handle_edge_irq);
+	irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
+
+	return 0;
+}
+
+static const struct irq_domain_ops sa1111_irqdomain_ops = {
+	.map = sa1111_irqdomain_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
 static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 {
 	void __iomem *irqbase = sachip->base + SA1111_INTC;
-	unsigned i, irq;
 	int ret;
 
 	/*
@@ -391,19 +412,21 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR0);
 	writel_relaxed(~0, irqbase + SA1111_INTSTATCLR1);
 
-	for (i = IRQ_GPAIN0; i <= SSPROR; i++) {
-		irq = sachip->irq_base + i;
-		irq_set_chip_and_handler(irq, &sa1111_irq_chip, handle_edge_irq);
-		irq_set_chip_data(irq, sachip);
-		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
+	sachip->irqdomain = irq_domain_add_linear(NULL, SA1111_IRQ_NR,
+						  &sa1111_irqdomain_ops,
+						  sachip);
+	if (!sachip->irqdomain) {
+		irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
+		return -ENOMEM;
 	}
 
-	for (i = AUDXMTDMADONEA; i <= IRQ_S1_BVD1_STSCHG; i++) {
-		irq = sachip->irq_base + i;
-		irq_set_chip_and_handler(irq, &sa1111_irq_chip, handle_edge_irq);
-		irq_set_chip_data(irq, sachip);
-		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
-	}
+	irq_domain_associate_many(sachip->irqdomain,
+				  sachip->irq_base + IRQ_GPAIN0,
+				  IRQ_GPAIN0, SSPROR + 1 - IRQ_GPAIN0);
+	irq_domain_associate_many(sachip->irqdomain,
+				  sachip->irq_base + AUDXMTDMADONEA,
+				  AUDXMTDMADONEA,
+				  IRQ_S1_BVD1_STSCHG + 1 - AUDXMTDMADONEA);
 
 	/*
 	 * Register SA1111 interrupt
@@ -428,12 +451,12 @@ static void sa1111_remove_irq(struct sa1111 *sachip)
 	writel_relaxed(0, irqbase + SA1111_WAKEEN0);
 	writel_relaxed(0, irqbase + SA1111_WAKEEN1);
 
-	if (sachip->irq != NO_IRQ) {
-		irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
-		irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
+	irq_domain_remove(sachip->irqdomain);
 
-		release_mem_region(sachip->phys + SA1111_INTC, 512);
-	}
+	irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
+	irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
+
+	release_mem_region(sachip->phys + SA1111_INTC, 512);
 }
 
 enum {
-- 
2.7.4
