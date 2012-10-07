From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  7 Oct 2012 09:27:18 +0200
Subject: [PATCH 4/6] usb: ohci-at91: switch pm ops
In-Reply-To: <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <1349594840-11374-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1349594840-11374-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so we can detect when we enter in slow_clock mode and drop
at91_suspend_entering_slow_clock

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-pm at vger.kernel.org
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-at91.c |   38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 0bf72f9..316897d 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -668,14 +668,12 @@ static int __devexit ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-
-static int
-ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
+static int ohci_hcd_at91_drv_suspend(struct device *dev, int slow_clock)
 {
-	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(dev))
 		enable_irq_wake(hcd->irq);
 
 	/*
@@ -685,7 +683,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 	 *
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
-	if (at91_suspend_entering_slow_clock()) {
+	if (slow_clock) {
 		ohci_usb_reset (ohci);
 		/* flush the writes */
 		(void) ohci_readl (ohci, &ohci->regs->control);
@@ -695,11 +693,21 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 	return 0;
 }
 
-static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
+static int ohci_hcd_at91_drv_suspend_standby(struct device *dev)
+{
+	return ohci_hcd_at91_drv_suspend(dev, 0);
+}
+
+static int ohci_hcd_at91_drv_suspend_mem(struct device *dev)
+{
+	return ohci_hcd_at91_drv_suspend(dev, 1);
+}
+
+static int ohci_hcd_at91_drv_resume(struct device *dev)
 {
-	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(dev))
 		disable_irq_wake(hcd->irq);
 
 	if (!clocked)
@@ -708,22 +716,24 @@ static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
 	ohci_finish_controller_resume(hcd);
 	return 0;
 }
-#else
-#define ohci_hcd_at91_drv_suspend NULL
-#define ohci_hcd_at91_drv_resume  NULL
 #endif
 
+static struct dev_pm_ops ohci_hcd_at91_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(ohci_hcd_at91_drv_suspend_standby, ohci_hcd_at91_drv_resume)
+	SET_SYSTEM_SLEEP_STANDBY_MEM_PM_OPS(ohci_hcd_at91_drv_suspend_standby,
+				ohci_hcd_at91_drv_suspend_mem)
+};
+
 MODULE_ALIAS("platform:at91_ohci");
 
 static struct platform_driver ohci_hcd_at91_driver = {
 	.probe		= ohci_hcd_at91_drv_probe,
 	.remove		= __devexit_p(ohci_hcd_at91_drv_remove),
 	.shutdown	= usb_hcd_platform_shutdown,
-	.suspend	= ohci_hcd_at91_drv_suspend,
-	.resume		= ohci_hcd_at91_drv_resume,
 	.driver		= {
 		.name	= "at91_ohci",
 		.owner	= THIS_MODULE,
+		.pm	= &ohci_hcd_at91_pm_ops,
 		.of_match_table	= of_match_ptr(at91_ohci_dt_ids),
 	},
 };
-- 
1.7.10.4
