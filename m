From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 May 2012 13:56:14 +0800
Subject: [PATCH] pinctrl: mxs: add gpio range support
Message-ID: <1337061374-24823-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs pins are organized in banks and each bank contains 32 pins.
i.MX23 has 4 banks in total, and every pin in the first 3 banks has
gpio function available.  i.MX28 has 7 banks and the first 5 banks
are capable of gpio mode.

As the gpio base is runtime determined for each port when booting
from device tree, the .base of struct pinctrl_gpio_range can only be
initialized with a offset local to the port, and have to plus gpio base
of the port at runtime.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/pinctrl/pinctrl-imx23.c |   12 ++++++++
 drivers/pinctrl/pinctrl-imx28.c |   19 +++++++++++++
 drivers/pinctrl/pinctrl-mxs.c   |   55 +++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-mxs.h   |    2 +
 4 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c
index 75d3eff..695b64b 100644
--- a/drivers/pinctrl/pinctrl-imx23.c
+++ b/drivers/pinctrl/pinctrl-imx23.c
@@ -261,10 +261,22 @@ static struct mxs_regs imx23_regs = {
 	.pull = 0x400,
 };
 
+/*
+ * The .base is initialized as the gpio offset local to the port, and will
+ * have gpio base of the port added at runtime.
+ */
+static struct pinctrl_gpio_range imx23_gpio_ranges[] = {
+	{ .name = "gpio", .id = 0, .base = 0, .pin_base = 0,  .npins = 32, },
+	{ .name = "gpio", .id = 1, .base = 0, .pin_base = 32, .npins = 31, },
+	{ .name = "gpio", .id = 2, .base = 0, .pin_base = 64, .npins = 32, },
+};
+
 static struct mxs_pinctrl_soc_data imx23_pinctrl_data = {
 	.regs = &imx23_regs,
 	.pins = imx23_pins,
 	.npins = ARRAY_SIZE(imx23_pins),
+	.gpio_ranges = imx23_gpio_ranges,
+	.gpio_num_ranges = ARRAY_SIZE(imx23_gpio_ranges),
 };
 
 static int __devinit imx23_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/pinctrl-imx28.c b/drivers/pinctrl/pinctrl-imx28.c
index b973026..c9a8e67 100644
--- a/drivers/pinctrl/pinctrl-imx28.c
+++ b/drivers/pinctrl/pinctrl-imx28.c
@@ -377,10 +377,29 @@ static struct mxs_regs imx28_regs = {
 	.pull = 0x600,
 };
 
+/*
+ * The .base is initialized as the gpio offset local to the port, and will
+ * have gpio base of the port added at runtime.
+ */
+static struct pinctrl_gpio_range imx28_gpio_ranges[] = {
+	{ .name = "gpio", .id = 0, .base = 0,  .pin_base = 0,   .npins = 8, },
+	{ .name = "gpio", .id = 0, .base = 16, .pin_base = 16,  .npins = 13, },
+	{ .name = "gpio", .id = 1, .base = 0,  .pin_base = 32,  .npins = 32, },
+	{ .name = "gpio", .id = 2, .base = 0,  .pin_base = 64,  .npins = 11, },
+	{ .name = "gpio", .id = 2, .base = 12, .pin_base = 76,  .npins = 10, },
+	{ .name = "gpio", .id = 2, .base = 24, .pin_base = 88,  .npins = 4, },
+	{ .name = "gpio", .id = 3, .base = 0,  .pin_base = 96,  .npins = 19, },
+	{ .name = "gpio", .id = 3, .base = 20, .pin_base = 116, .npins = 11, },
+	{ .name = "gpio", .id = 4, .base = 0,  .pin_base = 128, .npins = 17, },
+	{ .name = "gpio", .id = 4, .base = 20, .pin_base = 148, .npins = 1, },
+};
+
 static struct mxs_pinctrl_soc_data imx28_pinctrl_data = {
 	.regs = &imx28_regs,
 	.pins = imx28_pins,
 	.npins = ARRAY_SIZE(imx28_pins),
+	.gpio_ranges = imx28_gpio_ranges,
+	.gpio_num_ranges = ARRAY_SIZE(imx28_gpio_ranges),
 };
 
 static int __devinit imx28_pinctrl_probe(struct platform_device *pdev)
diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c
index ab63d38..ea33ebc 100644
--- a/drivers/pinctrl/pinctrl-mxs.c
+++ b/drivers/pinctrl/pinctrl-mxs.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -220,12 +221,41 @@ static void mxs_pinctrl_disable(struct pinctrl_dev *pctldev,
 	/* Nothing to do here */
 }
 
+static int mxs_gpio_request_enable(struct pinctrl_dev *pctldev,
+				   struct pinctrl_gpio_range *range,
+				   unsigned pinid)
+{
+	struct mxs_pinctrl_data *d = pinctrl_dev_get_drvdata(pctldev);
+	void __iomem *reg;
+	u8 bank, shift;
+	u16 pin;
+
+	bank = PINID_TO_BANK(pinid);
+	pin = PINID_TO_PIN(pinid);
+	reg = d->base + d->soc->regs->muxsel;
+	reg += bank * 0x20 + pin / 16 * 0x10;
+	shift = pin % 16 * 2;
+
+	writel(0x3 << shift, reg + SET);
+
+	return 0;
+}
+
+static void mxs_gpio_disable_free(struct pinctrl_dev *pctldev,
+				  struct pinctrl_gpio_range *range,
+				  unsigned pinid)
+{
+	/* Nothing to do here */
+}
+
 static struct pinmux_ops mxs_pinmux_ops = {
 	.get_functions_count = mxs_pinctrl_get_funcs_count,
 	.get_function_name = mxs_pinctrl_get_func_name,
 	.get_function_groups = mxs_pinctrl_get_func_groups,
 	.enable = mxs_pinctrl_enable,
 	.disable = mxs_pinctrl_disable,
+	.gpio_request_enable = mxs_gpio_request_enable,
+	.gpio_disable_free = mxs_gpio_disable_free,
 };
 
 static int mxs_pinconf_get(struct pinctrl_dev *pctldev,
@@ -482,7 +512,9 @@ int __devinit mxs_pinctrl_probe(struct platform_device *pdev,
 				struct mxs_pinctrl_soc_data *soc)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *child;
 	struct mxs_pinctrl_data *d;
+	int id, i, j = 0;
 	int ret;
 
 	d = devm_kzalloc(&pdev->dev, sizeof(*d), GFP_KERNEL);
@@ -500,6 +532,26 @@ int __devinit mxs_pinctrl_probe(struct platform_device *pdev,
 	mxs_pinctrl_desc.npins = d->soc->npins;
 	mxs_pinctrl_desc.name = dev_name(&pdev->dev);
 
+	for_each_child_of_node(np, child) {
+		if (!of_device_is_compatible(child, "fsl,mxs-gpio"))
+			continue;
+
+		id = of_alias_get_id(child, "gpio");
+		if (id < 0 || id > soc->gpio_num_ranges) {
+			dev_err(&pdev->dev, "invalid gpio id: %d\n", id);
+			return id;
+		}
+
+		for (i = j; i < soc->gpio_num_ranges; i++) {
+			struct pinctrl_gpio_range *range = &soc->gpio_ranges[i];
+			if (range->id == id) {
+				range->gc = of_node_to_gpiochip(child);
+				range->base += range->gc->base;
+				j++;
+			}
+		}
+	}
+
 	platform_set_drvdata(pdev, d);
 
 	ret = mxs_pinctrl_probe_dt(pdev, d);
@@ -515,6 +567,9 @@ int __devinit mxs_pinctrl_probe(struct platform_device *pdev,
 		goto err;
 	}
 
+	for (i = 0; i < soc->gpio_num_ranges; i++)
+		pinctrl_add_gpio_range(d->pctl, &soc->gpio_ranges[i]);
+
 	return 0;
 
 err:
diff --git a/drivers/pinctrl/pinctrl-mxs.h b/drivers/pinctrl/pinctrl-mxs.h
index fdd88d0b..7feef15 100644
--- a/drivers/pinctrl/pinctrl-mxs.h
+++ b/drivers/pinctrl/pinctrl-mxs.h
@@ -82,6 +82,8 @@ struct mxs_pinctrl_soc_data {
 	unsigned nfunctions;
 	struct mxs_group *groups;
 	unsigned ngroups;
+	struct pinctrl_gpio_range *gpio_ranges;
+	unsigned gpio_num_ranges;
 };
 
 int mxs_pinctrl_probe(struct platform_device *pdev,
-- 
1.7.4.1
