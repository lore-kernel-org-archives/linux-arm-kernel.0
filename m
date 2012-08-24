From: stigge@antcom.de (Roland Stigge)
Date: Fri, 24 Aug 2012 15:06:52 +0200
Subject: [PATCH 2/2] mtd: lpc32xx_mlc: Cleanup after DT-only conversion
In-Reply-To: <1345813612-4234-1-git-send-email-stigge@antcom.de>
References: <1345813612-4234-1-git-send-email-stigge@antcom.de>
Message-ID: <1345813612-4234-2-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPC32xx's DT-only conversion of the MLC NAND driver makes NAND config via
platform_data obsolete. Dropped by this patch.

Further, the driver really needs CONFIG_OF, which is already reflected by the
dependency on ARCH_LPC32XX which depends on CONFIG_OF. So also dropping
CONFIG_OF ifdefs.

There is still platform_data necessary to supply the dma_filter callback for
the dma engine. This is a completely different data structure than the old
platform_data for NAND config, so renaming some old "pdata" variable to "ncfg"
to prevent confusion with the new platform data.

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 drivers/mtd/nand/lpc32xx_mlc.c |   46 ++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

--- linux-2.6.orig/drivers/mtd/nand/lpc32xx_mlc.c
+++ linux-2.6/drivers/mtd/nand/lpc32xx_mlc.c
@@ -621,43 +621,36 @@ out1:
 	return -ENXIO;
 }
 
-#ifdef CONFIG_OF
 static struct lpc32xx_nand_cfg_mlc *lpc32xx_parse_dt(struct device *dev)
 {
-	struct lpc32xx_nand_cfg_mlc *pdata;
+	struct lpc32xx_nand_cfg_mlc *ncfg;
 	struct device_node *np = dev->of_node;
 
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
+	ncfg = devm_kzalloc(dev, sizeof(*ncfg), GFP_KERNEL);
+	if (!ncfg) {
 		dev_err(dev, "could not allocate memory for platform data\n");
 		return NULL;
 	}
 
-	of_property_read_u32(np, "nxp,tcea-delay", &pdata->tcea_delay);
-	of_property_read_u32(np, "nxp,busy-delay", &pdata->busy_delay);
-	of_property_read_u32(np, "nxp,nand-ta", &pdata->nand_ta);
-	of_property_read_u32(np, "nxp,rd-high", &pdata->rd_high);
-	of_property_read_u32(np, "nxp,rd-low", &pdata->rd_low);
-	of_property_read_u32(np, "nxp,wr-high", &pdata->wr_high);
-	of_property_read_u32(np, "nxp,wr-low", &pdata->wr_low);
-
-	if (!pdata->tcea_delay || !pdata->busy_delay || !pdata->nand_ta ||
-	    !pdata->rd_high || !pdata->rd_low || !pdata->wr_high ||
-	    !pdata->wr_low) {
+	of_property_read_u32(np, "nxp,tcea-delay", &ncfg->tcea_delay);
+	of_property_read_u32(np, "nxp,busy-delay", &ncfg->busy_delay);
+	of_property_read_u32(np, "nxp,nand-ta", &ncfg->nand_ta);
+	of_property_read_u32(np, "nxp,rd-high", &ncfg->rd_high);
+	of_property_read_u32(np, "nxp,rd-low", &ncfg->rd_low);
+	of_property_read_u32(np, "nxp,wr-high", &ncfg->wr_high);
+	of_property_read_u32(np, "nxp,wr-low", &ncfg->wr_low);
+
+	if (!ncfg->tcea_delay || !ncfg->busy_delay || !ncfg->nand_ta ||
+	    !ncfg->rd_high || !ncfg->rd_low || !ncfg->wr_high ||
+	    !ncfg->wr_low) {
 		dev_err(dev, "chip parameters not specified correctly\n");
 		return NULL;
 	}
 
-	pdata->wp_gpio = of_get_named_gpio(np, "gpios", 0);
+	ncfg->wp_gpio = of_get_named_gpio(np, "gpios", 0);
 
-	return pdata;
+	return ncfg;
 }
-#else
-static struct lpc32xx_nand_cfg_mlc *lpc32xx_parse_dt(struct device *dev)
-{
-	return NULL;
-}
-#endif
 
 /*
  * Probe for NAND controller
@@ -695,10 +688,9 @@ static int __devinit lpc32xx_nand_probe(
 	nand_chip = &host->nand_chip;
 	if (pdev->dev.of_node)
 		host->ncfg = lpc32xx_parse_dt(&pdev->dev);
-	else
-		host->ncfg = pdev->dev.platform_data;
 	if (!host->ncfg) {
-		dev_err(&pdev->dev, "Missing platform data\n");
+		dev_err(&pdev->dev,
+			"Missing or bad NAND config from device tree\n");
 		return -ENOENT;
 	}
 	if (host->ncfg->wp_gpio == -EPROBE_DEFER)
@@ -907,13 +899,11 @@ static int lpc32xx_nand_suspend(struct p
 #define lpc32xx_nand_suspend NULL
 #endif
 
-#if defined(CONFIG_OF)
 static const struct of_device_id lpc32xx_nand_match[] = {
 	{ .compatible = "nxp,lpc3220-mlc" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, lpc32xx_nand_match);
-#endif
 
 static struct platform_driver lpc32xx_nand_driver = {
 	.probe		= lpc32xx_nand_probe,
