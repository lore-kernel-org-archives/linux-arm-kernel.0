From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 19 Jun 2013 17:42:09 +0530
Subject: [PATCH V3 04/11] USB: OHCI: Properly handle ohci-da8xx suspend
In-Reply-To: <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371643936-3314-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371643936-3314-5-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-da8xx glue was not
properly handled as it was not suspending generic part
of ohci controller. Calling explicitly the ohci_suspend()
routine in ohci_da8xx_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V2:
 -Incase ohci_suspend() fails, return right away without
  executing further.
V3:
 -Aligned variable "do_wakeup" and "ret".
 -pdev->dev.power.power_state stuff has been removed.
---
 drivers/usb/host/ohci-da8xx.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 6aaa9c9..78a6124 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -406,19 +406,26 @@ static int ohci_hcd_da8xx_drv_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM
-static int ohci_da8xx_suspend(struct platform_device *dev, pm_message_t message)
+static int ohci_da8xx_suspend(struct platform_device *pdev,
+		pm_message_t message)
 {
-	struct usb_hcd	*hcd	= platform_get_drvdata(dev);
+	struct usb_hcd	*hcd	= platform_get_drvdata(pdev);
 	struct ohci_hcd	*ohci	= hcd_to_ohci(hcd);
+	bool		do_wakeup = device_may_wakeup(&pdev->dev);
+	int		ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
-	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret)
+		return ret;
+
+	ohci->next_statechange = jiffies;
 	ohci_da8xx_clock(0);
 	hcd->state = HC_STATE_SUSPENDED;
-	dev->dev.power.power_state = PMSG_SUSPEND;
-	return 0;
+
+	return ret;
 }
 
 static int ohci_da8xx_resume(struct platform_device *dev)
-- 
1.7.9.5
