From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Jan 2015 16:51:20 +0100
Subject: [PATCH v5 10/18] iommu: exynos: remove unused functions, part 2
In-Reply-To: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
References: <1422028288-891-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1422028288-891-11-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After refactoring functions to use pointer to struct sysmmu_drvdata
directly, some functions became useless and thus never used, so remove
them completely.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 862261f..e62cb96 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -457,49 +457,6 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data,
 	return ret;
 }
 
-/* __exynos_sysmmu_enable: Enables System MMU
- *
- * returns -error if an error occurred and System MMU is not enabled,
- * 0 if the System MMU has been just enabled and 1 if System MMU was already
- * enabled before.
- */
-static int __exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable,
-				  struct iommu_domain *domain)
-{
-	int ret = 0;
-	unsigned long flags;
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct sysmmu_drvdata *data;
-
-	BUG_ON(!has_sysmmu(dev));
-
-	data = dev_get_drvdata(owner->sysmmu);
-
-	ret = __sysmmu_enable(data, pgtable, domain);
-	if (ret >= 0)
-		data->master = dev;
-
-	return ret;
-}
-
-static bool exynos_sysmmu_disable(struct device *dev)
-{
-	unsigned long flags;
-	bool disabled = true;
-	struct exynos_iommu_owner *owner = dev->archdata.iommu;
-	struct sysmmu_drvdata *data;
-
-	BUG_ON(!has_sysmmu(dev));
-
-	data = dev_get_drvdata(owner->sysmmu);
-
-	disabled = __sysmmu_disable(data);
-	if (disabled)
-		data->master = NULL;
-
-	return disabled;
-}
-
 static void __sysmmu_tlb_invalidate_flpdcache(struct sysmmu_drvdata *data,
 					      sysmmu_iova_t iova)
 {
-- 
1.9.2
