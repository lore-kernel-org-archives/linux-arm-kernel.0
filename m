From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Nov 2016 10:35:10 +0800
Subject: [PATCH] pinctrl: sunxi: Free configs in pinctrl_map only if it is a
 config map
Message-ID: <20161111023510.14146-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the recently refactored sunxi pinctrl library, we are only allocating
one set of pin configs for each pinmux setting node. When the pinctrl_map
structure is freed, the pin configs should also be freed. However the
code assumed the first map would contain the configs, which actually
never happens, as the mux function map gets added first.

The proper way to do this is to look through all the maps and free the
first one whose type is actually PIN_MAP_TYPE_CONFIGS_GROUP.

Also slightly expand the comment explaining this.

Fixes: f233dbca6227 ("pinctrl: sunxi: Rework the pin config building code")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index ebe2c73d211e..e199d95af8c0 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -408,8 +408,21 @@ static void sunxi_pctrl_dt_free_map(struct pinctrl_dev *pctldev,
 				    struct pinctrl_map *map,
 				    unsigned num_maps)
 {
-	/* All the maps have the same pin config, free only the first one */
-	kfree(map[0].data.configs.configs);
+	int i;
+
+	/* pin config is never in the first map */
+	for (i = 1; i < num_maps; i++) {
+		if (map[i].type != PIN_MAP_TYPE_CONFIGS_GROUP)
+			continue;
+
+		/*
+		 * All the maps share the same pin config,
+		 * free only the first one we find.
+		 */
+		kfree(map[i].data.configs.configs);
+		break;
+	}
+
 	kfree(map);
 }
 
-- 
2.10.2
