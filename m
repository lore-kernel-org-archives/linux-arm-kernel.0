From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 26 Oct 2016 17:03:56 +0200
Subject: [PATCH v2 3/4] usb: musb: da8xx: Add DT support for the DA8xx driver
In-Reply-To: <1477494237-22831-1-git-send-email-abailon@baylibre.com>
References: <1477494237-22831-1-git-send-email-abailon@baylibre.com>
Message-ID: <1477494237-22831-4-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Petr Kulhavy <petr@barix.com>

This adds DT support for TI DA8xx/OMAP-L1x/AM17xx/AM18xx MUSB driver

Signed-off-by: Petr Kulhavy <petr@barix.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/usb/musb/da8xx.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 210b7e4..bfa571d 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -6,6 +6,9 @@
  * Based on the DaVinci "glue layer" code.
  * Copyright (C) 2005-2006 by Texas Instruments
  *
+ * DT support
+ * Copyright (c) 2016 Petr Kulhavy <petr@barix.com>
+ *
  * This file is part of the Inventra Controller Driver for Linux.
  *
  * The Inventra Controller Driver for Linux is free software; you
@@ -433,6 +436,21 @@ static int da8xx_musb_exit(struct musb *musb)
 	return 0;
 }
 
+static inline u8 get_vbus_power(struct device *dev)
+{
+	struct regulator *vbus_supply;
+	int current_uA;
+
+	vbus_supply = regulator_get_optional(dev, "vbus");
+	if (IS_ERR(vbus_supply))
+		return 255;
+	current_uA = regulator_get_current_limit(vbus_supply);
+	regulator_put(vbus_supply);
+	if (current_uA <= 0 || current_uA > 510000)
+		return 255;
+	return current_uA / 1000 / 2;
+}
+
 static const struct musb_platform_ops da8xx_ops = {
 	.quirks		= MUSB_DMA_CPPI | MUSB_INDEXED_EP,
 	.init		= da8xx_musb_init,
@@ -458,6 +476,12 @@ static const struct platform_device_info da8xx_dev_info = {
 	.dma_mask	= DMA_BIT_MASK(32),
 };
 
+static const struct musb_hdrc_config da8xx_config = {
+	.ram_bits = 10,
+	.num_eps = 5,
+	.multipoint = 1,
+};
+
 static int da8xx_probe(struct platform_device *pdev)
 {
 	struct resource musb_resources[2];
@@ -465,7 +489,9 @@ static int da8xx_probe(struct platform_device *pdev)
 	struct da8xx_glue		*glue;
 	struct platform_device_info	pinfo;
 	struct clk			*clk;
+	struct device_node		*np = pdev->dev.of_node;
 	int				ret;
+	struct resource *res;
 
 	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue)
@@ -486,6 +512,18 @@ static int da8xx_probe(struct platform_device *pdev)
 	glue->dev			= &pdev->dev;
 	glue->clk			= clk;
 
+	if (IS_ENABLED(CONFIG_OF) && np) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			/* FIXME */
+			return -ENOMEM;
+		}
+
+		pdata->config	= &da8xx_config;
+		pdata->mode	= musb_get_mode(&pdev->dev);
+		pdata->power	= get_vbus_power(&pdev->dev);
+	}
+
 	pdata->platform_ops		= &da8xx_ops;
 
 	glue->usb_phy = usb_phy_generic_register();
@@ -536,11 +574,20 @@ static int da8xx_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id da8xx_id_table[] = {
+	{
+		.compatible = "ti,da830-musb",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, da8xx_id_table);
+
 static struct platform_driver da8xx_driver = {
 	.probe		= da8xx_probe,
 	.remove		= da8xx_remove,
 	.driver		= {
 		.name	= "musb-da8xx",
+		.of_match_table = of_match_ptr(da8xx_id_table),
 	},
 };
 
-- 
2.7.3
