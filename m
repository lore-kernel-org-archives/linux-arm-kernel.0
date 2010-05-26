From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Wed, 26 May 2010 21:18:35 +0200
Subject: [PATCH 3/4] eukrea_mbimx27: add audio codec
Message-ID: <mailman.471.1274924681.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c |   44 +++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
index 34bdc26..471dbd2 100644
--- a/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-mx2/eukrea_mbimx27-baseboard.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2009 Eric Benard - eric at eukrea.com
+ * Copyright (C) 2009-2010 Eric Benard - eric at eukrea.com
  *
  * Based on pcm970-baseboard.c which is :
  * Copyright (C) 2008 Juergen Beisert (kernel at pengutronix.de)
@@ -37,6 +37,8 @@
 #include <mach/mmc.h>
 #include <mach/imx-uart.h>
 #include <mach/spi.h>
+#include <mach/ssi.h>
+#include <mach/audmux.h>
 
 #include "devices.h"
 
@@ -93,6 +95,13 @@ static int eukrea_mbimx27_pins[] = {
 	PD29_PF_CSPI1_SCLK,
 	PD30_PF_CSPI1_MISO,
 	PD31_PF_CSPI1_MOSI,
+	/* SSI4 */
+#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
+	PC16_PF_SSI4_FS,
+	PC17_PF_SSI4_RXD | GPIO_PUEN,
+	PC18_PF_SSI4_TXD | GPIO_PUEN,
+	PC19_PF_SSI4_CLK,
+#endif
 };
 
 static const uint32_t eukrea_mbimx27_keymap[] = {
@@ -287,6 +296,12 @@ static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
 	},
 };
 
+static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
+	{
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
+	},
+};
+
 static int eukrea_mbimx27_spi_cs[] = {GPIO_PORTD | 28};
 
 static struct spi_imx_master eukrea_mbimx27_spi_0_data = {
@@ -303,6 +318,10 @@ static struct imxmmc_platform_data sdhc_pdata = {
 	.dat3_card_detect = 1,
 };
 
+struct imx_ssi_platform_data eukrea_mbimx27_ssi_pdata = {
+	.flags = IMX_SSI_DMA,
+};
+
 /*
  * system init for baseboard usage. Will be called by cpuimx27 init.
  *
@@ -314,6 +333,24 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	mxc_gpio_setup_multiple_pins(eukrea_mbimx27_pins,
 		ARRAY_SIZE(eukrea_mbimx27_pins), "MBIMX27");
 
+#if defined(CONFIG_SND_SOC_EUKREA_TLV320)
+	/* SSI unit master I2S codec connected to SSI_PINS_4*/
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			MXC_AUDMUX_V1_PCR_SYN |
+			MXC_AUDMUX_V1_PCR_TFSDIR |
+			MXC_AUDMUX_V1_PCR_TCLKDIR |
+			MXC_AUDMUX_V1_PCR_RFSDIR |
+			MXC_AUDMUX_V1_PCR_RCLKDIR |
+			MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+			MXC_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4)
+	);
+	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
+			MXC_AUDMUX_V1_PCR_SYN |
+			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
+	);
+#endif
+
 	mxc_register_device(&mxc_uart_device1, &uart_pdata[0]);
 	mxc_register_device(&mxc_uart_device2, &uart_pdata[1]);
 #if !defined(MACH_EUKREA_CPUIMX27_USEUART4)
@@ -323,6 +360,11 @@ void __init eukrea_mbimx27_baseboard_init(void)
 	mxc_register_device(&mxc_fb_device, &eukrea_mbimx27_fb_data);
 	mxc_register_device(&mxc_sdhc_device0, &sdhc_pdata);
 
+	i2c_register_board_info(0, eukrea_mbimx27_i2c_devices,
+				ARRAY_SIZE(eukrea_mbimx27_i2c_devices));
+
+	mxc_register_device(&imx_ssi_device0, &eukrea_mbimx27_ssi_pdata);
+
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) \
 	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 	/* ADS7846 Touchscreen controller init */
-- 
1.6.3.3


--------------010207020109090402010001--
