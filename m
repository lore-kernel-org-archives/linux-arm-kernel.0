From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Tue, 17 Nov 2015 14:33:41 -0800
Subject: [PATCH] pinctrl: mediatek: fix a memleak when do dt maps.
Message-ID: <1447799622-3340-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

configs will kmemdup to dup_configs in pictrl util function.
So configs need to be freed.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Fix a memleak issue.
 According to Yingjoe's comment, add return checek for pinconf_generic_parse_dt_config.

 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   27 ++++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 5c71727..8db7cdf 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -509,6 +509,9 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 
 	err = pinconf_generic_parse_dt_config(node, pctldev, &configs,
 		&num_configs);
+	if (err)
+		return err;
+
 	if (num_configs)
 		has_config = 1;
 
@@ -520,21 +523,23 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	if (has_config && num_pins >= 1)
 		maps_per_pin++;
 
-	if (!num_pins || !maps_per_pin)
-		return -EINVAL;
+	if (!num_pins || !maps_per_pin) {
+		err = -EINVAL;
+		goto exit;
+	}
 
 	reserve = num_pins * maps_per_pin;
 
 	err = pinctrl_utils_reserve_map(pctldev, map,
 			reserved_maps, num_maps, reserve);
 	if (err < 0)
-		goto fail;
+		goto exit;
 
 	for (i = 0; i < num_pins; i++) {
 		err = of_property_read_u32_index(node, "pinmux",
 				i, &pinfunc);
 		if (err)
-			goto fail;
+			goto exit;
 
 		pin = MTK_GET_PIN_NO(pinfunc);
 		func = MTK_GET_PIN_FUNC(pinfunc);
@@ -543,20 +548,21 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 				func >= ARRAY_SIZE(mtk_gpio_functions)) {
 			dev_err(pctl->dev, "invalid pins value.\n");
 			err = -EINVAL;
-			goto fail;
+			goto exit;
 		}
 
 		grp = mtk_pctrl_find_group_by_pin(pctl, pin);
 		if (!grp) {
 			dev_err(pctl->dev, "unable to match pin %d to group\n",
 					pin);
-			return -EINVAL;
+			err = -EINVAL;
+			goto exit;
 		}
 
 		err = mtk_pctrl_dt_node_to_map_func(pctl, pin, func, grp, map,
 				reserved_maps, num_maps);
 		if (err < 0)
-			goto fail;
+			goto exit;
 
 		if (has_config) {
 			err = pinctrl_utils_add_map_configs(pctldev, map,
@@ -564,13 +570,14 @@ static int mtk_pctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 					configs, num_configs,
 					PIN_MAP_TYPE_CONFIGS_GROUP);
 			if (err < 0)
-				goto fail;
+				goto exit;
 		}
 	}
 
-	return 0;
+	err = 0;
 
-fail:
+exit:
+	kfree(configs);
 	return err;
 }
 
-- 
1.7.9.5
