From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:51 +0200
Subject: [PATCH 19/21] usb: phy: don't mark usb_bind_phy as __init
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-20-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes no sense for a symbol to be both exported and marked __init,
because any users in modules would be calling this function after
it gets discarded. Further, this patch revolves a section mismatch
warning from usbhs_init_phys(), which is intentionally not marked
__init:

WARNING: vmlinux.o(.text+0x413f8): Section mismatch in reference from
the function usbhs_init_phys() to the function .init.text:usb_bind_phy()

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/otg/otg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
index 2bd03d2..77346cf 100644
--- a/drivers/usb/otg/otg.c
+++ b/drivers/usb/otg/otg.c
@@ -414,7 +414,7 @@ EXPORT_SYMBOL(usb_remove_phy);
  *
  * To be used by platform specific initialization code.
  */
-int __init usb_bind_phy(const char *dev_name, u8 index,
+int usb_bind_phy(const char *dev_name, u8 index,
 				const char *phy_dev_name)
 {
 	struct usb_phy_bind *phy_bind;
-- 
1.8.1.2
