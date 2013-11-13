From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Wed, 13 Nov 2013 17:40:21 +0530
Subject: [PATCH 6/6] USB: OHCI: Properly handle ohci-spear suspend
In-Reply-To: <1384344621-6981-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1384344621-6981-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1384344621-6981-7-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-spear glue was not
properly handled as it was not suspending generic part
of ohci controller.  Alan Stern suggested, properly handle
ohci-spear suspend scenario.

Calling explicitly the ohci_suspend() routine in
spear_ohci_hcd_drv_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-spear.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 31ff3fc..41148f8 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -130,20 +130,26 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
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
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret)
+		return ret;
+
 	clk_disable_unprepare(sohci_p->clk);
 
-	return 0;
+	return ret;
 }
 
 static int spear_ohci_hcd_drv_resume(struct platform_device *dev)
-- 
1.7.9.5
