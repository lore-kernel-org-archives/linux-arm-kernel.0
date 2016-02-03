From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  2 Feb 2016 17:22:00 -0800
Subject: [PATCH] clk: gpio: Make into a platform driver
Message-ID: <1454462520-20787-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_get() for DT based clks already returns EPROBE_DEFER when the
OF clk provider is not present. So having all this code in the
clk provider to return EPROBE_DEFER when the gpio isn't ready yet
can be replaced with a platform driver that doesn't add the clk
provider until the gpio can be requested. Get rid of the
OF_CLK_DECLARE and convert this to a platform driver instead.

Cc: Jyri Sarha <jsarha@ti.com>
Cc: Sergej Sawazki <ce3a@gmx.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jon Nettleton <jon@solid-run.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/clk-gpio.c | 168 ++++++++++++++++---------------------------------
 1 file changed, 54 insertions(+), 114 deletions(-)

diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
index cbbea2985cc9..7252ea7dfe0d 100644
--- a/drivers/clk/clk-gpio.c
+++ b/drivers/clk/clk-gpio.c
@@ -20,6 +20,8 @@
 #include <linux/of_gpio.h>
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/of_device.h>
 
 /**
  * DOC: basic gpio gated clock which can be enabled and disabled
@@ -199,134 +201,72 @@ struct clk *clk_register_gpio_mux(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(clk_register_gpio_mux);
 
-#ifdef CONFIG_OF
-/**
- * clk_register_get() has to be delayed, because -EPROBE_DEFER
- * can not be handled properly at of_clk_init() call time.
- */
-
-struct clk_gpio_delayed_register_data {
-	const char *gpio_name;
-	int num_parents;
-	const char **parent_names;
-	struct device_node *node;
-	struct mutex lock;
-	struct clk *clk;
-	struct clk *(*clk_register_get)(const char *name,
-			const char * const *parent_names, u8 num_parents,
-			unsigned gpio, bool active_low);
-};
-
-static struct clk *of_clk_gpio_delayed_register_get(
-		struct of_phandle_args *clkspec, void *_data)
+static int gpio_clk_driver_probe(struct platform_device *pdev)
 {
-	struct clk_gpio_delayed_register_data *data = _data;
-	struct clk *clk;
-	int gpio;
+	struct device_node *node = pdev->dev.of_node;
+	const char **parent_names, *gpio_name;
+	int num_parents, gpio;
 	enum of_gpio_flags of_flags;
+	struct clk *clk;
+	bool active_low, is_mux;
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 0)
+		return -EINVAL;
 
-	mutex_lock(&data->lock);
+	if (num_parents) {
+		parent_names = devm_kcalloc(&pdev->dev, num_parents,
+					    sizeof(char *), GFP_KERNEL);
+		if (!parent_names)
+			return -ENOMEM;
 
-	if (data->clk) {
-		mutex_unlock(&data->lock);
-		return data->clk;
+		of_clk_parent_fill(node, parent_names, num_parents);
+	} else {
+		parent_names = NULL;
 	}
 
-	gpio = of_get_named_gpio_flags(data->node, data->gpio_name, 0,
-			&of_flags);
+	is_mux = of_device_is_compatible(node, "gpio-mux-clock");
+
+	gpio_name = is_mux ? "select-gpios" : "enable-gpios";
+	gpio = of_get_named_gpio_flags(node, gpio_name, 0, &of_flags);
 	if (gpio < 0) {
-		mutex_unlock(&data->lock);
 		if (gpio == -EPROBE_DEFER)
 			pr_debug("%s: %s: GPIOs not yet available, retry later\n",
-					data->node->name, __func__);
+					node->name, __func__);
 		else
 			pr_err("%s: %s: Can't get '%s' DT property\n",
-					data->node->name, __func__,
-					data->gpio_name);
-		return ERR_PTR(gpio);
+					node->name, __func__,
+					gpio_name);
+		return gpio;
 	}
 
-	clk = data->clk_register_get(data->node->name, data->parent_names,
-			data->num_parents, gpio, of_flags & OF_GPIO_ACTIVE_LOW);
-	if (IS_ERR(clk))
-		goto out;
-
-	data->clk = clk;
-out:
-	mutex_unlock(&data->lock);
-
-	return clk;
-}
-
-static struct clk *of_clk_gpio_gate_delayed_register_get(const char *name,
-		const char * const *parent_names, u8 num_parents,
-		unsigned gpio, bool active_low)
-{
-	return clk_register_gpio_gate(NULL, name, parent_names ?
-			parent_names[0] : NULL, gpio, active_low, 0);
-}
+	active_low = of_flags & OF_GPIO_ACTIVE_LOW;
 
-static struct clk *of_clk_gpio_mux_delayed_register_get(const char *name,
-		const char * const *parent_names, u8 num_parents, unsigned gpio,
-		bool active_low)
-{
-	return clk_register_gpio_mux(NULL, name, parent_names, num_parents,
-			gpio, active_low, 0);
-}
-
-static void __init of_gpio_clk_setup(struct device_node *node,
-		const char *gpio_name,
-		struct clk *(*clk_register_get)(const char *name,
-				const char * const *parent_names,
-				u8 num_parents,
-				unsigned gpio, bool active_low))
-{
-	struct clk_gpio_delayed_register_data *data;
-	const char **parent_names;
-	int i, num_parents;
-
-	num_parents = of_clk_get_parent_count(node);
-	if (num_parents < 0)
-		return;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return;
-
-	if (num_parents) {
-		parent_names = kcalloc(num_parents, sizeof(char *), GFP_KERNEL);
-		if (!parent_names) {
-			kfree(data);
-			return;
-		}
-
-		for (i = 0; i < num_parents; i++)
-			parent_names[i] = of_clk_get_parent_name(node, i);
-	} else {
-		parent_names = NULL;
-	}
-
-	data->num_parents = num_parents;
-	data->parent_names = parent_names;
-	data->node = node;
-	data->gpio_name = gpio_name;
-	data->clk_register_get = clk_register_get;
-	mutex_init(&data->lock);
+	if (is_mux)
+		clk = clk_register_gpio_mux(&pdev->dev, node->name,
+				parent_names, num_parents, gpio, active_low, 0);
+	else
+		clk = clk_register_gpio_gate(&pdev->dev, node->name,
+				parent_names ?  parent_names[0] : NULL, gpio,
+				active_low, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
-	of_clk_add_provider(node, of_clk_gpio_delayed_register_get, data);
+	return of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 
-static void __init of_gpio_gate_clk_setup(struct device_node *node)
-{
-	of_gpio_clk_setup(node, "enable-gpios",
-		of_clk_gpio_gate_delayed_register_get);
-}
-CLK_OF_DECLARE(gpio_gate_clk, "gpio-gate-clock", of_gpio_gate_clk_setup);
-
-void __init of_gpio_mux_clk_setup(struct device_node *node)
-{
-	of_gpio_clk_setup(node, "select-gpios",
-		of_clk_gpio_mux_delayed_register_get);
-}
-CLK_OF_DECLARE(gpio_mux_clk, "gpio-mux-clock", of_gpio_mux_clk_setup);
-#endif
+static const struct of_device_id gpio_clk_match_table[] = {
+	{ .compatible = "gpio-mux-clock" },
+	{ .compatible = "gpio-gate-clock" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpio_clk_match_table);
+
+static struct platform_driver gpio_clk_driver = {
+	.probe		= gpio_clk_driver_probe,
+	.driver		= {
+		.name	= "gpio-clk",
+		.of_match_table = gpio_clk_match_table,
+	},
+};
+builtin_platform_driver(gpio_clk_driver);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
