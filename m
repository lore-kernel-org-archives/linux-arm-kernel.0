From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:32:31 +0200
Subject: [PATCH v3 44/46] usb: gadget: net2280: add net2280_match_ep() function
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-45-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'match_ep' callback to utilize chip-specific knowledge in endpoint matching
process. Function does the same that was done by chip-specific code inside
of epautoconf. Now this code can be removed from there to separate generic code
from platform specific logic.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c  | 23 +----------------------
 drivers/usb/gadget/udc/net2280.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index cc0b084..d41fd82 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -86,28 +86,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	/* First, apply chip-specific "best usage" knowledge.
 	 * This might make a good usb_gadget_ops hook ...
 	 */
-	if (gadget_is_net2280(gadget)) {
-		char name[8];
-
-		if (type == USB_ENDPOINT_XFER_INT) {
-			/* ep-e, ep-f are PIO with only 64 byte fifos */
-			ep = gadget_find_ep_by_name(gadget, "ep-e");
-			if (ep && usb_gadget_ep_match_desc(gadget,
-					ep, desc, ep_comp))
-				goto found_ep;
-			ep = gadget_find_ep_by_name(gadget, "ep-f");
-			if (ep && usb_gadget_ep_match_desc(gadget,
-					ep, desc, ep_comp))
-				goto found_ep;
-		}
-
-		/* USB3380: use same address for usb and hardware endpoints */
-		snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
-				usb_endpoint_dir_in(desc) ? "in" : "out");
-		ep = gadget_find_ep_by_name(gadget, name);
-		if (ep && usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
-			goto found_ep;
-	} else if (gadget_is_goku (gadget)) {
+	if (gadget_is_goku (gadget)) {
 		if (USB_ENDPOINT_XFER_INT == type) {
 			/* single buffering is enough */
 			ep = gadget_find_ep_by_name(gadget, "ep3-bulk");
diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 0295cf7..41e6568 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -1533,6 +1533,36 @@ static int net2280_pullup(struct usb_gadget *_gadget, int is_on)
 	return 0;
 }
 
+static struct usb_ep *net2280_match_ep(struct usb_gadget *_gadget,
+		struct usb_endpoint_descriptor *desc,
+		struct usb_ss_ep_comp_descriptor *ep_comp)
+{
+	char name[8];
+	struct usb_ep *ep;
+	u8 type;
+
+	type = usb_endpoint_type(desc);
+
+	if (type == USB_ENDPOINT_XFER_INT) {
+		/* ep-e, ep-f are PIO with only 64 byte fifos */
+		ep = gadget_find_ep_by_name(_gadget, "ep-e");
+		if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+			return ep;
+		ep = gadget_find_ep_by_name(_gadget, "ep-f");
+		if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+			return ep;
+	}
+
+	/* USB3380: use same address for usb and hardware endpoints */
+	snprintf(name, sizeof(name), "ep%d%s", usb_endpoint_num(desc),
+			usb_endpoint_dir_in(desc) ? "in" : "out");
+	ep = gadget_find_ep_by_name(_gadget, name);
+	if (ep && usb_gadget_ep_match_desc(_gadget, ep, desc, ep_comp))
+		return ep;
+
+	return NULL;
+}
+
 static int net2280_start(struct usb_gadget *_gadget,
 		struct usb_gadget_driver *driver);
 static int net2280_stop(struct usb_gadget *_gadget);
@@ -1544,6 +1574,7 @@ static const struct usb_gadget_ops net2280_ops = {
 	.pullup		= net2280_pullup,
 	.udc_start	= net2280_start,
 	.udc_stop	= net2280_stop,
+	.match_ep	= net2280_match_ep,
 };
 
 /*-------------------------------------------------------------------------*/
-- 
1.9.1
