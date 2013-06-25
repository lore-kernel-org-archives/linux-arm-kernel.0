From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Tue, 25 Jun 2013 12:09:40 +0530
Subject: [PATCH V4 05/11] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <1372142386-10691-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1372142386-10691-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1372142386-10691-6-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-ep93xx glue was not
properly handled as it was not suspending generic part
of ohci controller. Calling explicitly the ohci_suspend()
routine in ohci_hcd_ep93xx_drv_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -Incase ohci_suspend() fails, return right away without
  executing further.
V3:
 -Aligned variable "do_wakeup" and "ret".
V4:
 -The do_wakeup and ret variable alignment is removed.
---
 drivers/usb/host/ohci-ep93xx.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
index 8704e9f..f0aaa48 100644
--- a/drivers/usb/host/ohci-ep93xx.c
+++ b/drivers/usb/host/ohci-ep93xx.c
@@ -174,13 +174,20 @@ static int ohci_hcd_ep93xx_drv_suspend(struct platform_device *pdev, pm_message_
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(&pdev->dev);
+	int ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret)
+		return ret;
+
 	ep93xx_stop_hc(&pdev->dev);
-	return 0;
+
+	return ret;
 }
 
 static int ohci_hcd_ep93xx_drv_resume(struct platform_device *pdev)
-- 
1.7.9.5
