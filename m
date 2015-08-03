From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Aug 2015 14:25:49 +0100
Subject: [PATCH 07/13] iommu/arm-smmu: Clean up DMA API usage
In-Reply-To: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
Message-ID: <1438608355-7335-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <Robin.Murphy@arm.com>

With the correct DMA API calls now integrated into the io-pgtable code,
let that handle the flushing of non-coherent page table updates.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4f093373f4c3..38a891e28e13 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1334,23 +1334,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
 
-	if (smmu->features & ARM_SMMU_FEAT_COHERENCY) {
+	/* The page table code handles flushing in the non-coherent case */
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENCY)
 		dsb(ishst);
-	} else {
-		dma_addr_t dma_addr;
-		struct device *dev = smmu->dev;
-
-		dma_addr = dma_map_page(dev, virt_to_page(addr), offset, size,
-					DMA_TO_DEVICE);
-
-		if (dma_mapping_error(dev, dma_addr))
-			dev_err(dev, "failed to flush pgtable at %p\n", addr);
-		else
-			dma_unmap_page(dev, dma_addr, size, DMA_TO_DEVICE);
-	}
 }
 
 static struct iommu_gather_ops arm_smmu_gather_ops = {
@@ -1532,6 +1519,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		.ias		= ias,
 		.oas		= oas,
 		.tlb		= &arm_smmu_gather_ops,
+		.iommu_dev	= smmu->dev,
 	};
 
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
-- 
2.1.4
