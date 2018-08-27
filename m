From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:05 +0800
Subject: [PATCH 06/16] pinctrl: mediatek: add driving strength related support
 to pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <2bc99963e3fb8989cbb87f3e3d26620e8241d730.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Put driving strength support related functions to pinctrl-mtk-common-v2.c
as these operations might be different by chips and allow different type
of driver to reuse them.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 48 +++++---------
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        |  2 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 79 ++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 14 +++++
 4 files changed, 112 insertions(+), 31 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index b412b65..1f0cd30 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -82,6 +82,9 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	u32 param = pinconf_to_config_param(*config);
 	int val, val2, err, reg, ret = 1;
+	const struct mtk_pin_desc *desc;
+
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
 
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
@@ -139,19 +142,13 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_E4, &val);
-		if (err)
-			return err;
-
-		err = mtk_hw_get_value(hw, pin, PINCTRL_PIN_REG_E8, &val2);
-		if (err)
-			return err;
-
-		/* 4mA when (e8, e4) = (0, 0); 8mA when (e8, e4) = (0, 1)
-		 * 12mA when (e8, e4) = (1, 0); 16mA when (e8, e4) = (1, 1)
-		 */
-		ret = ((val2 << 1) + val + 1) * 4;
-
+		if (hw->soc->drive_get) {
+			err = hw->soc->drive_get(hw, desc, &ret);
+			if (err)
+				return err;
+		} else {
+			err = -ENOTSUPP;
+		}
 		break;
 	case MTK_PIN_CONFIG_TDSEL:
 	case MTK_PIN_CONFIG_RDSEL:
@@ -178,9 +175,12 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			   unsigned long *configs, unsigned int num_configs)
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	const struct mtk_pin_desc *desc;
 	u32 reg, param, arg;
 	int cfg, err = 0;
 
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[pin];
+
 	for (cfg = 0; cfg < num_configs; cfg++) {
 		param = pinconf_to_config_param(configs[cfg]);
 		arg = pinconf_to_config_argument(configs[cfg]);
@@ -247,24 +247,10 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 				goto err;
 			break;
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			/* 4mA when (e8, e4) = (0, 0);
-			 * 8mA when (e8, e4) = (0, 1);
-			 * 12mA when (e8, e4) = (1, 0);
-			 * 16mA when (e8, e4) = (1, 1)
-			 */
-			if (!(arg % 4) && (arg >= 4 && arg <= 16)) {
-				arg = arg / 4 - 1;
-				err = mtk_hw_set_value(hw, pin,
-						       PINCTRL_PIN_REG_E4,
-						       arg & 0x1);
-				if (err)
-					goto err;
-
-				err = mtk_hw_set_value(hw, pin,
-						       PINCTRL_PIN_REG_E8,
-						       (arg & 0x2) >> 1);
-				if (err)
-					goto err;
+			if (hw->soc->drive_set) {
+				err = hw->soc->drive_set(hw, desc, arg);
+			if (err)
+				return err;
 			} else {
 				err = -ENOTSUPP;
 			}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 2fe1f27e..f6904a9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -767,6 +767,8 @@ static const struct mtk_pin_soc mt7622_data = {
 	.eint_hw = &mt7622_eint_hw,
 	.gpio_m	= 1,
 	.eint_m = 1,
+	.drive_set = mtk_pinconf_drive_set,
+	.drive_get = mtk_pinconf_drive_get,
 };
 
 static const struct of_device_id mt7622_pinctrl_of_match[] = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 2a16804..886b40e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -13,6 +13,32 @@
 
 #include "pinctrl-mtk-common-v2.h"
 
+/**
+ * struct mtk_drive_desc - the structure that holds the information
+ *			    of the driving current
+ * @min:	the minimum current of this group
+ * @max:	the maximum current of this group
+ * @step:	the step current of this group
+ * @scal:	the weight factor
+ *
+ * formula: output = ((input) / step - 1) * scal
+ */
+struct mtk_drive_desc {
+	u8 min;
+	u8 max;
+	u8 step;
+	u8 scal;
+};
+
+/* The groups of drive strength */
+const struct mtk_drive_desc mtk_drive[] = {
+	[DRV_GRP0] = { 4, 16, 4, 1 },
+	[DRV_GRP1] = { 4, 16, 4, 2 },
+	[DRV_GRP2] = { 2, 8, 2, 1 },
+	[DRV_GRP3] = { 2, 8, 2, 2 },
+	[DRV_GRP4] = { 2, 16, 2, 1 },
+};
+
 static void mtk_w32(struct mtk_pinctrl *pctl, u32 reg, u32 val)
 {
 	writel_relaxed(val, pctl->base + reg);
@@ -163,3 +189,56 @@ int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value)
 
 	return 0;
 }
+
+/* Revision 0 */
+int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
+			  const struct mtk_pin_desc *desc, u32 arg)
+{
+	const struct mtk_drive_desc *tb;
+	int err = -ENOTSUPP;
+
+	tb = &mtk_drive[desc->drv_n];
+	/* 4mA when (e8, e4) = (0, 0)
+	 * 8mA when (e8, e4) = (0, 1)
+	 * 12mA when (e8, e4) = (1, 0)
+	 * 16mA when (e8, e4) = (1, 1)
+	 */
+	if ((arg >= tb->min && arg <= tb->max) && !(arg % tb->step)) {
+		arg = (arg / tb->step - 1) * tb->scal;
+		err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_E4,
+				       arg & 0x1);
+		if (err)
+			return err;
+
+		err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_E8,
+				       (arg & 0x2) >> 1);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
+			  const struct mtk_pin_desc *desc, int *val)
+{
+	const struct mtk_drive_desc *tb;
+	int err, val1, val2;
+
+	tb = &mtk_drive[desc->drv_n];
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_E4, &val1);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_E8, &val2);
+	if (err)
+		return err;
+
+	/* 4mA when (e8, e4) = (0, 0); 8mA when (e8, e4) = (0, 1)
+	 * 12mA when (e8, e4) = (1, 0); 16mA when (e8, e4) = (1, 1)
+	 */
+	*val = (((val2 << 1) + val1) / tb->scal + 1) * tb->step;
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 91b84b5..9c37f97 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -50,6 +50,7 @@ enum {
 	PINCTRL_PIN_REG_E8,
 	PINCTRL_PIN_REG_TDSEL,
 	PINCTRL_PIN_REG_RDSEL,
+	PINCTRL_PIN_REG_DRV,
 	PINCTRL_PIN_REG_MAX,
 };
 
@@ -130,6 +131,8 @@ struct mtk_pin_desc {
 	u8 drv_n;
 };
 
+struct mtk_pinctrl;
+
 /* struct mtk_pin_soc - the structure that holds SoC-specific data */
 struct mtk_pin_soc {
 	const struct mtk_pin_reg_calc	*reg_cal;
@@ -145,6 +148,12 @@ struct mtk_pin_soc {
 	/* Specific parameters per SoC */
 	u8				gpio_m;
 	u8				eint_m;
+
+	/* Specific pinconfig operations */
+	int (*drive_set)(struct mtk_pinctrl *hw,
+			 const struct mtk_pin_desc *desc, u32 arg);
+	int (*drive_get)(struct mtk_pinctrl *hw,
+			 const struct mtk_pin_desc *desc, int *val);
 };
 
 struct mtk_pinctrl {
@@ -161,4 +170,9 @@ void mtk_rmw(struct mtk_pinctrl *pctl, u32 reg, u32 mask, u32 set);
 int mtk_hw_set_value(struct mtk_pinctrl *hw, int pin, int field, int value);
 int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value);
 
+int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
+			  const struct mtk_pin_desc *desc, u32 arg);
+int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
+			  const struct mtk_pin_desc *desc, int *val);
+
 #endif /* __PINCTRL_MTK_COMMON_V2_H */
-- 
2.7.4
