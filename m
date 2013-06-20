From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 20 Jun 2013 15:05:59 +0530
Subject: [PATCH V4 03/11] USB: OHCI: Properly handle ohci-s3c2410 suspend
In-Reply-To: <1371720968-7533-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371720968-7533-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371720968-7533-4-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-s3c2410 glue was not
properly handled as it was not suspending generic part
of ohci controller. Calling explicitly the ohci_suspend()
routine in ohci_hcd_s3c2410_drv_suspend() will ensure
proper handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -Incase ohci_suspend() fails, return right away without
  executing further.
V3:
 -rid of unwanted code from ohci_hcd_s3c2410_drv_suspend()
  which already ohci_suspend() does it.

V4:
 -The do_wakeup variable alignment is removed.
---
 drivers/usb/host/ohci-s3c2410.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 8018bb1..4ccf156 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -428,26 +428,15 @@ static int ohci_hcd_s3c2410_drv_suspend(struct device *dev)
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
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
-	if (ohci->rh_state != OHCI_RH_SUSPENDED) {
-		rc = -EINVAL;
-		goto bail;
-	}
-
-	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	rc = ohci_suspend(hcd, do_wakeup);
+	if (rc)
+		return rc;
 
 	s3c2410_stop_hc(pdev);
-bail:
-	spin_unlock_irqrestore(&ohci->lock, flags);
 
 	return rc;
 }
-- 
1.7.9.5
