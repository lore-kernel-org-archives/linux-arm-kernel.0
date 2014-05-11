From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 May 2014 00:10:24 +0200
Subject: [PATCH v3 7/9] ARM: S3C24XX: convert s3c2440 and s3c2442 to common
 clock framework
In-Reply-To: <3427359.fjFAW0MSIR@phil>
References: <3427359.fjFAW0MSIR@phil>
Message-ID: <2401749.09O7ybXGvD@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all machines using these cpus to use the ccf clock driver
instead of the legacy Samsung clock implementation.

Some of the more esotheric machines will probably need a fixup, as they
do strange things to the clkout outputs, that I did not really understand
nor have the hardware to check.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig          |  8 ++++----
 arch/arm/mach-s3c24xx/Makefile         |  4 ++--
 arch/arm/mach-s3c24xx/common.c         |  4 ----
 arch/arm/mach-s3c24xx/mach-anubis.c    | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-at2440evb.c | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-gta02.c     |  8 ++++++--
 arch/arm/mach-s3c24xx/mach-mini2440.c  | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-nexcoder.c  | 15 ++++++++++++---
 arch/arm/mach-s3c24xx/mach-osiris.c    | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-rx1950.c    | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-rx3715.c    | 10 +++++++---
 arch/arm/mach-s3c24xx/mach-smdk2440.c  | 10 +++++++---
 12 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 5c9cffd..ddd6574 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -73,10 +73,10 @@ config CPU_S3C2416
 
 config CPU_S3C2440
 	bool "SAMSUNG S3C2440"
-	depends on SAMSUNG_CLOCK
+	select COMMON_CLK
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
-	select S3C2410_CLOCK
+	select S3C2410_COMMON_CLK
 	select S3C2410_PM if PM
 	select S3C2440_DMA if S3C24XX_DMA
 	help
@@ -84,10 +84,10 @@ config CPU_S3C2440
 
 config CPU_S3C2442
 	bool "SAMSUNG S3C2442"
-	depends on SAMSUNG_CLOCK
+	select COMMON_CLK
 	select CPU_ARM920T
 	select CPU_LLSERIAL_S3C2440
-	select S3C2410_CLOCK
+	select S3C2410_COMMON_CLK
 	select S3C2410_DMA if S3C24XX_DMA
 	select S3C2410_PM if PM
 	help
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index f254797..9010eba 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -29,9 +29,9 @@ obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
 obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o
 obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
 
-obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o clock-s3c2440.o
+obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o
 obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
-obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o clock-s3c244x.o
+obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o
 obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
 obj-$(CONFIG_S3C2440_PLL_12000000) += pll-s3c2440-12000000.o
 obj-$(CONFIG_S3C2440_PLL_16934400) += pll-s3c2440-16934400.o
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 35cf88e..bda9dd4 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -92,7 +92,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= 0x32440000,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2440_map_io,
-		.init_clocks	= s3c244x_init_clocks,
 		.init_uarts	= s3c244x_init_uarts,
 		.init		= s3c2440_init,
 		.name		= name_s3c2440
@@ -101,7 +100,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= 0x32440001,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2440_map_io,
-		.init_clocks	= s3c244x_init_clocks,
 		.init_uarts	= s3c244x_init_uarts,
 		.init		= s3c2440_init,
 		.name		= name_s3c2440a
@@ -110,7 +108,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= 0x32440aaa,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2442_map_io,
-		.init_clocks	= s3c244x_init_clocks,
 		.init_uarts	= s3c244x_init_uarts,
 		.init		= s3c2442_init,
 		.name		= name_s3c2442
@@ -119,7 +116,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= 0x32440aab,
 		.idmask		= 0xffffffff,
 		.map_io		= s3c2442_map_io,
-		.init_clocks	= s3c244x_init_clocks,
 		.init_uarts	= s3c244x_init_uarts,
 		.init		= s3c2442_init,
 		.name		= name_s3c2442b
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index f81944f..7a0d83b 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -46,7 +46,6 @@
 
 #include <net/ax88796.h>
 
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
@@ -415,7 +414,6 @@ static void __init anubis_map_io(void)
 #endif
 
 	s3c24xx_init_io(anubis_iodesc, ARRAY_SIZE(anubis_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(anubis_uartcfgs, ARRAY_SIZE(anubis_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
@@ -433,6 +431,12 @@ static void __init anubis_map_io(void)
 	}
 }
 
+static void __init anubis_init_time(void)
+{
+	s3c2440_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init anubis_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -452,6 +456,6 @@ MACHINE_START(ANUBIS, "Simtec-Anubis")
 	.map_io		= anubis_map_io,
 	.init_machine	= anubis_init,
 	.init_irq	= s3c2440_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= anubis_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index d8f6bb1..9db768f 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -45,7 +45,6 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/mmc-s3cmci.h>
@@ -192,11 +191,16 @@ static struct platform_device *at2440evb_devices[] __initdata = {
 static void __init at2440evb_map_io(void)
 {
 	s3c24xx_init_io(at2440evb_iodesc, ARRAY_SIZE(at2440evb_iodesc));
-	s3c24xx_init_clocks(16934400);
 	s3c24xx_init_uarts(at2440evb_uartcfgs, ARRAY_SIZE(at2440evb_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init at2440evb_init_time(void)
+{
+	s3c2440_init_clocks(16934400);
+	samsung_timer_init();
+}
+
 static void __init at2440evb_init(void)
 {
 	s3c24xx_fb_set_platdata(&at2440evb_fb_info);
@@ -213,6 +217,6 @@ MACHINE_START(AT2440EVB, "AT2440EVB")
 	.map_io		= at2440evb_map_io,
 	.init_machine	= at2440evb_init,
 	.init_irq	= s3c2440_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= at2440evb_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index dc4db84..fc3a08d 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -501,7 +501,6 @@ static struct platform_device gta02_buttons_device = {
 static void __init gta02_map_io(void)
 {
 	s3c24xx_init_io(gta02_iodesc, ARRAY_SIZE(gta02_iodesc));
-	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(gta02_uartcfgs, ARRAY_SIZE(gta02_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
@@ -585,6 +584,11 @@ static void __init gta02_machine_init(void)
 	regulator_has_full_constraints();
 }
 
+static void __init gta02_init_time(void)
+{
+	s3c2442_init_clocks(12000000);
+	samsung_timer_init();
+}
 
 MACHINE_START(NEO1973_GTA02, "GTA02")
 	/* Maintainer: Nelson Castillo <arhuaco@freaks-unidos.net> */
@@ -592,6 +596,6 @@ MACHINE_START(NEO1973_GTA02, "GTA02")
 	.map_io		= gta02_map_io,
 	.init_irq	= s3c2442_init_irq,
 	.init_machine	= gta02_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= gta02_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 9e57fd9..5cc40ec 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -54,7 +54,6 @@
 #include <linux/mtd/partitions.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/samsung-time.h>
@@ -525,11 +524,16 @@ static struct platform_device *mini2440_devices[] __initdata = {
 static void __init mini2440_map_io(void)
 {
 	s3c24xx_init_io(mini2440_iodesc, ARRAY_SIZE(mini2440_iodesc));
-	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(mini2440_uartcfgs, ARRAY_SIZE(mini2440_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init mini2440_init_time(void)
+{
+	s3c2440_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 /*
  * mini2440_features string
  *
@@ -690,6 +694,6 @@ MACHINE_START(MINI2440, "MINI2440")
 	.map_io		= mini2440_map_io,
 	.init_machine	= mini2440_init,
 	.init_irq	= s3c2440_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= mini2440_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 3066851..05627c2 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -42,7 +42,6 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/samsung-time.h>
@@ -135,13 +134,23 @@ static void __init nexcoder_sensorboard_init(void)
 static void __init nexcoder_map_io(void)
 {
 	s3c24xx_init_io(nexcoder_iodesc, ARRAY_SIZE(nexcoder_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(nexcoder_uartcfgs, ARRAY_SIZE(nexcoder_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
 	nexcoder_sensorboard_init();
 }
 
+static void __init nexcoder_init_time(void)
+{
+	/*
+	 * for whatever reason the nexcoder called s3c24xx_init_clocks(0)
+	 * meaning a xti value of 0Hz, so this machine will most likely
+	 * not work out of the box and needs a fixup.
+	 */
+	s3c2440_init_clocks(0);
+	samsung_timer_init();
+}
+
 static void __init nexcoder_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
@@ -154,6 +163,6 @@ MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	.map_io		= nexcoder_map_io,
 	.init_machine	= nexcoder_init,
 	.init_irq	= s3c2440_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= nexcoder_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 487be02..3bc2c9b 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -40,7 +40,6 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/cpu-freq.h>
 #include <plat/devs.h>
@@ -389,7 +388,6 @@ static void __init osiris_map_io(void)
 #endif
 
 	s3c24xx_init_io(osiris_iodesc, ARRAY_SIZE(osiris_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(osiris_uartcfgs, ARRAY_SIZE(osiris_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
@@ -413,6 +411,12 @@ static void __init osiris_map_io(void)
 	local_irq_restore(flags);
 }
 
+static void __init osiris_init_time(void)
+{
+	s3c2440_init_clocks(12000000);
+	samsung_timer_init();
+}
+
 static void __init osiris_init(void)
 {
 	register_syscore_ops(&osiris_pm_syscore_ops);
@@ -434,6 +438,6 @@ MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	.map_io		= osiris_map_io,
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= osiris_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= osiris_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 219454c..5f37f52 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -54,7 +54,6 @@
 #include <mach/regs-lcd.h>
 #include <mach/gpio-samsung.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
@@ -746,7 +745,6 @@ static void __init rx1950_map_io(void)
 #endif
 
 	s3c24xx_init_io(rx1950_iodesc, ARRAY_SIZE(rx1950_iodesc));
-	s3c24xx_init_clocks(16934000);
 	s3c24xx_init_uarts(rx1950_uartcfgs, ARRAY_SIZE(rx1950_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
@@ -759,6 +757,12 @@ static void __init rx1950_map_io(void)
 	s3c_pm_init();
 }
 
+static void __init rx1950_init_time(void)
+{
+	s3c2442_init_clocks(16934000);
+	samsung_timer_init();
+}
+
 static void __init rx1950_init_machine(void)
 {
 	int i;
@@ -821,6 +825,6 @@ MACHINE_START(RX1950, "HP iPAQ RX1950")
 	.reserve	= rx1950_reserve,
 	.init_irq	= s3c2442_init_irq,
 	.init_machine = rx1950_init_machine,
-	.init_time	= samsung_timer_init,
+	.init_time	= rx1950_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index e6535ce..6e749ec 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -46,7 +46,6 @@
 #include <mach/regs-lcd.h>
 #include <mach/gpio-samsung.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
@@ -179,11 +178,16 @@ static struct platform_device *rx3715_devices[] __initdata = {
 static void __init rx3715_map_io(void)
 {
 	s3c24xx_init_io(rx3715_iodesc, ARRAY_SIZE(rx3715_iodesc));
-	s3c24xx_init_clocks(16934000);
 	s3c24xx_init_uarts(rx3715_uartcfgs, ARRAY_SIZE(rx3715_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init rx3715_init_time(void)
+{
+	s3c2440_init_clocks(16934000);
+	samsung_timer_init();
+}
+
 /* H1940 and RX3715 need to reserve this for suspend */
 static void __init rx3715_reserve(void)
 {
@@ -210,6 +214,6 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
 	.reserve	= rx3715_reserve,
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= rx3715_init_machine,
-	.init_time	= samsung_timer_init,
+	.init_time	= rx3715_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index d071dcf..5fb89c0 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -38,7 +38,6 @@
 #include <mach/fb.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/samsung-time.h>
@@ -159,11 +158,16 @@ static struct platform_device *smdk2440_devices[] __initdata = {
 static void __init smdk2440_map_io(void)
 {
 	s3c24xx_init_io(smdk2440_iodesc, ARRAY_SIZE(smdk2440_iodesc));
-	s3c24xx_init_clocks(16934400);
 	s3c24xx_init_uarts(smdk2440_uartcfgs, ARRAY_SIZE(smdk2440_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
 
+static void __init smdk2440_init_time(void)
+{
+	s3c2440_init_clocks(16934400);
+	samsung_timer_init();
+}
+
 static void __init smdk2440_machine_init(void)
 {
 	s3c24xx_fb_set_platdata(&smdk2440_fb_info);
@@ -180,6 +184,6 @@ MACHINE_START(S3C2440, "SMDK2440")
 	.init_irq	= s3c2440_init_irq,
 	.map_io		= smdk2440_map_io,
 	.init_machine	= smdk2440_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= smdk2440_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
-- 
1.9.0
