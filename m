From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Jan 2013 17:16:05 +0000
Subject: [PATCH 12/15] USB: gadget/freescale: disable non-multiplatform drivers
In-Reply-To: <1358788568-11137-1-git-send-email-arnd@arndb.de>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
Message-ID: <1358788568-11137-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both the fsl_mxc gadget and the imx_udc gadget drivers fail to build
without the mach/hardware.h file that is not available when building
for multiplatform. Let's disable these drivers for v3.8 in combination
with CONFIG_ARCH_MULTIPLATFORM, and fix them properly in v3.9 unless
someone has an better solution.

Without this patch, building allyesconfig results in:

drivers/usb/gadget/fsl_mxc_udc.c:21:27: fatal error: mach/hardware.h: No such file or directory

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb at vger.kernel.org
---
 drivers/usb/gadget/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 14625fd..ca57a6d 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -173,6 +173,7 @@ config USB_BCM63XX_UDC
 config USB_FSL_USB2
 	tristate "Freescale Highspeed USB DR Peripheral Controller"
 	depends on FSL_SOC || ARCH_MXC
+	depends on !ARCH_MULTIPLATFORM
 	select USB_FSL_MPH_DR_OF if OF
 	help
 	   Some of Freescale PowerPC and i.MX processors have a High Speed
@@ -280,7 +281,7 @@ config USB_S3C_HSOTG
 
 config USB_IMX
 	tristate "Freescale i.MX1 USB Peripheral Controller"
-	depends on ARCH_MXC
+	depends on ARCH_MXC && !ARCH_MULTIPLATFORM
 	help
 	   Freescale's i.MX1 includes an integrated full speed
 	   USB 1.1 device controller.
-- 
1.7.10.4
