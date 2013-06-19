From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 13:27:27 +0200
Subject: [PATCH] usb: gadget: at91_udc: call at91udc_of_init only when needed
Message-ID: <6194333.jEShKk4GmN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids a build error in at91sam9261_9g10_defconfig:

drivers/usb/gadget/at91_udc.c: In function 'at91udc_probe':
drivers/usb/gadget/at91_udc.c:1685:34: warning: 'flags' may be used uninitialized in this
function [-Wmaybe-uninitialized]
  board->vbus_active_low = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
                                  ^
drivers/usb/gadget/at91_udc.c:1678:21: note: 'flags' was declared here
  enum of_gpio_flags flags;
                     ^

Making the call to at91udc_of_init conditinal also reduces
the object code size without sacrificing build coverage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 073b938..2cbab1c 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1725,7 +1725,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	/* init software state */
 	udc = &controller;
 	udc->gadget.dev.parent = dev;
-	if (pdev->dev.of_node)
+	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
 		at91udc_of_init(udc, pdev->dev.of_node);
 	else
 		memcpy(&udc->board, dev->platform_data,
