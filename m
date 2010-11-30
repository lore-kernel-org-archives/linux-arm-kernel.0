From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:54 +0100
Subject: [PATCH 25/54] ARM: ixp4xx: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133654.GZ15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-ixp4xx/common.c |   42 ++++++++++++++++++++--------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 0bce097..886a875 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -127,9 +127,9 @@ int irq_to_gpio(unsigned int irq)
 }
 EXPORT_SYMBOL(irq_to_gpio);
 
-static int ixp4xx_set_irq_type(unsigned int irq, unsigned int type)
+static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 {
-	int line = irq2gpio[irq];
+	int line = irq2gpio[d->irq];
 	u32 int_style;
 	enum ixp4xx_irq_type irq_type;
 	volatile u32 *int_reg;
@@ -166,9 +166,9 @@ static int ixp4xx_set_irq_type(unsigned int irq, unsigned int type)
 	}
 
 	if (irq_type == IXP4XX_IRQ_EDGE)
-		ixp4xx_irq_edge |= (1 << irq);
+		ixp4xx_irq_edge |= (1 << d->irq);
 	else
-		ixp4xx_irq_edge &= ~(1 << irq);
+		ixp4xx_irq_edge &= ~(1 << d->irq);
 
 	if (line >= 8) {	/* pins 8-15 */
 		line -= 8;
@@ -187,22 +187,22 @@ static int ixp4xx_set_irq_type(unsigned int irq, unsigned int type)
 	*int_reg |= (int_style << (line * IXP4XX_GPIO_STYLE_SIZE));
 
 	/* Configure the line as an input */
-	gpio_line_config(irq2gpio[irq], IXP4XX_GPIO_IN);
+	gpio_line_config(irq2gpio[d->irq], IXP4XX_GPIO_IN);
 
 	return 0;
 }
 
-static void ixp4xx_irq_mask(unsigned int irq)
+static void ixp4xx_irq_mask(struct irq_data *d)
 {
-	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && irq >= 32)
-		*IXP4XX_ICMR2 &= ~(1 << (irq - 32));
+	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->irq >= 32)
+		*IXP4XX_ICMR2 &= ~(1 << (d->irq - 32));
 	else
-		*IXP4XX_ICMR &= ~(1 << irq);
+		*IXP4XX_ICMR &= ~(1 << d->irq);
 }
 
-static void ixp4xx_irq_ack(unsigned int irq)
+static void ixp4xx_irq_ack(struct irq_data *d)
 {
-	int line = (irq < 32) ? irq2gpio[irq] : -1;
+	int line = (d->irq < 32) ? irq2gpio[d->irq] : -1;
 
 	if (line >= 0)
 		*IXP4XX_GPIO_GPISR = (1 << line);
@@ -212,23 +212,23 @@ static void ixp4xx_irq_ack(unsigned int irq)
  * Level triggered interrupts on GPIO lines can only be cleared when the
  * interrupt condition disappears.
  */
-static void ixp4xx_irq_unmask(unsigned int irq)
+static void ixp4xx_irq_unmask(struct irq_data *d)
 {
-	if (!(ixp4xx_irq_edge & (1 << irq)))
-		ixp4xx_irq_ack(irq);
+	if (!(ixp4xx_irq_edge & (1 << d->irq)))
+		ixp4xx_irq_ack(d);
 
-	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && irq >= 32)
-		*IXP4XX_ICMR2 |= (1 << (irq - 32));
+	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->irq >= 32)
+		*IXP4XX_ICMR2 |= (1 << (d->irq - 32));
 	else
-		*IXP4XX_ICMR |= (1 << irq);
+		*IXP4XX_ICMR |= (1 << d->irq);
 }
 
 static struct irq_chip ixp4xx_irq_chip = {
 	.name		= "IXP4xx",
-	.ack		= ixp4xx_irq_ack,
-	.mask		= ixp4xx_irq_mask,
-	.unmask		= ixp4xx_irq_unmask,
-	.set_type	= ixp4xx_set_irq_type,
+	.irq_ack	= ixp4xx_irq_ack,
+	.irq_mask	= ixp4xx_irq_mask,
+	.irq_unmask	= ixp4xx_irq_unmask,
+	.irq_set_type	= ixp4xx_set_irq_type,
 };
 
 void __init ixp4xx_init_irq(void)
-- 
1.7.1
