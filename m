From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Aug 2015 14:25:52 +0100
Subject: [PATCH 10/13] iommu/arm-smmu: Remove arm_smmu_flush_pgtable()
In-Reply-To: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
References: <1438608355-7335-1-git-send-email-will.deacon@arm.com>
Message-ID: <1438608355-7335-11-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robin Murphy <Robin.Murphy@arm.com>

With the io-pgtable code now enforcing its own appropriate sync points,
the vestigial flush_pgtable callback becomes entirely redundant, so
remove it altogether.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5770ab98fa38..48a39dfa9777 100644
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
2.1.4
