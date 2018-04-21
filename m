From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 15:55:29 +0200
Subject: [PATCH 09/17] irqchip/irq-mvebu-icu: support ICU subnodes
In-Reply-To: <20180421135537.24716-1-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
Message-ID: <20180421135537.24716-10-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce new bindings for the ICU.

Each DT subnode of the ICU represents a type of interrupt that should
be handled separately. Add the possibility for the ICU to have subnodes
and probe each of them automatically with devm_platform_populate(). If
the node as no child, the probe function for NSRs will still be called
'manually'.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 85 +++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index c919110dcee5..1d3cd112619c 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -44,6 +44,7 @@ struct mvebu_icu {
 	struct irq_chip irq_chip;
 	struct regmap *regmap;
 	struct device *dev;
+	bool legacy_bindings;
 };
 
 struct mvebu_icu_irq_data {
@@ -52,6 +53,27 @@ struct mvebu_icu_irq_data {
 	unsigned int type;
 };
 
+static struct mvebu_icu *mvebu_dev_get_drvdata(struct platform_device *pdev)
+{
+	struct mvebu_icu *icu;
+
+	icu = dev_get_drvdata(&pdev->dev);
+	if (icu) {
+		/* Legacy bindings: get the device data */
+		if (!icu->legacy_bindings)
+			return ERR_PTR(-EINVAL);
+	} else {
+		/* New bindings: get the parent device (ICU) data */
+		icu = dev_get_drvdata(pdev->dev.parent);
+		if (!icu)
+			return ERR_PTR(-ENODEV);
+		if (icu->legacy_bindings)
+			return ERR_PTR(-EINVAL);
+	}
+
+	return icu;
+}
+
 static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct irq_data *d = irq_get_irq_data(desc->irq);
@@ -94,31 +116,35 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
 	struct mvebu_icu *icu = platform_msi_get_host_data(d);
-	unsigned int icu_group;
+	unsigned int param_count = icu->legacy_bindings ? 3 : 2;
 
 	/* Check the count of the parameters in dt */
-	if (WARN_ON(fwspec->param_count < 3)) {
+	if (WARN_ON(fwspec->param_count != param_count)) {
 		dev_err(icu->dev, "wrong ICU parameter count %d\n",
 			fwspec->param_count);
 		return -EINVAL;
 	}
 
-	/* Only ICU group type is handled */
-	icu_group = fwspec->param[0];
-	if (icu_group != ICU_GRP_NSR && icu_group != ICU_GRP_SR &&
-	    icu_group != ICU_GRP_SEI && icu_group != ICU_GRP_REI) {
-		dev_err(icu->dev, "wrong ICU group type %x\n", icu_group);
-		return -EINVAL;
+	if (icu->legacy_bindings) {
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		if (fwspec->param[0] != ICU_GRP_NSR) {
+			dev_err(icu->dev, "wrong ICU group type %x\n",
+				fwspec->param[0]);
+			return -EINVAL;
+		}
+	} else {
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
 	}
 
-	*hwirq = fwspec->param[1];
 	if (*hwirq >= ICU_MAX_IRQS) {
 		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
 		return -EINVAL;
 	}
 
 	/* Mask the type to prevent wrong DT configuration */
-	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+	*type &= IRQ_TYPE_SENSE_MASK;
 
 	return 0;
 }
@@ -144,7 +170,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		goto free_irqd;
 	}
 
-	icu_irqd->icu_group = fwspec->param[0];
+	if (icu->legacy_bindings)
+		icu_irqd->icu_group = fwspec->param[0];
+	else
+		icu_irqd->icu_group = ICU_GRP_NSR;
 	icu_irqd->icu = icu;
 
 	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
@@ -200,9 +229,9 @@ static int mvebu_icu_nsr_probe(struct platform_device *pdev)
 	phys_addr_t set, clr;
 	int ret;
 
-	icu = dev_get_drvdata(&pdev->dev);
-	if (!icu)
-		return -ENODEV;
+	icu = mvebu_dev_get_drvdata(pdev);
+	if (IS_ERR(icu))
+		return PTR_ERR(icu);
 
 	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, pdev->dev.of_node,
 						 DOMAIN_BUS_PLATFORM_MSI);
@@ -235,6 +264,20 @@ static int mvebu_icu_nsr_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id mvebu_icu_nsr_of_match[] = {
+	{ .compatible = "marvell,cp110-icu-nsr", },
+	{},
+};
+
+static struct platform_driver mvebu_icu_nsr_driver = {
+	.probe  = mvebu_icu_nsr_probe,
+	.driver = {
+		.name = "mvebu-icu-nsr",
+		.of_match_table = mvebu_icu_nsr_of_match,
+	},
+};
+builtin_platform_driver(mvebu_icu_nsr_driver);
+
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
@@ -262,6 +305,15 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	if (!icu->irq_chip.name)
 		return -ENOMEM;
 
+	/*
+	 * Legacy bindings: ICU is one node with one MSI parent: force manually
+	 *                  the probe of the NSR interrupts side.
+	 * New bindings: ICU node has children, one per interrupt controller
+	 *               having its own MSI parent: call platform_populate().
+	 */
+	if (!of_get_child_count(pdev->dev.of_node))
+		icu->legacy_bindings = true;
+
 	icu->irq_chip.irq_mask = irq_chip_mask_parent;
 	icu->irq_chip.irq_unmask = irq_chip_unmask_parent;
 	icu->irq_chip.irq_eoi = irq_chip_eoi_parent;
@@ -286,7 +338,10 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, icu);
 
-	return mvebu_icu_nsr_probe(pdev);
+	if (icu->legacy_bindings)
+		return mvebu_icu_nsr_probe(pdev);
+	else
+		return devm_of_platform_populate(&pdev->dev);
 }
 
 static const struct of_device_id mvebu_icu_of_match[] = {
-- 
2.14.1
