From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Tue, 16 Jun 2015 09:52:47 -0700
Subject: [PATCH 2/2] ARM: ep93xx: vision_ep9307: add audio support
In-Reply-To: <1434473567-5258-1-git-send-email-hsweeten@visionengravers.com>
References: <1434473567-5258-1-git-send-email-hsweeten@visionengravers.com>
Message-ID: <1434473567-5258-3-git-send-email-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2S audio support to the vision_ep9307 system.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/mach-ep93xx/vision_ep9307.c | 58 ++++++++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
index aa87dfa..ff22a6a 100644
--- a/arch/arm/mach-ep93xx/vision_ep9307.c
+++ b/arch/arm/mach-ep93xx/vision_ep9307.c
@@ -29,6 +29,8 @@
 #include <linux/spi/mmc_spi.h>
 #include <linux/mmc/host.h>
 
+#include <sound/cs4271.h>
+
 #include <mach/hardware.h>
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
@@ -169,6 +171,35 @@ static struct i2c_board_info vision_i2c_info[] __initdata = {
 };
 
 /*************************************************************************
+ * SPI CS4271 Audio Codec
+ *************************************************************************/
+static struct cs4271_platform_data vision_cs4271_data = {
+	.gpio_nreset	= EP93XX_GPIO_LINE_H(2),
+};
+
+static int vision_cs4271_hw_setup(struct spi_device *spi)
+{
+	return gpio_request_one(EP93XX_GPIO_LINE_EGPIO6,
+				GPIOF_OUT_INIT_HIGH, spi->modalias);
+}
+
+static void vision_cs4271_hw_cleanup(struct spi_device *spi)
+{
+	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
+}
+
+static void vision_cs4271_hw_cs_control(struct spi_device *spi, int value)
+{
+	gpio_set_value(EP93XX_GPIO_LINE_EGPIO6, value);
+}
+
+static struct ep93xx_spi_chip_ops vision_cs4271_hw = {
+	.setup		= vision_cs4271_hw_setup,
+	.cleanup	= vision_cs4271_hw_cleanup,
+	.cs_control	= vision_cs4271_hw_cs_control,
+};
+
+/*************************************************************************
  * SPI Flash
  *************************************************************************/
 #define VISION_SPI_FLASH_CS	EP93XX_GPIO_LINE_EGPIO7
@@ -262,12 +293,20 @@ static struct ep93xx_spi_chip_ops vision_spi_mmc_hw = {
  *************************************************************************/
 static struct spi_board_info vision_spi_board_info[] __initdata = {
 	{
+		.modalias		= "cs4271",
+		.platform_data		= &vision_cs4271_data,
+		.controller_data	= &vision_cs4271_hw,
+		.max_speed_hz		= 6000000,
+		.bus_num		= 0,
+		.chip_select		= 0,
+		.mode			= SPI_MODE_3,
+	}, {
 		.modalias		= "sst25l",
 		.platform_data		= &vision_spi_flash_data,
 		.controller_data	= &vision_spi_flash_hw,
 		.max_speed_hz		= 20000000,
 		.bus_num		= 0,
-		.chip_select		= 0,
+		.chip_select		= 1,
 		.mode			= SPI_MODE_3,
 	}, {
 		.modalias		= "mmc_spi",
@@ -275,7 +314,7 @@ static struct spi_board_info vision_spi_board_info[] __initdata = {
 		.controller_data	= &vision_spi_mmc_hw,
 		.max_speed_hz		= 20000000,
 		.bus_num		= 0,
-		.chip_select		= 1,
+		.chip_select		= 2,
 		.mode			= SPI_MODE_3,
 	},
 };
@@ -286,6 +325,20 @@ static struct ep93xx_spi_info vision_spi_master __initdata = {
 };
 
 /*************************************************************************
+ * I2S Audio
+ *************************************************************************/
+static struct platform_device vision_audio_device = {
+	.name		= "edb93xx-audio",
+	.id		= -1,
+};
+
+static void __init vision_register_i2s(void)
+{
+	ep93xx_register_i2s();
+	platform_device_register(&vision_audio_device);
+}
+
+/*************************************************************************
  * Machine Initialization
  *************************************************************************/
 static void __init vision_init_machine(void)
@@ -310,6 +363,7 @@ static void __init vision_init_machine(void)
 				ARRAY_SIZE(vision_i2c_info));
 	ep93xx_register_spi(&vision_spi_master, vision_spi_board_info,
 				ARRAY_SIZE(vision_spi_board_info));
+	vision_register_i2s();
 }
 
 MACHINE_START(VISION_EP9307, "Vision Engraving Systems EP9307")
-- 
2.3.0
