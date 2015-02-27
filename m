From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 28 Feb 2015 00:19:41 +0100
Subject: [PATCH, RESEND] usb: musb: fix Kconfig regression
Message-ID: <2671702.mSdaGStNT3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent bug fix I did that was marked for stable backports
introduced a slightly wrong dependency on CONFIG_OMAP_CONTROL_PHY.

I was missing the fact that the PHY driver already stubs out the
omap_control_usb_set_mode, and we only need to add a dependency
to prevent the musb-omap2430 driver from being built-in when
the phy driver is a loadable module, but we should not prevent it
from being built altogether when the phy driver is disabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ca784be36cc725 ("usb: start using the control module driver")
Acked-by: Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: <stable@vger.kernel.org> # v3.9+
---
Same patch as first time, now with correct recipient and with Pavel's
Ack added.

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 14e1628483d9..39db8b603627 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -79,7 +79,8 @@ config USB_MUSB_TUSB6010
 
 config USB_MUSB_OMAP2PLUS
 	tristate "OMAP2430 and onwards"
-	depends on ARCH_OMAP2PLUS && USB && OMAP_CONTROL_PHY
+	depends on ARCH_OMAP2PLUS && USB
+	depends on OMAP_CONTROL_PHY || !OMAP_CONTROL_PHY
 	select GENERIC_PHY
 
 config USB_MUSB_AM35X
