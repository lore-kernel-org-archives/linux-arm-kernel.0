From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Wed, 16 Mar 2011 15:59:11 +0900
Subject: [PATCH] ARM: EXYNOS4: Add Atmel mXT touchscreen device to the NURI
	board
Message-ID: <1300258751-662-1-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to support Atmel mXT touchscreen device to the NURI board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
Hi,

This patch is created at the source tree merged next branch of
git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git to next-exynos4 branch of
git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

Thanks.

 arch/arm/mach-exynos4/Kconfig     |    2 +
 arch/arm/mach-exynos4/mach-nuri.c |   89 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos4/Kconfig b/arch/arm/mach-exynos4/Kconfig
index 82195a9..74a5ff6 100644
--- a/arch/arm/mach-exynos4/Kconfig
+++ b/arch/arm/mach-exynos4/Kconfig
@@ -151,8 +151,10 @@ config MACH_NURI
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
 	select S3C_DEV_I2C1
+	select S3C_DEV_I2C3
 	select S3C_DEV_I2C5
 	select EXYNOS4_SETUP_I2C1
+	select EXYNOS4_SETUP_I2C3
 	select EXYNOS4_SETUP_I2C5
 	select EXYNOS4_SETUP_SDHCI
 	select SAMSUNG_DEV_PWM
diff --git a/arch/arm/mach-exynos4/mach-nuri.c b/arch/arm/mach-exynos4/mach-nuri.c
index b79ad01..cf354e2 100644
--- a/arch/arm/mach-exynos4/mach-nuri.c
+++ b/arch/arm/mach-exynos4/mach-nuri.c
@@ -12,6 +12,7 @@
 #include <linux/serial_core.h>
 #include <linux/input.h>
 #include <linux/i2c.h>
+#include <linux/i2c/atmel_mxt_ts.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
 #include <linux/regulator/machine.h>
@@ -30,6 +31,8 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/sdhci.h>
+#include <plat/gpio-cfg.h>
+#include <plat/iic.h>
 
 #include <mach/map.h>
 
@@ -257,6 +260,88 @@ static struct i2c_board_info i2c1_devs[] __initdata = {
 	/* Gyro, To be updated */
 };
 
+/* TSP */
+static u8 mxt_init_vals[] = {
+	/* MXT_GEN_COMMAND(6) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* MXT_GEN_POWER(7) */
+	0x20, 0xff, 0x32,
+	/* MXT_GEN_ACQUIRE(8) */
+	0x0a, 0x00, 0x05, 0x00, 0x00, 0x00, 0x09, 0x23,
+	/* MXT_TOUCH_MULTI(9) */
+	0x00, 0x00, 0x00, 0x13, 0x0b, 0x00, 0x00, 0x00, 0x02, 0x00,
+	0x00, 0x01, 0x01, 0x0e, 0x0a, 0x0a, 0x0a, 0x0a, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00,
+	/* MXT_TOUCH_KEYARRAY(15) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00,
+	0x00,
+	/* MXT_SPT_GPIOPWM(19) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* MXT_PROCI_GRIPFACE(20) */
+	0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x50, 0x28, 0x04,
+	0x0f, 0x0a,
+	/* MXT_PROCG_NOISE(22) */
+	0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0x23, 0x00,
+	0x00, 0x05, 0x0f, 0x19, 0x23, 0x2d, 0x03,
+	/* MXT_TOUCH_PROXIMITY(23) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00,
+	/* MXT_PROCI_ONETOUCH(24) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* MXT_SPT_SELFTEST(25) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00,
+	/* MXT_PROCI_TWOTOUCH(27) */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	/* MXT_SPT_CTECONFIG(28) */
+	0x00, 0x00, 0x02, 0x08, 0x10, 0x00,
+};
+
+static struct mxt_platform_data mxt_platform_data = {
+	.config			= mxt_init_vals,
+	.config_length		= ARRAY_SIZE(mxt_init_vals),
+
+	.x_line			= 18,
+	.y_line			= 11,
+	.x_size			= 1024,
+	.y_size			= 600,
+	.blen			= 0x1,
+	.threshold		= 0x28,
+	.voltage		= 2800000,              /* 2.8V */
+	.orient			= MXT_DIAGONAL_COUNTER,
+	.irqflags		= IRQF_TRIGGER_FALLING,
+};
+
+static struct s3c2410_platform_i2c i2c3_data __initdata = {
+	.flags		= 0,
+	.bus_num	= 3,
+	.slave_addr	= 0x10,
+	.frequency	= 400 * 1000,
+	.sda_delay	= 100,
+};
+
+static struct i2c_board_info i2c3_devs[] __initdata = {
+	{
+		I2C_BOARD_INFO("atmel_mxt_ts", 0x4a),
+		.platform_data	= &mxt_platform_data,
+		.irq		= IRQ_EINT(4),
+	},
+};
+
+static void __init nuri_tsp_init(void)
+{
+	int gpio;
+
+	/* TOUCH_INT: XEINT_4 */
+	gpio = EXYNOS4_GPX0(4);
+	gpio_request(gpio, "TOUCH_INT");
+	s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(0xf));
+	s3c_gpio_setpull(gpio, S3C_GPIO_PULL_UP);
+}
+
 /* GPIO I2C 5 (PMIC) */
 static struct i2c_board_info i2c5_devs[] __initdata = {
 	/* max8997, To be updated */
@@ -270,6 +355,7 @@ static struct platform_device *nuri_devices[] __initdata = {
 	&s3c_device_hsmmc3,
 	&s3c_device_wdt,
 	&s3c_device_timer[0],
+	&s3c_device_i2c3,
 
 	/* NURI Devices */
 	&nuri_gpio_keys,
@@ -287,8 +373,11 @@ static void __init nuri_map_io(void)
 static void __init nuri_machine_init(void)
 {
 	nuri_sdhci_init();
+	nuri_tsp_init();
 
 	i2c_register_board_info(1, i2c1_devs, ARRAY_SIZE(i2c1_devs));
+	s3c_i2c3_set_platdata(&i2c3_data);
+	i2c_register_board_info(3, i2c3_devs, ARRAY_SIZE(i2c3_devs));
 	i2c_register_board_info(5, i2c5_devs, ARRAY_SIZE(i2c5_devs));
 
 	/* Last */
-- 
1.7.0.4
