From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Apr 2014 08:50:52 +0200
Subject: [PATCH] ARM: S3C24XX: remove SAMSUNG_CLOCK remnants after ccf
 conversion
Message-ID: <1615843.xdRuLnoxgD@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This finally removes all remaining SAMSUNG_CLOCK conditional code
from s3c24xx architectures.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
This is of course meant to go on top of the s3c2410 ccf conversion

 arch/arm/mach-s3c24xx/Kconfig         |  5 -----
 arch/arm/mach-s3c24xx/common.c        | 17 -----------------
 arch/arm/mach-s3c24xx/cpufreq-utils.c |  6 ------
 arch/arm/mach-s3c24xx/mach-anubis.c   | 27 ---------------------------
 arch/arm/mach-s3c24xx/mach-bast.c     | 27 ---------------------------
 arch/arm/mach-s3c24xx/mach-osiris.c   | 27 ---------------------------
 arch/arm/mach-s3c24xx/mach-rx1950.c   | 14 --------------
 arch/arm/mach-s3c24xx/mach-vr1000.c   | 27 ---------------------------
 arch/arm/mach-s3c24xx/pm.c            | 12 ------------
 9 files changed, 162 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 77b0fb5..4500802 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -265,7 +265,6 @@ config ARCH_BAST
 	select ISA
 	select MACH_BAST_IDE
 	select S3C2410_IOTIMING if ARM_S3C2410_CPUFREQ
-	select S3C24XX_DCLK if SAMSUNG_CLOCK
 	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_SIMTEC_NOR
 	select S3C24XX_SIMTEC_PM if PM
@@ -347,7 +346,6 @@ config MACH_TCT_HAMMER
 config MACH_VR1000
 	bool "Thorcom VR1000"
 	select MACH_BAST_IDE
-	select S3C24XX_DCLK if SAMSUNG_CLOCK
 	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_SIMTEC_NOR
 	select S3C24XX_SIMTEC_PM if PM
@@ -533,7 +531,6 @@ config MACH_ANUBIS
 	bool "Simtec Electronics ANUBIS"
 	select HAVE_PATA_PLATFORM
 	select S3C2440_XTAL_12000000
-	select S3C24XX_DCLK if SAMSUNG_CLOCK
 	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_SIMTEC_PM if PM
 	select S3C_DEV_USB_HOST
@@ -574,7 +571,6 @@ config MACH_OSIRIS
 	bool "Simtec IM2440D20 (OSIRIS) module"
 	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 	select S3C2440_XTAL_12000000
-	select S3C24XX_DCLK if SAMSUNG_CLOCK
 	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_SIMTEC_PM if PM
 	select S3C_DEV_NAND
@@ -646,7 +642,6 @@ config MACH_RX1950
 	select PM_H1940 if PM
 	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
-	select S3C24XX_DCLK if SAMSUNG_CLOCK
 	select S3C24XX_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_PWM
 	select S3C_DEV_NAND
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 600a1be..c0763b8 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -307,23 +307,6 @@ struct s3c24xx_uart_resources s3c2410_uart_resources[] __initdata = {
 	},
 };
 
-/* initialise all the clocks */
-
-#ifdef CONFIG_SAMSUNG_CLOCK
-void __init_or_cpufreq s3c24xx_setup_clocks(unsigned long fclk,
-					   unsigned long hclk,
-					   unsigned long pclk)
-{
-	clk_upll.rate = s3c24xx_get_pll(__raw_readl(S3C2410_UPLLCON),
-					clk_xtal.rate);
-
-	clk_mpll.rate = fclk;
-	clk_h.rate = hclk;
-	clk_p.rate = pclk;
-	clk_f.rate = fclk;
-}
-#endif
-
 #if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
 	defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
 static struct resource s3c2410_dma_resource[] = {
diff --git a/arch/arm/mach-s3c24xx/cpufreq-utils.c b/arch/arm/mach-s3c24xx/cpufreq-utils.c
index c1b7508..d4d9514 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
+++ b/arch/arm/mach-s3c24xx/cpufreq-utils.c
@@ -61,12 +61,6 @@ void s3c2410_cpufreq_setrefresh(struct s3c_cpufreq_config *cfg)
  */
 void s3c2410_set_fvco(struct s3c_cpufreq_config *cfg)
 {
-#ifdef CONFIG_SAMSUNG_CLOCK
-	__raw_writel(cfg->pll.driver_data, S3C2410_MPLLCON);
-#endif
-
-#ifdef CONFIG_COMMON_CLK
 	if (!IS_ERR(cfg->mpll))
 		clk_set_rate(cfg->mpll, cfg->pll.frequency);
-#endif
 }
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 7a0d83b..e053581 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -364,16 +364,6 @@ static struct platform_device *anubis_devices[] __initdata = {
 	&anubis_device_sm501,
 };
 
-#ifdef CONFIG_SAMSUNG_CLOCK
-static struct clk *anubis_clocks[] __initdata = {
-	&s3c24xx_dclk0,
-	&s3c24xx_dclk1,
-	&s3c24xx_clkout0,
-	&s3c24xx_clkout1,
-	&s3c24xx_uclk,
-};
-#endif
-
 /* I2C devices. */
 
 static struct i2c_board_info anubis_i2c_devs[] __initdata = {
@@ -396,23 +386,6 @@ static struct s3c24xx_audio_simtec_pdata __initdata anubis_audio = {
 
 static void __init anubis_map_io(void)
 {
-#ifdef CONFIG_SAMSUNG_CLOCK
-	/* initialise the clocks */
-
-	s3c24xx_dclk0.parent = &clk_upll;
-	s3c24xx_dclk0.rate   = 12*1000*1000;
-
-	s3c24xx_dclk1.parent = &clk_upll;
-	s3c24xx_dclk1.rate   = 24*1000*1000;
-
-	s3c24xx_clkout0.parent  = &s3c24xx_dclk0;
-	s3c24xx_clkout1.parent  = &s3c24xx_dclk1;
-
-	s3c24xx_uclk.parent  = &s3c24xx_clkout1;
-
-	s3c24xx_register_clocks(anubis_clocks, ARRAY_SIZE(anubis_clocks));
-#endif
-
 	s3c24xx_init_io(anubis_iodesc, ARRAY_SIZE(anubis_iodesc));
 	s3c24xx_init_uarts(anubis_uartcfgs, ARRAY_SIZE(anubis_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index ea762f2..f9112b8 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -537,16 +537,6 @@ static struct platform_device *bast_devices[] __initdata = {
 	&bast_sio,
 };
 
-#ifdef CONFIG_SAMSUNG_CLK
-static struct clk *bast_clocks[] __initdata = {
-	&s3c24xx_dclk0,
-	&s3c24xx_dclk1,
-	&s3c24xx_clkout0,
-	&s3c24xx_clkout1,
-	&s3c24xx_uclk,
-};
-#endif
-
 static struct s3c_cpufreq_board __initdata bast_cpufreq = {
 	.refresh	= 7800, /* 7.8usec */
 	.auto_io	= 1,
@@ -560,23 +550,6 @@ static struct s3c24xx_audio_simtec_pdata __initdata bast_audio = {
 
 static void __init bast_map_io(void)
 {
-#ifdef CONFIG_SAMSUNG_CLOCK
-	/* initialise the clocks */
-
-	s3c24xx_dclk0.parent = &clk_upll;
-	s3c24xx_dclk0.rate   = 12*1000*1000;
-
-	s3c24xx_dclk1.parent = &clk_upll;
-	s3c24xx_dclk1.rate   = 24*1000*1000;
-
-	s3c24xx_clkout0.parent  = &s3c24xx_dclk0;
-	s3c24xx_clkout1.parent  = &s3c24xx_dclk1;
-
-	s3c24xx_uclk.parent  = &s3c24xx_clkout1;
-
-	s3c24xx_register_clocks(bast_clocks, ARRAY_SIZE(bast_clocks));
-#endif
-
 	s3c_hwmon_set_platdata(&bast_hwmon_info);
 
 	s3c24xx_init_io(bast_iodesc, ARRAY_SIZE(bast_iodesc));
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 3bc2c9b..189147b 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -350,16 +350,6 @@ static struct platform_device *osiris_devices[] __initdata = {
 	&osiris_pcmcia,
 };
 
-#ifdef CONFIG_SAMSUNG_CLOCK
-static struct clk *osiris_clocks[] __initdata = {
-	&s3c24xx_dclk0,
-	&s3c24xx_dclk1,
-	&s3c24xx_clkout0,
-	&s3c24xx_clkout1,
-	&s3c24xx_uclk,
-};
-#endif
-
 static struct s3c_cpufreq_board __initdata osiris_cpufreq = {
 	.refresh	= 7800, /* refresh period is 7.8usec */
 	.auto_io	= 1,
@@ -370,23 +360,6 @@ static void __init osiris_map_io(void)
 {
 	unsigned long flags;
 
-#ifdef CONFIG_SAMSUNG_CLOCK
-	/* initialise the clocks */
-
-	s3c24xx_dclk0.parent = &clk_upll;
-	s3c24xx_dclk0.rate   = 12*1000*1000;
-
-	s3c24xx_dclk1.parent = &clk_upll;
-	s3c24xx_dclk1.rate   = 24*1000*1000;
-
-	s3c24xx_clkout0.parent  = &s3c24xx_dclk0;
-	s3c24xx_clkout1.parent  = &s3c24xx_dclk1;
-
-	s3c24xx_uclk.parent  = &s3c24xx_clkout1;
-
-	s3c24xx_register_clocks(osiris_clocks, ARRAY_SIZE(osiris_clocks));
-#endif
-
 	s3c24xx_init_io(osiris_iodesc, ARRAY_SIZE(osiris_iodesc));
 	s3c24xx_init_uarts(osiris_uartcfgs, ARRAY_SIZE(osiris_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 5f37f52..e2c6541 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -728,22 +728,8 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&rx1950_leds,
 };
 
-#ifdef CONFIG_SAMSUNG_CLOCK
-static struct clk *rx1950_clocks[] __initdata = {
-	&s3c24xx_clkout0,
-	&s3c24xx_clkout1,
-};
-#endif
-
 static void __init rx1950_map_io(void)
 {
-#ifdef CONFIG_SAMSUNG_CLOCK
-	s3c24xx_clkout0.parent  = &clk_h;
-	s3c24xx_clkout1.parent  = &clk_f;
-
-	s3c24xx_register_clocks(rx1950_clocks, ARRAY_SIZE(rx1950_clocks));
-#endif
-
 	s3c24xx_init_io(rx1950_iodesc, ARRAY_SIZE(rx1950_iodesc));
 	s3c24xx_init_uarts(rx1950_uartcfgs, ARRAY_SIZE(rx1950_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 5f588bf..f88c584 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -299,16 +299,6 @@ static struct platform_device *vr1000_devices[] __initdata = {
 	&vr1000_led3,
 };
 
-#ifdef CONFIG_SAMSUNG_CLOCK
-static struct clk *vr1000_clocks[] __initdata = {
-	&s3c24xx_dclk0,
-	&s3c24xx_dclk1,
-	&s3c24xx_clkout0,
-	&s3c24xx_clkout1,
-	&s3c24xx_uclk,
-};
-#endif
-
 static void vr1000_power_off(void)
 {
 	gpio_direction_output(S3C2410_GPB(9), 1);
@@ -316,23 +306,6 @@ static void vr1000_power_off(void)
 
 static void __init vr1000_map_io(void)
 {
-#if CONFIG_SAMSUNG_CLOCK
-	/* initialise clock sources */
-
-	s3c24xx_dclk0.parent = &clk_upll;
-	s3c24xx_dclk0.rate   = 12*1000*1000;
-
-	s3c24xx_dclk1.parent = NULL;
-	s3c24xx_dclk1.rate   = 3692307;
-
-	s3c24xx_clkout0.parent  = &s3c24xx_dclk0;
-	s3c24xx_clkout1.parent  = &s3c24xx_dclk1;
-
-	s3c24xx_uclk.parent  = &s3c24xx_clkout1;
-
-	s3c24xx_register_clocks(vr1000_clocks, ARRAY_SIZE(vr1000_clocks));
-#endif
-
 	pm_power_off = vr1000_power_off;
 
 	s3c24xx_init_io(vr1000_iodesc, ARRAY_SIZE(vr1000_iodesc));
diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c24xx/pm.c
index 3d8cf30..b19256e 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c24xx/pm.c
@@ -66,18 +66,6 @@ static struct sleep_save core_save[] = {
 	SAVE_ITEM(S3C2410_BANKCON3),
 	SAVE_ITEM(S3C2410_BANKCON4),
 	SAVE_ITEM(S3C2410_BANKCON5),
-
-#ifdef CONFIG_SAMSUNG_CLOCK
-	SAVE_ITEM(S3C2410_LOCKTIME),
-	SAVE_ITEM(S3C2410_CLKCON),
-#ifndef CONFIG_CPU_FREQ
-	SAVE_ITEM(S3C2410_CLKDIVN),
-	SAVE_ITEM(S3C2410_MPLLCON),
-	SAVE_ITEM(S3C2410_REFRESH),
-#endif
-	SAVE_ITEM(S3C2410_UPLLCON),
-	SAVE_ITEM(S3C2410_CLKSLOW),
-#endif /* CONFIG_SAMSUNG_CLOCK */
 };
 
 /* s3c_pm_check_resume_pin
-- 
1.9.0
