From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Thu,  3 Oct 2013 18:32:10 +0530
Subject: [PATCH V2 08/11] USB: OHCI: Properly handle ohci-platform suspend
In-Reply-To: <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380805334-19934-9-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci-platform glue was not
properly handled as it was not suspending generic part
of ohci controller.Alan Stern suggested, properly handle
ohci-platform suspend scenario.

Calling explicitly the ohci_suspend() routine in
ohci_platform_suspend() will ensure proper handling of
suspend scenario.

Signed-off-by: Manjunath Goudar <manju.goudar@lge.com>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-platform.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index a4c6410..d67f841 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -139,14 +139,20 @@ static int ohci_platform_remove(struct platform_device *dev)
 
 static int ohci_platform_suspend(struct device *dev)
 {
-	struct usb_ohci_pdata *pdata = dev_get_platdata(dev);
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_ohci_pdata *pdata = dev->platform_data;
 	struct platform_device *pdev =
 		container_of(dev, struct platform_device, dev);
+	int ret;
+
+	ret = ohci_suspend(hcd);
+	if (ret)
+		return ret;
 
 	if (pdata->power_suspend)
 		pdata->power_suspend(pdev);
 
-	return 0;
+	return ret;
 }
 
 static int ohci_platform_resume(struct device *dev)
-- 
1.7.9.5
