From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:06:52 +0100
Subject: [PATCH 07/10] ARM: s3c64xx: use new adc/touchscreen driver
In-Reply-To: <1448467615-447097-1-git-send-email-arnd@arndb.de>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
Message-ID: <1448467615-447097-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old ADC and touchscreen drivers are not compatible with
multiplatform support, but we can use the exynos-adc driver
as a replacement.

This changes the common device creation functions for s3c64xx
(but not s3c24xx for now) to use the new driver. To do this,
we have to pass the interrupt resources in the opposite order
and pass the platform data in the adc device node.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c64xx/mach-mini6410.c             |  3 +--
 arch/arm/mach-s3c64xx/mach-real6410.c             |  3 +--
 arch/arm/mach-s3c64xx/mach-smartq.c               |  3 +--
 arch/arm/mach-s3c64xx/mach-smdk6410.c             |  3 +--
 arch/arm/plat-samsung/devs.c                      | 22 +++++-----------------
 include/linux/platform_data/touchscreen-s3c2410.h |  1 +
 6 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c64xx/mach-mini6410.c
index 3ce5842ed51b..ae999fb3fe6d 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c64xx/mach-mini6410.c
@@ -234,7 +234,6 @@ static struct platform_device *mini6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&mini6410_lcd_powerdev,
 	&s3c_device_adc,
-	&s3c_device_ts,
 };
 
 static void __init mini6410_map_io(void)
@@ -333,7 +332,7 @@ static void __init mini6410_machine_init(void)
 	s3c_nand_set_platdata(&mini6410_nand_info);
 	s3c_fb_set_platdata(&mini6410_lcd_pdata[features.lcd_index]);
 	s3c_sdhci1_set_platdata(&mini6410_hsmmc1_pdata);
-	s3c24xx_ts_set_platdata(NULL);
+	s3c64xx_ts_set_platdata(NULL);
 
 	/* configure nCS1 width to 16 bits */
 
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
index ca6548a1ed3b..4e240ffa7ac7 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -203,7 +203,6 @@ static struct platform_device *real6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_nand,
 	&s3c_device_adc,
-	&s3c_device_ts,
 	&s3c_device_ohci,
 };
 
@@ -302,7 +301,7 @@ static void __init real6410_machine_init(void)
 
 	s3c_fb_set_platdata(&real6410_lcd_pdata[features.lcd_index]);
 	s3c_nand_set_platdata(&real6410_nand_info);
-	s3c24xx_ts_set_platdata(NULL);
+	s3c64xx_ts_set_platdata(NULL);
 
 	/* configure nCS1 width to 16 bits */
 
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 96784e7f894a..936a63fc68d5 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -253,7 +253,6 @@ static struct platform_device *smartq_devices[] __initdata = {
 	&s3c_device_ohci,
 	&s3c_device_rtc,
 	&samsung_device_pwm,
-	&s3c_device_ts,
 	&s3c_device_usb_hsotg,
 	&s3c64xx_device_iis0,
 	&smartq_backlight_device,
@@ -400,7 +399,7 @@ void __init smartq_machine_init(void)
 	s3c_hwmon_set_platdata(&smartq_hwmon_pdata);
 	s3c_sdhci1_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
-	s3c24xx_ts_set_platdata(&smartq_touchscreen_pdata);
+	s3c64xx_ts_set_platdata(&smartq_touchscreen_pdata);
 
 	i2c_register_board_info(0, smartq_i2c_devs,
 				ARRAY_SIZE(smartq_i2c_devs));
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 34d31bd48954..8a894ee3ee76 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -290,7 +290,6 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_adc,
 	&s3c_device_cfcon,
 	&s3c_device_rtc,
-	&s3c_device_ts,
 	&s3c_device_wdt,
 };
 
@@ -669,7 +668,7 @@ static void __init smdk6410_machine_init(void)
 
 	samsung_keypad_set_platdata(&smdk6410_keypad_data);
 
-	s3c24xx_ts_set_platdata(NULL);
+	s3c64xx_ts_set_platdata(NULL);
 
 	/* configure nCS1 width to 16 bits */
 
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index f39938fa9ef6..b53d4ff3befb 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -119,12 +119,12 @@ struct platform_device s3c_device_adc = {
 #if defined(CONFIG_SAMSUNG_DEV_ADC)
 static struct resource s3c_adc_resource[] = {
 	[0] = DEFINE_RES_MEM(SAMSUNG_PA_ADC, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_TC),
-	[2] = DEFINE_RES_IRQ(IRQ_ADC),
+	[1] = DEFINE_RES_IRQ(IRQ_ADC),
+	[2] = DEFINE_RES_IRQ(IRQ_TC),
 };
 
 struct platform_device s3c_device_adc = {
-	.name		= "samsung-adc",
+	.name		= "exynos-adc",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
 	.resource	= s3c_adc_resource,
@@ -956,31 +956,19 @@ void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_
 #endif /* CONFIG_PLAT_S3C24XX */
 
 #ifdef CONFIG_SAMSUNG_DEV_TS
-static struct resource s3c_ts_resource[] = {
-	[0] = DEFINE_RES_MEM(SAMSUNG_PA_ADC, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_TC),
-};
-
 static struct s3c2410_ts_mach_info default_ts_data __initdata = {
 	.delay			= 10000,
 	.presc			= 49,
 	.oversampling_shift	= 2,
 };
 
-struct platform_device s3c_device_ts = {
-	.name		= "s3c64xx-ts",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_ts_resource),
-	.resource	= s3c_ts_resource,
-};
-
-void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
+void __init s3c64xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
 {
 	if (!pd)
 		pd = &default_ts_data;
 
 	s3c_set_platdata(pd, sizeof(struct s3c2410_ts_mach_info),
-			 &s3c_device_ts);
+			 &s3c_device_adc);
 }
 #endif /* CONFIG_SAMSUNG_DEV_TS */
 
diff --git a/include/linux/platform_data/touchscreen-s3c2410.h b/include/linux/platform_data/touchscreen-s3c2410.h
index 58dc7c5ae63b..71eccaa9835d 100644
--- a/include/linux/platform_data/touchscreen-s3c2410.h
+++ b/include/linux/platform_data/touchscreen-s3c2410.h
@@ -17,6 +17,7 @@ struct s3c2410_ts_mach_info {
 };
 
 extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
+extern void s3c64xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
 
 /* defined by architecture to configure gpio */
 extern void s3c24xx_ts_cfg_gpio(struct platform_device *dev);
-- 
2.1.0.rc2
