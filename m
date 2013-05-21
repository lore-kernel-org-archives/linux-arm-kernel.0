From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:23 +0200
Subject: [PATCH v4 02/21] sh-pfc: Add DT support
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support device instantiation through the device tree. The compatible
property is used to select the SoC pinmux information.

Set the gpio_chip device field to the PFC device to enable automatic
GPIO OF support.

Cc: devicetree-discuss at lists.ozlabs.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       | 155 +++++++++++++
 drivers/pinctrl/sh-pfc/core.c                      |  59 ++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   | 242 +++++++++++++++++++++
 3 files changed, 455 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
new file mode 100644
index 0000000..7651a90
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -0,0 +1,155 @@
+* Renesas Pin Function Controller (GPIO and Pin Mux/Config)
+
+The Pin Function Controller (PFC) is a Pin Mux/Config controller. On SH7372,
+SH73A0, R8A73A4 and R8A7740 it also acts as a GPIO controller.
+
+
+Pin Control
+-----------
+
+Required Properties:
+
+  - compatible: should be one of the following.
+    - "renesas,pfc-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible pin-controller.
+    - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
+    - "renesas,pfc-r8a7778": for R8A7778 (R-Mobile M1) compatible pin-controller.
+    - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
+    - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
+    - "renesas,pfc-sh7372": for SH7372 (SH-Mobile AP4) compatible pin-controller.
+    - "renesas,pfc-sh73a0": for SH73A0 (SH-Mobile AG5) compatible pin-controller.
+
+  - reg: Base address and length of each memory resource used by the pin
+    controller hardware module.
+
+Optional properties:
+
+  - #gpio-range-cells: Mandatory when the PFC doesn't handle GPIO, forbidden
+    otherwise. Should be 3.
+
+The PFC node also acts as a container for pin configuration nodes. Please refer
+to pinctrl-bindings.txt in this directory for the definition of the term "pin
+configuration node" and for the common pinctrl bindings used by client devices.
+
+Each pin configuration node represents a desired configuration for a pin, a
+pin group, or a list of pins or pin groups. The configuration can include the
+function to select on those pin(s) and pin configuration parameters (such as
+pull-up and pull-down).
+
+Pin configuration nodes contain pin configuration properties, either directly
+or grouped in child subnodes. Both pin muxing and configuration parameters can
+be grouped in that way and referenced as a single pin configuration node by
+client devices.
+
+A configuration node or subnode must reference at least one pin (through the
+pins or pin groups properties) and contain at least a function or one
+configuration parameter. When the function is present only pin groups can be
+used to reference pins.
+
+All pin configuration nodes and subnodes names are ignored. All of those nodes
+are parsed through phandles and processed purely based on their content.
+
+Pin Configuration Node Properties:
+
+- renesas,pins : An array of strings, each string containing the name of a pin.
+- renesas,groups : An array of strings, each string containing the name of a pin
+  group.
+
+- renesas,function: A string containing the name of the function to mux to the
+  pin group(s) specified by the renesas,groups property
+
+  Valid values for pin, group and function names can be found in the group and
+  function arrays of the PFC data file corresponding to the SoC
+  (drivers/pinctrl/sh-pfc/pfc-*.c)
+
+- renesas,pull-up: An integer representing the pull-up strength to be applied
+  to all pins specified by the renesas,pins and renesas-groups properties.
+  0 disables the pull-up, 1 enables it. Other values should not be used.
+- renesas,pull-down: An integer representing the pull-down strength to be
+  applied to all pins specified by the renesas,pins and renesas-groups
+  properties. 0 disables the pull-down, 1 enables it. Other values should not
+  be used.
+
+
+GPIO
+----
+
+On SH7372, SH73A0, R8A73A4 and R8A7740 the PFC node is also a GPIO controller
+node.
+
+Required Properties:
+
+  - gpio-controller: Marks the device node as a gpio controller.
+
+  - #gpio-cells: Should be 2. The first cell is the pin number and the second
+    cell is used to specify optional parameters as bit flags. Only the GPIO
+    active low flag (bit 0) is currently supported.
+
+The syntax of the gpio specifier used by client nodes should be the following
+with values derived from the SoC user manual.
+
+  <[phandle of the gpio controller node]
+   [pin number within the gpio controller]
+   [flags]>
+
+On other mach-shmobile platforms GPIO is handled by the gpio-rcar driver.
+Please refer to Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+for documentation of the GPIO device tree bindings on those platforms.
+
+
+Examples
+--------
+
+Example 1: SH73A0 (SH-Mobile AG5) pin controller node
+
+	pfc: pfc at e6050000 {
+		compatible = "renesas,pfc-sh73a0";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605801c 0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+Example 2: A GPIO LED node that references a GPIO
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 20 1>; /* Active low */
+		};
+	};
+
+Example 3: KZM-A9-GT (SH-Mobile AG5) default pin state hog and pin control maps
+           for the MMCIF and SCIFA4 devices
+
+	&pfc {
+		pinctrl-0 = <&scifa4_pins>;
+		pinctrl-names = "default";
+
+		mmcif_pins: mmcif {
+			mux {
+				renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
+				renesas,function = "mmc0";
+			};
+			cfg {
+				renesas,groups = "mmc0_data8_0";
+				renesas,pins = "PORT279";
+				renesas,pull-up = <1>;
+			};
+		};
+
+		scifa4_pins: scifa4 {
+			renesas,groups = "scifa4_data", "scifa4_ctrl";
+			renesas,function = "scifa4";
+		};
+	};
+
+Example 4: KZM-A9-GT (SH-Mobile AG5) default pin state for the MMCIF device
+
+	&mmcif {
+		pinctrl-0 = <&mmcif_pins>;
+		pinctrl-names = "default";
+
+		bus-width = <8>;
+		vmmc-supply = <&reg_1p8v>;
+		status = "okay";
+	};
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index ac45084..80d8d74 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -18,6 +18,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -348,13 +349,68 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id sh_pfc_of_table[] = {
+#ifdef CONFIG_PINCTRL_PFC_R8A73A4
+	{
+		.compatible = "renesas,pfc-r8a73a4",
+		.data = &r8a73a4_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7740
+	{
+		.compatible = "renesas,pfc-r8a7740",
+		.data = &r8a7740_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7778
+	{
+		.compatible = "renesas,pfc-r8a7778",
+		.data = &r8a7778_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7779
+	{
+		.compatible = "renesas,pfc-r8a7779",
+		.data = &r8a7779_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
+	{
+		.compatible = "renesas,pfc-r8a7790",
+		.data = &r8a7790_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH7372
+	{
+		.compatible = "renesas,pfc-sh7372",
+		.data = &sh7372_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH73A0
+	{
+		.compatible = "renesas,pfc-sh73a0",
+		.data = &sh73a0_pinmux_info,
+	},
+#endif
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sh_pfc_of_table);
+#endif
+
 static int sh_pfc_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	struct device_node *np = pdev->dev.of_node;
 	const struct sh_pfc_soc_info *info;
 	struct sh_pfc *pfc;
 	int ret;
 
-	info = (void *)pdev->id_entry->driver_data;
+	if (np)
+		info = of_match_device(sh_pfc_of_table, &pdev->dev)->data;
+	else
+		info = platid ? (const void *)platid->driver_data : NULL;
+
 	if (info == NULL)
 		return -ENODEV;
 
@@ -500,6 +556,7 @@ static struct platform_driver sh_pfc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(sh_pfc_of_table),
 	},
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 3492ec9..6a0de2c 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -14,7 +14,9 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -72,11 +74,251 @@ static void sh_pfc_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	seq_printf(s, "%s", DRV_NAME);
 }
 
+static int sh_pfc_map_add_config(struct pinctrl_map *map,
+				 const char *group_or_pin,
+				 enum pinctrl_map_type type,
+				 unsigned long *configs,
+				 unsigned int num_configs)
+{
+	unsigned long *cfgs;
+
+	cfgs = kmemdup(configs, num_configs * sizeof(*cfgs),
+		       GFP_KERNEL);
+	if (cfgs == NULL)
+		return -ENOMEM;
+
+	map->type = type;
+	map->data.configs.group_or_pin = group_or_pin;
+	map->data.configs.configs = cfgs;
+	map->data.configs.num_configs = num_configs;
+
+	return 0;
+}
+
+static int sh_pfc_dt_parse_config(unsigned long **configs,
+				  unsigned int *num_configs,
+				  unsigned long config)
+{
+	unsigned int count = *num_configs + 1;
+	unsigned long *cfgs;
+
+	cfgs = krealloc(*configs, sizeof(*cfgs) * count, GFP_KERNEL);
+	if (cfgs == NULL)
+		return -ENOMEM;
+
+	cfgs[count - 1] = config;
+
+	*configs = cfgs;
+	*num_configs = count;
+
+	return 0;
+}
+
+struct sh_pfc_config_param {
+	const char *name;
+	enum pin_config_param param;
+};
+
+static const struct sh_pfc_config_param sh_pfc_config_params[] = {
+	{ "renesas,pull-up", PIN_CONFIG_BIAS_PULL_UP },
+	{ "renesas,pull-down", PIN_CONFIG_BIAS_PULL_DOWN },
+};
+
+static int sh_pfc_dt_subnode_to_map(struct device *dev, struct device_node *np,
+				    struct pinctrl_map **map,
+				    unsigned int *num_maps, unsigned int *index)
+{
+	struct pinctrl_map *maps = *map;
+	unsigned int nmaps = *num_maps;
+	unsigned int idx = *index;
+	unsigned long *configs = NULL;
+	unsigned int num_configs = 0;
+	const char *function = NULL;
+	struct property *prop;
+	unsigned int num_pins;
+	const char *group;
+	const char *pin;
+	unsigned int i;
+	int ret;
+
+	/* Parse the function and configuration properties. At least a function
+	 * or one configuration must be specified.
+	 */
+	ret = of_property_read_string(np, "renesas,function", &function);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(dev, "Invalid function in DT\n");
+		return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sh_pfc_config_params); ++i) {
+		const struct sh_pfc_config_param *param =
+			&sh_pfc_config_params[i];
+		unsigned long config;
+		u32 val;
+
+		ret = of_property_read_u32(np, param->name, &val);
+		if (!ret) {
+			config = pinconf_to_config_packed(param->param, val);
+			ret = sh_pfc_dt_parse_config(&configs, &num_configs,
+						     config);
+			if (ret < 0)
+				goto done;
+		} else if (ret != -EINVAL) {
+			dev_err(dev, "Could not parse property %s\n",
+				param->name);
+		}
+	}
+
+	if (!function && num_configs == 0) {
+		dev_err(dev,
+			"DT node must contain at least a function or config\n");
+		goto done;
+	}
+
+	/* Count the number of pins and groups and reallocate mappings. */
+	ret = of_property_count_strings(np, "renesas,pins");
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(dev, "Invalid pins list in DT\n");
+		goto done;
+	}
+	num_pins = ret;
+
+	if (configs)
+		nmaps += ret;
+
+	ret = of_property_count_strings(np, "renesas,groups");
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(dev, "Invalid pin groups list in DT\n");
+		goto done;
+	}
+	num_pins += ret;
+
+	if (function)
+		nmaps += ret;
+	if (configs)
+		nmaps += ret;
+
+	if (!num_pins) {
+		dev_err(dev, "No pin or group provided in DT node\n");
+		ret = -ENODEV;
+		goto done;
+	}
+
+	maps = krealloc(maps, sizeof(*maps) * nmaps, GFP_KERNEL);
+	if (maps == NULL) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	*map = maps;
+	*num_maps = nmaps;
+
+	/* Iterate over pins and groups and create the mappings. */
+	of_property_for_each_string(np, "renesas,groups", prop, group) {
+		if (function) {
+			maps[idx].type = PIN_MAP_TYPE_MUX_GROUP;
+			maps[idx].data.mux.group = group;
+			maps[idx].data.mux.function = function;
+			idx++;
+		}
+
+		if (configs) {
+			ret = sh_pfc_map_add_config(&maps[idx], group,
+						    PIN_MAP_TYPE_CONFIGS_GROUP,
+						    configs, num_configs);
+			if (ret < 0)
+				goto done;
+
+			idx++;
+		}
+	}
+
+	if (!configs) {
+		ret = 0;
+		goto done;
+	}
+
+	of_property_for_each_string(np, "renesas,pins", prop, pin) {
+		ret = sh_pfc_map_add_config(&maps[idx], pin,
+					    PIN_MAP_TYPE_CONFIGS_PIN,
+					    configs, num_configs);
+		if (ret < 0)
+			goto done;
+
+		idx++;
+	}
+
+done:
+	*index = idx;
+	kfree(configs);
+	return ret;
+}
+
+static void sh_pfc_dt_free_map(struct pinctrl_dev *pctldev,
+			       struct pinctrl_map *map, unsigned num_maps)
+{
+	unsigned int i;
+
+	if (map == NULL)
+		return;
+
+	for (i = 0; i < num_maps; ++i) {
+		if (map[i].type == PIN_MAP_TYPE_CONFIGS_GROUP ||
+		    map[i].type == PIN_MAP_TYPE_CONFIGS_PIN)
+			kfree(map[i].data.configs.configs);
+	}
+
+	kfree(map);
+}
+
+static int sh_pfc_dt_node_to_map(struct pinctrl_dev *pctldev,
+				 struct device_node *np,
+				 struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct device *dev = pmx->pfc->dev;
+	struct device_node *child;
+	unsigned int index;
+	int ret;
+
+	*map = NULL;
+	*num_maps = 0;
+	index = 0;
+
+	for_each_child_of_node(np, child) {
+		ret = sh_pfc_dt_subnode_to_map(dev, child, map, num_maps,
+					       &index);
+		if (ret < 0)
+			goto done;
+	}
+
+	/* If no mapping has been found in child nodes try the config node. */
+	if (*num_maps == 0) {
+		ret = sh_pfc_dt_subnode_to_map(dev, np, map, num_maps, &index);
+		if (ret < 0)
+			goto done;
+	}
+
+	if (*num_maps)
+		return 0;
+
+	dev_err(dev, "no mapping found in node %s\n", np->full_name);
+	ret = -EINVAL;
+
+done:
+	if (ret < 0)
+		sh_pfc_dt_free_map(pctldev, *map, *num_maps);
+
+	return ret;
+}
+
 static const struct pinctrl_ops sh_pfc_pinctrl_ops = {
 	.get_groups_count	= sh_pfc_get_groups_count,
 	.get_group_name		= sh_pfc_get_group_name,
 	.get_group_pins		= sh_pfc_get_group_pins,
 	.pin_dbg_show		= sh_pfc_pin_dbg_show,
+	.dt_node_to_map		= sh_pfc_dt_node_to_map,
+	.dt_free_map		= sh_pfc_dt_free_map,
 };
 
 static int sh_pfc_get_functions_count(struct pinctrl_dev *pctldev)
-- 
1.8.1.5
