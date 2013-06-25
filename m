From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue, 25 Jun 2013 12:09:41 +0530
Subject: [PATCH V4 06/11] USB: OHCI: Properly handle ohci-exynos suspend
In-Reply-To: <1372142386-10691-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1372142386-10691-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1372142386-10691-7-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-exynos glue was not
properly handled as it was not suspending generic part
of ohci controller. Calling explicitly the ohci_suspend()
routine in exynos_ohci_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -Incase ohci_suspend() fails, return right away without
  executing further.

V3:
 -rid of unwanted code from ohci_hcd_s3c2410_drv_suspend() which already
  ohci_suspend() does it.
 -Aligned variable "do_wakeup" and "ret".

V4:
 -The do_wakeup and rc variable alignment is removed.
---
 drivers/usb/host/ohci-exynos.c |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index ae6068d..17de3dd 100644
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
