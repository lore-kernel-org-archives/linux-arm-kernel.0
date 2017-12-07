From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Thu, 7 Dec 2017 19:53:35 +0800
Subject: [PATCH 2/3] phy: phy-mtk-tphy: make shared banks optional for V1 TPHY
In-Reply-To: <ff2797a0487a0b30a2292c2685dedcbbfeead293.1512647458.git.chunfeng.yun@mediatek.com>
References: <ff2797a0487a0b30a2292c2685dedcbbfeead293.1512647458.git.chunfeng.yun@mediatek.com>
Message-ID: <7bf40e3131b62e0e765898ad1f9119998fd364d2.1512647458.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V1 TPHY for SATA doesn't have shared banks if it isn't shared
with PCIe or USB, so make it optional.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 5d9d7f3..d99f79b1 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -1023,9 +1023,10 @@ static int mtk_tphy_probe(struct platform_device *pdev)
 	tphy->dev = dev;
 	platform_set_drvdata(pdev, tphy);
 
-	if (tphy->pdata->version == MTK_PHY_V1) {
+	sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/* SATA phy of V1 needn't it if not shared with PCIe or USB */
+	if (sif_res && tphy->pdata->version == MTK_PHY_V1) {
 		/* get banks shared by multiple phys */
-		sif_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		tphy->sif_base = devm_ioremap_resource(dev, sif_res);
 		if (IS_ERR(tphy->sif_base)) {
 			dev_err(dev, "failed to remap sif regs\n");
-- 
1.9.1
