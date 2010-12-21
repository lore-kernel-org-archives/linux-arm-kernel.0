From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 21 Dec 2010 17:58:41 -0200
Subject: [PATCH 3/3] ARM: imx/mx25_3ds: Add USB support
In-Reply-To: <1292961521-31539-2-git-send-email-fabio.estevam@freescale.com>
References: <1292961521-31539-1-git-send-email-fabio.estevam@freescale.com>
	<1292961521-31539-2-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1292961521-31539-3-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    3 +++
 arch/arm/mach-imx/mach-mx25_3ds.c |   16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index fed3ee5..4a6c51a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -97,14 +97,17 @@ comment "MX25 platforms:"
 config MACH_MX25_3DS
 	bool "Support MX25PDK (3DS) Platform"
 	select SOC_IMX25
+	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMXDI_RTC
 	select IMX_HAVE_PLATFORM_IMX_FB
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_EHCI
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
+	select MXC_ULPI if USB_ULPI
 
 config MACH_EUKREA_CPUIMX25
 	bool "Support Eukrea CPUIMX25 Platform"
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 8b8e75b..62885d4 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -30,6 +30,8 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/input/matrix_keypad.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/ulpi.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -40,6 +42,7 @@
 #include <mach/common.h>
 #include <mach/mx25.h>
 #include <mach/iomux-mx25.h>
+#include <mach/ulpi.h>
 
 #include "devices-imx25.h"
 
@@ -184,13 +187,24 @@ static const struct matrix_keymap_data mx25pdk_keymap_data __initdata = {
 	.keymap_size	= ARRAY_SIZE(mx25pdk_keymap),
 };
 
+static const struct mxc_usbh_platform_data usbh2_pdata __initconst = {
+	.portsc	= MXC_EHCI_MODE_SERIAL,
+	.flags	= MXC_EHCI_INTERNAL_PHY,
+};
+
+static const struct fsl_usb2_platform_data otg_device_pdata __initconst = {
+	.operating_mode = FSL_USB2_DR_DEVICE,
+	.phy_mode       = FSL_USB2_PHY_UTMI,
+};
+
 static void __init mx25pdk_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
 			ARRAY_SIZE(mx25pdk_pads));
 
 	imx25_add_imx_uart0(&uart_pdata);
-	imx25_add_mxc_ehci_hs(NULL);
+	imx25_add_fsl_usb2_udc(&otg_device_pdata);
+	imx25_add_mxc_ehci_hs(&usbh2_pdata);
 	imx25_add_mxc_nand(&mx25pdk_nand_board_info);
 	imx25_add_imxdi_rtc(NULL);
 	imx25_add_imx_fb(&mx25pdk_fb_pdata);
-- 
1.6.0.4
