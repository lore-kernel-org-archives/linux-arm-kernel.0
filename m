From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:04 +0800
Subject: [PATCH 05/16] pinctrl: mediatek: extend struct mtk_pin_soc to
 pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <d303a55d5962a38a97db0182521107d384cc98df.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add two parameters gpio_m and eint_m for configuring GPIO mode and EINT
mode, they might be varying depend on SoC.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 4 ++--
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        | 2 ++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 5 ++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index ba7511d..b412b65 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -63,7 +63,7 @@ static int mtk_pinmux_gpio_request_enable(struct pinctrl_dev *pctldev,
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 
-	return mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_MODE, MTK_GPIO_MODE);
+	return mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_MODE, hw->soc->gpio_m);
 }
 
 static int mtk_pinmux_gpio_set_direction(struct pinctrl_dev *pctldev,
@@ -580,7 +580,7 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
 		return err;
 
 	err = mtk_hw_set_value(hw, gpio_n, PINCTRL_PIN_REG_MODE,
-			       MTK_GPIO_MODE);
+			       hw->soc->eint_m);
 	if (err)
 		return err;
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index a0045bb..2fe1f27e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -765,6 +765,8 @@ static const struct mtk_pin_soc mt7622_data = {
 	.funcs = mt7622_functions,
 	.nfuncs = ARRAY_SIZE(mt7622_functions),
 	.eint_hw = &mt7622_eint_hw,
+	.gpio_m	= 1,
+	.eint_m = 1,
 };
 
 static const struct of_device_id mt7622_pinctrl_of_match[] = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 174e75b..91b84b5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -9,7 +9,6 @@
 #ifndef __PINCTRL_MTK_COMMON_V2_H
 #define __PINCTRL_MTK_COMMON_V2_H
 
-#define MTK_GPIO_MODE  1
 #define MTK_INPUT      0
 #define MTK_OUTPUT     1
 #define MTK_DISABLE    0
@@ -142,6 +141,10 @@ struct mtk_pin_soc {
 	unsigned int			nfuncs;
 	const struct mtk_eint_regs	*eint_regs;
 	const struct mtk_eint_hw	*eint_hw;
+
+	/* Specific parameters per SoC */
+	u8				gpio_m;
+	u8				eint_m;
 };
 
 struct mtk_pinctrl {
-- 
2.7.4
