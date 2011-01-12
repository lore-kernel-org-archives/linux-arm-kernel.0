From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Wed, 12 Jan 2011 11:26:20 +0100
Subject: [PATCH] ux500: platform data for LP5521 leds driver
Message-ID: <1294827980-30023-1-git-send-email-philippe.langlais@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philippe Langlais <philippe.langlais@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c |   70 ++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 472f9a2..ce3257d 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/mfd/ab8500.h>
 #include <linux/mfd/tc3589x.h>
+#include <linux/leds-lp5521.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 
@@ -128,6 +129,58 @@ static struct tc3589x_platform_data mop500_tc35892_data = {
 	.irq_base	= MOP500_EGPIO_IRQ_BASE,
 };
 
+#if defined(CONFIG_LEDS_LP5521) || defined(CONFIG_LEDS_LP5521_MODULE)
+static struct lp5521_led_config lp5521_pri_led[] = {
+       [0] = {
+               .chan_nr = 0,
+               .led_current = 0x2f,
+               .max_current = 0x5f,
+       },
+       [1] = {
+               .chan_nr = 1,
+               .led_current = 0x2f,
+               .max_current = 0x5f,
+       },
+       [2] = {
+               .chan_nr = 2,
+               .led_current = 0x2f,
+               .max_current = 0x5f,
+       },
+};
+
+static struct lp5521_platform_data __initdata lp5521_pri_data = {
+       .label = "lp5521_pri",
+       .led_config     = &lp5521_pri_led[0],
+       .num_channels   = 3,
+       .clock_mode     = LP5521_CLOCK_EXT,
+};
+
+static struct lp5521_led_config lp5521_sec_led[] = {
+       [0] = {
+               .chan_nr = 0,
+               .led_current = 0x2f,
+               .max_current = 0x5f,
+       },
+       [1] = {
+               .chan_nr = 1,
+               .led_current = 0x2f,
+               .max_current = 0x5f,
+       },
+       [2] = {
+               .chan_nr = 2,
+               .led_current = 0x2f,
+               .max_current = 0x5f,
+       },
+};
+
+static struct lp5521_platform_data __initdata lp5521_sec_data = {
+       .label = "lp5521_sec",
+       .led_config     = &lp5521_sec_led[0],
+       .num_channels   = 3,
+       .clock_mode     = LP5521_CLOCK_EXT,
+};
+#endif /* CONFIG_LEDS_LP5521 */
+
 static struct i2c_board_info mop500_i2c0_devices[] = {
 	{
 		I2C_BOARD_INFO("tc3589x", 0x42),
@@ -136,6 +189,21 @@ static struct i2c_board_info mop500_i2c0_devices[] = {
 	},
 };
 
+static struct i2c_board_info __initdata mop500_i2c2_devices[] = {
+#if defined(CONFIG_LEDS_LP5521) || defined(CONFIG_LEDS_LP5521_MODULE)
+	{
+		/* lp5521 LED driver, 1st device */
+		I2C_BOARD_INFO("lp5521", 0x33),
+		.platform_data = &lp5521_pri_data,
+	},
+	{
+		/* lp5521 LED driver, 2st device */
+		I2C_BOARD_INFO("lp5521", 0x34),
+		.platform_data = &lp5521_sec_data,
+	},
+#endif
+};
+
 #define U8500_I2C_CONTROLLER(id, _slsu, _tft, _rft, clk, _sm) \
 static struct nmk_i2c_controller u8500_i2c##id##_data = { \
 	/*				\
@@ -382,6 +450,8 @@ static void __init u8500_init_machine(void)
 
 	i2c_register_board_info(0, mop500_i2c0_devices,
 				ARRAY_SIZE(mop500_i2c0_devices));
+	i2c_register_board_info(2, mop500_i2c2_devices,
+				ARRAY_SIZE(mop500_i2c2_devices));
 
 	platform_add_devices(u8500_platform_devices,
 			     ARRAY_SIZE(u8500_platform_devices));
-- 
1.7.3.1
