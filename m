From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 30 Jun 2010 21:59:22 +0900
Subject: [PATCH] ARM: S5PC100: Add Touchscreen support.
Message-ID: <1277902762-12916-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch adds touchscreen support for S5PC100.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig            |    2 ++
 arch/arm/mach-s5pc100/cpu.c              |    3 +++
 arch/arm/mach-s5pc100/include/mach/map.h |    5 ++++-
 arch/arm/mach-s5pc100/mach-smdkc100.c    |   12 ++++++++++++
 4 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index b2a11df..4cc740e 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -39,11 +39,13 @@ config S5PC100_SETUP_SDHCI_GPIO
 config MACH_SMDKC100
 	bool "SMDKC100"
 	select CPU_S5PC100
+	select SAMSUNG_DEV_ADC
 	select S3C_DEV_FB
 	select S3C_DEV_I2C1
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
+	select SAMSUNG_DEV_TS
 	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_I2C1
 	select S5PC100_SETUP_SDHCI
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index 7b5bdbc..5edd8e9 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -40,6 +40,7 @@
 #include <plat/clock.h>
 #include <plat/iic-core.h>
 #include <plat/sdhci.h>
+#include <plat/adc-core.h>
 #include <plat/onenand-core.h>
 
 #include <plat/s5pc100.h>
@@ -87,6 +88,8 @@ void __init s5pc100_map_io(void)
 	s5pc100_default_sdhci1();
 	s5pc100_default_sdhci2();
 
+	s3c_adc_setname("s3c64xx-adc");
+
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index cadae43..56d02c0 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -104,6 +104,8 @@
 #define S5PC100_PA_PCM0		0xF2400000
 #define S5PC100_PA_PCM1		0xF2500000
 
+#define S5PC100_PA_TSADC	(0xF3000000)
+
 /* KEYPAD */
 #define S5PC100_PA_KEYPAD	(0xF3100000)
 
@@ -130,9 +132,10 @@
 #define S3C_PA_HSMMC1		S5PC100_PA_HSMMC(1)
 #define S3C_PA_HSMMC2		S5PC100_PA_HSMMC(2)
 #define S3C_PA_KEYPAD		S5PC100_PA_KEYPAD
-#define S3C_PA_TSADC		S5PC100_PA_TSADC
 #define S3C_PA_ONENAND		S5PC100_PA_ONENAND
 #define S3C_PA_ONENAND_BUF	S5PC100_PA_ONENAND_BUF
 #define S3C_SZ_ONENAND_BUF	S5PC100_SZ_ONENAND_BUF
 
+#define SAMSUNG_PA_ADC		S5PC100_PA_TSADC
+
 #endif /* __ASM_ARCH_C100_MAP_H */
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index af22f82..ebb682b 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -42,6 +42,8 @@
 #include <plat/s5pc100.h>
 #include <plat/fb.h>
 #include <plat/iic.h>
+#include <plat/adc.h>
+#include <plat/ts.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -150,16 +152,24 @@ static struct s3c_fb_platdata smdkc100_lcd_pdata __initdata = {
 };
 
 static struct platform_device *smdkc100_devices[] __initdata = {
+	&s3c_device_adc,
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
 	&s3c_device_fb,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
+	&s3c_device_ts,
 	&smdkc100_lcd_powerdev,
 	&s5pc100_device_iis0,
 	&s5pc100_device_ac97,
 };
+
+static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
+	.delay			= 10000,
+	.presc			= 49,
+	.oversampling_shift	= 2,
+};
 
 static void __init smdkc100_map_io(void)
 {
@@ -170,6 +180,8 @@ static void __init smdkc100_map_io(void)
 
 static void __init smdkc100_machine_init(void)
 {
+	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+
 	/* I2C */
 	s3c_i2c0_set_platdata(NULL);
 	s3c_i2c1_set_platdata(NULL);
-- 
1.6.2.5
