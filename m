From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:53 +0100
Subject: [PATCH 24/54] ARM: ixp23xx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133653.GY15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-ixp23xx/core.c     |   55 +++++++++++++++++++++----------------
 arch/arm/mach-ixp23xx/ixdp2351.c |   36 ++++++++++++------------
 2 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-ixp23xx/core.c b/arch/arm/mach-ixp23xx/core.c
index aa4c442..9c8a339 100644
--- a/arch/arm/mach-ixp23xx/core.c
+++ b/arch/arm/mach-ixp23xx/core.c
@@ -111,9 +111,9 @@ enum ixp23xx_irq_type {
 
 static void ixp23xx_config_irq(unsigned int, enum ixp23xx_irq_type);
 
-static int ixp23xx_irq_set_type(unsigned int irq, unsigned int type)
+static int ixp23xx_irq_set_type(struct irq_data *d, unsigned int type)
 {
-	int line = irq - IRQ_IXP23XX_GPIO6 + 6;
+	int line = d->irq - IRQ_IXP23XX_GPIO6 + 6;
 	u32 int_style;
 	enum ixp23xx_irq_type irq_type;
 	volatile u32 *int_reg;
@@ -149,7 +149,7 @@ static int ixp23xx_irq_set_type(unsigned int irq, unsigned int type)
 		return -EINVAL;
 	}
 
-	ixp23xx_config_irq(irq, irq_type);
+	ixp23xx_config_irq(d->irq, irq_type);
 
 	if (line >= 8) {	/* pins 8-15 */
 		line -= 8;
@@ -173,9 +173,10 @@ static int ixp23xx_irq_set_type(unsigned int irq, unsigned int type)
 	return 0;
 }
 
-static void ixp23xx_irq_mask(unsigned int irq)
+static void ixp23xx_irq_mask(struct irq_data *d)
 {
 	volatile unsigned long *intr_reg;
+	unsigned int irq = d->irq;
 
 	if (irq >= 56)
 		irq += 8;
@@ -184,9 +185,9 @@ static void ixp23xx_irq_mask(unsigned int irq)
 	*intr_reg &= ~(1 << (irq % 32));
 }
 
-static void ixp23xx_irq_ack(unsigned int irq)
+static void ixp23xx_irq_ack(struct irq_data *d)
 {
-	int line = irq - IRQ_IXP23XX_GPIO6 + 6;
+	int line = d->irq - IRQ_IXP23XX_GPIO6 + 6;
 
 	if ((line < 6) || (line > 15))
 		return;
@@ -198,11 +199,12 @@ static void ixp23xx_irq_ack(unsigned int irq)
  * Level triggered interrupts on GPIO lines can only be cleared when the
  * interrupt condition disappears.
  */
-static void ixp23xx_irq_level_unmask(unsigned int irq)
+static void ixp23xx_irq_level_unmask(struct irq_data *d)
 {
 	volatile unsigned long *intr_reg;
+	unsigned int irq = d->irq;
 
-	ixp23xx_irq_ack(irq);
+	ixp23xx_irq_ack(d);
 
 	if (irq >= 56)
 		irq += 8;
@@ -211,9 +213,10 @@ static void ixp23xx_irq_level_unmask(unsigned int irq)
 	*intr_reg |= (1 << (irq % 32));
 }
 
-static void ixp23xx_irq_edge_unmask(unsigned int irq)
+static void ixp23xx_irq_edge_unmask(struct irq_data *d)
 {
 	volatile unsigned long *intr_reg;
+	unsigned int irq = d->irq;
 
 	if (irq >= 56)
 		irq += 8;
@@ -223,26 +226,30 @@ static void ixp23xx_irq_edge_unmask(unsigned int irq)
 }
 
 static struct irq_chip ixp23xx_irq_level_chip = {
-	.ack		= ixp23xx_irq_mask,
-	.mask		= ixp23xx_irq_mask,
-	.unmask		= ixp23xx_irq_level_unmask,
-	.set_type	= ixp23xx_irq_set_type
+	.irq_ack	= ixp23xx_irq_mask,
+	.irq_mask	= ixp23xx_irq_mask,
+	.irq_unmask	= ixp23xx_irq_level_unmask,
+	.irq_set_type	= ixp23xx_irq_set_type
 };
 
 static struct irq_chip ixp23xx_irq_edge_chip = {
-	.ack		= ixp23xx_irq_ack,
-	.mask		= ixp23xx_irq_mask,
-	.unmask		= ixp23xx_irq_edge_unmask,
-	.set_type	= ixp23xx_irq_set_type
+	.irq_ack	= ixp23xx_irq_ack,
+	.irq_mask	= ixp23xx_irq_mask,
+	.irq_unmask	= ixp23xx_irq_edge_unmask,
+	.irq_set_type	= ixp23xx_irq_set_type
 };
 
-static void ixp23xx_pci_irq_mask(unsigned int irq)
+static void ixp23xx_pci_irq_mask(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	*IXP23XX_PCI_XSCALE_INT_ENABLE &= ~(1 << (IRQ_IXP23XX_INTA + 27 - irq));
 }
 
-static void ixp23xx_pci_irq_unmask(unsigned int irq)
+static void ixp23xx_pci_irq_unmask(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	*IXP23XX_PCI_XSCALE_INT_ENABLE |= (1 << (IRQ_IXP23XX_INTA + 27 - irq));
 }
 
@@ -256,7 +263,7 @@ static void pci_handler(unsigned int irq, struct irq_desc *desc)
 
 	pci_interrupt = *IXP23XX_PCI_XSCALE_INT_STATUS;
 
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	/* See which PCI_INTA, or PCI_INTB interrupted */
 	if (pci_interrupt & (1 << 26)) {
@@ -269,13 +276,13 @@ static void pci_handler(unsigned int irq, struct irq_desc *desc)
 
 	generic_handle_irq(irqno);
 
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 static struct irq_chip ixp23xx_pci_irq_chip = {
-	.ack	= ixp23xx_pci_irq_mask,
-	.mask	= ixp23xx_pci_irq_mask,
-	.unmask	= ixp23xx_pci_irq_unmask
+	.irq_ack	= ixp23xx_pci_irq_mask,
+	.irq_mask	= ixp23xx_pci_irq_mask,
+	.irq_unmask	= ixp23xx_pci_irq_unmask
 };
 
 static void ixp23xx_config_irq(unsigned int irq, enum ixp23xx_irq_type type)
diff --git a/arch/arm/mach-ixp23xx/ixdp2351.c b/arch/arm/mach-ixp23xx/ixdp2351.c
index 664e39c..181116a 100644
--- a/arch/arm/mach-ixp23xx/ixdp2351.c
+++ b/arch/arm/mach-ixp23xx/ixdp2351.c
@@ -48,14 +48,14 @@
 /*
  * IXDP2351 Interrupt Handling
  */
-static void ixdp2351_inta_mask(unsigned int irq)
+static void ixdp2351_inta_mask(struct irq_data *d)
 {
-	*IXDP2351_CPLD_INTA_MASK_SET_REG = IXDP2351_INTA_IRQ_MASK(irq);
+	*IXDP2351_CPLD_INTA_MASK_SET_REG = IXDP2351_INTA_IRQ_MASK(d->irq);
 }
 
-static void ixdp2351_inta_unmask(unsigned int irq)
+static void ixdp2351_inta_unmask(struct irq_data *d)
 {
-	*IXDP2351_CPLD_INTA_MASK_CLR_REG = IXDP2351_INTA_IRQ_MASK(irq);
+	*IXDP2351_CPLD_INTA_MASK_CLR_REG = IXDP2351_INTA_IRQ_MASK(d->irq);
 }
 
 static void ixdp2351_inta_handler(unsigned int irq, struct irq_desc *desc)
@@ -64,7 +64,7 @@ static void ixdp2351_inta_handler(unsigned int irq, struct irq_desc *desc)
 		*IXDP2351_CPLD_INTA_STAT_REG & IXDP2351_INTA_IRQ_VALID;
 	int i;
 
-	desc->chip->mask(irq);
+	desc->irq_data.chip->irq_mask(&desc->irq_data);
 
 	for (i = 0; i < IXDP2351_INTA_IRQ_NUM; i++) {
 		if (ex_interrupt & (1 << i)) {
@@ -74,23 +74,23 @@ static void ixdp2351_inta_handler(unsigned int irq, struct irq_desc *desc)
 		}
 	}
 
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 static struct irq_chip ixdp2351_inta_chip = {
-	.ack	= ixdp2351_inta_mask,
-	.mask	= ixdp2351_inta_mask,
-	.unmask	= ixdp2351_inta_unmask
+	.irq_ack	= ixdp2351_inta_mask,
+	.irq_mask	= ixdp2351_inta_mask,
+	.irq_unmask	= ixdp2351_inta_unmask
 };
 
-static void ixdp2351_intb_mask(unsigned int irq)
+static void ixdp2351_intb_mask(struct irq_data *d)
 {
-	*IXDP2351_CPLD_INTB_MASK_SET_REG = IXDP2351_INTB_IRQ_MASK(irq);
+	*IXDP2351_CPLD_INTB_MASK_SET_REG = IXDP2351_INTB_IRQ_MASK(d->irq);
 }
 
-static void ixdp2351_intb_unmask(unsigned int irq)
+static void ixdp2351_intb_unmask(struct irq_data *d)
 {
-	*IXDP2351_CPLD_INTB_MASK_CLR_REG = IXDP2351_INTB_IRQ_MASK(irq);
+	*IXDP2351_CPLD_INTB_MASK_CLR_REG = IXDP2351_INTB_IRQ_MASK(d->irq);
 }
 
 static void ixdp2351_intb_handler(unsigned int irq, struct irq_desc *desc)
@@ -99,7 +99,7 @@ static void ixdp2351_intb_handler(unsigned int irq, struct irq_desc *desc)
 		*IXDP2351_CPLD_INTB_STAT_REG & IXDP2351_INTB_IRQ_VALID;
 	int i;
 
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	for (i = 0; i < IXDP2351_INTB_IRQ_NUM; i++) {
 		if (ex_interrupt & (1 << i)) {
@@ -109,13 +109,13 @@ static void ixdp2351_intb_handler(unsigned int irq, struct irq_desc *desc)
 		}
 	}
 
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 static struct irq_chip ixdp2351_intb_chip = {
-	.ack	= ixdp2351_intb_mask,
-	.mask	= ixdp2351_intb_mask,
-	.unmask	= ixdp2351_intb_unmask
+	.irq_ack	= ixdp2351_intb_mask,
+	.irq_mask	= ixdp2351_intb_mask,
+	.irq_unmask	= ixdp2351_intb_unmask
 };
 
 void __init ixdp2351_init_irq(void)
-- 
1.7.1
