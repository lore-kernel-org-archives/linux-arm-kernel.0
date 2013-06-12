From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 12 Jun 2013 20:58:32 +0530
Subject: [PATCH 04/10] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371050918-29472-5-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-ep93xx glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in ohci_hcd_ep93xx_drv_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-ep93xx.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
index 8704e9f..7c77f61 100644
--- a/drivers/usb/host/ohci-ep93xx.c
+++ b/drivers/usb/host/ohci-ep93xx.c
@@ -174,13 +174,17 @@ static int ohci_hcd_ep93xx_drv_suspend(struct platform_device *pdev, pm_message_
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(&pdev->dev);
+	int ret;
+
+	ret = ohci_suspend(hcd, do_wakeup);
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
 	ep93xx_stop_hc(&pdev->dev);
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_ep93xx_drv_resume(struct platform_device *pdev)
-- 
1.7.9.5
