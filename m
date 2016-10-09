From: linux.amoon@gmail.com (Anand Moon)
Date: Sun,  9 Oct 2016 14:34:15 +0000
Subject: [PATCH 2/2] host: ohci-exynos: Convert to use the
 SET_SYSTEM_SLEEP_PM_OPS
In-Reply-To: <1476023655-3232-1-git-send-email-linux.amoon@gmail.com>
References: <1476023655-3232-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1476023655-3232-2-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the ohci-exynos system PM callbacks within #ifdef CONFIG_PM_SLEEP
as to avoid them being build when not used. This also allows us to use the
SET_SYSTEM_SLEEP_PM_OPS macro which simplifies the code.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/usb/host/ohci-exynos.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 2cd105b..1764baa 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -219,7 +219,7 @@ static void exynos_ohci_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int exynos_ohci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -256,18 +256,16 @@ static int exynos_ohci_resume(struct device *dev)
 
 	return 0;
 }
-#else
-#define exynos_ohci_suspend	NULL
-#define exynos_ohci_resume	NULL
-#endif
 
-static const struct ohci_driver_overrides exynos_overrides __initconst = {
-	.extra_priv_size =	sizeof(struct exynos_ohci_hcd),
+static const struct dev_pm_ops exynos_ohci_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(exynos_ohci_suspend, exynos_ohci_resume)
 };
+#endif /* CONFIG_PM_SLEEP */
 
-static const struct dev_pm_ops exynos_ohci_pm_ops = {
-	.suspend	= exynos_ohci_suspend,
-	.resume		= exynos_ohci_resume,
+#define DEV_PM_OPS IS_ENABLED(CONFIG_PM_SLEEP) ? &exynos_ohci_pm_ops : NULL
+
+static const struct ohci_driver_overrides exynos_overrides __initconst = {
+	.extra_priv_size =	sizeof(struct exynos_ohci_hcd),
 };
 
 #ifdef CONFIG_OF
@@ -285,7 +283,7 @@ static struct platform_driver exynos_ohci_driver = {
 	.shutdown	= exynos_ohci_shutdown,
 	.driver = {
 		.name	= "exynos-ohci",
-		.pm	= &exynos_ohci_pm_ops,
+		.pm	= DEV_PM_OPS,
 		.of_match_table	= of_match_ptr(exynos_ohci_match),
 	}
 };
-- 
2.7.4
