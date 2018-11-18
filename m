From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Sun, 18 Nov 2018 17:17:04 +0300
Subject: [RFC PATCH v2 05/14] irqchip/sun4i: add support for suniv interrupt
 controller
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <d693414b1693a9018956bcc589a9048e88fbc8f6.1542546735.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new F-series SoCs (suniv) from Allwinner use an stripped version of
the interrupt controller in A10/A13.

Add support for it in irq-sun4i driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/irqchip/irq-sun4i.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
index e3e5b91..2abf662 100644
--- a/drivers/irqchip/irq-sun4i.c
+++ b/drivers/irqchip/irq-sun4i.c
@@ -23,13 +23,26 @@
 
 #include <asm/exception.h>
 
+enum sun4i_irq_type {
+	sun4i_ic,
+	suniv_ic
+};
+
+static enum sun4i_irq_type sun4i_irq_type;
+static int sun4i_irq_enable_reg_offset;
+static int sun4i_irq_mask_reg_offset;
+
 #define SUN4I_IRQ_VECTOR_REG		0x00
 #define SUN4I_IRQ_PROTECTION_REG	0x08
 #define SUN4I_IRQ_NMI_CTRL_REG		0x0c
 #define SUN4I_IRQ_PENDING_REG(x)	(0x10 + 0x4 * x)
 #define SUN4I_IRQ_FIQ_PENDING_REG(x)	(0x20 + 0x4 * x)
-#define SUN4I_IRQ_ENABLE_REG(x)		(0x40 + 0x4 * x)
-#define SUN4I_IRQ_MASK_REG(x)		(0x50 + 0x4 * x)
+#define SUN4I_IRQ_ENABLE_REG_OFFSET	0x40
+#define SUN4I_IRQ_MASK_REG_OFFSET	0x50
+#define SUNIV_IRQ_ENABLE_REG_OFFSET	0x20
+#define SUNIV_IRQ_MASK_REG_OFFSET	0x30
+#define SUN4I_IRQ_ENABLE_REG(x)		(sun4i_irq_enable_reg_offset + 0x4 * x)
+#define SUN4I_IRQ_MASK_REG(x)		(sun4i_irq_mask_reg_offset + 0x4 * x)
 
 static void __iomem *sun4i_irq_base;
 static struct irq_domain *sun4i_irq_domain;
@@ -115,8 +128,9 @@ static int __init sun4i_of_init(struct device_node *node,
 	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(1));
 	writel(0xffffffff, sun4i_irq_base + SUN4I_IRQ_PENDING_REG(2));
 
-	/* Enable protection mode */
-	writel(0x01, sun4i_irq_base + SUN4I_IRQ_PROTECTION_REG);
+	/* Enable protection mode (not available in suniv) */
+	if (sun4i_irq_type == sun4i_ic)
+		writel(0x01, sun4i_irq_base + SUN4I_IRQ_PROTECTION_REG);
 
 	/* Configure the external interrupt source type */
 	writel(0x00, sun4i_irq_base + SUN4I_IRQ_NMI_CTRL_REG);
@@ -130,7 +144,30 @@ static int __init sun4i_of_init(struct device_node *node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_of_init);
+
+static int __init sun4i_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	sun4i_irq_type = sun4i_ic;
+	sun4i_irq_enable_reg_offset = SUN4I_IRQ_ENABLE_REG_OFFSET;
+	sun4i_irq_mask_reg_offset = SUN4I_IRQ_MASK_REG_OFFSET;
+	sun4i_of_init(node, parent);
+
+	return 0;
+}
+IRQCHIP_DECLARE(allwinner_sun4i_ic, "allwinner,sun4i-a10-ic", sun4i_ic_of_init);
+
+static int __init suniv_ic_of_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	sun4i_irq_type = suniv_ic;
+	sun4i_irq_enable_reg_offset = SUNIV_IRQ_ENABLE_REG_OFFSET;
+	sun4i_irq_mask_reg_offset = SUNIV_IRQ_MASK_REG_OFFSET;
+	sun4i_of_init(node, parent);
+
+	return 0;
+}
+IRQCHIP_DECLARE(allwinner_suniv_ic, "allwinner,suniv-f1c100s-ic", suniv_ic_of_init);
 
 static void __exception_irq_entry sun4i_handle_irq(struct pt_regs *regs)
 {
-- 
2.7.4
