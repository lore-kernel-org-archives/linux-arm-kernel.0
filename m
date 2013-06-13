From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 13 Jun 2013 14:46:22 +0530
Subject: [PATCH V2 03/10] USB: OHCI: Properly handle ohci-da8xx suspend
In-Reply-To: <1371114989-2342-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371114989-2342-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371114989-2342-4-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-da8xx glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in ohci_da8xx_suspend() will ensure proper
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
 drivers/usb/host/ohci-da8xx.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 6aaa9c9..8d4914d 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -406,10 +406,21 @@ static int ohci_hcd_da8xx_drv_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM
-static int ohci_da8xx_suspend(struct platform_device *dev, pm_message_t message)
+static int ohci_da8xx_suspend(struct platform_device *pdev,
+		pm_message_t message)
 {
-	struct usb_hcd	*hcd	= platform_get_drvdata(dev);
+	struct usb_hcd	*hcd	= platform_get_drvdata(pdev);
 	struct ohci_hcd	*ohci	= hcd_to_ohci(hcd);
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
@@ -417,8 +428,8 @@ static int ohci_da8xx_suspend(struct platform_device *dev, pm_message_t message)
 
 	ohci_da8xx_clock(0);
 	hcd->state = HC_STATE_SUSPENDED;
-	dev->dev.power.power_state = PMSG_SUSPEND;
-	return 0;
+	pdev->dev.power.power_state = PMSG_SUSPEND;
+	return ret;
 }
 
 static int ohci_da8xx_resume(struct platform_device *dev)
-- 
1.7.9.5
