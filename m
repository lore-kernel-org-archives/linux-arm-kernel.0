From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jun 2016 13:38:25 +0200
Subject: [PATCH 4/5] usb: pxa27x_udc: remove unused function argument
In-Reply-To: <20160616113831.4108439-1-arnd@arndb.de>
References: <20160616113831.4108439-1-arnd@arndb.de>
Message-ID: <20160616113831.4108439-5-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a warning for this when building with W=1 because the
argument gets assigned to something else but never read:

drivers/usb/gadget/udc/pxa27x_udc.c: In function 'stop_activity':
drivers/usb/gadget/udc/pxa27x_udc.c:1828:74: error: parameter 'driver' set but not used [-Werror=unused-but-set-parameter]

This remove the argument entirely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/pxa27x_udc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 001a3b74a993..ad140aa00132 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1825,13 +1825,10 @@ fail:
  * Disables all udc endpoints (even control endpoint), report disconnect to
  * the gadget user.
  */
-static void stop_activity(struct pxa_udc *udc, struct usb_gadget_driver *driver)
+static void stop_activity(struct pxa_udc *udc)
 {
 	int i;
 
-	/* don't disconnect drivers more than once */
-	if (udc->gadget.speed == USB_SPEED_UNKNOWN)
-		driver = NULL;
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 
 	for (i = 0; i < NR_USB_ENDPOINTS; i++)
@@ -1848,7 +1845,7 @@ static int pxa27x_udc_stop(struct usb_gadget *g)
 {
 	struct pxa_udc *udc = to_pxa(g);
 
-	stop_activity(udc, NULL);
+	stop_activity(udc);
 	udc_disable(udc);
 
 	udc->driver = NULL;
@@ -2296,7 +2293,7 @@ static void irq_udc_reset(struct pxa_udc *udc)
 
 	if ((udccr & UDCCR_UDA) == 0) {
 		dev_dbg(udc->dev, "USB reset start\n");
-		stop_activity(udc, udc->driver);
+		stop_activity(udc);
 	}
 	udc->gadget.speed = USB_SPEED_FULL;
 	memset(&udc->stats, 0, sizeof udc->stats);
-- 
2.9.0
