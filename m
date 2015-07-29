From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 29 Jul 2015 19:46:06 +0100
Subject: [PATCH v2 3/9] iommu/arm-smmu: Clean up DMA API usage
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Message-ID: <eba4661ed193ea41052764c2c60ae8932294e6f1.1438195011.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the correct DMA API calls now integrated into the io-pgtable code,
let that handle the flushing of non-coherent page table updates.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0583ed2..5770ab9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -611,24 +611,13 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	unsigned long offset = (unsigned long)addr & ~PAGE_MASK;
 
-
-	/* Ensure new page tables are visible to the hardware walker */
-	if (smmu->features & ARM_SMMU_FEAT_COHERENT_WALK) {
+	/*
+	 * Ensure new page tables are visible to a coherent hardware walker.
+	 * The page table code deals with flushing for the non-coherent case.
+	 */
+	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		dsb(ishst);
-	} else {
-		/*
-		 * If the SMMU can't walk tables in the CPU caches, treat them
-		 * like non-coherent DMA since we need to flush the new entries
-		 * all the way out to memory. There's no possibility of
-		 * recursion here as the SMMU table walker will not be wired
-		 * through another SMMU.
-		 */
-		dma_map_page(smmu->dev, virt_to_page(addr), offset, size,
-			     DMA_TO_DEVICE);
-	}
 }
 
 static struct iommu_gather_ops arm_smmu_gather_ops = {
@@ -899,6 +888,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 		.ias		= ias,
 		.oas		= oas,
 		.tlb		= &arm_smmu_gather_ops,
+		.iommu_dev	= smmu->dev,
 	};
 
 	smmu_domain->smmu = smmu;
-- 
1.9.1
