From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 16 Sep 2014 13:54:45 +0200
Subject: [PATCH v2 18/18] iommu: exynos: add callback for initializing devices
 from device tree
In-Reply-To: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1410868485-4143-19-git-send-email-m.szyprowski@samsung.com>
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
index 0d304c62956e..6b8fe57d17f2 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1077,6 +1077,33 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
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
+		return 0;
+
+	data = platform_get_drvdata(sysmmu);
+	if (!data)
+		return 0;
+
+	if (!owner) {
+		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
+		if (!owner)
+			return 0;
+
+		INIT_LIST_HEAD(&owner->clients);
+		dev->archdata.iommu = owner;
+	}
+
+	list_add_tail(&data->owner_node, &owner->clients);
+	return 1;
+}
+
 static const struct iommu_ops exynos_iommu_ops = {
 	.domain_init = exynos_iommu_domain_init,
 	.domain_destroy = exynos_iommu_domain_destroy,
@@ -1086,6 +1113,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.unmap = exynos_iommu_unmap,
 	.iova_to_phys = exynos_iommu_iova_to_phys,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
+	.of_xlate = exynos_iommu_of_xlate,
 };
 
 static int init_done;
-- 
1.9.2
