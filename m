From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 09:20:17 +0200
Subject: [PATCH 02/12] ARM: imx: eukrea_mbimxsd25: add spi controler and
 spidev support
In-Reply-To: <1336461627-30315-1-git-send-email-eric@eukrea.com>
References: <1336461627-30315-1-git-send-email-eric@eukrea.com>
Message-ID: <1336461627-30315-2-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                      |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |   42 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7561eca..e102f8f 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -181,6 +181,7 @@ config MACH_EUKREA_MBIMXSD25_BASEBOARD
 	bool "Eukrea MBIMXSD development board"
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	select IMX_HAVE_PLATFORM_IMX_SSI
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	select LEDS_GPIO_REGISTER
 	help
 	  This adds board specific devices that can be found on Eukrea's
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index 2cf603e..cafa109 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -23,6 +23,7 @@
 #include <linux/leds.h>
 #include <linux/platform_device.h>
 #include <linux/input.h>
+#include <linux/spi/spi.h>
 #include <video/platform_lcd.h>
 
 #include <mach/hardware.h>
@@ -87,12 +88,22 @@ static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	/* CAN */
 	MX25_PAD_GPIO_D__CAN2_RX,
 	MX25_PAD_GPIO_C__CAN2_TX,
+	/* SPI1 */
+	MX25_PAD_CSPI1_MOSI__CSPI1_MOSI,
+	MX25_PAD_CSPI1_MISO__CSPI1_MISO,
+	MX25_PAD_CSPI1_SS0__GPIO_1_16,
+	MX25_PAD_CSPI1_SS1__GPIO_1_17,
+	MX25_PAD_CSPI1_SCLK__CSPI1_SCLK,
+	MX25_PAD_CSPI1_RDY__GPIO_2_22,
 };
 
 #define GPIO_LED1	83
 #define GPIO_SWITCH1	82
 #define GPIO_SD1CD	52
 #define GPIO_LCDPWR	26
+#define	GPIO_SPI1_SS0	IMX_GPIO_NR(1, 16)
+#define	GPIO_SPI1_SS1	IMX_GPIO_NR(1, 17)
+#define	GPIO_SPI1_IRQ	IMX_GPIO_NR(2, 22)
 
 static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
 	{
@@ -228,6 +239,30 @@ static struct esdhc_platform_data sd1_pdata = {
 	.wp_type = ESDHC_WP_NONE,
 };
 
+static struct spi_board_info eukrea_mbimxsd25_spi_board_info[] __initdata = {
+	{
+		.modalias = "spidev",
+		.max_speed_hz = 20000000,
+		.bus_num = 0,
+		.chip_select = 0,
+		.mode = SPI_MODE_0,
+	},
+	{
+		.modalias = "spidev",
+		.max_speed_hz = 20000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = SPI_MODE_0,
+	},
+};
+
+static int eukrea_mbimxsd25_spi_cs[] = {GPIO_SPI1_SS0, GPIO_SPI1_SS1};
+
+static const struct spi_imx_master eukrea_mbimxsd25_spi0_data __initconst = {
+	.chipselect     = eukrea_mbimxsd25_spi_cs,
+	.num_chipselect = ARRAY_SIZE(eukrea_mbimxsd25_spi_cs),
+};
+
 /*
  * system init for baseboard usage. Will be called by cpuimx25 init.
  *
@@ -262,6 +297,13 @@ void __init eukrea_mbimxsd25_baseboard_init(void)
 	i2c_register_board_info(0, eukrea_mbimxsd_i2c_devices,
 				ARRAY_SIZE(eukrea_mbimxsd_i2c_devices));
 
+	gpio_request(GPIO_SPI1_IRQ, "SPI1_IRQ");
+	gpio_direction_input(GPIO_SPI1_IRQ);
+	gpio_free(GPIO_SPI1_IRQ);
+	imx25_add_spi_imx0(&eukrea_mbimxsd25_spi0_data);
+	spi_register_board_info(eukrea_mbimxsd25_spi_board_info,
+		ARRAY_SIZE(eukrea_mbimxsd25_spi_board_info));
+
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
 	gpio_led_register_device(-1, &eukrea_mbimxsd_led_info);
 	imx_add_gpio_keys(&eukrea_mbimxsd_button_data);
-- 
1.7.7.6
