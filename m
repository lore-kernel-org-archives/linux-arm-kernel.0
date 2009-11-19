From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 19 Nov 2009 12:02:10 +0100
Subject: [PATCH 5/6] ARM: MX3: add support for GPIO LEDs on litekit db
In-Reply-To: <1258628531-15783-4-git-send-email-daniel@caiaq.de>
References: <1258628531-15783-1-git-send-email-daniel@caiaq.de>
	<1258628531-15783-2-git-send-email-daniel@caiaq.de>
	<1258628531-15783-3-git-send-email-daniel@caiaq.de>
	<1258628531-15783-4-git-send-email-daniel@caiaq.de>
Message-ID: <1258628531-15783-5-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The names are chosen to match the silkscreen.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 arch/arm/mach-mx3/mx31lite-db.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31lite-db.c b/arch/arm/mach-mx3/mx31lite-db.c
index f60cf08..694611d 100644
--- a/arch/arm/mach-mx3/mx31lite-db.c
+++ b/arch/arm/mach-mx3/mx31lite-db.c
@@ -29,6 +29,8 @@
 #include <linux/init.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -153,6 +155,36 @@ static struct spi_imx_master spi0_pdata = {
 	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
 };
 
+/* GPIO LEDs */
+
+static struct gpio_led litekit_leds[] = {
+	{
+		.name           = "GPIO0",
+		.gpio           = IOMUX_TO_GPIO(MX31_PIN_COMPARE),
+		.active_low     = 1,
+		.default_state  = LEDS_GPIO_DEFSTATE_OFF,
+	},
+	{
+		.name           = "GPIO1",
+		.gpio           = IOMUX_TO_GPIO(MX31_PIN_CAPTURE),
+		.active_low     = 1,
+		.default_state  = LEDS_GPIO_DEFSTATE_OFF,
+	}
+};
+
+static struct gpio_led_platform_data litekit_led_platform_data = {
+	.leds           = litekit_leds,
+	.num_leds       = ARRAY_SIZE(litekit_leds),
+};
+
+static struct platform_device litekit_led_device = {
+	.name   = "leds-gpio",
+	.id     = -1,
+	.dev    = {
+		.platform_data = &litekit_led_platform_data,
+	},
+};
+
 void __init mx31lite_db_init(void)
 {
 	mxc_iomux_setup_multiple_pins(litekit_db_board_pins,
@@ -161,5 +193,6 @@ void __init mx31lite_db_init(void)
 	mxc_register_device(&mxc_uart_device0, &uart_pdata);
 	mxc_register_device(&mxcsdhc_device0, &mmc_pdata);
 	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
+	platform_device_register(&litekit_led_device);
 }
 
-- 
1.6.5.2
