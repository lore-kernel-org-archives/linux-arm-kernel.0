From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  1 Feb 2013 08:52:08 +0100
Subject: [PATCH 5/9] USB chipidea: introduce dual role mode pdata flags
In-Reply-To: <1359705132-9434-1-git-send-email-s.hauer@pengutronix.de>
References: <1359705132-9434-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1359705132-9434-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even if a chipidea core is otg capable the board may not. This allows
to explicitly set the core to host/peripheral mode. Without these
flags the driver falls back to the old behaviour.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/chipidea/core.c  |   21 +++++++++++++++------
 include/linux/usb/chipidea.h |    2 +-
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index a3ec29d..b2dbf55 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -435,6 +435,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	struct resource	*res;
 	void __iomem	*base;
 	int		ret;
+	int		dr_mode;
 
 	if (!dev->platform_data) {
 		dev_err(dev, "platform data missing\n");
@@ -487,14 +488,22 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	dr_mode = ci->platdata->dr_mode;
+	if (dr_mode == USB_DR_MODE_UNKNOWN)
+		dr_mode = USB_DR_MODE_OTG;
+
 	/* initialize role(s) before the interrupt is requested */
-	ret = ci_hdrc_host_init(ci);
-	if (ret)
-		dev_info(dev, "doesn't support host\n");
+	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
+		ret = ci_hdrc_host_init(ci);
+		if (ret)
+			dev_info(dev, "doesn't support host\n");
+	}
 
-	ret = ci_hdrc_gadget_init(ci);
-	if (ret)
-		dev_info(dev, "doesn't support gadget\n");
+	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
+		ret = ci_hdrc_gadget_init(ci);
+		if (ret)
+			dev_info(dev, "doesn't support gadget\n");
+	}
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 1a2aa18..b314647 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -20,7 +20,7 @@ struct ci13xxx_platform_data {
 #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
 #define CI13XXX_PULLUP_ON_VBUS		BIT(2)
 #define CI13XXX_DISABLE_STREAMING	BIT(3)
-
+	enum usb_dr_mode	dr_mode;
 #define CI13XXX_CONTROLLER_RESET_EVENT		0
 #define CI13XXX_CONTROLLER_STOPPED_EVENT	1
 	void	(*notify_event) (struct ci13xxx *ci, unsigned event);
-- 
1.7.10.4
