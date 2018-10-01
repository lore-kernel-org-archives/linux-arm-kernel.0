From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon,  1 Oct 2018 16:13:49 +0200
Subject: [PATCH v6 05/14] irqchip/irq-mvebu-icu: disociate ICU and NSR
In-Reply-To: <20181001141358.31508-1-miquel.raynal@bootlin.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
Message-ID: <20181001141358.31508-6-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NSR (non-secure interrupts) are handled in the ICU driver like if there
was only this type of interrupt in the ICU. Change this behavior to
prepare the introduction of SEI (System Error Interrupts) support by
moving the NSR code in a separate function. This is done under the form
of a 'probe' function to ease future migration to NSR/SEI being platform
devices part of the ICU. The 'icu' structure is passed as driver data
and not as a parameter for the same reason.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 57 ++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 0f2655d7f19e..d09f220a2701 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -39,7 +39,6 @@
 struct mvebu_icu {
 	struct irq_chip irq_chip;
 	void __iomem *base;
-	struct irq_domain *domain;
 	struct device *dev;
 	atomic_t initialized;
 };
@@ -204,11 +203,39 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
 	.free      = mvebu_icu_irq_domain_free,
 };
 
+static int mvebu_icu_subset_probe(struct platform_device *pdev)
+{
+	struct device_node *msi_parent_dn;
+	struct device *dev = &pdev->dev;
+	struct irq_domain *irq_domain;
+	struct mvebu_icu *icu;
+
+	icu = dev_get_drvdata(dev);
+
+	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
+					    DOMAIN_BUS_PLATFORM_MSI);
+	if (!dev->msi_domain)
+		return -EPROBE_DEFER;
+
+	msi_parent_dn = irq_domain_get_of_node(dev->msi_domain);
+	if (!msi_parent_dn)
+		return -ENODEV;
+
+	irq_domain = platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
+							    mvebu_icu_write_msg,
+							    &mvebu_icu_domain_ops,
+							    icu);
+	if (!irq_domain) {
+		dev_err(dev, "Failed to create ICU MSI domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
 	struct mvebu_icu *icu;
-	struct device_node *node = pdev->dev.of_node;
-	struct device_node *gicp_dn;
 	struct resource *res;
 	int i;
 
@@ -240,19 +267,6 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	icu->irq_chip.irq_set_affinity = irq_chip_set_affinity_parent;
 #endif
 
-	/*
-	 * We're probed after MSI domains have been resolved, so force
-	 * resolution here.
-	 */
-	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, node,
-						 DOMAIN_BUS_PLATFORM_MSI);
-	if (!pdev->dev.msi_domain)
-		return -EPROBE_DEFER;
-
-	gicp_dn = irq_domain_get_of_node(pdev->dev.msi_domain);
-	if (!gicp_dn)
-		return -ENODEV;
-
 	/*
 	 * Clean all ICU interrupts with type SPI_NSR, required to
 	 * avoid unpredictable SPI assignments done by firmware.
@@ -267,16 +281,9 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 			writel_relaxed(0x0, icu->base + ICU_INT_CFG(i));
 	}
 
-	icu->domain =
-		platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
-						  mvebu_icu_write_msg,
-						  &mvebu_icu_domain_ops, icu);
-	if (!icu->domain) {
-		dev_err(&pdev->dev, "Failed to create ICU domain\n");
-		return -ENOMEM;
-	}
+	platform_set_drvdata(pdev, icu);
 
-	return 0;
+	return mvebu_icu_subset_probe(pdev);
 }
 
 static const struct of_device_id mvebu_icu_of_match[] = {
-- 
2.17.1
