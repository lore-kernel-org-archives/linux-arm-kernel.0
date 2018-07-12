From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Thu, 12 Jul 2018 14:18:31 +0800
Subject: [PATCH v3 5/6] iommu/arm-smmu-v3: add support for non-strict mode
In-Reply-To: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
References: <1531376312-2192-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1531376312-2192-6-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1. Add IOMMU_CAP_NON_STRICT capability.
2. Dynamic choose strict or non-strict mode base on the iommu domain type.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4402187..4a198a0 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1440,6 +1440,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_NOEXEC:
 		return true;
+	case IOMMU_CAP_NON_STRICT:
+		return true;
 	default:
 		return false;
 	}
@@ -1767,7 +1769,7 @@ static int arm_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	if (!ops)
 		return 0;
 
-	return ops->unmap(ops, iova, size);
+	return ops->unmap(ops, iova | IOMMU_DOMAIN_STRICT_MODE(domain), size);
 }
 
 static void arm_smmu_flush_iotlb_all(struct iommu_domain *domain)
@@ -1782,7 +1784,7 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
 {
 	struct arm_smmu_device *smmu = to_smmu_domain(domain)->smmu;
 
-	if (smmu)
+	if (smmu && (IOMMU_DOMAIN_STRICT_MODE(domain) == IOMMU_STRICT))
 		__arm_smmu_tlb_sync(smmu);
 }
 
-- 
1.8.3
