From: csmanjuvijay@gmail.com (Majunath Goudar)
Date: Thu,  3 Oct 2013 18:32:03 +0530
Subject: [PATCH V2 01/11] USB: OHCI: Properly handle OHCI controller suspend
In-Reply-To: <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
References: <1380708947-15966-1-git-send-email-csmanjuvijay@gmail.com>
 <1380805334-19934-1-git-send-email-csmanjuvijay@gmail.com>
Message-ID: <1380805334-19934-2-git-send-email-csmanjuvijay@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Goudar <manjunath.goudar@linaro.org>

Suspend scenario in case of OHCI was not properly
handled in ochi_suspend()routine. Alan Stern
suggested, properly handle OHCI suspend scenario.

This does generic proper handling of suspend
scenario to all OHCI SOC.

Signed-off-by: Manjunath Goudar <csmanjuvijay@gmail.com>
Signed-off-by: Manjunath Goudar <manju.goudar@lge.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ohci-hcd.c |   11 +++++++++--
 drivers/usb/host/ohci.h     |    2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 8ada13f..46087a1 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1032,10 +1032,11 @@ EXPORT_SYMBOL_GPL(ohci_restart);
 
 #ifdef CONFIG_PM
 
-int ohci_suspend(struct usb_hcd *hcd, bool do_wakeup)
+int ohci_suspend(struct usb_hcd *hcd)
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
+	if (HCD_WAKEUP_PENDING(hcd)) {
+		ohci_resume(hcd, false);
+		rc = -EBUSY;
+	}
+	return rc;
 }
 EXPORT_SYMBOL_GPL(ohci_suspend);
 
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index e2e5faa..f2ebd423 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -735,6 +735,6 @@ extern void	ohci_init_driver(struct hc_driver *drv,
 extern int	ohci_restart(struct ohci_hcd *ohci);
 extern int	ohci_setup(struct usb_hcd *hcd);
 #ifdef CONFIG_PM
-extern int	ohci_suspend(struct usb_hcd *hcd, bool do_wakeup);
+extern int	ohci_suspend(struct usb_hcd *hcd);
 extern int	ohci_resume(struct usb_hcd *hcd, bool hibernated);
 #endif
-- 
1.7.9.5
