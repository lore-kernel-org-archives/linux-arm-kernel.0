From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:09 +0800
Subject: [PATCH 10/16] pinctrl: mediatek: add ies register support to
 pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <c5b88da78519149ea5752727d2153bc0dfc6d8da.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Certain SoCs have to program an extra IES register to configure input
enabled mode so that we add it in the existing path as an option.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 26 +++++++++++++++++-------
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        |  1 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  2 ++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 4009329..219cfce 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -244,15 +244,27 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 					       MTK_DISABLE);
 			if (err)
 				goto err;
-			/* else: fall through */
+
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
+					       MTK_OUTPUT);
+			if (err)
+				goto err;
+			break;
 		case PIN_CONFIG_INPUT_ENABLE:
-		case PIN_CONFIG_SLEW_RATE:
-			reg = (param == PIN_CONFIG_SLEW_RATE) ?
-			       PINCTRL_PIN_REG_SR : PINCTRL_PIN_REG_DIR;
 
-			arg = (param == PIN_CONFIG_INPUT_ENABLE) ? 0 :
-			      (param == PIN_CONFIG_OUTPUT_ENABLE) ? 1 : arg;
-			err = mtk_hw_set_value(hw, pin, reg, arg);
+			if (hw->soc->ies_present) {
+				mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_IES,
+						 MTK_ENABLE);
+			}
+
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_DIR,
+					       MTK_INPUT);
+			if (err)
+				goto err;
+			break;
+		case PIN_CONFIG_SLEW_RATE:
+			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SR,
+					       arg);
 			if (err)
 				goto err;
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 9a5b13a..9ac36ab 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -767,6 +767,7 @@ static const struct mtk_pin_soc mt7622_data = {
 	.eint_hw = &mt7622_eint_hw,
 	.gpio_m	= 1,
 	.eint_m = 1,
+	.ies_present = false,
 	.bias_disable_set = mtk_pinconf_bias_disable_set,
 	.bias_disable_get = mtk_pinconf_bias_disable_get,
 	.bias_set = mtk_pinconf_bias_set,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index fa736c5..5133628 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -54,6 +54,7 @@ enum {
 	PINCTRL_PIN_REG_PUPD,
 	PINCTRL_PIN_REG_R0,
 	PINCTRL_PIN_REG_R1,
+	PINCTRL_PIN_REG_IES,
 	PINCTRL_PIN_REG_MAX,
 };
 
@@ -151,6 +152,7 @@ struct mtk_pin_soc {
 	/* Specific parameters per SoC */
 	u8				gpio_m;
 	u8				eint_m;
+	bool				ies_present;
 
 	/* Specific pinconfig operations */
 	int (*bias_disable_set)(struct mtk_pinctrl *hw,
-- 
2.7.4
