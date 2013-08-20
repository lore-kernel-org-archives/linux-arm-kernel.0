From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Aug 2013 15:20:32 +0200
Subject: [PATCH] ARM: ux500: fix up the I2C devices
Message-ID: <1377004832-30278-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2C device registration on the different ux500 board was
buggy due to a switch to dynamically assigned I2C host
addresses. This I2C host is still there, but we have to add
the devices dynamically instead of using board data.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4e7ab3a..ad0806e 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -324,21 +324,19 @@ static struct lp55xx_platform_data __initdata lp5521_sec_data = {
        .clock_mode     = LP55XX_CLOCK_EXT,
 };
 
+/* I2C0 devices only available on the first HREF/MOP500 */
 static struct i2c_board_info __initdata mop500_i2c0_devices[] = {
 	{
 		I2C_BOARD_INFO("tc3589x", 0x42),
 		.irq		= NOMADIK_GPIO_TO_IRQ(217),
 		.platform_data  = &mop500_tc35892_data,
 	},
-	/* I2C0 devices only available prior to HREFv60 */
 	{
 		I2C_BOARD_INFO("tps61052", 0x33),
 		.platform_data  = &mop500_tps61052_data,
 	},
 };
 
-#define NUM_PRE_V60_I2C0_DEVICES 1
-
 static struct i2c_board_info __initdata mop500_i2c2_devices[] = {
 	{
 		/* lp5521 LED driver, 1st device */
@@ -356,6 +354,17 @@ static struct i2c_board_info __initdata mop500_i2c2_devices[] = {
 	},
 };
 
+static int __init mop500_i2c_board_init(void)
+{
+	if (machine_is_u8500())
+		mop500_uib_i2c_add(0, mop500_i2c0_devices,
+				   ARRAY_SIZE(mop500_i2c0_devices));
+	mop500_uib_i2c_add(2, mop500_i2c2_devices,
+			   ARRAY_SIZE(mop500_i2c2_devices));
+	return 0;
+}
+device_initcall(mop500_i2c_board_init);
+
 static void __init mop500_i2c_init(struct device *parent)
 {
 	db8500_add_i2c0(parent, NULL);
@@ -564,7 +573,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
 static void __init mop500_init_machine(void)
 {
 	struct device *parent = NULL;
-	int i2c0_devs;
 	int i;
 
 	platform_device_register(&db8500_prcmu_device);
@@ -587,19 +595,13 @@ static void __init mop500_init_machine(void)
 	mop500_spi_init(parent);
 	mop500_audio_init(parent);
 	mop500_uart_init(parent);
-
 	u8500_cryp1_hash1_init(parent);
 
-	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
-
-	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
-	i2c_register_board_info(2, mop500_i2c2_devices,
-				ARRAY_SIZE(mop500_i2c2_devices));
-
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
 }
 
+
 static void __init snowball_init_machine(void)
 {
 	struct device *parent = NULL;
@@ -634,7 +636,6 @@ static void __init snowball_init_machine(void)
 static void __init hrefv60_init_machine(void)
 {
 	struct device *parent = NULL;
-	int i2c0_devs;
 	int i;
 
 	platform_device_register(&db8500_prcmu_device);
@@ -663,14 +664,6 @@ static void __init hrefv60_init_machine(void)
 	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
-	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
-
-	i2c0_devs -= NUM_PRE_V60_I2C0_DEVICES;
-
-	i2c_register_board_info(0, mop500_i2c0_devices, i2c0_devs);
-	i2c_register_board_info(2, mop500_i2c2_devices,
-				ARRAY_SIZE(mop500_i2c2_devices));
-
 	/* This board has full regulator constraints */
 	regulator_has_full_constraints();
 }
-- 
1.8.1.4
