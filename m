From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:41 +0100
Subject: [PATCH 16/54] ARM: footbridge: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133641.GQ15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-footbridge/common.c  |   14 +++++++-------
 arch/arm/mach-footbridge/isa-irq.c |   36 ++++++++++++++++++------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 88b3dd8..84c5f25 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -75,20 +75,20 @@ static const int fb_irq_mask[] = {
 	IRQ_MASK_PCI_PERR,	/* 19 */
 };
 
-static void fb_mask_irq(unsigned int irq)
+static void fb_mask_irq(struct irq_data *d)
 {
-	*CSR_IRQ_DISABLE = fb_irq_mask[_DC21285_INR(irq)];
+	*CSR_IRQ_DISABLE = fb_irq_mask[_DC21285_INR(d->irq)];
 }
 
-static void fb_unmask_irq(unsigned int irq)
+static void fb_unmask_irq(struct irq_data *d)
 {
-	*CSR_IRQ_ENABLE = fb_irq_mask[_DC21285_INR(irq)];
+	*CSR_IRQ_ENABLE = fb_irq_mask[_DC21285_INR(d->irq)];
 }
 
 static struct irq_chip fb_chip = {
-	.ack	= fb_mask_irq,
-	.mask	= fb_mask_irq,
-	.unmask = fb_unmask_irq,
+	.irq_ack	= fb_mask_irq,
+	.irq_mask	= fb_mask_irq,
+	.irq_unmask	= fb_unmask_irq,
 };
 
 static void __init __fb_init_irq(void)
diff --git a/arch/arm/mach-footbridge/isa-irq.c b/arch/arm/mach-footbridge/isa-irq.c
index 8bfd06a..de7a5cb 100644
--- a/arch/arm/mach-footbridge/isa-irq.c
+++ b/arch/arm/mach-footbridge/isa-irq.c
@@ -30,61 +30,61 @@
 
 #include "common.h"
 
-static void isa_mask_pic_lo_irq(unsigned int irq)
+static void isa_mask_pic_lo_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq & 7);
+	unsigned int mask = 1 << (d->irq & 7);
 
 	outb(inb(PIC_MASK_LO) | mask, PIC_MASK_LO);
 }
 
-static void isa_ack_pic_lo_irq(unsigned int irq)
+static void isa_ack_pic_lo_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq & 7);
+	unsigned int mask = 1 << (d->irq & 7);
 
 	outb(inb(PIC_MASK_LO) | mask, PIC_MASK_LO);
 	outb(0x20, PIC_LO);
 }
 
-static void isa_unmask_pic_lo_irq(unsigned int irq)
+static void isa_unmask_pic_lo_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq & 7);
+	unsigned int mask = 1 << (d->irq & 7);
 
 	outb(inb(PIC_MASK_LO) & ~mask, PIC_MASK_LO);
 }
 
 static struct irq_chip isa_lo_chip = {
-	.ack	= isa_ack_pic_lo_irq,
-	.mask	= isa_mask_pic_lo_irq,
-	.unmask = isa_unmask_pic_lo_irq,
+	.irq_ack	= isa_ack_pic_lo_irq,
+	.irq_mask	= isa_mask_pic_lo_irq,
+	.irq_unmask	= isa_unmask_pic_lo_irq,
 };
 
-static void isa_mask_pic_hi_irq(unsigned int irq)
+static void isa_mask_pic_hi_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq & 7);
+	unsigned int mask = 1 << (d->irq & 7);
 
 	outb(inb(PIC_MASK_HI) | mask, PIC_MASK_HI);
 }
 
-static void isa_ack_pic_hi_irq(unsigned int irq)
+static void isa_ack_pic_hi_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq & 7);
+	unsigned int mask = 1 << (d->irq & 7);
 
 	outb(inb(PIC_MASK_HI) | mask, PIC_MASK_HI);
 	outb(0x62, PIC_LO);
 	outb(0x20, PIC_HI);
 }
 
-static void isa_unmask_pic_hi_irq(unsigned int irq)
+static void isa_unmask_pic_hi_irq(struct irq_data *d)
 {
-	unsigned int mask = 1 << (irq & 7);
+	unsigned int mask = 1 << (d->irq & 7);
 
 	outb(inb(PIC_MASK_HI) & ~mask, PIC_MASK_HI);
 }
 
 static struct irq_chip isa_hi_chip = {
-	.ack	= isa_ack_pic_hi_irq,
-	.mask	= isa_mask_pic_hi_irq,
-	.unmask = isa_unmask_pic_hi_irq,
+	.irq_ack	= isa_ack_pic_hi_irq,
+	.irq_mask	= isa_mask_pic_hi_irq,
+	.irq_unmask	= isa_unmask_pic_hi_irq,
 };
 
 static void
-- 
1.7.1
