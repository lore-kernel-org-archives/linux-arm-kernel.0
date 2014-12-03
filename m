From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  3 Dec 2014 12:32:04 +0100
Subject: [PATCH 05/11] usb: gadget: at91_udc: Remove non-DT handling code
In-Reply-To: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417606330-17753-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417606330-17753-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since non-DT board support has been removed from the at91 architecture we
can safely remove non-DT handling code.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/usb/gadget/udc/Kconfig    |  1 +
 drivers/usb/gadget/udc/at91_udc.c | 16 ++--------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 217365d..36a598d 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -32,6 +32,7 @@ menu "USB Peripheral Controller"
 config USB_AT91
 	tristate "Atmel AT91 USB Device Port"
 	depends on ARCH_AT91
+	depends on OF || COMPILE_TEST
 	help
 	   Many Atmel AT91 processors (such as the AT91RM2000) have a
 	   full speed USB Device Port with support for five configurable
diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 4ecb576..e7984c0 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1697,12 +1697,6 @@ static int at91udc_probe(struct platform_device *pdev)
 	int		retval;
 	struct resource	*res;
 
-	if (!dev_get_platdata(dev) && !pdev->dev.of_node) {
-		/* small (so we copy it) but critical! */
-		DBG("missing platform_data\n");
-		return -ENODEV;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENXIO;
@@ -1715,11 +1709,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	/* init software state */
 	udc = &controller;
 	udc->gadget.dev.parent = dev;
-	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node)
-		at91udc_of_init(udc, pdev->dev.of_node);
-	else
-		memcpy(&udc->board, dev_get_platdata(dev),
-		       sizeof(struct at91_udc_data));
+	at91udc_of_init(udc, pdev->dev.of_node);
 	udc->pdev = pdev;
 	udc->enabled = 0;
 	spin_lock_init(&udc->lock);
@@ -1955,14 +1945,12 @@ static int at91udc_resume(struct platform_device *pdev)
 #define	at91udc_resume	NULL
 #endif
 
-#if defined(CONFIG_OF)
 static const struct of_device_id at91_udc_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-udc" },
 	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, at91_udc_dt_ids);
-#endif
 
 static struct platform_driver at91_udc_driver = {
 	.remove		= __exit_p(at91udc_remove),
@@ -1972,7 +1960,7 @@ static struct platform_driver at91_udc_driver = {
 	.driver		= {
 		.name	= (char *) driver_name,
 		.owner	= THIS_MODULE,
-		.of_match_table	= of_match_ptr(at91_udc_dt_ids),
+		.of_match_table	= at91_udc_dt_ids,
 	},
 };
 
-- 
1.9.1
