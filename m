From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri,  1 Apr 2011 17:56:27 +0400
Subject: [PATCH 6/7] pxa25x: drop handling of udc_is_connected
In-Reply-To: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1301666188-11822-6-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no more users of udc_is_connected. Drop this field from mach_info
and stop using it in pxa25x_udc.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/include/asm/mach/udc_pxa2xx.h |    1 -
 drivers/usb/gadget/pxa25x_udc.c        |   13 +++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/mach/udc_pxa2xx.h b/arch/arm/include/asm/mach/udc_pxa2xx.h
index ea297ac..f0719d3 100644
--- a/arch/arm/include/asm/mach/udc_pxa2xx.h
+++ b/arch/arm/include/asm/mach/udc_pxa2xx.h
@@ -10,7 +10,6 @@
  */
 
 struct pxa2xx_udc_mach_info {
-        int  (*udc_is_connected)(void);		/* do we see host? */
         void (*udc_command)(int cmd);
 #define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
 #define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
index 6cb32b8..40ceb73 100644
--- a/drivers/usb/gadget/pxa25x_udc.c
+++ b/drivers/usb/gadget/pxa25x_udc.c
@@ -1072,7 +1072,7 @@ udc_seq_show(struct seq_file *m, void *_d)
 			(tmp & UDCCFR_ACM) ? " acm" : "");
 	}
 
-	if (dev->gadget.speed != USB_SPEED_FULL || !dev->driver)
+	if (dev->gadget.speed == USB_SPEED_UNKNOWN || !dev->driver)
 		goto done;
 
 	seq_printf(m, "ep0 IN %lu/%lu, OUT %lu/%lu\nirqs %lu\n\n",
@@ -1700,9 +1700,13 @@ pxa25x_udc_irq(int irq, void *_dev)
 		if (unlikely(udccr & UDCCR_SUSIR)) {
 			udc_ack_int_UDCCR(UDCCR_SUSIR);
 			handled = 1;
-			DBG(DBG_VERBOSE, "USB suspend\n");
+			DBG(DBG_VERBOSE, "USB suspend%s\n",
+				dev->gadget.speed != USB_SPEED_UNKNOWN
+				? "" : "+disconnect");
 
-			if (dev->gadget.speed != USB_SPEED_UNKNOWN
+			if (dev->gadget.speed == USB_SPEED_UNKNOWN)
+				stop_activity(dev, dev->driver);
+			else if (dev->gadget.speed != USB_SPEED_UNKNOWN
 					&& dev->driver
 					&& dev->driver->suspend)
 				dev->driver->suspend(&dev->gadget);
@@ -1717,7 +1721,8 @@ pxa25x_udc_irq(int irq, void *_dev)
 
 			if (dev->gadget.speed != USB_SPEED_UNKNOWN
 					&& dev->driver
-					&& dev->driver->resume)
+					&& dev->driver->resume
+					&& dev->gadget.speed != USB_SPEED_UNKNOWN)
 				dev->driver->resume(&dev->gadget);
 		}
 
-- 
1.7.4.1
