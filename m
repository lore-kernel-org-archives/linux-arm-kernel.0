From: philippe.retornaz@epfl.ch (=?UTF-8?q?Philippe=20R=C3=A9tornaz?=)
Date: Tue, 15 May 2012 13:53:52 +0200
Subject: [PATCH 4/4] mx31moboard: Add sound support
In-Reply-To: <1337082832-9764-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-2-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-4-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <1337082832-9764-5-git-send-email-philippe.retornaz@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/Kconfig            |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c |   20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7561eca..0d75480 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -493,6 +493,7 @@ config MACH_MX31MOBOARD
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_IMX_SSI
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IPU_CORE
 	select IMX_HAVE_PLATFORM_MXC_EHCI
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index f17a15f..31e5b3d 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -47,6 +47,7 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
+#include <mach/ssi.h>
 
 #include "devices-imx31.h"
 
@@ -102,6 +103,9 @@ static unsigned int moboard_pins[] = {
 	MX31_PIN_CSPI3_MOSI__MOSI, MX31_PIN_CSPI3_MISO__MISO,
 	MX31_PIN_CSPI3_SCLK__SCLK, MX31_PIN_CSPI3_SPI_RDY__SPI_RDY,
 	MX31_PIN_CSPI2_SS1__CSPI3_SS1,
+	/* SSI */
+	MX31_PIN_STXD4__STXD4, MX31_PIN_SRXD4__SRXD4,
+	MX31_PIN_SCK4__SCK4, MX31_PIN_SFS4__SFS4,
 };
 
 static struct physmap_flash_data mx31moboard_flash_data = {
@@ -276,6 +280,11 @@ static struct mc13xxx_buttons_platform_data moboard_buttons = {
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
@@ -283,7 +292,12 @@ static struct mc13xxx_platform_data moboard_pmic = {
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
@@ -554,6 +568,10 @@ static void __init mx31moboard_init(void)
 
 	moboard_usbh2_init();
 
+	imx31_add_imx_ssi(0, &moboard_ssi_pdata);
+
+	imx_add_platform_device("imx_mc13783", 0, NULL, 0, NULL, 0);
+
 	pm_power_off = mx31moboard_poweroff;
 
 	switch (mx31moboard_baseboard) {
-- 
1.7.0.4
