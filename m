From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 13 Jun 2013 14:46:20 +0530
Subject: [PATCH V2 01/10] USB: OHCI: Properly handle ohci-at91 suspend
In-Reply-To: <1371114989-2342-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371114989-2342-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371114989-2342-2-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-at91 glue was not properly
handled as it was not suspending generic part of ohci controller.
Calling explicitly the ohci_suspend() routine in ohci_hcd_at91_drv_suspend()
will ensure proper handling of suspend scenario.

V2:
  -Incase ohci_suspend() fails, return right away without executing further.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-at91.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index fb2f127..6620e3a 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -619,8 +619,18 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(&pdev->dev);
+	int ret;
 
-	if (device_may_wakeup(&pdev->dev))
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
+		ohci_resume(hcd, false);
+		ret = -EBUSY;
+	}
+	if (ret)
+		return ret;
+
+	if (do_wakeup)
 		enable_irq_wake(hcd->irq);
 
 	/*
@@ -637,7 +647,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 		at91_stop_clock();
 	}
 
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
-- 
1.7.9.5
