From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 10 Sep 2014 11:15:51 +0200
Subject: [PATCH] pinctrl: berlin: fix the dt_free_map function
Message-ID: <1410340551-24023-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The berlin_pinctrl_dt_free_map function tries to free memory
allocated and handled by the of subsystem. This is wrong and
already handled by pinctrl_dt_free_maps() which calls
of_node_put().

This patch fixes the Berlin pinctrl way of freeing its maps,
avoiding a kernel BUG(), by using the common
pinctrl_utils_dt_free_map function instead.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/berlin.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berlin.c
index 86db2235ab00..6cd5e928fc7f 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -99,30 +99,11 @@ static int berlin_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrl_dev,
 	return 0;
 }
 
-static void berlin_pinctrl_dt_free_map(struct pinctrl_dev *pctrl_dev,
-				       struct pinctrl_map *map,
-				       unsigned nmaps)
-{
-	int i;
-
-	for (i = 0; i < nmaps; i++) {
-		if (map[i].type == PIN_MAP_TYPE_MUX_GROUP) {
-			kfree(map[i].data.mux.group);
-
-			/* a function can be applied to multiple groups */
-			if (i == 0)
-				kfree(map[i].data.mux.function);
-		}
-	}
-
-	kfree(map);
-}
-
 static const struct pinctrl_ops berlin_pinctrl_ops = {
 	.get_groups_count	= &berlin_pinctrl_get_group_count,
 	.get_group_name		= &berlin_pinctrl_get_group_name,
 	.dt_node_to_map		= &berlin_pinctrl_dt_node_to_map,
-	.dt_free_map		= &berlin_pinctrl_dt_free_map,
+	.dt_free_map		= &pinctrl_utils_dt_free_map,
 };
 
 static int berlin_pinmux_get_functions_count(struct pinctrl_dev *pctrl_dev)
-- 
1.9.1
