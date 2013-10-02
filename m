From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Wed,  2 Oct 2013 15:45:42 +0530
Subject: [PATCH 06/11] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380708947-15966-7-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci-exynos glue was not
properly handled as it was not suspending generic part
of ohci controller. Alan Stern suggested, properly handle
ohci-exynos suspend scenario.

Calling explicitly the ohci_suspend() routine in
exynos_ohci_suspend() will ensure proper handling of suspend
scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-exynos.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index 3e4bc74..f5f372e 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -203,24 +203,15 @@ static int exynos_ohci_suspend(struct device *dev)
 	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	struct platform_device *pdev = to_platform_device(dev);
+	bool do_wakeup = device_may_wakeup(dev);
 	unsigned long flags;
 	int rc = 0;
 
-	/*
-	 * Root hub was already suspended. Disable irq emission and
-	 * mark HW unaccessible, bail out if RH has been resumed. Use
-	 * the spinlock to properly synchronize with possible pending
-	 * RH suspend or resume activity.
-	 */
-	spin_lock_irqsave(&ohci->lock, flags);
-	if (ohci->rh_state != OHCI_RH_SUSPENDED &&
-			ohci->rh_state != OHCI_RH_HALTED) {
-		rc = -EINVAL;
-		goto fail;
-	}
-
-	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	rc = ohci_suspend(hcd, do_wakeup);
+	if (rc)
+		return rc;
 
+	spin_lock_irqsave(&ohci->lock, flags);
 	if (exynos_ohci->otg)
 		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
 
@@ -228,7 +219,6 @@ static int exynos_ohci_suspend(struct device *dev)
 
 	clk_disable_unprepare(exynos_ohci->clk);
 
-fail:
 	spin_unlock_irqrestore(&ohci->lock, flags);
 
 	return rc;
-- 
1.7.9.5
