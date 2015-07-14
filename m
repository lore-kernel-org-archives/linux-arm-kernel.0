From: r.baldyga@samsung.com (Robert Baldyga)
Date: Tue, 14 Jul 2015 11:38:57 +0200
Subject: [PATCH v2 09/48] usb: gadget: at91_udc: add ep capabilities support
In-Reply-To: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436866776-5004-10-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/at91_udc.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index fc42264..a04b073 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -59,15 +59,29 @@
 #define	DRIVER_VERSION	"3 May 2006"
 
 static const char driver_name [] = "at91_udc";
-static const char * const ep_names[] = {
-	"ep0",
-	"ep1",
-	"ep2",
-	"ep3-int",
-	"ep4",
-	"ep5",
+
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[] = {
+#define EP_INFO(_name, _type, _dir) \
+	{ \
+		.name = _name, \
+		.caps = USB_EP_CAPS(USB_EP_CAPS_TYPE_ ## _type, \
+				USB_EP_CAPS_DIR_ ## _dir), \
+	}
+
+	EP_INFO("ep0",		CONTROL, ALL),
+	EP_INFO("ep1",		ALL,	ALL),
+	EP_INFO("ep2",		ALL,	ALL),
+	EP_INFO("ep3-int",	INT,	ALL),
+	EP_INFO("ep4",		ALL,	ALL),
+	EP_INFO("ep5",		ALL,	ALL),
+
+#undef EP_INFO
 };
-#define ep0name		ep_names[0]
+
+#define ep0name		ep_info[0].name
 
 #define VBUS_POLL_TIMEOUT	msecs_to_jiffies(1000)
 
@@ -1830,7 +1844,8 @@ static int at91udc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < NUM_ENDPOINTS; i++) {
 		ep = &udc->ep[i];
-		ep->ep.name = ep_names[i];
+		ep->ep.name = ep_info[i].name;
+		ep->ep.caps = ep_info[i].caps;
 		ep->ep.ops = &at91_ep_ops;
 		ep->udc = udc;
 		ep->int_mask = BIT(i);
-- 
1.9.1
