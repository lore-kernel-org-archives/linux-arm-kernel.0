From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 1 Dec 2015 15:19:02 +0100
Subject: [PATCH] pinctrl: at91-pio4: fix memleak after using dt map
Message-ID: <1448979542-1202-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

configs is allocated by pinconf_generic_parse_dt_config(),
pinctrl_utils_add_map_configs() duplicates configs so it can and has to
be freed to prevent memory leaks.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Reported-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 33edd07..3a384ee 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -500,7 +500,8 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	if (!num_pins) {
 		dev_err(pctldev->dev, "no pins found in node %s\n",
 			of_node_full_name(np));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto exit;
 	}
 
 	/*
@@ -514,19 +515,19 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps, num_maps,
 					reserve);
 	if (ret < 0)
-		return ret;
+		goto exit;
 
 	for (i = 0; i < num_pins; i++) {
 		const char *group, *func;
 
 		ret = of_property_read_u32_index(np, "pinmux", i, &pinfunc);
 		if (ret)
-			return ret;
+			goto exit;
 
 		ret = atmel_pctl_xlate_pinfunc(pctldev, np, pinfunc, &group,
 					       &func);
 		if (ret)
-			return ret;
+			goto exit;
 
 		pinctrl_utils_add_map_mux(pctldev, map, reserved_maps, num_maps,
 					  group, func);
@@ -537,11 +538,13 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 					configs, num_configs,
 					PIN_MAP_TYPE_CONFIGS_GROUP);
 			if (ret < 0)
-				return ret;
+				goto exit;
 		}
 	}
 
-	return 0;
+exit:
+	kfree(configs);
+	return ret;
 }
 
 static int atmel_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
-- 
2.5.0
