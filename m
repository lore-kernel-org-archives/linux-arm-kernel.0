From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 27 Nov 2017 18:39:02 +0000
Subject: [PATCH 6/6] ARM: sa1111: map interrupt numbers through irqdomain
In-Reply-To: <20171127183811.GM31757@n2100.armlinux.org.uk>
References: <20171127183811.GM31757@n2100.armlinux.org.uk>
Message-ID: <E1eJOJ4-0006ow-1h@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Map the interrupt numbers for SA1111 through the SA1111 IRQ domain
rather than doing our own translation.  This allows us to eliminate
the irq_base sachip member.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/common/sa1111.c               | 40 ++++++++++++++++++++++------------
 arch/arm/include/asm/hardware/sa1111.h |  2 +-
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index d6a0ce7b51cf..a2c878769eaf 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -126,7 +126,7 @@ struct sa1111_dev_info {
 	unsigned long	skpcr_mask;
 	bool		dma;
 	unsigned int	devid;
-	unsigned int	irq[6];
+	unsigned int	hwirq[6];
 };
 
 static struct sa1111_dev_info sa1111_devices[] = {
@@ -135,7 +135,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 		.skpcr_mask	= SKPCR_UCLKEN,
 		.dma		= true,
 		.devid		= SA1111_DEVID_USB,
-		.irq = {
+		.hwirq = {
 			IRQ_USBPWR,
 			IRQ_HCIM,
 			IRQ_HCIBUFFACC,
@@ -149,7 +149,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 		.skpcr_mask	= SKPCR_I2SCLKEN | SKPCR_L3CLKEN,
 		.dma		= true,
 		.devid		= SA1111_DEVID_SAC,
-		.irq = {
+		.hwirq = {
 			AUDXMTDMADONEA,
 			AUDXMTDMADONEB,
 			AUDRCVDMADONEA,
@@ -165,7 +165,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 		.offset		= SA1111_KBD,
 		.skpcr_mask	= SKPCR_PTCLKEN,
 		.devid		= SA1111_DEVID_PS2_KBD,
-		.irq = {
+		.hwirq = {
 			IRQ_TPRXINT,
 			IRQ_TPTXINT
 		},
@@ -174,7 +174,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 		.offset		= SA1111_MSE,
 		.skpcr_mask	= SKPCR_PMCLKEN,
 		.devid		= SA1111_DEVID_PS2_MSE,
-		.irq = {
+		.hwirq = {
 			IRQ_MSRXINT,
 			IRQ_MSTXINT
 		},
@@ -183,7 +183,7 @@ static struct sa1111_dev_info sa1111_devices[] = {
 		.offset		= 0x1800,
 		.skpcr_mask	= 0,
 		.devid		= SA1111_DEVID_PCMCIA,
-		.irq = {
+		.hwirq = {
 			IRQ_S0_READY_NINT,
 			IRQ_S0_CD_VALID,
 			IRQ_S0_BVD1_STSCHG,
@@ -194,6 +194,11 @@ static struct sa1111_dev_info sa1111_devices[] = {
 	},
 };
 
+static int sa1111_map_irq(struct sa1111 *sachip, irq_hw_number_t hwirq)
+{
+	return irq_create_mapping(sachip->irqdomain, hwirq);
+}
+
 static void sa1111_handle_irqdomain(struct irq_domain *irqdomain, int irq)
 {
 	struct irq_desc *d = irq_to_desc(irq_linear_revmap(irqdomain, irq));
@@ -360,6 +365,10 @@ static int sa1111_irqdomain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct sa1111 *sachip = d->host_data;
 
+	/* Disallow unavailable interrupts */
+	if (hwirq > SSPROR && hwirq < AUDXMTDMADONEA)
+		return -EINVAL;
+
 	irq_set_chip_data(irq, sachip);
 	irq_set_chip_and_handler(irq, &sa1111_irq_chip, handle_edge_irq);
 	irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
@@ -443,7 +452,9 @@ static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 
 static void sa1111_remove_irq(struct sa1111 *sachip)
 {
+	struct irq_domain *domain = sachip->irqdomain;
 	void __iomem *irqbase = sachip->base + SA1111_INTC;
+	int i;
 
 	/* disable all IRQs */
 	writel_relaxed(0, irqbase + SA1111_INTEN0);
@@ -451,10 +462,10 @@ static void sa1111_remove_irq(struct sa1111 *sachip)
 	writel_relaxed(0, irqbase + SA1111_WAKEEN0);
 	writel_relaxed(0, irqbase + SA1111_WAKEEN1);
 
-	irq_domain_remove(sachip->irqdomain);
-
 	irq_set_chained_handler_and_data(sachip->irq, NULL, NULL);
-	irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
+	for (i = 0; i < SA1111_IRQ_NR; i++)
+		irq_dispose_mapping(irq_find_mapping(domain, i));
+	irq_domain_remove(domain);
 
 	release_mem_region(sachip->phys + SA1111_INTC, 512);
 }
@@ -595,7 +606,7 @@ static int sa1111_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 {
 	struct sa1111 *sachip = gc_to_sa1111(gc);
 
-	return sachip->irq_base + offset;
+	return sa1111_map_irq(sachip, offset);
 }
 
 static int sa1111_setup_gpios(struct sa1111 *sachip)
@@ -746,8 +757,8 @@ sa1111_init_one_child(struct sa1111 *sachip, struct resource *parent,
 	dev->mapbase     = sachip->base + info->offset;
 	dev->skpcr_mask  = info->skpcr_mask;
 
-	for (i = 0; i < ARRAY_SIZE(info->irq); i++)
-		dev->irq[i] = sachip->irq_base + info->irq[i];
+	for (i = 0; i < ARRAY_SIZE(info->hwirq); i++)
+		dev->hwirq[i] = info->hwirq[i];
 
 	/*
 	 * If the parent device has a DMA mask associated with it, and
@@ -1380,9 +1391,10 @@ EXPORT_SYMBOL(sa1111_disable_device);
 
 int sa1111_get_irq(struct sa1111_dev *sadev, unsigned num)
 {
-	if (num >= ARRAY_SIZE(sadev->irq))
+	struct sa1111 *sachip = sa1111_chip_driver(sadev);
+	if (num >= ARRAY_SIZE(sadev->hwirq))
 		return -EINVAL;
-	return sadev->irq[num];
+	return sa1111_map_irq(sachip, sadev->hwirq[num]);
 }
 EXPORT_SYMBOL_GPL(sa1111_get_irq);
 
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index 709980647dd1..798e520e8a49 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -390,7 +390,7 @@ struct sa1111_dev {
 	struct resource	res;
 	void __iomem	*mapbase;
 	unsigned int	skpcr_mask;
-	unsigned int	irq[6];
+	unsigned int	hwirq[6];
 	u64		dma_mask;
 };
 
-- 
2.7.4
