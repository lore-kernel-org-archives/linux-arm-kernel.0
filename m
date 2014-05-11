From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 May 2014 00:06:58 +0200
Subject: [PATCH v3 3/9] ARM: S3C24XX: enable usage of common dclk if common
 clock framework is enabled
In-Reply-To: <3427359.fjFAW0MSIR@phil>
References: <3427359.fjFAW0MSIR@phil>
Message-ID: <5267332.6suYJ7Ld43@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform device and select the correct implementation automatically
depending on wether the old samsung_clock or the common clock framework
is enabled.

This is only done for machines already using the old dclk implementation,
as everybody else should move to use dt anyway.

The machine-specific settings for the external clocks will have to be set
by somebody with knowledge about the specific hardware.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig       | 22 +++++++++++++++++-----
 arch/arm/mach-s3c24xx/common.c      | 14 ++++++++++++++
 arch/arm/mach-s3c24xx/common.h      |  2 ++
 arch/arm/mach-s3c24xx/mach-anubis.c |  5 +++++
 arch/arm/mach-s3c24xx/mach-bast.c   |  5 +++++
 arch/arm/mach-s3c24xx/mach-osiris.c |  5 +++++
 arch/arm/mach-s3c24xx/mach-rx1950.c |  5 +++++
 arch/arm/mach-s3c24xx/mach-vr1000.c |  5 +++++
 arch/arm/mach-s3c24xx/s3c244x.c     |  2 ++
 9 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index fbafb9a..b4c055b 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -18,6 +18,13 @@ config PLAT_S3C24XX
 	help
 	  Base platform code for any Samsung S3C24XX device
 
+config S3C2410_COMMON_DCLK
+	bool
+	select REGMAP_MMIO
+	help
+	  Temporary symbol to build the dclk driver based on the common clock
+	  framework.
+
 menu "SAMSUNG S3C24XX SoCs Support"
 
 comment "S3C24XX SoCs"
@@ -264,7 +271,8 @@ config ARCH_BAST
 	select ISA
 	select MACH_BAST_IDE
 	select S3C2410_IOTIMING if ARM_S3C2410_CPUFREQ
-	select S3C24XX_DCLK
+	select S3C24XX_DCLK if SAMSUNG_CLOCK
+	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_SIMTEC_NOR
 	select S3C24XX_SIMTEC_PM if PM
 	select S3C24XX_SIMTEC_USB
@@ -345,7 +353,8 @@ config MACH_TCT_HAMMER
 config MACH_VR1000
 	bool "Thorcom VR1000"
 	select MACH_BAST_IDE
-	select S3C24XX_DCLK
+	select S3C24XX_DCLK if SAMSUNG_CLOCK
+	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_SIMTEC_NOR
 	select S3C24XX_SIMTEC_PM if PM
 	select S3C24XX_SIMTEC_USB
@@ -530,7 +539,8 @@ config MACH_ANUBIS
 	bool "Simtec Electronics ANUBIS"
 	select HAVE_PATA_PLATFORM
 	select S3C2440_XTAL_12000000
-	select S3C24XX_DCLK
+	select S3C24XX_DCLK if SAMSUNG_CLOCK
+	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_SIMTEC_PM if PM
 	select S3C_DEV_USB_HOST
 	help
@@ -570,7 +580,8 @@ config MACH_OSIRIS
 	bool "Simtec IM2440D20 (OSIRIS) module"
 	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 	select S3C2440_XTAL_12000000
-	select S3C24XX_DCLK
+	select S3C24XX_DCLK if SAMSUNG_CLOCK
+	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_SIMTEC_PM if PM
 	select S3C_DEV_NAND
 	select S3C_DEV_USB_HOST
@@ -641,7 +652,8 @@ config MACH_RX1950
 	select PM_H1940 if PM
 	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
 	select S3C2440_XTAL_16934400
-	select S3C24XX_DCLK
+	select S3C24XX_DCLK if SAMSUNG_CLOCK
+	select S3C2410_COMMON_DCLK if COMMON_CLK
 	select S3C24XX_PWM
 	select S3C_DEV_NAND
 	help
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index ad5b76b..7cc6d94 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -553,3 +553,17 @@ void __init s3c2443_init_clocks(int xtal)
 	s3c2443_common_clk_init(NULL, xtal, 1, S3C24XX_VA_CLKPWR);
 }
 #endif
+
+#if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2440) || \
+	defined(CONFIG_CPU_S3C2442)
+static struct resource s3c2410_dclk_resource[] = {
+	[0] = DEFINE_RES_MEM(0x56000084, 0x4),
+};
+
+struct platform_device s3c2410_device_dclk = {
+	.name		= "s3c2410-dclk",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c2410_dclk_resource),
+	.resource	= s3c2410_dclk_resource,
+};
+#endif
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 3fade6d..50504c7 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -114,6 +114,8 @@ extern struct platform_device s3c2412_device_dma;
 extern struct platform_device s3c2440_device_dma;
 extern struct platform_device s3c2443_device_dma;
 
+extern struct platform_device s3c2410_device_dclk;
+
 #ifdef CONFIG_S3C2412_COMMON_CLK
 void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 				unsigned long ext_f, void __iomem *reg_base);
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index 81a270a..f81944f 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -352,6 +352,7 @@ static struct platform_device anubis_device_sm501 = {
 /* Standard Anubis devices */
 
 static struct platform_device *anubis_devices[] __initdata = {
+	&s3c2410_device_dclk,
 	&s3c_device_ohci,
 	&s3c_device_wdt,
 	&s3c_device_adc,
@@ -364,6 +365,7 @@ static struct platform_device *anubis_devices[] __initdata = {
 	&anubis_device_sm501,
 };
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 static struct clk *anubis_clocks[] __initdata = {
 	&s3c24xx_dclk0,
 	&s3c24xx_dclk1,
@@ -371,6 +373,7 @@ static struct clk *anubis_clocks[] __initdata = {
 	&s3c24xx_clkout1,
 	&s3c24xx_uclk,
 };
+#endif
 
 /* I2C devices. */
 
@@ -394,6 +397,7 @@ static struct s3c24xx_audio_simtec_pdata __initdata anubis_audio = {
 
 static void __init anubis_map_io(void)
 {
+#ifdef CONFIG_SAMSUNG_CLOCK
 	/* initialise the clocks */
 
 	s3c24xx_dclk0.parent = &clk_upll;
@@ -408,6 +412,7 @@ static void __init anubis_map_io(void)
 	s3c24xx_uclk.parent  = &s3c24xx_clkout1;
 
 	s3c24xx_register_clocks(anubis_clocks, ARRAY_SIZE(anubis_clocks));
+#endif
 
 	s3c24xx_init_io(anubis_iodesc, ARRAY_SIZE(anubis_iodesc));
 	s3c24xx_init_clocks(0);
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index e371ff5..dcdc4a5 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -523,6 +523,7 @@ static struct s3c_hwmon_pdata bast_hwmon_info = {
 // cat /sys/devices/platform/s3c24xx-adc/s3c-hwmon/in_0
 
 static struct platform_device *bast_devices[] __initdata = {
+	&s3c2410_device_dclk,
 	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
@@ -537,6 +538,7 @@ static struct platform_device *bast_devices[] __initdata = {
 	&bast_sio,
 };
 
+#ifdef CONFIG_SAMSUNG_CLK
 static struct clk *bast_clocks[] __initdata = {
 	&s3c24xx_dclk0,
 	&s3c24xx_dclk1,
@@ -544,6 +546,7 @@ static struct clk *bast_clocks[] __initdata = {
 	&s3c24xx_clkout1,
 	&s3c24xx_uclk,
 };
+#endif
 
 static struct s3c_cpufreq_board __initdata bast_cpufreq = {
 	.refresh	= 7800, /* 7.8usec */
@@ -558,6 +561,7 @@ static struct s3c24xx_audio_simtec_pdata __initdata bast_audio = {
 
 static void __init bast_map_io(void)
 {
+#ifdef CONFIG_SAMSUNG_CLOCK
 	/* initialise the clocks */
 
 	s3c24xx_dclk0.parent = &clk_upll;
@@ -572,6 +576,7 @@ static void __init bast_map_io(void)
 	s3c24xx_uclk.parent  = &s3c24xx_clkout1;
 
 	s3c24xx_register_clocks(bast_clocks, ARRAY_SIZE(bast_clocks));
+#endif
 
 	s3c_hwmon_set_platdata(&bast_hwmon_info);
 
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index a4ae4bb..487be02 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -344,12 +344,14 @@ static struct i2c_board_info osiris_i2c_devs[] __initdata = {
 /* Standard Osiris devices */
 
 static struct platform_device *osiris_devices[] __initdata = {
+	&s3c2410_device_dclk,
 	&s3c_device_i2c0,
 	&s3c_device_wdt,
 	&s3c_device_nand,
 	&osiris_pcmcia,
 };
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 static struct clk *osiris_clocks[] __initdata = {
 	&s3c24xx_dclk0,
 	&s3c24xx_dclk1,
@@ -357,6 +359,7 @@ static struct clk *osiris_clocks[] __initdata = {
 	&s3c24xx_clkout1,
 	&s3c24xx_uclk,
 };
+#endif
 
 static struct s3c_cpufreq_board __initdata osiris_cpufreq = {
 	.refresh	= 7800, /* refresh period is 7.8usec */
@@ -368,6 +371,7 @@ static void __init osiris_map_io(void)
 {
 	unsigned long flags;
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 	/* initialise the clocks */
 
 	s3c24xx_dclk0.parent = &clk_upll;
@@ -382,6 +386,7 @@ static void __init osiris_map_io(void)
 	s3c24xx_uclk.parent  = &s3c24xx_clkout1;
 
 	s3c24xx_register_clocks(osiris_clocks, ARRAY_SIZE(osiris_clocks));
+#endif
 
 	s3c24xx_init_io(osiris_iodesc, ARRAY_SIZE(osiris_iodesc));
 	s3c24xx_init_clocks(0);
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index afb784e..219454c 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -710,6 +710,7 @@ static struct i2c_board_info rx1950_i2c_devices[] = {
 };
 
 static struct platform_device *rx1950_devices[] __initdata = {
+	&s3c2410_device_dclk,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c0,
@@ -728,17 +729,21 @@ static struct platform_device *rx1950_devices[] __initdata = {
 	&rx1950_leds,
 };
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 static struct clk *rx1950_clocks[] __initdata = {
 	&s3c24xx_clkout0,
 	&s3c24xx_clkout1,
 };
+#endif
 
 static void __init rx1950_map_io(void)
 {
+#ifdef CONFIG_SAMSUNG_CLOCK
 	s3c24xx_clkout0.parent  = &clk_h;
 	s3c24xx_clkout1.parent  = &clk_f;
 
 	s3c24xx_register_clocks(rx1950_clocks, ARRAY_SIZE(rx1950_clocks));
+#endif
 
 	s3c24xx_init_io(rx1950_iodesc, ARRAY_SIZE(rx1950_iodesc));
 	s3c24xx_init_clocks(16934000);
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 1cc5b1b..bedaeef 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -286,6 +286,7 @@ static struct i2c_board_info vr1000_i2c_devs[] __initdata = {
 /* devices for this board */
 
 static struct platform_device *vr1000_devices[] __initdata = {
+	&s3c2410_device_dclk,
 	&s3c_device_ohci,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
@@ -299,6 +300,7 @@ static struct platform_device *vr1000_devices[] __initdata = {
 	&vr1000_led3,
 };
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 static struct clk *vr1000_clocks[] __initdata = {
 	&s3c24xx_dclk0,
 	&s3c24xx_dclk1,
@@ -306,6 +308,7 @@ static struct clk *vr1000_clocks[] __initdata = {
 	&s3c24xx_clkout1,
 	&s3c24xx_uclk,
 };
+#endif
 
 static void vr1000_power_off(void)
 {
@@ -314,6 +317,7 @@ static void vr1000_power_off(void)
 
 static void __init vr1000_map_io(void)
 {
+#if CONFIG_SAMSUNG_CLOCK
 	/* initialise clock sources */
 
 	s3c24xx_dclk0.parent = &clk_upll;
@@ -328,6 +332,7 @@ static void __init vr1000_map_io(void)
 	s3c24xx_uclk.parent  = &s3c24xx_clkout1;
 
 	s3c24xx_register_clocks(vr1000_clocks, ARRAY_SIZE(vr1000_clocks));
+#endif
 
 	pm_power_off = vr1000_power_off;
 
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index fe30ebb2..76b691b 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -46,6 +46,7 @@
 #include <plat/nand-core.h>
 #include <plat/watchdog-reset.h>
 
+#include "common.h"
 #include "regs-dsc.h"
 
 static struct map_desc s3c244x_iodesc[] __initdata = {
@@ -74,6 +75,7 @@ void __init s3c244x_map_io(void)
 	s3c_nand_setname("s3c2440-nand");
 	s3c_device_ts.name = "s3c2440-ts";
 	s3c_device_usbgadget.name = "s3c2440-usbgadget";
+	s3c2410_device_dclk.name = "s3c2440-dclk";
 }
 
 void __init_or_cpufreq s3c244x_setup_clocks(void)
-- 
1.9.0
