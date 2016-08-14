From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 14 Aug 2016 20:28:00 +0200
Subject: [PATCH 6/7] musb: sunxi: Always register both host and udc when build
 with dual-role support
In-Reply-To: <1471199281-5494-1-git-send-email-hdegoede@redhat.com>
References: <1471199281-5494-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471199281-5494-7-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sunxi the handling of host- / peripheral-only mode is fully taken care
of in the phy driver. So we can always safely let the musb-core register
both the host and udc.

Besides a nice cleanup, this is also a preparation patch for adding
run-time dr_mode switching support via the "mode" musb sysfs attribute
and the platform_set_mode() callback.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/sunxi.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index c6ee166..868db03 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -615,26 +615,8 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	}
 
 	memset(&pdata, 0, sizeof(pdata));
-	switch (usb_get_dr_mode(&pdev->dev)) {
-#if defined CONFIG_USB_MUSB_DUAL_ROLE || defined CONFIG_USB_MUSB_HOST
-	case USB_DR_MODE_HOST:
-		pdata.mode = MUSB_PORT_MODE_HOST;
-		break;
-#endif
-#if defined CONFIG_USB_MUSB_DUAL_ROLE || defined CONFIG_USB_MUSB_GADGET
-	case USB_DR_MODE_PERIPHERAL:
-		pdata.mode = MUSB_PORT_MODE_GADGET;
-		break;
-#endif
-#ifdef CONFIG_USB_MUSB_DUAL_ROLE
-	case USB_DR_MODE_OTG:
-		pdata.mode = MUSB_PORT_MODE_DUAL_ROLE;
-		break;
-#endif
-	default:
-		dev_err(&pdev->dev, "Invalid or missing 'dr_mode' property\n");
-		return -EINVAL;
-	}
+	/* devicetree dr_mode setting is handled by the phy driver */
+	pdata.mode		= MUSB_PORT_MODE_DUAL_ROLE;
 	pdata.platform_ops	= &sunxi_musb_ops;
 	pdata.config		= &sunxi_musb_hdrc_config;
 
-- 
2.7.4
