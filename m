From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 27 Dec 2011 22:48:32 -0800
Subject: [PATCH v2 1/2] Input: tegra-kbc - add device tree bindings
In-Reply-To: <1325053170-6984-2-git-send-email-olof@lixom.net>
References: <1325053170-6984-1-git-send-email-olof@lixom.net>
 <1325053170-6984-2-git-send-email-olof@lixom.net>
Message-ID: <20111228064832.GA29273@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Tue, Dec 27, 2011 at 10:19:29PM -0800, Olof Johansson wrote:
> This adds a simple device tree binding to the tegra keyboard controller.
> 
> Also, mark the default keymap as __devinitdata since it is not referenced
> after boot, and shorten the name to not have to avoid line wraps.

No, let's keep the names prefixed to match the rest of the driver(s).

> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);

Error handling is missing. I also dislike devm_* facilities as it causes
inconsistencies in the way we handle releasing of resources: some of
them will be released automatically while others need t be released
manually. I prefer having consistent model.

Does the patch below still work for you?

Thanks.

-- 
Dmitry

Input: tegra-kbc - add device tree bindings

From: Olof Johansson <olof@lixom.net>

This adds a simple device tree binding to the tegra keyboard controller.

Also, mark the default keymap as __devinitdata since it is not referenced
after boot.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 .../devicetree/bindings/input/tegra-kbc.txt        |   18 ++++
 drivers/input/keyboard/tegra-kbc.c                 |   92 ++++++++++++++++++--
 2 files changed, 102 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/tegra-kbc.txt


diff --git a/Documentation/devicetree/bindings/input/tegra-kbc.txt b/Documentation/devicetree/bindings/input/tegra-kbc.txt
new file mode 100644
index 0000000..5ecfa99
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/tegra-kbc.txt
@@ -0,0 +1,18 @@
+* Tegra keyboard controller
+
+Required properties:
+- compatible: "nvidia,tegra20-kbc"
+
+Optional properties:
+- debounce-delay: delay in milliseconds per row scan for debouncing
+- repeat-delay: delay in milliseconds before repeat starts
+- ghost-filter: enable ghost filtering for this device
+- wakeup-source: configure keyboard as a wakeup source for suspend/resume
+
+Example:
+
+keyboard: keyboard {
+	compatible = "nvidia,tegra20-kbc";
+	reg = <0x7000e200 0x100>;
+	ghost-filter;
+};
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 08d02f2..b77725d 100644
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
+static const u32 tegra_kbc_default_keymap[] __devinitdata = {
 	KEY(0, 2, KEY_W),
 	KEY(0, 3, KEY_S),
 	KEY(0, 4, KEY_A),
@@ -217,7 +218,8 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(31, 4, KEY_HELP),
 };
 
-static const struct matrix_keymap_data tegra_kbc_default_keymap_data = {
+static const
+struct matrix_keymap_data tegra_kbc_default_keymap_data __devinitdata = {
 	.keymap		= tegra_kbc_default_keymap,
 	.keymap_size	= ARRAY_SIZE(tegra_kbc_default_keymap),
 };
@@ -576,6 +578,56 @@ tegra_kbc_check_pin_cfg(const struct tegra_kbc_platform_data *pdata,
 	return true;
 }
 
+#ifdef CONFIG_OF
+static struct tegra_kbc_platform_data * __devinit
+tegra_kbc_dt_parse_pdata(struct platform_device *pdev)
+{
+	struct tegra_kbc_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+
+	if (!np)
+		return NULL;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
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
+	/*
+	 * All currently known keymaps with device tree support use the same
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
@@ -590,21 +642,28 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	unsigned int scan_time_rows;
 
 	if (!pdata)
-		return -EINVAL;
+		pdata = tegra_kbc_dt_parse_pdata(pdev);
 
-	if (!tegra_kbc_check_pin_cfg(pdata, &pdev->dev, &num_rows))
+	if (!pdata)
 		return -EINVAL;
 
+	if (!tegra_kbc_check_pin_cfg(pdata, &pdev->dev, &num_rows)) {
+		err = -EINVAL;
+		goto err_free_pdata;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(&pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
+		err = -ENXIO;
+		goto err_free_pdata;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
-		return -ENXIO;
+		err = -ENXIO;
+		goto err_free_pdata;
 	}
 
 	kbc = kzalloc(sizeof(*kbc), GFP_KERNEL);
@@ -706,6 +765,9 @@ err_free_mem_region:
 err_free_mem:
 	input_free_device(input_dev);
 	kfree(kbc);
+err_free_pdata:
+	if (!pdev->dev.platform_data)
+		kfree(pdata);
 
 	return err;
 }
@@ -715,6 +777,8 @@ static int __devexit tegra_kbc_remove(struct platform_device *pdev)
 	struct tegra_kbc *kbc = platform_get_drvdata(pdev);
 	struct resource *res;
 
+	platform_set_drvdata(pdev, NULL);
+
 	free_irq(kbc->irq, pdev);
 	clk_put(kbc->clk);
 
@@ -723,9 +787,14 @@ static int __devexit tegra_kbc_remove(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
-	kfree(kbc);
+	/*
+	 * If we do not have platform data attached to the device we
+	 * allocated it ourselves and thus need to free it.
+	 */
+	if (!pdev->dev.platform_data)
+		kfree(kbc->pdata);
 
-	platform_set_drvdata(pdev, NULL);
+	kfree(kbc);
 
 	return 0;
 }
@@ -793,6 +862,12 @@ static int tegra_kbc_resume(struct device *dev)
 
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
@@ -800,6 +875,7 @@ static struct platform_driver tegra_kbc_driver = {
 		.name	= "tegra-kbc",
 		.owner  = THIS_MODULE,
 		.pm	= &tegra_kbc_pm_ops,
+		.of_match_table = tegra_kbc_of_match,
 	},
 };
 module_platform_driver(tegra_kbc_driver);
