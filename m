From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 13 Jun 2013 14:46:25 +0530
Subject: [PATCH V2 06/10] USB: OHCI: Properly handle ohci-omap suspend
In-Reply-To: <1371114989-2342-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371114989-2342-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371114989-2342-7-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-omap glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in ohci_omap_suspend() will ensure proper
handling of suspend scenario.

V2:
 -Incase ohci_suspend() fails, return right away without
  executing further.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-omap.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index b900dba..9144315 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -423,16 +423,27 @@ static int ohci_hcd_omap_drv_remove(struct platform_device *dev)
 
 #ifdef	CONFIG_PM
 
-static int ohci_omap_suspend(struct platform_device *dev, pm_message_t message)
+static int ohci_omap_suspend(struct platform_device *pdev, pm_message_t message)
 {
-	struct ohci_hcd	*ohci = hcd_to_ohci(platform_get_drvdata(dev));
+	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(&pdev->dev);
+	int ret;
+
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
+		ohci_resume(hcd, false);
+		ret = -EBUSY;
+	}
+	if (ret)
+		return ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
 	omap_ohci_clock_power(0);
-	return 0;
+	return ret;
 }
 
 static int ohci_omap_resume(struct platform_device *dev)
-- 
1.7.9.5
