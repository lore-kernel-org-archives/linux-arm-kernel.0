From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:34 +0100
Subject: [PATCH 11/54] ARM: clps711x: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133634.GL15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-clps711x/irq.c |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-clps711x/irq.c b/arch/arm/mach-clps711x/irq.c
index 9a12d85..86da7a1 100644
--- a/arch/arm/mach-clps711x/irq.c
+++ b/arch/arm/mach-clps711x/irq.c
@@ -27,24 +27,24 @@
 
 #include <asm/hardware/clps7111.h>
 
-static void int1_mask(unsigned int irq)
+static void int1_mask(struct irq_data *d)
 {
 	u32 intmr1;
 
 	intmr1 = clps_readl(INTMR1);
-	intmr1 &= ~(1 << irq);
+	intmr1 &= ~(1 << d->irq);
 	clps_writel(intmr1, INTMR1);
 }
 
-static void int1_ack(unsigned int irq)
+static void int1_ack(struct irq_data *d)
 {
 	u32 intmr1;
 
 	intmr1 = clps_readl(INTMR1);
-	intmr1 &= ~(1 << irq);
+	intmr1 &= ~(1 << d->irq);
 	clps_writel(intmr1, INTMR1);
 
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_CSINT:  clps_writel(0, COEOI);  break;
 	case IRQ_TC1OI:  clps_writel(0, TC1EOI); break;
 	case IRQ_TC2OI:  clps_writel(0, TC2EOI); break;
@@ -54,56 +54,56 @@ static void int1_ack(unsigned int irq)
 	}
 }
 
-static void int1_unmask(unsigned int irq)
+static void int1_unmask(struct irq_data *d)
 {
 	u32 intmr1;
 
 	intmr1 = clps_readl(INTMR1);
-	intmr1 |= 1 << irq;
+	intmr1 |= 1 << d->irq;
 	clps_writel(intmr1, INTMR1);
 }
 
 static struct irq_chip int1_chip = {
-	.ack	= int1_ack,
-	.mask	= int1_mask,
-	.unmask = int1_unmask,
+	.irq_ack	= int1_ack,
+	.irq_mask	= int1_mask,
+	.irq_unmask	= int1_unmask,
 };
 
-static void int2_mask(unsigned int irq)
+static void int2_mask(struct irq_data *d)
 {
 	u32 intmr2;
 
 	intmr2 = clps_readl(INTMR2);
-	intmr2 &= ~(1 << (irq - 16));
+	intmr2 &= ~(1 << (d->irq - 16));
 	clps_writel(intmr2, INTMR2);
 }
 
-static void int2_ack(unsigned int irq)
+static void int2_ack(struct irq_data *d)
 {
 	u32 intmr2;
 
 	intmr2 = clps_readl(INTMR2);
-	intmr2 &= ~(1 << (irq - 16));
+	intmr2 &= ~(1 << (d->irq - 16));
 	clps_writel(intmr2, INTMR2);
 
-	switch (irq) {
+	switch (d->irq) {
 	case IRQ_KBDINT: clps_writel(0, KBDEOI); break;
 	}
 }
 
-static void int2_unmask(unsigned int irq)
+static void int2_unmask(struct irq_data *d)
 {
 	u32 intmr2;
 
 	intmr2 = clps_readl(INTMR2);
-	intmr2 |= 1 << (irq - 16);
+	intmr2 |= 1 << (d->irq - 16);
 	clps_writel(intmr2, INTMR2);
 }
 
 static struct irq_chip int2_chip = {
-	.ack	= int2_ack,
-	.mask	= int2_mask,
-	.unmask = int2_unmask,
+	.irq_ack	= int2_ack,
+	.irq_mask	= int2_mask,
+	.irq_unmask	= int2_unmask,
 };
 
 void __init clps711x_init_irq(void)
-- 
1.7.1
