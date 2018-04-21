From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 15:55:32 +0200
Subject: [PATCH 12/17] irqchip/irq-mvebu-icu: add support for System Error
 Interrupts (SEI)
In-Reply-To: <20180421135537.24716-1-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
Message-ID: <20180421135537.24716-13-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An SEI driver provides an MSI domain through which it is possible to
raise SEIs.

Handle the NSR probe function in a more generic way to support other
type of interrupts (ie. the SEIs).

For clarity we do not use tree IRQ domains for now but linear ones
instead, allocating the 207 ICU lines for each interrupt group.
Reallocating an ICU slot is prevented by the use of an ICU-wide bitmap.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 132 +++++++++++++++++++++++++++++++++-------
 1 file changed, 110 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 1d3cd112619c..862541f2d135 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -24,12 +24,17 @@
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
 #include "irq-mvebu-gicp.h"
+#include "irq-mvebu-sei.h"
 
 /* ICU registers */
 #define ICU_SETSPI_NSR_AL	0x10
 #define ICU_SETSPI_NSR_AH	0x14
 #define ICU_CLRSPI_NSR_AL	0x18
 #define ICU_CLRSPI_NSR_AH	0x1c
+#define ICU_SET_SEI_AL		0x50
+#define ICU_SET_SEI_AH		0x54
+#define ICU_CLR_SEI_AL		0x58
+#define ICU_CLR_SEI_AH		0x5C
 #define ICU_INT_CFG(x)          (0x100 + 4 * (x))
 #define   ICU_INT_ENABLE	BIT(24)
 #define   ICU_IS_EDGE		BIT(28)
@@ -40,11 +45,29 @@
 #define ICU_SATA0_ICU_ID	109
 #define ICU_SATA1_ICU_ID	107
 
+struct mvebu_icu_subset_data {
+	int (*get_doorbells)(struct device_node *msi_parent_dn,
+			     phys_addr_t *set, phys_addr_t *clr);
+	unsigned int offset_set_ah;
+	unsigned int offset_set_al;
+	unsigned int offset_clr_ah;
+	unsigned int offset_clr_al;
+	unsigned int icu_group;
+};
+
 struct mvebu_icu {
 	struct irq_chip irq_chip;
 	struct regmap *regmap;
 	struct device *dev;
 	bool legacy_bindings;
+	/* Lock on interrupt allocations/releases */
+	spinlock_t msi_lock;
+	DECLARE_BITMAP(msi_bitmap, ICU_MAX_IRQS);
+};
+
+struct mvebu_icu_msi_data {
+	struct mvebu_icu *icu;
+	const struct mvebu_icu_subset_data *subset_data;
 };
 
 struct mvebu_icu_irq_data {
@@ -115,7 +138,8 @@ static int
 mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
-	struct mvebu_icu *icu = platform_msi_get_host_data(d);
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
+	struct mvebu_icu *icu = msi_data->icu;
 	unsigned int param_count = icu->legacy_bindings ? 3 : 2;
 
 	/* Check the count of the parameters in dt */
@@ -156,7 +180,9 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int err;
 	unsigned long hwirq;
 	struct irq_fwspec *fwspec = args;
-	struct mvebu_icu *icu = platform_msi_get_host_data(domain);
+	struct mvebu_icu_msi_data *msi_data =
+		platform_msi_get_host_data(domain);
+	struct mvebu_icu *icu = msi_data->icu;
 	struct mvebu_icu_irq_data *icu_irqd;
 
 	icu_irqd = kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
@@ -170,16 +196,22 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		goto free_irqd;
 	}
 
+	spin_lock(&icu->msi_lock);
+	err = bitmap_allocate_region(icu->msi_bitmap, hwirq, 0);
+	spin_unlock(&icu->msi_lock);
+	if (err < 0)
+		goto free_irqd;
+
 	if (icu->legacy_bindings)
 		icu_irqd->icu_group = fwspec->param[0];
 	else
-		icu_irqd->icu_group = ICU_GRP_NSR;
+		icu_irqd->icu_group = msi_data->subset_data->icu_group;
 	icu_irqd->icu = icu;
 
 	err = platform_msi_domain_alloc(domain, virq, nr_irqs);
 	if (err) {
 		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
-		goto free_irqd;
+		goto free_bitmap;
 	}
 
 	/* Make sure there is no interrupt left pending by the firmware */
@@ -198,6 +230,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 free_msi:
 	platform_msi_domain_free(domain, virq, nr_irqs);
+free_bitmap:
+	spin_lock(&icu->msi_lock);
+	bitmap_release_region(icu->msi_bitmap, hwirq, 0);
+	spin_unlock(&icu->msi_lock);
 free_irqd:
 	kfree(icu_irqd);
 	return err;
@@ -207,12 +243,19 @@ static void
 mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 			  unsigned int nr_irqs)
 {
+	struct mvebu_icu_msi_data *msi_data =
+		platform_msi_get_host_data(domain);
+	struct mvebu_icu *icu = msi_data->icu;
 	struct irq_data *d = irq_get_irq_data(virq);
 	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
 
 	kfree(icu_irqd);
 
 	platform_msi_domain_free(domain, virq, nr_irqs);
+
+	spin_lock(&icu->msi_lock);
+	bitmap_release_region(icu->msi_bitmap, d->hwirq, 0);
+	spin_unlock(&icu->msi_lock);
 }
 
 static const struct irq_domain_ops mvebu_icu_domain_ops = {
@@ -221,18 +264,33 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
 	.free      = mvebu_icu_irq_domain_free,
 };
 
-static int mvebu_icu_nsr_probe(struct platform_device *pdev)
+static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
+	const struct mvebu_icu_subset_data *subset;
+	struct mvebu_icu_msi_data *msi_data;
 	struct device_node *msi_parent_dn;
 	struct irq_domain *irq_domain;
 	struct mvebu_icu *icu;
 	phys_addr_t set, clr;
 	int ret;
 
+	msi_data = devm_kzalloc(&pdev->dev, sizeof(*msi_data), GFP_KERNEL);
+	if (!msi_data)
+		return -ENOMEM;
+
 	icu = mvebu_dev_get_drvdata(pdev);
 	if (IS_ERR(icu))
 		return PTR_ERR(icu);
 
+	subset = of_device_get_match_data(&pdev->dev);
+	if (!subset) {
+		dev_err(&pdev->dev, "Could not retrieve subset data\n");
+		return -EINVAL;
+	}
+
+	msi_data->icu = icu;
+	msi_data->subset_data = subset;
+
 	pdev->dev.msi_domain = of_msi_get_domain(&pdev->dev, pdev->dev.of_node,
 						 DOMAIN_BUS_PLATFORM_MSI);
 	if (!pdev->dev.msi_domain)
@@ -243,19 +301,19 @@ static int mvebu_icu_nsr_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Set Clear/Set ICU NSR SPI message address in AP */
-	ret = mvebu_gicp_get_doorbells(msi_parent_dn, &set, &clr);
+	ret = subset->get_doorbells(msi_parent_dn, &set, &clr);
 	if (ret)
 		return ret;
 
-	regmap_write(icu->regmap, ICU_SETSPI_NSR_AH, upper_32_bits(set));
-	regmap_write(icu->regmap, ICU_SETSPI_NSR_AL, lower_32_bits(set));
-	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AH, upper_32_bits(clr));
-	regmap_write(icu->regmap, ICU_CLRSPI_NSR_AL, lower_32_bits(clr));
+	regmap_write(icu->regmap, subset->offset_set_ah, upper_32_bits(set));
+	regmap_write(icu->regmap, subset->offset_set_al, lower_32_bits(set));
+	regmap_write(icu->regmap, subset->offset_clr_ah, upper_32_bits(clr));
+	regmap_write(icu->regmap, subset->offset_clr_al, lower_32_bits(clr));
 
 	irq_domain = platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
 						       mvebu_icu_write_msg,
 						       &mvebu_icu_domain_ops,
-						       icu);
+						       msi_data);
 	if (!irq_domain) {
 		dev_err(&pdev->dev, "Failed to create ICU MSI domain\n");
 		return -ENOMEM;
@@ -264,19 +322,44 @@ static int mvebu_icu_nsr_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id mvebu_icu_nsr_of_match[] = {
-	{ .compatible = "marvell,cp110-icu-nsr", },
+static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data = {
+	.get_doorbells = mvebu_gicp_get_doorbells,
+	.offset_set_ah = ICU_SETSPI_NSR_AH,
+	.offset_set_al = ICU_SETSPI_NSR_AL,
+	.offset_clr_ah = ICU_CLRSPI_NSR_AH,
+	.offset_clr_al = ICU_CLRSPI_NSR_AL,
+	.icu_group = ICU_GRP_NSR,
+};
+
+static const struct mvebu_icu_subset_data mvebu_icu_sei_subset_data = {
+	.get_doorbells = mvebu_sei_get_doorbells,
+	.offset_set_ah = ICU_SET_SEI_AH,
+	.offset_set_al = ICU_SET_SEI_AL,
+	.offset_clr_ah = ICU_CLR_SEI_AH,
+	.offset_clr_al = ICU_CLR_SEI_AL,
+	.icu_group = ICU_GRP_SEI,
+};
+
+static const struct of_device_id mvebu_icu_subset_of_match[] = {
+	{
+		.compatible = "marvell,cp110-icu-nsr",
+		.data = &mvebu_icu_nsr_subset_data,
+	},
+	{
+		.compatible = "marvell,cp110-icu-sei",
+		.data = &mvebu_icu_sei_subset_data,
+	},
 	{},
 };
 
-static struct platform_driver mvebu_icu_nsr_driver = {
-	.probe  = mvebu_icu_nsr_probe,
+static struct platform_driver mvebu_icu_subset_drivers = {
+	.probe  = mvebu_icu_subset_probe,
 	.driver = {
-		.name = "mvebu-icu-nsr",
-		.of_match_table = mvebu_icu_nsr_of_match,
+		.name = "mvebu-icu-subset",
+		.of_match_table = mvebu_icu_subset_of_match,
 	},
 };
-builtin_platform_driver(mvebu_icu_nsr_driver);
+builtin_platform_driver(mvebu_icu_subset_drivers);
 
 static int mvebu_icu_probe(struct platform_device *pdev)
 {
@@ -291,6 +374,8 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 
 	icu->dev = &pdev->dev;
 
+	spin_lock_init(&icu->msi_lock);
+
 	icu->regmap = syscon_regmap_lookup_by_phandle(pdev->dev.of_node, NULL);
 	if (IS_ERR(icu->regmap))
 		return PTR_ERR(icu->regmap);
@@ -323,7 +408,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 #endif
 
 	/*
-	 * Clean all ICU interrupts with type SPI_NSR, required to
+	 * Clean all ICU interrupts of type SPI_NSR and SEI, required to
 	 * avoid unpredictable SPI assignments done by firmware.
 	 */
 	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
@@ -332,20 +417,23 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 		regmap_read(icu->regmap, ICU_INT_CFG(i), &icu_int);
 		icu_grp = icu_int >> ICU_GROUP_SHIFT;
 
-		if (icu_grp == ICU_GRP_NSR)
+		if (icu_grp == ICU_GRP_NSR ||
+		    (icu_grp == ICU_GRP_SEI && !icu->legacy_bindings))
 			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
 	}
 
 	platform_set_drvdata(pdev, icu);
 
 	if (icu->legacy_bindings)
-		return mvebu_icu_nsr_probe(pdev);
+		return mvebu_icu_subset_probe(pdev);
 	else
 		return devm_of_platform_populate(&pdev->dev);
 }
 
 static const struct of_device_id mvebu_icu_of_match[] = {
-	{ .compatible = "marvell,cp110-icu", },
+	{
+		.compatible = "marvell,cp110-icu",
+	},
 	{},
 };
 
-- 
2.14.1
