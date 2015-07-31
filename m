From: r.baldyga@samsung.com (Robert Baldyga)
Date: Fri, 31 Jul 2015 16:00:20 +0200
Subject: [PATCH v5 08/46] usb: gadget: amd5536udc: add ep capabilities support
In-Reply-To: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1438351258-31578-9-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert endpoint configuration to new capabilities model.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/udc/amd5536udc.c | 88 ++++++++++++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc.c b/drivers/usb/gadget/udc/amd5536udc.c
index de7e5e2..fdacddb 100644
--- a/drivers/usb/gadget/udc/amd5536udc.c
+++ b/drivers/usb/gadget/udc/amd5536udc.c
@@ -138,15 +138,82 @@ static DECLARE_TASKLET(disconnect_tasklet, udc_tasklet_disconnect,
 
 /* endpoint names used for print */
 static const char ep0_string[] = "ep0in";
-static const char *const ep_string[] = {
-	ep0_string,
-	"ep1in-int", "ep2in-bulk", "ep3in-bulk", "ep4in-bulk", "ep5in-bulk",
-	"ep6in-bulk", "ep7in-bulk", "ep8in-bulk", "ep9in-bulk", "ep10in-bulk",
-	"ep11in-bulk", "ep12in-bulk", "ep13in-bulk", "ep14in-bulk",
-	"ep15in-bulk", "ep0out", "ep1out-bulk", "ep2out-bulk", "ep3out-bulk",
-	"ep4out-bulk", "ep5out-bulk", "ep6out-bulk", "ep7out-bulk",
-	"ep8out-bulk", "ep9out-bulk", "ep10out-bulk", "ep11out-bulk",
-	"ep12out-bulk", "ep13out-bulk", "ep14out-bulk", "ep15out-bulk"
+static const struct {
+	const char *name;
+	const struct usb_ep_caps caps;
+} ep_info[] = {
+#define EP_INFO(_name, _caps) \
+	{ \
+		.name = _name, \
+		.caps = _caps, \
+	}
+
+	EP_INFO(ep0_string,
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep1in-int",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep2in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep3in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep4in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep5in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep6in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep7in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep8in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep9in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep10in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep11in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep12in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep13in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep14in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep15in-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
+	EP_INFO("ep0out",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_CONTROL, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep1out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep2out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep3out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep4out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep5out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep6out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep7out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep8out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep9out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep10out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep11out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep12out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep13out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep14out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+	EP_INFO("ep15out-bulk",
+		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_OUT)),
+
+#undef EP_INFO
 };
 
 /* DMA usage flag */
@@ -1517,7 +1584,8 @@ static void udc_setup_endpoints(struct udc *dev)
 	for (tmp = 0; tmp < UDC_EP_NUM; tmp++) {
 		ep = &dev->ep[tmp];
 		ep->dev = dev;
-		ep->ep.name = ep_string[tmp];
+		ep->ep.name = ep_info[tmp].name;
+		ep->ep.caps = ep_info[tmp].caps;
 		ep->num = tmp;
 		/* txfifo size is calculated at enable time */
 		ep->txfifo = dev->txfifo;
-- 
1.9.1
