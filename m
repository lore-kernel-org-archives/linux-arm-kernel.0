From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 21:09:46 +0000
Subject: [PATCH] usb: ehci: mark unlink_empty_async_suspended() as
 __maybe_unused
In-Reply-To: <1364362080-8489-1-git-send-email-linux@prisktech.co.nz>
References: <1364362080-8489-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201303282109.47130.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 4d053fdac3 "usb: ehci: unlink_empty_async_suspended() only used
with CONFIG_PM" tried to hide the unlink_empty_async_suspended function
inside of an #ifdef to work around an unused function warning.

Unfortunately that had the effect of introducing a new warning:

drivers/usb/host/ehci-q.c:1297:13: warning: 'unlink_empty_async_suspended' 
	declared 'static' but never defined [-Wunused-function]

While we could add another #ifdef around the function declaration to avoid
this, a nicer solution is to mark it as __maybe_unused, which will let
gcc silently drop the function definition when it is not needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
index 7562d76..d34b399 100644
--- a/drivers/usb/host/ehci-q.c
+++ b/drivers/usb/host/ehci-q.c
@@ -1293,9 +1293,8 @@ static void unlink_empty_async(struct ehci_hcd *ehci)
 	}
 }
 
-#ifdef CONFIG_PM
 /* The root hub is suspended; unlink all the async QHs */
-static void unlink_empty_async_suspended(struct ehci_hcd *ehci)
+static void __maybe_unused unlink_empty_async_suspended(struct ehci_hcd *ehci)
 {
 	struct ehci_qh		*qh;
 
@@ -1306,7 +1305,6 @@ static void unlink_empty_async_suspended(struct ehci_hcd *ehci)
 	}
 	start_iaa_cycle(ehci);
 }
-#endif
 
 /* makes sure the async qh will become idle */
 /* caller must own ehci->lock */
