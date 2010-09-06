From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 06 Sep 2010 11:12:27 +0200
Subject: [PATCH 6/6] ARM: S5PC110: GONI: Add support for QT602240 TS driver
In-Reply-To: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
References: <1283764347-460-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1283764347-460-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Add required platform definitions for QT602240 touchscreen on I2C2 bus.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    3 ++
 arch/arm/mach-s5pv210/mach-goni.c |   56 +++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 5315fec..2f4025d 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -76,6 +76,7 @@ config MACH_GONI
 	bool "GONI"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S5P_GPIO_INT
 	select S3C_DEV_FB
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
@@ -83,8 +84,10 @@ config MACH_GONI
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
+	select S3C_DEV_I2C2
 	select S5P_DEV_ONENAND
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_I2C2
 	select S5PV210_SETUP_SDHCI
 	help
 	  Machine support for Samsung GONI board
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index fdc5cca..bc9c5af 100644
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
@@ -35,6 +36,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/iic.h>
 #include <plat/sdhci.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
@@ -111,6 +113,52 @@ static struct s3c_fb_platdata goni_lcd_pdata __initdata = {
 	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
 };
 
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
+
+	s5p_register_gpio_interrupt(gpio);
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+	irq = gpio_to_irq(gpio);
+	i2c2_devs[0].irq = irq;
+}
+
 /* MAX8998 regulators */
 #if defined(CONFIG_REGULATOR_MAX8998) || defined(CONFIG_REGULATOR_MAX8998_MODULE)
 
@@ -465,6 +513,7 @@ static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
+	&s3c_device_i2c2,
 };
 
 static void __init goni_map_io(void)
@@ -476,6 +525,13 @@ static void __init goni_map_io(void)
 
 static void __init goni_machine_init(void)
 {
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
1.7.2.2
