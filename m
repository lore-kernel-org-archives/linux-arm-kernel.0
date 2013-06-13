From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 13 Jun 2013 14:41:01 +0530
Subject: [PATCH 10/10] USB: OHCI: Properly handle ohci-spear suspend
In-Reply-To: <1371114661-2207-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371114661-2207-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371114661-2207-11-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-spear glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in spear_ohci_hcd_drv_suspend() will ensure proper
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
 drivers/usb/host/ohci-spear.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 31ff3fc..2ff867b 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -130,12 +130,22 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 }
 
 #if defined(CONFIG_PM)
-static int spear_ohci_hcd_drv_suspend(struct platform_device *dev,
+static int spear_ohci_hcd_drv_suspend(struct platform_device *pdev,
 		pm_message_t message)
 {
-	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
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
@@ -143,7 +153,7 @@ static int spear_ohci_hcd_drv_suspend(struct platform_device *dev,
 
 	clk_disable_unprepare(sohci_p->clk);
 
-	return 0;
+	return ret;
 }
 
 static int spear_ohci_hcd_drv_resume(struct platform_device *dev)
-- 
1.7.9.5
