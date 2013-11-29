From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Nov 2013 12:14:34 +0000
Subject: [PATCH 2/3] iommu/arm-smmu: remove potential NULL dereference on
 mapping path
In-Reply-To: <1385727275-19082-1-git-send-email-will.deacon@arm.com>
References: <1385727275-19082-1-git-send-email-will.deacon@arm.com>
Message-ID: <1385727275-19082-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When handling mapping requests, we dereference the SMMU domain before
checking that it is NULL. This patch fixes the issue by removing the check
altogether, since we don't actually use the leaf_smmu when creating
mappings.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/iommu/arm-smmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6dbcaa4433cd..ef77e3dd6dd2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1423,9 +1423,8 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 			phys_addr_t paddr, size_t size, int flags)
 {
 	struct arm_smmu_domain *smmu_domain = domain->priv;
-	struct arm_smmu_device *smmu = smmu_domain->leaf_smmu;
 
-	if (!smmu_domain || !smmu)
+	if (!smmu_domain)
 		return -ENODEV;
 
 	/* Check for silent address truncation up the SMMU chain. */
-- 
1.8.2.2
