From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 26 Oct 2017 20:50:27 +0800
Subject: [PATCH 2/3] phy: phy-mtk-tphy: use of_device_get_match_data()
In-Reply-To: <f08880e993f05761f0171b83812e940d30a54b05.1509022149.git.chunfeng.yun@mediatek.com>
References: <f08880e993f05761f0171b83812e940d30a54b05.1509022149.git.chunfeng.yun@mediatek.com>
Message-ID: <0c63a4f0c8c20ceaba2e5173993b7ca69671f852.1509022150.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reduce the boilerplate code to get the specific data

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 54cc44b..cdd33bf 100644
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
1.7.9.5
