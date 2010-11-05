From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:26:04 +0100
Subject: [PATCH 2/3] ARM i.MX27 eukrea: Fix compilation
In-Reply-To: <1288949165-13286-1-git-send-email-s.hauer@pengutronix.de>
References: <1288949165-13286-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288949165-13286-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently compilation breaks for the eukrea mbimx27 baseboard
when CONFIG_SPI_IMX is selected and CONFIG_TOUCHSCREEN_ADS7846
is not selected. Fix this by removing the ifdefs altogether.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Eric Benard <eric@eukrea.com>
---
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index 026263c..7e1e9dc 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -250,9 +250,6 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-#if defined(CONFIG_TOUCHSCREEN_ADS7846) \
-	|| defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
-
 #define ADS7846_PENDOWN (GPIO_PORTD | 25)
 
 static void ads7846_dev_init(void)
@@ -273,9 +270,7 @@ static struct ads7846_platform_data ads7846_config __initdata = {
 	.get_pendown_state	= ads7846_get_pendown_state,
 	.keep_vref_on		= 1,
 };
-#endif
 
-#if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
 static struct spi_board_info eukrea_mbimx27_spi_board_info[] __initdata = {
 	[0] = {
 		.modalias	= "ads7846",
@@ -294,7 +289,6 @@ static const struct spi_imx_master eukrea_mbimx27_spi0_data __initconst = {
 	.chipselect	= eukrea_mbimx27_spi_cs,
 	.num_chipselect = ARRAY_SIZE(eukrea_mbimx27_spi_cs),
 };
-#endif
 
 static struct i2c_board_info eukrea_mbimx27_i2c_devices[] = {
 	{
-- 
1.7.2.3
