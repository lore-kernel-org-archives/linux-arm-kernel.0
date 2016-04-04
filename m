From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  4 Apr 2016 08:06:57 +0000
Subject: [PATCH v6 2/7] iommu/arm-smmu: advertise DOMAIN_ATTR_MSI_MAPPING
 attribute
In-Reply-To: <1459757222-2668-1-git-send-email-eric.auger@linaro.org>
References: <1459757222-2668-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1459757222-2668-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, MSI write transactions from device upstream to the smmu
are conveyed through the iommu. Therefore target physical addresses
must be mapped and DOMAIN_ATTR_MSI_MAPPING is set to advertise
this requirement on arm-smmu and arm-smmu-v3.

Signed-off-by: Eric Auger <eric.auger@linaro.org>
Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>

---

v4 -> v5:
- don't handle fsl_pamu_domain anymore
- handle arm-smmu-v3
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 drivers/iommu/arm-smmu.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4ff73ff..a077a35 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1900,6 +1900,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_MSI_MAPPING:
+		return 0;
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5158feb..6562752 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1429,6 +1429,8 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 	case DOMAIN_ATTR_NESTING:
 		*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 		return 0;
+	case DOMAIN_ATTR_MSI_MAPPING:
+		return 0;
 	default:
 		return -ENODEV;
 	}
-- 
1.9.1
