From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 04 May 2015 10:16:13 +0200
Subject: [PATCH v6 18/25] iommu: exynos: add callback for initializing devices
 from device tree
In-Reply-To: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1430727380-10912-19-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds implementation of of_xlate callback, which prepares
masters device for attaching to IOMMU. This callback is called during
creating devices from device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 94fbd870ede6..6e6b502ee2c9 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1082,6 +1082,33 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 	return phys;
 }
 
+static int exynos_iommu_of_xlate(struct device *dev,
+				 struct of_phandle_args *spec)
+{
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
+	struct sysmmu_drvdata *data;
+
+	if (!sysmmu)
+		return -ENODEV;
+
+	data = platform_get_drvdata(sysmmu);
+	if (!data)
+		return -ENODEV;
+
+	if (!owner) {
+		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
+		if (!owner)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&owner->clients);
+		dev->archdata.iommu = owner;
+	}
+
+	list_add_tail(&data->owner_node, &owner->clients);
+	return 0;
+}
+
 static struct iommu_ops exynos_iommu_ops = {
 	.domain_alloc = exynos_iommu_domain_alloc,
 	.domain_free = exynos_iommu_domain_free,
@@ -1092,6 +1119,7 @@ static struct iommu_ops exynos_iommu_ops = {
 	.map_sg = default_iommu_map_sg,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
+	.of_xlate = exynos_iommu_of_xlate,
 };
 
 static bool init_done;
-- 
1.9.2
