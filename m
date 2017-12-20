From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 20 Dec 2017 17:47:06 +0800
Subject: [PATCH net 2/2] net: mediatek: remove superfluous pin setup for
 MT7622 SoC
In-Reply-To: <e366efc29985d3292c8a1afb1389b5eac57c9037.1513762066.git.sean.wang@mediatek.com>
References: <e366efc29985d3292c8a1afb1389b5eac57c9037.1513762066.git.sean.wang@mediatek.com>
Message-ID: <e3bd43a5337df719e791bc9902135a0916a951ff.1513762066.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Remove superfluous pin setup to get out of accessing invalid I/O pin
registers because the way for pin configuring tends to be different from
various SoCs and thus it should be better being managed and controlled by
the pinctrl driver which MT7622 already can support.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 35 +++++++++++++++++------------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  3 +++
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index fc67e35..29826dd 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1952,14 +1952,16 @@ static int mtk_hw_init(struct mtk_eth *eth)
 	}
 	regmap_write(eth->ethsys, ETHSYS_SYSCFG0, val);
 
-	/* Set GE2 driving and slew rate */
-	regmap_write(eth->pctl, GPIO_DRV_SEL10, 0xa00);
+	if (eth->pctl) {
+		/* Set GE2 driving and slew rate */
+		regmap_write(eth->pctl, GPIO_DRV_SEL10, 0xa00);
 
-	/* set GE2 TDSEL */
-	regmap_write(eth->pctl, GPIO_OD33_CTRL8, 0x5);
+		/* set GE2 TDSEL */
+		regmap_write(eth->pctl, GPIO_OD33_CTRL8, 0x5);
 
-	/* set GE2 TUNE */
-	regmap_write(eth->pctl, GPIO_BIAS_CTRL, 0x0);
+		/* set GE2 TUNE */
+		regmap_write(eth->pctl, GPIO_BIAS_CTRL, 0x0);
+	}
 
 	/* Set linkdown as the default for each GMAC. Its own MCR would be set
 	 * up with the more appropriate value when mtk_phy_link_adjust call is
@@ -2538,11 +2540,13 @@ static int mtk_probe(struct platform_device *pdev)
 		}
 	}
 
-	eth->pctl = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-						    "mediatek,pctl");
-	if (IS_ERR(eth->pctl)) {
-		dev_err(&pdev->dev, "no pctl regmap found\n");
-		return PTR_ERR(eth->pctl);
+	if (eth->soc->required_pctl) {
+		eth->pctl = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							    "mediatek,pctl");
+		if (IS_ERR(eth->pctl)) {
+			dev_err(&pdev->dev, "no pctl regmap found\n");
+			return PTR_ERR(eth->pctl);
+		}
 	}
 
 	for (i = 0; i < 3; i++) {
@@ -2668,17 +2672,20 @@ static int mtk_remove(struct platform_device *pdev)
 
 static const struct mtk_soc_data mt2701_data = {
 	.caps = MTK_GMAC1_TRGMII,
-	.required_clks = MT7623_CLKS_BITMAP
+	.required_clks = MT7623_CLKS_BITMAP,
+	.required_pctl = true,
 };
 
 static const struct mtk_soc_data mt7622_data = {
 	.caps = MTK_DUAL_GMAC_SHARED_SGMII | MTK_GMAC1_ESW,
-	.required_clks = MT7622_CLKS_BITMAP
+	.required_clks = MT7622_CLKS_BITMAP,
+	.required_pctl = false,
 };
 
 static const struct mtk_soc_data mt7623_data = {
 	.caps = MTK_GMAC1_TRGMII,
-	.required_clks = MT7623_CLKS_BITMAP
+	.required_clks = MT7623_CLKS_BITMAP,
+	.required_pctl = true,
 };
 
 const struct of_device_id of_mtk_match[] = {
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index a3af466..672b8c3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -573,10 +573,13 @@ struct mtk_rx_ring {
  * @caps			Flags shown the extra capability for the SoC
  * @required_clks		Flags shown the bitmap for required clocks on
  *				the target SoC
+ * @required_pctl		A bool value to show whether the SoC requires
+ *				the extra setup for those pins used by GMAC.
  */
 struct mtk_soc_data {
 	u32		caps;
 	u32		required_clks;
+	bool		required_pctl;
 };
 
 /* currently no SoC has more than 2 macs */
-- 
2.7.4
