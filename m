From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 20 Jan 2015 14:39:00 +0100
Subject: [PATCHv7 2/6] USB: host: ohci-at91: Use struct dev_pm_ops instead of
 struct platform_driver
In-Reply-To: <1421761144-11767-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421761144-11767-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <1421761144-11767-3-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch replace struct platform_driver.{resume,suspend} PM bindings
to a new struct dev_pm_ops.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/usb/host/ohci-at91.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index dc9e4e6..65e7836 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -593,11 +593,11 @@ static int ohci_hcd_at91_drv_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 
 static int
-ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
+ohci_hcd_at91_drv_suspend(struct device *dev)
 {
-	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
-	bool		do_wakeup = device_may_wakeup(&pdev->dev);
+	bool		do_wakeup = device_may_wakeup(dev);
 	int		ret;
 
 	if (do_wakeup)
@@ -629,11 +629,11 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 	return ret;
 }
 
-static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
+static int ohci_hcd_at91_drv_resume(struct device *dev)
 {
-	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(dev))
 		disable_irq_wake(hcd->irq);
 
 	if (!clocked)
@@ -642,19 +642,18 @@ static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
 	ohci_resume(hcd, false);
 	return 0;
 }
-#else
-#define ohci_hcd_at91_drv_suspend NULL
-#define ohci_hcd_at91_drv_resume  NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(ohci_hcd_at91_pm_ops, ohci_hcd_at91_drv_suspend,
+					ohci_hcd_at91_drv_resume);
+
 static struct platform_driver ohci_hcd_at91_driver = {
 	.probe		= ohci_hcd_at91_drv_probe,
 	.remove		= ohci_hcd_at91_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
-	.suspend	= ohci_hcd_at91_drv_suspend,
-	.resume		= ohci_hcd_at91_drv_resume,
 	.driver		= {
 		.name	= "at91_ohci",
+		.pm	= &ohci_hcd_at91_pm_ops,
 		.of_match_table	= of_match_ptr(at91_ohci_dt_ids),
 	},
 };
-- 
2.1.4
