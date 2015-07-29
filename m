From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 29 Jul 2015 19:46:10 +0100
Subject: [PATCH v2 7/9] iommu/arm-smmu: Remove arm_smmu_flush_pgtable()
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Message-ID: <e0e55f7aae299088f90472feb4b54c8601ff3b81.1438195011.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the io-pgtable code now enforcing its own appropriate sync points,
the vestigial flush_pgtable callback becomes entirely redundant, so
remove it altogether.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5770ab9..48a39df 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -608,23 +608,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	}
 }
 
-static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
-{
-	struct arm_smmu_domain *smmu_domain = cookie;
-
-	/*
-	 * Ensure new page tables are visible to a coherent hardware walker.
-	 * The page table code deals with flushing for the non-coherent case.
-	 */
-	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
-		dsb(ishst);
-}
-
 static struct iommu_gather_ops arm_smmu_gather_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync,
-	.flush_pgtable	= arm_smmu_flush_pgtable,
 };
 
 static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
-- 
1.9.1
