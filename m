From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Mon, 28 Apr 2014 17:52:42 +0200
Subject: [RFC PATCH v5 02/11] ARM SMMU: Add capability IOMMU_CAP_DMA_EXEC
In-Reply-To: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <1398700371-20096-3-git-send-email-a.motakis@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM SMMU can take an IOMMU_EXEC protection flag in addition to
IOMMU_READ and IOMMU_WRITE. Expose this as an IOMMU capability.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
---
 drivers/iommu/arm-smmu.c | 2 ++
 include/linux/iommu.h    | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 1d9ab39..abf802f 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1509,6 +1509,8 @@ static int arm_smmu_domain_has_cap(struct iommu_domain *domain,
 	if (smmu_domain->root_cfg.smmu->features & ARM_SMMU_FEAT_COHERENT_WALK)
 		caps |= IOMMU_CAP_CACHE_COHERENCY;
 
+	caps |= IOMMU_CAP_DMA_EXEC;
+
 	return !!(cap & caps);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b96a5b2..4f547f3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -57,8 +57,9 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 };
 
-#define IOMMU_CAP_CACHE_COHERENCY	0x1
-#define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
+#define IOMMU_CAP_CACHE_COHERENCY	(1 << 0)
+#define IOMMU_CAP_INTR_REMAP		(1 << 1) /* isolates device intrs */
+#define IOMMU_CAP_DMA_EXEC		(1 << 2) /* EXEC protection flag */
 
 /*
  * Following constraints are specifc to FSL_PAMUV1:
-- 
1.8.3.2
