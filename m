From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 18 Nov 2009 14:41:42 +0100
Subject: [PATCH 5/5] ARM: MX3: add support for GPIO LEDs on litekit db
In-Reply-To: <1258551702-8631-4-git-send-email-daniel@caiaq.de>
References: <1258551702-8631-1-git-send-email-daniel@caiaq.de>
	<1258551702-8631-2-git-send-email-daniel@caiaq.de>
	<1258551702-8631-3-git-send-email-daniel@caiaq.de>
	<1258551702-8631-4-git-send-email-daniel@caiaq.de>
Message-ID: <1258551702-8631-5-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The names are chosen to match the silkscreen.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lite-db.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index 1ab92f6..b475634 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -30,6 +30,8 @@
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/mfd/mc13783.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -170,6 +172,36 @@ static struct spi_board_info litekit_spi_devs[] __initdata = {
 	},
 };
 
+/* GPIO LEDs */
+
+static struct gpio_led litekit_leds[] = {
+	{
+		.name		= "GPIO0",
+		.gpio		= IOMUX_TO_GPIO(MX31_PIN_COMPARE),
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	},
+	{
+		.name		= "GPIO1",
+		.gpio		= IOMUX_TO_GPIO(MX31_PIN_CAPTURE),
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_OFF,
+	}
+};
+
+static struct gpio_led_platform_data litekit_led_platform_data = {
+	.leds		= litekit_leds,
+	.num_leds	= ARRAY_SIZE(litekit_leds),
+};
+
+static struct platform_device litekit_led_device = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &litekit_led_platform_data,
+	},
+};
+
 void __init mx31lite_db_init(void)
 {
 	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
@@ -180,5 +212,6 @@ void __init mx31lite_db_init(void)
 	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
 	spi_register_board_info(litekit_spi_devs,
 				ARRAY_SIZE(litekit_spi_devs));
+	platform_device_register(&litekit_led_device);
 }
 
-- 
1.6.5.2
