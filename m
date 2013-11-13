From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Wed, 13 Nov 2013 17:40:20 +0530
Subject: [PATCH 5/6] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <1384344621-6981-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1384344621-6981-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1384344621-6981-6-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-exynos glue was not
properly handled as it was not suspending generic part
of ohci controller. Alan Stern suggested, properly handle
ohci-exynos suspend scenario.

Calling explicitly the ohci_suspend() routine in
exynos_ohci_suspend() will ensure proper handling of suspend
scenario.

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-exynos.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index a87baed..4b5c8bd 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -192,23 +192,14 @@ static int exynos_ohci_suspend(struct device *dev)
 	struct exynos_ohci_hcd *exynos_ohci = to_exynos_ohci(hcd);
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	struct platform_device *pdev = to_platform_device(dev);
+	bool do_wakeup = device_may_wakeup(dev);
 	unsigned long flags;
-	int rc = 0;
+	int rc = ohci_suspend(hcd, do_wakeup);
 
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
+	if (rc)
+		return rc;
 
-	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	spin_lock_irqsave(&ohci->lock, flags);
 
 	if (exynos_ohci->otg)
 		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
@@ -217,10 +208,9 @@ static int exynos_ohci_suspend(struct device *dev)
 
 	clk_disable_unprepare(exynos_ohci->clk);
 
-fail:
 	spin_unlock_irqrestore(&ohci->lock, flags);
 
-	return rc;
+	return 0;
 }
 
 static int exynos_ohci_resume(struct device *dev)
-- 
1.7.9.5
