From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Wed, 21 Nov 2018 21:30:38 +0300
Subject: [RFC PATCH v3 05/17] irqchip/sun4i: add support for suniv interrupt
 controller
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <08b40429e46626f4caf8e4d2287b5c4d354e3b7f.1542824904.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new F-series SoCs (suniv) from Allwinner use an stripped version of
the interrupt controller in A10/A13

Add support for it in irq-sun4i driver.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/irqchip/irq-sun4i.c | 104 +++++++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index e3e5b91..7ca4a4d 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -28,11 +28,21 @@
 #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
 #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
 #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
-#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
-#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG(x)		(irq_ic_data->enable_req_offset + 0x4 * x)
+#define SUN4I_IRQ_MASK_REG(x)		(irq_ic_data->mask_req_offset + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
+#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
+#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
+#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
+
+struct sunxi_irq_chip_data{
+	void __iomem *irq_base;
+	struct irq_domain *irq_domain;
+	u32 enable_req_offset;
+	u32 mask_req_offset;
+};
 
-static void __iomem *sun4i_irq_base;
-static struct irq_domain *sun4i_irq_domain;
+static struct sunxi_irq_chip_data *irq_ic_data;
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs);
 
@@ -43,7 +53,7 @@ static void sun4i_irq_ack(struct irq_data *irqd)
 	if (irq != 0)
 		return; /* Only IRQ 0 / the ENMI needs to be acked */
 
-	writel(BIT(0), sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0));
+	writel(BIT(0), irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
 }
 
 static void sun4i_irq_mask(struct irq_data *irqd)
@@ -53,9 +63,9 @@ static void sun4i_irq_mask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 	writel(val & ~(1 << irq_off),
-	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 }
 
 static void sun4i_irq_unmask(struct irq_data *irqd)
@@ -65,9 +75,9 @@ static void sun4i_irq_unmask(struct irq_data *irqd)
 	int reg = irq / 32;
 	u32 val;
 
-	val = readl(sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	val = readl(irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 	writel(val | (1 << irq_off),
-	       sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(reg));
+	       irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(reg));
 }
 
 static struct irq_chip sun4i_irq_chip = {
@@ -95,42 +105,76 @@ static const struct irq_domain_ops sun4i_irq_ops = {
 static int __init sun4i_of_init(struct device_node *node,
 				struct device_node *parent)
 {
-	sun4i_irq_base = of_iomap(node, 0);
-	if (!sun4i_irq_base)
+	irq_ic_data->irq_base = of_iomap(node, 0);
+	if (!irq_ic_data->irq_base)
 		panic("%pOF: unable to map IC registers\n",
 			node);
 
 	/* Disable all interrupts */
-	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(0));
-	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(1));
-	writel(0, sun4i_irq_base + SUN4I_IRQ_ENABLE_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_ENABLE_REG(2));
 
 	/* Unmask all the interrupts, ENABLE_REG(x) is used for masking */
-	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(0));
-	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(1));
-	writel(0, sun4i_irq_base + SUN4I_IRQ_MASK_REG(2));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(0));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(1));
+	writel(0, irq_ic_data->irq_base + SUN4I_IRQ_MASK_REG(2));
 
 	/* Clear all the pending interrupts */
-	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0));
-	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(1));
-	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(2));
+	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0));
+	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(1));
+	writel(0xffffffff, irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(2));
 
-	/* Enable protection mode */
-	writel(0x01, sun4i_irq_base + SUN4I_IRQ_PROTECTION_REG);
+	/* Enable protection mode (not available in suniv) */
+	if (of_device_is_compatible(node, "allwinner,sun4i-a10-ic"))
+		writel(0x01, irq_ic_data->irq_base + SUN4I_IRQ_PROTECTION_REG);
 
 	/* Configure the external interrupt source type */
-	writel(0x00, sun4i_irq_base + SUN4I_IRQ_NMI_CTRL_REG);
+	writel(0x00, irq_ic_data->irq_base + SUN4I_IRQ_NMI_CTRL_REG);
 
-	sun4i_irq_domain = irq_domain_add_linear(node, 3 * 32,
+	irq_ic_data->irq_domain = irq_domain_add_linear(node, 3 * 32,
 						 &sun4i_irq_ops, NULL);
-	if (!sun4i_irq_domain)
+	if (!irq_ic_data->irq_domain)
 		panic("%pOF: unable to create IRQ domain\n", node);
 
 	set_handle_irq(sun4i_handle_irq);
 
 	return 0;
 }
-IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
+
+static int __init sun4i_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_req_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_req_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_ic_of_init);
+
+static int __init suniv_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	irq_ic_data = kzalloc(sizeof(struct sunxi_irq_chip_data), GFP_KERNEL);
+	if (!irq_ic_data) {
+		pr_err("kzalloc failed!\n");
+		return -ENOMEM;
+	}
+
+	irq_ic_data->enable_req_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
+	irq_ic_data->mask_req_offset = SUNIV_IRQ_MASK_REG_OFFSET;
+
+	return sun4i_of_init(node, parent);
+}
+
+IRQCHIP_DECLARE(allwinner_sunvi_ic, "allwinner,suniv-f1c100s-ic", suniv_ic_of_init);
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
@@ -146,13 +190,13 @@ static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 	 * the extra check in the common case of 1 hapening after having
 	 * read the vector-reg once.
 	 */
-	hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
+	hwirq = readl(irq_ic_data->irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
 	if (hwirq == 0 &&
-		  !(readl(sun4i_irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
+		  !(readl(irq_ic_data->irq_base + SUN4I_IRQ_PENDING_REG(0)) & BIT(0)))
 		return;
 
 	do {
-		handle_domain_irq(sun4i_irq_domain, hwirq, regs);
-		hwirq = readl(sun4i_irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
+		handle_domain_irq(irq_ic_data->irq_domain, hwirq, regs);
+		hwirq = readl(irq_ic_data->irq_base + SUN4I_IRQ_VECTOR_REG) >> 2;
 	} while (hwirq != 0);
 }
-- 
2.7.4
