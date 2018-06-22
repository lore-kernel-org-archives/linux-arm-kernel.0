From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 22 Jun 2018 11:49:06 +0800
Subject: [PATCH 3/7] pinctrl: mt7622: fix that pinctrl_claim_hogs cannot work
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
Message-ID: <3b1fa378e0a83a5f39497fe8efaf4c992507ed5d.1529639050.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

To allow claiming hogs by pinctrl, we cannot enable pinctrl until all
groups and functions are being added done. Also, it's necessary that
the corresponding gpiochip is being added when the pinctrl device is
enabled.

Cc: stable at vger.kernel.org
Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index e9eba62..42155d4 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1695,9 +1695,10 @@ static int mtk_pinctrl_probe(struct platform_device *pdev)
 	mtk_desc.custom_conf_items = mtk_conf_items;
 #endif
 
-	hw->pctrl = devm_pinctrl_register(&pdev->dev, &mtk_desc, hw);
-	if (IS_ERR(hw->pctrl))
-		return PTR_ERR(hw->pctrl);
+	err = devm_pinctrl_register_and_init(&pdev->dev, &mtk_desc, hw,
+					     &hw->pctrl);
+	if (err)
+		return err;
 
 	/* Setup groups descriptions per SoC types */
 	err = mtk_build_groups(hw);
@@ -1713,11 +1714,19 @@ static int mtk_pinctrl_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	/* For able to make pinctrl_claim_hogs, we must not enable pinctrl
+	 * until all groups and functions are being added one.
+	 */
+	err = pinctrl_enable(hw->pctrl);
+	if (err)
+		return err;
+
 	err = mtk_build_eint(hw, pdev);
 	if (err)
 		dev_warn(&pdev->dev,
 			 "Failed to add EINT, but pinctrl still can work\n");
 
+	/* Build gpiochip should be after pinctrl_enable is done */
 	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
-- 
2.7.4
