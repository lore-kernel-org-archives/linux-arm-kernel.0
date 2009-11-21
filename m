From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 21 Nov 2009 18:40:40 +0100
Subject: [PATCH] ARM: MX3: lilly1131: move MC13783 device registration
Message-ID: <1258825240-2992-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the MC13783 device in the module code.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lilly-db.c |   19 -------------------
 arch/arm/mach-mx3/mx31lilly.c    |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lilly-db.c b/arch/arm/mach-mx3/mx31lilly-db.c
index bb1e44f..7aebd74 100644
--- a/arch/arm/mach-mx3/mx31lilly-db.c
+++ b/arch/arm/mach-mx3/mx31lilly-db.c
@@ -29,8 +29,6 @@
 #include <linux/init.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
-#include <linux/spi/spi.h>
-#include <linux/mfd/mc13783.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -214,22 +212,6 @@ static void __init mx31lilly_init_fb(void)
 	gpio_direction_output(LCD_VCC_EN_GPIO, 1);
 }
 
-/* SPI */
-
-static struct mc13783_platform_data mc13783_pdata __initdata = {
-	.flags = MC13783_USE_RTC | MC13783_USE_TOUCHSCREEN,
-};
-
-static struct spi_board_info lilly_spi_devs[] __initdata = {
-	{
-		.modalias	= "mc13783",
-		.max_speed_hz	= 1000000,
-		.bus_num	= 1,
-		.chip_select	= 0,
-		.platform_data	= &mc13783_pdata,
-	},
-};
-
 void __init mx31lilly_db_init(void)
 {
 	mxc_iomux_setup_multiple_pins(lilly_db_board_pins,
@@ -240,6 +222,5 @@ void __init mx31lilly_db_init(void)
 	mxc_register_device(&mxc_uart_device2, &uart_pdata);
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
 	mx31lilly_init_fb();
-	spi_register_board_info(lilly_spi_devs, ARRAY_SIZE(lilly_spi_devs));
 }
 
diff --git a/arch/arm/mach-mx3/mx31lilly.c b/arch/arm/mach-mx3/mx31lilly.c
index 9e32a5c..17854b0 100644
--- a/arch/arm/mach-mx3/mx31lilly.c
+++ b/arch/arm/mach-mx3/mx31lilly.c
@@ -35,6 +35,8 @@
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/mc13783.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -248,6 +250,8 @@ static struct platform_device *devices[] __initdata = {
 	&physmap_flash_device,
 };
 
+/* SPI */
+
 static int spi_internal_chipselect[] = {
 	MXC_SPI_CS(0),
 	MXC_SPI_CS(1),
@@ -264,6 +268,18 @@ static struct spi_imx_master spi1_pdata = {
 	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
 };
 
+static struct mc13783_platform_data mc13783_pdata __initdata = {
+	.flags = MC13783_USE_RTC | MC13783_USE_TOUCHSCREEN,
+};
+
+static struct spi_board_info mc13783_dev __initdata = {
+	.modalias	= "mc13783",
+	.max_speed_hz	= 1000000,
+	.bus_num	= 1,
+	.chip_select	= 0,
+	.platform_data	= &mc13783_pdata,
+};
+
 static int mx31lilly_baseboard;
 core_param(mx31lilly_baseboard, mx31lilly_baseboard, int, 0444);
 
@@ -301,6 +317,7 @@ static void __init mx31lilly_board_init(void)
 
 	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
 	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
+	spi_register_board_info(&mc13783_dev, 1);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
-- 
1.6.5.2
