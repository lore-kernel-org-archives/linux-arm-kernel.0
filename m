From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 11 Feb 2016 14:34:12 +0000
Subject: [RFC v2 05/15] iommu/arm-smmu: implement
 alloc/free_reserved_iova_domain
In-Reply-To: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
References: <1455201262-5259-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1455201262-5259-6-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement alloc/free_reserved_iova_domain for arm-smmu. we use
the iova allocator (iova.c). The iova_domain is attached to the
arm_smmu_domain struct. A mutex is introduced to protect it.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v1 -> v2:
- formerly implemented in vfio_iommu_type1
---
 drivers/iommu/arm-smmu.c | 87 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index c8b7e71..f42341d 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -42,6 +42,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/iova.h>
 
 #include <linux/amba/bus.h>
 
@@ -347,6 +348,9 @@ struct arm_smmu_domain {
 	enum arm_smmu_domain_stage	stage;
 	struct mutex			init_mutex; /* Protects smmu pointer */
 	struct iommu_domain		domain;
+	struct iova_domain		*reserved_iova_domain;
+	/* protects reserved domain manipulation */
+	struct mutex			reserved_mutex;
 };
 
 static struct iommu_ops arm_smmu_ops;
@@ -975,6 +979,7 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 
 	mutex_init(&smmu_domain->init_mutex);
+	mutex_init(&smmu_domain->reserved_mutex);
 	spin_lock_init(&smmu_domain->pgtbl_lock);
 
 	return &smmu_domain->domain;
@@ -1446,22 +1451,74 @@ out_unlock:
 	return ret;
 }
 
+static int arm_smmu_alloc_reserved_iova_domain(struct iommu_domain *domain,
+					       dma_addr_t iova, size_t size,
+					       unsigned long order)
+{
+	unsigned long granule, mask;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	int ret = 0;
+
+	granule = 1UL << order;
+	mask = granule - 1;
+	if (iova & mask || (!size) || (size & mask))
+		return -EINVAL;
+
+	if (smmu_domain->reserved_iova_domain)
+		return -EEXIST;
+
+	mutex_lock(&smmu_domain->reserved_mutex);
+
+	smmu_domain->reserved_iova_domain =
+		kzalloc(sizeof(struct iova_domain), GFP_KERNEL);
+	if (!smmu_domain->reserved_iova_domain) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	init_iova_domain(smmu_domain->reserved_iova_domain,
+			 granule, iova >> order, (iova + size - 1) >> order);
+
+unlock:
+	mutex_unlock(&smmu_domain->reserved_mutex);
+	return ret;
+}
+
+static void arm_smmu_free_reserved_iova_domain(struct iommu_domain *domain)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct iova_domain *iovad = smmu_domain->reserved_iova_domain;
+
+	if (!iovad)
+		return;
+
+	mutex_lock(&smmu_domain->reserved_mutex);
+
+	put_iova_domain(iovad);
+	kfree(iovad);
+
+	mutex_unlock(&smmu_domain->reserved_mutex);
+}
+
 static struct iommu_ops arm_smmu_ops = {
-	.capable		= arm_smmu_capable,
-	.domain_alloc		= arm_smmu_domain_alloc,
-	.domain_free		= arm_smmu_domain_free,
-	.attach_dev		= arm_smmu_attach_dev,
-	.detach_dev		= arm_smmu_detach_dev,
-	.map			= arm_smmu_map,
-	.unmap			= arm_smmu_unmap,
-	.map_sg			= default_iommu_map_sg,
-	.iova_to_phys		= arm_smmu_iova_to_phys,
-	.add_device		= arm_smmu_add_device,
-	.remove_device		= arm_smmu_remove_device,
-	.device_group		= arm_smmu_device_group,
-	.domain_get_attr	= arm_smmu_domain_get_attr,
-	.domain_set_attr	= arm_smmu_domain_set_attr,
-	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
+	.capable			= arm_smmu_capable,
+	.domain_alloc			= arm_smmu_domain_alloc,
+	.domain_free			= arm_smmu_domain_free,
+	.attach_dev			= arm_smmu_attach_dev,
+	.detach_dev			= arm_smmu_detach_dev,
+	.map				= arm_smmu_map,
+	.unmap				= arm_smmu_unmap,
+	.map_sg				= default_iommu_map_sg,
+	.iova_to_phys			= arm_smmu_iova_to_phys,
+	.add_device			= arm_smmu_add_device,
+	.remove_device			= arm_smmu_remove_device,
+	.device_group			= arm_smmu_device_group,
+	.domain_get_attr		= arm_smmu_domain_get_attr,
+	.domain_set_attr		= arm_smmu_domain_set_attr,
+	.alloc_reserved_iova_domain	= arm_smmu_alloc_reserved_iova_domain,
+	.free_reserved_iova_domain	= arm_smmu_free_reserved_iova_domain,
+	/* Page size bitmap, restricted during device attach */
+	.pgsize_bitmap			= -1UL,
 };
 
 static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
-- 
1.9.1
