From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Sun, 25 Nov 2018 10:43:10 +0300
Subject: [RFC PATCH v4 07/17] irqchip/sun4i: Add support for Allwinner ARMv5
 F1C100s
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <1f3cce09623052eaa90093f13ea9d13047a2b250.1543131714.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for suniv Allwinner ARMv5 F1C100s SoC which has
stripped version of interrupt controller that found in A10/A13.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/irqchip/irq-sun4i.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 507f4e3..fb78d66 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -32,6 +32,8 @@
 #define SUN4I_IRQ_MASK_REG(data, x)	((data)->mask_reg_offset + 0x4 * x)
 #define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
 #define SUN4I_IRQ_MASK_REG_OFFSET	0x50
+#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
+#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
 
 struct sun4i_irq_chip_data {
 	void __iomem *irq_base;
@@ -105,15 +107,6 @@ static const struct irq_domain_ops sun4i_irq_ops = {
 static int __init sun4i_of_init(struct device_node *node,
 				struct device_node *parent)
 {
-	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
-	if (!irq_ic_data) {
-		pr_err("kzalloc failed!\n");
-		return -ENOMEM;
-	}
-
-	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
-	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
-
 	irq_ic_data->irq_base = of_iomap(node, 0);
 	if (!irq_ic_data->irq_base)
 		panic("%pOF: unable to map IC registers\n",
@@ -149,7 +142,41 @@ static int __init sun4i_of_init(struct device_node *node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
+
+static int __init sun4i_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_ic_of_init);
+
+static int __init suniv_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sun4i_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_reg_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUNIV_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic",
+		suniv_ic_of_init);
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
-- 
2.7.4
