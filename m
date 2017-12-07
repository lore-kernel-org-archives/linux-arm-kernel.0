From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 7 Dec 2017 19:53:36 +0800
Subject: [PATCH 3/3] phy: phy-mtk-tphy: use of_device_get_match_data()
In-Reply-To: <ff2797a0487a0b30a2292c2685dedcbbfeead293.1512647458.git.chunfeng.yun@mediatek.com>
References: <ff2797a0487a0b30a2292c2685dedcbbfeead293.1512647458.git.chunfeng.yun@mediatek.com>
Message-ID: <808e7e783be76e0d5d5eab9f805e8be2d77a7a1b.1512647458.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reduce the boilerplate code to get the specific data

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index d99f79b1..bd26de3 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -20,6 +20,7 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 
@@ -995,7 +996,6 @@ static struct phy *mtk_phy_xlate(struct device *dev,
 
 static int mtk_tphy_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct device_node *child_np;
@@ -1005,15 +1005,14 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 	struct resource res;
 	int port, retval;
 
-	match = of_match_node(mtk_tphy_id_table, pdev->dev.of_node);
-	if (!match)
-		return -EINVAL;
-
 	tphy = devm_kzalloc(dev, sizeof(*tphy), GFP_KERNEL);
 	if (!tphy)
 		return -ENOMEM;
 
-	tphy->pdata = match->data;
+	tphy->pdata = of_device_get_match_data(dev);
+	if (!tphy->pdata)
+		return -EINVAL;
+
 	tphy->nphys = of_get_child_count(np);
 	tphy->phys = devm_kcalloc(dev, tphy->nphys,
 				  sizeof(*tphy->phys), GFP_KERNEL);
-- 
1.9.1
