From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 15 Nov 2012 16:36:32 +0800
Subject: [PATCH v5 03/10] pinctrl: append method of lookup pinctrl map
In-Reply-To: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1352968600-15345-4-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pinctrl driver gets pinctrl map if both group and map type is specified.
In pinctrl-single driver, each pin group is defined in DT file. The pinconf
information is also defined in each pin group.

pinctrl-single driver could store those mask/shift/value information
into pinctrl map. pinconf_get()/pinconf_set() and
pinconf_group_get()/pinconf_group_set() could get those information from
pinctrl map.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/core.c           |   24 ++++++++++++++++++++++++
 include/linux/pinctrl/consumer.h |    4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 2e39c04..0d36270 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -839,6 +839,30 @@ int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *state)
 }
 EXPORT_SYMBOL_GPL(pinctrl_select_state);
 
+const struct pinctrl_map *pinctrl_lookup_map(struct pinctrl *p,
+					     const char *name, unsigned type)
+{
+	struct pinctrl_maps *maps_node;
+	struct pinctrl_map const *map;
+	int i;
+
+	for_each_maps(maps_node, i, map) {
+		/* Map must be for this device */
+		if (strcmp(map->ctrl_dev_name, dev_name(p->dev)))
+			continue;
+		if (map->type != type)
+			continue;
+		if (map->type == PIN_MAP_TYPE_MUX_GROUP)
+			if (!strcmp(map->data.mux.group, name))
+				return map;
+		if (map->type == PIN_MAP_TYPE_CONFIGS_GROUP)
+			if (!strcmp(map->data.configs.group_or_pin, name))
+				return map;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pinctrl_lookup_map);
+
 static void devm_pinctrl_release(struct device *dev, void *res)
 {
 	pinctrl_put(*(struct pinctrl **)res);
diff --git a/include/linux/pinctrl/consumer.h b/include/linux/pinctrl/consumer.h
index 4aad3ce..2687515 100644
--- a/include/linux/pinctrl/consumer.h
+++ b/include/linux/pinctrl/consumer.h
@@ -36,6 +36,10 @@ extern struct pinctrl_state * __must_check pinctrl_lookup_state(
 							struct pinctrl *p,
 							const char *name);
 extern int pinctrl_select_state(struct pinctrl *p, struct pinctrl_state *s);
+extern const struct pinctrl_map * __must_check pinctrl_lookup_map(
+						struct pinctrl *p,
+						const char *name,
+						unsigned type);
 
 extern struct pinctrl * __must_check devm_pinctrl_get(struct device *dev);
 extern void devm_pinctrl_put(struct pinctrl *p);
-- 
1.7.10.4
