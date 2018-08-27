From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:06 +0800
Subject: [PATCH 07/16] pinctrl: mediatek: add drv register support to
 pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <d8f028d29de497b2a51c24c2392b5a057d9f3ae9.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Certain SoCs have to program DRV register to configure driving
strength so that we add it in the existing path as an option.

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 38 ++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  5 ++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 886b40e..3f09179 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -242,3 +242,41 @@ int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
 
 	return 0;
 }
+
+/* Revision 1 */
+int mtk_pinconf_drive_set_rev1(struct mtk_pinctrl *hw,
+			       const struct mtk_pin_desc *desc, u32 arg)
+{
+	const struct mtk_drive_desc *tb;
+	int err = -ENOTSUPP;
+
+	tb = &mtk_drive[desc->drv_n];
+
+	if ((arg >= tb->min && arg <= tb->max) && !(arg % tb->step)) {
+		arg = (arg / tb->step - 1) * tb->scal;
+
+		err = mtk_hw_set_value(hw, desc->number, PINCTRL_PIN_REG_DRV,
+				       arg);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+int mtk_pinconf_drive_get_rev1(struct mtk_pinctrl *hw,
+			       const struct mtk_pin_desc *desc, int *val)
+{
+	const struct mtk_drive_desc *tb;
+	int err, val1;
+
+	tb = &mtk_drive[desc->drv_n];
+
+	err = mtk_hw_get_value(hw, desc->number, PINCTRL_PIN_REG_DRV, &val1);
+	if (err)
+		return err;
+
+	*val = ((val1 & 0x7) / tb->scal + 1) * tb->step;
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 9c37f97..c031818 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -175,4 +175,9 @@ int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
 			  const struct mtk_pin_desc *desc, int *val);
 
+int mtk_pinconf_drive_set_rev1(struct mtk_pinctrl *hw,
+			       const struct mtk_pin_desc *desc, u32 arg);
+int mtk_pinconf_drive_get_rev1(struct mtk_pinctrl *hw,
+			       const struct mtk_pin_desc *desc, int *val);
+
 #endif /* __PINCTRL_MTK_COMMON_V2_H */
-- 
2.7.4
