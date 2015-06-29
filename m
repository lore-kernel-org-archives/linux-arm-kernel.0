From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jun 2015 17:47:43 +0100
Subject: [PATCH 2/2] iommu/arm-smmu: Delete an unnecessary check before the
 function call "free_io_pgtable_ops"
In-Reply-To: <1435596463-19247-1-git-send-email-will.deacon@arm.com>
References: <1435596463-19247-1-git-send-email-will.deacon@arm.com>
Message-ID: <1435596463-19247-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>

The free_io_pgtable_ops() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f14130121298..8e9ec81ce4bb 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1389,8 +1389,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (smmu_domain->pgtbl_ops)
-		free_io_pgtable_ops(smmu_domain->pgtbl_ops);
+	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
 	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-- 
2.1.4
