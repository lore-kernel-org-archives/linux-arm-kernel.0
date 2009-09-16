From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 16 Sep 2009 19:29:29 +0200
Subject: [PATCH] at91: use gpiolib calls for USB vbus pin on at91sam9g45
In-Reply-To: <4AB10F7D.9060706@atmel.com>
References: <4AB10F7D.9060706@atmel.com>
Message-ID: <1253122169-14806-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change pin configuration for USB vbus on at91sam9g45: use the generic gpiolib
call instead of the at91 specific one.
Use gpio_request() function with same identifier for OHCI and EHCI hosts as
they are sharing the same pin.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
This patch is on top of at91sam9g45 USB integration one:
"[PATCH 2/2] at91/USB: at91sam9g45 series USB host integration"
http://lkml.org/lkml/2009/6/9/221

 arch/arm/mach-at91/at91sam9g45_devices.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 5be8cf2..7d939c0 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -118,8 +118,10 @@ void __init at91_add_device_usbh_ohci(struct at91_usbh_data *data)
 
 	/* Enable VBus control for UHP ports */
 	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
-			at91_set_gpio_output(data->vbus_pin[i], 0);
+		if (data->vbus_pin[i]) {
+			gpio_request(data->vbus_pin[i], "usb host vbus");
+			gpio_direction_output(data->vbus_pin[i], 0);
+		}
 	}
 
 	usbh_ohci_data = *data;
@@ -173,8 +175,10 @@ void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data)
 
 	/* Enable VBus control for UHP ports */
 	for (i = 0; i < data->ports; i++) {
-		if (data->vbus_pin[i])
-			at91_set_gpio_output(data->vbus_pin[i], 0);
+		if (data->vbus_pin[i]) {
+			gpio_request(data->vbus_pin[i], "usb host vbus");
+			gpio_direction_output(data->vbus_pin[i], 0);
+		}
 	}
 
 	usbh_ehci_data = *data;
-- 
1.5.6.5
