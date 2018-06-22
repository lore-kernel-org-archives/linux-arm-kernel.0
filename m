From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 22 Jun 2018 11:49:07 +0800
Subject: [PATCH 4/7] pinctrl: mt7622: stop using the deprecated
 pinctrl_add_gpio_range
In-Reply-To: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
References: <f222c9f488490bd86d35346e725491e1de306ace.1529639050.git.sean.wang@mediatek.com>
Message-ID: <098100772163e54fe5ca49576042edbfaf3807a5.1529639050.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

If the pinctrl node has the gpio-ranges property, the range will be added
by the gpio core and doesn't need to be added by the pinctrl driver.

But for keeping backward compatibility, an explicit pinctrl_add_gpio_range
is still needed to be called when there is a missing gpio-ranges in pinctrl
node in old dts files.

Cc: stable at vger.kernel.org
Fixes: d6ed93551320 ("pinctrl: mediatek: add pinctrl driver for MT7622 SoC")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 42155d4..055074bb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -1508,11 +1508,20 @@ static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
 	if (ret < 0)
 		return ret;
 
-	ret = gpiochip_add_pin_range(chip, dev_name(hw->dev), 0, 0,
-				     chip->ngpio);
-	if (ret < 0) {
-		gpiochip_remove(chip);
-		return ret;
+	/* Just for backward compatible for these old pinctrl nodes without
+	 * "gpio-ranges" property. Otherwise, called directly from a
+	 * DeviceTree-supported pinctrl driver is DEPRECATED.
+	 * Please see Section 2.1 of
+	 * Documentation/devicetree/bindings/gpio/gpio.txt on how to
+	 * bind pinctrl and gpio drivers via the "gpio-ranges" property.
+	 */
+	if (!of_find_property(np, "gpio-ranges", NULL)) {
+		ret = gpiochip_add_pin_range(chip, dev_name(hw->dev), 0, 0,
+					     chip->ngpio);
+		if (ret < 0) {
+			gpiochip_remove(chip);
+			return ret;
+		}
 	}
 
 	return 0;
-- 
2.7.4
