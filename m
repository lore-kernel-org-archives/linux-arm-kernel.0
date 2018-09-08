From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sat, 8 Sep 2018 19:07:31 +0800
Subject: [PATCH v2 15/22] pinctrl: mediatek: adjust error code and message
 when some register not supported is found
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
Message-ID: <2873ce93abf93d31a160c7dcbf5b3ff42c5e3886.1536404280.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

It's usual and not an error for there's some register not supported by a
certain SoC or a pin so that in the case we have to adjust the message to
print and the error code to get rid of unnecessary false alarm.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 35 ++++++++++++------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 18a3548..7cdd46f 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -61,12 +61,21 @@ void mtk_rmw(struct mtk_pinctrl *pctl, u8 i, u32 reg, u32 mask, u32 set)
 
 static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
 				   const struct mtk_pin_desc *desc,
-				   const struct mtk_pin_reg_calc *rc,
-				   struct mtk_pin_field *pfd)
+				   int field, struct mtk_pin_field *pfd)
 {
 	const struct mtk_pin_field_calc *c, *e;
+	const struct mtk_pin_reg_calc *rc;
 	u32 bits;
 
+	if (hw->soc->reg_cal && hw->soc->reg_cal[field].range) {
+		rc = &hw->soc->reg_cal[field];
+	} else {
+		dev_dbg(hw->dev,
+			"Not support field %d for pin %d (%s)\n",
+			field, desc->number, desc->name);
+		return -ENOTSUPP;
+	}
+
 	c = rc->range;
 	e = c + rc->nranges;
 
@@ -77,14 +86,15 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw,
 	}
 
 	if (c >= e) {
-		dev_err(hw->dev, "Out of range for pin = %d (%s)\n",
-			desc->number, desc->name);
-		return -EINVAL;
+		dev_dbg(hw->dev, "Not support field %d for pin = %d (%s)\n",
+			field, desc->number, desc->name);
+		return -ENOTSUPP;
 	}
 
 	if (c->i_base > hw->nbase - 1) {
-		dev_err(hw->dev, "Invalid base is found for pin = %d (%s)\n",
-			desc->number, desc->name);
+		dev_err(hw->dev,
+			"Invalid base for field %d for pin = %d (%s)\n",
+			field, desc->number, desc->name);
 		return -EINVAL;
 	}
 
@@ -116,21 +126,12 @@ static int mtk_hw_pin_field_get(struct mtk_pinctrl *hw,
 				const struct mtk_pin_desc *desc,
 				int field, struct mtk_pin_field *pfd)
 {
-	const struct mtk_pin_reg_calc *rc;
-
 	if (field < 0 || field >= PINCTRL_PIN_REG_MAX) {
 		dev_err(hw->dev, "Invalid Field %d\n", field);
 		return -EINVAL;
 	}
 
-	if (hw->soc->reg_cal && hw->soc->reg_cal[field].range) {
-		rc = &hw->soc->reg_cal[field];
-	} else {
-		dev_err(hw->dev, "Undefined range for field %d\n", field);
-		return -EINVAL;
-	}
-
-	return mtk_hw_pin_field_lookup(hw, desc, rc, pfd);
+	return mtk_hw_pin_field_lookup(hw, desc, field, pfd);
 }
 
 static void mtk_hw_bits_part(struct mtk_pin_field *pf, int *h, int *l)
-- 
2.7.4
