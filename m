From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun,  3 Sep 2017 10:43:47 -0700
Subject: [PATCH v2 4/4] ARM: ep93xx: Add lm70 HWMON sensor to TS-72xx boards
In-Reply-To: <20170903174347.6148-1-f.fainelli@gmail.com>
References: <20170903174347.6148-1-f.fainelli@gmail.com>
Message-ID: <20170903174347.6148-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: H Hartley Sweeten <hsweeten@visionengravers.com>

Register the TI TMP122 (lm70) temperature sensor driver for the TS-72xx
boards.

Originaly from Florian Fainelli. Updated to the new spi-ep93xx chip select
method.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-ep93xx/ts72xx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 55ca3b375952..4b8fefbf62dd 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -18,7 +18,10 @@
 #include <linux/io.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/spi/spi.h>
+#include <linux/platform_data/spi-ep93xx.h>
 
+#include <mach/gpio-ep93xx.h>
 #include <mach/hardware.h>
 
 #include <asm/mach-types.h>
@@ -230,6 +233,27 @@ static struct platform_device ts73xx_fpga_device = {
 
 #endif
 
+/*************************************************************************
+ * SPI Bus
+ *************************************************************************/
+static struct spi_board_info ts72xx_spi_devices[] __initdata = {
+	{
+		.modalias		= "tmp122",
+		.max_speed_hz		= 2 * 1000 * 1000,
+		.bus_num		= 0,
+		.chip_select		= 0,
+	},
+};
+
+static int ts72xx_spi_chipselects[] __initdata = {
+	EP93XX_GPIO_LINE_F(2),		/* DIO_17 */
+};
+
+static struct ep93xx_spi_info ts72xx_spi_info __initdata = {
+	.chipselect	= ts72xx_spi_chipselects,
+	.num_chipselect	= ARRAY_SIZE(ts72xx_spi_chipselects),
+};
+
 static void __init ts72xx_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -242,6 +266,8 @@ static void __init ts72xx_init_machine(void)
 	if (board_is_ts7300())
 		platform_device_register(&ts73xx_fpga_device);
 #endif
+	ep93xx_register_spi(&ts72xx_spi_info, ts72xx_spi_devices,
+			    ARRAY_SIZE(ts72xx_spi_devices));
 }
 
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
-- 
2.11.0
