From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Wed,  2 Oct 2013 15:45:43 +0530
Subject: [PATCH 07/11] USB: OHCI: Properly handle ohci-omap suspend
In-Reply-To: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380708947-15966-8-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci-omap glue was not
properly handled as it was not suspending generic part
of ohci controller. Alan Stern suggested, properly handle
ohci-omap suspend scenario.

Calling explicitly the ohci_suspend() routine in
ohci_omap_suspend() will ensure proper handling of suspend
scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-omap.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 18b27a2..f253214 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -431,16 +431,23 @@ static int ohci_hcd_omap_drv_remove(struct platform_device *dev)
 
 #ifdef	CONFIG_PM
 
-static int ohci_omap_suspend(struct platform_device *dev, pm_message_t message)
+static int ohci_omap_suspend(struct platform_device *pdev, pm_message_t message)
 {
-	struct ohci_hcd	*ohci = hcd_to_ohci(platform_get_drvdata(dev));
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	bool do_wakeup = device_may_wakeup(&pdev->dev);
+	int ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd, do_wakeup);
+	if (ret)
+		return ret;
+
 	omap_ohci_clock_power(0);
-	return 0;
+	return ret;
 }
 
 static int ohci_omap_resume(struct platform_device *dev)
-- 
1.7.9.5
