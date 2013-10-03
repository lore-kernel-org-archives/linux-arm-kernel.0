From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Thu,  3 Oct 2013 18:32:11 +0530
Subject: [PATCH V2 09/11] USB: OHCI: Properly handle ohci-pxa27x suspend
In-Reply-To: <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380805334-19934-10-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of ohci-pxa27x glue was not
properly handled as it was not suspending generic part
of ohci controller.  Alan Stern suggested, properly
handle ohci-pxa27x suspend scenario.

Calling explicitly the ohci_suspend() routine in
ohci_hcd_pxa27x_drv_suspend() will ensure proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manju.goudar@lge.com>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-pxa27x.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index c1b1fa3..3b77109 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -509,13 +509,19 @@ static int ohci_hcd_pxa27x_drv_suspend(struct device *dev)
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	struct pxa27x_ohci *pxa_ohci = to_pxa27x_ohci(hcd);
 	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	int ret;
+
 
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
 
+	ret = ohci_suspend(hcd);
+	if (ret)
+		return ret;
+
 	pxa27x_stop_hc(pxa_ohci, dev);
-	return 0;
+	return ret;
 }
 
 static int ohci_hcd_pxa27x_drv_resume(struct device *dev)
-- 
1.7.9.5
