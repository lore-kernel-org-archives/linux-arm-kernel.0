From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  9 Oct 2012 22:13:54 +0200
Subject: [PATCH v2 4/8] USB: EHCI: mark ehci_orion_conf_mbus_windows __devinit
In-Reply-To: <1349813638-4617-1-git-send-email-arnd@arndb.de>
References: <1349813638-4617-1-git-send-email-arnd@arndb.de>
Message-ID: <1349813638-4617-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __devinit section is going away soon, but while it's
still there, we get a correct warning about
ehci_orion_conf_mbus_windows being discarded before
its caller, so it should be marked __devinit rather than
__init.

Without this patch, building dove_defconfig results in:

WARNING: drivers/usb/host/built-in.o(.devinit.text+0x8a4): Section mismatch in reference from the function ehci_orion_drv_probe() to the function .init.text:ehci_orion_conf_mbus_windows()
The function __devinit ehci_orion_drv_probe() references
a function __init ehci_orion_conf_mbus_windows().
If ehci_orion_conf_mbus_windows is only used by ehci_orion_drv_probe then
annotate ehci_orion_conf_mbus_windows with a matching annotation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/host/ehci-orion.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 8892d36..1f5dd5e 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -160,7 +160,7 @@ static const struct hc_driver ehci_orion_hc_driver = {
 	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
 };
 
-static void __init
+static void __devinit
 ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 			     const struct mbus_dram_target_info *dram)
 {
-- 
1.7.10
