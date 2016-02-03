From: biao.huang@mediatek.com (Biao Huang)
Date: Wed, 3 Feb 2016 09:24:45 +0800
Subject: [PATCH 1/2] pinctrl: mediatek: fix direction control issue
In-Reply-To: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
References: <1454462686-770-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1454462686-770-2-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since input-enable/disable and input-schmitt-enable/disable are
workable when gpio direction is input, so add direction setting
when do input-enable/disable and input-schmitt-enable/disable
properties.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 8cac73d..6eb01c9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -352,6 +352,7 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
 		ret = mtk_pconf_set_pull_select(pctl, pin, true, false, arg);
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
+		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
 		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);
 		break;
 	case PIN_CONFIG_OUTPUT:
@@ -359,6 +360,7 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
 		ret = mtk_pmx_gpio_set_direction(pctldev, NULL, pin, false);
 		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
 		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-- 
1.7.9.5
