From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 12 Nov 2009 09:21:58 +0100
Subject: [PATCH 14/18] SMDKC100: add I2C0 and I2C1 buses support
In-Reply-To: <1258014122-18185-14-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-2-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-3-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-4-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-5-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-6-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-7-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-8-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-9-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-10-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-11-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-12-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-13-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-14-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258014122-18185-15-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

From: Kyungmin Park <kyungmin.park@samsung.com>

Add required machine definitions for I2C 0 and 1 bus controllers.
Currently no I2C device are defined yet.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig         |    2 ++
 arch/arm/mach-s5pc100/mach-smdkc100.c |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 5e6b9a3..36e7e00 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -18,6 +18,8 @@ config MACH_SMDKC100
 	bool "SMDKC100"
 	select CPU_S5PC100
 	select S3C_DEV_FB
+	select S3C_DEV_I2C1
+	select S5PC1XX_SETUP_I2C0
 	select S5PC1XX_SETUP_I2C1
 	select S5PC1XX_SETUP_FB_24BPP
 	help
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 098956d..2c0119f 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -42,6 +42,7 @@
 #include <plat/cpu.h>
 #include <plat/s5pc100.h>
 #include <plat/fb.h>
+#include <plat/iic.h>
 
 #define UCON (S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
@@ -78,6 +79,14 @@ static struct s3c2410_uartcfg smdkc100_uartcfgs[] __initdata = {
 	},
 };
 
+/* I2C0 */
+static struct i2c_board_info i2c_devs0[] __initdata = {
+};
+
+/* I2C1 */
+static struct i2c_board_info i2c_devs1[] __initdata = {
+};
+
 /* LCD power controller */
 static void smdkc100_lcd_power_set(struct plat_lcd_data *pd,
 				   unsigned int power)
@@ -135,6 +144,8 @@ static struct s3c_fb_platdata smdkc100_lcd_pdata __initdata = {
 static struct map_desc smdkc100_iodesc[] = {};
 
 static struct platform_device *smdkc100_devices[] __initdata = {
+	&s3c_device_i2c0,
+	&s3c_device_i2c1,
 	&s3c_device_fb,
 	&smdkc100_lcd_powerdev,
 };
@@ -148,6 +159,12 @@ static void __init smdkc100_map_io(void)
 
 static void __init smdkc100_machine_init(void)
 {
+	/* I2C */
+	s3c_i2c0_set_platdata(NULL);
+	s3c_i2c1_set_platdata(NULL);
+	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
+	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
+
 	s3c_fb_set_platdata(&smdkc100_lcd_pdata);
 
 	/* LCD init */
-- 
1.6.5
