From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 19 Jun 2013 17:42:07 +0530
Subject: [PATCH V3 02/11] USB: OHCI: Properly handle ohci-at91 suspend
In-Reply-To: <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371643936-3314-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-at91 glue was not properly
handled as it was not suspending generic part of ohci controller.
Calling explicitly the ohci_suspend() routine in ohci_hcd_at91_drv_suspend()
will ensure proper handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
  -Incase ohci_suspend() fails, return right away without executing further.

V3:
 -Aligned variable "do_wakeup" and "ret".
---
 drivers/usb/host/ohci-at91.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index fb2f127..e34baa6 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -619,8 +619,14 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	bool		do_wakeup = device_may_wakeup(&pdev->dev);
+	int		ret;
 
-	if (device_may_wakeup(&pdev->dev))
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret)
+		return ret;
+
+	if (do_wakeup)
 		enable_irq_wake(hcd->irq);
 
 	/*
@@ -637,7 +643,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 		at91_stop_clock();
 	}
 
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
-- 
1.7.9.5
