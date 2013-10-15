From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Tue, 15 Oct 2013 18:49:57 +0530
Subject: [PATCH V2 2/7] USB: OHCI: Properly handle ohci-at91 suspend
In-Reply-To: <1381843202-28707-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1381843202-28707-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1381843202-28707-3-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci-at91 glue was not properly handled
as it was not suspending generic part of ohci controller. Alan Stern
suggested, properly handle ohci-at91 suspend scenario.

Calling explicitly the ohci_suspend() routine in ohci_hcd_at91_drv_suspend()
will ensure proper handling of suspend scenario. This task is sugested
by Alan Stern.

V1->V2:
      Due to version mismatch and build failure on ep93xx reverted this patch. 
      This is a proper patch for ohci-at91 suspend as Alan Stern mentioned.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-at91.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 476b5a5..f2d8403 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -636,8 +636,14 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
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
@@ -658,7 +664,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 		at91_stop_clock();
 	}
 
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
-- 
1.7.9.5
