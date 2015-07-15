From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 15 Jul 2015 08:32:25 +0200
Subject: [PATCH v3 38/46] usb: gadget: epautoconf: remove pxa quirk from
 ep_matches()
In-Reply-To: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436941953-1327-39-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The same effect can be achieved by using capabilities flags, so now we can
get rid of handling of hardware specific limitations in generic code.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c     | 5 -----
 drivers/usb/gadget/udc/pxa25x_udc.c | 9 +++------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index af4b10a..4f66e9d73 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -58,11 +58,6 @@ ep_matches (
 		 */
 		if (!ep->caps.type_int && !ep->caps.type_bulk)
 			return 0;
-		/* for now, avoid PXA "interrupt-in";
-		 * it's documented as never using DATA1.
-		 */
-		if (gadget_is_pxa(gadget) && ep->caps.type_int)
-			return 0;
 		break;
 	}
 
diff --git a/drivers/usb/gadget/udc/pxa25x_udc.c b/drivers/usb/gadget/udc/pxa25x_udc.c
index 1301e29..f53e526 100644
--- a/drivers/usb/gadget/udc/pxa25x_udc.c
+++ b/drivers/usb/gadget/udc/pxa25x_udc.c
@@ -1898,8 +1898,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep5in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -1977,8 +1976,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep10in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
@@ -2056,8 +2054,7 @@ static struct pxa25x_udc memory = {
 			.name		= "ep15in-int",
 			.ops		= &pxa25x_ep_ops,
 			.maxpacket	= INT_FIFO_SIZE,
-			.caps		= USB_EP_CAPS(USB_EP_CAPS_TYPE_INT,
-						USB_EP_CAPS_DIR_IN),
+			.caps		= USB_EP_CAPS(0, 0),
 		},
 		.dev		= &memory,
 		.fifo_size	= INT_FIFO_SIZE,
-- 
1.9.1
