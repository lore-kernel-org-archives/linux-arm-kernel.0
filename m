From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 19 Oct 2016 11:30:34 +0100
Subject: [PATCH] iommu: convert DT component matching to
 component_match_add_release()
Message-ID: <E1bwo8o-0005LV-54@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert DT component matching to use component_match_add_release().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/iommu/mtk_iommu.c    | 8 +++++---
 drivers/iommu/mtk_iommu.h    | 5 +++++
 drivers/iommu/mtk_iommu_v1.c | 8 +++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b12c12d74c33..41604796fca3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -583,17 +583,19 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			continue;
 
 		plarbdev = of_find_device_by_node(larbnode);
-		of_node_put(larbnode);
 		if (!plarbdev) {
 			plarbdev = of_platform_device_create(
 						larbnode, NULL,
 						platform_bus_type.dev_root);
-			if (!plarbdev)
+			if (!plarbdev) {
+				of_node_put(larbnode);
 				return -EPROBE_DEFER;
+			}
 		}
 		data->smi_imu.larb_imu[i].dev = &plarbdev->dev;
 
-		component_match_add(dev, &match, compare_of, larbnode);
+		component_match_add_release(dev, &match, release_of,
+					    compare_of, larbnode);
 	}
 
 	platform_set_drvdata(pdev, data);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 3dab13b4a211..44ca38095c6a 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -60,6 +60,11 @@ static inline int compare_of(struct device *dev, void *data)
 	return dev->of_node == data;
 }
 
+static inline void release_of(struct device *dev, void *data)
+{
+	of_node_put(data);
+}
+
 static inline int mtk_iommu_bind(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index b8aeb0768483..92341ef33354 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -624,17 +624,19 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			continue;
 
 		plarbdev = of_find_device_by_node(larb_spec.np);
-		of_node_put(larb_spec.np);
 		if (!plarbdev) {
 			plarbdev = of_platform_device_create(
 						larb_spec.np, NULL,
 						platform_bus_type.dev_root);
-			if (!plarbdev)
+			if (!plarbdev) {
+				of_node_put(larb_spec.np);
 				return -EPROBE_DEFER;
+			}
 		}
 
 		data->smi_imu.larb_imu[larb_nr].dev = &plarbdev->dev;
-		component_match_add(dev, &match, compare_of, larb_spec.np);
+		component_match_add_release(dev, &match, release_of,
+					    compare_of, larb_spec.np);
 		larb_nr++;
 	}
 
-- 
2.1.0
