From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 23 Jan 2014 19:31:41 +1300
Subject: [PATCH] vt8500: pinctrl: Change devicetree data parsing
Message-ID: <1390458701-30238-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to an assumption in the VT8500 pinctrl driver, the value passed
from devicetree for 'wm,pull' was not explicitly translated before
being passed to pinconf.

With changes to 'enum pin_config_param', PIN_CONFIG_BIAS_PULL_(UP/DOWN)
no longer map 1-to-1 with the expected values in devicetree.

This patch adds a small translation between the devicetree values (0..2)
and the enum pin_config_param equivalent values.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/pinctrl/vt8500/pinctrl-wmt.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 39aec08..fa4fdbd 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -276,6 +276,17 @@ static int wmt_pctl_dt_node_to_map_pull(struct wmt_pinctrl_data *data,
 	if (!configs)
 		return -ENOMEM;
 
+	switch (pull) {
+	case 0:
+		pull = PIN_CONFIG_BIAS_DISABLE;
+		break;
+	case 1:
+		pull = PIN_CONFIG_BIAS_PULL_DOWN;
+		break;
+	case 2:
+		pull = PIN_CONFIG_BIAS_PULL_UP;
+		break;
+	}
 	configs[0] = pull;
 
 	map->type = PIN_MAP_TYPE_CONFIGS_PIN;
-- 
1.7.9.5
