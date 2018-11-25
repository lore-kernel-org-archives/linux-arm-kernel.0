From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Sun, 25 Nov 2018 10:43:09 +0300
Subject: [RFC PATCH v4 06/17] irqchip/sun4i: Move IC specific register offsets
 to struct
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <0242923026be282e26fe9e50d9bb0ec3d5ae355f.1543131714.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves IC specific register offsets to sun4i_irq_chip_data
struct in order to support different chips.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/irqchip/irq-sun4i.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index 0c32506..507f4e3 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -28,12 +28,16 @@
 #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
 #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
 #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
-#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
-#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG(data, x)	((data)->enable_reg_offset + 0x4 * x)
+#define SUN4I_IRQ_MASK_REG(data, x)	((data)->mask_reg_offset + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
+#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
 
 struct sun4i_irq_chip_data {
 	void __iomem *irq_base;
 	struct irq_domain *irq_domain;
+	u32 enable_reg_offset;
+	u32 mask_reg_offset;
 };
 
 static struct sun4i_irq_chip_data *irq_ic_data;
@@ -57,9 +61,10 @@ static void sun4i_irq_mask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base +
+			SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 	writel(val & ~(1 << irq_off),
-	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 }
 
 static void sun4i_irq_unmask(struct irq_data *irqd)
@@ -69,9 +74,10 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base +
+			SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 	writel(val | (1 << irq_off),
-	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, reg));
 }
 
 static struct irq_chip sun4i_irq_chip = {
@@ -105,20 +111,23 @@ static int __init sun4i_of_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	irq_ic_data->enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+
 	irq_ic_data->irq_base = of_iomap(node, 0);
 	if (!irq_ic_data->irq_base)
 		panic("%pOF: unable to map IC registers\n",
 			node);
 
 	/* Disable all interrupts */
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(0));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(1));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(irq_ic_data, 2));
 
 	/* Unmask all the interrupts, ENABLE_REG(x) is used for masking */
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(0));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(1));
-	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(irq_ic_data, 2));
 
 	/* Clear all the pending interrupts */
 	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
-- 
2.7.4
