From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Jul 2010 22:13:18 +0900
Subject: [PATCH 2/3] ARM: S5PV210: Add support for I2C devices on SMDKV210 and
	SMDKC110
In-Reply-To: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
References: <1279285999-27555-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279285999-27555-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch adds support I2C-0/1/2 devices to the SMDKV210/SMDKC110.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig         |    8 ++++++++
 arch/arm/mach-s5pv210/mach-smdkc110.c |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-s5pv210/mach-smdkv210.c |   29 +++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 0761eac..2a996d9 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -72,9 +72,13 @@ config MACH_SMDKV210
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
 	select SAMSUNG_DEV_ADC
+	select S3C_DEV_I2C1
+	select S3C_DEV_I2C2
 	select SAMSUNG_DEV_TS
 	select S3C_DEV_WDT
 	select HAVE_S3C2410_WATCHDOG
+	select S5PV210_SETUP_I2C1
+	select S5PV210_SETUP_I2C2
 	help
 	  Machine support for Samsung SMDKV210
 
@@ -82,8 +86,12 @@ config MACH_SMDKC110
 	bool "SMDKC110"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S3C_DEV_I2C1
+	select S3C_DEV_I2C2
 	select S3C_DEV_WDT
 	select HAVE_S3C2410_WATCHDOG
+	select S5PV210_SETUP_I2C1
+	select S5PV210_SETUP_I2C2
 	help
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
index 4c8903c..420f9a0 100644
--- a/arch/arm/mach-s5pv210/mach-smdkc110.c
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/serial_core.h>
+#include <linux/i2c.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -25,6 +26,7 @@
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/iic.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -74,9 +76,24 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 static struct platform_device *smdkc110_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
+	&s3c_device_i2c0,
+	&s3c_device_i2c1,
+	&s3c_device_i2c2,
 	&s3c_device_wdt,
 };
 
+static struct i2c_board_info smdkc100_i2c_devs0[] __initdata = {
+	{ I2C_BOARD_INFO("24c08", 0x50), },     /* Samsung S524AD0XD1 */
+};
+
+static struct i2c_board_info smdkc100_i2c_devs1[] __initdata = {
+	/* To Be Updated */
+};
+
+static struct i2c_board_info smdkc100_i2c_devs2[] __initdata = {
+	/* To Be Updated */
+};
+
 static void __init smdkc110_map_io(void)
 {
 	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
@@ -86,6 +103,17 @@ static void __init smdkc110_map_io(void)
 
 static void __init smdkc110_machine_init(void)
 {
+	/* I2C */
+	s3c_i2c0_set_platdata(NULL);
+	s3c_i2c1_set_platdata(NULL);
+	s3c_i2c2_set_platdata(NULL);
+	i2c_register_board_info(0, smdkc100_i2c_devs0,
+			ARRAY_SIZE(smdkc100_i2c_devs0));
+	i2c_register_board_info(1, smdkc100_i2c_devs1,
+			ARRAY_SIZE(smdkc100_i2c_devs1));
+	i2c_register_board_info(2, smdkc100_i2c_devs2,
+			ARRAY_SIZE(smdkc100_i2c_devs2));
+
 	platform_add_devices(smdkc110_devices, ARRAY_SIZE(smdkc110_devices));
 }
 
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 0d46279..765f47e 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/serial_core.h>
 
@@ -27,6 +28,7 @@
 #include <plat/cpu.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/iic.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -77,10 +79,25 @@ static struct platform_device *smdkv210_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
 	&s3c_device_adc,
+	&s3c_device_i2c0,
+	&s3c_device_i2c1,
+	&s3c_device_i2c2,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 };
 
+static struct i2c_board_info smdkv210_i2c_devs0[] __initdata = {
+	{ I2C_BOARD_INFO("24c08", 0x50), },     /* Samsung S524AD0XD1 */
+};
+
+static struct i2c_board_info smdkv210_i2c_devs1[] __initdata = {
+	/* To Be Updated */
+};
+
+static struct i2c_board_info smdkv210_i2c_devs2[] __initdata = {
+	/* To Be Updated */
+};
+
 static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
 	.delay			= 10000,
 	.presc			= 49,
@@ -97,6 +114,18 @@ static void __init smdkv210_map_io(void)
 static void __init smdkv210_machine_init(void)
 {
 	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+
+	/* I2C */
+	s3c_i2c0_set_platdata(NULL);
+	s3c_i2c1_set_platdata(NULL);
+	s3c_i2c2_set_platdata(NULL);
+	i2c_register_board_info(0, smdkv210_i2c_devs0,
+			ARRAY_SIZE(smdkv210_i2c_devs0));
+	i2c_register_board_info(1, smdkv210_i2c_devs1,
+			ARRAY_SIZE(smdkv210_i2c_devs1));
+	i2c_register_board_info(2, smdkv210_i2c_devs2,
+			ARRAY_SIZE(smdkv210_i2c_devs2));
+
 	platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
 }
 
-- 
1.6.2.5
