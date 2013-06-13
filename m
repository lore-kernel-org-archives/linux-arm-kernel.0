From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 13 Jun 2013 14:46:27 +0530
Subject: [PATCH V2 08/10] USB: OHCI: Properly handle ohci-pxa27x suspend
In-Reply-To: <1371114989-2342-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371114989-2342-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371114989-2342-9-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-pxa27x glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in ohci_hcd_pxa27x_drv_suspend() will ensure proper
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
 drivers/usb/host/ohci-pxa27x.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 3a9c01d..d441a87 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -564,13 +564,23 @@ static int ohci_hcd_pxa27x_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct pxa27x_ohci *ohci = to_pxa27x_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(dev);
+	int ret;
+
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret == 0 && do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
+		ohci_resume(hcd, false);
+		ret = -EBUSY;
+	}
+	if (ret)
+		return ret;
 
 	if (time_before(jiffies, ohci->ohci.next_statechange))
 		msleep(5);
 	ohci->ohci.next_statechange = jiffies;
 
 	pxa27x_stop_hc(ohci, dev);
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_pxa27x_drv_resume(struct device *dev)
-- 
1.7.9.5
