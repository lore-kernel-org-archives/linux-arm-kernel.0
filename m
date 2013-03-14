From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 14 Mar 2013 13:50:32 +0800
Subject: [PATCH 04/14] usb: fsl_udc_core: using common vbus_active
In-Reply-To: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
References: <1363240242-25775-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1363240242-25775-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using common vbus_active to indicate vbus status

CC: Li Yang <leoli@freescale.com>
Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/gadget/fsl_udc_core.c |    4 ++--
 drivers/usb/gadget/fsl_usb2_udc.h |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 04d5fef..c343bbf 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -1195,7 +1195,7 @@ static int fsl_wakeup(struct usb_gadget *gadget)
 
 static int can_pullup(struct fsl_udc *udc)
 {
-	return udc->driver && udc->softconnect && udc->vbus_active;
+	return udc->driver && udc->softconnect && udc->gadget.vbus_active;
 }
 
 /* Notify controller that VBUS is powered, Called by whatever
@@ -1208,7 +1208,7 @@ static int fsl_vbus_session(struct usb_gadget *gadget, int is_active)
 	udc = container_of(gadget, struct fsl_udc, gadget);
 	spin_lock_irqsave(&udc->lock, flags);
 	VDBG("VBUS %s", is_active ? "on" : "off");
-	udc->vbus_active = (is_active != 0);
+	udc->gadget.vbus_active = (is_active != 0);
 	if (can_pullup(udc))
 		fsl_writel((fsl_readl(&dr_regs->usbcmd) | USB_CMD_RUN_STOP),
 				&dr_regs->usbcmd);
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index c6703bb..f17ce58 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -483,7 +483,6 @@ struct fsl_udc {
 	spinlock_t lock;
 	struct usb_phy *transceiver;
 	unsigned softconnect:1;
-	unsigned vbus_active:1;
 	unsigned stopped:1;
 	unsigned remote_wakeup:1;
 	unsigned already_stopped:1;
-- 
1.7.0.4
