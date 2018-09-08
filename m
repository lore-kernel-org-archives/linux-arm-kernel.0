From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sat, 8 Sep 2018 19:07:27 +0800
Subject: [PATCH v2 11/22] pinctrl: mediatek: add pullen,
 pullsel register support to pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
Message-ID: <f698dee4dcac1b5acfde7133773f7dc1e8c40583.1536404280.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Certain SoCs have to program an extra PULLEN, PULLSEL register to configure
bias related function so that we add it in the existing path.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 76 ++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 15 +++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index e66bf49..86eefe8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -190,6 +190,7 @@ int mtk_hw_get_value(struct mtk_pinctrl *hw, int pin, int field, int *value)
 	return 0;
 }
 
+/* Revision 0 */
 int mtk_pinconf_bias_disable_set(struct mtk_pinctrl *hw,
 				 const struct mtk_pin_desc *desc)
 {
@@ -268,6 +269,81 @@ int mtk_pinconf_bias_get(struct mtk_pinctrl *hw,
 	return 0;
 }
 
+/* Revision 1 */
+int mtk_pinconf_bias_disable_set_rev1(struct mtk_pinctrl *hw,
+				      const struct mtk_pin_desc *desc)
+{
+	int err;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PULLEN,
+			       MTK_DISABLE);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int mtk_pinconf_bias_disable_get_rev1(struct mtk_pinctrl *hw,
+				      const struct mtk_pin_desc *desc, int *res)
+{
+	int v, err;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PULLEN, &v);
+	if (err)
+		return err;
+
+	if (v == MTK_ENABLE)
+		return -EINVAL;
+
+	*res = 1;
+
+	return 0;
+}
+
+int mtk_pinconf_bias_set_rev1(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, bool pullup)
+{
+	int err, arg;
+
+	arg = pullup ? MTK_PULLUP : MTK_PULLDOWN;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PULLEN,
+			       MTK_ENABLE);
+	if (err)
+		return err;
+
+	err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_PULLSEL, arg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int mtk_pinconf_bias_get_rev1(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, bool pullup,
+			      int *res)
+{
+	int err, v;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PULLEN, &v);
+	if (err)
+		return err;
+
+	if (v == MTK_DISABLE)
+		return -EINVAL;
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_PULLSEL, &v);
+	if (err)
+		return err;
+
+	if (pullup ^ (v == MTK_PULLUP))
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
index b01dbd8..d90788b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -13,6 +13,8 @@
 #define MTK_OUTPUT     1
 #define MTK_DISABLE    0
 #define MTK_ENABLE     1
+#define MTK_PULLDOWN   0
+#define MTK_PULLUP     1
 
 #define EINT_NA	-1
 
@@ -55,6 +57,8 @@ enum {
 	PINCTRL_PIN_REG_R0,
 	PINCTRL_PIN_REG_R1,
 	PINCTRL_PIN_REG_IES,
+	PINCTRL_PIN_REG_PULLEN,
+	PINCTRL_PIN_REG_PULLSEL,
 	PINCTRL_PIN_REG_MAX,
 };
 
@@ -201,6 +205,17 @@ int mtk_pinconf_bias_get(struct mtk_pinctrl *hw,
 			 const struct mtk_pin_desc *desc, bool pullup,
 			 int *res);
 
+int mtk_pinconf_bias_disable_set_rev1(struct mtk_pinctrl *hw,
+				      const struct mtk_pin_desc *desc);
+int mtk_pinconf_bias_disable_get_rev1(struct mtk_pinctrl *hw,
+				      const struct mtk_pin_desc *desc,
+				      int *res);
+int mtk_pinconf_bias_set_rev1(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, bool pullup);
+int mtk_pinconf_bias_get_rev1(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, bool pullup,
+			      int *res);
+
 int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 			  const struct mtk_pin_desc *desc, u32 arg);
 int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
-- 
2.7.4
