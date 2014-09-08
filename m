From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 08 Sep 2014 17:30:47 +0200
Subject: [PATCH] ARM: S3C24XX: remove separate restart code
Message-ID: <15331569.UPPHKgXBj9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The restart-handler series from Guenter Roeck got accepted recently and
implements among other things also the restart handler in the samsung
watchdog driver and where applicable in the clock drivers. So there is
no need for having the restart callbacks in s3c24xx boards anymore.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Kconfig                      |  2 --
 arch/arm/mach-s3c24xx/common.c                     |  4 ----
 arch/arm/mach-s3c24xx/common.h                     |  5 -----
 .../mach-s3c24xx/include/mach/regs-s3c2443-clock.h |  2 --
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |  1 -
 arch/arm/mach-s3c24xx/mach-anubis.c                |  1 -
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |  1 -
 arch/arm/mach-s3c24xx/mach-bast.c                  |  1 -
 arch/arm/mach-s3c24xx/mach-gta02.c                 |  1 -
 arch/arm/mach-s3c24xx/mach-h1940.c                 |  1 -
 arch/arm/mach-s3c24xx/mach-jive.c                  |  1 -
 arch/arm/mach-s3c24xx/mach-mini2440.c              |  1 -
 arch/arm/mach-s3c24xx/mach-n30.c                   |  2 --
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |  1 -
 arch/arm/mach-s3c24xx/mach-osiris.c                |  1 -
 arch/arm/mach-s3c24xx/mach-otom.c                  |  1 -
 arch/arm/mach-s3c24xx/mach-qt2410.c                |  1 -
 arch/arm/mach-s3c24xx/mach-rx1950.c                |  1 -
 arch/arm/mach-s3c24xx/mach-rx3715.c                |  1 -
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |  1 -
 arch/arm/mach-s3c24xx/mach-smdk2410.c              |  1 -
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |  3 ---
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |  1 -
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |  1 -
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |  1 -
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            |  1 -
 arch/arm/mach-s3c24xx/mach-vr1000.c                |  1 -
 arch/arm/mach-s3c24xx/mach-vstms.c                 |  1 -
 arch/arm/mach-s3c24xx/s3c2410.c                    | 13 ------------
 arch/arm/mach-s3c24xx/s3c2412.c                    | 23 ----------------------
 arch/arm/mach-s3c24xx/s3c2416.c                    |  8 --------
 arch/arm/mach-s3c24xx/s3c2443.c                    |  8 --------
 arch/arm/mach-s3c24xx/s3c244x.c                    | 12 -----------
 33 files changed, 104 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index ad5316a..9eb2229 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -32,7 +32,6 @@ config CPU_S3C2410
 	select S3C2410_DMA if S3C24XX_DMA
 	select ARM_S3C2410_CPUFREQ if ARM_S3C24XX_CPUFREQ
 	select S3C2410_PM if PM
-	select SAMSUNG_WDT_RESET
 	help
 	  Support for S3C2410 and S3C2410A family from the S3C24XX line
 	  of Samsung Mobile CPUs.
@@ -76,7 +75,6 @@ config CPU_S3C2442
 config CPU_S3C244X
 	def_bool y
 	depends on CPU_S3C2440 || CPU_S3C2442
-	select SAMSUNG_WDT_RESET
 
 config CPU_S3C2443
 	bool "SAMSUNG S3C2443"
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 44fa95d..bf50328 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -51,7 +51,6 @@
 #include <plat/devs.h>
 #include <plat/cpu-freq.h>
 #include <plat/pwm-core.h>
-#include <plat/watchdog-reset.h>
 
 #include "common.h"
 
@@ -513,7 +512,6 @@ struct platform_device s3c2443_device_dma = {
 void __init s3c2410_init_clocks(int xtal)
 {
 	s3c2410_common_clk_init(NULL, xtal, 0, S3C24XX_VA_CLKPWR);
-	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
 #endif
 
@@ -535,7 +533,6 @@ void __init s3c2416_init_clocks(int xtal)
 void __init s3c2440_init_clocks(int xtal)
 {
 	s3c2410_common_clk_init(NULL, xtal, 1, S3C24XX_VA_CLKPWR);
-	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
 #endif
 
@@ -543,7 +540,6 @@ void __init s3c2440_init_clocks(int xtal)
 void __init s3c2442_init_clocks(int xtal)
 {
 	s3c2410_common_clk_init(NULL, xtal, 2, S3C24XX_VA_CLKPWR);
-	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
 #endif
 
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index ac3ff12..c7ac7e6 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -22,7 +22,6 @@ extern  int s3c2410a_init(void);
 extern void s3c2410_map_io(void);
 extern void s3c2410_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2410_init_clocks(int xtal);
-extern void s3c2410_restart(enum reboot_mode mode, const char *cmd);
 extern void s3c2410_init_irq(void);
 #else
 #define s3c2410_init_clocks NULL
@@ -38,7 +37,6 @@ extern void s3c2412_map_io(void);
 extern void s3c2412_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2412_init_clocks(int xtal);
 extern  int s3c2412_baseclk_add(void);
-extern void s3c2412_restart(enum reboot_mode mode, const char *cmd);
 extern void s3c2412_init_irq(void);
 #else
 #define s3c2412_init_clocks NULL
@@ -53,7 +51,6 @@ extern void s3c2416_map_io(void);
 extern void s3c2416_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2416_init_clocks(int xtal);
 extern  int s3c2416_baseclk_add(void);
-extern void s3c2416_restart(enum reboot_mode mode, const char *cmd);
 extern void s3c2416_init_irq(void);
 
 extern struct syscore_ops s3c2416_irq_syscore_ops;
@@ -67,7 +64,6 @@ extern struct syscore_ops s3c2416_irq_syscore_ops;
 #if defined(CONFIG_CPU_S3C2440) || defined(CONFIG_CPU_S3C2442)
 extern void s3c244x_map_io(void);
 extern void s3c244x_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-extern void s3c244x_restart(enum reboot_mode mode, const char *cmd);
 #else
 #define s3c244x_init_uarts NULL
 #endif
@@ -98,7 +94,6 @@ extern void s3c2443_map_io(void);
 extern void s3c2443_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s3c2443_init_clocks(int xtal);
 extern  int s3c2443_baseclk_add(void);
-extern void s3c2443_restart(enum reboot_mode mode, const char *cmd);
 extern void s3c2443_init_irq(void);
 #else
 #define s3c2443_init_clocks NULL
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
index c3feff3..ffe37bd 100644
--- a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
+++ b/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
@@ -42,8 +42,6 @@
 #define S3C2443_URSTCON			S3C2443_CLKREG(0x88)
 #define S3C2443_UCLKCON			S3C2443_CLKREG(0x8C)
 
-#define S3C2443_SWRST_RESET		(0x533c2443)
-
 #define S3C2443_PLLCON_OFF		(1<<24)
 
 #define S3C2443_CLKSRC_EPLLREF_XTAL	(2<<7)
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index 5157e25..3e63777 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -247,5 +247,4 @@ MACHINE_START(AML_M5900, "AML_M5900")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= amlm5900_init,
 	.init_time	= amlm5900_init_time,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index e053581..d03df0d 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -430,5 +430,4 @@ MACHINE_START(ANUBIS, "Simtec-Anubis")
 	.init_machine	= anubis_init,
 	.init_irq	= s3c2440_init_irq,
 	.init_time	= anubis_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index 9db768f..9ae170f 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -218,5 +218,4 @@ MACHINE_START(AT2440EVB, "AT2440EVB")
 	.init_machine	= at2440evb_init,
 	.init_irq	= s3c2440_init_irq,
 	.init_time	= at2440evb_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index f9112b8..ed07cf3 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -591,5 +591,4 @@ MACHINE_START(BAST, "Simtec-BAST")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= bast_init,
 	.init_time	= bast_init_time,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index fc3a08d..6d1e0b9 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -597,5 +597,4 @@ MACHINE_START(NEO1973_GTA02, "GTA02")
 	.init_irq	= s3c2442_init_irq,
 	.init_machine	= gta02_machine_init,
 	.init_time	= gta02_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index c9a99bb..d35ddc1 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -747,5 +747,4 @@ MACHINE_START(H1940, "IPAQ-H1940")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= h1940_init,
 	.init_time	= h1940_init_time,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 7804d3c..7d99fe8 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -670,5 +670,4 @@ MACHINE_START(JIVE, "JIVE")
 	.map_io		= jive_map_io,
 	.init_machine	= jive_machine_init,
 	.init_time	= jive_init_time,
-	.restart	= s3c2412_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 5cc40ec..a852168 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -695,5 +695,4 @@ MACHINE_START(MINI2440, "MINI2440")
 	.init_machine	= mini2440_init,
 	.init_irq	= s3c2440_init_irq,
 	.init_time	= mini2440_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 3ac2a54..171c1f1 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -599,7 +599,6 @@ MACHINE_START(N30, "Acer-N30")
 	.init_machine	= n30_init,
 	.init_irq	= s3c2410_init_irq,
 	.map_io		= n30_map_io,
-	.restart	= s3c2410_restart,
 MACHINE_END
 
 MACHINE_START(N35, "Acer-N35")
@@ -610,5 +609,4 @@ MACHINE_START(N35, "Acer-N35")
 	.init_machine	= n30_init,
 	.init_irq	= s3c2410_init_irq,
 	.map_io		= n30_map_io,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index c82c281..2a61d13 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -159,5 +159,4 @@ MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	.init_machine	= nexcoder_init,
 	.init_irq	= s3c2440_init_irq,
 	.init_time	= nexcoder_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 189147b..2f6fdc3 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -412,5 +412,4 @@ MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= osiris_init,
 	.init_time	= osiris_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index 4583300..345a484 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -122,5 +122,4 @@ MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
 	.init_machine	= otom11_init,
 	.init_irq	= s3c2410_init_irq,
 	.init_time	= otom11_init_time,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 228c909..984516e 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -352,5 +352,4 @@ MACHINE_START(QT2410, "QT2410")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= qt2410_machine_init,
 	.init_time	= qt2410_init_time,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index e2c6541..c3f2682 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -812,5 +812,4 @@ MACHINE_START(RX1950, "HP iPAQ RX1950")
 	.init_irq	= s3c2442_init_irq,
 	.init_machine = rx1950_init_machine,
 	.init_time	= rx1950_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index 6e749ec..cf55196 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -215,5 +215,4 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= rx3715_init_machine,
 	.init_time	= rx3715_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
index e4dcb9a..f886478 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -51,5 +51,4 @@ DT_MACHINE_START(S3C2416_DT, "Samsung S3C2416 (Flattened Device Tree)")
 	.map_io		= s3c2416_dt_map_io,
 	.init_irq	= irqchip_init,
 	.init_machine	= s3c2416_dt_machine_init,
-	.restart	= s3c2416_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2410.c b/arch/arm/mach-s3c24xx/mach-smdk2410.c
index 419fadd..27dd660 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2410.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2410.c
@@ -124,5 +124,4 @@ MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switc
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= smdk2410_init,
 	.init_time	= smdk2410_init_time,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index 10726bf..586e4a3 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -138,7 +138,6 @@ MACHINE_START(S3C2413, "S3C2413")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= samsung_timer_init,
-	.restart	= s3c2412_restart,
 MACHINE_END
 
 MACHINE_START(SMDK2412, "SMDK2412")
@@ -150,7 +149,6 @@ MACHINE_START(SMDK2412, "SMDK2412")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= samsung_timer_init,
-	.restart	= s3c2412_restart,
 MACHINE_END
 
 MACHINE_START(SMDK2413, "SMDK2413")
@@ -162,5 +160,4 @@ MACHINE_START(SMDK2413, "SMDK2413")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= smdk2413_init_time,
-	.restart	= s3c2412_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index 24189e8..86394f7 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -262,5 +262,4 @@ MACHINE_START(SMDK2416, "SMDK2416")
 	.map_io		= smdk2416_map_io,
 	.init_machine	= smdk2416_machine_init,
 	.init_time	= smdk2416_init_time,
-	.restart	= s3c2416_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index 5fb89c0a..9bb96bf 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -185,5 +185,4 @@ MACHINE_START(S3C2440, "SMDK2440")
 	.map_io		= smdk2440_map_io,
 	.init_machine	= smdk2440_machine_init,
 	.init_time	= smdk2440_init_time,
-	.restart	= s3c244x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index 0ed7761..87fe5c5 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -150,5 +150,4 @@ MACHINE_START(SMDK2443, "SMDK2443")
 	.map_io		= smdk2443_map_io,
 	.init_machine	= smdk2443_machine_init,
 	.init_time	= smdk2443_init_time,
-	.restart	= s3c2443_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index c616ca2..2deb62f 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -157,5 +157,4 @@ MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= tct_hammer_init,
 	.init_time	= tct_hammer_init_time,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index f88c584..89f32bd 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -340,5 +340,4 @@ MACHINE_START(VR1000, "Thorcom-VR1000")
 	.init_machine	= vr1000_init,
 	.init_irq	= s3c2410_init_irq,
 	.init_time	= vr1000_init_time,
-	.restart	= s3c2410_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index 9d4f647..b4460d5 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -165,5 +165,4 @@ MACHINE_START(VSTMS, "VSTMS")
 	.init_machine	= vstms_init,
 	.map_io		= vstms_map_io,
 	.init_time	= vstms_init_time,
-	.restart	= s3c2412_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 5ffe828..2a6985a 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -42,7 +42,6 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
-#include <plat/watchdog-reset.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -135,15 +134,3 @@ int __init s3c2410a_init(void)
 	s3c2410_dev.bus = &s3c2410a_subsys;
 	return s3c2410_init();
 }
-
-void s3c2410_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT) {
-		soft_restart(0);
-	}
-
-	samsung_wdt_reset();
-
-	/* we'll take a jump through zero as a poor second */
-	soft_restart(0);
-}
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 569f3f5..ecf2c77 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -48,9 +48,6 @@
 #include "regs-dsc.h"
 #include "s3c2412-power.h"
 
-#define S3C2412_SWRST			(S3C24XX_VA_CLKPWR + 0x30)
-#define S3C2412_SWRST_RESET		(0x533C2412)
-
 #ifndef CONFIG_CPU_S3C2412_ONLY
 void __iomem *s3c24xx_va_gpio2 = S3C24XX_VA_GPIO;
 
@@ -128,26 +125,6 @@ static void s3c2412_idle(void)
 	cpu_do_idle();
 }
 
-void s3c2412_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT)
-		soft_restart(0);
-
-	/* errata "Watch-dog/Software Reset Problem" specifies that
-	 * this reset must be done with the SYSCLK sourced from
-	 * EXTCLK instead of FOUT to avoid a glitch in the reset
-	 * mechanism.
-	 *
-	 * See the watchdog section of the S3C2412 manual for more
-	 * information on this fix.
-	 */
-
-	__raw_writel(0x00, S3C2412_CLKSRC);
-	__raw_writel(S3C2412_SWRST_RESET, S3C2412_SWRST);
-
-	mdelay(1);
-}
-
 /* s3c2412_map_io
  *
  * register the standard cpu IO areas, and any passed in from the
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index 9fe260a..bfd4da8 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -81,14 +81,6 @@ static struct device s3c2416_dev = {
 	.bus		= &s3c2416_subsys,
 };
 
-void s3c2416_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT)
-		soft_restart(0);
-
-	__raw_writel(S3C2443_SWRST_RESET, S3C2443_SWRST);
-}
-
 int __init s3c2416_init(void)
 {
 	printk(KERN_INFO "S3C2416: Initializing architecture\n");
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index c7a804d..87b6b89 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -61,14 +61,6 @@ static struct device s3c2443_dev = {
 	.bus		= &s3c2443_subsys,
 };
 
-void s3c2443_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT)
-		soft_restart(0);
-
-	__raw_writel(S3C2443_SWRST_RESET, S3C2443_SWRST);
-}
-
 int __init s3c2443_init(void)
 {
 	printk("S3C2443: Initialising architecture\n");
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index d1c3e65..177f978 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -42,7 +42,6 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 #include <plat/nand-core.h>
-#include <plat/watchdog-reset.h>
 
 #include "common.h"
 #include "regs-dsc.h"
@@ -137,14 +136,3 @@ struct syscore_ops s3c244x_pm_syscore_ops = {
 	.suspend	= s3c244x_suspend,
 	.resume		= s3c244x_resume,
 };
-
-void s3c244x_restart(enum reboot_mode mode, const char *cmd)
-{
-	if (mode == REBOOT_SOFT)
-		soft_restart(0);
-
-	samsung_wdt_reset();
-
-	/* we'll take a jump through zero as a poor second */
-	soft_restart(0);
-}
-- 
2.0.1
