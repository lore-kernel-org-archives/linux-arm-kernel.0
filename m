From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 19 Sep 2011 16:03:19 +0200
Subject: [PATCH 08/11] at92/udc: use gpio_is_valid to check the gpio
In-Reply-To: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1316441002-27381-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-usb at vger.kernel.org
---
Hi,

	I'd like to apply this patch via AT91 with the whole gpio patch series

Best Regards,
J.
 drivers/usb/gadget/at91_udc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index ddb118a..205498d 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1758,7 +1758,7 @@ static int __init at91udc_probe(struct platform_device *pdev)
 
 	/* rm9200 needs manual D+ pullup; off by default */
 	if (cpu_is_at91rm9200()) {
-		if (udc->board.pullup_pin <= 0) {
+		if (gpio_is_valid(udc->board.pullup_pin)) {
 			DBG("no D+ pullup?\n");
 			retval = -ENODEV;
 			goto fail0;
@@ -1825,7 +1825,7 @@ static int __init at91udc_probe(struct platform_device *pdev)
 		DBG("request irq %d failed\n", udc->udp_irq);
 		goto fail1;
 	}
-	if (udc->board.vbus_pin > 0) {
+	if (gpio_is_valid(udc->board.vbus_pin)) {
 		retval = gpio_request(udc->board.vbus_pin, "udc_vbus");
 		if (retval < 0) {
 			DBG("request vbus pin failed\n");
@@ -1869,10 +1869,10 @@ static int __init at91udc_probe(struct platform_device *pdev)
 	INFO("%s version %s\n", driver_name, DRIVER_VERSION);
 	return 0;
 fail4:
-	if (udc->board.vbus_pin > 0 && !udc->board.vbus_polled)
+	if (gpio_is_valid(udc->board.vbus_pin) && !udc->board.vbus_polled)
 		free_irq(udc->board.vbus_pin, udc);
 fail3:
-	if (udc->board.vbus_pin > 0)
+	if (gpio_is_valid(udc->board.vbus_pin))
 		gpio_free(udc->board.vbus_pin);
 fail2:
 	free_irq(udc->udp_irq, udc);
@@ -1907,7 +1907,7 @@ static int __exit at91udc_remove(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 0);
 	remove_debug_file(udc);
-	if (udc->board.vbus_pin > 0) {
+	if (gpio_is_valid(udc->board.vbus_pin)) {
 		free_irq(udc->board.vbus_pin, udc);
 		gpio_free(udc->board.vbus_pin);
 	}
@@ -1951,7 +1951,7 @@ static int at91udc_suspend(struct platform_device *pdev, pm_message_t mesg)
 		enable_irq_wake(udc->udp_irq);
 
 	udc->active_suspend = wake;
-	if (udc->board.vbus_pin > 0 && !udc->board.vbus_polled && wake)
+	if (gpio_is_valid(udc->board.vbus_pin) && !udc->board.vbus_polled && wake)
 		enable_irq_wake(udc->board.vbus_pin);
 	return 0;
 }
@@ -1961,7 +1961,7 @@ static int at91udc_resume(struct platform_device *pdev)
 	struct at91_udc *udc = platform_get_drvdata(pdev);
 	unsigned long	flags;
 
-	if (udc->board.vbus_pin > 0 && !udc->board.vbus_polled &&
+	if (gpio_is_valid(udc->board.vbus_pin) && !udc->board.vbus_polled &&
 	    udc->active_suspend)
 		disable_irq_wake(udc->board.vbus_pin);
 
-- 
1.7.5.4
