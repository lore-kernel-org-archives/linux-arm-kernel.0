From: romain.izard.pro@gmail.com (Romain Izard)
Date: Fri, 11 May 2018 12:19:54 +0200
Subject: [PATCH v2 1/3] usb: gadget: udc: atmel: GPIO inversion is handled by
 gpiod
In-Reply-To: <20180511101956.11782-1-romain.izard.pro@gmail.com>
References: <20180511101956.11782-1-romain.izard.pro@gmail.com>
Message-ID: <20180511101956.11782-2-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When converting to GPIO descriptors, gpiod_get_value automatically
handles the line inversion flags from the device tree.

Do not invert the line twice.

Fixes: 3df034081021 ("usb: gadget: udc: atmel: convert to use GPIO descriptors")
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 3 +--
 drivers/usb/gadget/udc/atmel_usba_udc.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 27c16399c7e8..0fe3d0feb8f7 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -417,7 +417,7 @@ static inline void usba_int_enb_set(struct usba_udc *udc, u32 val)
 static int vbus_is_present(struct usba_udc *udc)
 {
 	if (udc->vbus_pin)
-		return gpiod_get_value(udc->vbus_pin) ^ udc->vbus_pin_inverted;
+		return gpiod_get_value(udc->vbus_pin);
 
 	/* No Vbus detection: Assume always present */
 	return 1;
@@ -2076,7 +2076,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, "atmel,vbus",
 						GPIOD_IN);
-	udc->vbus_pin_inverted = gpiod_is_active_low(udc->vbus_pin);
 
 	if (fifo_mode == 0) {
 		pp = NULL;
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 969ce8f3c3e2..d7eb7cf4fd5c 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -326,7 +326,6 @@ struct usba_udc {
 	const struct usba_udc_errata *errata;
 	int irq;
 	struct gpio_desc *vbus_pin;
-	int vbus_pin_inverted;
 	int num_ep;
 	int configured_ep;
 	struct usba_fifo_cfg *fifo_cfg;
-- 
2.14.1
