From: daniel@caiaq.de (Daniel Mack)
Date: Sat, 17 Oct 2009 15:12:59 +0200
Subject: [PATCH 3/4] ARM: MX3: add support for mc13783 on lilly-db
In-Reply-To: <1255785180-18501-3-git-send-email-daniel@caiaq.de>
References: <1255785180-18501-1-git-send-email-daniel@caiaq.de>
	<1255785180-18501-2-git-send-email-daniel@caiaq.de>
	<1255785180-18501-3-git-send-email-daniel@caiaq.de>
Message-ID: <1255785180-18501-4-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip is actually located on the module, not on the base board. But
other base boards might add more SPI devices, so the spi_board_info
struct must be separated from the module code.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mx31lilly-db.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lilly-db.c b/arch/arm/mach-mx3/mx31lilly-db.c
index 3b3a78f..60f2d15 100644
--- a/arch/arm/mach-mx3/mx31lilly-db.c
+++ b/arch/arm/mach-mx3/mx31lilly-db.c
@@ -29,6 +29,8 @@
 #include <linux/init.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/mc13783.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -202,6 +204,22 @@ static void __init mx31lilly_init_fb(void)
 	gpio_direction_output(LCD_VCC_EN_GPIO, 1);
 }
 
+/* SPI */
+
+static struct mc13783_platform_data mc13783_pdata __initdata = {
+	.flags = MC13783_USE_RTC | MC13783_USE_TOUCHSCREEN,
+};
+
+static struct spi_board_info lilly_spi_devs[] __initdata = {
+	{
+		.modalias	= "mc13783",
+		.max_speed_hz	= 1000000,
+		.bus_num	= 1,
+		.chip_select	= 0,
+		.platform_data	= &mc13783_pdata,
+	},
+};
+
 void __init mx31lilly_db_init(void)
 {
 	mxc_iomux_setup_multiple_pins(lilly_db_board_pins,
@@ -212,5 +230,6 @@ void __init mx31lilly_db_init(void)
 	mxc_register_device(&mxc_uart_device2, &uart_pdata);
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
 	mx31lilly_init_fb();
+	spi_register_board_info(lilly_spi_devs, ARRAY_SIZE(lilly_spi_devs));
 }
 
-- 
1.6.3.3
