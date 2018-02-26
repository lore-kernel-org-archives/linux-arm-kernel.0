From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Mon, 26 Feb 2018 16:34:02 +0800
Subject: [PATCH v2 4/4] pintcrl: support bias-disable of generic and special
 pins simultaneously
In-Reply-To: <1519634042-12063-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1519634042-12063-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1519634042-12063-5-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For generic pins, parameter "arg" is 0 or 1.
For special pins, bias-disable is set by R0R1,
so we need transmited "00" to set bias-disable
When we set "bias-disable" as high-z property,
the parameter should be "MTK_PUPD_SET_R1R0_00".

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 3cf384f..e88ba04 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -301,8 +301,17 @@ static int mtk_pconf_set_pull_select(struct mtk_pinctrl *pctl,
 	 * resistor bit, so we need this special handle.
 	 */
 	if (pctl->devdata->spec_pull_set) {
-		ret = pctl->devdata->spec_pull_set(mtk_get_regmap(pctl, pin),
-			pin, pctl->devdata->port_align, isup, arg);
+		if (enable) {
+			ret = pctl->devdata->spec_pull_set(
+				mtk_get_regmap(pctl, pin), pin,
+				pctl->devdata->port_align, isup,
+				arg);
+		} else {
+			ret = pctl->devdata->spec_pull_set(
+				mtk_get_regmap(pctl, pin), pin,
+				pctl->devdata->port_align, isup,
+				MTK_PUPD_SET_R1R0_00);
+		}
 		if (!ret)
 			return 0;
 	}
-- 
1.9.1
