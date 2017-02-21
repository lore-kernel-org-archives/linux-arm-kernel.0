From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Tue, 21 Feb 2017 11:15:29 -0700
Subject: [PATCH 4/4] ARM: ep93xx: Add lm70 HWMON sensor to TS-72xx boards
In-Reply-To: <20170221181529.6780-1-hsweeten@visionengravers.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
Message-ID: <20170221181529.6780-5-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the TI TMP122 (lm70) temperature sensor driver for the TS-72xx
boards.

Originaly from Florian Fainelli. Updated to the new spi-ep93xx chip select
method.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-ep93xx/ts72xx.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 9b62e5c..ec8272b 100644
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
@@ -208,14 +211,36 @@ static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
 	.phy_id		= 1,
 };
 
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
 	ts72xx_register_flash();
 	platform_device_register(&ts72xx_rtc_device);
 	platform_device_register(&ts72xx_wdt_device);
-
 	ep93xx_register_eth(&ts72xx_eth_data, 1);
+	ep93xx_register_spi(&ts72xx_spi_info, ts72xx_spi_devices,
+			    ARRAY_SIZE(ts72xx_spi_devices));
 }
 
 MACHINE_START(TS72XX, "Technologic Systems TS-72xx SBC")
-- 
2.10.0
