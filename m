From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  6 May 2014 17:16:07 +0200
Subject: [PATCH] usb: gadget: atmel_usba: always test udc->driver
Message-ID: <1399389367-15456-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Found using smatch: drivers/usb/gadget/atmel_usba_udc.c:1689 usba_udc_irq()
error: we previously assumed 'udc->driver' could be null (see line 1636)

Always test udc->driver before using its members.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 9f65324f9ae0..76023ce449a3 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1686,7 +1686,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 		reset_all_endpoints(udc);
 
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN
-				&& udc->driver->disconnect) {
+				&& udc->driver && udc->driver->disconnect) {
 			udc->gadget.speed = USB_SPEED_UNKNOWN;
 			spin_unlock(&udc->lock);
 			udc->driver->disconnect(&udc->gadget);
-- 
1.9.1
