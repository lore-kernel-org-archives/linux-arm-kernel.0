From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu,  6 Jun 2013 14:41:57 +0200
Subject: [PATCH v2] ARM: imx: Remove mxc specific ulpi access ops
Message-ID: <1370522517-2873-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are ulpi access ops implemented in drivers/usb/phy/phy-ulpi.c.
mxc access ops implement the same access operations within mach-imx. This
patch removes the mxc ulpi file and uses phy-ulpi instead for
imx_otg_ulpi_create.

phy-ulpi successfully tested with i.MX27 Phytec phyCARD-S (pca100).

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---

Sascha: Please let me know if your Ack does not include the v2 changes.

Thanks,

Markus

Notes:
    Changes in v2:
     - Remove empty config symbol MXC_ULPI and replace all occurences with
       USB_ULPI_VIEWPORT
     - Change header ifdef to be dependent on USB_ULPI_VIEWPORT

 arch/arm/mach-imx/Kconfig       |  29 +++++-----
 arch/arm/mach-imx/Makefile      |   1 -
 arch/arm/mach-imx/mach-pca100.c |   4 +-
 arch/arm/mach-imx/ulpi.c        | 118 ----------------------------------------
 arch/arm/mach-imx/ulpi.h        |  11 ++--
 5 files changed, 22 insertions(+), 141 deletions(-)
 delete mode 100644 arch/arm/mach-imx/ulpi.c

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ba44328..0cc8e6e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -56,9 +56,6 @@ config MXC_USE_EPIT
 	  uses the same clocks as the GPT. Anyway, on some systems the GPT
 	  may be in use for other purposes.
 
-config MXC_ULPI
-	bool
-
 config ARCH_HAS_RNGA
 	bool
 
@@ -233,7 +230,7 @@ config MACH_EUKREA_CPUIMX25SD
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX25
 
 choice
@@ -284,7 +281,7 @@ config MACH_PCM038
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX27
 	help
 	  Include support for phyCORE-i.MX27 (aka pcm038) platform. This
@@ -314,7 +311,7 @@ config MACH_CPUIMX27
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX27
 	help
 	  Include support for Eukrea CPUIMX27 platform. This includes
@@ -369,7 +366,7 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX27
 	help
 	  Include support for MX27PDK platform. This includes specific
@@ -414,7 +411,7 @@ config MACH_PCA100
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
 	select IMX_HAVE_PLATFORM_SPI_IMX
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX27
 	help
 	  Include support for phyCARD-s (aka pca100) platform. This
@@ -481,7 +478,7 @@ config MACH_MX31LILLY
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX31
 	help
 	  Include support for mx31 based LILLY1131 modules. This includes
@@ -497,7 +494,7 @@ config MACH_MX31LITE
 	select IMX_HAVE_PLATFORM_MXC_RTC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select LEDS_GPIO_REGISTER
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX31
 	help
 	  Include support for MX31 LITEKIT platform. This includes specific
@@ -514,7 +511,7 @@ config MACH_PCM037
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_MXC_W1
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX31
 	help
 	  Include support for Phytec pcm037 platform. This includes
@@ -544,7 +541,7 @@ config MACH_MX31_3DS
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX31
 	help
 	  Include support for MX31PDK (3DS) platform. This includes specific
@@ -571,7 +568,7 @@ config MACH_MX31MOBOARD
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select LEDS_GPIO_REGISTER
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX31
 	help
 	  Include support for mx31moboard platform. This includes specific
@@ -595,7 +592,7 @@ config MACH_ARMADILLO5X0
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX31
 	help
 	  Include support for Atmark Armadillo-500 platform. This includes
@@ -639,7 +636,7 @@ config MACH_PCM043
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX35
 	help
 	  Include support for Phytec pcm043 platform. This includes
@@ -673,7 +670,7 @@ config MACH_EUKREA_CPUIMX35SD
 	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
-	select MXC_ULPI if USB_ULPI
+	select USB_ULPI_VIEWPORT if USB_ULPI
 	select SOC_IMX35
 	help
 	  Include support for Eukrea CPUIMX35 platform. This includes
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 70ae7c4..dcb8291 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -23,7 +23,6 @@ obj-$(CONFIG_ARCH_MXC_IOMUX_V3) += iomux-v3.o
 obj-$(CONFIG_MXC_TZIC) += tzic.o
 obj-$(CONFIG_MXC_AVIC) += avic.o
 
-obj-$(CONFIG_MXC_ULPI) += ulpi.o
 obj-$(CONFIG_MXC_USE_EPIT) += epit.o
 obj-$(CONFIG_MXC_DEBUG_BOARD) += 3ds_debugboard.o
 
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index b8b15bb..19bb644 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -398,8 +398,8 @@ static void __init pca100_init(void)
 		imx27_add_fsl_usb2_udc(&otg_device_pdata);
 	}
 
-	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
+	usbh2_pdata.otg = imx_otg_ulpi_create(
+			ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	if (usbh2_pdata.otg)
 		imx27_add_mxc_ehci_hs(2, &usbh2_pdata);
diff --git a/arch/arm/mach-imx/ulpi.c b/arch/arm/mach-imx/ulpi.c
deleted file mode 100644
index 0f05195..0000000
--- a/arch/arm/mach-imx/ulpi.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Copyright 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- * Copyright 2009 Daniel Mack <daniel@caiaq.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
- * MA  02110-1301, USA.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/delay.h>
-#include <linux/usb/otg.h>
-#include <linux/usb/ulpi.h>
-
-#include "ulpi.h"
-
-/* ULPIVIEW register bits */
-#define ULPIVW_WU		(1 << 31)	/* Wakeup */
-#define ULPIVW_RUN		(1 << 30)	/* read/write run */
-#define ULPIVW_WRITE		(1 << 29)	/* 0 = read  1 = write */
-#define ULPIVW_SS		(1 << 27)	/* SyncState */
-#define ULPIVW_PORT_MASK	0x07	/* Port field */
-#define ULPIVW_PORT_SHIFT	24
-#define ULPIVW_ADDR_MASK	0xff	/* data address field */
-#define ULPIVW_ADDR_SHIFT	16
-#define ULPIVW_RDATA_MASK	0xff	/* read data field */
-#define ULPIVW_RDATA_SHIFT	8
-#define ULPIVW_WDATA_MASK	0xff	/* write data field */
-#define ULPIVW_WDATA_SHIFT	0
-
-static int ulpi_poll(void __iomem *view, u32 bit)
-{
-	int timeout = 10000;
-
-	while (timeout--) {
-		u32 data = __raw_readl(view);
-
-		if (!(data & bit))
-			return 0;
-
-		cpu_relax();
-	};
-
-	printk(KERN_WARNING "timeout polling for ULPI device\n");
-
-	return -ETIMEDOUT;
-}
-
-static int ulpi_read(struct usb_phy *otg, u32 reg)
-{
-	int ret;
-	void __iomem *view = otg->io_priv;
-
-	/* make sure interface is running */
-	if (!(__raw_readl(view) & ULPIVW_SS)) {
-		__raw_writel(ULPIVW_WU, view);
-
-		/* wait for wakeup */
-		ret = ulpi_poll(view, ULPIVW_WU);
-		if (ret)
-			return ret;
-	}
-
-	/* read the register */
-	__raw_writel((ULPIVW_RUN | (reg << ULPIVW_ADDR_SHIFT)), view);
-
-	/* wait for completion */
-	ret = ulpi_poll(view, ULPIVW_RUN);
-	if (ret)
-		return ret;
-
-	return (__raw_readl(view) >> ULPIVW_RDATA_SHIFT) & ULPIVW_RDATA_MASK;
-}
-
-static int ulpi_write(struct usb_phy *otg, u32 val, u32 reg)
-{
-	int ret;
-	void __iomem *view = otg->io_priv;
-
-	/* make sure the interface is running */
-	if (!(__raw_readl(view) & ULPIVW_SS)) {
-		__raw_writel(ULPIVW_WU, view);
-		/* wait for wakeup */
-		ret = ulpi_poll(view, ULPIVW_WU);
-		if (ret)
-			return ret;
-	}
-
-	__raw_writel((ULPIVW_RUN | ULPIVW_WRITE |
-		      (reg << ULPIVW_ADDR_SHIFT) |
-		      ((val & ULPIVW_WDATA_MASK) << ULPIVW_WDATA_SHIFT)), view);
-
-	/* wait for completion */
-	return ulpi_poll(view, ULPIVW_RUN);
-}
-
-struct usb_phy_io_ops mxc_ulpi_access_ops = {
-	.read	= ulpi_read,
-	.write	= ulpi_write,
-};
-EXPORT_SYMBOL_GPL(mxc_ulpi_access_ops);
-
-struct usb_phy *imx_otg_ulpi_create(unsigned int flags)
-{
-	return otg_ulpi_create(&mxc_ulpi_access_ops, flags);
-}
diff --git a/arch/arm/mach-imx/ulpi.h b/arch/arm/mach-imx/ulpi.h
index 42bdaca..23f5c03 100644
--- a/arch/arm/mach-imx/ulpi.h
+++ b/arch/arm/mach-imx/ulpi.h
@@ -1,8 +1,13 @@
 #ifndef __MACH_ULPI_H
 #define __MACH_ULPI_H
 
-#ifdef CONFIG_USB_ULPI
-struct usb_phy *imx_otg_ulpi_create(unsigned int flags);
+#include <linux/usb/ulpi.h>
+
+#ifdef CONFIG_USB_ULPI_VIEWPORT
+static inline struct usb_phy *imx_otg_ulpi_create(unsigned int flags)
+{
+	return otg_ulpi_create(&ulpi_viewport_access_ops, flags);
+}
 #else
 static inline struct usb_phy *imx_otg_ulpi_create(unsigned int flags)
 {
@@ -10,7 +15,5 @@ static inline struct usb_phy *imx_otg_ulpi_create(unsigned int flags)
 }
 #endif
 
-extern struct usb_phy_io_ops mxc_ulpi_access_ops;
-
 #endif /* __MACH_ULPI_H */
 
-- 
1.8.2.1
