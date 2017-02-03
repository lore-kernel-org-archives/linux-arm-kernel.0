From: joro@8bytes.org (Joerg Roedel)
Date: Fri,  3 Feb 2017 16:17:46 +0100
Subject: [PATCH 08/10] iommu/mediatek: Make use of iommu_device_register
 interface
In-Reply-To: <1486135068-23994-1-git-send-email-joro@8bytes.org>
References: <1486135068-23994-1-git-send-email-joro@8bytes.org>
Message-ID: <1486135068-23994-9-git-send-email-joro@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joerg Roedel <jroedel@suse.de>

Register individual Mediatek IOMMUs to the iommu core and
add sysfs entries.

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/mtk_iommu.c | 26 ++++++++++++++++++++++++++
 drivers/iommu/mtk_iommu.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 1479c76..9fb7258 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -360,11 +360,15 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 
 static int mtk_iommu_add_device(struct device *dev)
 {
+	struct mtk_iommu_data *data;
 	struct iommu_group *group;
 
 	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
 		return -ENODEV; /* Not a iommu client device */
 
+	data = dev->iommu_fwspec->iommu_priv;
+	iommu_device_link(&data->iommu, dev);
+
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
 		return PTR_ERR(group);
@@ -375,9 +379,14 @@ static int mtk_iommu_add_device(struct device *dev)
 
 static void mtk_iommu_remove_device(struct device *dev)
 {
+	struct mtk_iommu_data *data;
+
 	if (!dev->iommu_fwspec || dev->iommu_fwspec->ops != &mtk_iommu_ops)
 		return;
 
+	data = dev->iommu_fwspec->iommu_priv;
+	iommu_device_unlink(&data->iommu, dev);
+
 	iommu_group_remove_device(dev);
 	iommu_fwspec_free(dev);
 }
@@ -497,6 +506,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	struct mtk_iommu_data   *data;
 	struct device           *dev = &pdev->dev;
 	struct resource         *res;
+	resource_size_t		ioaddr;
 	struct component_match  *match = NULL;
 	void                    *protect;
 	int                     i, larb_nr, ret;
@@ -519,6 +529,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	data->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
+	ioaddr = res->start;
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0)
@@ -567,6 +578,18 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
+				     "mtk-iommu.%pa", &ioaddr);
+	if (ret)
+		return ret;
+
+	data->iommu.ops    = &mtk_iommu_ops;
+	data->iommu.fwnode = &pdev->dev.of_node->fwnode;
+
+	ret = iommu_device_register(&data->iommu);
+	if (ret)
+		return ret;
+
 	if (!iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, &mtk_iommu_ops);
 
@@ -577,6 +600,9 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
 
+	iommu_device_sysfs_remove(&data->iommu);
+	iommu_device_unregister(&data->iommu);
+
 	if (iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, NULL);
 
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 50177f7..2a28ead 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -47,6 +47,8 @@ struct mtk_iommu_data {
 	struct iommu_group		*m4u_group;
 	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
 	bool                            enable_4GB;
+
+	struct iommu_device		iommu;
 };
 
 static inline int compare_of(struct device *dev, void *data)
-- 
1.9.1
