From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 12 Jun 2013 20:58:30 +0530
Subject: [PATCH 02/10] USB: OHCI: Properly handle ohci-s3c2410 suspend
In-Reply-To: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371050918-29472-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-s3c2410 glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in ohci_hcd_s3c2410_drv_suspend() will ensure
proper handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-s3c2410.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 8018bb1..2ffa693 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -430,6 +430,7 @@ static int ohci_hcd_s3c2410_drv_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	unsigned long flags;
 	int rc = 0;
+	bool do_wakeup = device_may_wakeup(dev);
 
 	/*
 	 * Root hub was already suspended. Disable irq emission and
@@ -445,6 +446,8 @@ static int ohci_hcd_s3c2410_drv_suspend(struct device *dev)
 
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 
+	rc = ohci_suspend(hcd, do_wakeup);
+
 	s3c2410_stop_hc(pdev);
 bail:
 	spin_unlock_irqrestore(&ohci->lock, flags);
-- 
1.7.9.5
