From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 13 Apr 2016 18:13:03 +0100
Subject: [PATCH 7/7] iommu/arm-smmu: Support SMMUv1 64KB supplement
In-Reply-To: <cover.1460391217.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
Message-ID: <119e74a022bf9ee11a2b787233af731e16d75995.1460391217.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 64KB Translation Granule Supplement to the SMMUv1 architecture
allows an SMMUv1 implementation to support 64KB pages for stage 2
translations, using a constrained VMSAv8 descriptor format limited
to 40-bit addresses. Now that we can freely mix and match context
formats, we can actually handle having 4KB pages via an AArch32
context but 64KB pages via an AArch64 context, so plumb it in.

It is assumed that any implementations will have hardware capabilities
matching the format constraints, thus obviating the need for excessive
sanity-checking; this is the case for MMU-401, the only ARM Ltd.
implementation.

CC: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1d4285f..00aa948 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -277,7 +277,8 @@ MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
 
 enum arm_smmu_arch_version {
-	ARM_SMMU_V1 = 1,
+	ARM_SMMU_V1,
+	ARM_SMMU_V1_64K,
 	ARM_SMMU_V2,
 };
 
@@ -769,7 +770,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 
 	/* CBAR */
 	reg = cfg->cbar;
-	if (smmu->version == ARM_SMMU_V1)
+	if (smmu->version < ARM_SMMU_V2)
 		reg |= cfg->irptndx << CBAR_IRPTNDX_SHIFT;
 
 	/*
@@ -942,7 +943,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		goto out_unlock;
 
 	cfg->cbndx = ret;
-	if (smmu->version == ARM_SMMU_V1) {
+	if (smmu->version < ARM_SMMU_V2) {
 		cfg->irptndx = atomic_inc_return(&smmu->irptndx);
 		cfg->irptndx %= smmu->num_context_irqs;
 	} else {
@@ -1627,7 +1628,8 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	bool cttw_dt, cttw_reg;
 
 	dev_notice(smmu->dev, "probing hardware configuration...\n");
-	dev_notice(smmu->dev, "SMMUv%d with:\n", smmu->version);
+	dev_notice(smmu->dev, "SMMUv%d with:\n",
+			smmu->version == ARM_SMMU_V2 ? 2 : 1);
 
 	/* ID0 */
 	id = readl_relaxed(gr0_base + ARM_SMMU_GR0_ID0);
@@ -1659,7 +1661,8 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		return -ENODEV;
 	}
 
-	if ((id & ID0_S1TS) && ((smmu->version == 1) || !(id & ID0_ATOSNS))) {
+	if ((id & ID0_S1TS) &&
+		((smmu->version < ARM_SMMU_V2) || !(id & ID0_ATOSNS))) {
 		smmu->features |= ARM_SMMU_FEAT_TRANS_OPS;
 		dev_notice(smmu->dev, "\taddress translation ops\n");
 	}
@@ -1774,8 +1777,10 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 		dev_warn(smmu->dev,
 			 "failed to set DMA mask for table walker\n");
 
-	if (smmu->version == ARM_SMMU_V1) {
+	if (smmu->version < ARM_SMMU_V2) {
 		smmu->va_size = smmu->ipa_size;
+		if (smmu->version == ARM_SMMU_V1_64K)
+			smmu->features |= ARM_SMMU_FEAT_FMT_AARCH64_64K;
 	} else {
 		size = (id >> ID2_UBS_SHIFT) & ID2_UBS_MASK;
 		smmu->va_size = arm_smmu_id_size_to_bits(size);
@@ -1827,6 +1832,7 @@ static struct arm_smmu_match_data name = { .version = ver, .model = imp }
 
 ARM_SMMU_MATCH_DATA(smmu_generic_v1, ARM_SMMU_V1, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(smmu_generic_v2, ARM_SMMU_V2, GENERIC_SMMU);
+ARM_SMMU_MATCH_DATA(arm_mmu401, ARM_SMMU_V1_64K, GENERIC_SMMU);
 ARM_SMMU_MATCH_DATA(arm_mmu500, ARM_SMMU_V2, ARM_MMU500);
 ARM_SMMU_MATCH_DATA(cavium_smmuv2, ARM_SMMU_V2, CAVIUM_SMMUV2);
 
@@ -1834,7 +1840,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", .data = &smmu_generic_v1 },
 	{ .compatible = "arm,smmu-v2", .data = &smmu_generic_v2 },
 	{ .compatible = "arm,mmu-400", .data = &smmu_generic_v1 },
-	{ .compatible = "arm,mmu-401", .data = &smmu_generic_v1 },
+	{ .compatible = "arm,mmu-401", .data = &arm_mmu401 },
 	{ .compatible = "arm,mmu-500", .data = &arm_mmu500 },
 	{ .compatible = "cavium,smmu-v2", .data = &cavium_smmuv2 },
 	{ },
@@ -1928,7 +1934,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
 
 	parse_driver_options(smmu);
 
-	if (smmu->version > ARM_SMMU_V1 &&
+	if (smmu->version == ARM_SMMU_V2 &&
 	    smmu->num_context_banks != smmu->num_context_irqs) {
 		dev_err(dev,
 			"found only %d context interrupt(s) but %d required\n",
-- 
2.7.3.dirty
