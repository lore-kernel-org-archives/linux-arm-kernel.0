From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 21 Aug 2016 14:16:39 +0200
Subject: [PATCH v3 7/7] musb: sunxi: Add support for platform_set_mode
In-Reply-To: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
References: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1471781799-10457-7-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows run-time dr_mode switching support via the "mode" musb
sysfs attribute.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-No changes
Changes in v3:
-Fix switch-case code style
---
 drivers/usb/musb/sunxi.c | 58 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index c6ee166..649aaba 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -74,6 +74,7 @@
 #define SUNXI_MUSB_FL_HAS_SRAM			5
 #define SUNXI_MUSB_FL_HAS_RESET			6
 #define SUNXI_MUSB_FL_NO_CONFIGDATA		7
+#define SUNXI_MUSB_FL_PHY_MODE_PEND		8
 
 /* Our read/write methods need access and do not get passed in a musb ref :| */
 static struct musb *sunxi_musb;
@@ -87,6 +88,7 @@ struct sunxi_glue {
 	struct phy		*phy;
 	struct platform_device	*usb_phy;
 	struct usb_phy		*xceiv;
+	enum phy_mode		phy_mode;
 	unsigned long		flags;
 	struct work_struct	work;
 	struct extcon_dev	*extcon;
@@ -140,6 +142,9 @@ static void sunxi_musb_work(struct work_struct *work)
 			clear_bit(SUNXI_MUSB_FL_PHY_ON, &glue->flags);
 		}
 	}
+
+	if (test_and_clear_bit(SUNXI_MUSB_FL_PHY_MODE_PEND, &glue->flags))
+		phy_set_mode(glue->phy, glue->phy_mode);
 }
 
 static void sunxi_musb_set_vbus(struct musb *musb, int is_on)
@@ -341,6 +346,47 @@ static void sunxi_musb_dma_controller_destroy(struct dma_controller *c)
 {
 }
 
+static int sunxi_musb_set_mode(struct musb *musb, u8 mode)
+{
+	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
+	enum phy_mode new_mode;
+
+	switch (mode) {
+	case MUSB_HOST:
+		new_mode = PHY_MODE_USB_HOST;
+		break;
+	case MUSB_PERIPHERAL:
+		new_mode = PHY_MODE_USB_DEVICE;
+		break;
+	case MUSB_OTG:
+		new_mode = PHY_MODE_USB_OTG;
+		break;
+	default:
+		dev_err(musb->controller->parent,
+			"Error requested mode not supported by this kernel\n");
+		return -EINVAL;
+	}
+
+	if (glue->phy_mode == new_mode)
+		return 0;
+
+	if (musb->port_mode != MUSB_PORT_MODE_DUAL_ROLE) {
+		dev_err(musb->controller->parent,
+			"Error changing modes is only supported in dual role mode\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * phy_set_mode may sleep, and we're called with a spinlock held,
+	 * so let sunxi_musb_work deal with it.
+	 */
+	glue->phy_mode = new_mode;
+	set_bit(SUNXI_MUSB_FL_PHY_MODE_PEND, &glue->flags);
+	schedule_work(&glue->work);
+
+	return 0;
+}
+
 /*
  * sunxi musb register layout
  * 0x00 - 0x17	fifo regs, 1 long per fifo
@@ -568,6 +614,7 @@ static const struct musb_platform_ops sunxi_musb_ops = {
 	.writew		= sunxi_musb_writew,
 	.dma_init	= sunxi_musb_dma_controller_create,
 	.dma_exit	= sunxi_musb_dma_controller_destroy,
+	.set_mode	= sunxi_musb_set_mode,
 	.set_vbus	= sunxi_musb_set_vbus,
 	.pre_root_reset_end = sunxi_musb_pre_root_reset_end,
 	.post_root_reset_end = sunxi_musb_post_root_reset_end,
@@ -614,21 +661,28 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
+	if (!glue)
+		return -ENOMEM;
+
 	memset(&pdata, 0, sizeof(pdata));
 	switch (usb_get_dr_mode(&pdev->dev)) {
 #if defined CONFIG_USB_MUSB_DUAL_ROLE || defined CONFIG_USB_MUSB_HOST
 	case USB_DR_MODE_HOST:
 		pdata.mode = MUSB_PORT_MODE_HOST;
+		glue->phy_mode = PHY_MODE_USB_HOST;
 		break;
 #endif
 #if defined CONFIG_USB_MUSB_DUAL_ROLE || defined CONFIG_USB_MUSB_GADGET
 	case USB_DR_MODE_PERIPHERAL:
 		pdata.mode = MUSB_PORT_MODE_GADGET;
+		glue->phy_mode = PHY_MODE_USB_DEVICE;
 		break;
 #endif
 #ifdef CONFIG_USB_MUSB_DUAL_ROLE
 	case USB_DR_MODE_OTG:
 		pdata.mode = MUSB_PORT_MODE_DUAL_ROLE;
+		glue->phy_mode = PHY_MODE_USB_OTG;
 		break;
 #endif
 	default:
@@ -638,10 +692,6 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	pdata.platform_ops	= &sunxi_musb_ops;
 	pdata.config		= &sunxi_musb_hdrc_config;
 
-	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
-	if (!glue)
-		return -ENOMEM;
-
 	glue->dev = &pdev->dev;
 	INIT_WORK(&glue->work, sunxi_musb_work);
 	glue->host_nb.notifier_call = sunxi_musb_host_notifier;
-- 
2.7.4
