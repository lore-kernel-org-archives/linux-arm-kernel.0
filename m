From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 19 Aug 2010 17:50:45 +0900
Subject: [PATCH 3/4] ARM: S5PC110: GONI: Add TSP driver
In-Reply-To: <1282207846-4578-1-git-send-email-jy0922.shim@samsung.com>
References: <1282207846-4578-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1282207846-4578-3-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Use the TSP on I2C2.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    2 +
 arch/arm/mach-s5pv210/mach-goni.c |   53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 303c8a6..1538dad 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -89,10 +89,12 @@ config MACH_GONI
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_I2C1
+	select S3C_DEV_I2C2
 	select S5PC110_DEV_ONENAND
 	select SAMSUNG_DEV_KEYPAD
 	select S5PV210_SETUP_FB_24BPP
 	select S5PV210_SETUP_I2C1
+	select S5PV210_SETUP_I2C2
 	select S5PV210_SETUP_KEYPAD
 	select S5PV210_SETUP_SDHCI
 	help
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index c4f10c8..21a1bfc 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -15,6 +15,7 @@
 #include <linux/fb.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/i2c/qt602240_ts.h>
 #include <linux/mfd/max8998.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -156,6 +157,50 @@ static void __init goni_radio_init(void)
 	gpio_direction_output(gpio, 1);
 }
 
+/* TSP */
+static struct qt602240_platform_data qt602240_platform_data = {
+	.x_line		= 17,
+	.y_line		= 11,
+	.x_size		= 800,
+	.y_size		= 480,
+	.blen		= 0x21,
+	.threshold	= 0x28,
+	.voltage	= 2800000,              /* 2.8V */
+	.orient		= QT602240_DIAGONAL,
+};
+
+static struct s3c2410_platform_i2c i2c2_data __initdata = {
+	.flags		= 0,
+	.bus_num	= 2,
+	.slave_addr	= 0x10,
+	.frequency	= 400 * 1000,
+	.sda_delay	= 100,
+};
+
+static struct i2c_board_info i2c2_devs[] __initdata = {
+	{
+		I2C_BOARD_INFO("qt602240_ts", 0x4a),
+		.platform_data = &qt602240_platform_data,
+	},
+};
+
+static void __init goni_tsp_init(void)
+{
+	int gpio, irq;
+
+	gpio = S5PV210_GPJ1(3);                 /* XMSMADDR_11 */
+	gpio_request(gpio, "TSP_LDO_ON");
+	gpio_direction_output(gpio, 1);
+	gpio_export(gpio, 0);
+
+	gpio = S5PV210_GPJ0(5);                 /* XMSMADDR_5 */
+	gpio_request(gpio, "TSP_INT");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+	irq = gpio_to_irq(gpio);
+	i2c2_devs[0].irq = irq;
+}
+
 /* MAX8998 regulators */
 #if defined(CONFIG_REGULATOR_MAX8998) || defined(CONFIG_REGULATOR_MAX8998_MODULE)
 
@@ -511,6 +556,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
 	&s3c_device_i2c1,
+	&s3c_device_i2c2,
 	&samsung_device_keypad,
 };
 
@@ -530,6 +576,13 @@ static void __init goni_machine_init(void)
 	s3c_i2c1_set_platdata(NULL);
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
 
+	/* TSP: call before I2C 2 registeration */
+	goni_tsp_init();
+
+	/* I2C2 */
+	s3c_i2c2_set_platdata(&i2c2_data);
+	i2c_register_board_info(2, i2c2_devs, ARRAY_SIZE(i2c2_devs));
+
 	/* PMIC */
 	goni_pmic_init();
 	i2c_register_board_info(AP_I2C_GPIO_PMIC_BUS_4, i2c_gpio_pmic_devs,
-- 
1.7.0.4
