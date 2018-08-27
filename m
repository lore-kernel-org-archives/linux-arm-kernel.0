From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:07 +0800
Subject: [PATCH 08/16] pinctrl: mediatek: add pull related support to
 pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <9af622f544db84bf5f58b45a908a1758b90ff38f.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Put pull control support related functions to pinctrl-mtk-common-v2.c
as these operations might be different by chips and allow different
type of driver to reuse them.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 76 ++++++++++++++---------
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        |  4 ++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 78 ++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 19 ++++++
 4 files changed, 148 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index 1f0cd30..d69f024 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -88,27 +88,34 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_PU, &val);
-		if (err)
-			return err;
-
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_PD, &val2);
-		if (err)
-			return err;
-
-		if (val || val2)
-			return -EINVAL;
-
+		if (hw->soc->bias_disable_get) {
+			err = hw->soc->bias_disable_get(hw, desc, &ret);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
+		if (hw->soc->bias_get) {
+			err = hw->soc->bias_get(hw, desc, 1, &ret);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (hw->soc->bias_get) {
+			err = hw->soc->bias_get(hw, desc, 0, &ret);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
 	case PIN_CONFIG_SLEW_RATE:
-		reg = (param == PIN_CONFIG_BIAS_PULL_UP) ?
-		      PINCTRL_PIN_REG_PU :
-		      (param == PIN_CONFIG_BIAS_PULL_DOWN) ?
-		      PINCTRL_PIN_REG_PD : PINCTRL_PIN_REG_SR;
-
-		err = mtk_hw_get_value(hw, pin, reg, &val);
+		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_SR, &val);
 		if (err)
 			return err;
 
@@ -187,20 +194,31 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_DISABLE:
+			if (hw->soc->bias_disable_set) {
+				err = hw->soc->bias_disable_set(hw, desc);
+				if (err)
+					return err;
+			} else {
+				return -ENOTSUPP;
+			}
+			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
+			if (hw->soc->bias_set) {
+				err = hw->soc->bias_set(hw, desc, 1);
+				if (err)
+					return err;
+			} else {
+				return -ENOTSUPP;
+			}
+			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			arg = (param == PIN_CONFIG_BIAS_DISABLE) ? 0 :
-			       (param == PIN_CONFIG_BIAS_PULL_UP) ? 1 : 2;
-
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_PU,
-					       arg & 1);
-			if (err)
-				goto err;
-
-			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_PD,
-					       !!(arg & 2));
-			if (err)
-				goto err;
+			if (hw->soc->bias_set) {
+				err = hw->soc->bias_set(hw, desc, 0);
+				if (err)
+					return err;
+			} else {
+				return -ENOTSUPP;
+			}
 			break;
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			err = mtk_hw_set_value(hw, pin, PINCTRL_PIN_REG_SMT,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index f6904a9..9a5b13a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -767,6 +767,10 @@ static const struct mtk_pin_soc mt7622_data = {
 	.eint_hw = &mt7622_eint_hw,
 	.gpio_m	= 1,
 	.eint_m = 1,
+	.bias_disable_set = mtk_pinconf_bias_disable_set,
+	.bias_disable_get = mtk_pinconf_bias_disable_get,
+	.bias_set = mtk_pinconf_bias_set,
+	.bias_get = mtk_pinconf_bias_get,
 	.drive_set = mtk_pinconf_drive_set,
 	.drive_get = mtk_pinconf_drive_get,
 };
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 3f09179..67c95ef 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -190,6 +190,84 @@ int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value)
 	return 0;
 }
 
+int mtk_pinconf_bias_disable_set(struct mtk_pinctrl *hw,
+				 const struct mtk_pin_desc *desc)
+{
+	int err;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PU,
+			       MTK_DISABLE);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PD,
+			       MTK_DISABLE);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int mtk_pinconf_bias_disable_get(struct mtk_pinctrl *hw,
+				 const struct mtk_pin_desc *desc, int *res)
+{
+	int v, v2;
+	int err;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PU, &v);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PD, &v2);
+	if (err)
+		return err;
+
+	if (v == MTK_ENABLE || v2 == MTK_ENABLE)
+		return -EINVAL;
+
+	*res = 1;
+
+	return 0;
+}
+
+int mtk_pinconf_bias_set(struct mtk_pinctrl *hw,
+			 const struct mtk_pin_desc *desc, bool pullup)
+{
+	int err, arg;
+
+	arg = pullup ? 1 : 2;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PU, arg & 1);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PD,
+			       !!(arg & 2));
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int mtk_pinconf_bias_get(struct mtk_pinctrl *hw,
+			 const struct mtk_pin_desc *desc, bool pullup, int *res)
+{
+	int reg, err, v;
+
+	reg = pullup ? PINCTRL_PIN_REG_PU : PINCTRL_PIN_REG_PD;
+
+	err = mtk_hw_get_value(hw, desc->number, reg, &v);
+	if (err)
+		return err;
+
+	if (!v)
+		return -EINVAL;
+
+	*res = 1;
+
+	return 0;
+}
+
 /* Revision 0 */
 int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 			  const struct mtk_pin_desc *desc, u32 arg)
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index c031818..d97e646 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -150,6 +150,15 @@ struct mtk_pin_soc {
 	u8				eint_m;
 
 	/* Specific pinconfig operations */
+	int (*bias_disable_set)(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc);
+	int (*bias_disable_get)(struct mtk_pinctrl *hw,
+				const struct mtk_pin_desc *desc, int *res);
+	int (*bias_set)(struct mtk_pinctrl *hw,
+			const struct mtk_pin_desc *desc, bool pullup);
+	int (*bias_get)(struct mtk_pinctrl *hw,
+			const struct mtk_pin_desc *desc, bool pullup, int *res);
+
 	int (*drive_set)(struct mtk_pinctrl *hw,
 			 const struct mtk_pin_desc *desc, u32 arg);
 	int (*drive_get)(struct mtk_pinctrl *hw,
@@ -170,6 +179,16 @@ void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set);
 int mtk_hw_set_value(struct mtk_pinctrl *hw, int pin, int field, int value);
 int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value);
 
+int mtk_pinconf_bias_disable_set(struct mtk_pinctrl *hw,
+				 const struct mtk_pin_desc *desc);
+int mtk_pinconf_bias_disable_get(struct mtk_pinctrl *hw,
+				 const struct mtk_pin_desc *desc, int *res);
+int mtk_pinconf_bias_set(struct mtk_pinctrl *hw,
+			 const struct mtk_pin_desc *desc, bool pullup);
+int mtk_pinconf_bias_get(struct mtk_pinctrl *hw,
+			 const struct mtk_pin_desc *desc, bool pullup,
+			 int *res);
+
 int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 			  const struct mtk_pin_desc *desc, u32 arg);
 int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
-- 
2.7.4
