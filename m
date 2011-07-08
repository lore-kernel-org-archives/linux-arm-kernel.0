From: juergen.lambrecht@gmail.com (=?UTF-8?q?J=C3=BCrgen=20Lambrecht?=)
Date: Fri,  8 Jul 2011 15:28:58 +0200
Subject: [RFC PATCH] ARM: imx27pdk (3ds): enable m13783 codec over SSI
Message-ID: <1310131738-668-1-git-send-email-J.Lambrecht@televic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- add SSI in Kconfig
- enable audio in MFD mc13783
- configure audmux-v1
- configure SSI4

Signed-off-by: J?rgen Lambrecht <J.Lambrecht@televic.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |   40 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0a3512b..2fe5e70 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -286,6 +286,7 @@ config MACH_MX27_3DS
 	select IMX_HAVE_PLATFORM_MXC_MMC
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SPI_IMX
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select MXC_DEBUG_BOARD
 	select MXC_ULPI if USB_ULPI
 	help
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 2787cf3..c0f7dcc 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -41,6 +41,7 @@
 #include <mach/irqs.h>
 #include <mach/3ds_debugboard.h>
 #include <mach/mxc_nand.h>
+#include <mach/audmux.h>
 
 #include "devices-imx27.h"
 
@@ -101,6 +102,11 @@ static const int mx27pdk_pins[] __initconst = {
 	PE2_PF_USBOTG_DIR,
 	PE24_PF_USBOTG_CLK,
 	PE25_PF_USBOTG_DATA7,
+	/* SSI4 for audio to MC13783 */
+	PC16_PF_SSI4_FS,
+	PC17_PF_SSI4_RXD,
+	PC18_PF_SSI4_TXD,
+	PC19_PF_SSI4_CLK,
 	/* CSPI1 */
 	PD31_PF_CSPI1_MOSI,
 	PD30_PF_CSPI1_MISO,
@@ -271,6 +277,13 @@ static struct regulator_init_data vgen_init = {
 	.consumer_supplies = vgen_consumers,
 };
 
+static struct regulator_init_data vaudio_init = {
+	.constraints = {
+		.boot_on	= 1,
+		.always_on	= 1,
+	},
+};
+
 static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 	{
 		.id = MC13783_REG_VMMC1,
@@ -284,6 +297,9 @@ static struct mc13xxx_regulator_init_data mx27_3ds_regulators[] = {
 	}, {
 		.id = MC13783_REG_GPO3, /* Turn on 3.3V */
 		.init_data = &gpo_init,
+	}, {
+		.id = MC13783_REG_VAUDIO,  /* Power codec */
+		.init_data = &vaudio_init,
 	},
 };
 
@@ -295,7 +311,7 @@ static struct mc13xxx_platform_data mc13783_pdata = {
 
 	},
 	.flags  = MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN |
-	MC13783_USE_RTC,
+	MC13783_USE_RTC | MC13783_USE_CODEC,
 };
 
 /* SPI */
@@ -385,6 +401,11 @@ static const struct imxi2c_platform_data mx27_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
 
+/* 4-wire is synchronous; SSI-slave and MC13783-master; DMA instead of FIQ */
+static const struct imx_ssi_platform_data mx27pdk_ssi4_pdata __initconst = {
+	.flags			= IMX_SSI_SYN | IMX_SSI_DMA | IMX_SSI_USE_I2S_SLAVE,
+};
+
 static void __init mx27pdk_init(void)
 {
 	imx27_soc_init();
@@ -420,6 +441,23 @@ static void __init mx27pdk_init(void)
 		pr_warn("Init of the debugboard failed, all devices on the debugboard are unusable.\n");
 	imx27_add_imx_i2c(0, &mx27_3ds_i2c0_data);
 	imx27_add_imx_fb(&mx27_3ds_fb_data);
+
+	/* SSI unit master I2S codec connected to SSI_PINS_4*/
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+			MXC_AUDMUX_V1_PCR_TFSDIR |  /* Transmit Frame Sync is output */
+			MXC_AUDMUX_V1_PCR_TCLKDIR | /* Transmit Clock is output */
+			MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) | /*Transmit Frame Sync and Clock select source port to be HPCR3 or external SSI4*/
+			MXC_AUDMUX_V1_PCR_RFSDIR |  /* Receive Frame Sync is output */
+			MXC_AUDMUX_V1_PCR_RCLKDIR | /* Receive Clock is output */
+			MXC_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) | /*Receive Frame Sync and Clock select source port to be HPCR3 or external SSI4*/
+			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) /*Receive Data select source port to be HPCR3 or external SSI4*/
+	);
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
+			MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0) /*Receive Data select source port to be HPCR1 or internal SSI1*/
+	);
+	imx27_add_imx_ssi(0, &mx27pdk_ssi4_pdata);
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.7.1
