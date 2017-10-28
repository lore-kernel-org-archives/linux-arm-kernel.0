From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 28 Oct 2017 15:37:18 +0200
Subject: [PATCH 3/4] pinctrl: gemini: Use generic DT parser
In-Reply-To: <20171028133719.27528-1-linus.walleij@linaro.org>
References: <20171028133719.27528-1-linus.walleij@linaro.org>
Message-ID: <20171028133719.27528-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can just use the generic Device Tree parser code
in this driver and save some code.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/Kconfig          |  1 +
 drivers/pinctrl/pinctrl-gemini.c | 66 +++-------------------------------------
 2 files changed, 5 insertions(+), 62 deletions(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 1778cf4f81c7..98b2d5dcbda7 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -151,6 +151,7 @@ config PINCTRL_GEMINI
 	depends on ARCH_GEMINI
 	default ARCH_GEMINI
 	select PINMUX
+	select GENERIC_PINCONF
 	select MFD_SYSCON
 
 config PINCTRL_MCP23S08
diff --git a/drivers/pinctrl/pinctrl-gemini.c b/drivers/pinctrl/pinctrl-gemini.c
index 7ffd768c0e02..18fb5ff8a442 100644
--- a/drivers/pinctrl/pinctrl-gemini.c
+++ b/drivers/pinctrl/pinctrl-gemini.c
@@ -13,6 +13,8 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/regmap.h>
@@ -1918,73 +1920,13 @@ static void gemini_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	seq_printf(s, " " DRIVER_NAME);
 }
 
-static int gemini_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
-					    struct device_node *np,
-					    struct pinctrl_map **map,
-					    unsigned int *reserved_maps,
-					    unsigned int *num_maps)
-{
-	int ret;
-	const char *function = NULL;
-	const char *group;
-	struct property *prop;
-
-	ret = of_property_read_string(np, "function", &function);
-	if (ret < 0)
-		return ret;
-
-	ret = of_property_count_strings(np, "groups");
-	if (ret < 0)
-		return ret;
-
-	ret = pinctrl_utils_reserve_map(pctldev, map, reserved_maps,
-					num_maps, ret);
-	if (ret < 0)
-		return ret;
-
-	of_property_for_each_string(np, "groups", prop, group) {
-		ret = pinctrl_utils_add_map_mux(pctldev, map, reserved_maps,
-						num_maps, group, function);
-		if (ret < 0)
-			return ret;
-		pr_debug("ADDED FUNCTION %s <-> GROUP %s\n",
-			 function, group);
-	}
-
-	return 0;
-}
-
-static int gemini_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
-				struct device_node *np_config,
-				struct pinctrl_map **map,
-				unsigned int *num_maps)
-{
-	unsigned int reserved_maps = 0;
-	struct device_node *np;
-	int ret;
-
-	*map = NULL;
-	*num_maps = 0;
-
-	for_each_child_of_node(np_config, np) {
-		ret = gemini_pinctrl_dt_subnode_to_map(pctldev, np, map,
-					&reserved_maps, num_maps);
-		if (ret < 0) {
-			pinctrl_utils_free_map(pctldev, *map, *num_maps);
-			return ret;
-		}
-	}
-
-	return 0;
-};
-
 static const struct pinctrl_ops gemini_pctrl_ops = {
 	.get_groups_count = gemini_get_groups_count,
 	.get_group_name = gemini_get_group_name,
 	.get_group_pins = gemini_get_group_pins,
 	.pin_dbg_show = gemini_pin_dbg_show,
-	.dt_node_to_map = gemini_pinctrl_dt_node_to_map,
-	.dt_free_map = pinctrl_utils_free_map,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_group,
+	.dt_free_map = pinconf_generic_dt_free_map,
 };
 
 /**
-- 
2.13.6
