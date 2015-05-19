From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 19 May 2015 15:20:32 +0200
Subject: [PATCH v7 12/25] iommu/exynos: Add/remove callbacks should fail if no
 iommu is available
In-Reply-To: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1432041645-11172-13-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return fail if given master device passed to add_device/remove_device
callbacks doesn't has associated any sysmmu controller.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0e7250fda087..a5f0c99602c2 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1081,6 +1081,9 @@ static int exynos_iommu_add_device(struct device *dev)
 	struct iommu_group *group;
 	int ret;
 
+	if (!has_sysmmu(dev))
+		return -ENODEV;
+
 	group = iommu_group_get(dev);
 
 	if (!group) {
@@ -1099,6 +1102,9 @@ static int exynos_iommu_add_device(struct device *dev)
 
 static void exynos_iommu_remove_device(struct device *dev)
 {
+	if (!has_sysmmu(dev))
+		return;
+
 	iommu_group_remove_device(dev);
 }
 
-- 
1.9.2
