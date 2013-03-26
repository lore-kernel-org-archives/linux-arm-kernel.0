From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 26 Mar 2013 23:08:38 +0100
Subject: [PATCH v6 4/7] irqchip: s3c24xx: add irq_set_type callback for basic
 interrupt types
In-Reply-To: <201303262305.49725.heiko@sntech.de>
References: <201303262305.49725.heiko@sntech.de>
Message-ID: <201303262308.38741.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables post-init setting of the desired typehandler for the interrupt.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/irqchip/irq-s3c24xx.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index a565eb8..7cba4f0 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -123,6 +123,28 @@ static inline void s3c_irq_ack(struct irq_data *data)
 		__raw_writel(bitval, intc->reg_intpnd);
 }
 
+static int s3c_irq_type(struct irq_data *data, unsigned int type)
+{
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+	case IRQ_TYPE_EDGE_FALLING:
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_set_handler(data->irq, handle_edge_irq);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_handler(data->irq, handle_level_irq);
+		break;
+	default:
+		pr_err("No such irq type %d", type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int s3c_irqext_type_set(void __iomem *gpcon_reg,
 			       void __iomem *extint_reg,
 			       unsigned long gpcon_offset,
@@ -228,6 +250,7 @@ static struct irq_chip s3c_irq_chip = {
 	.irq_ack	= s3c_irq_ack,
 	.irq_mask	= s3c_irq_mask,
 	.irq_unmask	= s3c_irq_unmask,
+	.irq_set_type	= s3c_irq_type,
 	.irq_set_wake	= s3c_irq_wake
 };
 
@@ -236,6 +259,7 @@ static struct irq_chip s3c_irq_level_chip = {
 	.irq_mask	= s3c_irq_mask,
 	.irq_unmask	= s3c_irq_unmask,
 	.irq_ack	= s3c_irq_ack,
+	.irq_set_type	= s3c_irq_type,
 };
 
 static struct irq_chip s3c_irqext_chip = {
-- 
1.7.10.4
