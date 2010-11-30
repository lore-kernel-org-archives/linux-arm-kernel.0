From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:52 +0100
Subject: [PATCH 23/54] ARM: ixp2000: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133652.GX15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-ixp2000/core.c     |   70 ++++++++++++++++++++-----------------
 arch/arm/mach-ixp2000/ixdp2x00.c |   18 +++++-----
 arch/arm/mach-ixp2000/ixdp2x01.c |   18 +++++-----
 3 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
index e24e3d0..5fc4e06 100644
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -309,9 +309,9 @@ static void ixp2000_GPIO_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static int ixp2000_GPIO_irq_type(unsigned int irq, unsigned int type)
+static int ixp2000_GPIO_irq_type(struct irq_data *d, unsigned int type)
 {
-	int line = irq - IRQ_IXP2000_GPIO0;
+	int line = d->irq - IRQ_IXP2000_GPIO0;
 
 	/*
 	 * First, configure this GPIO line as an input.
@@ -342,8 +342,10 @@ static int ixp2000_GPIO_irq_type(unsigned int irq, unsigned int type)
 	return 0;
 }
 
-static void ixp2000_GPIO_irq_mask_ack(unsigned int irq)
+static void ixp2000_GPIO_irq_mask_ack(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	ixp2000_reg_write(IXP2000_GPIO_INCR, (1 << (irq - IRQ_IXP2000_GPIO0)));
 
 	ixp2000_reg_write(IXP2000_GPIO_EDSR, (1 << (irq - IRQ_IXP2000_GPIO0)));
@@ -351,38 +353,42 @@ static void ixp2000_GPIO_irq_mask_ack(unsigned int irq)
 	ixp2000_reg_wrb(IXP2000_GPIO_INST, (1 << (irq - IRQ_IXP2000_GPIO0)));
 }
 
-static void ixp2000_GPIO_irq_mask(unsigned int irq)
+static void ixp2000_GPIO_irq_mask(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	ixp2000_reg_wrb(IXP2000_GPIO_INCR, (1 << (irq - IRQ_IXP2000_GPIO0)));
 }
 
-static void ixp2000_GPIO_irq_unmask(unsigned int irq)
+static void ixp2000_GPIO_irq_unmask(struct irq_data *d)
 {
+	unsigned int irq = d->irq;
+
 	ixp2000_reg_write(IXP2000_GPIO_INSR, (1 << (irq - IRQ_IXP2000_GPIO0)));
 }
 
 static struct irq_chip ixp2000_GPIO_irq_chip = {
-	.ack		= ixp2000_GPIO_irq_mask_ack,
-	.mask		= ixp2000_GPIO_irq_mask,
-	.unmask		= ixp2000_GPIO_irq_unmask,
-	.set_type	= ixp2000_GPIO_irq_type,
+	.irq_ack	= ixp2000_GPIO_irq_mask_ack,
+	.irq_mask	= ixp2000_GPIO_irq_mask,
+	.irq_unmask	= ixp2000_GPIO_irq_unmask,
+	.irq_set_type	= ixp2000_GPIO_irq_type,
 };
 
-static void ixp2000_pci_irq_mask(unsigned int irq)
+static void ixp2000_pci_irq_mask(struct irq_data *d)
 {
 	unsigned long temp = *IXP2000_PCI_XSCALE_INT_ENABLE;
-	if (irq == IRQ_IXP2000_PCIA)
+	if (d->irq == IRQ_IXP2000_PCIA)
 		ixp2000_reg_wrb(IXP2000_PCI_XSCALE_INT_ENABLE, (temp & ~(1 << 26)));
-	else if (irq == IRQ_IXP2000_PCIB)
+	else if (d->irq == IRQ_IXP2000_PCIB)
 		ixp2000_reg_wrb(IXP2000_PCI_XSCALE_INT_ENABLE, (temp & ~(1 << 27)));
 }
 
-static void ixp2000_pci_irq_unmask(unsigned int irq)
+static void ixp2000_pci_irq_unmask(struct irq_data *d)
 {
 	unsigned long temp = *IXP2000_PCI_XSCALE_INT_ENABLE;
-	if (irq == IRQ_IXP2000_PCIA)
+	if (d->irq == IRQ_IXP2000_PCIA)
 		ixp2000_reg_write(IXP2000_PCI_XSCALE_INT_ENABLE, (temp | (1 << 26)));
-	else if (irq == IRQ_IXP2000_PCIB)
+	else if (d->irq == IRQ_IXP2000_PCIB)
 		ixp2000_reg_write(IXP2000_PCI_XSCALE_INT_ENABLE, (temp | (1 << 27)));
 }
 
@@ -401,44 +407,44 @@ static void ixp2000_err_irq_handler(unsigned int irq, struct irq_desc *desc)
 	}
 }
 
-static void ixp2000_err_irq_mask(unsigned int irq)
+static void ixp2000_err_irq_mask(struct irq_data *d)
 {
 	ixp2000_reg_write(IXP2000_IRQ_ERR_ENABLE_CLR,
-			(1 << (irq - IRQ_IXP2000_DRAM0_MIN_ERR)));
+			(1 << (d->irq - IRQ_IXP2000_DRAM0_MIN_ERR)));
 }
 
-static void ixp2000_err_irq_unmask(unsigned int irq)
+static void ixp2000_err_irq_unmask(struct irq_data *d)
 {
 	ixp2000_reg_write(IXP2000_IRQ_ERR_ENABLE_SET,
-			(1 << (irq - IRQ_IXP2000_DRAM0_MIN_ERR)));
+			(1 << (d->irq - IRQ_IXP2000_DRAM0_MIN_ERR)));
 }
 
 static struct irq_chip ixp2000_err_irq_chip = {
-	.ack	= ixp2000_err_irq_mask,
-	.mask	= ixp2000_err_irq_mask,
-	.unmask	= ixp2000_err_irq_unmask
+	.irq_ack	= ixp2000_err_irq_mask,
+	.irq_mask	= ixp2000_err_irq_mask,
+	.irq_unmask	= ixp2000_err_irq_unmask
 };
 
 static struct irq_chip ixp2000_pci_irq_chip = {
-	.ack	= ixp2000_pci_irq_mask,
-	.mask	= ixp2000_pci_irq_mask,
-	.unmask	= ixp2000_pci_irq_unmask
+	.irq_ack	= ixp2000_pci_irq_mask,
+	.irq_mask	= ixp2000_pci_irq_mask,
+	.irq_unmask	= ixp2000_pci_irq_unmask
 };
 
-static void ixp2000_irq_mask(unsigned int irq)
+static void ixp2000_irq_mask(struct irq_data *d)
 {
-	ixp2000_reg_wrb(IXP2000_IRQ_ENABLE_CLR, (1 << irq));
+	ixp2000_reg_wrb(IXP2000_IRQ_ENABLE_CLR, (1 << d->irq));
 }
 
-static void ixp2000_irq_unmask(unsigned int irq)
+static void ixp2000_irq_unmask(struct irq_data *d)
 {
-	ixp2000_reg_write(IXP2000_IRQ_ENABLE_SET, (1 << irq));
+	ixp2000_reg_write(IXP2000_IRQ_ENABLE_SET, (1 << d->irq));
 }
 
 static struct irq_chip ixp2000_irq_chip = {
-	.ack	= ixp2000_irq_mask,
-	.mask	= ixp2000_irq_mask,
-	.unmask	= ixp2000_irq_unmask
+	.irq_ack	= ixp2000_irq_mask,
+	.irq_mask	= ixp2000_irq_mask,
+	.irq_unmask	= ixp2000_irq_unmask
 };
 
 void __init ixp2000_init_irq(void)
diff --git a/arch/arm/mach-ixp2000/ixdp2x00.c b/arch/arm/mach-ixp2000/ixdp2x00.c
index 91fffb9..7d90d3f 100644
--- a/arch/arm/mach-ixp2000/ixdp2x00.c
+++ b/arch/arm/mach-ixp2000/ixdp2x00.c
@@ -63,7 +63,7 @@ static struct slowport_cfg slowport_cpld_cfg = {
 };
 #endif
 
-static void ixdp2x00_irq_mask(unsigned int irq)
+static void ixdp2x00_irq_mask(struct irq_data *d)
 {
 	unsigned long dummy;
 	static struct slowport_cfg old_cfg;
@@ -78,7 +78,7 @@ static void ixdp2x00_irq_mask(unsigned int irq)
 #endif
 
 	dummy = *board_irq_mask;
-	dummy |=  IXP2000_BOARD_IRQ_MASK(irq);
+	dummy |=  IXP2000_BOARD_IRQ_MASK(d->irq);
 	ixp2000_reg_wrb(board_irq_mask, dummy);
 
 #ifdef CONFIG_ARCH_IXDP2400
@@ -87,7 +87,7 @@ static void ixdp2x00_irq_mask(unsigned int irq)
 #endif
 }
 
-static void ixdp2x00_irq_unmask(unsigned int irq)
+static void ixdp2x00_irq_unmask(struct irq_data *d)
 {
 	unsigned long dummy;
 	static struct slowport_cfg old_cfg;
@@ -98,7 +98,7 @@ static void ixdp2x00_irq_unmask(unsigned int irq)
 #endif
 
 	dummy = *board_irq_mask;
-	dummy &=  ~IXP2000_BOARD_IRQ_MASK(irq);
+	dummy &=  ~IXP2000_BOARD_IRQ_MASK(d->irq);
 	ixp2000_reg_wrb(board_irq_mask, dummy);
 
 	if (machine_is_ixdp2400()) 
@@ -111,7 +111,7 @@ static void ixdp2x00_irq_handler(unsigned int irq, struct irq_desc *desc)
 	static struct slowport_cfg old_cfg;
 	int i;
 
-	desc->chip->mask(irq);
+	desc->irq_data.chip->irq_mask(&desc->irq_data);
 
 #ifdef CONFIG_ARCH_IXDP2400
 	if (machine_is_ixdp2400())
@@ -133,13 +133,13 @@ static void ixdp2x00_irq_handler(unsigned int irq, struct irq_desc *desc)
 		}
 	}
 
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 static struct irq_chip ixdp2x00_cpld_irq_chip = {
-	.ack	= ixdp2x00_irq_mask,
-	.mask	= ixdp2x00_irq_mask,
-	.unmask	= ixdp2x00_irq_unmask
+	.irq_ack	= ixdp2x00_irq_mask,
+	.irq_mask	= ixdp2x00_irq_mask,
+	.irq_unmask	= ixdp2x00_irq_unmask
 };
 
 void __init ixdp2x00_init_irq(volatile unsigned long *stat_reg, volatile unsigned long *mask_reg, unsigned long nr_of_irqs)
diff --git a/arch/arm/mach-ixp2000/ixdp2x01.c b/arch/arm/mach-ixp2000/ixdp2x01.c
index 6c121bd..34b1b2a 100644
--- a/arch/arm/mach-ixp2000/ixdp2x01.c
+++ b/arch/arm/mach-ixp2000/ixdp2x01.c
@@ -48,16 +48,16 @@
 /*************************************************************************
  * IXDP2x01 IRQ Handling
  *************************************************************************/
-static void ixdp2x01_irq_mask(unsigned int irq)
+static void ixdp2x01_irq_mask(struct irq_data *d)
 {
 	ixp2000_reg_wrb(IXDP2X01_INT_MASK_SET_REG,
-				IXP2000_BOARD_IRQ_MASK(irq));
+				IXP2000_BOARD_IRQ_MASK(d->irq));
 }
 
-static void ixdp2x01_irq_unmask(unsigned int irq)
+static void ixdp2x01_irq_unmask(struct irq_data *d)
 {
 	ixp2000_reg_write(IXDP2X01_INT_MASK_CLR_REG,
-				IXP2000_BOARD_IRQ_MASK(irq));
+				IXP2000_BOARD_IRQ_MASK(d->irq));
 }
 
 static u32 valid_irq_mask;
@@ -67,7 +67,7 @@ static void ixdp2x01_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 ex_interrupt;
 	int i;
 
-	desc->chip->mask(irq);
+	desc->irq_data.chip->irq_mask(&desc->irq_data);
 
 	ex_interrupt = *IXDP2X01_INT_STAT_REG & valid_irq_mask;
 
@@ -83,13 +83,13 @@ static void ixdp2x01_irq_handler(unsigned int irq, struct irq_desc *desc)
 		}
 	}
 
-	desc->chip->unmask(irq);
+	desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
 static struct irq_chip ixdp2x01_irq_chip = {
-	.mask	= ixdp2x01_irq_mask,
-	.ack	= ixdp2x01_irq_mask,
-	.unmask	= ixdp2x01_irq_unmask
+	.irq_mask	= ixdp2x01_irq_mask,
+	.irq_ack	= ixdp2x01_irq_mask,
+	.irq_unmask	= ixdp2x01_irq_unmask
 };
 
 /*
-- 
1.7.1
