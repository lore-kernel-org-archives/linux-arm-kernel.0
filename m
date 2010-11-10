From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 10 Nov 2010 07:00:02 -0800 (PST)
Subject: [PATCH] mx51_babbage: Add SPI flash support
Message-ID: <762576.24799.qm@web51006.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX51 Babbage has an AT45DB321 SPI Flash connected to eCSPI1.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/Kconfig              |    3 +-
 arch/arm/mach-mx5/board-mx51_babbage.c |   35 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 7bff99a..ebab3f3 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -12,9 +12,10 @@ comment "MX5 platforms:"
 
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
+	select IMX_HAVE_PLATFORM_ESDHC
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
-	select IMX_HAVE_PLATFORM_ESDHC
+	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
 	  Include support for MX51 Babbage platform, also known as MX51EVK in
 	  u-boot. This includes specific configurations for the board and its
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index e6be941..66b07d8 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -20,6 +20,8 @@
 #include <linux/fec.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 
 #include <mach/common.h>
 #include <mach/hardware.h>
@@ -41,6 +43,8 @@
 #define BABBAGE_PHY_RESET	(1*32 + 5)	/* GPIO_2_5 */
 #define BABBAGE_FEC_PHY_RESET	(1*32 + 14)	/* GPIO_2_14 */
 #define BABBAGE_POWER_KEY	(1*32 + 21)	/* GPIO_2_21 */
+#define BABBAGE_ECSPI1_CS0	(3*32 + 24)	/* GPIO_4_24 */
+#define BABBAGE_ECSPI1_CS1	(3*32 + 25)	/* GPIO_4_25 */
 
 /* USB_CTRL_1 */
 #define MX51_USB_CTRL_1_OFFSET			0x10
@@ -147,6 +151,13 @@ static iomux_v3_cfg_t mx51babbage_pads[] = {
 	MX51_PAD_SD2_DATA1__SD2_DATA1,
 	MX51_PAD_SD2_DATA2__SD2_DATA2,
 	MX51_PAD_SD2_DATA3__SD2_DATA3,
+
+	/* eCSPI1 */
+	MX51_PAD_CSPI1_MISO__ECSPI1_MISO,
+	MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI,
+	MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
+	MX51_PAD_CSPI1_SS0__GPIO_4_24,
+	MX51_PAD_CSPI1_SS1__GPIO_4_25,
 };
 
 /* Serial ports */
@@ -310,6 +321,27 @@ static int __init babbage_otg_mode(char *options)
 }
 __setup("otg_mode=", babbage_otg_mode);
 
+static struct spi_board_info mx51_babbage_spi_board_info[] __initdata = {
+	{
+		.modalias = "mtd_dataflash",
+		.max_speed_hz = 25000000,
+		.bus_num = 0,
+		.chip_select = 1,
+		.mode = SPI_MODE_0,
+		.platform_data = NULL,
+	},
+};
+
+static int mx51_babbage_spi_cs[] = {
+	BABBAGE_ECSPI1_CS0,
+	BABBAGE_ECSPI1_CS1,
+};
+
+static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
+	.chipselect     = mx51_babbage_spi_cs,
+	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
+};
+
 /*
  * Board specific initialization.
  */
@@ -351,6 +383,9 @@ static void __init mxc_board_init(void)
 
 	imx51_add_esdhc(0, NULL);
 	imx51_add_esdhc(1, NULL);
+	spi_register_board_info(mx51_babbage_spi_board_info,
+		ARRAY_SIZE(mx51_babbage_spi_board_info));
+	imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
 }
 
 static void __init mx51_babbage_timer_init(void)
-- 
1.6.0.4



      
