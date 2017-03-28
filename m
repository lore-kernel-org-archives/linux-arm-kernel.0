From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Tue, 28 Mar 2017 19:07:37 +0300
Subject: [PATCH linux-next v2 2/4] usb: gadget: udc: atmel: Minor code cleanup
In-Reply-To: <cover.1490715349.git.cristian.birsan@microchip.com>
References: <cover.1490715349.git.cristian.birsan@microchip.com>
Message-ID: <1badc958c2a8980da639ba77b9f21bb5e3fb32fd.1490715349.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Minor code cleanup based on feedback received on mailinglist.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 3fd43fb..2bd8410 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -321,7 +321,6 @@ static inline void usba_cleanup_debugfs(struct usba_udc *udc)
 
 static ushort fifo_mode;
 
-/* "modprobe ... fifo_mode=1" etc */
 module_param(fifo_mode, ushort, 0x0);
 MODULE_PARM_DESC(fifo_mode, "Endpoint configuration mode");
 
@@ -371,7 +370,7 @@ static struct usba_fifo_cfg mode_4_cfg[] = {
 };
 /* Add additional configurations here */
 
-int usba_config_fifo_table(struct usba_udc *udc)
+static int usba_config_fifo_table(struct usba_udc *udc)
 {
 	int n;
 
@@ -1076,11 +1075,9 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 		struct usb_gadget_driver *driver);
 static int atmel_usba_stop(struct usb_gadget *gadget);
 
-static struct usb_ep *atmel_usba_match_ep(
-		struct usb_gadget		*gadget,
-		struct usb_endpoint_descriptor	*desc,
-		struct usb_ss_ep_comp_descriptor *ep_comp
-)
+static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
+				struct usb_endpoint_descriptor	*desc,
+				struct usb_ss_ep_comp_descriptor *ep_comp)
 {
 	struct usb_ep	*_ep;
 	struct usba_ep *ep;
@@ -1100,7 +1097,6 @@ static struct usb_ep *atmel_usba_match_ep(
 		ep = to_usba_ep(_ep);
 
 		switch (usb_endpoint_type(desc)) {
-
 		case USB_ENDPOINT_XFER_CONTROL:
 			break;
 
@@ -1141,7 +1137,7 @@ static struct usb_ep *atmel_usba_match_ep(
 		ep->udc->configured_ep++;
 	}
 
-return _ep;
+	return _ep;
 }
 
 static const struct usb_gadget_ops usba_udc_ops = {
@@ -2089,8 +2085,9 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		while ((pp = of_get_next_child(np, pp)))
 			udc->num_ep++;
 		udc->configured_ep = 1;
-	} else
+	} else {
 		udc->num_ep = usba_config_fifo_table(udc);
+	}
 
 	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * udc->num_ep,
 			   GFP_KERNEL);
-- 
2.7.4
