From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 20 Jun 2013 15:06:05 +0530
Subject: [PATCH V4 09/11] USB: OHCI: Properly handle ohci-pxa27x suspend
In-Reply-To: <1371720968-7533-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371720968-7533-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371720968-7533-10-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-pxa27x glue was not
properly handled as it was not suspending generic part
of ohci controller. Calling explicitly the ohci_suspend()
routine in ohci_hcd_pxa27x_drv_suspend() will ensure proper
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

V4:
 -The do_wakeup and ret variable alignment is removed.
---
 drivers/usb/host/ohci-pxa27x.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 3a9c01d..5fb91f1 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -564,13 +564,19 @@ static int ohci_hcd_pxa27x_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct pxa27x_ohci *ohci = to_pxa27x_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(dev);
+	int ret;
 
 	if (time_before(jiffies, ohci->ohci.next_statechange))
 		msleep(5);
 	ohci->ohci.next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret)
+		return ret;
+
 	pxa27x_stop_hc(ohci, dev);
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_pxa27x_drv_resume(struct device *dev)
-- 
1.7.9.5
