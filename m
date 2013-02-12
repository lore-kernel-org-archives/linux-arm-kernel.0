From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Feb 2013 01:05:45 +0100
Subject: [PATCH 3/3] ARM: S3C24XX: handle s3c2412 eints using new
 infrastructure
In-Reply-To: <201302120102.03511.heiko@sntech.de>
References: <201302120102.03511.heiko@sntech.de>
Message-ID: <201302120105.45608.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c2412 handles the eints 0 to 3 different than all the other SoCs
of the 24xx range. These eints must be acked and masked in the regular
bits as well as the bits 0 to 3 of the eint registers, which are unused
on the other SoCs.

This of course can be realized using the new infrastructure with the
eint bits in the main register being the parent interrupts of the
same bits in the eint register.

The s3c2412 therefore gets its own IRQ_EINT0 to 4 constants that
reside in the newly created gap before IRQ_EINT4. gpio-samsung, as the
only user of these is modified to return the correct values when
handling gpio_to_irq requests on s3c2412 based machines.

Due to lack of hardware this is compile tested only, but should
hopefully work as intended.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/include/mach/irqs.h |    4 +
 arch/arm/mach-s3c24xx/irq.c               |  118 +++++++++--------------------
 drivers/gpio/gpio-samsung.c               |    5 +-
 3 files changed, 44 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/include/mach/irqs.h b/arch/arm/mach-s3c24xx/include/mach/irqs.h
index ea589e4..43cada8 100644
--- a/arch/arm/mach-s3c24xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c24xx/include/mach/irqs.h
@@ -59,6 +59,10 @@
 #define IRQ_ADCPARENT  S3C2410_IRQ(31)
 
 /* interrupts generated from the external interrupts sources */
+#define IRQ_EINT0_2412 S3C2410_IRQ(32)
+#define IRQ_EINT1_2412 S3C2410_IRQ(33)
+#define IRQ_EINT2_2412 S3C2410_IRQ(34)
+#define IRQ_EINT3_2412 S3C2410_IRQ(35)
 #define IRQ_EINT4      S3C2410_IRQ(36)	   /* 52 */
 #define IRQ_EINT5      S3C2410_IRQ(37)
 #define IRQ_EINT6      S3C2410_IRQ(38)
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index 67e8d82..debf606 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -344,7 +344,10 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 	case S3C_IRQTYPE_NONE:
 		return 0;
 	case S3C_IRQTYPE_EINT:
-		if (irq_data->parent_irq)
+		/* On the S3C2412, the EINT0to3 have a parent irq
+		 * but need the s3c_irq_eint0t4 chip
+		 */
+		if (irq_data->parent_irq && (!soc_is_s3c2412() || hw >= 4))
 			irq_set_chip_and_handler(virq, &s3c_irqext_chip,
 						 handle_edge_irq);
 		else
@@ -625,10 +628,10 @@ void __init s3c24xx_init_irq(void)
 
 #ifdef CONFIG_CPU_S3C2412
 static struct s3c_irq_data init_s3c2412base[32] = {
-	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
-	{ .type = S3C_IRQTYPE_EINT, }, /* EINT1 */
-	{ .type = S3C_IRQTYPE_EINT, }, /* EINT2 */
-	{ .type = S3C_IRQTYPE_EINT, }, /* EINT3 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT0 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT1 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT2 */
+	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT3 */
 	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT4to7 */
 	{ .type = S3C_IRQTYPE_LEVEL, }, /* EINT8to23 */
 	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
@@ -659,6 +662,33 @@ static struct s3c_irq_data init_s3c2412base[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, }, /* ADCPARENT */
 };
 
+static struct s3c_irq_data init_s3c2412eint[32] = {
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 0 }, /* EINT0 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 1 }, /* EINT1 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 2 }, /* EINT2 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 3 }, /* EINT3 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT4 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT5 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT6 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 4 }, /* EINT7 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT8 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT9 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT10 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT11 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT12 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT13 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT14 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT15 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT16 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT17 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT18 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT19 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT20 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT21 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT22 */
+	{ .type = S3C_IRQTYPE_EINT, .parent_irq = 5 }, /* EINT23 */
+};
+
 static struct s3c_irq_data init_s3c2412subint[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-RX */
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 28 }, /* UART0-TX */
@@ -677,77 +707,9 @@ static struct s3c_irq_data init_s3c2412subint[32] = {
 	{ .type = S3C_IRQTYPE_LEVEL, .parent_irq = 21 }, /* CF */
 };
 
-/* the s3c2412 changes the behaviour of IRQ_EINT0 through IRQ_EINT3 by
- * having them turn up in both the INT* and the EINT* registers. Whilst
- * both show the status, they both now need to be acked when the IRQs
- * go off.
-*/
-
-static void
-s3c2412_irq_mask(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
-	unsigned long mask;
-
-	mask = __raw_readl(S3C2410_INTMSK);
-	__raw_writel(mask | bitval, S3C2410_INTMSK);
-
-	mask = __raw_readl(S3C2412_EINTMASK);
-	__raw_writel(mask | bitval, S3C2412_EINTMASK);
-}
-
-static inline void
-s3c2412_irq_ack(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
-
-	__raw_writel(bitval, S3C2412_EINTPEND);
-	__raw_writel(bitval, S3C2410_SRCPND);
-	__raw_writel(bitval, S3C2410_INTPND);
-}
-
-static inline void
-s3c2412_irq_maskack(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
-	unsigned long mask;
-
-	mask = __raw_readl(S3C2410_INTMSK);
-	__raw_writel(mask|bitval, S3C2410_INTMSK);
-
-	mask = __raw_readl(S3C2412_EINTMASK);
-	__raw_writel(mask | bitval, S3C2412_EINTMASK);
-
-	__raw_writel(bitval, S3C2412_EINTPEND);
-	__raw_writel(bitval, S3C2410_SRCPND);
-	__raw_writel(bitval, S3C2410_INTPND);
-}
-
-static void
-s3c2412_irq_unmask(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_EINT0);
-	unsigned long mask;
-
-	mask = __raw_readl(S3C2412_EINTMASK);
-	__raw_writel(mask & ~bitval, S3C2412_EINTMASK);
-
-	mask = __raw_readl(S3C2410_INTMSK);
-	__raw_writel(mask & ~bitval, S3C2410_INTMSK);
-}
-
-static struct irq_chip s3c2412_irq_eint0t4 = {
-	.irq_ack	= s3c2412_irq_ack,
-	.irq_mask	= s3c2412_irq_mask,
-	.irq_unmask	= s3c2412_irq_unmask,
-	.irq_set_wake	= s3c_irq_wake,
-	.irq_set_type	= s3c_irqext_type,
-};
-
 void s3c2412_init_irq(void)
 {
 	struct s3c_irq_intc *main_intc;
-	unsigned int irqno;
 
 	pr_info("S3C2412: IRQ Support\n");
 
@@ -761,16 +723,8 @@ void s3c2412_init_irq(void)
 		return;
 	}
 
-	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
+	s3c24xx_init_intc(NULL, &init_s3c2412eint[0], main_intc, 0x560000a4);
 	s3c24xx_init_intc(NULL, &init_s3c2412subint[0], main_intc, 0x4a000018);
-
-	/* special handling for eints 0 to 3 */
-
-	for (irqno = IRQ_EINT0; irqno <= IRQ_EINT3; irqno++) {
-		irq_set_chip_and_handler(irqno, &s3c2412_irq_eint0t4,
-					 handle_edge_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
 }
 #endif
 
diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 49b4292..cb4a55b 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -1123,7 +1123,10 @@ int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
 static int s3c24xx_gpiolib_fbank_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	if (offset < 4)
-		return IRQ_EINT0 + offset;
+		if (soc_is_s3c2412())
+			return IRQ_EINT0_2412 + offset;
+		else
+			return IRQ_EINT0 + offset;
 
 	if (offset < 8)
 		return IRQ_EINT4 + offset - 4;
-- 
1.7.2.3
