From: wonhongkwon@gmail.com (Wonhong Kwon)
Date: Thu, 23 Oct 2014 17:48:55 +0900
Subject: [PATCH] usb: ehci/ohci: use SIMPLE_DEV_PM_OPS to support hibernation
Message-ID: <1414054135-14428-1-git-send-email-wonhong.kwon@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ehci/ohci just define .suspend/.resume functions for dev_pm_ops, but
in order to support both STR(suspend-to-ram) and hibernation, other
callbacks such as .freeze/.thaw are also required.

Registering all required callbacks for both STR and hibernation can
be done by SIMPLE_DEV_PM_OPS macro function.

Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>
---
 drivers/usb/host/ehci-platform.c |   13 +++++--------
 drivers/usb/host/ohci-platform.c |   13 +++++--------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 2f5b9ce..9aee03f 100644
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
@@ -349,10 +348,10 @@ static int ehci_platform_resume(struct device *dev)
 	return 0;
 }
 
-#else /* !CONFIG_PM */
+#else /* !CONFIG_PM_SLEEP */
 #define ehci_platform_suspend	NULL
 #define ehci_platform_resume	NULL
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct of_device_id vt8500_ehci_ids[] = {
 	{ .compatible = "via,vt8500-ehci", },
@@ -368,10 +367,8 @@ static const struct platform_device_id ehci_platform_table[] = {
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
index 4369299..70b912f 100644
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
@@ -336,10 +335,10 @@ static int ohci_platform_resume(struct device *dev)
 	return 0;
 }
 
-#else /* !CONFIG_PM */
+#else /* !CONFIG_PM_SLEEP */
 #define ohci_platform_suspend	NULL
 #define ohci_platform_resume	NULL
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_SLEEP */
 
 static const struct of_device_id ohci_platform_ids[] = {
 	{ .compatible = "generic-ohci", },
@@ -353,10 +352,8 @@ static const struct platform_device_id ohci_platform_table[] = {
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
