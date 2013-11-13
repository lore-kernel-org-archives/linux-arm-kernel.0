From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Wed, 13 Nov 2013 17:40:16 +0530
Subject: [PATCH V4 1/6] USB: OHCI: Properly handle OHCI controller suspend
In-Reply-To: <1384344621-6981-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1384344621-6981-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1384344621-6981-2-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend scenario in case of OHCI was not properly
handled in ochi_suspend()routine. Alan Stern
suggested, properly handle OHCI suspend scenario.

This does generic proper handling of suspend
scenario to all OHCI SOC.

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Acked-by:  Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 V3->V4:
     - No changes, only added Alan Acked-by.

V2->V3 :
     - No changes.
       As a build failure on ep93xx patch, reverted this patch(reveart
       commit id 476e4b). Rewrote this patch on top of latest Greg usb-next
       branch. This patch not gives any build error. patch is required for
       proper suspending as Alan mentioned. It is having common ohci suspend
       features w/o this following patches(still in usb-next) are not useful.

       Commit id "10abfa13"[PATCH 7/11] Properly handle ohci-omap suspend.
       Commit id "39dbd7df"[PATCH 8/11] Properly handle ohci-platform suspend.
       Commit id "4ceaa893"[PATCH 9/11] Properly handle ohci-pxa suspend.
       Commit id "f3c60599"[PATCH 10/11] Properly handle ohci-sm501 suspend.

      Initially when I wrote this patch I was working in Linaro, now I am not
      part of Linaro that is why Linaro id is bouncing. Sending this patch
      from personal mail id.

V1->V2:
     - No change.
       Due to build failure on ep93xx reverted this patch. This patch is
       needed as Alan mentioned, it is having common ohci suspend features
       w/o this following patches(still in usb-next) are not useful.

        Commit id "10abfa13"[PATCH 7/11] Properly handle ohci-omap suspend.
        Commit id "39dbd7df"[PATCH 8/11] Properly handle ohci-platform suspend.
        Commit id "4ceaa893"[PATCH 9/11] Properly handle ohci-pxa suspend.
        Commit id "f3c60599"[PATCH 10/11] Properly handle ohci-sm501 suspend.

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
