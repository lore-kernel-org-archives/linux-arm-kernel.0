From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Feb 2013 16:00:12 +0800
Subject: [PATCH v8 5/8] usb: chipidea: udc: add pullup/pulldown dp at
 hw_device_state
In-Reply-To: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1360051215-27722-6-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- During the connect/disconnect host, we need to pullup
and pulldown dp
- Make sure the dp is not pullup until the vbus is on when
flag CI13XXX_PULLUP_ON_VBUS is set
- Using hw_device_state when set run/stop bit

Signed-off-by: Peter Chen <peter.chen@freescale.com>

diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index e82dae4..597ae64 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -91,8 +91,10 @@ static int hw_device_state(struct ci13xxx *ci, u32 dma)
 		/* interrupt, error, port change, reset, sleep/suspend */
 		hw_write(ci, OP_USBINTR, ~0,
 			     USBi_UI|USBi_UEI|USBi_PCI|USBi_URI|USBi_SLI);
+		hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
 	} else {
 		hw_write(ci, OP_USBINTR, ~0, 0);
+		hw_write(ci, OP_USBCMD, USBCMD_RS, 0);
 	}
 	return 0;
 }
@@ -1424,10 +1426,14 @@ static int ci13xxx_pullup(struct usb_gadget *_gadget, int is_on)
 {
 	struct ci13xxx *ci = container_of(_gadget, struct ci13xxx, gadget);
 
+	if ((ci->platdata->flags & CI13XXX_PULLUP_ON_VBUS) &&
+			!ci->vbus_active)
+		return -ENOTSUPP;
+
 	if (is_on)
-		hw_write(ci, OP_USBCMD, USBCMD_RS, USBCMD_RS);
+		hw_device_state(ci, ci->ep0out->qh.dma);
 	else
-		hw_write(ci, OP_USBCMD, USBCMD_RS, 0);
+		hw_device_state(ci, 0);
 
 	return 0;
 }
-- 
1.7.0.4
