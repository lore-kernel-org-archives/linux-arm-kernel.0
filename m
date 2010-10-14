From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 14 Oct 2010 10:57:42 +0900
Subject: [PATCH v2 1/2] ARM: S5PV210: Add i2c information to Goni and Aquila
	board
Message-ID: <4CB66396.8010004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch the I2C board information for the WM8994 used in the Goni/Aquila
as audio codec and adds the I2C platform drivers.

Signed-off-by : Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by : Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by : Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-aquila.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/mach-goni.c   |   27 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index 0dda801..0663ec4 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -404,6 +404,28 @@ static struct i2c_board_info i2c_gpio_pmic_devs[] __initdata = {
 #endif
 };
 
+/* GPIO I2C AP 1.8V */
+#define AP_I2C_GPIO_BUS_5	5
+static struct i2c_gpio_platform_data aquila_i2c_gpio5_data = {
+	.sda_pin	= S5PV210_MP05(3),	/* XM0ADDR_11 */
+	.scl_pin	= S5PV210_MP05(2),	/* XM0ADDR_10 */
+};
+
+static struct platform_device aquila_i2c_gpio5 = {
+	.name		= "i2c-gpio",
+	.id		= AP_I2C_GPIO_BUS_5,
+	.dev		= {
+		.platform_data	= &aquila_i2c_gpio5_data,
+	},
+};
+
+static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
+	{
+		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
+		I2C_BOARD_INFO("wm8994", 0x1a),
+	},
+};
+
 /* PMIC Power button */
 static struct gpio_keys_button aquila_gpio_keys_table[] = {
 	{
@@ -475,6 +497,7 @@ static void aquila_setup_sdhci(void)
 
 static struct platform_device *aquila_devices[] __initdata = {
 	&aquila_i2c_gpio_pmic,
+	&aquila_i2c_gpio5,
 	&aquila_device_gpiokeys,
 	&s3c_device_fb,
 	&s5pc110_device_onenand,
@@ -506,6 +529,10 @@ static void __init aquila_machine_init(void)
 	s3c_fimc_setname(1, "s5p-fimc");
 	s3c_fimc_setname(2, "s5p-fimc");
 
+	/* SOUND */
+	i2c_register_board_info(AP_I2C_GPIO_BUS_5, i2c_gpio5_devs,
+			ARRAY_SIZE(i2c_gpio5_devs));
+
 	/* FB */
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 53754d7..df5c2d1 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -385,6 +385,28 @@ static struct i2c_board_info i2c_gpio_pmic_devs[] __initdata = {
 #endif
 };
 
+/* GPIO I2C AP 1.8V */
+#define AP_I2C_GPIO_BUS_5	5
+static struct i2c_gpio_platform_data goni_i2c_gpio5_data = {
+	.sda_pin	= S5PV210_MP05(3),	/* XM0ADDR_11 */
+	.scl_pin	= S5PV210_MP05(2),	/* XM0ADDR_10 */
+};
+
+static struct platform_device goni_i2c_gpio5 = {
+	.name		= "i2c-gpio",
+	.id		= AP_I2C_GPIO_BUS_5,
+	.dev		= {
+		.platform_data	= &goni_i2c_gpio5_data,
+	},
+};
+
+static struct i2c_board_info i2c_gpio5_devs[] __initdata = {
+	{
+		/* CS/ADDR = low 0x34 (FYI: high = 0x36) */
+		I2C_BOARD_INFO("wm8994", 0x1a),
+	},
+};
+
 /* PMIC Power button */
 static struct gpio_keys_button goni_gpio_keys_table[] = {
 	{
@@ -458,6 +480,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_fb,
 	&s5pc110_device_onenand,
 	&goni_i2c_gpio_pmic,
+	&goni_i2c_gpio5,
 	&goni_device_gpiokeys,
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
@@ -483,6 +506,10 @@ static void __init goni_machine_init(void)
 	/* SDHCI */
 	goni_setup_sdhci();
 
+	/* SOUND */
+	i2c_register_board_info(AP_I2C_GPIO_BUS_5, i2c_gpio5_devs,
+			ARRAY_SIZE(i2c_gpio5_devs));
+
 	/* FB */
 	s3c_fb_set_platdata(&goni_lcd_pdata);
 
-- 
1.7.0.4
