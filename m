From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Thu, 14 Dec 2017 11:03:01 +0000
Subject: [PATCH] iommu/arm-smmu-v3: Don't free page table ops twice
Message-ID: <20171214110301.2998-1-jean-philippe.brucker@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kasan reports a double free when finalise_stage_fn fails: the io_pgtable
ops are freed by arm_smmu_domain_finalise and then again by
arm_smmu_domain_free. Prevent this by leaving pgtbl_ops empty on failure.

Fixes: 48ec83bcbcf5 ("iommu/arm-smmu: Add initial driver support for ARM SMMUv3 devices")
Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f122071688fd..db4281d0e269 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1698,13 +1698,15 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	domain->geometry.aperture_end = (1UL << ias) - 1;
 	domain->geometry.force_aperture = true;
-	smmu_domain->pgtbl_ops = pgtbl_ops;
 
 	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
-	if (ret < 0)
+	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
+		return ret;
+	}
 
-	return ret;
+	smmu_domain->pgtbl_ops = pgtbl_ops;
+	return 0;
 }
 
 static __le64 *arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
-- 
2.14.3
