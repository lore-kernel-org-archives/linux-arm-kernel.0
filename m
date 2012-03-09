From: philippe.retornaz@epfl.ch (=?utf-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Fri,  9 Mar 2012 15:55:15 +0100
Subject: [PATCH 3/4] mx31moboard: Add ssi configuration
In-Reply-To: <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
 <1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1331304916-4724-4-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/Kconfig            |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c |   37 +++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4defb97..2c60f63 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -493,6 +493,7 @@ config MACH_MX31MOBOARD
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index f225262..23e9d6e 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -42,11 +42,13 @@
 #include <asm/mach/time.h>
 #include <asm/mach/map.h>
 #include <asm/memblock.h>
+#include <mach/audmux.h>
 #include <mach/board-mx31moboard.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
+#include <mach/ssi.h>
 
 #include "devices-imx31.h"
 
@@ -102,6 +104,9 @@ static unsigned int moboard_pins[] = {
 	MX31_PIN_CSPI3_MOSI__MOSI, MX31_PIN_CSPI3_MISO__MISO,
 	MX31_PIN_CSPI3_SCLK__SCLK, MX31_PIN_CSPI3_SPI_RDY__SPI_RDY,
 	MX31_PIN_CSPI2_SS1__CSPI3_SS1,
+	/* SSI */
+	MX31_PIN_STXD4__STXD4, MX31_PIN_SRXD4__SRXD4,
+	MX31_PIN_SCK4__SCK4, MX31_PIN_SFS4__SFS4,
 };
 
 static struct physmap_flash_data mx31moboard_flash_data = {
@@ -276,6 +281,11 @@ static struct mc13xxx_buttons_platform_data moboard_buttons = {
 	.b1on_key = KEY_POWER,
 };
 
+static struct mc13xxx_codec_platform_data moboard_codec = {
+	.dac_ssi_port = MC13783_SSI1_PORT,
+	.adc_ssi_port = MC13783_SSI1_PORT,
+};
+
 static struct mc13xxx_platform_data moboard_pmic = {
 	.regulators = {
 		.regulators = moboard_regulators,
@@ -283,7 +293,12 @@ static struct mc13xxx_platform_data moboard_pmic = {
 	},
 	.leds = &moboard_leds,
 	.buttons = &moboard_buttons,
-	.flags = MC13XXX_USE_RTC | MC13XXX_USE_ADC,
+	.codec = &moboard_codec,
+	.flags = MC13XXX_USE_RTC | MC13XXX_USE_ADC | MC13XXX_USE_CODEC,
+};
+
+static struct imx_ssi_platform_data moboard_ssi_pdata = {
+	.flags = IMX_SSI_DMA | IMX_SSI_NET,
 };
 
 static struct spi_board_info moboard_spi_board_info[] __initdata = {
@@ -527,6 +542,24 @@ static void __init mx31moboard_init(void)
 	mxc_iomux_setup_multiple_pins(moboard_pins, ARRAY_SIZE(moboard_pins),
 		"moboard");
 
+	mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT4_SSI_PINS_4,
+			MXC_AUDMUX_V2_PTCR_SYN,
+			MXC_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0) |
+			MXC_AUDMUX_V2_PDCR_MODE(1) |
+			MXC_AUDMUX_V2_PDCR_INMMASK(0xfc));
+
+	mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0,
+		MXC_AUDMUX_V2_PTCR_SYN |
+		MXC_AUDMUX_V2_PTCR_TFSDIR |
+		MXC_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		MXC_AUDMUX_V2_PTCR_TCLKDIR |
+		MXC_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		MXC_AUDMUX_V2_PTCR_RFSDIR |
+		MXC_AUDMUX_V2_PTCR_RFSEL(MX31_AUDMUX_PORT4_SSI_PINS_4) |
+		MXC_AUDMUX_V2_PTCR_RCLKDIR |
+		MXC_AUDMUX_V2_PTCR_RCSEL(MX31_AUDMUX_PORT4_SSI_PINS_4),
+		MXC_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT4_SSI_PINS_4));
+
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 	gpio_led_register_device(-1, &mx31moboard_led_pdata);
 
@@ -552,6 +585,8 @@ static void __init mx31moboard_init(void)
 
 	moboard_usbh2_init();
 
+	imx31_add_imx_ssi(0, &moboard_ssi_pdata);
+
 	pm_power_off = mx31moboard_poweroff;
 
 	switch (mx31moboard_baseboard) {
-- 
1.6.3.3
