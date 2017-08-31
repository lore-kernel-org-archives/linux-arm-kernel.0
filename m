From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Thu, 31 Aug 2017 14:48:20 +0200
Subject: [PATCH] usb: gadget: udc: atmel: set vbus irqflags explicitly
Message-ID: <20170831124820.21423-1-nicolas.ferre@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

The driver triggers actions on both edges of the vbus signal.

The former PIO controller was triggering IRQs on both falling and rising edges
by default. Newer PIO controller don't, so it's better to set it explicitly to
IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING.

Without this patch we may trigger the connection with host but only on some
bouncing signal conditions and thus lose connecting events.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org> # v4.4+
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 98d71400f8a1..a884c022df7a 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -29,6 +29,8 @@
 #include <linux/of_gpio.h>
 
 #include "atmel_usba_udc.h"
+#define USBA_VBUS_IRQFLAGS (IRQF_ONESHOT \
+			   | IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING)
 
 #ifdef CONFIG_USB_GADGET_DEBUG_FS
 #include <linux/debugfs.h>
@@ -2361,7 +2363,7 @@ static int usba_udc_probe(struct platform_device *pdev)
 					IRQ_NOAUTOEN);
 			ret = devm_request_threaded_irq(&pdev->dev,
 					gpio_to_irq(udc->vbus_pin), NULL,
-					usba_vbus_irq_thread, IRQF_ONESHOT,
+					usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
 					"atmel_usba_udc", udc);
 			if (ret) {
 				udc->vbus_pin = -ENODEV;
-- 
2.9.0
