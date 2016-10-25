From: abailon@baylibre.com (Alexandre Bailon)
Date: Tue, 25 Oct 2016 14:11:32 +0200
Subject: [PATCH v2] ARM: davinci: da8xx: Fix some redefined symbol warnings
In-Reply-To: <1477397492-7925-1-git-send-email-abailon@baylibre.com>
References: <1477397492-7925-1-git-send-email-abailon@baylibre.com>
Message-ID: <1477397492-7925-2-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some macro for DA8xx CFGCHIP are defined in usb-davinci.h,
but da8xx-cfgchip.h intend to replace them.
The usb-da8xx.c is using both headers, causing redefined symbol warnings.
Remove the macro and update the da830-evm board file to use da8xx-cfgchip.h

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c   |  3 ++-
 include/linux/platform_data/usb-davinci.h | 23 -----------------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 3d8cf8c..9817316 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -27,6 +27,7 @@
 #include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/platform_data/spi-davinci.h>
 #include <linux/platform_data/usb-davinci.h>
+#include <linux/mfd/da8xx-cfgchip.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -133,7 +134,7 @@ static __init void da830_evm_usb_init(void)
 	 * controller won't be able to drive VBUS thinking that it's a B-device.
 	 * Otherwise, we want to use the OTG mode and enable VBUS comparators.
 	 */
-	cfgchip2 &= ~CFGCHIP2_OTGMODE;
+	cfgchip2 &= ~CFGCHIP2_OTGMODE_MASK;
 #ifdef	CONFIG_USB_MUSB_HOST
 	cfgchip2 |=  CFGCHIP2_FORCE_HOST;
 #else
diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index e0bc4ab..0926e99 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -11,29 +11,6 @@
 #ifndef __ASM_ARCH_USB_H
 #define __ASM_ARCH_USB_H
 
-/* DA8xx CFGCHIP2 (USB 2.0 PHY Control) register bits */
-#define CFGCHIP2_PHYCLKGD	(1 << 17)
-#define CFGCHIP2_VBUSSENSE	(1 << 16)
-#define CFGCHIP2_RESET		(1 << 15)
-#define CFGCHIP2_OTGMODE	(3 << 13)
-#define CFGCHIP2_NO_OVERRIDE	(0 << 13)
-#define CFGCHIP2_FORCE_HOST	(1 << 13)
-#define CFGCHIP2_FORCE_DEVICE 	(2 << 13)
-#define CFGCHIP2_FORCE_HOST_VBUS_LOW (3 << 13)
-#define CFGCHIP2_USB1PHYCLKMUX	(1 << 12)
-#define CFGCHIP2_USB2PHYCLKMUX	(1 << 11)
-#define CFGCHIP2_PHYPWRDN	(1 << 10)
-#define CFGCHIP2_OTGPWRDN	(1 << 9)
-#define CFGCHIP2_DATPOL 	(1 << 8)
-#define CFGCHIP2_USB1SUSPENDM	(1 << 7)
-#define CFGCHIP2_PHY_PLLON	(1 << 6)	/* override PLL suspend */
-#define CFGCHIP2_SESENDEN	(1 << 5)	/* Vsess_end comparator */
-#define CFGCHIP2_VBDTCTEN	(1 << 4)	/* Vbus comparator */
-#define CFGCHIP2_REFFREQ	(0xf << 0)
-#define CFGCHIP2_REFFREQ_12MHZ	(1 << 0)
-#define CFGCHIP2_REFFREQ_24MHZ	(2 << 0)
-#define CFGCHIP2_REFFREQ_48MHZ	(3 << 0)
-
 struct	da8xx_ohci_root_hub;
 
 typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
-- 
2.7.3
