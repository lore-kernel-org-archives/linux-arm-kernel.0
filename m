From: biao.huang@mediatek.com (Biao Huang)
Date: Wed, 27 Jan 2016 09:24:39 +0800
Subject: [PATCH v4 1/5] pinctrl: mediatek: fix direction control issue
In-Reply-To: <1453857883-28436-1-git-send-email-biao.huang@mediatek.com>
References: <1453857883-28436-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1453857883-28436-2-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since input-enable/disable and input-schmitt-enable/disable are
workable when gpio direction is input, so add direction setting
when do input-enable/disable and input-schmitt-enable/disable
properties.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Acked-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 16d48a4..e96e86d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -347,6 +347,7 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
 		ret = mtk_pconf_set_pull_select(pctl, pin, true, false, arg);
 		break;
 	case PIN_CONFIG_INPUT_ENABLE:
+		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
 		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);
 		break;
 	case PIN_CONFIG_OUTPUT:
@@ -354,6 +355,7 @@ static int mtk_pconf_parse_conf(struct pinctrl_dev *pctldev,
 		ret = mtk_pmx_gpio_set_direction(pctldev, NULL, pin, false);
 		break;
 	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		mtk_pmx_gpio_set_direction(pctldev, NULL, pin, true);
 		ret = mtk_pconf_set_ies_smt(pctl, pin, arg, param);
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
-- 
1.7.9.5
