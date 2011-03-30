From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 30 Mar 2011 14:33:13 +0200
Subject: [PATCH] mach-ux500: fix i2c0 device setup regression
Message-ID: <1301488393-13924-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Adding two sets of I2C devices to the same bus doesn't quite work,
atleast not anymore. Stash one array and determine how much of it
shall be added instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index dc8746d..cc64bf4 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -178,16 +178,15 @@ static struct i2c_board_info __initdata mop500_i2c0_devices[] = {
 		.irq		= NOMADIK_GPIO_TO_IRQ(217),
 		.platform_data  = &mop500_tc35892_data,
 	},
-};
-
-/* I2C0 devices only available prior to HREFv60 */
-static struct i2c_board_info __initdata mop500_i2c0_old_devices[] = {
+	/* I2C0 devices only available prior to HREFv60 */
 	{
 		I2C_BOARD_INFO("tps61052", 0x33),
 		.platform_data  = &mop500_tps61052_data,
 	},
 };
 
+#define NUM_PRE_V60_I2C0_DEVICES 1
+
 static struct i2c_board_info __initdata mop500_i2c2_devices[] = {
 	{
 		/* lp5521 LED driver, 1st device */
@@ -425,6 +424,8 @@ static void __init mop500_uart_init(void)
 
 static void __init mop500_init_machine(void)
 {
+	int i2c0_devs;
+
 	/*
 	 * The HREFv60 board removed a GPIO expander and routed
 	 * all these GPIO pins to the internal GPIO controller
@@ -448,11 +449,11 @@ static void __init mop500_init_machine(void)
 
 	platform_device_register(&ab8500_device);
 
-	i2c_register_board_info(0, mop500_i2c0_devices,
-				ARRAY_SIZE(mop500_i2c0_devices));
-	if (!machine_is_hrefv60())
-		i2c_register_board_info(0, mop500_i2c0_old_devices,
-					ARRAY_SIZE(mop500_i2c0_old_devices));
+	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
+	if (machine_is_hrefv60())
+		i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
+
+	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
 	i2c_register_board_info(2, mop500_i2c2_devices,
 				ARRAY_SIZE(mop500_i2c2_devices));
 }
-- 
1.7.3.2
