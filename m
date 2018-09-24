From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 24 Sep 2018 16:58:52 +0800
Subject: [PATCH v2 12/14] iommu/mediatek: Add shutdown callback
In-Reply-To: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
References: <1537779534-23575-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1537779534-23575-13-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the reboot burning test, if some Multimedia HW has something wrong,
It may keep send the invalid request to IOMMU. In order to avoid
affect the reboot flow, we add the shutdown callback to disable
M4U HW when shutdown.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 18b130b..fb8aefc 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -710,6 +710,11 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void mtk_iommu_shutdown(struct platform_device *pdev)
+{
+	mtk_iommu_remove(pdev);
+}
+
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -785,6 +790,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
 	.remove	= mtk_iommu_remove,
+	.shutdown = mtk_iommu_shutdown,
 	.driver	= {
 		.name = "mtk-iommu",
 		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
-- 
1.9.1
