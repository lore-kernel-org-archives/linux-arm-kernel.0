From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jan 2014 19:40:01 +0100
Subject: [PATCH 4/5] ARM: S3C24XX: convert boards to use common restart
 function
In-Reply-To: <3105326.uFdOVLyXH8@phil>
References: <3105326.uFdOVLyXH8@phil>
Message-ID: <2227259.2cNbl9uzOp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts all boards to use the new common restart function instead
of SoC specific ones.

The mach-s3c2416-dt board now tries to setup either a swrst- or watchdog-
reset so that it will be able to handle more s3c24xx-SoCs later on.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/s3c2416.dtsi          |    5 +++++
 arch/arm/mach-s3c24xx/Kconfig           |    3 +++
 arch/arm/mach-s3c24xx/common.c          |    5 +++++
 arch/arm/mach-s3c24xx/mach-amlm5900.c   |    2 +-
 arch/arm/mach-s3c24xx/mach-anubis.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c  |    2 +-
 arch/arm/mach-s3c24xx/mach-bast.c       |    2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c      |    2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c      |    2 +-
 arch/arm/mach-s3c24xx/mach-jive.c       |    2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c   |    2 +-
 arch/arm/mach-s3c24xx/mach-n30.c        |    4 ++--
 arch/arm/mach-s3c24xx/mach-nexcoder.c   |    2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-otom.c       |    2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c |   11 ++++++++++-
 arch/arm/mach-s3c24xx/mach-smdk2410.c   |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c   |    6 +++---
 arch/arm/mach-s3c24xx/mach-smdk2416.c   |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c   |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c   |    2 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c |    2 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c     |    2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c      |    2 +-
 27 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index c19d99c..a28d30f 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -35,6 +35,11 @@
 		#clock-cells = <1>;
 	};
 
+	swrst at 4c000044 {
+		compatible = "samsung,s3c2443-swrst";
+		reg = <0x4c000044 0x4>;
+	};
+
 	pinctrl at 56000000 {
 		compatible = "samsung,s3c2416-pinctrl";
 	};
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index bb0f653..8748fc3 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -62,6 +62,7 @@ config CPU_S3C2412
 	select S3C2412_COMMON_CLK
 	select S3C2412_DMA if S3C24XX_DMA
 	select S3C2412_PM if PM
+	select S3C24XX_SWRST
 	help
 	  Support for the S3C2412 and S3C2413 SoCs from the S3C24XX line
 
@@ -73,6 +74,7 @@ config CPU_S3C2416
 	select S3C2416_PM if PM
 	select S3C2443_COMMON_CLK
 	select S3C2443_DMA if S3C24XX_DMA
+	select S3C24XX_SWRST
 	help
 	  Support for the S3C2416 SoC from the S3C24XX line
 
@@ -110,6 +112,7 @@ config CPU_S3C2443
 	select CPU_LLSERIAL_S3C2440
 	select S3C2443_COMMON_CLK
 	select S3C2443_DMA if S3C24XX_DMA
+	select S3C24XX_SWRST
 	help
 	  Support for the S3C2443 SoC from the S3C24XX line
 
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index a3b1d98..bf57d4c 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -46,6 +46,7 @@
 #include <mach/regs-gpio.h>
 #include <plat/regs-serial.h>
 #include <mach/dma.h>
+#include <mach/regs-s3c2443-clock.h>
 
 #include <plat/cpu.h>
 #include <plat/devs.h>
@@ -538,9 +539,11 @@ void __init s3c2410_init_clocks(int xtal)
 #endif
 
 #ifdef CONFIG_CPU_S3C2412
+#define S3C2412_SWRST (S3C24XX_VA_CLKPWR + 0x30)
 void __init s3c2412_init_clocks(int xtal)
 {
 	s3c2412_common_clk_init(NULL, xtal, 0, S3C24XX_VA_CLKPWR);
+	s3c24xx_swrst_reset_init(S3C2412_SWRST, true);
 }
 #endif
 
@@ -548,6 +551,7 @@ void __init s3c2412_init_clocks(int xtal)
 void __init s3c2416_init_clocks(int xtal)
 {
 	s3c2443_common_clk_init(NULL, xtal, 0, S3C24XX_VA_CLKPWR);
+	s3c24xx_swrst_reset_init(S3C2443_SWRST, false);
 }
 #endif
 
@@ -571,6 +575,7 @@ void __init s3c2442_init_clocks(int xtal)
 void __init s3c2443_init_clocks(int xtal)
 {
 	s3c2443_common_clk_init(NULL, xtal, 1, S3C24XX_VA_CLKPWR);
+	s3c24xx_swrst_reset_init(S3C2443_SWRST, false);
 }
 #endif
 
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c24xx/mach-amlm5900.c
index ebe06ad..d19cc49 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c24xx/mach-amlm5900.c
@@ -246,5 +246,5 @@ MACHINE_START(AML_M5900, "AML_M5900")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= amlm5900_init,
 	.init_time	= amlm5900_init_time,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c24xx/mach-anubis.c
index e43f984..43af5fb 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c24xx/mach-anubis.c
@@ -456,5 +456,5 @@ MACHINE_START(ANUBIS, "Simtec-Anubis")
 	.init_machine	= anubis_init,
 	.init_irq	= s3c2440_init_irq,
 	.init_time	= anubis_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c24xx/mach-at2440evb.c
index f3ac0af..4df7f92 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c24xx/mach-at2440evb.c
@@ -217,5 +217,5 @@ MACHINE_START(AT2440EVB, "AT2440EVB")
 	.init_machine	= at2440evb_init,
 	.init_irq	= s3c2440_init_irq,
 	.init_time	= at2440evb_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c24xx/mach-bast.c
index a1323bc..6ebb026 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c24xx/mach-bast.c
@@ -617,5 +617,5 @@ MACHINE_START(BAST, "Simtec-BAST")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= bast_init,
 	.init_time	= bast_init_time,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c24xx/mach-gta02.c
index d8cd88c..60030a0 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c24xx/mach-gta02.c
@@ -596,5 +596,5 @@ MACHINE_START(NEO1973_GTA02, "GTA02")
 	.init_irq	= s3c2442_init_irq,
 	.init_machine	= gta02_machine_init,
 	.init_time	= gta02_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 873e452..192b8d2 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -743,5 +743,5 @@ MACHINE_START(H1940, "IPAQ-H1940")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= h1940_init,
 	.init_time	= h1940_init_time,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c24xx/mach-jive.c
index 6c1a34f..08ca9c7 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c24xx/mach-jive.c
@@ -670,5 +670,5 @@ MACHINE_START(JIVE, "JIVE")
 	.map_io		= jive_map_io,
 	.init_machine	= jive_machine_init,
 	.init_time	= jive_init_time,
-	.restart	= s3c2412_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index d2b38f0..0686901 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -694,5 +694,5 @@ MACHINE_START(MINI2440, "MINI2440")
 	.init_machine	= mini2440_init,
 	.init_irq	= s3c2440_init_irq,
 	.init_time	= mini2440_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index 8c9fa09..a083027 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -598,7 +598,7 @@ MACHINE_START(N30, "Acer-N30")
 	.init_machine	= n30_init,
 	.init_irq	= s3c2410_init_irq,
 	.map_io		= n30_map_io,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
 
 MACHINE_START(N35, "Acer-N35")
@@ -609,5 +609,5 @@ MACHINE_START(N35, "Acer-N35")
 	.init_machine	= n30_init,
 	.init_irq	= s3c2410_init_irq,
 	.map_io		= n30_map_io,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c24xx/mach-nexcoder.c
index c594071..3f4610e 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c24xx/mach-nexcoder.c
@@ -158,5 +158,5 @@ MACHINE_START(NEXCODER_2440, "NexVision - Nexcoder 2440")
 	.init_machine	= nexcoder_init,
 	.init_irq	= s3c2440_init_irq,
 	.init_time	= nexcoder_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index a0d290b..3382374 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -438,5 +438,5 @@ MACHINE_START(OSIRIS, "Simtec-OSIRIS")
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= osiris_init,
 	.init_time	= osiris_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c24xx/mach-otom.c
index 889f7d7..228477d 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c24xx/mach-otom.c
@@ -122,5 +122,5 @@ MACHINE_START(OTOM, "Nex Vision - Otom 1.1")
 	.init_machine	= otom11_init,
 	.init_irq	= s3c2410_init_irq,
 	.init_time	= otom11_init_time,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c24xx/mach-qt2410.c
index 96fcf08..e34d8a1 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c24xx/mach-qt2410.c
@@ -351,5 +351,5 @@ MACHINE_START(QT2410, "QT2410")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= qt2410_machine_init,
 	.init_time	= qt2410_init_time,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index b46312a..2a3e1db 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -824,5 +824,5 @@ MACHINE_START(RX1950, "HP iPAQ RX1950")
 	.init_irq	= s3c2442_init_irq,
 	.init_machine = rx1950_init_machine,
 	.init_time	= rx1950_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index d842f45..e3dc759 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -214,5 +214,5 @@ MACHINE_START(RX3715, "IPAQ-RX3715")
 	.init_irq	= s3c2440_init_irq,
 	.init_machine	= rx3715_init_machine,
 	.init_time	= rx3715_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
index 0a86953..88716fa4 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
@@ -24,6 +24,7 @@
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
+#include <plat/watchdog-reset.h>
 
 #include "common.h"
 
@@ -34,6 +35,14 @@ static void __init s3c2416_dt_map_io(void)
 
 static void __init s3c2416_dt_machine_init(void)
 {
+	s3c24xx_swrst_reset_of_init();
+
+#ifdef CONFIG_SAMSUNG_WDT_RESET
+	/* if no special swrst-device exists try to find a watchdog */
+	if (!s3c24xx_swrst_reset_available())
+		samsung_wdt_reset_of_init();
+#endif
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	s3c_pm_init();
 }
@@ -50,5 +59,5 @@ DT_MACHINE_START(S3C2416_DT, "Samsung S3C2416 (Flattened Device Tree)")
 	.map_io		= s3c2416_dt_map_io,
 	.init_irq	= irqchip_init,
 	.init_machine	= s3c2416_dt_machine_init,
-	.restart	= s3c2416_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2410.c b/arch/arm/mach-s3c24xx/mach-smdk2410.c
index c961e50..ced3557 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2410.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2410.c
@@ -124,5 +124,5 @@ MACHINE_START(SMDK2410, "SMDK2410") /* @TODO: request a new identifier and switc
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= smdk2410_init,
 	.init_time	= smdk2410_init_time,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c24xx/mach-smdk2413.c
index cb1a0c7..fe01b32 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2413.c
@@ -140,7 +140,7 @@ MACHINE_START(S3C2413, "S3C2413")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= samsung_timer_init,
-	.restart	= s3c2412_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
 
 MACHINE_START(SMDK2412, "SMDK2412")
@@ -152,7 +152,7 @@ MACHINE_START(SMDK2412, "SMDK2412")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= samsung_timer_init,
-	.restart	= s3c2412_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
 
 MACHINE_START(SMDK2413, "SMDK2413")
@@ -164,5 +164,5 @@ MACHINE_START(SMDK2413, "SMDK2413")
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
 	.init_time	= smdk2413_init_time,
-	.restart	= s3c2412_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c24xx/mach-smdk2416.c
index 3ec6d49..c22f2f1 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2416.c
@@ -262,5 +262,5 @@ MACHINE_START(SMDK2416, "SMDK2416")
 	.map_io		= smdk2416_map_io,
 	.init_machine	= smdk2416_machine_init,
 	.init_time	= smdk2416_init_time,
-	.restart	= s3c2416_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c24xx/mach-smdk2440.c
index 335fe26..d8c66b6 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2440.c
@@ -185,5 +185,5 @@ MACHINE_START(S3C2440, "SMDK2440")
 	.map_io		= smdk2440_map_io,
 	.init_machine	= smdk2440_machine_init,
 	.init_time	= smdk2440_init_time,
-	.restart	= s3c244x_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c24xx/mach-smdk2443.c
index 58da97b..3cbbd4f 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c24xx/mach-smdk2443.c
@@ -151,5 +151,5 @@ MACHINE_START(SMDK2443, "SMDK2443")
 	.map_io		= smdk2443_map_io,
 	.init_machine	= smdk2443_machine_init,
 	.init_time	= smdk2443_init_time,
-	.restart	= s3c2443_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
index 3d6afe7..bcc3efa 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c24xx/mach-tct_hammer.c
@@ -157,5 +157,5 @@ MACHINE_START(TCT_HAMMER, "TCT_HAMMER")
 	.init_irq	= s3c2410_init_irq,
 	.init_machine	= tct_hammer_init,
 	.init_time	= tct_hammer_init_time,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c24xx/mach-vr1000.c
index 443c74e..1828b1c 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c24xx/mach-vr1000.c
@@ -366,5 +366,5 @@ MACHINE_START(VR1000, "Thorcom-VR1000")
 	.init_machine	= vr1000_init,
 	.init_irq	= s3c2410_init_irq,
 	.init_time	= vr1000_init_time,
-	.restart	= s3c2410_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c24xx/mach-vstms.c
index d4ebaf4..63e627b 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c24xx/mach-vstms.c
@@ -168,5 +168,5 @@ MACHINE_START(VSTMS, "VSTMS")
 	.init_machine	= vstms_init,
 	.map_io		= vstms_map_io,
 	.init_time	= vstms_init_time,
-	.restart	= s3c2412_restart,
+	.restart	= s3c24xx_restart,
 MACHINE_END
-- 
1.7.10.4
