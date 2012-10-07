From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  7 Oct 2012 09:27:19 +0200
Subject: [PATCH 5/6] usb: at91_ude: switch pm ops
In-Reply-To: <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1349594840-11374-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so we can detect when we enter in slow_clock mode and drop
at91_suspend_entering_slow_clock

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-pm at vger.kernel.org
Cc: linux-usb at vger.kernel.org 
---
 drivers/usb/gadget/at91_udc.c |   34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 89d90b5..ba5b0af 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1910,10 +1910,10 @@ static int __exit at91udc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int at91udc_suspend(struct platform_device *pdev, pm_message_t mesg)
+static int at91udc_suspend(struct device *dev, int slow_clock)
 {
-	struct at91_udc *udc = platform_get_drvdata(pdev);
-	int		wake = udc->driver && device_may_wakeup(&pdev->dev);
+	struct at91_udc *udc = dev_get_drvdata(dev);
+	int		wake = udc->driver && device_may_wakeup(dev);
 	unsigned long	flags;
 
 	/* Unless we can act normally to the host (letting it wake us up
@@ -1923,7 +1923,7 @@ static int at91udc_suspend(struct platform_device *pdev, pm_message_t mesg)
 	 */
 	if ((!udc->suspended && udc->addr)
 			|| !wake
-			|| at91_suspend_entering_slow_clock()) {
+			|| slow_clock) {
 		spin_lock_irqsave(&udc->lock, flags);
 		pullup(udc, 0);
 		wake = 0;
@@ -1937,9 +1937,19 @@ static int at91udc_suspend(struct platform_device *pdev, pm_message_t mesg)
 	return 0;
 }
 
-static int at91udc_resume(struct platform_device *pdev)
+static int at91udc_suspend_standby(struct device *dev)
 {
-	struct at91_udc *udc = platform_get_drvdata(pdev);
+	return at91udc_suspend(dev, 0);
+}
+
+static int at91udc_suspend_mem(struct device *dev)
+{
+	return at91udc_suspend(dev, 1);
+}
+
+static int at91udc_resume(struct device *dev)
+{
+	struct at91_udc *udc = dev_get_drvdata(dev);
 	unsigned long	flags;
 
 	if (gpio_is_valid(udc->board.vbus_pin) && !udc->board.vbus_polled &&
@@ -1956,11 +1966,14 @@ static int at91udc_resume(struct platform_device *pdev)
 	}
 	return 0;
 }
-#else
-#define	at91udc_suspend	NULL
-#define	at91udc_resume	NULL
 #endif
 
+static struct dev_pm_ops at91_udc_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(at91udc_suspend_standby, at91udc_resume)
+	SET_SYSTEM_SLEEP_STANDBY_MEM_PM_OPS(at91udc_suspend_standby,
+				at91udc_suspend_mem)
+};
+
 #if defined(CONFIG_OF)
 static const struct of_device_id at91_udc_dt_ids[] = {
 	{ .compatible = "atmel,at91rm9200-udc" },
@@ -1973,11 +1986,10 @@ MODULE_DEVICE_TABLE(of, at91_udc_dt_ids);
 static struct platform_driver at91_udc_driver = {
 	.remove		= __exit_p(at91udc_remove),
 	.shutdown	= at91udc_shutdown,
-	.suspend	= at91udc_suspend,
-	.resume		= at91udc_resume,
 	.driver		= {
 		.name	= (char *) driver_name,
 		.owner	= THIS_MODULE,
+		.pm	= &at91_udc_pm_ops,
 		.of_match_table	= of_match_ptr(at91_udc_dt_ids),
 	},
 };
-- 
1.7.10.4
