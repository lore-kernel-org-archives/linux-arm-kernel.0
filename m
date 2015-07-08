From: r.baldyga@samsung.com (Robert Baldyga)
Date: Wed, 08 Jul 2015 13:09:21 +0200
Subject: [PATCH 37/37] usb: gadget: epautoconf: add endpoint capabilities flags
 verification
In-Reply-To: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
References: <1436353761-7107-1-git-send-email-r.baldyga@samsung.com>
Message-ID: <1436353761-7107-38-git-send-email-r.baldyga@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce endpoint matching mechanism basing on endpoint capabilities
flags. We check if endpoint supports transfer type and direction requested
in ep descriptor. Since we have this new endpoint matching mechanism
there is no need to have old code guessing endpoint capabilities basing
on its name, so we are getting rid of it.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/usb/gadget/epautoconf.c | 72 +++++++++++++----------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 8e00ca7..38df22a 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -47,7 +47,6 @@ ep_matches (
 )
 {
 	u8		type;
-	const char	*tmp;
 	u16		max;
 
 	int		num_req_streams = 0;
@@ -56,58 +55,31 @@ ep_matches (
 	if (ep->claimed)
 		return 0;
 
-	/* only support ep0 for portable CONTROL traffic */
 	type = usb_endpoint_type(desc);
-	if (USB_ENDPOINT_XFER_CONTROL == type)
-		return 0;
-
-	/* some other naming convention */
-	if ('e' != ep->name[0])
+	switch (type) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		/* only support ep0 for portable CONTROL traffic */
 		return 0;
+	case USB_ENDPOINT_XFER_ISOC:
+		if (!ep->caps.type_iso)
+			return 0;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		if (!ep->caps.type_bulk)
+			return 0;
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		if (!ep->caps.type_int)
+			return 0;
+		break;
+	}
 
-	/* type-restriction:  "-iso", "-bulk", or "-int".
-	 * direction-restriction:  "in", "out".
-	 */
-	if ('-' != ep->name[2]) {
-		tmp = strrchr (ep->name, '-');
-		if (tmp) {
-			switch (type) {
-			case USB_ENDPOINT_XFER_INT:
-				/* bulk endpoints handle interrupt transfers,
-				 * except the toggle-quirky iso-synch kind
-				 */
-				if ('s' == tmp[2])	// == "-iso"
-					return 0;
-				/* for now, avoid PXA "interrupt-in";
-				 * it's documented as never using DATA1.
-				 */
-				if (gadget_is_pxa (gadget)
-						&& 'i' == tmp [1])
-					return 0;
-				break;
-			case USB_ENDPOINT_XFER_BULK:
-				if ('b' != tmp[1])	// != "-bulk"
-					return 0;
-				break;
-			case USB_ENDPOINT_XFER_ISOC:
-				if ('s' != tmp[2])	// != "-iso"
-					return 0;
-			}
-		} else {
-			tmp = ep->name + strlen (ep->name);
-		}
-
-		/* direction-restriction:  "..in-..", "out-.." */
-		tmp--;
-		if (!isdigit (*tmp)) {
-			if (desc->bEndpointAddress & USB_DIR_IN) {
-				if ('n' != *tmp)
-					return 0;
-			} else {
-				if ('t' != *tmp)
-					return 0;
-			}
-		}
+	if (usb_endpoint_dir_in(desc)) {
+		if (!ep->caps.dir_in)
+			return 0;
+	} else {
+		if (!ep->caps.dir_out)
+			return 0;
 	}
 
 	/*
-- 
1.9.1
