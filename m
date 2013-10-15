From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Tue, 15 Oct 2013 18:50:00 +0530
Subject: [PATCH V2 5/7] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <1381843202-28707-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1381843202-28707-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1381843202-28707-6-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Majunath Goudar <manju.goudar@lge.com>

Suspend scenario in case of ohci-ep93xx glue was not
properly handled as it was not suspending generic part
of ohci controller. Alan Stern suggested, properly handle
ohci-ep93xx suspend scenario.

Calling explicitly the ohci_suspend() routine in
ohci_hcd_ep93xx_drv_suspend() will ensure proper handling of
suspend scenario.

Signed-off-by: Manjunath Goudar <manju.goudar@lge.com>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V1->V2:
   -Fixed Olof Johansson reported build error:
   drivers/usb/host/ohci-ep93xx.c: In function 'ohci_hcd_ep93xx_drv_suspend':
   drivers/usb/host/ohci-ep93xx.c:126:2: error: implicit declaration of
   function 'ep93xx_stop_hc'
---
 drivers/usb/host/ohci-ep93xx.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-ep93xx.c b/drivers/usb/host/ohci-ep93xx.c
index 492f681..77ebdc8 100644
--- a/drivers/usb/host/ohci-ep93xx.c
+++ b/drivers/usb/host/ohci-ep93xx.c
@@ -112,12 +112,15 @@ static int ohci_hcd_ep93xx_drv_suspend(struct platform_device *pdev, pm_message_
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(&pdev->dev);
+	int ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
-
-	clk_disable(usb_host_clock);
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret)
+		return ret;
 	return 0;
 }
 
-- 
1.7.9.5
