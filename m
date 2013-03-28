From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Mar 2013 22:55:02 +0100
Subject: [PATCH v3 4/7] USB: EHCI: export ehci_shutdown
In-Reply-To: <1364507705-22012-1-git-send-email-arnd@arndb.de>
References: <1364507705-22012-1-git-send-email-arnd@arndb.de>
Message-ID: <1364507705-22012-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ehci_shutdown function is used by the platform specific ehci backends
for at91, tegra and ps3. In order to turn any of these into separate
modules, we need to make this function globally visible and export it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ehci-hcd.c | 3 ++-
 drivers/usb/host/ehci.h     | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 8f1f4b4..1c9aa17 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -353,7 +353,7 @@ static void ehci_silence_controller(struct ehci_hcd *ehci)
  * This forcibly disables dma and IRQs, helping kexec and other cases
  * where the next system software may expect clean state.
  */
-static void ehci_shutdown(struct usb_hcd *hcd)
+void ehci_shutdown(struct usb_hcd *hcd)
 {
 	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
 
@@ -367,6 +367,7 @@ static void ehci_shutdown(struct usb_hcd *hcd)
 
 	hrtimer_cancel(&ehci->hrtimer);
 }
+EXPORT_SYMBOL_GPL(ehci_shutdown);
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index e666999..915739d 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -799,6 +799,7 @@ struct ehci_driver_overrides {
 extern void	ehci_init_driver(struct hc_driver *drv,
 				const struct ehci_driver_overrides *over);
 extern int	ehci_setup(struct usb_hcd *hcd);
+extern void	ehci_shutdown(struct usb_hcd *hcd);
 
 #ifdef CONFIG_PM
 extern int	ehci_suspend(struct usb_hcd *hcd, bool do_wakeup);
-- 
1.8.1.2
