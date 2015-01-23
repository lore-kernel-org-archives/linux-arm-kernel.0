From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Jan 2015 16:51:18 +0100
Subject: [PATCH v5 08/18] iommu: exynos: remove useless spinlock
In-Reply-To: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1422028288-891-9-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes useless spinlocks and other unused members from
struct exynos_iommu_owner. There is no point is protecting this
structure by spinlock because content of this structure doesn't change
and other structures have their own spinlocks.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 3c82411..aa8c4b0 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -189,9 +189,6 @@ struct exynos_iommu_owner {
 	struct list_head client; /* entry of exynos_iommu_domain.clients */
 	struct device *dev;
 	struct device *sysmmu;
-	struct iommu_domain *domain;
-	void *vmm_data;         /* IO virtual memory manager's data */
-	spinlock_t lock;        /* Lock to preserve consistency of System MMU */
 };
 
 struct exynos_iommu_domain {
@@ -477,16 +474,12 @@ static int __exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable,
 
 	BUG_ON(!has_sysmmu(dev));
 
-	spin_lock_irqsave(&owner->lock, flags);
-
 	data = dev_get_drvdata(owner->sysmmu);
 
 	ret = __sysmmu_enable(data, pgtable, domain);
 	if (ret >= 0)
 		data->master = dev;
 
-	spin_unlock_irqrestore(&owner->lock, flags);
-
 	return ret;
 }
 
@@ -499,16 +492,12 @@ static bool exynos_sysmmu_disable(struct device *dev)
 
 	BUG_ON(!has_sysmmu(dev));
 
-	spin_lock_irqsave(&owner->lock, flags);
-
 	data = dev_get_drvdata(owner->sysmmu);
 
 	disabled = __sysmmu_disable(data);
 	if (disabled)
 		data->master = NULL;
 
-	spin_unlock_irqrestore(&owner->lock, flags);
-
 	return disabled;
 }
 
-- 
1.9.2
