From: ming.lei@canonical.com (Ming Lei)
Date: Sun,  9 Jun 2013 23:18:29 +0800
Subject: [RFC PATCH 2/4] USB: EHCI: don't release ehci->lock if URB giveback
 in tasklet context
In-Reply-To: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
References: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
Message-ID: <1370791112-18464-3-git-send-email-ming.lei@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If HCD_BH is set for HC driver's flags, URB giveback will be
done in tasklet context instead of interrupt context, so the
ehci->lock needn't to be released any more before calling
usb_hcd_giveback_urb().

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 drivers/usb/host/ehci-q.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index d34b399..0387a81 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -283,9 +283,11 @@ __acquires(ehci->lock)
 
 	/* complete() can reenter this HCD */
 	usb_hcd_unlink_urb_from_ep(ehci_to_hcd(ehci), urb);
-	spin_unlock (&ehci->lock);
+	if (!hcd_giveback_urb_in_bh(ehci_to_hcd(ehci)))
+		spin_unlock(&ehci->lock);
 	usb_hcd_giveback_urb(ehci_to_hcd(ehci), urb, status);
-	spin_lock (&ehci->lock);
+	if (!hcd_giveback_urb_in_bh(ehci_to_hcd(ehci)))
+		spin_lock(&ehci->lock);
 }
 
 static int qh_schedule (struct ehci_hcd *ehci, struct ehci_qh *qh);
-- 
1.7.9.5
