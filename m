From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 21 Mar 2011 16:15:43 +0100
Subject: [PATCH] ARM: mxs: Enable SPI-GPIO support on TX28
In-Reply-To: <1300720545-14123-1-git-send-email-LW@KARO-electronics.de>
References: <1300720545-14123-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1300720545-14123-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-mxs/mach-tx28.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
index 52e05a1..b0d91e7 100644
--- a/arch/arm/mach-mxs/mach-tx28.c
+++ b/arch/arm/mach-mxs/mach-tx28.c
@@ -134,6 +134,13 @@ static const iomux_cfg_t tx28_stk5v3_pads[] __initconst = {
 		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
 	MX28_PAD_SSP0_SCK__SSP0_SCK |
 		(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
+	/* SPI GPIO */
+	MX28_PAD_AUART2_RX__GPIO_3_8,
+	MX28_PAD_AUART2_TX__GPIO_3_9,
+	MX28_PAD_SSP3_MOSI__GPIO_2_25,
+	MX28_PAD_SSP3_MISO__GPIO_2_26,
+	MX28_PAD_SSP3_SCK__GPIO_2_24,
 };
 
 static struct gpio_led tx28_stk5v3_leds[] = {
@@ -153,13 +160,28 @@ static struct spi_board_info tx28_spi_board_info[] = {
 	{
 		.modalias = "spidev",
 		.max_speed_hz = 20000000,
-		.bus_num = 0,
+		.bus_num = 1,
+		.chip_select = 0,
+		.controller_data = (void *)MXS_GPIO_NR(3, 8),
+		.mode = SPI_MODE_0,
+	},
+	{
+		.modalias = "spidev",
+		.max_speed_hz = 20000000,
+		.bus_num = 1,
 		.chip_select = 1,
-		.controller_data = (void *)SPI_GPIO_NO_CHIPSELECT,
+		.controller_data = (void *)MXS_GPIO_NR(3, 9),
 		.mode = SPI_MODE_0,
 	},
 };
 
+static struct spi_gpio_platform_data tx28_spi_gpio_data = {
+	.sck = MXS_GPIO_NR(2, 24),
+	.mosi = MXS_GPIO_NR(2, 25),
+	.miso = MXS_GPIO_NR(2, 26),
+	.num_chipselect = 2,
+};
+
 #define TSC2007_PEN_GPIO		MXS_GPIO_NR(3, 20)
 
 static int tx28_stk5_tsc2007_init(void)
@@ -334,6 +356,8 @@ static void __init tx28_stk5v3_init(void)
 	/* spi via ssp will be added when available */
 	spi_register_board_info(tx28_spi_board_info,
 			ARRAY_SIZE(tx28_spi_board_info));
+	mxs_add_platform_device("spi_gpio", 1, NULL, 0,
+			&tx28_spi_gpio_data, sizeof(tx28_spi_gpio_data));
 	mxs_add_platform_device("leds-gpio", 0, NULL, 0,
 			&tx28_stk5v3_led_data, sizeof(tx28_stk5v3_led_data));
 	mx28_add_mxs_i2c(0);
@@ -356,6 +380,8 @@ static void __init tx28_stk5v4_init(void)
 	/* spi via ssp will be added later */
 	spi_register_board_info(tx28_spi_board_info,
 			ARRAY_SIZE(tx28_spi_board_info));
+	mxs_add_platform_device("spi_gpio", 1, NULL, 0,
+			&tx28_spi_gpio_data, sizeof(tx28_spi_gpio_data));
 	mxs_add_platform_device("leds-gpio", 0, NULL, 0,
 			&tx28_stk5v3_led_data, sizeof(tx28_stk5v3_led_data));
 	mx28_add_mxs_i2c(0);
-- 
1.5.6.5
