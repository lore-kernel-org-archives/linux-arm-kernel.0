From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 21 Oct 2014 12:40:15 +0200
Subject: [PATCH v8 4/9] ARM: irqchip: mxs: prepare driver for HW with
 different offsets
In-Reply-To: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1413888020-8790-5-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some HW has similar functionality but different register offsets.
Make sure we can change offsets dynamically.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 drivers/irqchip/irq-mxs.c | 55 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index e4acf1e..681125d 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -29,18 +29,39 @@
 
 #include "irqchip.h"
 
+/*
+ * this device provide 4 offsets for each register:
+ * 0x0 - plain read write mode
+ * 0x4 - set mode, OR logic.
+ * 0x8 - clr mode, XOR logic.
+ * 0xc - togle mode.
+ */
+#define SET_REG 4
+#define CLR_REG 8
+
 #define HW_ICOLL_VECTOR				0x0000
 #define HW_ICOLL_LEVELACK			0x0010
 #define HW_ICOLL_CTRL				0x0020
 #define HW_ICOLL_STAT_OFFSET			0x0070
-#define HW_ICOLL_INTERRUPTn_SET(n)		(0x0124 + (n) * 0x10)
-#define HW_ICOLL_INTERRUPTn_CLR(n)		(0x0128 + (n) * 0x10)
-#define BM_ICOLL_INTERRUPTn_ENABLE		0x00000004
+#define HW_ICOLL_INTERRUPT0			0x0120
+#define HW_ICOLL_INTERRUPTn(n)			((n) * 0x10)
+#define BM_ICOLL_INTR_ENABLE			BIT(2)
 #define BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0	0x1
 
 #define ICOLL_NUM_IRQS		128
 
-static void __iomem *icoll_base;
+struct icoll_priv {
+	void __iomem *vector;
+	void __iomem *levelack;
+	void __iomem *ctrl;
+	void __iomem *stat;
+	void __iomem *intr;
+	/* number of interrupts per register */
+	int intr_per_reg;
+	void __iomem *clear;
+};
+
+static struct icoll_priv icoll_priv;
 static struct irq_domain *icoll_domain;
 
 static void icoll_ack_irq(struct irq_data *d)
@@ -51,19 +72,19 @@ static void icoll_ack_irq(struct irq_data *d)
 	 * BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0 unconditionally.
 	 */
 	__raw_writel(BV_ICOLL_LEVELACK_IRQLEVELACK__LEVEL0,
-			icoll_base + HW_ICOLL_LEVELACK);
+			icoll_priv.levelack);
 }
 
 static void icoll_mask_irq(struct irq_data *d)
 {
-	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
-			icoll_base + HW_ICOLL_INTERRUPTn_CLR(d->hwirq));
+	__raw_writel(BM_ICOLL_INTR_ENABLE,
+			icoll_priv.intr + CLR_REG + HW_ICOLL_INTERRUPTn(d->hwirq));
 }
 
 static void icoll_unmask_irq(struct irq_data *d)
 {
-	__raw_writel(BM_ICOLL_INTERRUPTn_ENABLE,
-			icoll_base + HW_ICOLL_INTERRUPTn_SET(d->hwirq));
+	__raw_writel(BM_ICOLL_INTR_ENABLE,
+			icoll_priv.intr + SET_REG + HW_ICOLL_INTERRUPTn(d->hwirq));
 }
 
 static struct irq_chip mxs_icoll_chip = {
@@ -76,8 +97,8 @@ asmlinkage void __exception_irq_entry icoll_handle_irq(struct pt_regs *regs)
 {
 	u32 irqnr;
 
-	irqnr = __raw_readl(icoll_base + HW_ICOLL_STAT_OFFSET);
-	__raw_writel(irqnr, icoll_base + HW_ICOLL_VECTOR);
+	irqnr = __raw_readl(icoll_priv.stat);
+	__raw_writel(irqnr, icoll_priv.vector);
 	handle_domain_irq(icoll_domain, irqnr, regs);
 }
 
@@ -98,14 +119,22 @@ static struct irq_domain_ops icoll_irq_domain_ops = {
 static int __init icoll_of_init(struct device_node *np,
 			  struct device_node *interrupt_parent)
 {
-	icoll_base = of_iomap(np, 0);
+	void __iomem *icoll_base = of_iomap(np, 0);
 	WARN_ON(!icoll_base);
 
+	icoll_priv.vector	= icoll_base + HW_ICOLL_VECTOR;
+	icoll_priv.levelack	= icoll_base + HW_ICOLL_LEVELACK;
+	icoll_priv.ctrl		= icoll_base + HW_ICOLL_CTRL;
+	icoll_priv.stat		= icoll_base + HW_ICOLL_STAT_OFFSET;
+	icoll_priv.intr		= icoll_base + HW_ICOLL_INTERRUPT0;
+	icoll_priv.intr_per_reg	= 1;
+	icoll_priv.clear	= NULL;
+
 	/*
 	 * Interrupt Collector reset, which initializes the priority
 	 * for each irq to level 0.
 	 */
-	stmp_reset_block(icoll_base + HW_ICOLL_CTRL);
+	stmp_reset_block(icoll_priv.ctrl);
 
 	icoll_domain = irq_domain_add_linear(np, ICOLL_NUM_IRQS,
 					     &icoll_irq_domain_ops, NULL);
-- 
1.9.1
