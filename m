From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 26 Jan 2016 18:06:36 +0000
Subject: [PATCH 3/4] iommu/arm-smmu: Support DMA-API domains
In-Reply-To: <cover.1453830752.git.robin.murphy@arm.com>
References: <cover.1453830752.git.robin.murphy@arm.com>
Message-ID: <713b480816536d959b31befe2758b526eabcf0ab.1453830752.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With DMA mapping ops provided by the iommu-dma code, only a minimal
contribution from the IOMMU driver is needed to create a suitable
DMA-API domain for them to use. Implement this for the ARM SMMUs.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 10 +++++++++-
 drivers/iommu/arm-smmu.c    | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2087534..f003b3a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -21,6 +21,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
@@ -1396,7 +1397,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 
 	/*
@@ -1408,6 +1409,12 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	if (!smmu_domain)
 		return NULL;
 
+	if (type == IOMMU_DOMAIN_DMA &&
+	    iommu_get_dma_cookie(&smmu_domain->domain)) {
+		kfree(smmu_domain);
+		return NULL;
+	}
+
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
 	return &smmu_domain->domain;
@@ -1436,6 +1443,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
+	iommu_put_dma_cookie(domain);
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
 	/* Free the CD and ASID, if we allocated them */
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d1b7dc1..18e0e10 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -29,6 +29,7 @@
 #define pr_fmt(fmt) "arm-smmu: " fmt
 
 #include <linux/delay.h>
+#include <linux/dma-iommu.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -976,7 +977,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED)
+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
 		return NULL;
 	/*
 	 * Allocate the domain and initialise some of its data structures.
@@ -987,6 +988,12 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 	if (!smmu_domain)
 		return NULL;
 
+	if (type == IOMMU_DOMAIN_DMA &&
+	    iommu_get_dma_cookie(&smmu_domain->domain)) {
+		kfree(smmu_domain);
+		return NULL;
+	}
+
 	mutex_init(&smmu_domain->init_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
 
@@ -1001,6 +1008,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	 * Free the domain resources. We assume that all devices have
 	 * already been detached.
 	 */
+	iommu_put_dma_cookie(domain);
 	arm_smmu_destroy_domain_context(domain);
 	kfree(smmu_domain);
 }
-- 
2.7.0.25.gfc10eb5.dirty
