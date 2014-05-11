From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 May 2014 00:10:55 +0200
Subject: [PATCH v3 8/9] ARM: S3C24XX: convert s3c2410 to common clock framework
In-Reply-To: <3427359.fjFAW0MSIR@phil>
References: <3427359.fjFAW0MSIR@phil>
Message-ID: <1813339.UpKLx2elXI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the machines using the s3c2410 to use the new driver based
on the common clock framework instead of the legacy Samsung clock driver.

As with the s3c244x, machines using the clkout output will need a fixup
from someone with the hardware.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig           |  4 ++--
 arch/arm/mach-s3c24xx/common.c          |  2 --
 arch/arm/mach-s3c24xx/mach-amlm5900.c   |  9 +++++++--
 arch/arm/mach-s3c24xx/mach-bast.c       | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-h1940.c      | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-n30.c        | 12 ++++++++----
 arch/arm/mach-s3c24xx/mach-nexcoder.c   |  7 +------
 arch/arm/mach-s3c24xx/mach-otom.c       | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-qt2410.c     |  9 +++++++--
 arch/arm/mach-s3c24xx/mach-smdk2410.c   |  9 +++++++--
 arch/arm/mach-s3c24xx/mach-tct_hammer.c |  9 +++++++--
 arch/arm/mach-s3c24xx/mach-vr1000.c     | 10 +++++++---
 12 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index ddd6574..82602dc 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -37,10 +37,10 @@ comment "S3C24XX SoCs"
 config CPU_S3C2410
 	bool "SAMSUNG S3C2410"
 	default y
-	depends on SAMSUNG_CLOCK
+	select COMMON_CLK
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2410
-	select S3C2410_CLOCK
+	select S3C2410_COMMON_CLK
 	select S3C2410_DMA if S3C24XX_DMA
 	select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
 	select S3C2410_PM if PM
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index bda9dd4..600a1be 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -74,7 +74,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= 0x32410000,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2410_map_io,
-		.init_clocks	= s3c2410_init_clocks,
 		.init_uarts	= s3c2410_init_uarts,
 		.init		= s3c2410_init,
 		.name		= name_s3c2410
@@ -83,7 +82,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= 0x32410002,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2410_map_io,
-		.init_clocks	= s3c2410_init_clocks,
 		.init_uarts	= s3c2410_init_uarts,
 		.init		= s3c2410a_init,
 		.name		= name_s3c2410a
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index 8ac9554..5157e25 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -161,11 +161,16 @@ static struct platform_device *amlm5900_devices[] __initdata = {
 static void __init amlm5900_map_io(void)
 {
 	s3c24xx_init_io(amlm5900_iodesc, ARRAY_SIZE(amlm5900_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(amlm5900_uartcfgs, ARRAY_SIZE(amlm5900_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init amlm5900_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 #ifdef CONFIG_FB_S3C2410
 static struct s3c2410fb_display __initdata amlm5900_lcd_info = {
 	.width		= 160,
@@ -241,6 +246,6 @@ MACHINE_START(AML_M5900, "AML_M5900")
 	.map_io		= amlm5900_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= amlm5900_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= amlm5900_init_time,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index dcdc4a5..ea762f2 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -51,7 +51,6 @@
 #include <mach/regs-lcd.h>
 #include <mach/gpio-samsung.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/cpu-freq.h>
 #include <plat/devs.h>
@@ -581,11 +580,16 @@ static void __init bast_map_io(void)
 	s3c_hwmon_set_platdata(&bast_hwmon_info);
 
 	s3c24xx_init_io(bast_iodesc, ARRAY_SIZE(bast_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(bast_uartcfgs, ARRAY_SIZE(bast_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init bast_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init bast_init(void)
 {
 	register_syscore_ops(&bast_pm_syscore_ops);
@@ -613,6 +617,6 @@ MACHINE_START(BAST, "Simtec-BAST")
 	.map_io		= bast_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= bast_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= bast_init_time,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index e453acd..fbf5487 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -57,7 +57,6 @@
 #include <mach/regs-lcd.h>
 #include <mach/gpio-samsung.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
@@ -646,7 +645,6 @@ static struct platform_device *h1940_devices[] __initdata = {
 static void __init h1940_map_io(void)
 {
 	s3c24xx_init_io(h1940_iodesc, ARRAY_SIZE(h1940_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(h1940_uartcfgs, ARRAY_SIZE(h1940_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
@@ -662,6 +660,12 @@ static void __init h1940_map_io(void)
 	WARN_ON(gpiochip_add(&h1940_latch_gpiochip));
 }
 
+static void __init h1940_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 /* H1940 and RX3715 need to reserve this for suspend */
 static void __init h1940_reserve(void)
 {
@@ -739,6 +743,6 @@ MACHINE_START(H1940, "IPAQ-H1940")
 	.reserve	= h1940_reserve,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= h1940_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= h1940_init_time,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 4cccaad..3ac2a54 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -45,7 +45,6 @@
 
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <linux/platform_data/mmc-s3cmci.h>
@@ -535,11 +534,16 @@ static void __init n30_map_io(void)
 {
 	s3c24xx_init_io(n30_iodesc, ARRAY_SIZE(n30_iodesc));
 	n30_hwinit();
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(n30_uartcfgs, ARRAY_SIZE(n30_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init n30_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 /* GPB3 is the line that controls the pull-up for the USB D+ line */
 
 static void __init n30_init(void)
@@ -591,7 +595,7 @@ MACHINE_START(N30, "Acer-N30")
 				Ben Dooks <ben-linux@fluff.org>
 	*/
 	.atag_offset	= 0x100,
-	.init_time	= samsung_timer_init,
+	.init_time	= n30_init_time,
 	.init_machine	= n30_init,
 	.init_irq	= s3c2410_init_irq,
 	.map_io		= n30_map_io,
@@ -602,7 +606,7 @@ MACHINE_START(N35, "Acer-N35")
 	/* Maintainer: Christer Weinigel <christer@weinigel.se>
 	*/
 	.atag_offset	= 0x100,
-	.init_time	= samsung_timer_init,
+	.init_time	= n30_init_time,
 	.init_machine	= n30_init,
 	.init_irq	= s3c2410_init_irq,
 	.map_io		= n30_map_io,
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 05627c2..c82c281 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -142,12 +142,7 @@ static void __init nexcoder_map_io(void)
 
 static void __init nexcoder_init_time(void)
 {
-	/*
-	 * for whatever reason the nexcoder called s3c24xx_init_clocks(0)
-	 * meaning a xti value of 0Hz, so this machine will most likely
-	 * not work out of the box and needs a fixup.
-	 */
-	s3c2440_init_clocks(0);
+	s3c2440_init_clocks(12000000);
 	samsung_timer_init();
 }
 
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index bdb3faa..4583300 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -30,7 +30,6 @@
 #include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/samsung-time.h>
@@ -100,11 +99,16 @@ static struct platform_device *otom11_devices[] __initdata = {
 static void __init otom11_map_io(void)
 {
 	s3c24xx_init_io(otom11_iodesc, ARRAY_SIZE(otom11_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(otom11_uartcfgs, ARRAY_SIZE(otom11_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init otom11_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init otom11_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -117,6 +121,6 @@ MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
 	.map_io		= otom11_map_io,
 	.init_machine	= otom11_init,
 	.init_irq	= s3c2410_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= otom11_init_time,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 8c12787..228c909 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -304,11 +304,16 @@ __setup("tft=", qt2410_tft_setup);
 static void __init qt2410_map_io(void)
 {
 	s3c24xx_init_io(qt2410_iodesc, ARRAY_SIZE(qt2410_iodesc));
-	s3c24xx_init_clocks(12*1000*1000);
 	s3c24xx_init_uarts(smdk2410_uartcfgs, ARRAY_SIZE(smdk2410_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init qt2410_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init qt2410_machine_init(void)
 {
 	s3c_nand_set_platdata(&qt2410_nand_info);
@@ -346,6 +351,6 @@ MACHINE_START(QT2410, "QT2410")
 	.map_io		= qt2410_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= qt2410_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= qt2410_init_time,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2410.c b/arch/arm/mach-s3c24xx/mach-smdk2410.c
index f32924e..419fadd 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2410.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2410.c
@@ -99,11 +99,16 @@ static struct platform_device *smdk2410_devices[] __initdata = {
 static void __init smdk2410_map_io(void)
 {
 	s3c24xx_init_io(smdk2410_iodesc, ARRAY_SIZE(smdk2410_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(smdk2410_uartcfgs, ARRAY_SIZE(smdk2410_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init smdk2410_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init smdk2410_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -118,6 +123,6 @@ MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switc
 	.map_io		= smdk2410_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= smdk2410_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= smdk2410_init_time,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index 4108b2f..c616ca2 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -135,11 +135,16 @@ static struct platform_device *tct_hammer_devices[] __initdata = {
 static void __init tct_hammer_map_io(void)
 {
 	s3c24xx_init_io(tct_hammer_iodesc, ARRAY_SIZE(tct_hammer_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(tct_hammer_uartcfgs, ARRAY_SIZE(tct_hammer_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init tct_hammer_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init tct_hammer_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -151,6 +156,6 @@ MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
 	.map_io		= tct_hammer_map_io,
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= tct_hammer_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= tct_hammer_init_time,
 	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index bedaeef..5f588bf 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -43,7 +43,6 @@
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/samsung-time.h>
@@ -337,11 +336,16 @@ static void __init vr1000_map_io(void)
 	pm_power_off = vr1000_power_off;
 
 	s3c24xx_init_io(vr1000_iodesc, ARRAY_SIZE(vr1000_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(vr1000_uartcfgs, ARRAY_SIZE(vr1000_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init vr1000_init_time(void)
+{
+	s3c2410_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init vr1000_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -362,6 +366,6 @@ MACHINE_START(VR1000, "Thorcom-VR1000")
 	.map_io		= vr1000_map_io,
 	.init_machine	= vr1000_init,
 	.init_irq	= s3c2410_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= vr1000_init_time,
 	.restart	= s3c2410_restart,
 MACHINE_END
-- 
1.9.0
