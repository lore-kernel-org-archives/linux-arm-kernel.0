From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Wed, 13 Nov 2013 17:40:17 +0530
Subject: [PATCH 2/6] USB: OHCI: Properly handle ohci-at91 suspend
In-Reply-To: <1384344621-6981-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1384344621-6981-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1384344621-6981-3-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-at91 glue was not properly handled
as it was not suspending generic part of ohci controller. Alan Stern
suggested, properly handle ohci-at91 suspend scenario.

Calling explicitly the ohci_suspend() routine in ohci_hcd_at91_drv_suspend()
will ensure proper handling of suspend scenario. This task is sugested
by Alan Stern.

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-at91.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index 476b5a5..71eff0b 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -636,10 +636,17 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	bool		do_wakeup = device_may_wakeup(&pdev->dev);
+	int		ret;
 
-	if (device_may_wakeup(&pdev->dev))
+	if (do_wakeup)
 		enable_irq_wake(hcd->irq);
 
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret) {
+		disable_irq_wake(hcd->irq);
+		return ret;
+	}
 	/*
 	 * The integrated transceivers seem unable to notice disconnect,
 	 * reconnect, or wakeup without the 48 MHz clock active.  so for
@@ -658,7 +665,7 @@ ohci_hcd_at91_drv_suspend(struct platform_device *pdev, pm_message_t mesg)
 		at91_stop_clock();
 	}
 
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_at91_drv_resume(struct platform_device *pdev)
-- 
1.7.9.5
