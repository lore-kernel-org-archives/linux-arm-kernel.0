From: jason77.wang@gmail.com (Hui Wang)
Date: Wed, 20 Jun 2012 18:13:47 +0800
Subject: [PATCH v2] pinctrl: pinctrl-imx: fix map setting problem if
 NO_PAD_CTL is set
Message-ID: <1340187227-25343-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

new_map is allocated according to map_num instead of grp->npins,
if a pin or some pins of a group has NO_PAD_CTL property, the map_num
and the grp->npin are different definitely.

When we set mapping information to the new_map[], we should skip those
pins with NO_PAD_CTL from index, otherwise it is possible the driver
will aceesss to a unallocated region.

Cc: Dong Aisheng <dong.aisheng@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
In the v2, according to dong.aisheng's suggestion, change to use j as index.

 drivers/pinctrl/pinctrl-imx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index dd6d93a..2bafb5d 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -146,7 +146,7 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 	struct pinctrl_map *new_map;
 	struct device_node *parent;
 	int map_num = 1;
-	int i;
+	int i, j;
 
 	/*
 	 * first find the group of this node and check if we need create
@@ -184,13 +184,14 @@ static int imx_dt_node_to_map(struct pinctrl_dev *pctldev,
 
 	/* create config map */
 	new_map++;
-	for (i = 0; i < grp->npins; i++) {
+	for (i = j = 0; i < grp->npins; i++) {
 		if (!(grp->configs[i] & IMX_NO_PAD_CTL)) {
-			new_map[i].type = PIN_MAP_TYPE_CONFIGS_PIN;
-			new_map[i].data.configs.group_or_pin =
+			new_map[j].type = PIN_MAP_TYPE_CONFIGS_PIN;
+			new_map[j].data.configs.group_or_pin =
 					pin_get_name(pctldev, grp->pins[i]);
-			new_map[i].data.configs.configs = &grp->configs[i];
-			new_map[i].data.configs.num_configs = 1;
+			new_map[j].data.configs.configs = &grp->configs[i];
+			new_map[j].data.configs.num_configs = 1;
+			j++;
 		}
 	}
 
-- 
1.7.11
