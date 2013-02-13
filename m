From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:29:13 +0900
Subject: [PATCH 1/9] sh-pfc: Add OF support
In-Reply-To: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
References: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360726161-16072-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Support device instantiation through the device tree. The compatible
property is used to select the SoC pinmux information.

Set the gpio_chip device field to the PFC device to enable automatic
GPIO OF support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: devicetree-discuss at lists.ozlabs.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   77 ++++++++++++++++++++
 drivers/pinctrl/sh-pfc/core.c                      |   62 +++++++++++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |   54 ++++++++++++++
 3 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
new file mode 100644
index 0000000..77752c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -0,0 +1,77 @@
+* Renesas GPIO and Pin Mux/Config controller
+
+Required Properties:
+- compatible: should be one of the following.
+  - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
+  - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
+  - "renesas,pfc-sh7372": for SH7372 (SH-Mobile AP4) compatible pin-controller.
+  - "renesas,pfc-sh73a0": for SH73A0 (SH-Mobile AG5) compatible pin-controller.
+
+- reg: Base address and length of each memory resource used by the pin
+  controller hardware module.
+
+- gpio-controller: Marks the device node as a gpio controller.
+
+- #gpio-cells: Should be 2. The first cell is the pin number and the second cell
+  is used to specify optional parameters as bit flags. Only the GPIO active low
+  flag (bit 0) is currently supported.
+
+
+The PFC node also acts as a container for pin control maps represented as
+subnodes. Each subnode contains a function name and one or more pin or pin group
+name. The subnode names are ignored, all subnodes are parsed through phandles
+and processed purely based on their content.
+
+Required Subnode Properties:
+- renesas,pins : An array of strings. Each string contains the name of a pin or
+  pin group.
+- renesas,function: A string containing the name of the function to mux to the
+  pin or pin group.
+
+  Valid values for group and function names can be found in the group and
+  function arrays of the PFC data file corresponding to the SoC
+  (drivers/pinctrl/spear/pfc-*.c)
+
+Please refer to pinctrl-bindings.txt in this directory for details of the common
+pinctrl bindings used by client devices.
+
+
+The syntax of the gpio specifier used by client nodes should be the following
+with values derived from the SoC user manual.
+
+  <[phandle of the gpio controller node]
+   [pin number within the gpio controller]
+   [flags and pull up/down]>
+
+
+Example 1: SH73A0 (SH-Mobile AG5) pin controller node
+
+	gpio: pfc at e6050000 {
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
+			gpios = <&gpio 20 1>; /* Active low */
+		};
+	};
+
+Example 3: KZM-A9-GT (SH-Mobile AG5) default pin state and pin control maps
+           for the LCD device
+
+	&gpio {
+		pinctrl-0 = <&lcd_pins>;
+		pinctrl-names = "default";
+
+		lcd_pins: pfc_lcd_pins {
+			renesas,pins = "lcd_data24", "lcd_sync";
+			renesas,function = "lcd";
+		};
+	};
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 912b579..d0e8e77 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -19,6 +19,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -510,8 +511,55 @@ int sh_pfc_config_gpio(struct sh_pfc *pfc, unsigned gpio, int pinmux_type,
 	return sh_pfc_config_mux(pfc, mark, pinmux_type, cfg_mode);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id sh_pfc_of_table[] = {
+#ifdef CONFIG_PINCTRL_PFC_R8A7740
+	{
+		.compatible = "renesas,pfc-r8a7740",
+		.data = &r8a7740_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7779
+	{
+		.compatible = "renesas,pfc-r8a7779",
+		.data = &r8a7779_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH7367
+	{
+		.compatible = "renesas,pfc-sh7367",
+		.data = &sh7367_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH7372
+	{
+		.compatible = "renesas,pfc-sh7372",
+		.data = &sh7372_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH7377
+	{
+		.compatible = "renesas,pfc-sh7377",
+		.data = &sh7377_pinmux_info,
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
+#ifdef CONFIG_OF
+	struct device_node *np = pdev->dev.of_node;
+#endif
 	struct sh_pfc_soc_info *info;
 	struct sh_pfc *pfc;
 	int ret;
@@ -521,8 +569,15 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	 */
 	BUILD_BUG_ON(PINMUX_FLAG_TYPE > ((1 << PINMUX_FLAG_DBIT_SHIFT) - 1));
 
-	info = pdev->id_entry->driver_data
-	      ? (void *)pdev->id_entry->driver_data : pdev->dev.platform_data;
+	if (platid)
+		info = (void *)platid->driver_data;
+#ifdef CONFIG_OF
+	else if (np)
+		info = (void *)of_match_device(sh_pfc_of_table, &pdev->dev)->data;
+#endif
+	else
+		info = pdev->dev.platform_data;
+
 	if (info == NULL)
 		return -ENODEV;
 
@@ -646,6 +701,9 @@ static struct platform_driver sh_pfc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = sh_pfc_of_table,
+#endif
 	},
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 6ee4105..78b78d2 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -15,7 +15,9 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -65,11 +67,63 @@ static void sh_pfc_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
 	seq_printf(s, "%s", DRV_NAME);
 }
 
+static int sh_pfc_dt_node_to_map(struct pinctrl_dev *pctldev,
+				 struct device_node *np,
+				 struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct pinctrl_map *maps;
+	struct property *prop;
+	unsigned int index = 0;
+	const char *function;
+	const char *group;
+	int ret;
+
+	ret = of_property_read_string(np, "renesas,function", &function);
+	if (ret < 0) {
+		dev_err(pmx->pfc->dev, "No function provided in DT\n");
+		return ret;
+	}
+
+	ret = of_property_count_strings(np, "renesas,pins");
+	if (ret < 0)
+		return ret;
+
+	if (!ret) {
+		dev_err(pmx->pfc->dev, "No pin(group) provided in DT node\n");
+		return -ENODEV;
+	}
+
+	maps = kzalloc(sizeof(*maps) * ret, GFP_KERNEL);
+	if (maps == NULL)
+		return -ENOMEM;
+
+	of_property_for_each_string(np, "renesas,pins", prop, group) {
+		maps[index].type = PIN_MAP_TYPE_MUX_GROUP;
+		maps[index].data.mux.group = group;
+		maps[index].data.mux.function = function;
+		index++;
+	}
+
+	*map = maps;
+	*num_maps = index;
+
+	return 0;
+}
+
+static void sh_pfc_dt_free_map(struct pinctrl_dev *pctldev,
+			       struct pinctrl_map *map, unsigned num_maps)
+{
+	kfree(map);
+}
+
 static struct pinctrl_ops sh_pfc_pinctrl_ops = {
 	.get_groups_count	= sh_pfc_get_groups_count,
 	.get_group_name		= sh_pfc_get_group_name,
 	.get_group_pins		= sh_pfc_get_group_pins,
 	.pin_dbg_show		= sh_pfc_pin_dbg_show,
+	.dt_node_to_map		= sh_pfc_dt_node_to_map,
+	.dt_free_map		= sh_pfc_dt_free_map,
 };
 
 static int sh_pfc_get_functions_count(struct pinctrl_dev *pctldev)
-- 
1.7.10.4
