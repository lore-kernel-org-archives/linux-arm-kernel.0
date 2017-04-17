From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Mon, 17 Apr 2017 17:27:26 +0530
Subject: [PATCH] iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU is
 bypassed
Message-ID: <1492430246-17267-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

For software initiated address translation, when domain type is
IOMMU_DOMAIN_IDENTITY i.e SMMU is bypassed, mimic HW behavior
i.e return the same IOVA as translated address.

This patch is an extension to Will Deacon's patchset 
"Implement SMMU passthrough using the default domain".

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 41afb07..2f4a130 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1405,6 +1405,9 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return iova;
+
 	if (!ops)
 		return 0;
 
-- 
2.7.4
