From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Thu,  3 Oct 2013 18:32:06 +0530
Subject: [PATCH V2 04/11] USB: OHCI: Properly handle ohci-da8xx suspend
In-Reply-To: <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380805334-19934-5-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci-da8xx glue was not
properly handled as it was not suspending generic part
of ohci controller. Alan Stern suggested, properly handle
ohci-da8xx suspend scenario.

Calling explicitly the ohci_suspend()
routine in ohci_da8xx_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manju.goudar@lge.com>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-da8xx.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 9be59f1..4b9a7a3 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -406,19 +406,25 @@ static int ohci_hcd_da8xx_drv_remove(struct platform_device *dev)
 }
 
 #ifdef CONFIG_PM
-static int ohci_da8xx_suspend(struct platform_device *dev, pm_message_t message)
+static int ohci_da8xx_suspend(struct platform_device *pdev,
+				pm_message_t message)
 {
-	struct usb_hcd	*hcd	= platform_get_drvdata(dev);
+	struct usb_hcd	*hcd	= platform_get_drvdata(pdev);
 	struct ohci_hcd	*ohci	= hcd_to_ohci(hcd);
+	int		ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd);
+	if (ret)
+		return ret;
+
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
