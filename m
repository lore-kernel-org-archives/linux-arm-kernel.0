From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 22 Jun 2018 11:49:05 +0800
Subject: [PATCH 2/7] pinctrl: mt7622: fix initialization sequence between eint
 and gpiochip
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
Message-ID: <989f31608d4a85594d3805f966006e1f607ccde3.1529639050.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Because gpichip applied in the driver must depend on mtk eint to implement
the input data debouncing and the translation between gpio and irq, it's
better to keep logic consistent with mtk eint being built prior to gpiochip
being added.

Cc: stable at vger.kernel.org
Fixes: e6dabd38d8e7 ("pinctrl: mediatek: add EINT support to MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 9ad8cb77..e9eba62 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1713,17 +1713,17 @@ static int mtk_pinctrl_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	err = mtk_build_eint(hw, pdev);
+	if (err)
+		dev_warn(&pdev->dev,
+			 "Failed to add EINT, but pinctrl still can work\n");
+
 	err = mtk_build_gpiochip(hw, pdev->dev.of_node);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to add gpio_chip\n");
 		return err;
 	}
 
-	err = mtk_build_eint(hw, pdev);
-	if (err)
-		dev_warn(&pdev->dev,
-			 "Failed to add EINT, but pinctrl still can work\n");
-
 	platform_set_drvdata(pdev, hw);
 
 	return 0;
-- 
2.7.4
