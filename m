From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Jan 2012 13:36:07 +0900
Subject: [PATCH 2/7] ARM: S3C24XX: use static declaration when it is not used
 in other files
Message-ID: <010a01ccd7f6$3173a190$945ae4b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c2410/mach-h1940.c    |   12 ++++++------
 arch/arm/mach-s3c2416/clock.c         |    6 ------
 arch/arm/mach-s3c2416/mach-smdk2416.c |    8 ++++----
 arch/arm/mach-s3c2440/mach-gta02.c    |    4 ++--
 arch/arm/mach-s3c2440/mach-rx1950.c   |   12 ++++++------
 arch/arm/plat-s3c24xx/s3c2443-clock.c |    2 +-
 6 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index 41245a6..6b21ba1 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -162,7 +162,7 @@ static int h1940_gpiolib_latch_get(struct gpio_chip *chip,
 	return (latch_state >> (offset + 16)) & 1;
 }
 
-struct gpio_chip h1940_latch_gpiochip = {
+static struct gpio_chip h1940_latch_gpiochip = {
 	.base			= H1940_LATCH_GPIO(0),
 	.owner			= THIS_MODULE,
 	.label			= "H1940_LATCH",
@@ -304,7 +304,7 @@ static const struct s3c_adc_bat_thresh bat_lut_acin[] = {
 	{ .volt = 3841, .cur = 0, .level = 0},
 };
 
-int h1940_bat_init(void)
+static int h1940_bat_init(void)
 {
 	int ret;
 
@@ -317,17 +317,17 @@ int h1940_bat_init(void)
 
 }
 
-void h1940_bat_exit(void)
+static void h1940_bat_exit(void)
 {
 	gpio_free(H1940_LATCH_SM803_ENABLE);
 }
 
-void h1940_enable_charger(void)
+static void h1940_enable_charger(void)
 {
 	gpio_set_value(H1940_LATCH_SM803_ENABLE, 1);
 }
 
-void h1940_disable_charger(void)
+static void h1940_disable_charger(void)
 {
 	gpio_set_value(H1940_LATCH_SM803_ENABLE, 0);
 }
@@ -364,7 +364,7 @@ static struct platform_device h1940_battery = {
 	},
 };
 
-DEFINE_SPINLOCK(h1940_blink_spin);
+static DEFINE_SPINLOCK(h1940_blink_spin);
 
 int h1940_led_blink_set(unsigned gpio, int state,
 	unsigned long *delay_on, unsigned long *delay_off)
diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
index 59f54d1..e01490d 100644
--- a/arch/arm/mach-s3c2416/clock.c
+++ b/arch/arm/mach-s3c2416/clock.c
@@ -132,12 +132,6 @@ static struct clk hsmmc0_clk = {
 	.ctrlbit	= S3C2416_HCLKCON_HSMMC0,
 };
 
-void __init_or_cpufreq s3c2416_setup_clocks(void)
-{
-	s3c2443_common_setup_clocks(s3c2416_get_pll);
-}
-
-
 static struct clksrc_clk *clksrcs[] __initdata = {
 	&hsspi_eplldiv,
 	&hsspi_mux,
diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
index eebe1e7..30a44f8 100644
--- a/arch/arm/mach-s3c2416/mach-smdk2416.c
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -125,7 +125,7 @@ static struct s3c2410_uartcfg smdk2416_uartcfgs[] __initdata = {
 	}
 };
 
-void smdk2416_hsudc_gpio_init(void)
+static void smdk2416_hsudc_gpio_init(void)
 {
 	s3c_gpio_setpull(S3C2410_GPH(14), S3C_GPIO_PULL_UP);
 	s3c_gpio_setpull(S3C2410_GPF(2), S3C_GPIO_PULL_NONE);
@@ -133,20 +133,20 @@ void smdk2416_hsudc_gpio_init(void)
 	s3c2410_modify_misccr(S3C2416_MISCCR_SEL_SUSPND, 0);
 }
 
-void smdk2416_hsudc_gpio_uninit(void)
+static void smdk2416_hsudc_gpio_uninit(void)
 {
 	s3c2410_modify_misccr(S3C2416_MISCCR_SEL_SUSPND, 1);
 	s3c_gpio_setpull(S3C2410_GPH(14), S3C_GPIO_PULL_NONE);
 	s3c_gpio_cfgpin(S3C2410_GPH(14), S3C_GPIO_SFN(0));
 }
 
-struct s3c24xx_hsudc_platdata smdk2416_hsudc_platdata = {
+static struct s3c24xx_hsudc_platdata smdk2416_hsudc_platdata = {
 	.epnum = 9,
 	.gpio_init = smdk2416_hsudc_gpio_init,
 	.gpio_uninit = smdk2416_hsudc_gpio_uninit,
 };
 
-struct s3c_fb_pd_win smdk2416_fb_win[] = {
+static struct s3c_fb_pd_win smdk2416_fb_win[] = {
 	[0] = {
 		/* think this is the same as the smdk6410 */
 		.win_mode	= {
diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 5859e60..7365a44 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -258,7 +258,7 @@ static struct pcf50633_bl_platform_data gta02_backlight_data = {
 	.ramp_time = 5,
 };
 
-struct pcf50633_platform_data gta02_pcf_pdata = {
+static struct pcf50633_platform_data gta02_pcf_pdata = {
 	.resumers = {
 		[0] =	PCF50633_INT1_USBINS |
 			PCF50633_INT1_USBREM |
@@ -404,7 +404,7 @@ static struct platform_device gta02_nor_flash = {
 };
 
 
-struct platform_device s3c24xx_pwm_device = {
+static struct platform_device s3c24xx_pwm_device = {
 	.name		= "s3c24xx_pwm",
 	.num_resources	= 0,
 };
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 80077f6..4a8e2d3 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -217,7 +217,7 @@ static const struct s3c_adc_bat_thresh bat_lut_acin[] = {
 	{ .volt = 3820, .cur = 0, .level = 0},
 };
 
-int rx1950_bat_init(void)
+static int rx1950_bat_init(void)
 {
 	int ret;
 
@@ -236,25 +236,25 @@ err_gpio1:
 	return ret;
 }
 
-void rx1950_bat_exit(void)
+static void rx1950_bat_exit(void)
 {
 	gpio_free(S3C2410_GPJ(2));
 	gpio_free(S3C2410_GPJ(3));
 }
 
-void rx1950_enable_charger(void)
+static void rx1950_enable_charger(void)
 {
 	gpio_direction_output(S3C2410_GPJ(2), 1);
 	gpio_direction_output(S3C2410_GPJ(3), 1);
 }
 
-void rx1950_disable_charger(void)
+static void rx1950_disable_charger(void)
 {
 	gpio_direction_output(S3C2410_GPJ(2), 0);
 	gpio_direction_output(S3C2410_GPJ(3), 0);
 }
 
-DEFINE_SPINLOCK(rx1950_blink_spin);
+static DEFINE_SPINLOCK(rx1950_blink_spin);
 
 static int rx1950_led_blink_set(unsigned gpio, int state,
 	unsigned long *delay_on, unsigned long *delay_off)
@@ -382,7 +382,7 @@ static struct s3c2410fb_mach_info rx1950_lcd_cfg = {
 
 static struct pwm_device *lcd_pwm;
 
-void rx1950_lcd_power(int enable)
+static void rx1950_lcd_power(int enable)
 {
 	int i;
 	static int enabled;
diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3c24xx/s3c2443-clock.c
index 95e6819..037b448 100644
--- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
+++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
@@ -53,7 +53,7 @@ int s3c2443_clkcon_enable_s(struct clk *clk, int enable)
  * elided as the EPLL can be either sourced by the XTAL or EXTCLK and as
  * such directly equating the two source clocks is impossible.
  */
-struct clk clk_mpllref = {
+static struct clk clk_mpllref = {
 	.name		= "mpllref",
 	.parent		= &clk_xtal,
 };
-- 
1.7.1
