From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sat, 8 Sep 2018 19:07:35 +0800
Subject: [PATCH v2 19/22] pinctrl: mediatek: extend advanced pull support in
 pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
Message-ID: <818dc8145d9b1e193c0c203767d33b11fa69ead4.1536404280.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Extend the advanced pull based on the legacy bias plus additional r0 and r1
to tweak the resistor level.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 37 ++++++++++++++++++++----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 7cdd46f..7d5f570 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -476,6 +476,19 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
 
 	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_PUPD, arg);
 
+	/* If PUPD register is not supported for that pin, let's fallback to
+	 * general bias control.
+	 */
+	if (err == -ENOTSUPP) {
+		if (hw->soc->bias_set) {
+			err = hw->soc->bias_set(hw, desc, pullup);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+	}
+
 	return err;
 }
 
@@ -487,12 +500,26 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
 	int err;
 
 	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_PUPD, &t);
-	if (err)
-		return err;
 
-	/* t == 0 supposes PULLUP for the customized PULL setup */
-	if (pullup ^ !t)
-		return -EINVAL;
+	/* If PUPD register is not supported for that pin, let's fallback to
+	 * general bias control.
+	 */
+	if (err == -ENOTSUPP) {
+		if (hw->soc->bias_get) {
+			err = hw->soc->bias_get(hw, desc, pullup, val);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+	} else {
+		/* t == 0 supposes PULLUP for the customized PULL setup */
+		if (err)
+			return err;
+
+		if (pullup ^ !t)
+			return -EINVAL;
+	}
 
 	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_R0, &t);
 	if (err)
-- 
2.7.4
