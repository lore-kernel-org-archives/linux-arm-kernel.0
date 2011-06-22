From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 22 Jun 2011 13:34:59 +0200
Subject: [PATCH 1/6] mach-ux500: add basic support for snowball board
Message-ID: <1308742499-23196-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Marklund <robert.marklund@stericsson.com>

Based on work from Mathieu J. Poirier <mathieu.poirier@linaro.org>
For more information on snowball please visit
http://www.igloocommunity.org

Signed-off-by: Robert Marklund <robert.marklund@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c |  154 +++++++++++++++++++++++++++++++++--
 1 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index c64d6aa..e3bbb55 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -26,8 +26,10 @@
 #include <linux/mfd/ab8500/gpio.h>
 #include <linux/leds-lp5521.h>
 #include <linux/input.h>
+#include <linux/smsc911x.h>
 #include <linux/gpio_keys.h>
 
+#include <linux/leds.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -44,6 +46,26 @@
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
 
+static struct gpio_led snowball_led_array[] = {
+	{
+		.name = "user_led",
+		.default_trigger = "none",
+		.gpio = 142,
+	},
+};
+
+static struct gpio_led_platform_data snowball_led_data = {
+	.leds = snowball_led_array,
+	.num_leds = ARRAY_SIZE(snowball_led_array),
+};
+
+static struct platform_device snowball_led_dev = {
+	.name = "leds-gpio",
+	.dev = {
+		.platform_data = &snowball_led_data,
+	},
+};
+
 static struct ab8500_gpio_platform_data ab8500_gpio_pdata = {
 	.gpio_base		= MOP500_AB8500_GPIO(0),
 	.irq_base		= MOP500_AB8500_VIR_GPIO_IRQ_BASE,
@@ -66,6 +88,97 @@ static struct ab8500_gpio_platform_data ab8500_gpio_pdata = {
 					0x7A, 0x00, 0x00},
 };
 
+static struct gpio_keys_button snowball_key_array[] = {
+	{
+		.gpio           = 32,
+		.type           = EV_KEY,
+		.code           = KEY_1,
+		.desc           = "userpb",
+		.active_low     = 1,
+		.debounce_interval = 50,
+		.wakeup         = 1,
+	},
+	{
+		.gpio           = 151,
+		.type           = EV_KEY,
+		.code           = KEY_2,
+		.desc           = "extkb1",
+		.active_low     = 1,
+		.debounce_interval = 50,
+		.wakeup         = 1,
+	},
+	{
+		.gpio           = 152,
+		.type           = EV_KEY,
+		.code           = KEY_3,
+		.desc           = "extkb2",
+		.active_low     = 1,
+		.debounce_interval = 50,
+		.wakeup         = 1,
+	},
+	{
+		.gpio           = 161,
+		.type           = EV_KEY,
+		.code           = KEY_4,
+		.desc           = "extkb3",
+		.active_low     = 1,
+		.debounce_interval = 50,
+		.wakeup         = 1,
+	},
+	{
+		.gpio           = 162,
+		.type           = EV_KEY,
+		.code           = KEY_5,
+		.desc           = "extkb4",
+		.active_low     = 1,
+		.debounce_interval = 50,
+		.wakeup         = 1,
+	},
+};
+
+static struct gpio_keys_platform_data snowball_key_data = {
+	.buttons        = snowball_key_array,
+	.nbuttons       = ARRAY_SIZE(snowball_key_array),
+};
+
+static struct platform_device snowball_key_dev = {
+	.name           = "gpio-keys",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &snowball_key_data,
+	}
+};
+
+static struct smsc911x_platform_config snowball_sbnet_cfg = {
+	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
+	.irq_type = SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags = SMSC911X_USE_16BIT | SMSC911X_FORCE_INTERNAL_PHY,
+	.shift = 1,
+};
+
+static struct resource sbnet_res[] = {
+	{
+		.name = "smsc911x-memory",
+		.start = (0x5000 << 16),
+		.end  =  (0x5000 << 16) + 0xffff,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = NOMADIK_GPIO_TO_IRQ(140),
+		.end = NOMADIK_GPIO_TO_IRQ(140),
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
+	},
+};
+
+static struct platform_device snowball_sbnet_dev = {
+	.name           = "smsc911x",
+	.num_resources  = ARRAY_SIZE(sbnet_res),
+	.resource       = sbnet_res,
+	.dev            = {
+		.platform_data = &snowball_sbnet_cfg,
+	},
+};
+
 static struct ab8500_platform_data ab8500_platdata = {
 	.irq_base	= MOP500_AB8500_IRQ_BASE,
 	.regulator_reg_init = ab8500_regulator_reg_init,
@@ -292,8 +405,9 @@ static void mop500_prox_deactivate(struct device *dev)
 }
 
 /* add any platform devices here - TODO */
-static struct platform_device *platform_devs[] __initdata = {
+static struct platform_device *mop500_platform_devs[] __initdata = {
 	&mop500_gpio_keys_device,
+	&ab8500_device,
 };
 
 #ifdef CONFIG_STE_DMA40
@@ -424,6 +538,13 @@ static void __init mop500_uart_init(void)
 	db8500_add_uart2(&uart2_plat);
 }
 
+static struct platform_device *snowball_platform_devs[] __initdata = {
+	&snowball_led_dev,
+	&snowball_key_dev,
+	&snowball_sbnet_dev,
+	&ab8500_device,
+};
+
 static void __init mop500_init_machine(void)
 {
 	int i2c0_devs;
@@ -433,24 +554,30 @@ static void __init mop500_init_machine(void)
 	 * all these GPIO pins to the internal GPIO controller
 	 * instead.
 	 */
-	if (machine_is_hrefv60())
-		mop500_gpio_keys[0].gpio = HREFV60_PROX_SENSE_GPIO;
-	else
-		mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
+	if (!machine_is_snowball()) {
+		if (machine_is_hrefv60())
+			mop500_gpio_keys[0].gpio = HREFV60_PROX_SENSE_GPIO;
+		else
+			mop500_gpio_keys[0].gpio = GPIO_PROX_SENSOR;
+	}
 
 	u8500_init_devices();
 
 	mop500_pins_init();
 
-	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
+	if (machine_is_snowball())
+		platform_add_devices(snowball_platform_devs,
+					ARRAY_SIZE(snowball_platform_devs));
+	else
+		platform_add_devices(mop500_platform_devs,
+					ARRAY_SIZE(mop500_platform_devs));
 
 	mop500_i2c_init();
-	mop500_sdi_init();
+	if (!machine_is_snowball())
+		mop500_sdi_init();
 	mop500_spi_init();
 	mop500_uart_init();
 
-	platform_device_register(&ab8500_device);
-
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
 	if (machine_is_hrefv60())
 		i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
@@ -480,3 +607,12 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.timer		= &ux500_timer,
 	.init_machine	= mop500_init_machine,
 MACHINE_END
+
+MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
+	.boot_params	= 0x100,
+	.map_io		= u8500_map_io,
+	.init_irq	= ux500_init_irq,
+	/* we re-use nomadik timer here */
+	.timer		= &ux500_timer,
+	.init_machine	= mop500_init_machine,
+MACHINE_END
-- 
1.7.3.2
