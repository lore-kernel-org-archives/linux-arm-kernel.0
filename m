From: rogerq@ti.com (Roger Quadros)
Date: Mon, 28 Jan 2013 13:30:09 +0200
Subject: [PATCH 08/30] mfd: omap-usb-host: Remove PHY reset handling code
In-Reply-To: <1359372631-8180-1-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
Message-ID: <1359372631-8180-9-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHY reset GPIO handling will be done in the PHY driver

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/omap-usb-host.c |   47 -------------------------------------------
 1 files changed, 0 insertions(+), 47 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 0874352..502a779 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -430,24 +430,10 @@ static unsigned omap_usbhs_rev2_hostconfig(struct usbhs_hcd_omap *omap,
 static void omap_usbhs_init(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = omap->pdata;
 	unsigned			reg;
 
 	dev_dbg(dev, "starting TI HSUSB Controller\n");
 
-	if (pdata->phy_reset) {
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_request_one(pdata->reset_gpio_port[0],
-					 GPIOF_OUT_INIT_LOW, "USB1 PHY reset");
-
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_request_one(pdata->reset_gpio_port[1],
-					 GPIOF_OUT_INIT_LOW, "USB2 PHY reset");
-
-		/* Hold the PHY in RESET for enough time till DIR is high */
-		udelay(10);
-	}
-
 	pm_runtime_get_sync(dev);
 
 	reg = usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
@@ -476,37 +462,8 @@ static void omap_usbhs_init(struct device *dev)
 	dev_dbg(dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
 
 	pm_runtime_put_sync(dev);
-	if (pdata->phy_reset) {
-		/* Hold the PHY in RESET for enough time till
-		 * PHY is settled and ready
-		 */
-		udelay(10);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_set_value_cansleep
-				(pdata->reset_gpio_port[0], 1);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_set_value_cansleep
-				(pdata->reset_gpio_port[1], 1);
-	}
-}
-
-static void omap_usbhs_deinit(struct device *dev)
-{
-	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = omap->pdata;
-
-	if (pdata->phy_reset) {
-		if (gpio_is_valid(pdata->reset_gpio_port[0]))
-			gpio_free(pdata->reset_gpio_port[0]);
-
-		if (gpio_is_valid(pdata->reset_gpio_port[1]))
-			gpio_free(pdata->reset_gpio_port[1]);
-	}
 }
 
-
 /**
  * usbhs_omap_probe - initialize TI-based HCDs
  *
@@ -710,8 +667,6 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	return 0;
 
 err_alloc:
-	omap_usbhs_deinit(&pdev->dev);
-
 	for (i = 0; i < omap->nports; i++) {
 		if (!IS_ERR(omap->utmi_clk[i]))
 			clk_put(omap->utmi_clk[i]);
@@ -756,8 +711,6 @@ static int usbhs_omap_remove(struct platform_device *pdev)
 	struct usbhs_hcd_omap *omap = platform_get_drvdata(pdev);
 	int i;
 
-	omap_usbhs_deinit(&pdev->dev);
-
 	for (i = 0; i < omap->nports; i++) {
 		if (!IS_ERR(omap->utmi_clk[i]))
 			clk_put(omap->utmi_clk[i]);
-- 
1.7.4.1
