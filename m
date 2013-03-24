From: hechtb@gmail.com (Bastian Hecht)
Date: Sun, 24 Mar 2013 16:54:35 +0100
Subject: [PATCH] irqchip: intc-irqpin: Add support for shared interrupt lines
Message-ID: <1364140475-27350-1-git-send-email-hechtb+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some hardware we don't have a 1-1 mapping from the external
interrupts coming from INTC to the GIC SPI pins. We can however
share lines to demux incoming IRQs on these SoCs.

This patch enables the intc_irqpin driver to detect requests for shared
interrupt lines and demuxes them properly by querying the INTC INTREQx0A
registers.

As multiple driver instances can use the same shared interrupt line, we
need to pay extra attention during the device probing to exclude IRQ
floods that would be caused by interrupts for which no handler has been
set up yet.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c |  110 ++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index fd5dabc..b6fc6a6 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -74,8 +74,11 @@ struct intc_irqpin_priv {
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
 	struct irq_domain *irq_domain;
+	u8 shared_irq_mask;
 };
 
+enum { IRQ_SCAN_START, IRQ_SCAN_SHARED, IRQ_SCAN_SINGLE, IRQ_SCAN_ERROR };
+
 static unsigned long intc_irqpin_read32(void __iomem *iomem)
 {
 	return ioread32(iomem);
@@ -182,6 +185,8 @@ static void intc_irqpin_irq_enable(struct irq_data *d)
 
 	intc_irqpin_dbg(&p->irq[hw_irq], "enable");
 	intc_irqpin_irq_write_hwirq(p, INTC_IRQPIN_REG_CLEAR, hw_irq);
+
+	p->shared_irq_mask &= ~BIT(hw_irq);
 }
 
 static void intc_irqpin_irq_disable(struct irq_data *d)
@@ -191,6 +196,8 @@ static void intc_irqpin_irq_disable(struct irq_data *d)
 
 	intc_irqpin_dbg(&p->irq[hw_irq], "disable");
 	intc_irqpin_irq_write_hwirq(p, INTC_IRQPIN_REG_MASK, hw_irq);
+
+	p->shared_irq_mask |= BIT(hw_irq);
 }
 
 static void intc_irqpin_irq_enable_force(struct irq_data *d)
@@ -261,8 +268,27 @@ static irqreturn_t intc_irqpin_irq_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static irqreturn_t intc_irqpin_shared_irq_handler(int irq, void *dev_id)
+{
+	struct intc_irqpin_priv *p = dev_id;
+	unsigned int reg_source = intc_irqpin_read(p, INTC_IRQPIN_REG_SOURCE);
+	irqreturn_t status = IRQ_NONE;
+	int k;
+
+	for (k = 0; k < 8; k++) {
+		if (reg_source & BIT(7 - k)) {
+			if (BIT(k) & p->shared_irq_mask)
+				continue;
+
+			status |= intc_irqpin_irq_handler(irq, &p->irq[k]);
+		}
+	}
+
+	return status;
+}
+
 static int intc_irqpin_irq_domain_map(struct irq_domain *h, unsigned int virq,
-				      irq_hw_number_t hw)
+					irq_hw_number_t hw)
 {
 	struct intc_irqpin_priv *p = h->host_data;
 
@@ -278,7 +304,7 @@ static int intc_irqpin_irq_domain_map(struct irq_domain *h, unsigned int virq,
 
 static struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 	.map	= intc_irqpin_irq_domain_map,
-	.xlate  = irq_domain_xlate_twocell,
+	.xlate	= irq_domain_xlate_twocell,
 };
 
 static int intc_irqpin_probe(struct platform_device *pdev)
@@ -292,6 +318,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	void (*enable_fn)(struct irq_data *d);
 	void (*disable_fn)(struct irq_data *d);
 	const char *name = dev_name(&pdev->dev);
+	int scan_status;
+	int reg_prio;
 	int ret;
 	int k;
 
@@ -369,9 +397,13 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	/* mask all interrupts using priority */
+	reg_prio = intc_irqpin_read(p, INTC_IRQPIN_REG_PRIO);
 	for (k = 0; k < p->number_of_irqs; k++)
 		intc_irqpin_mask_unmask_prio(p, k, 1);
 
+	/* clear all pending interrupts */
+	intc_irqpin_write(p, INTC_IRQPIN_REG_SOURCE, 0x0);
+
 	/* use more severe masking method if requested */
 	if (p->config.control_parent) {
 		enable_fn = intc_irqpin_irq_enable_force;
@@ -400,18 +432,78 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	/* request and set priority on interrupts one by one */
-	for (k = 0; k < p->number_of_irqs; k++) {
-		if (devm_request_irq(&pdev->dev, p->irq[k].requested_irq,
-				     intc_irqpin_irq_handler,
-				     0, name, &p->irq[k])) {
+	/* scan for shared interrupt lines */
+	scan_status = IRQ_SCAN_START;
+	for (k = 1; k < p->number_of_irqs; k++) {
+		if (p->irq[k].requested_irq == p->irq[0].requested_irq) {
+			if (scan_status == IRQ_SCAN_SINGLE) {
+				scan_status = IRQ_SCAN_ERROR;
+				break;
+			}
+			scan_status = IRQ_SCAN_SHARED;
+		} else {
+			if (scan_status == IRQ_SCAN_SHARED) {
+				scan_status = IRQ_SCAN_ERROR;
+				break;
+			}
+			scan_status = IRQ_SCAN_SINGLE;
+		}
+	}
+
+	switch (scan_status) {
+	case IRQ_SCAN_START:	/* means we got only 1 interrupt */
+	case IRQ_SCAN_SINGLE:
+		/* request interrupts one by one */
+		for (k = 0; k < p->number_of_irqs; k++) {
+			if (devm_request_irq(&pdev->dev,
+					p->irq[k].requested_irq,
+					intc_irqpin_irq_handler,
+					0, name, &p->irq[k])) {
+				dev_err(&pdev->dev,
+					"failed to request low IRQ\n");
+				ret = -ENOENT;
+				goto err1;
+			}
+		}
+		break;
+
+	case IRQ_SCAN_SHARED:
+		/* request one shared interrupt
+		 *
+		 * On some hardware (like r8a7740) the shared interrupt only
+		 * is silent if we mask out REG_PRIO *and* REG_MASK. To save
+		 * the user from an IRQ-flood when using multiple intc_irqpin
+		 * instances in a shared fashion, we enforce this masking a
+		 * priori.
+		 */
+		p->shared_irq_mask = intc_irqpin_read(p, INTC_IRQPIN_REG_MASK);
+		if (p->shared_irq_mask != 0xff || reg_prio != 0x00) {
+			dev_err(&pdev->dev,
+				"expected all interrupts to be masked out "\
+				"when using shared interrupts\n");
+			ret = -EINVAL;
+			goto err1;
+		}
+		if (devm_request_irq(&pdev->dev, p->irq[0].requested_irq,
+				intc_irqpin_shared_irq_handler,
+				IRQF_SHARED, name, p)) {
 			dev_err(&pdev->dev, "failed to request low IRQ\n");
 			ret = -ENOENT;
 			goto err1;
 		}
-		intc_irqpin_mask_unmask_prio(p, k, 0);
+		break;
+
+	case IRQ_SCAN_ERROR:
+		dev_err(&pdev->dev,
+			"mixing single and shared IRQ lines not supported\n");
+		ret = -EINVAL;
+		goto err0;
 	}
 
+	/* unmask all interrupts on prio level */
+	for (k = 0; k < p->number_of_irqs; k++)
+		intc_irqpin_mask_unmask_prio(p, k, 0);
+
 	dev_info(&pdev->dev, "driving %d irqs\n", p->number_of_irqs);
 
 	/* warn in case of mismatch if irq base is specified */
@@ -450,7 +542,7 @@ static struct platform_driver intc_irqpin_device_driver = {
 	.driver		= {
 		.name	= "renesas_intc_irqpin",
 		.of_match_table = intc_irqpin_dt_ids,
-		.owner  = THIS_MODULE,
+		.owner	= THIS_MODULE,
 	}
 };
 
-- 
1.7.9.5
