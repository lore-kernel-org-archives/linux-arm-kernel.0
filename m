From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Mar 2015 18:15:35 +0000
Subject: [PATCH 2/4] iommu/arm-smmu: set a more appropriate DMA mask
In-Reply-To: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
References: <1426875337-12808-1-git-send-email-will.deacon@arm.com>
Message-ID: <1426875337-12808-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <Robin.Murphy@arm.com>

Since we use dma_map_page() as an architecture-independent means of
making page table updates visible to non-coherent SMMUs, we need to
have a suitable DMA mask set to discourage the DMA mapping layer from
creating bounce buffers and flushing those instead, if said page tables
happen to lie outside the default 32-bit mask.

Tested-by: Mitchel Humpherys <mitchelh@codeaurora.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[will: added error checking]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4abb831e24f0..161dd46999e2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1634,6 +1634,15 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
 	smmu->pa_size = size;
 
+	/*
+	 * What the page table walker can address actually depends on which
+	 * descriptor format is in use, but since a) we don't know that yet,
+	 * and b) it can vary per context bank, this will have to do...
+	 */
+	if (dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(size)))
+		dev_warn(smmu->dev,
+			 "failed to set DMA mask for table walker\n");
+
 	if (smmu->version == ARM_SMMU_V1) {
 		smmu->va_size = smmu->ipa_size;
 		size = SZ_4K | SZ_2M | SZ_1G;
-- 
2.1.4
