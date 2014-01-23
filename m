From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 23 Jan 2014 21:57:33 +1300
Subject: [PATCH v2 RESEND] vt8500: pinctrl: Change devicetree data parsing
Message-ID: <1390467453-8841-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to an assumption in the VT8500 pinctrl driver, the value passed
from devicetree for 'wm,pull' was not explicitly translated before
being passed to pinconf.

Since v3.10, changes to 'enum pin_config_param', PIN_CONFIG_BIAS_PULL_(UP/DOWN)
no longer map 1-to-1 with the expected values in devicetree.

This patch adds a small translation between the devicetree values (0..2)
and the enum pin_config_param equivalent values.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
v2:
Minor change in commit message to indicate time since problem occurred.
Change assigned variable to configs[0] rather than reassigning to pull.
Add a default case to the switch to prevent static checker errors.

v2 resend:
Correct Linus' email address

 drivers/pinctrl/vt8500/pinctrl-wmt.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/vt8500/pinctrl-wmt.c b/drivers/pinctrl/vt8500/pinctrl-wmt.c
index 39aec08..25ab2ee 100644
--- a/drivers/pinctrl/vt8500/pinctrl-wmt.c
+++ b/drivers/pinctrl/vt8500/pinctrl-wmt.c
@@ -276,7 +276,20 @@ static int wmt_pctl_dt_node_to_map_pull(struct wmt_pinctrl_data *data,
 	if (!configs)
 		return -ENOMEM;
 
-	configs[0] = pull;
+	switch (pull) {
+	case 0:
+		configs[0] = PIN_CONFIG_BIAS_DISABLE;
+		break;
+	case 1:
+		configs[0] = PIN_CONFIG_BIAS_PULL_DOWN;
+		break;
+	case 2:
+		configs[0] = PIN_CONFIG_BIAS_PULL_UP;
+		break;
+	default:
+		configs[0] = PIN_CONFIG_BIAS_DISABLE;
+		dev_err(data->dev, "invalid pull state %d - disabling\n", pull);
+	}
 
 	map->type = PIN_MAP_TYPE_CONFIGS_PIN;
 	map->data.configs.group_or_pin = data->groups[group];
-- 
1.7.9.5
