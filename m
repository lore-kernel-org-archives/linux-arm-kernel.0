From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 13 Jun 2013 14:40:53 +0530
Subject: [PATCH 02/10] USB: OHCI: Properly handle ohci-s3c2410 suspend
In-Reply-To: <1371114661-2207-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371114661-2207-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371114661-2207-3-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-s3c2410 glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in ohci_hcd_s3c2410_drv_suspend() will ensure
proper handling of suspend scenario.

V2:
 -Incase ohci_suspend() fails, return right away
  without executing further.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-s3c2410.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 8018bb1..01430f2 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -430,7 +430,15 @@ static int ohci_hcd_s3c2410_drv_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	unsigned long flags;
 	int rc = 0;
+	bool do_wakeup = device_may_wakeup(dev);
 
+	rc = ohci_suspend(hcd, do_wakeup);
+	if (rc == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
+		ohci_resume(hcd, false);
+		rc = -EBUSY;
+	}
+	if (rc)
+		return rc;
 	/*
 	 * Root hub was already suspended. Disable irq emission and
 	 * mark HW unaccessible, bail out if RH has been resumed. Use
-- 
1.7.9.5
