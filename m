From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Thu,  3 Oct 2013 18:32:12 +0530
Subject: [PATCH V2 10/11] USB: OHCI: Properly handle ohci-sm501 suspend
In-Reply-To: <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380805334-19934-11-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci-sm501 glue was not
properly handled as it was not suspending generic part
of ohci controller.  Alan Stern suggested, properly
handle ohci-sm501 suspend scenario.

Calling explicitly the ohci_suspend() routine in
ohci_sm501_suspend() will ensure proper handling of suspend
scenario.

Signed-off-by: Manjunath Goudar <manju.goudar@lge.com>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-sm501.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-sm501.c b/drivers/usb/host/ohci-sm501.c
index d479d5d..cdf25ef 100644
--- a/drivers/usb/host/ohci-sm501.c
+++ b/drivers/usb/host/ohci-sm501.c
@@ -216,14 +216,20 @@ static int ohci_hcd_sm501_drv_remove(struct platform_device *pdev)
 static int ohci_sm501_suspend(struct platform_device *pdev, pm_message_t msg)
 {
 	struct device *dev = &pdev->dev;
-	struct ohci_hcd	*ohci = hcd_to_ohci(platform_get_drvdata(pdev));
+	struct usb_hcd  *hcd = platform_get_drvdata(pdev);
+	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	int ret;
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd);
+	if (ret)
+		return ret;
+
 	sm501_unit_power(dev->parent, SM501_GATE_USB_HOST, 0);
-	return 0;
+	return ret;
 }
 
 static int ohci_sm501_resume(struct platform_device *pdev)
-- 
1.7.9.5
