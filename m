From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Thu,  3 Oct 2013 18:32:04 +0530
Subject: [PATCH V2 02/11] USB: OHCI: Properly handle ohci-at91 suspend
In-Reply-To: <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380805334-19934-3-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci-at91 glue was not properly handled
as it was not suspending generic part of ohci controller. Alan Stern
suggested, properly handle ohci-at91 suspend scenario.

Calling explicitly the ohci_suspend() routine in ohci_hcd_at91_drv_suspend()
will ensure proper handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manju.goudar@lge.com>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-at91.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 476b5a5..13449cc 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -636,9 +636,11 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	int		ret;
 
-	if (device_may_wakeup(&pdev->dev))
-		enable_irq_wake(hcd->irq);
+	ret = ohci_suspend(hcd);
+	if (ret)
+		return ret;
 
 	/*
 	 * The integrated transceivers seem unable to notice disconnect,
@@ -658,7 +660,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 		at91_stop_clock();
 	}
 
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
-- 
1.7.9.5
