From: manjunath.goudar@linaro.org (Manjunath Goudar)
Date: Thu, 20 Jun 2013 15:05:57 +0530
Subject: [PATCH V4 01/11] USB: OHCI: Properly handle OHCI controller suspend
In-Reply-To: <1371720968-7533-1-git-send-email-manjunath.goudar@linaro.org>
References: <1371050918-29472-1-git-send-email-manjunath.goudar@linaro.org>
 <1371720968-7533-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <1371720968-7533-2-git-send-email-manjunath.goudar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of OHCI was not properly
handled in ochi_suspend()routine. This does proper
handling of suspend scenario.

Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org

V3: New patch.

V4: No change.
---
 drivers/usb/host/ohci-hcd.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index b69a49e..f3dcaa2 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1034,6 +1034,7 @@ int ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
 	unsigned long	flags;
+	int		rc = 0;
 
 	/* Disable irq emission and mark HW unaccessible. Use
 	 * the spinlock to properly synchronize with possible pending
@@ -1046,7 +1047,13 @@ int ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
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
