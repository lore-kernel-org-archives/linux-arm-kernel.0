From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  7 Mar 2012 10:15:42 +0100
Subject: [PATCH 5/9] USB: at91: Device udc add dt support
In-Reply-To: <20120307084924.GK21255@game.jcrosoft.org>
References: <20120307084924.GK21255@game.jcrosoft.org>
Message-ID: <1331111746-21393-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow to compile it if AT91 is enable.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-usb at vger.kernel.org
---
Hi Greg

	if it's ok with you I apply with the rest of the USB patch series via
	at91

Best Regards,
J.
 .../devicetree/bindings/usb/atmel-usb.txt          |   18 +++++++++
 drivers/usb/gadget/Kconfig                         |    2 +-
 drivers/usb/gadget/at91_udc.c                      |   40 +++++++++++++++++++-
 3 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 0143d7c..60bd215 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -29,3 +29,21 @@ usb1: ehci at 00800000 {
 	reg = <0x00800000 0x100000>;
 	interrupts = <22 4>;
 };
+
+AT91 USB device controller
+
+Required properties:
+ - compatible: Should be "atmel,at91rm9200-udc"
+ - reg: Address and length of the register set for the device
+ - interrupts: Should contain macb interrupt
+
+Optional properties:
+ - atmel,vbus-gpio: If present, specifies a gpio that needs to be
+   activated for the bus to be powered.
+
+usb1: gadget at fffa4000 {
+	compatible = "atmel,at91rm9200-udc";
+	reg = <0xfffa4000 0x4000>;
+	interrupts = <10 4>;
+	atmel,vbus-gpio = <&pioC 5 0>;
+};
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 85ae4b4..edf1144 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -137,7 +137,7 @@ choice
 
 config USB_AT91
 	tristate "Atmel AT91 USB Device Port"
-	depends on ARCH_AT91 && !ARCH_AT91SAM9RL && !ARCH_AT91SAM9G45
+	depends on ARCH_AT91
 	help
 	   Many Atmel AT91 processors (such as the AT91RM2000) have a
 	   full speed USB Device Port with support for five configurable
diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index f99b3dc..4063209 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -30,6 +30,8 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/prefetch.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 
 #include <asm/byteorder.h>
 #include <mach/hardware.h>
@@ -1707,7 +1709,27 @@ static void at91udc_shutdown(struct platform_device *dev)
 	spin_unlock_irqrestore(&udc->lock, flags);
 }
 
-static int __init at91udc_probe(struct platform_device *pdev)
+static void __devinit at91udc_of_init(struct at91_udc *udc,
+				     struct device_node *np)
+{
+	struct at91_udc_data *board = &udc->board;
+	u32 val;
+	enum of_gpio_flags flags;
+
+	if (of_property_read_u32(np, "atmel,vbus-polled", &val) == 0)
+		board->vbus_polled = 1;
+
+	board->vbus_pin = of_get_named_gpio_flags(np, "atmel,vbus-gpio", 0,
+						  &flags);
+	board->vbus_active_low = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
+
+	board->pullup_pin = of_get_named_gpio_flags(np, "atmel,pullup-gpio", 0,
+						  &flags);
+
+	board->pullup_active_low = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
+}
+
+static int __devinit at91udc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
 	struct at91_udc	*udc;
@@ -1742,7 +1764,11 @@ static int __init at91udc_probe(struct platform_device *pdev)
 	/* init software state */
 	udc = &controller;
 	udc->gadget.dev.parent = dev;
-	udc->board = *(struct at91_udc_data *) dev->platform_data;
+	if (pdev->dev.of_node)
+		at91udc_of_init(udc, pdev->dev.of_node);
+	else
+		memcpy(&udc->board, dev->platform_data,
+		       sizeof(struct at91_udc_data));
 	udc->pdev = pdev;
 	udc->enabled = 0;
 	spin_lock_init(&udc->lock);
@@ -1971,6 +1997,15 @@ static int at91udc_resume(struct platform_device *pdev)
 #define	at91udc_resume	NULL
 #endif
 
+#if defined(CONFIG_OF)
+static const struct of_device_id at91_udc_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-udc" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, at91_udc_dt_ids);
+#endif
+
 static struct platform_driver at91_udc_driver = {
 	.remove		= __exit_p(at91udc_remove),
 	.shutdown	= at91udc_shutdown,
@@ -1979,6 +2014,7 @@ static struct platform_driver at91_udc_driver = {
 	.driver		= {
 		.name	= (char *) driver_name,
 		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(at91_udc_dt_ids),
 	},
 };
 
-- 
1.7.7
