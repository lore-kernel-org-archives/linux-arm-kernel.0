From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:24:06 +0100
Subject: [PATCH 4/6] usb: ehci-atmel: use __maybe_unused to hide pm functions
In-Reply-To: <1456932255-71725-1-git-send-email-arnd@arndb.de>
References: <1456932255-71725-1-git-send-email-arnd@arndb.de>
Message-ID: <1456932255-71725-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ehci-atmel driver uses #ifdef to check for CONFIG_PM, but then
uses SIMPLE_DEV_PM_OPS, which leaves the references out when
CONFIG_PM_SLEEP is not defined, so we get a warning with
PM=y && PM_SLEEP=n:

drivers/usb/host/ehci-atmel.c:189:12: error: 'ehci_atmel_drv_suspend' defined but not used [-Werror=unused-function]
drivers/usb/host/ehci-atmel.c:203:12: error: 'ehci_atmel_drv_resume' defined but not used [-Werror=unused-function]

This removes the incorrect #ifdef and instead uses a __maybe_unused
annotation to let the compiler know it can silently drop
the function definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ehci-atmel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index be0964a801e8..7440722bfbf0 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -185,8 +185,7 @@ static int ehci_atmel_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ehci_atmel_drv_suspend(struct device *dev)
+static int __maybe_unused ehci_atmel_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct atmel_ehci_priv *atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
@@ -200,7 +199,7 @@ static int ehci_atmel_drv_suspend(struct device *dev)
 	return 0;
 }
 
-static int ehci_atmel_drv_resume(struct device *dev)
+static int __maybe_unused ehci_atmel_drv_resume(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct atmel_ehci_priv *atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
@@ -208,7 +207,6 @@ static int ehci_atmel_drv_resume(struct device *dev)
 	atmel_start_clock(atmel_ehci);
 	return ehci_resume(hcd, false);
 }
-#endif
 
 #ifdef CONFIG_OF
 static const struct of_device_id atmel_ehci_dt_ids[] = {
-- 
2.7.0
