From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 May 2015 10:16:05 +0200
Subject: [PATCH v6 10/25] iommu: exynos: remove useless device_add/remove
 callbacks
In-Reply-To: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1430727380-10912-11-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver doesn't need to do anything important in device add/remove
callbacks, because initialization will be done from device-tree specific
callbacks added later. IOMMU groups created by current code were never
used.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 7d62715ab51e..f2eceb6605c5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1062,32 +1062,6 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
-static int exynos_iommu_add_device(struct device *dev)
-{
-	struct iommu_group *group;
-	int ret;
-
-	group = iommu_group_get(dev);
-
-	if (!group) {
-		group = iommu_group_alloc();
-		if (IS_ERR(group)) {
-			dev_err(dev, "Failed to allocate IOMMU group\n");
-			return PTR_ERR(group);
-		}
-	}
-
-	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
-
-	return ret;
-}
-
-static void exynos_iommu_remove_device(struct device *dev)
-{
-	iommu_group_remove_device(dev);
-}
-
 static const struct iommu_ops exynos_iommu_ops = {
 	.domain_alloc = exynos_iommu_domain_alloc,
 	.domain_free = exynos_iommu_domain_free,
@@ -1097,8 +1071,6 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.unmap = exynos_iommu_unmap,
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
-	.add_device = exynos_iommu_add_device,
-	.remove_device = exynos_iommu_remove_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 };
 
-- 
1.9.2
