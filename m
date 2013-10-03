From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Thu,  3 Oct 2013 18:32:09 +0530
Subject: [PATCH V2 07/11] USB: OHCI: Properly handle ohci-omap suspend
In-Reply-To: <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380805334-19934-8-git-send-email-csmanjuvijay@gmail.com>
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

Signed-off-by: Manjunath Goudar <manju.goudar@lge.com>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-omap.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 18b27a2..ec2d04c 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -431,16 +431,22 @@ static int ohci_hcd_omap_drv_remove(struct platform_device *dev)
 
 #ifdef	CONFIG_PM
 
-static int ohci_omap_suspend(struct platform_device *dev, pm_message_t message)
+static int ohci_omap_suspend(struct platform_device *pdev, pm_message_t message)
 {
-	struct ohci_hcd	*ohci = hcd_to_ohci(platform_get_drvdata(dev));
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd);
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
