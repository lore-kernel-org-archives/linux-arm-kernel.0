From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Tue,  8 Apr 2014 20:10:35 +0530
Subject: [PATCH RESEND] usb: ohci-exynos: Remove locks for 'ohci' in suspend
 callback
Message-ID: <1396968035-32286-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch : 14982e3 USB: OHCI: Properly handle ohci-exynos suspend
has already removed 'ohci_hcd' settings from exynos glue layer
as a part of streamlining the ohci controller's suspend.
So we don't need the locks for 'ohci_hcd' anymore.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
Cc: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ohci-exynos.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 68588d8..9cf80cb 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -190,17 +190,13 @@ static int exynos_ohci_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
-	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	struct platform_device *pdev = to_platform_device(dev);
 	bool do_wakeup = device_may_wakeup(dev);
-	unsigned long flags;
 	int rc = ohci_suspend(hcd, do_wakeup);
 
 	if (rc)
 		return rc;
 
-	spin_lock_irqsave(&ohci->lock, flags);
-
 	if (exynos_ohci->otg)
 		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
 
@@ -208,8 +204,6 @@ static int exynos_ohci_suspend(struct device *dev)
 
 	clk_disable_unprepare(exynos_ohci->clk);
 
-	spin_unlock_irqrestore(&ohci->lock, flags);
-
 	return 0;
 }
 
-- 
1.7.10.4
