From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 May 2014 16:25:27 +0200
Subject: [PATCH] pinctrl: sunxi: Fix multiple registration issue
Message-ID: <1400768727-7338-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the support for the PRCM muxer on the A31 has been added, the global
static pinctl_desc definition has been left as is. Unfortunately, this
structure is used to register the pinctrl device, and prior to this
registration, we set the name and pins field.

Since this structure is shared across instances, that means that the latest
registered pinctrl device wins in setting the name, pins and pins numbers,
which is not really a good thing.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f6522b54ece9..6dfc172af9d3 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -436,12 +436,6 @@ static const struct pinmux_ops sunxi_pmx_ops = {
 	.gpio_set_direction	= sunxi_pmx_gpio_set_direction,
 };
 
-static struct pinctrl_desc sunxi_pctrl_desc = {
-	.confops	= &sunxi_pconf_ops,
-	.pctlops	= &sunxi_pctrl_ops,
-	.pmxops		= &sunxi_pmx_ops,
-};
-
 static int sunxi_pinctrl_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	return pinctrl_request_gpio(chip->base + offset);
@@ -778,6 +772,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 		       const struct sunxi_pinctrl_desc *desc)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct pinctrl_desc *pctrl_desc;
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
 	struct resource *res;
@@ -796,6 +791,7 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	if (IS_ERR(pctl->membase))
 		return PTR_ERR(pctl->membase);
 
+	pctl->dev = &pdev->dev;
 	pctl->desc = desc;
 
 	ret = sunxi_pinctrl_build_state(pdev);
@@ -813,12 +809,21 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	for (i = 0; i < pctl->desc->npins; i++)
 		pins[i] = pctl->desc->pins[i].pin;
 
-	sunxi_pctrl_desc.name = dev_name(&pdev->dev);
-	sunxi_pctrl_desc.owner = THIS_MODULE;
-	sunxi_pctrl_desc.pins = pins;
-	sunxi_pctrl_desc.npins = pctl->desc->npins;
-	pctl->dev = &pdev->dev;
-	pctl->pctl_dev = pinctrl_register(&sunxi_pctrl_desc,
+	pctrl_desc = devm_kzalloc(&pdev->dev,
+				  sizeof(*pctrl_desc),
+				  GFP_KERNEL);
+	if (!pctrl_desc)
+		return -ENOMEM;
+
+	pctrl_desc->name = dev_name(&pdev->dev);
+	pctrl_desc->owner = THIS_MODULE;
+	pctrl_desc->pins = pins;
+	pctrl_desc->npins = pctl->desc->npins;
+	pctrl_desc->confops = &sunxi_pconf_ops;
+	pctrl_desc->pctlops = &sunxi_pctrl_ops;
+	pctrl_desc->pmxops =  &sunxi_pmx_ops;
+
+	pctl->pctl_dev = pinctrl_register(pctrl_desc,
 					  &pdev->dev, pctl);
 	if (!pctl->pctl_dev) {
 		dev_err(&pdev->dev, "couldn't register pinctrl driver\n");
-- 
1.9.3
