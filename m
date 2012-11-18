From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 18 Nov 2012 01:55:53 +0100
Subject: [PATCH 07/10] ARM: S3C24XX: assimilate second s3c2416 interrupt into
 new structure
In-Reply-To: <201211180151.01029.heiko@sntech.de>
References: <201211180151.01029.heiko@sntech.de>
Message-ID: <201211180155.53448.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interrupt ack,mask and unmask functions for the main interrupt
register are also able to handle the second one of the s3c2416.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/irq.c |  118 ++++++++++++++++---------------------------
 1 files changed, 43 insertions(+), 75 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index ace7e34..675a5f9 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -22,6 +22,7 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/syscore_ops.h>
+#include <linux/slab.h>
 
 #include <linux/irqdomain.h>
 
@@ -54,6 +55,9 @@
 /* s3c_irqext_chip + edge handler */
 #define S3C_IRQTYPE_SUBEINT	6
 
+/* s3c2416_irq2_chip + edge handler */
+#define S3C_IRQTYPE_S3C2416	7
+
 struct s3c_irq_data {
 	unsigned int type;
 	unsigned long parent_irq;
@@ -164,6 +168,13 @@ struct irq_chip s3c_irq_chip = {
 	.irq_set_wake	= s3c_irq_wake
 };
 
+struct irq_chip s3c2416_irq_second = {
+	.name		= "s3c2416",
+	.irq_ack	= s3c_irq_ack,
+	.irq_mask	= s3c_irq_mask,
+	.irq_unmask	= s3c_irq_unmask,
+};
+
 static void s3c_irqext_ack(struct irq_data *data)
 {
 	struct s3c_irq_intc *intc = data->domain->host_data;
@@ -516,6 +527,11 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 		set_irq_flags(virq, IRQF_VALID);
 		attach_to_parent = true;
 		break;
+	case S3C_IRQTYPE_S3C2416:
+		irq_set_chip_and_handler(virq, &s3c2416_irq_second,
+					 handle_edge_irq);
+		set_irq_flags(virq, IRQF_VALID);
+		break;
 	default:
 		pr_err("irq-s3c24xx: unsupported irqtype %d\n", irq_data->type);
 		return -EINVAL;
@@ -800,80 +816,6 @@ struct s3c_irq_data init_s3c2443base[32] = {
 #endif
 
 #ifdef CONFIG_CPU_S3C2416
-
-/* second interrupt register */
-
-static inline void s3c2416_irq_ack_second(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
-
-	__raw_writel(bitval, S3C2416_SRCPND2);
-	__raw_writel(bitval, S3C2416_INTPND2);
-}
-
-static void s3c2416_irq_mask_second(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
-	unsigned long mask;
-
-	mask = __raw_readl(S3C2416_INTMSK2);
-	mask |= bitval;
-	__raw_writel(mask, S3C2416_INTMSK2);
-}
-
-static void s3c2416_irq_unmask_second(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
-	unsigned long mask;
-
-	mask = __raw_readl(S3C2416_INTMSK2);
-	mask &= ~bitval;
-	__raw_writel(mask, S3C2416_INTMSK2);
-}
-
-struct irq_chip s3c2416_irq_second = {
-	.irq_ack	= s3c2416_irq_ack_second,
-	.irq_mask	= s3c2416_irq_mask_second,
-	.irq_unmask	= s3c2416_irq_unmask_second,
-};
-
-
-static void s3c2416_irq_add_second(void)
-{
-	unsigned long pend;
-	unsigned long last;
-	int irqno;
-	int i;
-
-	/* first, clear all interrupts pending... */
-	last = 0;
-	for (i = 0; i < 4; i++) {
-		pend = __raw_readl(S3C2416_INTPND2);
-
-		if (pend == 0 || pend == last)
-			break;
-
-		__raw_writel(pend, S3C2416_SRCPND2);
-		__raw_writel(pend, S3C2416_INTPND2);
-		printk(KERN_INFO "irq: clearing pending status %08x\n",
-		       (int)pend);
-		last = pend;
-	}
-
-	for (irqno = IRQ_S3C2416_2D; irqno <= IRQ_S3C2416_I2S1; irqno++) {
-		switch (irqno) {
-		case IRQ_S3C2416_RESERVED2:
-		case IRQ_S3C2416_RESERVED3:
-			/* no IRQ here */
-			break;
-		default:
-			irq_set_chip_and_handler(irqno, &s3c2416_irq_second,
-						 handle_edge_irq);
-			set_irq_flags(irqno, IRQF_VALID);
-		}
-	}
-}
-
 struct s3c_irq_data init_s3c2416subint[32] = {
 	{ .type = S3C_IRQTYPE_SUBLEVEL, .parent_irq = 28 }, /* UART0-RX */
 	{ .type = S3C_IRQTYPE_SUBLEVEL, .parent_irq = 28 }, /* UART0-TX */
@@ -906,8 +848,21 @@ struct s3c_irq_data init_s3c2416subint[32] = {
 	{ .type = S3C_IRQTYPE_SUBLEVEL, .parent_irq = 9 }, /* AC97 */
 };
 
+struct s3c_irq_data init_s3c2416_second[32] = {
+	{ .type = S3C_IRQTYPE_S3C2416 }, /* 2D */
+	{ .type = S3C_IRQTYPE_S3C2416 }, /* IIC1 */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
+	{ .type = S3C_IRQTYPE_NONE }, /* reserved */
+	{ .type = S3C_IRQTYPE_S3C2416 }, /* PCM0 */
+	{ .type = S3C_IRQTYPE_S3C2416 }, /* PCM1 */
+	{ .type = S3C_IRQTYPE_S3C2416 }, /* I2S0 */
+	{ .type = S3C_IRQTYPE_S3C2416 }, /* I2S1 */
+};
+
 void __init s3c2416_init_irq(void)
 {
+	struct s3c_irq_intc *s3c_intc2;
+
 	/* override irq data */
 	s3c_intc[0].irqs = &init_s3c2443base[0];
 	s3c_intc[2].irqs = &init_s3c2416subint[0];
@@ -916,7 +871,20 @@ void __init s3c2416_init_irq(void)
 
 	s3c24xx_init_irq();
 
-	s3c2416_irq_add_second();
+	s3c_intc2 = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
+	if (!s3c_intc2) {
+		pr_err("irq: failed to allocate memory for second controller\n");
+		return;
+	}
+
+	s3c_intc2->reg_pending = S3C2416_SRCPND2,
+	s3c_intc2->reg_intpnd = S3C2416_INTPND2,
+	s3c_intc2->reg_mask = S3C2416_INTMSK2,
+	s3c_intc2->irqs = &init_s3c2416_second[0],
+
+	s3c24xx_clear_intc(s3c_intc2);
+	s3c_intc2->domain = irq_domain_add_legacy(NULL, 8, IRQ_S3C2416_2D, 0,
+						  &s3c24xx_irq_ops, s3c_intc2);
 }
 
 #ifdef CONFIG_PM
-- 
1.7.2.3
