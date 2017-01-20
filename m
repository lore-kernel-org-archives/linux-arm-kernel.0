From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Fri, 20 Jan 2017 16:18:37 +0800
Subject: [PATCH v2,
 2/6] phy: phy-mt65xx-usb3: move clock from phy node into port nodes
In-Reply-To: <1484900321-26933-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1484900321-26933-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1484900321-26933-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the reference clock of HighSpeed port is 48M which comes from PLL;
the reference clock of SuperSpeed port is 26M which usually comes
from 26M oscillator directly, but some SoCs are not, add it for
compatibility, and put them into port node for flexibility.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mt65xx-usb3.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index 93f57d9..0995433 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -141,6 +141,7 @@ struct mt65xx_phy_pdata {
 struct mt65xx_phy_instance {
 	struct phy *phy;
 	void __iomem *port_base;
+	struct clk *ref_clk;	/* reference clock of anolog phy */
 	u32 index;
 	u8 type;
 };
@@ -148,7 +149,6 @@ struct mt65xx_phy_instance {
 struct mt65xx_u3phy {
 	struct device *dev;
 	void __iomem *sif_base;	/* only shared sif */
-	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
 	const struct mt65xx_phy_pdata *pdata;
 	struct mt65xx_phy_instance **phys;
 	int nphys;
@@ -422,9 +422,9 @@ static int mt65xx_phy_init(struct phy *phy)
 	struct mt65xx_u3phy *u3phy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
-	ret = clk_prepare_enable(u3phy->u3phya_ref);
+	ret = clk_prepare_enable(instance->ref_clk);
 	if (ret) {
-		dev_err(u3phy->dev, "failed to enable u3phya_ref\n");
+		dev_err(u3phy->dev, "failed to enable ref_clk\n");
 		return ret;
 	}
 
@@ -467,7 +467,7 @@ static int mt65xx_phy_exit(struct phy *phy)
 	if (instance->type == PHY_TYPE_USB2)
 		phy_instance_exit(u3phy, instance);
 
-	clk_disable_unprepare(u3phy->u3phya_ref);
+	clk_disable_unprepare(instance->ref_clk);
 	return 0;
 }
 
@@ -567,12 +567,6 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 		return PTR_ERR(u3phy->sif_base);
 	}
 
-	u3phy->u3phya_ref = devm_clk_get(dev, "u3phya_ref");
-	if (IS_ERR(u3phy->u3phya_ref)) {
-		dev_err(dev, "error to get u3phya_ref\n");
-		return PTR_ERR(u3phy->u3phya_ref);
-	}
-
 	port = 0;
 	for_each_child_of_node(np, child_np) {
 		struct mt65xx_phy_instance *instance;
@@ -607,6 +601,13 @@ static int mt65xx_u3phy_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
+		instance->ref_clk = devm_clk_get(&phy->dev, "ref_clk");
+		if (IS_ERR(instance->ref_clk)) {
+			dev_err(dev, "failed to get ref_clk(id-%d)\n", port);
+			retval = PTR_ERR(instance->ref_clk);
+			goto put_child;
+		}
+
 		instance->phy = phy;
 		instance->index = port;
 		phy_set_drvdata(phy, instance);
-- 
1.7.9.5
