From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 1 Jan 2013 22:59:58 +0100
Subject: [PATCH v2 11/11] ARM: S3C24XX: remove maskack irq ack funtions
In-Reply-To: <201301012251.15899.heiko@sntech.de>
References: <201301012251.15899.heiko@sntech.de>
Message-ID: <201301012259.58754.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the past level irqs provided a special ack handler that also masked
the interrupt. But handle_level_irq also does mask-ack the interrupt
itself, so there is no need to keep this special ack function around.

We therefore can simplyfy the number of irq-chips again.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/plat-s3c24xx/irq.c |   41 +++++++++--------------------------------
 1 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 8cba552..0516cbc 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -128,12 +128,6 @@ static inline void s3c_irq_ack(struct irq_data *data)
 		__raw_writel(bitval, intc->reg_intpnd);
 }
 
-static inline void s3c_irq_maskack(struct irq_data *data)
-{
-	s3c_irq_mask(data);
-	s3c_irq_ack(data);
-}
-
 #ifdef CONFIG_PM
 /* state for IRQs over sleep
  *
@@ -164,22 +158,6 @@ int s3c_irq_wake(struct irq_data *data, unsigned int state)
 }
 #endif
 
-struct irq_chip s3c_irq_level_chip = {
-	.name		= "s3c-level",
-	.irq_ack	= s3c_irq_maskack,
-	.irq_mask	= s3c_irq_mask,
-	.irq_unmask	= s3c_irq_unmask,
-	.irq_set_wake	= s3c_irq_wake
-};
-
-struct irq_chip s3c_irq_chip = {
-	.name		= "s3c",
-	.irq_ack	= s3c_irq_ack,
-	.irq_mask	= s3c_irq_mask,
-	.irq_unmask	= s3c_irq_unmask,
-	.irq_set_wake	= s3c_irq_wake
-};
-
 static int s3c_irqext_type_set(void __iomem *gpcon_reg,
 			       void __iomem *extint_reg,
 			       unsigned long gpcon_offset,
@@ -299,17 +277,16 @@ static struct irq_chip s3c_irq_eint0t4 = {
 	.irq_set_type	= s3c_irqext0_type,
 };
 
-/* used for UARTs */
-static struct irq_chip s3c_irq_sublevel_chip = {
-	.name		= "s3c-sublevel",
+struct irq_chip s3c_irq_chip = {
+	.name		= "s3c",
+	.irq_ack	= s3c_irq_ack,
 	.irq_mask	= s3c_irq_mask,
 	.irq_unmask	= s3c_irq_unmask,
-	.irq_ack	= s3c_irq_maskack,
+	.irq_set_wake	= s3c_irq_wake
 };
 
-/* used for ADC and Touchscreen */
-static struct irq_chip s3c_irq_subedge_chip = {
-	.name		= "s3c-subedge",
+static struct irq_chip s3c_irq_general_chip = {
+	.name		= "s3c-general",
 	.irq_mask	= s3c_irq_mask,
 	.irq_unmask	= s3c_irq_unmask,
 	.irq_ack	= s3c_irq_ack,
@@ -412,7 +389,7 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 	case S3C_IRQTYPE_EDGE:
 		if (irq_data->parent_irq ||
 		    intc->reg_pending == S3C2416_SRCPND2)
-			irq_set_chip_and_handler(virq, &s3c_irq_subedge_chip,
+			irq_set_chip_and_handler(virq, &s3c_irq_general_chip,
 						 handle_edge_irq);
 		else
 			irq_set_chip_and_handler(virq, &s3c_irq_chip,
@@ -420,10 +397,10 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 		break;
 	case S3C_IRQTYPE_LEVEL:
 		if (irq_data->parent_irq)
-			irq_set_chip_and_handler(virq, &s3c_irq_sublevel_chip,
+			irq_set_chip_and_handler(virq, &s3c_irq_general_chip,
 						 handle_level_irq);
 		else
-			irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
+			irq_set_chip_and_handler(virq, &s3c_irq_chip,
 						 handle_level_irq);
 		break;
 	default:
-- 
1.7.2.3
