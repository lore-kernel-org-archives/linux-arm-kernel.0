From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 18 Jan 2017 14:00:09 +0800
Subject: [RESEND PATCH 1/6] phy: phy-mt65xx-usb3: add reference clock of usb3
 analog phy
Message-ID: <1484719214-11989-1-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

usually, the reference clock of usb3 analog phy comes from
26M oscillator directly, but some SoCs are not, add it for
compatibility.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mt65xx-usb3.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index d972067..fc9a4f0 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -149,7 +149,8 @@ struct mt65xx_phy_instance {
 struct mt65xx_u3phy {
 	struct device *dev;
 	void __iomem *sif_base;	/* include sif2, but exclude port's */
-	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
+	struct clk *u2ref_clk;	/* reference clock of u2 analog phy */
+	struct clk *u3ref_clk;	/* reference clock of u3 analog phy */
 	const struct mt65xx_phy_pdata *pdata;
 	struct mt65xx_phy_instance **phys;
 	int nphys;
@@ -429,11 +430,17 @@ static int mt65xx_phy_init(struct phy *phy)
 {
 	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
+	struct clk *ref_clk;
 	int ret;
 
-	ret = clk_prepare_enable(u3phy->u3phya_ref);
+	if (instance->type == PHY_TYPE_USB2)
+		ref_clk = u3phy->u2ref_clk;
+	else
+		ref_clk = u3phy->u3ref_clk;
+
+	ret = clk_prepare_enable(ref_clk);
 	if (ret) {
-		dev_err(u3phy->dev, "failed to enable u3phya_ref\n");
+		dev_err(u3phy->dev, "failed to enable ref clk\n");
 		return ret;
 	}
 
@@ -464,9 +471,16 @@ static int mt65xx_phy_exit(struct phy *phy)
 {
 	struct mt65xx_phy_instance *instance = phy_get_drvdata(phy);
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
+	struct clk *ref_clk;
 
 	phy_instance_exit(u3phy, instance);
-	clk_disable_unprepare(u3phy->u3phya_ref);
+
+	if (instance->type == PHY_TYPE_USB2)
+		ref_clk = u3phy->u2ref_clk;
+	else
+		ref_clk = u3phy->u3ref_clk;
+
+	clk_disable_unprepare(ref_clk);
 	return 0;
 }
 
@@ -566,10 +580,16 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 		return PTR_ERR(u3phy->sif_base);
 	}
 
-	u3phy->u3phya_ref = devm_clk_get(dev, "u3phya_ref");
-	if (IS_ERR(u3phy->u3phya_ref)) {
-		dev_err(dev, "error to get u3phya_ref\n");
-		return PTR_ERR(u3phy->u3phya_ref);
+	u3phy->u2ref_clk = devm_clk_get(dev, "u2ref_clk");
+	if (IS_ERR(u3phy->u2ref_clk)) {
+		dev_err(dev, "failed to get u2ref_clk\n");
+		return PTR_ERR(u3phy->u2ref_clk);
+	}
+
+	u3phy->u3ref_clk = devm_clk_get(dev, "u3ref_clk");
+	if (IS_ERR(u3phy->u3ref_clk)) {
+		dev_err(dev, "failed to get u3ref_clk\n");
+		return PTR_ERR(u3phy->u3ref_clk);
 	}
 
 	port = 0;
-- 
1.7.9.5
