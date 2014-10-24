From: wonhongkwon@gmail.com (Wonhong Kwon)
Date: Fri, 24 Oct 2014 13:45:47 +0900
Subject: [PATCH v2] usb: ehci/ohci-platform: use SIMPLE_DEV_PM_OPS to support
 hibernation
Message-ID: <1414125947-23522-1-git-send-email-wonhong.kwon@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ehci/ohci-platform just define .suspend/.resume functions for dev_pm_ops,
but in order to support both STR(suspend-to-ram) and hibernation, other
callbacks such as .freeze/.thaw are also required.

Registering all required callbacks for both STR and hibernation can
be done by SIMPLE_DEV_PM_OPS macro function.

Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-platform.c |   15 ++++-----------
 drivers/usb/host/ohci-platform.c |   15 ++++-----------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 2f5b9ce..da056fe 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -311,8 +311,7 @@ static int ehci_platform_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
+#ifdef CONFIG_PM_SLEEP
 static int ehci_platform_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -348,11 +347,7 @@ static int ehci_platform_resume(struct device *dev)
 	ehci_resume(hcd, false);
 	return 0;
 }
-
-#else /* !CONFIG_PM */
-#define ehci_platform_suspend	NULL
-#define ehci_platform_resume	NULL
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
@@ -368,10 +363,8 @@ static const struct platform_device_id ehci_platform_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, ehci_platform_table);
 
-static const struct dev_pm_ops ehci_platform_pm_ops = {
-	.suspend	= ehci_platform_suspend,
-	.resume		= ehci_platform_resume,
-};
+static SIMPLE_DEV_PM_OPS(ehci_platform_pm_ops, ehci_platform_suspend,
+	ehci_platform_resume);
 
 static struct platform_driver ehci_platform_driver = {
 	.id_table	= ehci_platform_table,
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 4369299..c6f5e03 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -298,8 +298,7 @@ static int ohci_platform_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
+#ifdef CONFIG_PM_SLEEP
 static int ohci_platform_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -335,11 +334,7 @@ static int ohci_platform_resume(struct device *dev)
 	ohci_resume(hcd, false);
 	return 0;
 }
-
-#else /* !CONFIG_PM */
-#define ohci_platform_suspend	NULL
-#define ohci_platform_resume	NULL
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct of_device_id ohci_platform_ids[] = {
 	{ .compatible = "generic-ohci", },
@@ -353,10 +348,8 @@ static const struct platform_device_id ohci_platform_table[] = {
 };
 MODULE_DEVICE_TABLE(platform, ohci_platform_table);
 
-static const struct dev_pm_ops ohci_platform_pm_ops = {
-	.suspend	= ohci_platform_suspend,
-	.resume		= ohci_platform_resume,
-};
+static SIMPLE_DEV_PM_OPS(ohci_platform_pm_ops, ohci_platform_suspend,
+	ohci_platform_resume);
 
 static struct platform_driver ohci_platform_driver = {
 	.id_table	= ohci_platform_table,
-- 
1.7.9.5
