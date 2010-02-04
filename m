From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  4 Feb 2010 16:03:44 +0100
Subject: [PATCH 7/8] i.MX31 pcm037: Add USB support
In-Reply-To: <1265295825-8705-7-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-2-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-3-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-4-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-5-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-6-git-send-email-s.hauer@pengutronix.de>
	<1265295825-8705-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1265295825-8705-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/Kconfig       |    1 +
 arch/arm/mach-mx3/mach-pcm037.c |  137 +++++---
 arch/arm/mach-mx3/pcm037.c      |  795 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx3/pcm043.c      |  367 ++++++++++++++++++
 4 files changed, 1255 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/mach-mx3/pcm037.c
 create mode 100644 arch/arm/mach-mx3/pcm043.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 2829441..2232b7b 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -34,6 +34,7 @@ config MACH_MX31ADS_WM1133_EV1
 config MACH_PCM037
 	bool "Support Phytec pcm037 (i.MX31) platforms"
 	select ARCH_MX31
+	select MXC_ULPI if USB_ULPI
 	help
 	  Include support for Phytec pcm037 platform. This includes
 	  specific configurations for the board and its peripherals.
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 21f5481..11f5315 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -33,6 +33,9 @@
 #include <linux/irq.h>
 #include <linux/fsl_devices.h>
 #include <linux/can/platform/sja1000.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
+#include <linux/fsl_devices.h>
 
 #include <media/soc_camera.h>
 
@@ -51,6 +54,8 @@
 #include <mach/mx3_camera.h>
 #include <mach/mx3fb.h>
 #include <mach/mxc_nand.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
 
 #include "devices.h"
 #include "pcm037.h"
@@ -172,19 +177,7 @@ static unsigned int pcm037_pins[] = {
 	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
 	/* GPIO */
 	IOMUX_MODE(MX31_PIN_ATA_DMACK, IOMUX_CONFIG_GPIO),
-};
-
-static struct physmap_flash_data pcm037_flash_data = {
-	.width  = 2,
-};
-
-static struct resource pcm037_flash_resource = {
-	.start	= 0xa0000000,
-	.end	= 0xa1ffffff,
-	.flags	= IORESOURCE_MEM,
-};
-
-static int usbotg_pins[] = {
+	/* OTG */
 	MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
 	MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
 	MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
@@ -197,39 +190,29 @@ static int usbotg_pins[] = {
 	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
 	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
 	MX31_PIN_USBOTG_STP__USBOTG_STP,
+	/* USB host 2 */
+	IOMUX_MODE(MX31_PIN_USBH2_CLK, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DIR, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_NXT, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_STP, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DATA0, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DATA1, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_STXD3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SRXD3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SCK3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SFS3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_STXD6, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SRXD6, IOMUX_CONFIG_FUNC),
 };
 
-/* USB OTG HS port */
-static int __init gpio_usbotg_hs_activate(void)
-{
-	int ret = mxc_iomux_setup_multiple_pins(usbotg_pins,
-					ARRAY_SIZE(usbotg_pins), "usbotg");
-
-	if (ret < 0) {
-		printk(KERN_ERR "Cannot set up OTG pins\n");
-		return ret;
-	}
-
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA3, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA4, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA5, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA6, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA7, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_CLK,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_DIR,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
-
-	return 0;
-}
+static struct physmap_flash_data pcm037_flash_data = {
+	.width  = 2,
+};
 
-/* OTG config */
-static struct fsl_usb2_platform_data usb_pdata = {
-	.operating_mode	= FSL_USB2_DR_DEVICE,
-	.phy_mode	= FSL_USB2_PHY_ULPI,
+static struct resource pcm037_flash_resource = {
+	.start	= 0xa0000000,
+	.end	= 0xa1ffffff,
+	.flags	= IORESOURCE_MEM,
 };
 
 static struct platform_device pcm037_flash = {
@@ -561,16 +544,65 @@ static struct platform_device pcm970_sja1000 = {
 	.num_resources = ARRAY_SIZE(pcm970_sja1000_resources),
 };
 
+static struct mxc_usbh_platform_data otg_pdata = {
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static struct mxc_usbh_platform_data usbh2_pdata = {
+	.portsc	= MXC_EHCI_MODE_ULPI,
+	.flags	= MXC_EHCI_INTERFACE_DIFF_UNI,
+};
+
+static struct fsl_usb2_platform_data otg_device_pdata = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode       = FSL_USB2_PHY_ULPI,
+};
+
+static int otg_mode_host;
+
+static int __init pcm037_otg_mode(char *options)
+{
+	if (!strcmp(options, "host"))
+		otg_mode_host = 1;
+	else if (!strcmp(options, "device"))
+		otg_mode_host = 0;
+	else
+		pr_info("otg_mode neither \"host\" nor \"device\". "
+			"Defaulting to device\n");
+	return 0;
+}
+__setup("otg_mode=", pcm037_otg_mode);
+
 /*
  * Board specific initialization.
  */
 static void __init mxc_board_init(void)
 {
 	int ret;
+	u32 tmp;
+
+	mxc_iomux_set_gpr(MUX_PGP_UH2, 1);
 
 	mxc_iomux_setup_multiple_pins(pcm037_pins, ARRAY_SIZE(pcm037_pins),
 			"pcm037");
 
+#define H2_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS \
+		| PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+
+	mxc_iomux_set_pad(MX31_PIN_USBH2_CLK, H2_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DIR, H2_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_NXT, H2_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_STP, H2_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA0, H2_PAD_CFG); /* USBH2_DATA0 */
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA1, H2_PAD_CFG); /* USBH2_DATA1 */
+	mxc_iomux_set_pad(MX31_PIN_SRXD6, H2_PAD_CFG);	/* USBH2_DATA2 */
+	mxc_iomux_set_pad(MX31_PIN_STXD6, H2_PAD_CFG);	/* USBH2_DATA3 */
+	mxc_iomux_set_pad(MX31_PIN_SFS3, H2_PAD_CFG);	/* USBH2_DATA4 */
+	mxc_iomux_set_pad(MX31_PIN_SCK3, H2_PAD_CFG);	/* USBH2_DATA5 */
+	mxc_iomux_set_pad(MX31_PIN_SRXD3, H2_PAD_CFG);	/* USBH2_DATA6 */
+	mxc_iomux_set_pad(MX31_PIN_STXD3, H2_PAD_CFG);	/* USBH2_DATA7 */
+
 	if (pcm037_variant() == PCM037_EET)
 		mxc_iomux_setup_multiple_pins(pcm037_uart1_pins,
 			ARRAY_SIZE(pcm037_uart1_pins), "pcm037_uart1");
@@ -608,8 +640,6 @@ static void __init mxc_board_init(void)
 	mxc_register_device(&mxcsdhc_device0, &sdhc_pdata);
 	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
 	mxc_register_device(&mx3_fb, &mx3fb_pdata);
-	if (!gpio_usbotg_hs_activate())
-		mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
 
 	/* CSI */
 	/* Camera power: default - off */
@@ -623,6 +653,23 @@ static void __init mxc_board_init(void)
 		mxc_register_device(&mx3_camera, &camera_pdata);
 
 	platform_device_register(&pcm970_sja1000);
+
+#if defined(CONFIG_USB_ULPI)
+	if (otg_mode_host) {
+		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+		mxc_register_device(&mxc_otg_host, &otg_pdata);
+	}
+
+	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
+				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+#endif
+	if (!otg_mode_host)
+		mxc_register_device(&mxc_otg_udc_device, &otg_device_pdata);
+
 }
 
 static void __init pcm037_timer_init(void)
diff --git a/arch/arm/mach-mx3/pcm037.c b/arch/arm/mach-mx3/pcm037.c
new file mode 100644
index 0000000..3156642
--- /dev/null
+++ b/arch/arm/mach-mx3/pcm037.c
@@ -0,0 +1,795 @@
+/*
+ *  Copyright (C) 2008 Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/plat-ram.h>
+#include <linux/memory.h>
+#include <linux/gpio.h>
+#include <linux/smsc911x.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/i2c/at24.h>
+#include <linux/i2c/pca953x.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/irq.h>
+#include <linux/fsl_devices.h>
+#include <linux/can/platform/sja1000.h>
+
+#include <media/soc_camera.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+#include <mach/board-pcm037.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/iomux-mx3.h>
+#include <mach/hardware.h>
+#include <mach/mx3_camera.h>
+#include <mach/mxc_nand.h>
+#include <mach/mmc.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
+#include <mach/irqs.h>
+#include <mach/i2c.h>
+#include <mach/mxc_ehci.h>
+#include <mach/ulpi.h>
+#include <mach/spi.h>
+
+#include "devices.h"
+
+static unsigned int pcm037_pins[] = {
+	/* I2C */
+	MX31_PIN_CSPI2_MOSI__SCL,
+	MX31_PIN_CSPI2_MISO__SDA,
+	MX31_PIN_CSPI2_SS2__I2C3_SDA,
+	MX31_PIN_CSPI2_SCLK__I2C3_SCL,
+	/* SDHC1 */
+	MX31_PIN_SD1_DATA3__SD1_DATA3,
+	MX31_PIN_SD1_DATA2__SD1_DATA2,
+	MX31_PIN_SD1_DATA1__SD1_DATA1,
+	MX31_PIN_SD1_DATA0__SD1_DATA0,
+	MX31_PIN_SD1_CLK__SD1_CLK,
+	MX31_PIN_SD1_CMD__SD1_CMD,
+	IOMUX_MODE(MX31_PIN_SCK6, IOMUX_CONFIG_GPIO), /* card detect */
+	IOMUX_MODE(MX31_PIN_SFS6, IOMUX_CONFIG_GPIO), /* write protect */
+	/* SPI1 */
+	MX31_PIN_CSPI1_MOSI__MOSI,
+	MX31_PIN_CSPI1_MISO__MISO,
+	MX31_PIN_CSPI1_SCLK__SCLK,
+	MX31_PIN_CSPI1_SPI_RDY__SPI_RDY,
+	MX31_PIN_CSPI1_SS0__SS0,
+	MX31_PIN_CSPI1_SS1__SS1,
+	MX31_PIN_CSPI1_SS2__SS2,
+	/* UART1 */
+	MX31_PIN_CTS1__CTS1,
+	MX31_PIN_RTS1__RTS1,
+	MX31_PIN_TXD1__TXD1,
+	MX31_PIN_RXD1__RXD1,
+	/* UART2 */
+	MX31_PIN_TXD2__TXD2,
+	MX31_PIN_RXD2__RXD2,
+	MX31_PIN_CTS2__CTS2,
+	MX31_PIN_RTS2__RTS2,
+	/* UART3 */
+	MX31_PIN_CSPI3_MOSI__RXD3,
+	MX31_PIN_CSPI3_MISO__TXD3,
+	MX31_PIN_CSPI3_SCLK__RTS3,
+	MX31_PIN_CSPI3_SPI_RDY__CTS3,
+	/* LAN9217 irq pin */
+	IOMUX_MODE(MX31_PIN_GPIO3_1, IOMUX_CONFIG_GPIO),
+	/* MC13783 IRQ pim */
+	IOMUX_MODE(MX31_PIN_GPIO3_0, IOMUX_CONFIG_GPIO),
+	/* Onewire */
+	MX31_PIN_BATT_LINE__OWIRE,
+	/* Framebuffer */
+	MX31_PIN_LD0__LD0,
+	MX31_PIN_LD1__LD1,
+	MX31_PIN_LD2__LD2,
+	MX31_PIN_LD3__LD3,
+	MX31_PIN_LD4__LD4,
+	MX31_PIN_LD5__LD5,
+	MX31_PIN_LD6__LD6,
+	MX31_PIN_LD7__LD7,
+	MX31_PIN_LD8__LD8,
+	MX31_PIN_LD9__LD9,
+	MX31_PIN_LD10__LD10,
+	MX31_PIN_LD11__LD11,
+	MX31_PIN_LD12__LD12,
+	MX31_PIN_LD13__LD13,
+	MX31_PIN_LD14__LD14,
+	MX31_PIN_LD15__LD15,
+	MX31_PIN_LD16__LD16,
+	MX31_PIN_LD17__LD17,
+	MX31_PIN_VSYNC3__VSYNC3,
+	MX31_PIN_HSYNC__HSYNC,
+	MX31_PIN_FPSHIFT__FPSHIFT,
+	MX31_PIN_DRDY0__DRDY0,
+	MX31_PIN_D3_REV__D3_REV,
+	MX31_PIN_CONTRAST__CONTRAST,
+	MX31_PIN_D3_SPL__D3_SPL,
+	MX31_PIN_D3_CLS__D3_CLS,
+	MX31_PIN_LCS0__GPI03_23,
+};
+
+static struct physmap_flash_data pcm037_flash_data = {
+	.width  = 2,
+};
+
+static struct resource pcm037_flash_resource = {
+	.start	= 0xa0000000,
+	.end	= 0xa1ffffff,
+	.flags	= IORESOURCE_MEM,
+};
+
+static int usbotg_pins[] = {
+	MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
+	MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
+	MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
+	MX31_PIN_USBOTG_DATA3__USBOTG_DATA3,
+	MX31_PIN_USBOTG_DATA4__USBOTG_DATA4,
+	MX31_PIN_USBOTG_DATA5__USBOTG_DATA5,
+	MX31_PIN_USBOTG_DATA6__USBOTG_DATA6,
+	MX31_PIN_USBOTG_DATA7__USBOTG_DATA7,
+	MX31_PIN_USBOTG_CLK__USBOTG_CLK,
+	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
+	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
+	MX31_PIN_USBOTG_STP__USBOTG_STP,
+	/* CSI */
+	IOMUX_MODE(MX31_PIN_CSI_D5, IOMUX_CONFIG_GPIO),
+	MX31_PIN_CSI_D6__CSI_D6,
+	MX31_PIN_CSI_D7__CSI_D7,
+	MX31_PIN_CSI_D8__CSI_D8,
+	MX31_PIN_CSI_D9__CSI_D9,
+	MX31_PIN_CSI_D10__CSI_D10,
+	MX31_PIN_CSI_D11__CSI_D11,
+	MX31_PIN_CSI_D12__CSI_D12,
+	MX31_PIN_CSI_D13__CSI_D13,
+	MX31_PIN_CSI_D14__CSI_D14,
+	MX31_PIN_CSI_D15__CSI_D15,
+	MX31_PIN_CSI_HSYNC__CSI_HSYNC,
+	MX31_PIN_CSI_MCLK__CSI_MCLK,
+	MX31_PIN_CSI_PIXCLK__CSI_PIXCLK,
+	MX31_PIN_CSI_VSYNC__CSI_VSYNC,
+	/* GPIO */
+	IOMUX_MODE(MX31_PIN_ATA_DMACK, IOMUX_CONFIG_GPIO),
+};
+
+/* USB OTG HS port */
+static int __init gpio_usbotg_hs_activate(void)
+{
+	int ret = mxc_iomux_setup_multiple_pins(usbotg_pins,
+					ARRAY_SIZE(usbotg_pins), "usbotg");
+
+	if (ret < 0) {
+		printk(KERN_ERR "Cannot set up OTG pins\n");
+		return ret;
+	}
+
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA0, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA1, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA2, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA3, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA4, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA5, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA6, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DATA7, PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_CLK,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_DIR,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_NXT,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+	mxc_iomux_set_pad(MX31_PIN_USBOTG_STP,   PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST);
+
+	return 0;
+}
+
+/* OTG config */
+static struct fsl_usb2_platform_data usb_pdata = {
+	.operating_mode	= FSL_USB2_DR_DEVICE,
+	.phy_mode	= FSL_USB2_PHY_ULPI,
+};
+
+static struct platform_device pcm037_flash = {
+	.name	= "physmap-flash",
+	.id	= 0,
+	.dev	= {
+		.platform_data  = &pcm037_flash_data,
+	},
+	.resource = &pcm037_flash_resource,
+	.num_resources = 1,
+};
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct resource smsc911x_resources[] = {
+	[0] = {
+		.start		= CS1_BASE_ADDR + 0x300,
+		.end		= CS1_BASE_ADDR + 0x300 + SZ_64K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
+		.end		= IOMUX_TO_IRQ(MX31_PIN_GPIO3_1),
+		.flags		= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+	},
+};
+
+static struct smsc911x_platform_config smsc911x_info = {
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_FORCE_INTERNAL_PHY |
+			  SMSC911X_SAVE_MAC_ADDRESS,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+};
+
+static struct platform_device pcm037_eth = {
+	.name		= "smsc911x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smsc911x_resources),
+	.resource	= smsc911x_resources,
+	.dev		= {
+		.platform_data = &smsc911x_info,
+	},
+};
+
+static struct platdata_mtd_ram pcm038_sram_data = {
+	.bankwidth = 2,
+};
+
+static struct resource pcm038_sram_resource = {
+	.start = CS4_BASE_ADDR,
+	.end   = CS4_BASE_ADDR + 512 * 1024 - 1,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device pcm037_sram_device = {
+	.name = "mtd-ram",
+	.id = 0,
+	.dev = {
+		.platform_data = &pcm038_sram_data,
+	},
+	.num_resources = 1,
+	.resource = &pcm038_sram_resource,
+};
+
+static struct mxc_nand_platform_data pcm037_nand_board_info = {
+	.width = 1,
+	.hw_ecc = 1,
+};
+
+static struct imxi2c_platform_data pcm037_i2c_1_data = {
+	.bitrate = 100000,
+};
+
+static struct at24_platform_data board_eeprom = {
+	.byte_len = 4096,
+	.page_size = 32,
+	.flags = AT24_FLAG_ADDR16,
+};
+
+static struct i2c_board_info pcm037_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
+		.platform_data = &board_eeprom,
+	}, {
+		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
+		.type = "pcf8563",
+	}
+};
+
+static struct imxi2c_platform_data pcm037_i2c_2_data = {
+	.bitrate = 20000,
+};
+
+static int pcm037_camera_power(struct device *dev, int on)
+{
+	/* disable or enable the camera on X7 or X8 PCM970 connector */
+	gpio_set_value(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), !on);
+	return 0;
+}
+/* count of GPIOs that are occupied by the CPU itself */
+#define MAX_INTERNAL_GPIO 96
+static int gpio_bus_switch;
+
+static unsigned long pcm037_camera_query_bus_param(struct soc_camera_link *link)
+{
+	int ret;
+
+	if (!gpio_bus_switch) {
+		ret = gpio_request(MAX_INTERNAL_GPIO, "camera");
+		if (!ret) {
+			gpio_bus_switch = MAX_INTERNAL_GPIO;
+			gpio_direction_output(gpio_bus_switch, 0);
+		} else
+			gpio_bus_switch = -EINVAL;
+	}
+
+	return SOCAM_DATAWIDTH_10;
+}
+
+static int pcm037_camera_set_bus_param(struct soc_camera_link *link,
+		unsigned long flags)
+{
+	return 0;
+}
+
+static struct soc_camera_link iclink[] = {
+	{
+		.bus_id	= 0, /* Must match with the camera ID */
+		.query_bus_param = pcm037_camera_query_bus_param,
+		.set_bus_param = pcm037_camera_set_bus_param,
+		.power = pcm037_camera_power,
+
+	}, {
+		.bus_id	= 0, /* Must match with the camera ID */
+		.query_bus_param = pcm037_camera_query_bus_param,
+		.set_bus_param = pcm037_camera_set_bus_param,
+		.power = pcm037_camera_power,
+		.flags	= SOCAM_SENSOR_INVERT_PCLK,
+	}
+};
+
+/* count of GPIOs that are occupied by the CPU itself */
+#define MAX_INTERNAL_GPIO 96 
+
+static struct pca953x_platform_data pca9536_data = {
+	.gpio_base      = MAX_INTERNAL_GPIO,
+};
+
+static struct i2c_board_info pcm037_i2c_2_devices[] = {
+	{
+		/* Must initialize before the camera(s) */
+		I2C_BOARD_INFO("pca953x", 0x41),
+		.type = "pca9536",
+		.platform_data = &pca9536_data,
+	}, {
+		I2C_BOARD_INFO("mt9m001", 0x5d),
+		.platform_data = &iclink[0],
+	}, {
+		I2C_BOARD_INFO("mt9v022", 0x48),
+		.platform_data = &iclink[1], /* mt9v022 needs pclk inversion*/
+	},
+};
+
+/* Not connected by default */
+#ifdef PCM970_SDHC_RW_SWITCH
+static int pcm970_sdhc1_get_ro(struct device *dev)
+{
+	return gpio_get_value(IOMUX_TO_GPIO(MX31_PIN_SFS6));
+}
+#endif
+
+#define SDHC1_GPIO_WP	IOMUX_TO_GPIO(MX31_PIN_SFS6)
+#define SDHC1_GPIO_DET	IOMUX_TO_GPIO(MX31_PIN_SCK6)
+
+static int pcm970_sdhc1_init(struct device *dev, irq_handler_t detect_irq,
+		void *data)
+{
+	int ret;
+
+	ret = gpio_request(SDHC1_GPIO_DET, "sdhc-detect");
+	if (ret)
+		return ret;
+
+	gpio_direction_input(SDHC1_GPIO_DET);
+
+#ifdef PCM970_SDHC_RW_SWITCH
+	ret = gpio_request(SDHC1_GPIO_WP, "sdhc-wp");
+	if (ret)
+		goto err_gpio_free;
+	gpio_direction_input(SDHC1_GPIO_WP);
+#endif
+
+	ret = request_irq(IOMUX_TO_IRQ(MX31_PIN_SCK6), detect_irq,
+			IRQF_DISABLED | IRQF_TRIGGER_FALLING,
+				"sdhc-detect", data);
+	if (ret)
+		goto err_gpio_free_2;
+
+	return 0;
+
+err_gpio_free_2:
+#ifdef PCM970_SDHC_RW_SWITCH
+	gpio_free(SDHC1_GPIO_WP);
+err_gpio_free:
+#endif
+	gpio_free(SDHC1_GPIO_DET);
+
+	return ret;
+}
+
+static void pcm970_sdhc1_exit(struct device *dev, void *data)
+{
+	free_irq(IOMUX_TO_IRQ(MX31_PIN_SCK6), data);
+	gpio_free(SDHC1_GPIO_DET);
+	gpio_free(SDHC1_GPIO_WP);
+}
+
+#ifdef CONFIG_SPI
+static unsigned int pcm037_spi_cs[] = {MXC_SPI_CS(0), };
+
+static struct spi_imx_master pcm037_spi_0_data = {
+	.chipselect = pcm037_spi_cs,
+	.num_chipselect = ARRAY_SIZE(pcm037_spi_cs),
+};
+
+static struct spi_board_info pcm037_spi_board_info[] __initdata = {
+	{
+		.modalias = "mc13783",
+		.irq = IOMUX_TO_IRQ(MX31_PIN_GPIO3_0),
+		.max_speed_hz = 3000000,
+		.bus_num = 0,
+		.chip_select = 0,
+	}
+};
+#endif /* CONFIG_SPI */
+
+static struct imxmmc_platform_data sdhc_pdata = {
+#ifdef PCM970_SDHC_RW_SWITCH
+	.get_ro = pcm970_sdhc1_get_ro,
+#endif
+	.init = pcm970_sdhc1_init,
+	.exit = pcm970_sdhc1_exit,
+};
+
+struct mx3_camera_pdata camera_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.flags		= MX3_CAMERA_DATAWIDTH_8 | MX3_CAMERA_DATAWIDTH_10,
+	.mclk_10khz	= 2000,
+};
+
+static int __init pcm037_camera_alloc_dma(const size_t buf_size)
+{
+	dma_addr_t dma_handle;
+	void *buf;
+	int dma;
+
+	if (buf_size < 2 * 1024 * 1024)
+		return -EINVAL;
+
+	buf = dma_alloc_coherent(NULL, buf_size, &dma_handle, GFP_KERNEL);
+	if (!buf) {
+		pr_err("%s: cannot allocate camera buffer-memory\n", __func__);
+		return -ENOMEM;
+	}
+
+	memset(buf, 0, buf_size);
+
+	dma = dma_declare_coherent_memory(&mx3_camera.dev,
+					dma_handle, dma_handle, buf_size,
+					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);
+
+	if (dma & DMA_MEMORY_MAP)
+		return 0;
+
+	dma_free_coherent(NULL, buf_size, buf, dma_handle);
+
+	/* The way we call dma_declare_coherent_memory only a malloc can fail */
+	return -ENOMEM;
+}
+
+static struct platform_device *devices[] __initdata = {
+	&pcm037_flash,
+	&pcm037_sram_device,
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static const struct fb_videomode fb_modedb[] = {
+	{
+		/* 240x320 @ 60 Hz Sharp */
+		.name		= "Sharp-LQ035Q7DH06-QVGA",
+		.refresh	= 60,
+		.xres		= 240,
+		.yres		= 320,
+		.pixclock	= 185925,
+		.left_margin	= 9,
+		.right_margin	= 16,
+		.upper_margin	= 7,
+		.lower_margin	= 9,
+		.hsync_len	= 1,
+		.vsync_len	= 1,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_SHARP_MODE |
+				  FB_SYNC_CLK_INVERT | FB_SYNC_CLK_IDLE_EN,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	}, {
+		/* 240x320 @ 60 Hz */
+		.name		= "TX090",
+		.refresh	= 60,
+		.xres		= 240,
+		.yres		= 320,
+		.pixclock	= 38255,
+		.left_margin	= 144,
+		.right_margin	= 0,
+		.upper_margin	= 7,
+		.lower_margin	= 40,
+		.hsync_len	= 96,
+		.vsync_len	= 1,
+		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_OE_ACT_HIGH,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.name		= "Sharp-LQ035Q7DH06-QVGA",
+	.mode		= fb_modedb,
+	.num_modes	= ARRAY_SIZE(fb_modedb),
+};
+
+static int isp1504_set_vbus_power(void __iomem *view, int on)
+{
+	int vid, pid, ret = 0;
+
+	vid = (ulpi_read(ISP1504_VID_HIGH, view) << 8) |
+		 ulpi_read(ISP1504_VID_LOW, view);
+	pid = (ulpi_read(ISP1504_PID_HIGH, view) << 8) |
+		 ulpi_read(ISP1504_PID_LOW, view);
+
+	pr_info("ULPI Vendor ID 0x%x    Product ID 0x%x\n", vid, pid);
+	if (vid != 0x4cc || pid != 0x1504) {
+		pr_err("No ISP1504 found\n");
+		return -1;
+	}
+
+	if (on) {
+		ret = ulpi_set(DRV_VBUS_EXT |	/* enable external Vbus */
+			    DRV_VBUS |		/* enable internal Vbus */
+			    USE_EXT_VBUS_IND |	/* use external indicator */
+			    CHRG_VBUS,		/* charge Vbus */
+			    ISP1504_OTGCTL, view);
+	} else {
+		ret = ulpi_clear(DRV_VBUS_EXT |	/* disable external Vbus */
+			      DRV_VBUS,		/* disable internal Vbus */
+			      ISP1504_OTGCTL, view);
+
+		ret |= ulpi_set(USE_EXT_VBUS_IND | /* use external indicator */
+			    DISCHRG_VBUS,	   /* discharge Vbus */
+			    ISP1504_OTGCTL, view);
+	}
+
+	return ret;
+}
+
+static unsigned int usb1_pins[] = {
+	MX31_PIN_USBOTG_DATA0__USBOTG_DATA0,
+	MX31_PIN_USBOTG_DATA1__USBOTG_DATA1,
+	MX31_PIN_USBOTG_DATA2__USBOTG_DATA2,
+	MX31_PIN_USBOTG_DATA3__USBOTG_DATA3,
+	MX31_PIN_USBOTG_DATA4__USBOTG_DATA4,
+	MX31_PIN_USBOTG_DATA5__USBOTG_DATA5,
+	MX31_PIN_USBOTG_DATA6__USBOTG_DATA6,
+	MX31_PIN_USBOTG_DATA7__USBOTG_DATA7,
+	MX31_PIN_USBOTG_CLK__USBOTG_CLK,
+	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
+	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
+	MX31_PIN_USBOTG_STP__USBOTG_STP,
+};
+
+static int pcm037_otg_init(struct platform_device *pdev)
+{
+	int ret;
+	unsigned int tmp;
+
+	tmp = readl(IO_ADDRESS(MX31_OTG_BASE_ADDR) + 0x600);
+	tmp &= ~((3 << 21) | 1);
+	tmp |= (1 << 5) | (1 << 16) | (1 << 19) | (1 << 11) | (1 << 20);
+	writel(tmp, IO_ADDRESS(MX31_OTG_BASE_ADDR) + 0x600);
+
+	tmp = readl(IO_ADDRESS(MX31_OTG_BASE_ADDR) + 0x184);
+	tmp &= ~(3 << 30);
+	tmp |= 2 << 30;
+	writel(tmp, IO_ADDRESS(MX31_OTG_BASE_ADDR) + 0x184);
+
+	mxc_iomux_setup_multiple_pins(usb1_pins, ARRAY_SIZE(usb1_pins),
+			"pcm037");
+
+	/* USB pins here */
+
+	mdelay(10);
+
+	ret = isp1504_set_vbus_power(IO_ADDRESS(MX31_OTG_BASE_ADDR + 0x170), 1);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data otg_pdata = {
+	.init = pcm037_otg_init,
+};
+
+static unsigned int usb2_pins[] = {
+	IOMUX_MODE(MX31_PIN_USBH2_CLK, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DIR, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_NXT, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_STP, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DATA0, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_USBH2_DATA1, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_STXD3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SRXD3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SCK3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SFS3, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_STXD6, IOMUX_CONFIG_FUNC),
+	IOMUX_MODE(MX31_PIN_SRXD6, IOMUX_CONFIG_FUNC),
+};
+
+static int pcm037_usbh2_init(struct platform_device *pdev)
+{
+	int ret;
+	unsigned int tmp;
+
+	tmp = readl(IO_ADDRESS(IOMUXC_BASE_ADDR + 0x8));
+	tmp |= 1 << 11;
+	writel(tmp, IO_ADDRESS(IOMUXC_BASE_ADDR + 0x8));
+
+	mxc_iomux_setup_multiple_pins(usb2_pins, ARRAY_SIZE(usb2_pins),
+			"pcm037");
+
+#define H2_PAD_CFG (PAD_CTL_DRV_MAX | PAD_CTL_SRE_FAST | PAD_CTL_HYS_CMOS | PAD_CTL_ODE_CMOS | PAD_CTL_100K_PU)
+	mxc_iomux_set_pad(MX31_PIN_USBH2_CLK, H2_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DIR, H2_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_NXT, H2_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_STP, H2_PAD_CFG);
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA0, H2_PAD_CFG); /* USBH2_DATA0 */
+	mxc_iomux_set_pad(MX31_PIN_USBH2_DATA1, H2_PAD_CFG); /* USBH2_DATA1 */
+	mxc_iomux_set_pad(MX31_PIN_SRXD6, H2_PAD_CFG);	/* USBH2_DATA2 */
+	mxc_iomux_set_pad(MX31_PIN_STXD6, H2_PAD_CFG);	/* USBH2_DATA3 */
+	mxc_iomux_set_pad(MX31_PIN_SFS3, H2_PAD_CFG);	/* USBH2_DATA4 */
+	mxc_iomux_set_pad(MX31_PIN_SCK3, H2_PAD_CFG);	/* USBH2_DATA5 */
+	mxc_iomux_set_pad(MX31_PIN_SRXD3, H2_PAD_CFG);	/* USBH2_DATA6 */
+	mxc_iomux_set_pad(MX31_PIN_STXD3, H2_PAD_CFG);	/* USBH2_DATA7 */
+
+	tmp = readl(IO_ADDRESS(MX31_OTG_BASE_ADDR) + 0x600);
+	tmp &= ~((3 << 21) | 1);
+	tmp |= (1 << 5) | (1 << 16) | (1 << 19) | (1 << 20);
+	writel(tmp, IO_ADDRESS(MX31_OTG_BASE_ADDR) + 0x600);
+
+	tmp = readl(IO_ADDRESS(MX31_OTG_BASE_ADDR) + 0x584);
+	tmp &= ~(3 << 30);
+	tmp |= 2 << 30;
+	writel(tmp, IO_ADDRESS(MX31_OTG_BASE_ADDR) + 0x584);
+
+	mdelay(10);
+
+	ret = isp1504_set_vbus_power(IO_ADDRESS(MX31_OTG_BASE_ADDR + 0x570), 1);
+
+	return 0;
+}
+
+struct mxc_usbh_platform_data usbh2_pdata = {
+	.init = pcm037_usbh2_init,
+};
+
+static struct resource pcm970_sja1000_resources[] = {
+	{
+		.start   = CS5_BASE_ADDR,
+		.end     = CS5_BASE_ADDR + 0x100 - 1,
+		.flags   = IORESOURCE_MEM,
+	}, {
+		.start   = IOMUX_TO_IRQ(IOMUX_PIN(48,   105)),
+		.end     = IOMUX_TO_IRQ(IOMUX_PIN(48,   105)),
+		.flags   = IORESOURCE_IRQ | IORESOURCE_IRQ_LOWEDGE,
+	},
+};
+
+struct sja1000_platform_data pcm970_sja1000_platform_data = {
+	.clock		= 16000000 / 2,
+	.ocr		= 0x40 | 0x18,
+	.cdr		= 0x40,
+};
+
+static struct platform_device pcm970_sja1000 = {
+	.name = "sja1000_platform",
+	.dev = {
+		.platform_data = &pcm970_sja1000_platform_data,
+	},
+	.resource = pcm970_sja1000_resources,
+	.num_resources = ARRAY_SIZE(pcm970_sja1000_resources),
+};
+
+/*
+ * Board specific initialization.
+ */
+static void __init mxc_board_init(void)
+{
+	int ret;
+
+	mxc_iomux_setup_multiple_pins(pcm037_pins, ARRAY_SIZE(pcm037_pins),
+			"pcm037");
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+	mxc_register_device(&mxc_uart_device2, &uart_pdata);
+
+	mxc_register_device(&mxc_w1_master_device, NULL);
+
+	/* LAN9217 IRQ pin */
+	ret = gpio_request(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1), "lan9217-irq");
+	if (ret)
+		pr_warning("could not get LAN irq gpio\n");
+	else {
+		gpio_direction_input(IOMUX_TO_GPIO(MX31_PIN_GPIO3_1));
+		platform_device_register(&pcm037_eth);
+	}
+
+	i2c_register_board_info(1, pcm037_i2c_devices,
+			ARRAY_SIZE(pcm037_i2c_devices));
+	i2c_register_board_info(2, pcm037_i2c_2_devices,
+			ARRAY_SIZE(pcm037_i2c_2_devices));
+
+	mxc_register_device(&mxc_i2c_device1, &pcm037_i2c_1_data);
+	mxc_register_device(&mxc_i2c_device2, &pcm037_i2c_2_data);
+
+	mxc_register_device(&mxc_nand_device, &pcm037_nand_board_info);
+	mxc_register_device(&mxcsdhc_device0, &sdhc_pdata);
+	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+	if (!gpio_usbotg_hs_activate())
+		mxc_register_device(&mxc_otg_udc_device, &usb_pdata);
+	mxc_register_device(&mxc_otg, &otg_pdata);
+	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
+
+#ifdef CONFIG_SPI
+	mxc_register_device(&imx_spi_device0, &pcm037_spi_0_data);
+
+	spi_register_board_info(pcm037_spi_board_info,
+			ARRAY_SIZE(pcm037_spi_board_info));
+#endif
+
+	platform_device_register(&pcm970_sja1000);
+
+	/* CSI */
+	/* Camera power: default - off */
+	gpio_direction_output(IOMUX_TO_GPIO(MX31_PIN_CSI_D5), 1);
+
+	if (!pcm037_camera_alloc_dma(4 * 1024 * 1024))
+		mxc_register_device(&mx3_camera, &camera_pdata);
+}
+
+static void __init pcm037_timer_init(void)
+{
+	mx31_clocks_init(26000000);
+}
+
+struct sys_timer pcm037_timer = {
+	.init	= pcm037_timer_init,
+};
+
+MACHINE_START(PCM037, "Phytec Phycore pcm037")
+	/* Maintainer: Pengutronix */
+	.phys_io	= AIPS1_BASE_ADDR,
+	.io_pg_offst	= ((AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params    = PHYS_OFFSET + 0x100,
+	.map_io         = mx31_map_io,
+	.init_irq       = mxc_init_irq,
+	.init_machine   = mxc_board_init,
+	.timer          = &pcm037_timer,
+MACHINE_END
+
diff --git a/arch/arm/mach-mx3/pcm043.c b/arch/arm/mach-mx3/pcm043.c
new file mode 100644
index 0000000..25c2c32
--- /dev/null
+++ b/arch/arm/mach-mx3/pcm043.c
@@ -0,0 +1,367 @@
+/*
+ *  Copyright (C) 2009 Sascha Hauer, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/plat-ram.h>
+#include <linux/memory.h>
+#include <linux/gpio.h>
+#include <linux/smc911x.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/i2c/at24.h>
+#include <linux/fsl_devices.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/eeprom.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/i2c.h>
+#include <mach/iomux-mx35.h>
+#include <mach/ipu.h>
+#include <mach/mx3fb.h>
+#include <mach/mxc_ehci.h>
+#include <mach/spi.h>
+
+#include "devices.h"
+
+static const struct fb_videomode fb_modedb[] = {
+	{
+		/* 240x320 @ 60 Hz */
+		.name		= "Sharp-LQ035Q7",
+		.refresh	= 60,
+		.xres		= 240,
+		.yres		= 320,
+		.pixclock	= 185925,
+		.left_margin	= 9,
+		.right_margin	= 16,
+		.upper_margin	= 7,
+		.lower_margin	= 9,
+		.hsync_len	= 1,
+		.vsync_len	= 1,
+		.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_SHARP_MODE | FB_SYNC_CLK_INVERT | FB_SYNC_CLK_IDLE_EN,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	}, {
+		/* 240x320 @ 60 Hz */
+		.name		= "TX090",
+		.refresh	= 60,
+		.xres		= 240,
+		.yres		= 320,
+		.pixclock	= 38255,
+		.left_margin	= 144,
+		.right_margin	= 0,
+		.upper_margin	= 7,
+		.lower_margin	= 40,
+		.hsync_len	= 96,
+		.vsync_len	= 1,
+		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_OE_ACT_HIGH,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+};
+
+static struct ipu_platform_data mx3_ipu_data = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct mx3fb_platform_data mx3fb_pdata = {
+	.dma_dev	= &mx3_ipu.dev,
+	.name		= "Sharp-LQ035Q7",
+	.mode		= fb_modedb,
+	.num_modes	= ARRAY_SIZE(fb_modedb),
+};
+
+static struct physmap_flash_data pcm043_flash_data = {
+	.width  = 2,
+};
+
+static struct resource pcm043_flash_resource = {
+	.start	= 0xa0000000,
+	.end	= 0xa1ffffff,
+	.flags	= IORESOURCE_MEM,
+};
+
+static struct platform_device pcm043_flash = {
+	.name	= "physmap-flash",
+	.id	= 0,
+	.dev	= {
+		.platform_data  = &pcm043_flash_data,
+	},
+	.resource = &pcm043_flash_resource,
+	.num_resources = 1,
+};
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct imxi2c_platform_data pcm043_i2c_1_data = {
+	.bitrate = 50000,
+};
+
+static struct at24_platform_data board_eeprom = {
+	.byte_len = 4096,
+	.page_size = 32,
+	.flags = AT24_FLAG_ADDR16,
+};
+
+static struct i2c_board_info pcm043_i2c_devices[] = {
+       {
+		I2C_BOARD_INFO("at24", 0x52), /* E0=0, E1=1, E2=0 */
+		.platform_data = &board_eeprom,
+	}, {
+		I2C_BOARD_INFO("rtc-pcf8563", 0x51),
+		.type = "pcf8563",
+	}
+};
+
+static struct platform_device *devices[] __initdata = {
+	&pcm043_flash,
+	&mxc_fec_device,
+};
+
+static struct pad_desc pcm043_pads[] = {
+	/* UART1 */
+	MX35_PAD_CTS1__UART1_CTS,
+	MX35_PAD_RTS1__UART1_RTS,
+	MX35_PAD_TXD1__UART1_TXD_MUX,
+	MX35_PAD_RXD1__UART1_RXD_MUX,
+	/* UART2 */
+	MX35_PAD_CTS2__UART2_CTS,
+	MX35_PAD_RTS2__UART2_RTS,
+	MX35_PAD_TXD2__UART2_TXD_MUX,
+	MX35_PAD_RXD2__UART2_RXD_MUX,
+	/* FEC */
+	MX35_PAD_FEC_TX_CLK__FEC_TX_CLK,
+	MX35_PAD_FEC_RX_CLK__FEC_RX_CLK,
+	MX35_PAD_FEC_RX_DV__FEC_RX_DV,
+	MX35_PAD_FEC_COL__FEC_COL,
+	MX35_PAD_FEC_RDATA0__FEC_RDATA_0,
+	MX35_PAD_FEC_TDATA0__FEC_TDATA_0,
+	MX35_PAD_FEC_TX_EN__FEC_TX_EN,
+	MX35_PAD_FEC_MDC__FEC_MDC,
+	MX35_PAD_FEC_MDIO__FEC_MDIO,
+	MX35_PAD_FEC_TX_ERR__FEC_TX_ERR,
+	MX35_PAD_FEC_RX_ERR__FEC_RX_ERR,
+	MX35_PAD_FEC_CRS__FEC_CRS,
+	MX35_PAD_FEC_RDATA1__FEC_RDATA_1,
+	MX35_PAD_FEC_TDATA1__FEC_TDATA_1,
+	MX35_PAD_FEC_RDATA2__FEC_RDATA_2,
+	MX35_PAD_FEC_TDATA2__FEC_TDATA_2,
+	MX35_PAD_FEC_RDATA3__FEC_RDATA_3,
+	MX35_PAD_FEC_TDATA3__FEC_TDATA_3,
+	/* I2C1 */
+	MX35_PAD_I2C1_CLK__I2C1_SCL,
+	MX35_PAD_I2C1_DAT__I2C1_SDA,
+	/* Display */
+	MX35_PAD_LD0__IPU_DISPB_DAT_0,
+	MX35_PAD_LD1__IPU_DISPB_DAT_1,
+	MX35_PAD_LD2__IPU_DISPB_DAT_2,
+	MX35_PAD_LD3__IPU_DISPB_DAT_3,
+	MX35_PAD_LD4__IPU_DISPB_DAT_4,
+	MX35_PAD_LD5__IPU_DISPB_DAT_5,
+	MX35_PAD_LD6__IPU_DISPB_DAT_6,
+	MX35_PAD_LD7__IPU_DISPB_DAT_7,
+	MX35_PAD_LD8__IPU_DISPB_DAT_8,
+	MX35_PAD_LD9__IPU_DISPB_DAT_9,
+	MX35_PAD_LD10__IPU_DISPB_DAT_10,
+	MX35_PAD_LD11__IPU_DISPB_DAT_11,
+	MX35_PAD_LD12__IPU_DISPB_DAT_12,
+	MX35_PAD_LD13__IPU_DISPB_DAT_13,
+	MX35_PAD_LD14__IPU_DISPB_DAT_14,
+	MX35_PAD_LD15__IPU_DISPB_DAT_15,
+	MX35_PAD_LD16__IPU_DISPB_DAT_16,
+	MX35_PAD_LD17__IPU_DISPB_DAT_17,
+	MX35_PAD_D3_HSYNC__IPU_DISPB_D3_HSYNC,
+	MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK,
+	MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY,
+	MX35_PAD_CONTRAST__IPU_DISPB_CONTR,
+	MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC,
+	MX35_PAD_D3_REV__IPU_DISPB_D3_REV,
+	MX35_PAD_D3_CLS__IPU_DISPB_D3_CLS,
+	MX35_PAD_D3_SPL__IPU_DISPB_D3_SPL,
+	/* USB host */
+	MX35_PAD_I2C2_CLK__USB_TOP_USBH2_PWR,
+	MX35_PAD_I2C2_DAT__USB_TOP_USBH2_OC,
+	/* SPI2 */
+	MX35_PAD_SCK5__CSPI2_SCLK,
+	MX35_PAD_STXD5__CSPI2_MOSI,
+	MX35_PAD_SRXD5__CSPI2_MISO,
+	MX35_PAD_HCKR__GPIO1_6,
+	/* gpio */
+	MX35_PAD_ATA_CS0__GPIO2_6,
+};
+
+static int pcm043_usbh1_init(struct platform_device *pdev)
+{
+	unsigned int tmp;
+
+	tmp = readl(IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x600);
+	tmp &= ~((3 << 21) | (1 << 2) | (1 << 16));
+	tmp |= (1 << 4) | (2 << 21) | (1 << 19) | (1 << 12) | (1 << 6) | (1 << 5);
+	writel(tmp, IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x600);
+
+	tmp = readl(IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x584);
+	tmp |= (3 << 30);
+	writel(tmp, IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x584);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data usbh1_pdata = {
+	.init = pcm043_usbh1_init,
+};
+
+static int pcm043_otg_init(struct platform_device *pdev)
+{
+	unsigned int tmp;
+
+	tmp = readl(IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x600);
+	tmp &= ~(3 << 29);
+	tmp |= (2 << 29);
+	writel(tmp, IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x600);
+
+	tmp = readl(IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x184);
+	tmp &= ~(3 << 30);
+	writel(tmp, IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x184);
+
+	return 0;
+}
+
+static struct mxc_usbh_platform_data otg_pdata = {
+	.init = pcm043_otg_init,
+};
+
+static struct fsl_usb2_platform_data usb_data = {
+	.operating_mode	= FSL_USB2_DR_DEVICE,
+	.phy_mode	= FSL_USB2_PHY_UTMI,
+};
+
+static int otg_mode_host;
+
+static int __init pcm043_otg_mode(char *options)
+{
+	if (!strcmp(options, "host"))
+		otg_mode_host = 1;
+	else if (!strcmp(options, "device"))
+		otg_mode_host = 0;
+	else
+		pr_info("pcm043_otg_mode neither \"host\" nor \"device\". "
+			"Defaulting to device\n");
+	return 0;
+}
+__setup("pcm043_otg_mode=", pcm043_otg_mode);
+
+#ifdef CONFIG_SPI
+static struct spi_eeprom at25320 = {
+	.name		= "at25320an",
+	.byte_len	= 4096,
+	.page_size	= 32,
+	.flags		= EE_ADDR2,
+};
+
+static unsigned int pcm043_spi_cs[] = {6, };
+
+static struct spi_imx_master pcm043_spi_0_data = {
+	.chipselect = pcm043_spi_cs,
+	.num_chipselect = ARRAY_SIZE(pcm043_spi_cs),
+};
+
+static struct spi_board_info pcm043_spi_board_info[] __initdata = {
+	{
+		.modalias = "at25",
+		.max_speed_hz = 300000,
+		.bus_num = 1,
+		.chip_select = 0,
+		.platform_data = &at25320,
+	}
+};
+#endif /* CONFIG_SPI */
+
+/*
+ * Board specific initialization.
+ */
+static void __init mxc_board_init(void)
+{
+	unsigned int tmp;
+
+	mxc_iomux_v3_setup_multiple_pads(pcm043_pads, ARRAY_SIZE(pcm043_pads));
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+
+	mxc_register_device(&mxc_uart_device1, &uart_pdata);
+
+	i2c_register_board_info(0, pcm043_i2c_devices,
+			ARRAY_SIZE(pcm043_i2c_devices));
+
+	mxc_register_device(&mxc_i2c_device0, &pcm043_i2c_1_data);
+
+	mxc_register_device(&mx3_ipu, &mx3_ipu_data);
+	mxc_register_device(&mx3_fb, &mx3fb_pdata);
+
+	tmp = readl(IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x600);
+	tmp &= ~(3 << 29);
+	tmp |= (2 << 29);
+	writel(tmp, IO_ADDRESS(MX35_OTG_BASE_ADDR) + 0x600);
+
+	mxc_register_device(&mxc_usbh1, &usbh1_pdata);
+	if (otg_mode_host)
+		mxc_register_device(&mxc_otg, &otg_pdata);
+	else
+		mxc_register_device(&mxc_otg_udc_device, &usb_data);
+
+#ifdef CONFIG_SPI
+	mxc_register_device(&imx_spi_device1, &pcm043_spi_0_data);
+
+	spi_register_board_info(pcm043_spi_board_info,
+			ARRAY_SIZE(pcm043_spi_board_info));
+#endif
+}
+
+static void __init pcm043_timer_init(void)
+{
+	mx35_clocks_init();
+}
+
+struct sys_timer pcm043_timer = {
+	.init	= pcm043_timer_init,
+};
+
+MACHINE_START(PCM043, "Phytec Phycore pcm043")
+	/* Maintainer: Pengutronix */
+	.phys_io	= AIPS1_BASE_ADDR,
+	.io_pg_offst	= ((AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params    = PHYS_OFFSET + 0x100,
+	.map_io         = mx35_map_io,
+	.init_irq       = mxc_init_irq,
+	.init_machine   = mxc_board_init,
+	.timer          = &pcm043_timer,
+MACHINE_END
+
-- 
1.6.6
