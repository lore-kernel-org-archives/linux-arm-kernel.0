From: dromede@gmail.com (dromede at gmail.com)
Date: Fri, 30 Nov 2012 00:22:59 +0100
Subject: [PATCH] [ARM] pxa/spitz: Minor code refactor and typo fixes
Message-ID: <1354231379-17289-1-git-send-email-dromede@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marko Katic <dromede.gmail.com>

This patch slightly changes the way i2c devices are defined
and registered.
I2c devices that are present in  all spitz variants are always defined
while the max7310 gpio expander specific to the akita variant is defined
conditionally. This makes more sense and will result in a slightly smaller kernel
for some variants.

I2c init function spitz_i2c_init() is simplified and is now more readable.

Some code sections were renamed to better describe their contents.

Signed-off-by: Marko Katic <dromede@gmail.com>
---
 arch/arm/mach-pxa/spitz.c |   46 ++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 2073f0e..0f92264 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -732,7 +732,7 @@ static inline void spitz_lcd_init(void) {}
 #endif
 
 /******************************************************************************
- * Framebuffer
+ * NAND Flash
  ******************************************************************************/
 #if defined(CONFIG_MTD_NAND_SHARPSL) || defined(CONFIG_MTD_NAND_SHARPSL_MODULE)
 static struct mtd_partition spitz_nand_partitions[] = {
@@ -858,23 +858,13 @@ static inline void spitz_nor_init(void) {}
 #endif
 
 /******************************************************************************
- * GPIO expander
+ * I2C devices
  ******************************************************************************/
 #if defined(CONFIG_I2C_PXA) || defined(CONFIG_I2C_PXA_MODULE)
 static struct pca953x_platform_data akita_pca953x_pdata = {
 	.gpio_base		= AKITA_IOEXP_GPIO_BASE,
 };
 
-static struct i2c_board_info spitz_i2c_devs[] = {
-	{
-		.type		= "wm8750",
-		.addr		= 0x1b,
-	}, {
-		.type		= "max7310",
-		.addr		= 0x18,
-		.platform_data	= &akita_pca953x_pdata,
-	},
-};
 
 static struct regulator_consumer_supply isl6271a_consumers[] = {
 	REGULATOR_SUPPLY("vcc_core", NULL),
@@ -894,7 +884,12 @@ static struct regulator_init_data isl6271a_info[] = {
 	}
 };
 
-static struct i2c_board_info spitz_pi2c_devs[] = {
+/* wm8750 and isl6271a are present in all spitz variants */
+static struct i2c_board_info spitz_i2c_devs[2] = {
+	{
+		.type		= "wm8750",
+		.addr		= 0x1b,
+	},
 	{
 		.type		= "isl6271a",
 		.addr		= 0x0c,
@@ -902,18 +897,27 @@ static struct i2c_board_info spitz_pi2c_devs[] = {
 	},
 };
 
+#ifdef CONFIG_MACH_AKITA
+static struct i2c_board_info akita_i2c_devs[1] = {
+	{
+		.type		= "max7310",
+		.addr		= 0x18,
+		.platform_data	= &akita_pca953x_pdata,
+	},
+};
+#endif
+
 static void __init spitz_i2c_init(void)
 {
-	int size = ARRAY_SIZE(spitz_i2c_devs);
-
-	/* Only Akita has the max7310 chip */
-	if (!machine_is_akita())
-		size--;
-
 	pxa_set_i2c_info(NULL);
 	pxa27x_set_i2c_power_info(NULL);
-	i2c_register_board_info(0, spitz_i2c_devs, size);
-	i2c_register_board_info(1, ARRAY_AND_SIZE(spitz_pi2c_devs));
+
+	i2c_register_board_info(0, &spitz_i2c_devs[0], 1);
+	i2c_register_board_info(1, &spitz_i2c_devs[1], 1);
+
+	if (machine_is_akita())
+		i2c_register_board_info(0, akita_i2c_devs, 1);
+
 }
 #else
 static inline void spitz_i2c_init(void) {}
-- 
1.7.10.4
