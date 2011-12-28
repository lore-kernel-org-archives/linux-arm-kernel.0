From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Dec 2011 22:19:29 -0800
Subject: [PATCH v2 1/2] Input: tegra-kbc - add device tree bindings
In-Reply-To: <1325053170-6984-1-git-send-email-olof@lixom.net>
References: <1325053170-6984-1-git-send-email-olof@lixom.net>
Message-ID: <1325053170-6984-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a simple device tree binding to the tegra keyboard controller.

Also, mark the default keymap as __devinitdata since it is not referenced
after boot, and shorten the name to not have to avoid line wraps.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 .../devicetree/bindings/input/tegra-kbc.txt        |   18 +++++
 drivers/input/keyboard/tegra-kbc.c                 |   70 ++++++++++++++++++--
 2 files changed, 83 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/tegra-kbc.txt

diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt b/Documentation/devicetree/bindings/input/tegra-kbc.txt
new file mode 100644
index 0000000..a7c1d40
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/tegra-kbc.txt
@@ -0,0 +1,18 @@
+* Tegra keyboard controller
+
+Required properties:
+- compatible : "nvidia,tegra20-kbc"
+
+Optional properties:
+- debounce-delay: delay in milliseconds per row scan for debouncing
+- repeat-delay: delay in milliseconds before repeat starts
+- ghost-filter : enable ghost filtering for this device
+- wakeup-source : configure keyboard as a wakeup source for suspend/resume
+
+Example:
+
+keyboard: keyboard {
+	compatible = "nvidia,tegra20-kbc";
+	reg = <0x7000e200 0x100>;
+	ghost-filter;
+};
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index cf3228b..4ce6cc8 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/clk.h>
 #include <linux/slab.h>
 #include <mach/clk.h>
@@ -82,7 +83,7 @@ struct tegra_kbc {
 	struct clk *clk;
 };
 
-static const u32 tegra_kbc_default_keymap[] = {
+static const u32 default_keymap[] __devinitdata = {
 	KEY(0, 2, KEY_W),
 	KEY(0, 3, KEY_S),
 	KEY(0, 4, KEY_A),
@@ -217,9 +218,9 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(31, 4, KEY_HELP),
 };
 
-static const struct matrix_keymap_data tegra_kbc_default_keymap_data = {
-	.keymap		= tegra_kbc_default_keymap,
-	.keymap_size	= ARRAY_SIZE(tegra_kbc_default_keymap),
+static const struct matrix_keymap_data default_keymap_data __devinitdata = {
+	.keymap		= default_keymap,
+	.keymap_size	= ARRAY_SIZE(default_keymap),
 };
 
 static void tegra_kbc_report_released_keys(struct input_dev *input,
@@ -576,6 +577,55 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 	return true;
 }
 
+#ifdef CONFIG_OF
+static struct tegra_kbc_platform_data * __devinit tegra_kbc_dt_parse_pdata(
+	struct platform_device *pdev)
+{
+	struct tegra_kbc_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+	int i;
+	u32 prop;
+
+	if (!np)
+		return NULL;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+
+	if (!of_property_read_u32(np, "debounce-delay", &prop))
+		pdata->debounce_cnt = prop;
+
+	if (!of_property_read_u32(np, "repeat-delay", &prop))
+		pdata->repeat_cnt = prop;
+
+	if (of_find_property(np, "needs-ghost-filter", NULL))
+		pdata->use_ghost_filter = true;
+
+	if (of_find_property(np, "wakeup-source", NULL))
+		pdata->wakeup = true;
+
+	/* All currently known keymaps with device tree support use the same
+	 * pin_cfg, so set it up here.
+	 */
+	for (i = 0; i < KBC_MAX_ROW; i++) {
+		pdata->pin_cfg[i].num = i;
+		pdata->pin_cfg[i].is_row = true;
+	}
+	
+	for (i = 0; i < KBC_MAX_COL; i++) {
+		pdata->pin_cfg[KBC_MAX_ROW + i].num = i;
+		pdata->pin_cfg[KBC_MAX_ROW + i].is_row = false;
+	}
+
+	return pdata;
+}
+#else
+static inline struct tegra_kbc_platform_data *tegra_kbc_dt_parse_pdata(
+	struct platform_device *pdev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 {
 	const struct tegra_kbc_platform_data *pdata = pdev->dev.platform_data;
@@ -590,6 +640,9 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	unsigned int scan_time_rows;
 
 	if (!pdata)
+		pdata = tegra_kbc_dt_parse_pdata(pdev);
+
+	if (!pdata)
 		return -EINVAL;
 
 	if (!tegra_kbc_check_pin_cfg(pdata, &pdev->dev, &num_rows))
@@ -671,7 +724,7 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 
 	kbc->use_fn_map = pdata->use_fn_map;
 	kbc->use_ghost_filter = pdata->use_ghost_filter;
-	keymap_data = pdata->keymap_data ?: &tegra_kbc_default_keymap_data;
+	keymap_data = pdata->keymap_data ?: &default_keymap_data;
 	matrix_keypad_build_keymap(keymap_data, KBC_ROW_SHIFT,
 				   input_dev->keycode, input_dev->keybit);
 
@@ -793,6 +846,12 @@ static int tegra_kbc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(tegra_kbc_pm_ops, tegra_kbc_suspend, tegra_kbc_resume);
 
+static const struct of_device_id tegra_kbc_of_match[] = {
+	{ .compatible = "nvidia,tegra20-kbc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tegra_kbc_of_match);
+
 static struct platform_driver tegra_kbc_driver = {
 	.probe		= tegra_kbc_probe,
 	.remove		= __devexit_p(tegra_kbc_remove),
@@ -800,6 +859,7 @@ static struct platform_driver tegra_kbc_driver = {
 		.name	= "tegra-kbc",
 		.owner  = THIS_MODULE,
 		.pm	= &tegra_kbc_pm_ops,
+		.of_match_table = tegra_kbc_of_match,
 	},
 };
 
-- 
1.7.8.GIT
