From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Sep 2014 17:50:04 +0100
Subject: [PATCH 6/7] iommu/arm-smmu: fix architecture version detection
In-Reply-To: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
References: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409849405-17347-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <Robin.Murphy@arm.com>

The SMMU driver was relying on a quirk of MMU-500 r2px to identify
the correct architecture version. Since this does not apply to other
implementations, make the architecture version for each supported
implementation explicit.

While we're at it, remove the unnecessary #ifdef since the dependencies
for CONFIG_ARM_SMMU already imply CONFIG_OF.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 47 +++++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 2a7e3331b93a..1f447e7843ed 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -331,6 +331,11 @@ module_param_named(force_stage, force_stage, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
 
+enum arm_smmu_arch_version {
+	ARM_SMMU_V1 = 1,
+	ARM_SMMU_V2,
+};
+
 struct arm_smmu_smr {
 	u8				idx;
 	u16				mask;
@@ -365,7 +370,7 @@ struct arm_smmu_device {
 
 #define ARM_SMMU_OPT_SECURE_CFG_ACCESS (1 << 0)
 	u32				options;
-	int				version;
+	enum arm_smmu_arch_version	version;
 
 	u32				num_context_banks;
 	u32				num_s2_context_banks;
@@ -730,7 +735,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 
 	/* CBAR */
 	reg = cfg->cbar;
-	if (smmu->version == 1)
+	if (smmu->version == ARM_SMMU_V1)
 		reg |= cfg->irptndx << CBAR_IRPTNDX_SHIFT;
 
 	/*
@@ -745,7 +750,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	}
 	writel_relaxed(reg, gr1_base + ARM_SMMU_GR1_CBAR(cfg->cbndx));
 
-	if (smmu->version > 1) {
+	if (smmu->version > ARM_SMMU_V1) {
 		/* CBA2R */
 #ifdef CONFIG_64BIT
 		reg = CBA2R_RW64_64BIT;
@@ -818,7 +823,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain)
 	 * TTBCR
 	 * We use long descriptor, with inner-shareable WBWA tables in TTBR0.
 	 */
-	if (smmu->version > 1) {
+	if (smmu->version > ARM_SMMU_V1) {
 		if (PAGE_SIZE == SZ_4K)
 			reg = TTBCR_TG0_4K;
 		else
@@ -915,7 +920,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		goto out_unlock;
 
 	cfg->cbndx = ret;
-	if (smmu->version == 1) {
+	if (smmu->version == ARM_SMMU_V1) {
 		cfg->irptndx = atomic_inc_return(&smmu->irptndx);
 		cfg->irptndx %= smmu->num_context_irqs;
 	} else {
@@ -1726,10 +1731,6 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	u32 id;
 
 	dev_notice(smmu->dev, "probing hardware configuration...\n");
-
-	/* Primecell ID */
-	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_PIDR2);
-	smmu->version = ((id >> PIDR2_ARCH_SHIFT) & PIDR2_ARCH_MASK) + 1;
 	dev_notice(smmu->dev, "SMMUv%d with:\n", smmu->version);
 
 	/* ID0 */
@@ -1846,7 +1847,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
 	smmu->s2_output_size = min_t(unsigned long, PHYS_MASK_SHIFT, size);
 
-	if (smmu->version == 1) {
+	if (smmu->version == ARM_SMMU_V1) {
 		smmu->s1_input_size = 32;
 	} else {
 #ifdef CONFIG_64BIT
@@ -1877,8 +1878,18 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static struct of_device_id arm_smmu_of_match[] = {
+	{ .compatible = "arm,smmu-v1", .data = (void *)ARM_SMMU_V1 },
+	{ .compatible = "arm,smmu-v2", .data = (void *)ARM_SMMU_V2 },
+	{ .compatible = "arm,mmu-400", .data = (void *)ARM_SMMU_V1 },
+	{ .compatible = "arm,mmu-500", .data = (void *)ARM_SMMU_V2 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
+
 static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id;
 	struct resource *res;
 	struct arm_smmu_device *smmu;
 	struct device *dev = &pdev->dev;
@@ -1893,6 +1904,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 	}
 	smmu->dev = dev;
 
+	of_id = of_match_node(arm_smmu_of_match, dev->of_node);
+	smmu->version = (enum arm_smmu_arch_version)of_id->data;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	smmu->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(smmu->base))
@@ -1957,7 +1971,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	parse_driver_options(smmu);
 
-	if (smmu->version > 1 &&
+	if (smmu->version > ARM_SMMU_V1 &&
 	    smmu->num_context_banks != smmu->num_context_irqs) {
 		dev_err(dev,
 			"found only %d context interrupt(s) but %d required\n",
@@ -2038,17 +2052,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-static struct of_device_id arm_smmu_of_match[] = {
-	{ .compatible = "arm,smmu-v1", },
-	{ .compatible = "arm,smmu-v2", },
-	{ .compatible = "arm,mmu-400", },
-	{ .compatible = "arm,mmu-500", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
-#endif
-
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.owner		= THIS_MODULE,
-- 
2.1.0
