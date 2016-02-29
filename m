From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 10:19:07 +0100
Subject: [PATCH 2/2] iommu/mediatek: mark PM functions as __maybe_unused
In-Reply-To: <1456737553-496245-1-git-send-email-arnd@arndb.de>
References: <1456737553-496245-1-git-send-email-arnd@arndb.de>
Message-ID: <1456737553-496245-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_PM is unset, we get a harmless warning for this driver:

drivers/iommu/mtk_iommu.c:665:12: error: 'mtk_iommu_suspend' defined but not used [-Werror=unused-function]
drivers/iommu/mtk_iommu.c:680:12: error: 'mtk_iommu_resume' defined but not used [-Werror=unused-function]

Marking the functions as __maybe_unused gits rid of the two functions
and lets the compiler silently drop the object code, while still
doing syntax checking on them for build-time verification.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 0df4fabe208d ("iommu/mediatek: Add mt8173 IOMMU driver")
---
 drivers/iommu/mtk_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 721ffdb296d6..f3c160e4c25d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -662,7 +662,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_iommu_suspend(struct device *dev)
+static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
@@ -677,7 +677,7 @@ static int mtk_iommu_suspend(struct device *dev)
 	return 0;
 }
 
-static int mtk_iommu_resume(struct device *dev)
+static int __maybe_unused mtk_iommu_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-- 
2.7.0
