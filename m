From: robin.murphy@arm.com (Robin Murphy)
Date: Thu,  5 Mar 2015 18:56:36 +0000
Subject: [PATCH] iommu: arm-smmu: set a more appropriate DMA mask
Message-ID: <2ad6f0a7d198d607e252c420fef52d95dbe048c6.1425581413.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we use dma_map_page() as an architecture-independent means of
making page table updates visible to non-coherent SMMUs, we need to
have a suitable DMA mask set to discourage the DMA mapping layer from
creating bounce buffers and flushing those instead, if said page tables
happen to lie outside the default 32-bit mask.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index fc13dd5..dc0ae62 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1630,6 +1630,13 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
 	smmu->pa_size = size;
 
+	/*
+	 * What the page table walker can address actually depends on which
+	 * descriptor format is in use, but since a) we don't know that yet,
+	 * and b) it can vary per context bank, this will have to do...
+	 */
+	dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(size));
+
 	if (smmu->version == ARM_SMMU_V1) {
 		smmu->va_size = smmu->ipa_size;
 		size = SZ_4K | SZ_2M | SZ_1G;
-- 
1.9.1
