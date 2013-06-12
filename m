From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 12 Jun 2013 20:58:37 +0530
Subject: [PATCH 09/10] USB: OHCI: Properly handle ohci-sm501 suspend
In-Reply-To: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371050918-29472-10-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-sm501 glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in ohci_sm501_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-sm501.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index d479d5d..f4f2da0 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -216,14 +216,19 @@ static int ohci_hcd_sm501_drv_remove(struct platform_device *pdev)
 static int ohci_sm501_suspend(struct platform_device *pdev, pm_message_t msg)
 {
 	struct device *dev = &pdev->dev;
-	struct ohci_hcd	*ohci = hcd_to_ohci(platform_get_drvdata(pdev));
+	struct usb_hcd  *hcd = platform_get_drvdata(pdev);
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(dev);
+	int ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd, do_wakeup);
+
 	sm501_unit_power(dev->parent, SM501_GATE_USB_HOST, 0);
-	return 0;
+	return ret;
 }
 
 static int ohci_sm501_resume(struct platform_device *pdev)
-- 
1.7.9.5
