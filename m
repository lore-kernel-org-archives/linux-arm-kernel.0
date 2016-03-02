From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  2 Mar 2016 16:24:03 +0100
Subject: [PATCH 1/6] usb: host: unhide suspend/resume declarations
In-Reply-To: <1456932255-71725-1-git-send-email-arnd@arndb.de>
References: <1456932255-71725-1-git-send-email-arnd@arndb.de>
Message-ID: <1456932255-71725-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need to hide function declarations, and making
these visible to the SoC specific host drivers lets us
use __maybe_unused and IS_ENABLED() checks to control
their use, rather than having to use #ifdef to hide all
callers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/ehci.h | 2 --
 drivers/usb/host/ohci.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 2ddf35203c05..3f3b74aeca97 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -888,12 +888,10 @@ extern int	ehci_handshake(struct ehci_hcd *ehci, void __iomem *ptr,
 				u32 mask, u32 done, int usec);
 extern int	ehci_reset(struct ehci_hcd *ehci);
 
-#ifdef CONFIG_PM
 extern int	ehci_suspend(struct usb_hcd *hcd, bool do_wakeup);
 extern int	ehci_resume(struct usb_hcd *hcd, bool force_reset);
 extern void	ehci_adjust_port_wakeup_flags(struct ehci_hcd *ehci,
 			bool suspending, bool do_wakeup);
-#endif	/* CONFIG_PM */
 
 extern int	ehci_hub_control(struct usb_hcd	*hcd, u16 typeReq, u16 wValue,
 				 u16 wIndex, char *buf, u16 wLength);
diff --git a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
index bc462288cfb0..37f1725e7a46 100644
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -735,10 +735,8 @@ extern void	ohci_init_driver(struct hc_driver *drv,
 				const struct ohci_driver_overrides *over);
 extern int	ohci_restart(struct ohci_hcd *ohci);
 extern int	ohci_setup(struct usb_hcd *hcd);
-#ifdef CONFIG_PM
 extern int	ohci_suspend(struct usb_hcd *hcd, bool do_wakeup);
 extern int	ohci_resume(struct usb_hcd *hcd, bool hibernated);
-#endif
 extern int	ohci_hub_control(struct usb_hcd	*hcd, u16 typeReq, u16 wValue,
 				 u16 wIndex, char *buf, u16 wLength);
 extern int	ohci_hub_status_data(struct usb_hcd *hcd, char *buf);
-- 
2.7.0
