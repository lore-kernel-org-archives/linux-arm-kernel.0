From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 13 Dec 2013 14:02:46 +0100
Subject: [PATCH 10/12] ARM: S3C24XX: convert s3c2440 and s3c2442 to common
 clock framework
In-Reply-To: <201312131356.40755.heiko@sntech.de>
References: <201312131356.40755.heiko@sntech.de>
Message-ID: <201312131402.46554.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all machines using these cpus to use the ccf clock driver
instead of the legacy Samsung clock implementation.

Some of the more esotheric machines will probably need a fixup, as they
do strange things to the clkout outputs, that I did not really understand
nor have the hardware to check.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig          |    8 ++++----
 arch/arm/mach-s3c24xx/Makefile         |    4 ++--
 arch/arm/mach-s3c24xx/common.c         |    4 ----
 arch/arm/mach-s3c24xx/mach-anubis.c    |   10 +++++++---
 arch/arm/mach-s3c24xx/mach-at2440evb.c |   10 +++++++---
 arch/arm/mach-s3c24xx/mach-gta02.c     |    8 ++++++--
 arch/arm/mach-s3c24xx/mach-mini2440.c  |   10 +++++++---
 arch/arm/mach-s3c24xx/mach-nexcoder.c  |   15 ++++++++++++---
 arch/arm/mach-s3c24xx/mach-osiris.c    |   10 +++++++---
 arch/arm/mach-s3c24xx/mach-rx1950.c    |   10 +++++++---
 arch/arm/mach-s3c24xx/mach-rx3715.c    |   10 +++++++---
 arch/arm/mach-s3c24xx/mach-smdk2440.c  |   10 +++++++---
 12 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index 2a9a18c..c06197f 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -72,10 +72,10 @@ config CPU_S3C2416
 
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
@@ -83,10 +83,10 @@ config CPU_S3C2440
 
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
index ba0e547..720bf7a 100644
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
index 66dcb0e..cf00c4a 100644
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
index a7d1721a..e43f984 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -45,7 +45,6 @@
 
 #include <net/ax88796.h>
 
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
@@ -414,7 +413,6 @@ static void __init anubis_map_io(void)
 #endif
 
 	s3c24xx_init_io(anubis_iodesc, ARRAY_SIZE(anubis_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(anubis_uartcfgs, ARRAY_SIZE(anubis_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
@@ -432,6 +430,12 @@ static void __init anubis_map_io(void)
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
@@ -451,6 +455,6 @@ MACHINE_START(ANUBIS, "Simtec-Anubis")
 	.map_io		= anubis_map_io,
 	.init_machine	= anubis_init,
 	.init_irq	= s3c2440_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= anubis_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 6dfeeb7..f3ac0af 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -44,7 +44,6 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <linux/platform_data/mmc-s3cmci.h>
@@ -191,11 +190,16 @@ static struct platform_device *at2440evb_devices[] __initdata = {
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
@@ -212,6 +216,6 @@ MACHINE_START(AT2440EVB, "AT2440EVB")
 	.map_io		= at2440evb_map_io,
 	.init_machine	= at2440evb_init,
 	.init_irq	= s3c2440_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= at2440evb_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index 13d8d07..d8cd88c 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -500,7 +500,6 @@ static struct platform_device gta02_buttons_device = {
 static void __init gta02_map_io(void)
 {
 	s3c24xx_init_io(gta02_iodesc, ARRAY_SIZE(gta02_iodesc));
-	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(gta02_uartcfgs, ARRAY_SIZE(gta02_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 }
@@ -584,6 +583,11 @@ static void __init gta02_machine_init(void)
 	regulator_has_full_constraints();
 }
 
+static void __init gta02_init_time(void)
+{
+	s3c2442_init_clocks(12000000);
+	samsung_timer_init();
+}
 
 MACHINE_START(NEO1973_GTA02, "GTA02")
 	/* Maintainer: Nelson Castillo <arhuaco@freaks-unidos.net> */
@@ -591,6 +595,6 @@ MACHINE_START(NEO1973_GTA02, "GTA02")
 	.map_io		= gta02_map_io,
 	.init_irq	= s3c2442_init_irq,
 	.init_machine	= gta02_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= gta02_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 4a18d49..d2b38f0 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -53,7 +53,6 @@
 #include <linux/mtd/partitions.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/samsung-time.h>
@@ -524,11 +523,16 @@ static struct platform_device *mini2440_devices[] __initdata = {
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
@@ -689,6 +693,6 @@ MACHINE_START(MINI2440, "MINI2440")
 	.map_io		= mini2440_map_io,
 	.init_machine	= mini2440_init,
 	.init_irq	= s3c2440_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= mini2440_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index 01f4354..9ece48a 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -41,7 +41,6 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 
 #include <plat/gpio-cfg.h>
-#include <plat/clock.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/samsung-time.h>
@@ -134,13 +133,23 @@ static void __init nexcoder_sensorboard_init(void)
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
@@ -153,6 +162,6 @@ MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	.map_io		= nexcoder_map_io,
 	.init_machine	= nexcoder_init,
 	.init_irq	= s3c2440_init_irq,
-	.init_time	= samsung_timer_init,
+	.init_time	= nexcoder_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index d55d88d..a0d290b 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -39,7 +39,6 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/cpu-freq.h>
 #include <plat/devs.h>
@@ -388,7 +387,6 @@ static void __init osiris_map_io(void)
 #endif
 
 	s3c24xx_init_io(osiris_iodesc, ARRAY_SIZE(osiris_iodesc));
-	s3c24xx_init_clocks(0);
 	s3c24xx_init_uarts(osiris_uartcfgs, ARRAY_SIZE(osiris_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
@@ -412,6 +410,12 @@ static void __init osiris_map_io(void)
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
@@ -433,6 +437,6 @@ MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	.map_io		= osiris_map_io,
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= osiris_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= osiris_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index a0f12d1..b46312a 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -52,7 +52,6 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
@@ -744,7 +743,6 @@ static void __init rx1950_map_io(void)
 #endif
 
 	s3c24xx_init_io(rx1950_iodesc, ARRAY_SIZE(rx1950_iodesc));
-	s3c24xx_init_clocks(16934000);
 	s3c24xx_init_uarts(rx1950_uartcfgs, ARRAY_SIZE(rx1950_uartcfgs));
 	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
 
@@ -757,6 +755,12 @@ static void __init rx1950_map_io(void)
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
@@ -819,6 +823,6 @@ MACHINE_START(RX1950, "HP iPAQ RX1950")
 	.reserve	= rx1950_reserve,
 	.init_irq	= s3c2442_init_irq,
 	.init_machine = rx1950_init_machine,
-	.init_time	= samsung_timer_init,
+	.init_time	= rx1950_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index 3bc6231..d842f45 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -44,7 +44,6 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-lcd.h>
 
-#include <plat/clock.h>
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
@@ -178,11 +177,16 @@ static struct platform_device *rx3715_devices[] __initdata = {
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
@@ -209,6 +213,6 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
 	.reserve	= rx3715_reserve,
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= rx3715_init_machine,
-	.init_time	= samsung_timer_init,
+	.init_time	= rx3715_init_time,
 	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index de2e5d3..335fe26 100644
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
1.7.10.4
