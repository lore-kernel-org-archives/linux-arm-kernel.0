From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 29 Jul 2015 19:46:11 +0100
Subject: [PATCH v2 8/9] iommu/arm-smmu-v3: Remove arm_smmu_flush_pgtable()
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Message-ID: <6d71f81bd98569f0b00701e4932df754370185e3.1438195011.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the io-pgtable code now enforcing its own appropriate sync points,
the vestigial flush_pgtable callback becomes entirely redundant, so
remove it altogether.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ac29d24..0c453fb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1301,20 +1301,10 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 	arm_smmu_cmdq_issue_cmd(smmu, &cmd);
 }
 
-static void arm_smmu_flush_pgtable(void *addr, size_t size, void *cookie)
-{
-	struct arm_smmu_domain *smmu_domain = cookie;
-
-	/* The page table code handles flushing in the non-coherent case */
-	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_COHERENCY)
-		dsb(ishst);
-}
-
 static struct iommu_gather_ops arm_smmu_gather_ops = {
 	.tlb_flush_all	= arm_smmu_tlb_inv_context,
 	.tlb_add_flush	= arm_smmu_tlb_inv_range_nosync,
 	.tlb_sync	= arm_smmu_tlb_sync,
-	.flush_pgtable	= arm_smmu_flush_pgtable,
 };
 
 /* IOMMU API */
-- 
1.9.1
