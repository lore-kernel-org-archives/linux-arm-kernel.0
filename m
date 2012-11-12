From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 12 Nov 2012 14:50:14 +0100
Subject: [RFC PATCH 4/4] ARM: S3C24XX: First part converting irq code to use
 hwirq
In-Reply-To: <201211121446.30167.heiko@sntech.de>
References: <201211121446.30167.heiko@sntech.de>
Message-ID: <201211121450.19151.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly introduced irq_domains to let the basic ack, mask and unmask
functions use its hwirq field. This also includes the external irq sources
and removes all offset calculations based on the static irq numbers from
these parts.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/irq-pm.c           |    4 +-
 arch/arm/plat-samsung/include/plat/irq.h |    8 +-
 drivers/irqchip/irq-s3c24xx.c            |  109 ++++++++++++++++++------------
 3 files changed, 71 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
index 0efb2e2..5aa7e28 100644
--- a/arch/arm/mach-s3c24xx/irq-pm.c
+++ b/arch/arm/mach-s3c24xx/irq-pm.c
@@ -29,12 +29,12 @@
  * set bit to 1 in allow bitfield to enable the wakeup settings on it
 */
 
-unsigned long s3c_irqwake_intallow	= 1L << (IRQ_RTC - IRQ_EINT0) | 0xfL;
+unsigned long s3c_irqwake_intallow	= 1L << 30 | 0xfL;
 unsigned long s3c_irqwake_eintallow	= 0x0000fff0L;
 
 int s3c_irq_wake(struct irq_data *data, unsigned int state)
 {
-	unsigned long irqbit = 1 << (data->irq - IRQ_EINT0);
+	unsigned long irqbit = 1 << (data->hwirq);
 
 	if (!(s3c_irqwake_intallow & irqbit))
 		return -ENOENT;
diff --git a/arch/arm/plat-samsung/include/plat/irq.h b/arch/arm/plat-samsung/include/plat/irq.h
index 3ae54dc..d024d7a 100644
--- a/arch/arm/plat-samsung/include/plat/irq.h
+++ b/arch/arm/plat-samsung/include/plat/irq.h
@@ -35,7 +35,7 @@ static inline void s3c_irqsub_mask(struct irq_data *data,
 	submask = __raw_readl(S3C2410_INTSUBMSK);
 	mask = __raw_readl(S3C2410_INTMSK);
 
-	submask |= (1UL << (data->irq - IRQ_S3CUART_RX0));
+	submask |= (1UL << data->hwirq);
 
 	/* check to see if we need to mask the parent IRQ */
 
@@ -56,7 +56,7 @@ static inline void s3c_irqsub_unmask(struct irq_data *data,
 	submask = __raw_readl(S3C2410_INTSUBMSK);
 	mask = __raw_readl(S3C2410_INTMSK);
 
-	submask &= ~(1UL << (data->irq - IRQ_S3CUART_RX0));
+	submask &= ~(1UL << data->hwirq);
 	mask &= ~parentbit;
 
 	/* write back masks */
@@ -69,7 +69,7 @@ static inline void s3c_irqsub_maskack(struct irq_data *data,
 				      unsigned int parentmask,
 				      unsigned int group)
 {
-	unsigned int bit = 1UL << (data->irq - IRQ_S3CUART_RX0);
+	unsigned int bit = 1UL << data->hwirq;
 
 	s3c_irqsub_mask(data, parentmask, group);
 
@@ -90,7 +90,7 @@ static inline void s3c_irqsub_ack(struct irq_data *data,
 				  unsigned int parentmask,
 				  unsigned int group)
 {
-	unsigned int bit = 1UL << (data->irq - IRQ_S3CUART_RX0);
+	unsigned int bit = 1UL << data->hwirq;
 
 	__raw_writel(bit, S3C2410_SUBSRCPND);
 
diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 073e614..804fda1 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -39,18 +39,17 @@
 static void
 s3c_irq_mask(struct irq_data *data)
 {
-	unsigned int irqno = data->irq - IRQ_EINT0;
 	unsigned long mask;
 
 	mask = __raw_readl(S3C2410_INTMSK);
-	mask |= 1UL << irqno;
+	mask |= 1UL << data->hwirq;
 	__raw_writel(mask, S3C2410_INTMSK);
 }
 
 static inline void
 s3c_irq_ack(struct irq_data *data)
 {
-	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
+	unsigned long bitval = 1UL << data->hwirq;
 
 	__raw_writel(bitval, S3C2410_SRCPND);
 	__raw_writel(bitval, S3C2410_INTPND);
@@ -59,7 +58,7 @@ s3c_irq_ack(struct irq_data *data)
 static inline void
 s3c_irq_maskack(struct irq_data *data)
 {
-	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
+	unsigned long bitval = 1UL << data->hwirq;
 	unsigned long mask;
 
 	mask = __raw_readl(S3C2410_INTMSK);
@@ -79,10 +78,8 @@ s3c_irq_unmask(struct irq_data *data)
 	if (irqno != IRQ_TIMER4 && irqno != IRQ_EINT8t23)
 		irqdbf2("s3c_irq_unmask %d\n", irqno);
 
-	irqno -= IRQ_EINT0;
-
 	mask = __raw_readl(S3C2410_INTMSK);
-	mask &= ~(1UL << irqno);
+	mask &= ~(1UL << data->hwirq);
 	__raw_writel(mask, S3C2410_INTMSK);
 }
 
@@ -105,11 +102,10 @@ struct irq_chip s3c_irq_chip = {
 static void
 s3c_irqext_mask(struct irq_data *data)
 {
-	unsigned int irqno = data->irq - EXTINT_OFF;
 	unsigned long mask;
 
 	mask = __raw_readl(S3C24XX_EINTMASK);
-	mask |= ( 1UL << irqno);
+	mask |= ( 1UL << data->hwirq);
 	__raw_writel(mask, S3C24XX_EINTMASK);
 }
 
@@ -120,7 +116,7 @@ s3c_irqext_ack(struct irq_data *data)
 	unsigned long bit;
 	unsigned long mask;
 
-	bit = 1UL << (data->irq - EXTINT_OFF);
+	bit = 1UL << data->hwirq;
 
 	mask = __raw_readl(S3C24XX_EINTMASK);
 
@@ -132,10 +128,10 @@ s3c_irqext_ack(struct irq_data *data)
 	/* not sure if we should be acking the parent irq... */
 
 	if (data->irq <= IRQ_EINT7) {
-		if ((req & 0xf0) == 0)
+		if ((req & 0xf0) == 0) /* FIXME: use parent irq-domain */
 			s3c_irq_ack(irq_get_irq_data(IRQ_EINT4t7));
 	} else {
-		if ((req >> 8) == 0)
+		if ((req >> 8) == 0) /* FIXME: use parent irq-domain */
 			s3c_irq_ack(irq_get_irq_data(IRQ_EINT8t23));
 	}
 }
@@ -143,46 +139,21 @@ s3c_irqext_ack(struct irq_data *data)
 static void
 s3c_irqext_unmask(struct irq_data *data)
 {
-	unsigned int irqno = data->irq - EXTINT_OFF;
 	unsigned long mask;
 
 	mask = __raw_readl(S3C24XX_EINTMASK);
-	mask &= ~(1UL << irqno);
+	mask &= ~(1UL << data->hwirq);
 	__raw_writel(mask, S3C24XX_EINTMASK);
 }
 
-int
-s3c_irqext_type(struct irq_data *data, unsigned int type)
+static int s3c_irqext_set_type(void __iomem *gpcon_reg,
+			       void __iomem *extint_reg,
+			       unsigned long gpcon_offset,
+			       unsigned long extint_offset,
+			       unsigned int type)
 {
-	void __iomem *extint_reg;
-	void __iomem *gpcon_reg;
-	unsigned long gpcon_offset, extint_offset;
 	unsigned long newvalue = 0, value;
 
-	if ((data->irq >= IRQ_EINT0) && (data->irq <= IRQ_EINT3)) {
-		gpcon_reg = S3C2410_GPFCON;
-		extint_reg = S3C24XX_EXTINT0;
-		gpcon_offset = (data->irq - IRQ_EINT0) * 2;
-		extint_offset = (data->irq - IRQ_EINT0) * 4;
-	} else if ((data->irq >= IRQ_EINT4) && (data->irq <= IRQ_EINT7)) {
-		gpcon_reg = S3C2410_GPFCON;
-		extint_reg = S3C24XX_EXTINT0;
-		gpcon_offset = (data->irq - (EXTINT_OFF)) * 2;
-		extint_offset = (data->irq - (EXTINT_OFF)) * 4;
-	} else if ((data->irq >= IRQ_EINT8) && (data->irq <= IRQ_EINT15)) {
-		gpcon_reg = S3C2410_GPGCON;
-		extint_reg = S3C24XX_EXTINT1;
-		gpcon_offset = (data->irq - IRQ_EINT8) * 2;
-		extint_offset = (data->irq - IRQ_EINT8) * 4;
-	} else if ((data->irq >= IRQ_EINT16) && (data->irq <= IRQ_EINT23)) {
-		gpcon_reg = S3C2410_GPGCON;
-		extint_reg = S3C24XX_EXTINT2;
-		gpcon_offset = (data->irq - IRQ_EINT8) * 2;
-		extint_offset = (data->irq - IRQ_EINT16) * 4;
-	} else {
-		return -1;
-	}
-
 	/* Set the GPIO to external interrupt mode */
 	value = __raw_readl(gpcon_reg);
 	value = (value & ~(3 << gpcon_offset)) | (0x02 << gpcon_offset);
@@ -227,6 +198,56 @@ s3c_irqext_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+int
+s3c_irqext_type(struct irq_data *data, unsigned int type)
+{
+	void __iomem *extint_reg;
+	void __iomem *gpcon_reg;
+	unsigned long gpcon_offset, extint_offset;
+
+	if ((data->hwirq >= 4) && (data->hwirq <= 7)) {
+		gpcon_reg = S3C2410_GPFCON;
+		extint_reg = S3C24XX_EXTINT0;
+		gpcon_offset = (data->hwirq) * 2;
+		extint_offset = (data->hwirq) * 4;
+	} else if ((data->hwirq >= 8) && (data->hwirq <= 15)) {
+		gpcon_reg = S3C2410_GPGCON;
+		extint_reg = S3C24XX_EXTINT1;
+		gpcon_offset = (data->hwirq - 8) * 2;
+		extint_offset = (data->hwirq - 8) * 4;
+	} else if ((data->hwirq >= 16) && (data->hwirq <= 23)) {
+		gpcon_reg = S3C2410_GPGCON;
+		extint_reg = S3C24XX_EXTINT2;
+		gpcon_offset = (data->hwirq - 8) * 2;
+		extint_offset = (data->hwirq - 16) * 4;
+	} else {
+		return -EINVAL;
+	}
+
+	return s3c_irqext_set_type(gpcon_reg, extint_reg, gpcon_offset,
+				   extint_offset, type);
+}
+
+int
+s3c_irqext0_type(struct irq_data *data, unsigned int type)
+{
+	void __iomem *extint_reg;
+	void __iomem *gpcon_reg;
+	unsigned long gpcon_offset, extint_offset;
+
+	if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
+		gpcon_reg = S3C2410_GPFCON;
+		extint_reg = S3C24XX_EXTINT0;
+		gpcon_offset = (data->hwirq) * 2;
+		extint_offset = (data->hwirq) * 4;
+	} else {
+		return -EINVAL;
+	}
+
+	return s3c_irqext_set_type(gpcon_reg, extint_reg, gpcon_offset,
+				   extint_offset, type);
+}
+
 static struct irq_chip s3c_irqext_chip = {
 	.name		= "s3c-ext",
 	.irq_mask	= s3c_irqext_mask,
@@ -242,7 +263,7 @@ static struct irq_chip s3c_irq_eint0t4 = {
 	.irq_mask	= s3c_irq_mask,
 	.irq_unmask	= s3c_irq_unmask,
 	.irq_set_wake	= s3c_irq_wake,
-	.irq_set_type	= s3c_irqext_type,
+	.irq_set_type	= s3c_irqext0_type,
 };
 
 /* mask values for the parent registers for each of the interrupt types */
-- 
1.7.2.3
