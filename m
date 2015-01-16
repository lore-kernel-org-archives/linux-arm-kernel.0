From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Fri, 16 Jan 2015 20:41:14 +0100
Subject: [PATCH] USB: host: ehci_atmel: Add suspend/resume support
Message-ID: <1421437274-31615-1-git-send-email-sylvain.rochet@finsecur.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add suspend/resume support for Atmel EHCI, mostly
about disabling and unpreparing clocks so USB PLL is stopped
before entering sleep state.

Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
---
 drivers/usb/host/ehci-atmel.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 56a8850..790de92 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/atmel.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 
@@ -174,6 +175,36 @@ static int ehci_atmel_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int ehci_atmel_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = ehci_suspend(hcd, false);
+	if (ret)
+		return ret;
+
+	if (at91_suspend_entering_slow_clock())
+		atmel_stop_clock();
+
+	return 0;
+}
+
+static int ehci_atmel_drv_resume(struct platform_device *pdev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+
+	if (!clocked)
+		atmel_start_clock();
+
+	return ehci_resume(hcd, false);
+}
+#else
+#define ehci_atmel_drv_suspend NULL
+#define ehci_atmel_drv_resume  NULL
+#endif
+
 #ifdef CONFIG_OF
 static const struct of_device_id atmel_ehci_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9g45-ehci" },
@@ -187,6 +218,8 @@ static struct platform_driver ehci_atmel_driver = {
 	.probe		= ehci_atmel_drv_probe,
 	.remove		= ehci_atmel_drv_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
+	.suspend	= ehci_atmel_drv_suspend,
+	.resume		= ehci_atmel_drv_resume,
 	.driver		= {
 		.name	= "atmel-ehci",
 		.of_match_table	= of_match_ptr(atmel_ehci_dt_ids),
-- 
2.1.4
