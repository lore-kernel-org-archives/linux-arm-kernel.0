From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 28 Apr 2016 08:15:17 +0000
Subject: [PATCH v8 2/8] iommu/arm-smmu: sets the MSI geometry to programmable
In-Reply-To: <1461831323-5480-1-git-send-email-eric.auger@linaro.org>
References: <1461831323-5480-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1461831323-5480-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM, MSI write transactions from device upstream to the smmu
are conveyed through the iommu. Therefore target physical addresses
must be mapped and DOMAIN_ATTR_MSI_GEOMETRY advertises a programmable
MSI IOVA region.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v7 -> v8:
- use DOMAIN_ATTR_MSI_GEOMETRY

v4 -> v5:
- don't handle fsl_pamu_domain anymore
- handle arm-smmu-v3
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 drivers/iommu/arm-smmu.c    | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 4ff73ff..bf222b5 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1396,6 +1396,7 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct iommu_domain_msi_geometry msi_geometry = {0, 0, true};
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
@@ -1414,6 +1415,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		kfree(smmu_domain);
 		return NULL;
 	}
+	smmu_domain->domain.msi_geometry = msi_geometry;
 
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c39ac4..55f429d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -976,6 +976,7 @@ static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
+	struct iommu_domain_msi_geometry msi_geometry = {0, 0, true};
 
 	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
@@ -994,6 +995,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 	}
 
+	smmu_domain->domain.msi_geometry = msi_geometry;
+
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
 
-- 
1.9.1
