From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Sep 2010 17:27:20 -0700
Subject: [PATCH 7/7] omap4: board-omap4panda: adding leds status1 and status2
In-Reply-To: <20100925002608.24551.67183.stgit@baageli.muru.com>
References: <20100925002608.24551.67183.stgit@baageli.muru.com>
Message-ID: <20100925002720.24551.11276.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

At Pandaboard we have 2 status leds, so adding them with similar usage as
we have for Beagleboard (heartbeat and mmc0). The patch basically adds the
platform data required by leds-gpio driver.

Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c03d1d5..22a8fd3 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl.h>
@@ -40,6 +41,36 @@
 #include "hsmmc.h"
 
 
+static struct gpio_led gpio_leds[] = {
+	{
+		.name			= "pandaboard::status1",
+		.default_trigger	= "heartbeat",
+		.gpio			= 7,
+	},
+	{
+		.name			= "pandaboard::status2",
+		.default_trigger	= "mmc0",
+		.gpio			= 8,
+	},
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_led_info,
+	},
+};
+
+static struct platform_device *panda_devices[] __initdata = {
+	&leds_gpio,
+};
+
 static void __init omap4_panda_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
@@ -277,6 +308,7 @@ static void __init omap4_panda_init(void)
 	int status;
 
 	omap4_panda_i2c_init();
+	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 Panda uses internal transceiver so register nop transceiver */
