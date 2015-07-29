From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 29 Jul 2015 19:46:07 +0100
Subject: [PATCH v2 4/9] iommu/arm-smmu-v3: Clean up DMA API usage
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Message-ID: <c2cb4e3b6e7a30738e4d017e8640f08d930d5a82.1438195011.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the correct DMA API calls now integrated into the io-pgtable code,
let that handle the flushing of non-coherent page table updates.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8e9ec81..ac29d24 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1304,23 +1304,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
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
@@ -1502,6 +1489,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		.ias		= ias,
 		.oas		= oas,
 		.tlb		= &arm_smmu_gather_ops,
+		.iommu_dev	= smmu->dev,
 	};
 
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
-- 
1.9.1
