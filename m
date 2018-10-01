From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon,  1 Oct 2018 16:13:53 +0200
Subject: [PATCH v6 09/14] irqchip/irq-mvebu-icu: add support for System Error
 Interrupts (SEI)
In-Reply-To: <20181001141358.31508-1-miquel.raynal@bootlin.com>
References: <20181001141358.31508-1-miquel.raynal@bootlin.com>
Message-ID: <20181001141358.31508-10-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far the ICU only handled NSR interrupts through GICP. An SEI driver
provides an MSI domain through which it is possible to raise SEI, so
let's add SEI support to the ICU driver.

Handle the NSR probe function in a more generic way to support other
type of interrupts.

Each interrupt domain is a tree domain to avoid allocation the 207
entries each time. Instead an ICU-wide bitmap is used to follow ICU
slot allocations.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 173 +++++++++++++++++++++++++-------
 1 file changed, 139 insertions(+), 34 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index c79d2cb787a0..21e7c5830fcc 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -27,6 +27,10 @@
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
@@ -37,11 +41,27 @@
 #define ICU_SATA0_ICU_ID	109
 #define ICU_SATA1_ICU_ID	107
 
+struct mvebu_icu_subset_data {
+	unsigned int icu_group;
+	unsigned int offset_set_ah;
+	unsigned int offset_set_al;
+	unsigned int offset_clr_ah;
+	unsigned int offset_clr_al;
+};
+
 struct mvebu_icu {
-	struct irq_chip irq_chip;
 	void __iomem *base;
 	struct device *dev;
+
+	/* Lock on interrupt allocations/releases */
+	struct mutex msi_lock;
+	DECLARE_BITMAP(msi_bitmap, ICU_MAX_IRQS);
+};
+
+struct mvebu_icu_msi_data {
+	struct mvebu_icu *icu;
 	atomic_t initialized;
+	const struct mvebu_icu_subset_data *subset_data;
 };
 
 struct mvebu_icu_irq_data {
@@ -52,28 +72,38 @@ struct mvebu_icu_irq_data {
 
 DEFINE_STATIC_KEY_FALSE(legacy_bindings);
 
-static void mvebu_icu_init(struct mvebu_icu *icu, struct msi_msg *msg)
+static void mvebu_icu_init(struct mvebu_icu *icu,
+			   struct mvebu_icu_msi_data *msi_data,
+			   struct msi_msg *msg)
 {
-	if (atomic_cmpxchg(&icu->initialized, false, true))
+	const struct mvebu_icu_subset_data *subset = msi_data->subset_data;
+
+	if (atomic_cmpxchg(&msi_data->initialized, false, true))
+		return;
+
+	/* Set 'SET' ICU SPI message address in AP */
+	writel_relaxed(msg[0].address_hi, icu->base + subset->offset_set_ah);
+	writel_relaxed(msg[0].address_lo, icu->base + subset->offset_set_al);
+
+	if (subset->icu_group != ICU_GRP_NSR)
 		return;
 
-	/* Set Clear/Set ICU SPI message address in AP */
-	writel_relaxed(msg[0].address_hi, icu->base + ICU_SETSPI_NSR_AH);
-	writel_relaxed(msg[0].address_lo, icu->base + ICU_SETSPI_NSR_AL);
-	writel_relaxed(msg[1].address_hi, icu->base + ICU_CLRSPI_NSR_AH);
-	writel_relaxed(msg[1].address_lo, icu->base + ICU_CLRSPI_NSR_AL);
+	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
+	writel_relaxed(msg[1].address_hi, icu->base + subset->offset_clr_ah);
+	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
 }
 
 static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct irq_data *d = irq_get_irq_data(desc->irq);
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d->domain);
 	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
 	struct mvebu_icu *icu = icu_irqd->icu;
 	unsigned int icu_int;
 
 	if (msg->address_lo || msg->address_hi) {
-		/* One off initialization */
-		mvebu_icu_init(icu, msg);
+		/* One off initialization per domain */
+		mvebu_icu_init(icu, msi_data, msg);
 		/* Configure the ICU with irq number & type */
 		icu_int = msg->data | ICU_INT_ENABLE;
 		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
@@ -103,10 +133,29 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	}
 }
 
+static struct irq_chip mvebu_icu_nsr_chip = {
+	.name			= "ICU-NSR",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
+static struct irq_chip mvebu_icu_sei_chip = {
+	.name			= "ICU-SEI",
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+};
+
 static int
 mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(d);
 	struct mvebu_icu *icu = platform_msi_get_host_data(d);
 	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
 
@@ -128,6 +177,14 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 	} else {
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+		/*
+		 * The ICU receives level interrupts. While the NSR are also
+		 * level interrupts, SEI are edge interrupts. Force the type
+		 * here in this case.
+		 */
+		if (msi_data->subset_data->icu_group == ICU_GRP_SEI)
+			*type = IRQ_TYPE_EDGE_RISING;
 	}
 
 	if (*hwirq >= ICU_MAX_IRQS) {
@@ -138,6 +195,25 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 	return 0;
 }
 
+static int mvebu_icu_msi_bitmap_region_alloc(struct mvebu_icu *icu, int hwirq)
+{
+	int ret;
+
+	mutex_lock(&icu->msi_lock);
+	ret = test_and_set_bit(hwirq, icu->msi_bitmap);
+	mutex_unlock(&icu->msi_lock);
+
+	return ret;
+}
+
+static void mvebu_icu_msi_bitmap_region_release(struct mvebu_icu *icu,
+						int hwirq)
+{
+	mutex_lock(&icu->msi_lock);
+	clear_bit(hwirq, icu->msi_bitmap);
+	mutex_unlock(&icu->msi_lock);
+}
+
 static int
 mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 			   unsigned int nr_irqs, void *args)
@@ -145,8 +221,10 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int err;
 	unsigned long hwirq;
 	struct irq_fwspec *fwspec = args;
-	struct mvebu_icu *icu = platform_msi_get_host_data(domain);
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(domain);
+	struct mvebu_icu *icu = msi_data->icu;
 	struct mvebu_icu_irq_data *icu_irqd;
+	struct irq_chip *chip = &mvebu_icu_nsr_chip;
 
 	icu_irqd = kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
 	if (!icu_irqd)
@@ -159,16 +237,20 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 		goto free_irqd;
 	}
 
+	err = mvebu_icu_msi_bitmap_region_alloc(icu, hwirq);
+	if (err)
+		goto free_irqd;
+
 	if (static_branch_unlikely(&legacy_bindings))
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
@@ -176,8 +258,11 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (err)
 		goto free_msi;
 
+	if (icu_irqd->icu_group == ICU_GRP_SEI)
+		chip = &mvebu_icu_sei_chip;
+
 	err = irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					    &icu->irq_chip, icu_irqd);
+					    chip, icu_irqd);
 	if (err) {
 		dev_err(icu->dev, "failed to set the data to IRQ domain\n");
 		goto free_msi;
@@ -187,6 +272,8 @@ mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 free_msi:
 	platform_msi_domain_free(domain, virq, nr_irqs);
+free_bitmap:
+	mvebu_icu_msi_bitmap_region_release(icu, hwirq);
 free_irqd:
 	kfree(icu_irqd);
 	return err;
@@ -196,12 +283,16 @@ static void
 mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 			  unsigned int nr_irqs)
 {
+	struct mvebu_icu_msi_data *msi_data = platform_msi_get_host_data(domain);
+	struct mvebu_icu *icu = msi_data->icu;
 	struct irq_data *d = irq_get_irq_data(virq);
 	struct mvebu_icu_irq_data *icu_irqd = d->chip_data;
 
 	kfree(icu_irqd);
 
 	platform_msi_domain_free(domain, virq, nr_irqs);
+
+	mvebu_icu_msi_bitmap_region_release(icu, d->hwirq);
 }
 
 static const struct irq_domain_ops mvebu_icu_domain_ops = {
@@ -210,28 +301,54 @@ static const struct irq_domain_ops mvebu_icu_domain_ops = {
 	.free      = mvebu_icu_irq_domain_free,
 };
 
+static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data = {
+	.icu_group = ICU_GRP_NSR,
+	.offset_set_ah = ICU_SETSPI_NSR_AH,
+	.offset_set_al = ICU_SETSPI_NSR_AL,
+	.offset_clr_ah = ICU_CLRSPI_NSR_AH,
+	.offset_clr_al = ICU_CLRSPI_NSR_AL,
+};
+
+static const struct mvebu_icu_subset_data mvebu_icu_sei_subset_data = {
+	.icu_group = ICU_GRP_SEI,
+	.offset_set_ah = ICU_SET_SEI_AH,
+	.offset_set_al = ICU_SET_SEI_AL,
+};
+
 static const struct of_device_id mvebu_icu_subset_of_match[] = {
 	{
 		.compatible = "marvell,cp110-icu-nsr",
+		.data = &mvebu_icu_nsr_subset_data,
+	},
+	{
+		.compatible = "marvell,cp110-icu-sei",
+		.data = &mvebu_icu_sei_subset_data,
 	},
 	{},
 };
 
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
+	struct mvebu_icu_msi_data *msi_data;
 	struct device_node *msi_parent_dn;
 	struct device *dev = &pdev->dev;
 	struct irq_domain *irq_domain;
-	struct mvebu_icu *icu;
+
+	msi_data = devm_kzalloc(dev, sizeof(*msi_data), GFP_KERNEL);
+	if (!msi_data)
+		return -ENOMEM;
 
 	/*
 	 * Device data being populated means we are using the legacy bindings.
 	 * Using the parent device data means we are using the new bindings.
 	 */
-	if (dev_get_drvdata(dev))
-		icu = dev_get_drvdata(dev);
-	else
-		icu = dev_get_drvdata(dev->parent);
+	if (dev_get_drvdata(dev)) {
+		msi_data->icu = dev_get_drvdata(dev);
+		msi_data->subset_data = &mvebu_icu_nsr_subset_data;
+	} else {
+		msi_data->icu = dev_get_drvdata(dev->parent);
+		msi_data->subset_data = of_device_get_match_data(dev);
+	}
 
 	dev->msi_domain = of_msi_get_domain(dev, dev->of_node,
 					    DOMAIN_BUS_PLATFORM_MSI);
@@ -245,7 +362,7 @@ static int mvebu_icu_subset_probe(struct platform_device *pdev)
 	irq_domain = platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
 							    mvebu_icu_write_msg,
 							    &mvebu_icu_domain_ops,
-							    icu);
+							    msi_data);
 	if (!irq_domain) {
 		dev_err(dev, "Failed to create ICU MSI domain\n");
 		return -ENOMEM;
@@ -283,11 +400,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 		return PTR_ERR(icu->base);
 	}
 
-	icu->irq_chip.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
-					    "ICU.%x",
-					    (unsigned int)res->start);
-	if (!icu->irq_chip.name)
-		return -ENOMEM;
+	mutex_init(&icu->msi_lock);
 
 	/*
 	 * Legacy bindings: ICU is one node with one MSI parent: force manually
@@ -299,16 +412,8 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	if (!of_get_child_count(pdev->dev.of_node))
 		static_branch_enable(&legacy_bindings);
 
-	icu->irq_chip.irq_mask = irq_chip_mask_parent;
-	icu->irq_chip.irq_unmask = irq_chip_unmask_parent;
-	icu->irq_chip.irq_eoi = irq_chip_eoi_parent;
-	icu->irq_chip.irq_set_type = irq_chip_set_type_parent;
-#ifdef CONFIG_SMP
-	icu->irq_chip.irq_set_affinity = irq_chip_set_affinity_parent;
-#endif
-
 	/*
-	 * Clean all ICU interrupts with type SPI_NSR, required to
+	 * Clean all ICU interrupts of type NSR and SEI, required to
 	 * avoid unpredictable SPI assignments done by firmware.
 	 */
 	for (i = 0 ; i < ICU_MAX_IRQS ; i++) {
-- 
2.17.1
