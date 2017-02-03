From: joro@8bytes.org (Joerg Roedel)
Date: Fri,  3 Feb 2017 16:17:47 +0100
Subject: [PATCH 09/10] iommu/exynos: Make use of iommu_device_register
 interface
In-Reply-To: <1486135068-23994-1-git-send-email-joro@8bytes.org>
References: <1486135068-23994-1-git-send-email-joro@8bytes.org>
Message-ID: <1486135068-23994-10-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

Register Exynos IOMMUs to the IOMMU core and make them
visible in sysfs. This patch does not add the links between
IOMMUs and translated devices yet.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/exynos-iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 57ba0d3..90f0f52 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -276,6 +276,8 @@ struct sysmmu_drvdata {
 	struct list_head owner_node;	/* node for owner controllers list */
 	phys_addr_t pgtable;		/* assigned page table structure */
 	unsigned int version;		/* our version */
+
+	struct iommu_device iommu;	/* IOMMU core handle */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -556,6 +558,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sysmmu_drvdata *data;
 	struct resource *res;
+	resource_size_t ioaddr;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -565,6 +568,7 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	data->sfrbase = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->sfrbase))
 		return PTR_ERR(data->sfrbase);
+	ioaddr = res->start;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
@@ -611,6 +615,18 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
 
+	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
+				     "sysmmu.%pa", &ioaddr);
+	if (ret)
+		return ret;
+
+	data->iommu.ops    = &exynos_iommu_ops;
+	data->iommu.fwnode = &dev->of_node->fwnode;
+
+	ret = iommu_device_register(&data->iommu);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, data);
 
 	__sysmmu_get_version(data);
-- 
1.9.1
