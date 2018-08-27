From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:08 +0800
Subject: [PATCH 09/16] pinctrl: mediatek: add advanced pull related support to
 pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <613636a253c8d310b84997724ee5544ac06ae6be.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

There are some specific pins (i.e. MMC/SD) need specific registers to
turn on/off the 10K & 50k(75K) resistors when pull up/down.

Therefore, this patch adds the custom prarmeters so that the user could
control it through device tree.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         | 33 ++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 55 ++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 17 ++++++++
 3 files changed, 105 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index d69f024..4009329 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -15,16 +15,22 @@
 /* Custom pinconf parameters */
 #define MTK_PIN_CONFIG_TDSEL	(PIN_CONFIG_END + 1)
 #define MTK_PIN_CONFIG_RDSEL	(PIN_CONFIG_END + 2)
+#define MTK_PIN_CONFIG_PU_ADV	(PIN_CONFIG_END + 3)
+#define MTK_PIN_CONFIG_PD_ADV	(PIN_CONFIG_END + 4)
 
 static const struct pinconf_generic_params mtk_custom_bindings[] = {
 	{"mediatek,tdsel",	MTK_PIN_CONFIG_TDSEL,		0},
 	{"mediatek,rdsel",	MTK_PIN_CONFIG_RDSEL,		0},
+	{"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,		1},
+	{"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,	1},
 };
 
 #ifdef CONFIG_DEBUG_FS
 static const struct pin_config_item mtk_conf_items[] = {
 	PCONFDUMP(MTK_PIN_CONFIG_TDSEL, "tdsel", NULL, true),
 	PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
 };
 #endif
 
@@ -169,6 +175,19 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		ret = val;
 
 		break;
+	case MTK_PIN_CONFIG_PU_ADV:
+	case MTK_PIN_CONFIG_PD_ADV:
+		if (hw->soc->adv_pull_get) {
+			bool pullup;
+
+			pullup = param == MTK_PIN_CONFIG_PU_ADV;
+			err = hw->soc->adv_pull_get(hw, desc, pullup, &ret);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
 	default:
 		return -ENOTSUPP;
 	}
@@ -282,6 +301,20 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			if (err)
 				goto err;
 			break;
+		case MTK_PIN_CONFIG_PU_ADV:
+		case MTK_PIN_CONFIG_PD_ADV:
+			if (hw->soc->adv_pull_set) {
+				bool pullup;
+
+				pullup = param == MTK_PIN_CONFIG_PU_ADV;
+				err = hw->soc->adv_pull_set(hw, desc, pullup,
+							    arg);
+				if (err)
+					return err;
+			} else {
+				return -ENOTSUPP;
+			}
+			break;
 		default:
 			err = -ENOTSUPP;
 		}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 67c95ef..e66bf49 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -358,3 +358,58 @@ int mtk_pinconf_drive_get_rev1(struct mtk_pinctrl *hw,
 
 	return 0;
 }
+
+int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
+			     const struct mtk_pin_desc *desc, bool pullup,
+			     u32 arg)
+{
+	int err;
+
+	/* 10K off & 50K (75K) off, when (R0, R1) = (0, 0);
+	 * 10K off & 50K (75K) on, when (R0, R1) = (0, 1);
+	 * 10K on & 50K (75K) off, when (R0, R1) = (1, 0);
+	 * 10K on & 50K (75K) on, when (R0, R1) = (1, 1)
+	 */
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_R0, arg & 1);
+	if (err)
+		return 0;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_R1,
+			       !!(arg & 2));
+	if (err)
+		return 0;
+
+	arg = pullup ? 0 : 1;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PUPD, arg);
+
+	return err;
+}
+
+int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
+			     const struct mtk_pin_desc *desc, bool pullup,
+			     u32 *val)
+{
+	u32 t, t2;
+	int err;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PUPD, &t);
+	if (err)
+		return err;
+
+	/* t == 0 supposes PULLUP for the customized PULL setup */
+	if (pullup ^ !t)
+		return -EINVAL;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_R0, &t);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_R1, &t2);
+	if (err)
+		return err;
+
+	*val = (t | t2 << 1) & 0x7;
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index d97e646..fa736c5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -51,6 +51,9 @@ enum {
 	PINCTRL_PIN_REG_TDSEL,
 	PINCTRL_PIN_REG_RDSEL,
 	PINCTRL_PIN_REG_DRV,
+	PINCTRL_PIN_REG_PUPD,
+	PINCTRL_PIN_REG_R0,
+	PINCTRL_PIN_REG_R1,
 	PINCTRL_PIN_REG_MAX,
 };
 
@@ -163,6 +166,13 @@ struct mtk_pin_soc {
 			 const struct mtk_pin_desc *desc, u32 arg);
 	int (*drive_get)(struct mtk_pinctrl *hw,
 			 const struct mtk_pin_desc *desc, int *val);
+
+	int (*adv_pull_set)(struct mtk_pinctrl *hw,
+			    const struct mtk_pin_desc *desc, bool pullup,
+			    u32 arg);
+	int (*adv_pull_get)(struct mtk_pinctrl *hw,
+			    const struct mtk_pin_desc *desc, bool pullup,
+			    u32 *val);
 };
 
 struct mtk_pinctrl {
@@ -199,4 +209,11 @@ int mtk_pinconf_drive_set_rev1(struct mtk_pinctrl *hw,
 int mtk_pinconf_drive_get_rev1(struct mtk_pinctrl *hw,
 			       const struct mtk_pin_desc *desc, int *val);
 
+int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
+			     const struct mtk_pin_desc *desc, bool pullup,
+			     u32 arg);
+int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
+			     const struct mtk_pin_desc *desc, bool pullup,
+			     u32 *val);
+
 #endif /* __PINCTRL_MTK_COMMON_V2_H */
-- 
2.7.4
