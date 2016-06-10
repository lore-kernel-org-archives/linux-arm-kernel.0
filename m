From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 10 Jun 2016 21:02:54 +0200
Subject: [PATCH v4 4/4] usb: musb: sunxi: Simplify dr_mode handling
In-Reply-To: <1465585374-10213-1-git-send-email-hdegoede@redhat.com>
References: <1465585374-10213-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1465585374-10213-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

phy-sun4i-usb now has proper dr_mode handling, it always registers an
extcon, and sends a notify with the mode (even when in peripheral- /
host-only mode) at least once.

So we can simply the sunxi musb glue by always registering its extcon
notifier and relying on sunxi_musb_work() to enable vbus when in
host-only mode.

This also enables host- and peripheral-only mode with vbus monitoring.

Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Bin Liu <b-liu@ti.com>
---
Changes in v2:
-No changes
Changes in v3:
-No changes
Changes in v4:
-Add Maxime's Tested-by
-Add Bin Liu's Acked-by
---
 drivers/usb/musb/sunxi.c | 68 ++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index 7650051..a17eb2a 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -256,12 +256,10 @@ static int sunxi_musb_init(struct musb *musb)
 	writeb(SUNXI_MUSB_VEND0_PIO_MODE, musb->mregs + SUNXI_MUSB_VEND0);
 
 	/* Register notifier before calling phy_init() */
-	if (musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE) {
-		ret = extcon_register_notifier(glue->extcon, EXTCON_USB_HOST,
-					       &glue->host_nb);
-		if (ret)
-			goto error_reset_assert;
-	}
+	ret = extcon_register_notifier(glue->extcon, EXTCON_USB_HOST,
+				       &glue->host_nb);
+	if (ret)
+		goto error_reset_assert;
 
 	ret = phy_init(glue->phy);
 	if (ret)
@@ -275,9 +273,8 @@ static int sunxi_musb_init(struct musb *musb)
 	return 0;
 
 error_unregister_notifier:
-	if (musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
-		extcon_unregister_notifier(glue->extcon, EXTCON_USB_HOST,
-					   &glue->host_nb);
+	extcon_unregister_notifier(glue->extcon, EXTCON_USB_HOST,
+				   &glue->host_nb);
 error_reset_assert:
 	if (test_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags))
 		reset_control_assert(glue->rst);
@@ -301,9 +298,8 @@ static int sunxi_musb_exit(struct musb *musb)
 
 	phy_exit(glue->phy);
 
-	if (musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
-		extcon_unregister_notifier(glue->extcon, EXTCON_USB_HOST,
-					   &glue->host_nb);
+	extcon_unregister_notifier(glue->extcon, EXTCON_USB_HOST,
+				   &glue->host_nb);
 
 	if (test_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags))
 		reset_control_assert(glue->rst);
@@ -315,25 +311,6 @@ static int sunxi_musb_exit(struct musb *musb)
 	return 0;
 }
 
-static int sunxi_set_mode(struct musb *musb, u8 mode)
-{
-	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
-	int ret;
-
-	if (mode == MUSB_HOST) {
-		ret = phy_power_on(glue->phy);
-		if (ret)
-			return ret;
-
-		set_bit(SUNXI_MUSB_FL_PHY_ON, &glue->flags);
-		/* Stop musb work from turning vbus off again */
-		set_bit(SUNXI_MUSB_FL_VBUS_ON, &glue->flags);
-		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
-	}
-
-	return 0;
-}
-
 static void sunxi_musb_enable(struct musb *musb)
 {
 	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
@@ -582,7 +559,6 @@ static const struct musb_platform_ops sunxi_musb_ops = {
 	.exit		= sunxi_musb_exit,
 	.enable		= sunxi_musb_enable,
 	.disable	= sunxi_musb_disable,
-	.set_mode	= sunxi_set_mode,
 	.fifo_offset	= sunxi_musb_fifo_offset,
 	.ep_offset	= sunxi_musb_ep_offset,
 	.busctl_offset	= sunxi_musb_busctl_offset,
@@ -638,10 +614,6 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
-	if (!glue)
-		return -ENOMEM;
-
 	memset(&pdata, 0, sizeof(pdata));
 	switch (usb_get_dr_mode(&pdev->dev)) {
 #if defined CONFIG_USB_MUSB_DUAL_ROLE || defined CONFIG_USB_MUSB_HOST
@@ -649,15 +621,13 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 		pdata.mode = MUSB_PORT_MODE_HOST;
 		break;
 #endif
+#if defined CONFIG_USB_MUSB_DUAL_ROLE || defined CONFIG_USB_MUSB_GADGET
+	case USB_DR_MODE_PERIPHERAL:
+		pdata.mode = MUSB_PORT_MODE_GADGET;
+		break;
+#endif
 #ifdef CONFIG_USB_MUSB_DUAL_ROLE
 	case USB_DR_MODE_OTG:
-		glue->extcon = extcon_get_edev_by_phandle(&pdev->dev, 0);
-		if (IS_ERR(glue->extcon)) {
-			if (PTR_ERR(glue->extcon) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
-			dev_err(&pdev->dev, "Invalid or missing extcon\n");
-			return PTR_ERR(glue->extcon);
-		}
 		pdata.mode = MUSB_PORT_MODE_DUAL_ROLE;
 		break;
 #endif
@@ -668,6 +638,10 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	pdata.platform_ops	= &sunxi_musb_ops;
 	pdata.config		= &sunxi_musb_hdrc_config;
 
+	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
+	if (!glue)
+		return -ENOMEM;
+
 	glue->dev = &pdev->dev;
 	INIT_WORK(&glue->work, sunxi_musb_work);
 	glue->host_nb.notifier_call = sunxi_musb_host_notifier;
@@ -701,6 +675,14 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 		}
 	}
 
+	glue->extcon = extcon_get_edev_by_phandle(&pdev->dev, 0);
+	if (IS_ERR(glue->extcon)) {
+		if (PTR_ERR(glue->extcon) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_err(&pdev->dev, "Invalid or missing extcon\n");
+		return PTR_ERR(glue->extcon);
+	}
+
 	glue->phy = devm_phy_get(&pdev->dev, "usb");
 	if (IS_ERR(glue->phy)) {
 		if (PTR_ERR(glue->phy) == -EPROBE_DEFER)
-- 
2.7.4
