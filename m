From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue, 25 Apr 2017 15:27:52 +0530
Subject: [PATCH v2] iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU is
 bypassed
Message-ID: <1493114272-30093-1-git-send-email-sunil.kovvuri@gmail.com>
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

V2
- As per Will's suggestion applied fix to SMMUv3 driver as well.

 drivers/iommu/arm-smmu-v3.c | 3 +++
 drivers/iommu/arm-smmu.c    | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 05b4592..d412bdd 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1714,6 +1714,9 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return iova;
+
 	if (!ops)
 		return 0;
 
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index bfab4f7..81088cd 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1459,6 +1459,9 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct io_pgtable_ops *ops= smmu_domain->pgtbl_ops;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY)
+		return iova;
+
 	if (!ops)
 		return 0;
 
-- 
2.7.4
