From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 29 Mar 2015 12:50:48 +0200
Subject: [PATCH 3/3] msub: sunxi: Add pre/post root reset end platform
 functions
In-Reply-To: <1427626248-6257-1-git-send-email-hdegoede@redhat.com>
References: <1427626248-6257-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1427626248-6257-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pre/post root reset end platform functions and make them call
sun4i_usb_phy_set_squelch_detect() to work around the sunxi usb otg phy
workaround.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/usb/musb/sunxi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index ef91548..774312f 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/phy/phy-sun4i-usb.h>
 #include <linux/platform_device.h>
 #include <linux/soc/sunxi/sunxi_sram.h>
 #include <linux/usb/musb.h>
@@ -147,6 +148,20 @@ static void sunxi_musb_set_vbus(struct musb *musb, int is_on)
 	schedule_work(&glue->work);
 }
 
+void sunxi_musb_pre_root_reset_end(struct musb *musb)
+{
+	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
+
+	sun4i_usb_phy_set_squelch_detect(glue->phy, false);
+}
+
+void sunxi_musb_post_root_reset_end(struct musb *musb)
+{
+	struct sunxi_glue *glue = dev_get_drvdata(musb->controller->parent);
+
+	sun4i_usb_phy_set_squelch_detect(glue->phy, true);
+}
+
 static irqreturn_t sunxi_musb_interrupt(int irq, void *__hci)
 {
 	struct musb *musb = __hci;
@@ -515,6 +530,8 @@ static const struct musb_platform_ops sunxi_musb_ops = {
 	.readw		= sunxi_musb_readw,
 	.writew		= sunxi_musb_writew,
 	.set_vbus	= sunxi_musb_set_vbus,
+	.pre_root_reset_end = sunxi_musb_pre_root_reset_end,
+	.post_root_reset_end = sunxi_musb_post_root_reset_end,
 };
 
 /* Allwinner OTG supports up to 5 endpoints */
-- 
2.3.4
