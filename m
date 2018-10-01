From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon,  1 Oct 2018 16:13:50 +0200
Subject: [PATCH v6 06/14] irqchip/irq-mvebu-icu: support ICU subnodes
In-Reply-To: <20181001141358.31508-1-miquel.raynal@bootlin.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
Message-ID: <20181001141358.31508-7-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ICU can handle several type of interrupt, each of them being handled
differently on AP side. On CP side, the ICU should be able to make the
distinction between each interrupt group by pointing to the right parent.

This is done through the introduction of new bindings, presenting the ICU
node as the parent of multiple ICU sub-nodes, each of them being an
interrupt type with a different interrupt parent. ICU interrupt 'clients'
now directly point to the right sub-node, avoiding the need for the extra
ICU_GRP_* parameter.

ICU subnodes are probed automatically with devm_platform_populate(). If
the node as no child, the probe function for NSRs will still be called
'manually' in order to preserve backward compatibility with DT using the
old binding.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 77 ++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index d09f220a2701..c79d2cb787a0 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
+#include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
 #include <linux/of_irq.h>
@@ -49,6 +50,8 @@ struct mvebu_icu_irq_data {
 	unsigned int type;
 };
 
+DEFINE_STATIC_KEY_FALSE(legacy_bindings);
+
 static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
 {
 	if (atomic_cmpxchg(&icu->initialized, false, true))
@@ -105,32 +108,33 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
 	struct mvebu_icu *icu = platform_msi_get_host_data(d);
-	unsigned int icu_group;
+	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
 
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
+	if (static_branch_unlikely(&legacy_bindings)) {
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		if (fwspec->param[0] != ICU_GRP_NSR) {
+			dev_err(icu->dev, "wrong ICU group type %x\n",
+				fwspec->param[0]);
+			return -EINVAL;
+		}
+	} else {
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
 	}
 
-	*hwirq = fwspec->param[1];
 	if (*hwirq >= ICU_MAX_IRQS) {
 		dev_err(icu->dev, "invalid interrupt number %ld\n", *hwirq);
 		return -EINVAL;
 	}
 
-	/* Mask the type to prevent wrong DT configuration */
-	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-
 	return 0;
 }
 
@@ -155,7 +159,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		goto free_irqd;
 	}
 
-	icu_irqd->icu_group = fwspec->param[0];
+	if (static_branch_unlikely(&legacy_bindings))
+		icu_irqd->icu_group = fwspec->param[0];
+	else
+		icu_irqd->icu_group = ICU_GRP_NSR;
 	icu_irqd->icu = icu;
 
 	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
@@ -203,6 +210,13 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
 	.free      = mvebu_icu_irq_domain_free,
 };
 
+static const struct of_device_id mvebu_icu_subset_of_match[] = {
+	{
+		.compatible = "marvell,cp110-icu-nsr",
+	},
+	{},
+};
+
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
 	struct device_node *msi_parent_dn;
@@ -210,7 +224,14 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 	struct irq_domain *irq_domain;
 	struct mvebu_icu *icu;
 
-	icu = dev_get_drvdata(dev);
+	/*
+	 * Device data being populated means we are using the legacy bindings.
+	 * Using the parent device data means we are using the new bindings.
+	 */
+	if (dev_get_drvdata(dev))
+		icu = dev_get_drvdata(dev);
+	else
+		icu = dev_get_drvdata(dev->parent);
 
 	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_PLATFORM_MSI);
@@ -233,6 +254,15 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_driver mvebu_icu_subset_driver = {
+	.probe  = mvebu_icu_subset_probe,
+	.driver = {
+		.name = "mvebu-icu-subset",
+		.of_match_table = mvebu_icu_subset_of_match,
+	},
+};
+builtin_platform_driver(mvebu_icu_subset_driver);
+
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
@@ -259,6 +289,16 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	if (!icu->irq_chip.name)
 		return -ENOMEM;
 
+	/*
+	 * Legacy bindings: ICU is one node with one MSI parent: force manually
+	 *                  the probe of the NSR interrupts side.
+	 * New bindings: ICU node has children, one per interrupt controller
+	 *               having its own MSI parent: call platform_populate().
+	 * All ICU instances should use the same bindings.
+	 */
+	if (!of_get_child_count(pdev->dev.of_node))
+		static_branch_enable(&legacy_bindings);
+
 	icu->irq_chip.irq_mask = irq_chip_mask_parent;
 	icu->irq_chip.irq_unmask = irq_chip_unmask_parent;
 	icu->irq_chip.irq_eoi = irq_chip_eoi_parent;
@@ -277,13 +317,18 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 		icu_int = readl_relaxed(icu->base + ICU_INT_CFG(i));
 		icu_grp = icu_int >> ICU_GROUP_SHIFT;
 
-		if (icu_grp == ICU_GRP_NSR)
+		if (icu_grp == ICU_GRP_NSR ||
+		    (icu_grp == ICU_GRP_SEI &&
+		     !static_branch_unlikely(&legacy_bindings)))
 			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
 	}
 
 	platform_set_drvdata(pdev, icu);
 
-	return mvebu_icu_subset_probe(pdev);
+	if (static_branch_unlikely(&legacy_bindings))
+		return mvebu_icu_subset_probe(pdev);
+	else
+		return devm_of_platform_populate(&pdev->dev);
 }
 
 static const struct of_device_id mvebu_icu_of_match[] = {
-- 
2.17.1
