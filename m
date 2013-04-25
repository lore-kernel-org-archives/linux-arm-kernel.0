From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Apr 2013 19:29:02 +0200
Subject: [PATCH 19/21] USB: lpc32xx: ISP1301 needs USB_PHY
In-Reply-To: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
Message-ID: <1366910944-3033663-20-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig entry for USB_LPC32XX unconditionally selects USB_ISP1301,
which is now only visible when USB_PHY is also enabled.

This adds an appropriate dependency and enables USB_PHY in the msm
defconfig, avoiding these build errors:

warning: (USB_LPC32XX) selects USB_ISP1301 which has unmet direct dependencies (USB_SUPPORT && USB_PHY && (USB || USB_GADGET) && I2C)
drivers/built-in.o: In function `usb_hcd_nxp_probe':
drivers/usb/host/ohci-nxp.c:224: undefined reference to `isp1301_get_client'
drivers/built-in.o: In function `lpc32xx_udc_probe':
drivers/usb/gadget/lpc32xx_udc.c:3071: undefined reference to `isp1301_get_client'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: linux-usb at vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Roland Stigge <stigge@antcom.de>
---
 arch/arm/configs/lpc32xx_defconfig | 1 +
 drivers/usb/gadget/Kconfig         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 8fee514..398a367 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -146,6 +146,7 @@ CONFIG_SND_DEBUG_VERBOSE=y
 # CONFIG_SND_SPI is not set
 CONFIG_SND_SOC=y
 CONFIG_USB=y
+CONFIG_USB_PHY=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index a61d981..f85b427 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -144,6 +144,7 @@ config USB_AT91
 config USB_LPC32XX
 	tristate "LPC32XX USB Peripheral Controller"
 	depends on ARCH_LPC32XX
+	depends on USB_PHY
 	select USB_ISP1301
 	select USB_OTG_UTILS
 	help
-- 
1.8.1.2
