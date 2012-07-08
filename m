From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun, 8 Jul 2012 20:20:51 +0200
Subject: [PATCH 09/10] MACH/Samsung/Mini2440: enable buzzer
In-Reply-To: <1341767544-17447-10-git-send-email-jbe@pengutronix.de>
References: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
 <1341767544-17447-10-git-send-email-jbe@pengutronix.de>
Message-ID: <201207082020.51220.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index ad1d89e..8a41f03 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -592,6 +592,15 @@ static struct s3c_hwmon_pdata mini2440_adc __initdata = {
 	.in[7] = &mini2440_adc_chcfg[7],
 };
 
+static struct platform_device mini2440_buzzer_device = {
+	.name = "pwm-beeper",
+	.id = -1,
+	.dev = {
+		.parent = &s3c_device_timer[0].dev,
+		.platform_data = (void *)0,	/* channel 0 */
+	},
+};
+
 static struct platform_device *mini2440_devices[] __initdata = {
 	&s3c_device_ohci,
 	&s3c_device_wdt,
@@ -609,6 +618,8 @@ static struct platform_device *mini2440_devices[] __initdata = {
 	&samsung_asoc_dma,
 	&s3c_device_adc,
 	&s3c_device_hwmon,
+	&s3c_device_timer[0],
+	&mini2440_buzzer_device,
 };
 
 static void __init mini2440_map_io(void)
@@ -771,6 +782,9 @@ static void __init mini2440_init(void)
 	i2c_register_board_info(0, mini2440_i2c_devs,
 				ARRAY_SIZE(mini2440_i2c_devs));
 
+	/* PWM to the buzzer */
+	s3c_gpio_cfgpin(S3C2410_GPB(0), S3C2410_GPB0_TOUT0);
+
 	platform_add_devices(mini2440_devices, ARRAY_SIZE(mini2440_devices));
 
 	if (features.count)	/* the optional features */

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
