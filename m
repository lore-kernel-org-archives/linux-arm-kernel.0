From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:24:04 +0100
Subject: [PATCH 2/6] usb: xhci-mtk: use __maybe_unused to hide pm functions
In-Reply-To: <1456932255-71725-1-git-send-email-arnd@arndb.de>
References: <1456932255-71725-1-git-send-email-arnd@arndb.de>
Message-ID: <1456932255-71725-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mediatek XHCI glue driver uses SET_SYSTEM_SLEEP_PM_OPS() to
conditionally set the correct suspend/resume options, and
also puts both the dev_pm_ops and the functions inside of
an #ifdef testing for CONFIG_PM_SLEEP, but those functions
then call other code that becomes unused:

drivers/usb/host/xhci-mtk.c:135:12: error: 'xhci_mtk_host_disable' defined but not used [-Werror=unused-function]
drivers/usb/host/xhci-mtk.c:313:13: error: 'usb_wakeup_enable' defined but not used [-Werror=unused-function]
drivers/usb/host/xhci-mtk.c:321:13: error: 'usb_wakeup_disable' defined but not used [-Werror=unused-function]

This replaces the #ifdef with __maybe_unused annotations so the
compiler knows it can silently drop them instead of warning.

For the DEV_PM_OPS definition, we can use an IS_ENABLED() check
to avoid defining the structure when CONFIG_PM is not set without
the #ifdef.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/xhci-mtk.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 9532f5aef71b..79959f17c38c 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -695,7 +695,6 @@ static int xhci_mtk_remove(struct platform_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 /*
  * if ip sleep fails, and all clocks are disabled, access register will hang
  * AHB bus, so stop polling roothubs to avoid regs access on bus suspend.
@@ -703,7 +702,7 @@ static int xhci_mtk_remove(struct platform_device *dev)
  * to wake up system immediately after system suspend complete if ip sleep
  * fails, it is what we wanted.
  */
-static int xhci_mtk_suspend(struct device *dev)
+static int __maybe_unused xhci_mtk_suspend(struct device *dev)
 {
 	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
 	struct usb_hcd *hcd = mtk->hcd;
@@ -722,7 +721,7 @@ static int xhci_mtk_suspend(struct device *dev)
 	return 0;
 }
 
-static int xhci_mtk_resume(struct device *dev)
+static int __maybe_unused xhci_mtk_resume(struct device *dev)
 {
 	struct xhci_hcd_mtk *mtk = dev_get_drvdata(dev);
 	struct usb_hcd *hcd = mtk->hcd;
@@ -744,10 +743,7 @@ static int xhci_mtk_resume(struct device *dev)
 static const struct dev_pm_ops xhci_mtk_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(xhci_mtk_suspend, xhci_mtk_resume)
 };
-#define DEV_PM_OPS	(&xhci_mtk_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif /* CONFIG_PM */
+#define DEV_PM_OPS IS_ENABLED(CONFIG_PM) ? &xhci_mtk_pm_ops : NULL
 
 #ifdef CONFIG_OF
 static const struct of_device_id mtk_xhci_of_match[] = {
-- 
2.7.0
