From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Mon, 23 Nov 2009 19:16:36 +0100
Subject: [PATCH 2/3] mx31moboard: SPI corrections
In-Reply-To: <1259000197-18627-2-git-send-email-valentin.longchamp@epfl.ch>
References: <1259000197-18627-1-git-send-email-valentin.longchamp@epfl.ch>
	<1259000197-18627-2-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1259000197-18627-3-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds requirement for ADC on mc13783 and moves the spidev declaration
to marxbot file.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard-marxbot.c |   13 +++++++++++++
 arch/arm/mach-mx3/mx31moboard.c         |    7 +------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard-marxbot.c b/arch/arm/mach-mx3/mx31moboard-marxbot.c
index 7f3c71c..738c118 100644
--- a/arch/arm/mach-mx3/mx31moboard-marxbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-marxbot.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
+#include <linux/spi/spi.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
@@ -126,6 +127,15 @@ static void dspics_resets_init(void)
 	}
 }
 
+static struct spi_board_info marxbot_spi_board_info[] __initdata = {
+	{
+		.modalias = "spidev",
+		.max_speed_hz = 300000,
+		.bus_num = 1,
+		.chip_select = 1, /* according spi1_cs[] ! */
+	},
+};
+
 #define TURRETCAM_POWER	IOMUX_TO_GPIO(MX31_PIN_GPIO3_1)
 #define BASECAM_POWER	IOMUX_TO_GPIO(MX31_PIN_CSI_D5)
 #define TURRETCAM_RST_B	IOMUX_TO_GPIO(MX31_PIN_GPIO3_0)
@@ -217,6 +227,9 @@ void __init mx31moboard_marxbot_init(void)
 
 	mxc_register_device(&mx31_sdhc_device1, &sdhc2_pdata);
 
+	spi_register_board_info(marxbot_spi_board_info,
+		ARRAY_SIZE(marxbot_spi_board_info));
+
 	marxbot_cam_init();
 	platform_add_devices(marxbot_cameras, ARRAY_SIZE(marxbot_cameras));
 
diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
index 8b786ca..db77608 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mx31moboard.c
@@ -213,6 +213,7 @@ static struct mc13783_platform_data moboard_pmic = {
 	.regulators = moboard_regulators,
 	.num_regulators = ARRAY_SIZE(moboard_regulators),
 	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC,
+		MC13783_USE_ADC,
 };
 
 static struct spi_board_info moboard_spi_board_info[] __initdata = {
@@ -225,12 +226,6 @@ static struct spi_board_info moboard_spi_board_info[] __initdata = {
 		.platform_data = &moboard_pmic,
 		.mode = SPI_CS_HIGH,
 	},
-	{
-		.modalias = "spidev",
-		.max_speed_hz = 300000,
-		.bus_num = 1,
-		.chip_select = 1, /* according spi1_cs[] ! */
-	},
 };
 
 static int moboard_spi2_cs[] = {
-- 
1.6.3.3
