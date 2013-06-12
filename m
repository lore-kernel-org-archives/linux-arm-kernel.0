From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Wed, 12 Jun 2013 20:58:35 +0530
Subject: [PATCH 07/10] USB: OHCI: Properly handle ohci-platform suspend
In-Reply-To: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371050918-29472-8-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of ohci-platform glue was not
properly handled as it was not suspending generic part
of ohci controller.Calling explicitly the ohci_suspend()
routine in ohci_platform_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-platform.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index bc30475..ad8cb3b 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -142,11 +142,15 @@ static int ohci_platform_suspend(struct device *dev)
 	struct usb_ohci_pdata *pdata = dev->platform_data;
 	struct platform_device *pdev =
 		container_of(dev, struct platform_device, dev);
+	bool do_wakeup = device_may_wakeup(dev);
+	int ret;
+
+	ret = ohci_suspend(hcd, do_wakeup);
 
 	if (pdata->power_suspend)
 		pdata->power_suspend(pdev);
 
-	return 0;
+	return ret;
 }
 
 static int ohci_platform_resume(struct device *dev)
-- 
1.7.9.5
