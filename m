From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 27 Mar 2013 07:10:02 +1300
Subject: [PATCH] usb: ehci: unlink_empty_async_suspended() only used with
 CONFIG_PM
Message-ID: <1364321402-1691-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling with !CONFIG_PM generates an unused function warning on
unlink_empty_async_suspended().

Enclose the function and its forward declaration in a #ifdef CONFIG_PM

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/usb/host/ehci-q.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 23d1369..3638b28 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -1316,6 +1316,7 @@ static void unlink_empty_async(struct ehci_hcd *ehci)
 	}
 }
 
+#ifdef CONFIG_PM
 /* The root hub is suspended; unlink all the async QHs */
 static void unlink_empty_async_suspended(struct ehci_hcd *ehci)
 {
@@ -1328,7 +1329,7 @@ static void unlink_empty_async_suspended(struct ehci_hcd *ehci)
 	}
 	start_iaa_cycle(ehci, false);
 }
-
+#endif
 /* makes sure the async qh will become idle */
 /* caller must own ehci->lock */
 
-- 
1.7.9.5
