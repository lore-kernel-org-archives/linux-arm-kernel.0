From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Wed, 8 Jun 2016 17:50:44 +0800
Subject: [PATCH] iommu/mediatek: Do not call of_node_put in mtk_iommu_of_xlate
Message-ID: <1465379444-14719-1-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The device_node will be released in of_iommu_configure, it may be double
released if call of_node_put in mtk_iommu_of_xlate.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c3043d8..493bd3e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -455,7 +455,6 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	if (!dev->archdata.iommu) {
 		/* Get the m4u device */
 		m4updev = of_find_device_by_node(args->np);
-		of_node_put(args->np);
 		if (WARN_ON(!m4updev))
 			return -EINVAL;
 
-- 
1.8.1.1.dirty
