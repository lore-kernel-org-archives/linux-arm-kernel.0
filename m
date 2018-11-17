From: yong.wu@mediatek.com (Yong Wu)
Date: Sat, 17 Nov 2018 10:35:39 +0800
Subject: [PATCH v3 12/15] iommu/mediatek: Add shutdown callback
In-Reply-To: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1542422142-30688-13-git-send-email-yong.wu@mediatek.com>
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
index 735fefc..63406c5 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -708,6 +708,11 @@ static int mtk_iommu_remove(struct platform_device *pdev)
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
@@ -783,6 +788,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
 	.remove	= mtk_iommu_remove,
+	.shutdown = mtk_iommu_shutdown,
 	.driver	= {
 		.name = "mtk-iommu",
 		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
-- 
1.9.1
