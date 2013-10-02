From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Wed,  2 Oct 2013 15:45:37 +0530
Subject: [PATCH 01/11] USB: OHCI: Properly handle OHCI controller suspend
In-Reply-To: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380708947-15966-2-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of OHCI was not properly
handled in ochi_suspend()routine. Alan Stern
suggested, properly handle OHCI suspend scenario.

This does generic proper handling of suspend
scenario to all OHCI SOC.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-hcd.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 8ada13f..310bcfe 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1036,6 +1036,7 @@ int ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	unsigned long	flags;
+	int		rc = 0;
 
 	/* Disable irq emission and mark HW unaccessible. Use
 	 * the spinlock to properly synchronize with possible pending
@@ -1048,7 +1049,13 @@ int ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	spin_unlock_irqrestore (&ohci->lock, flags);
 
-	return 0;
+	synchronize_irq(hcd->irq);
+
+	if (do_wakeup && HCD_WAKEUP_PENDING(hcd)) {
+		ohci_resume(hcd, false);
+		rc = -EBUSY;
+	}
+	return rc;
 }
 EXPORT_SYMBOL_GPL(ohci_suspend);
 
-- 
1.7.9.5
