From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Thu, 10 Jul 2014 09:54:00 +0200
Subject: [PATCH v2 2/2] ARM: shmobile: lager: remove USBHS callbacks
In-Reply-To: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <1404978840-31917-3-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let the driver handle initialization and power control.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-lager.c | 126 ++++-------------------------------
 1 file changed, 13 insertions(+), 113 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index b8b2b44..c2a14c7 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -420,117 +420,17 @@ static const struct resource usbhs_resources[] __initconst = {
 	DEFINE_RES_IRQ(gic_spi(107)),
 };
 
-struct usbhs_private {
-	struct renesas_usbhs_platform_info info;
-	struct usb_phy *phy;
-};
-
-#define usbhs_get_priv(pdev) \
-	container_of(renesas_usbhs_get_info(pdev), struct usbhs_private, info)
-
-static int usbhs_power_ctrl(struct platform_device *pdev,
-				void __iomem *base, int enable)
-{
-	struct usbhs_private *priv = usbhs_get_priv(pdev);
-
-	if (!priv->phy)
-		return -ENODEV;
-
-	if (enable) {
-		int retval = usb_phy_init(priv->phy);
-
-		if (!retval)
-			retval = usb_phy_set_suspend(priv->phy, 0);
-		return retval;
-	}
-
-	usb_phy_set_suspend(priv->phy, 1);
-	usb_phy_shutdown(priv->phy);
-	return 0;
-}
-
-static int usbhs_hardware_init(struct platform_device *pdev)
-{
-	struct usbhs_private *priv = usbhs_get_priv(pdev);
-	struct usb_phy *phy;
-	int ret;
-
-	/* USB0 Function - use PWEN as GPIO input to detect DIP Switch SW5
-	 * setting to avoid VBUS short circuit due to wrong cable.
-	 * PWEN should be pulled up high if USB Function is selected by SW5
-	 */
-	gpio_request_one(RCAR_GP_PIN(5, 18), GPIOF_IN, NULL); /* USB0_PWEN */
-	if (!gpio_get_value(RCAR_GP_PIN(5, 18))) {
-		pr_warn("Error: USB Function not selected - check SW5 + SW6\n");
-		ret = -ENOTSUPP;
-		goto error;
-	}
-
-	phy = usb_get_phy_dev(&pdev->dev, 0);
-	if (IS_ERR(phy)) {
-		ret = PTR_ERR(phy);
-		goto error;
-	}
-
-	priv->phy = phy;
-	return 0;
- error:
-	gpio_free(RCAR_GP_PIN(5, 18));
-	return ret;
-}
-
-static int usbhs_hardware_exit(struct platform_device *pdev)
-{
-	struct usbhs_private *priv = usbhs_get_priv(pdev);
-
-	if (!priv->phy)
-		return 0;
-
-	usb_put_phy(priv->phy);
-	priv->phy = NULL;
-
-	gpio_free(RCAR_GP_PIN(5, 18));
-	return 0;
-}
-
-static int usbhs_get_id(struct platform_device *pdev)
-{
-	return USBHS_GADGET;
-}
-
-static u32 lager_usbhs_pipe_type[] = {
-	USB_ENDPOINT_XFER_CONTROL,
-	USB_ENDPOINT_XFER_ISOC,
-	USB_ENDPOINT_XFER_ISOC,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_INT,
-	USB_ENDPOINT_XFER_INT,
-	USB_ENDPOINT_XFER_INT,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-	USB_ENDPOINT_XFER_BULK,
-};
-
-static struct usbhs_private usbhs_priv __initdata = {
-	.info = {
-		.platform_callback = {
-			.power_ctrl	= usbhs_power_ctrl,
-			.hardware_init	= usbhs_hardware_init,
-			.hardware_exit	= usbhs_hardware_exit,
-			.get_id		= usbhs_get_id,
-		},
-		.driver_param = {
-			.buswait_bwait	= 4,
-			.pipe_type = lager_usbhs_pipe_type,
-			.pipe_size = ARRAY_SIZE(lager_usbhs_pipe_type),
-		},
-	}
+static struct renesas_usbhs_platform_info usbhs_info __initdata = {
+	.driver_param = {
+		.buswait_bwait	= 4,
+		.type = USBHS_TYPE_R8A7790,
+		/* USB0 Function - use PWEN as GPIO input to detect DIP
+		 * Switch SW5 setting to avoid VBUS short circuit due to
+		 * wrong cable.  PWEN should be pulled up high if USB
+		 * Function is selected by SW5.
+		 */
+		.enable_gpio = RCAR_GP_PIN(5, 18),
+	},
 };
 
 static void __init lager_register_usbhs(void)
@@ -540,8 +440,8 @@ static void __init lager_register_usbhs(void)
 					  "renesas_usbhs", -1,
 					  usbhs_resources,
 					  ARRAY_SIZE(usbhs_resources),
-					  &usbhs_priv.info,
-					  sizeof(usbhs_priv.info));
+					  &usbhs_info,
+					  sizeof(usbhs_info));
 }
 
 /* USBHS PHY */
-- 
1.8.4.5
