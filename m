From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 20 Aug 2010 15:23:59 +0800
Subject: [PATCH 1/1] [ARM] pxa: encode IRQ number into .nr_irqs
Message-ID: <mailman.208.1282300840.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-pxa/Kconfig                    |   21 -------------
 arch/arm/mach-pxa/balloon3.c                 |    1 +
 arch/arm/mach-pxa/cm-x2xx.c                  |    4 ++
 arch/arm/mach-pxa/eseries.c                  |    7 ++++
 arch/arm/mach-pxa/ezx.c                      |    8 +++++
 arch/arm/mach-pxa/hx4700.c                   |    1 +
 arch/arm/mach-pxa/include/mach/balloon3.h    |    2 +
 arch/arm/mach-pxa/include/mach/eseries-irq.h |    1 +
 arch/arm/mach-pxa/include/mach/hx4700.h      |    1 +
 arch/arm/mach-pxa/include/mach/irqs.h        |   42 ++------------------------
 arch/arm/mach-pxa/include/mach/littleton.h   |    2 +
 arch/arm/mach-pxa/include/mach/lpd270.h      |    1 +
 arch/arm/mach-pxa/include/mach/lubbock.h     |    3 ++
 arch/arm/mach-pxa/include/mach/magician.h    |    2 +
 arch/arm/mach-pxa/include/mach/mainstone.h   |    2 +
 arch/arm/mach-pxa/include/mach/pcm027.h      |    2 +
 arch/arm/mach-pxa/include/mach/poodle.h      |    2 +
 arch/arm/mach-pxa/include/mach/tosa.h        |    1 +
 arch/arm/mach-pxa/include/mach/zeus.h        |    2 +
 arch/arm/mach-pxa/include/mach/zylonite.h    |    2 +
 arch/arm/mach-pxa/littleton.c                |    1 +
 arch/arm/mach-pxa/lpd270.c                   |    1 +
 arch/arm/mach-pxa/lubbock.c                  |    3 +-
 arch/arm/mach-pxa/magician.c                 |    1 +
 arch/arm/mach-pxa/mainstone.c                |    1 +
 arch/arm/mach-pxa/pcm027.c                   |    1 +
 arch/arm/mach-pxa/poodle.c                   |    1 +
 arch/arm/mach-pxa/stargate2.c                |    3 ++
 arch/arm/mach-pxa/tosa.c                     |    1 +
 arch/arm/mach-pxa/zeus.c                     |    1 +
 arch/arm/mach-pxa/zylonite.c                 |    1 +
 32 files changed, 62 insertions(+), 61 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9295110..45f93e1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -588,6 +588,7 @@ config ARCH_PXA
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
+	select SPARSE_IRQ
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 3d4926e..e2453db 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -8,19 +8,16 @@ config ARCH_LUBBOCK
 	bool "Intel DBPXA250 Development Platform (aka Lubbock)"
 	select PXA25x
 	select SA1111
-	select PXA_HAVE_BOARD_IRQS

 config MACH_MAINSTONE
 	bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
 	select PXA27x
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 config MACH_ZYLONITE
 	bool
 	select PXA3xx
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 config MACH_ZYLONITE300
 	bool "PXA3xx Development Platform (aka Zylonite) PXA300/310"
@@ -61,7 +58,6 @@ config ARCH_VIPER
 	select ISA
 	select I2C_GPIO
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS
 	select PXA_HAVE_ISA_IRQS
 	select ARCOM_PCMCIA

@@ -69,7 +65,6 @@ config MACH_ARCOM_ZEUS
 	bool "Arcom/Eurotech ZEUS SBC"
 	select PXA27x
 	select ISA
-	select PXA_HAVE_BOARD_IRQS
 	select PXA_HAVE_ISA_IRQS
 	select ARCOM_PCMCIA

@@ -77,7 +72,6 @@ config MACH_BALLOON3
 	bool "Balloon 3 board"
 	select PXA27x
 	select IWMMXT
-	select PXA_HAVE_BOARD_IRQS

 config MACH_CSB726
 	bool "Enable Cogent CSB726 System On a Module"
@@ -140,13 +134,11 @@ config MACH_INTELMOTE2
 	bool "Intel Mote 2 Platform"
 	select PXA27x
 	select IWMMXT
-	select PXA_HAVE_BOARD_IRQS

 config MACH_STARGATE2
 	bool "Intel Stargate 2 Platform"
 	select PXA27x
 	select IWMMXT
-	select PXA_HAVE_BOARD_IRQS

 config MACH_XCEP
 	bool "Iskratel Electronics XCEP"
@@ -206,13 +198,11 @@ config MACH_LOGICPD_PXA270
 	bool "LogicPD PXA270 Card Engine Development Platform"
 	select PXA27x
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 config MACH_PCM027
 	bool "Phytec phyCORE-PXA270 CPU module (PCM-027)"
 	select PXA27x
 	select IWMMXT
-	select PXA_HAVE_BOARD_IRQS

 config MACH_PCM990_BASEBOARD
 	bool "PHYTEC PCM-990 development board"
@@ -247,7 +237,6 @@ config MACH_COLIBRI_PXA270_INCOME
 	depends on MACH_COLIBRI
 	select PXA27x
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 config MACH_COLIBRI300
 	bool "Toradex Colibri PXA300/310"
@@ -274,7 +263,6 @@ config MACH_H4700
 	select PXA27x
 	select IWMMXT
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 config MACH_H5000
 	bool "HP iPAQ h5000"
@@ -289,7 +277,6 @@ config MACH_MAGICIAN
 	select PXA27x
 	select IWMMXT
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 config MACH_MIOA701
 	bool "Mitac Mio A701 Support"
@@ -307,7 +294,6 @@ config PXA_EZX
 	select PXA27x
 	select IWMMXT
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 config MACH_EZX_A780
 	bool "Motorola EZX A780"
@@ -478,7 +464,6 @@ config MACH_POODLE
 	depends on PXA_SHARPSL
 	select PXA25x
 	select SHARP_LOCOMO
-	select PXA_HAVE_BOARD_IRQS

 config MACH_CORGI
 	bool "Enable Sharp SL-C700 (Corgi) Support"
@@ -523,7 +508,6 @@ config MACH_TOSA
 	bool "Enable Sharp SL-6000x (Tosa) Support"
 	depends on PXA_SHARPSL
 	select PXA25x
-	select PXA_HAVE_BOARD_IRQS

 config TOSA_BT
 	tristate "Control the state of built-in bluetooth chip on Sharp SL-6000"
@@ -552,7 +536,6 @@ config MACH_ICONTROL
 config ARCH_PXA_ESERIES
 	bool "PXA based Toshiba e-series PDAs"
 	select PXA25x
-	select PXA_HAVE_BOARD_IRQS

 config MACH_E330
 	bool "Toshiba e330"
@@ -606,7 +589,6 @@ config MACH_ZIPIT2
 	bool "Zipit Z2 Handheld"
 	select PXA27x
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 endmenu

@@ -693,9 +675,6 @@ config SHARPSL_PM_MAX1111
 	select HWMON
 	select SENSORS_MAX1111

-config PXA_HAVE_BOARD_IRQS
-	bool
-
 config PXA_HAVE_ISA_IRQS
 	bool

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 9041340..2b81e64 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -779,6 +779,7 @@ MACHINE_START(BALLOON3, "Balloon3")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= balloon3_map_io,
+	.nr_irqs	= BALLOON3_NR_IRQS,
 	.init_irq	= balloon3_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= balloon3_init,
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index bff6e78..ad40e7b 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -33,6 +33,9 @@
 extern void cmx255_init(void);
 extern void cmx270_init(void);

+/* reserve IRQs for IT8152 */
+#define CMX2XX_NR_IRQS		(IRQ_BOARD_START + 40)
+
 /* virtual addresses for statically mapped regions */
 #define CMX2XX_VIRT_BASE	(0xe8000000)
 #define CMX2XX_IT8152_VIRT	(CMX2XX_VIRT_BASE)
@@ -514,6 +517,7 @@ MACHINE_START(ARMCORE, "Compulab CM-X2XX")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= cmx2xx_map_io,
+	.nr_irqs	= CMX2XX_NR_IRQS,
 	.init_irq	= cmx2xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= cmx2xx_init,
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 349212a..4971ce1 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -29,6 +29,7 @@

 #include <mach/pxa25x.h>
 #include <mach/eseries-gpio.h>
+#include <mach/eseries-irq.h>
 #include <mach/audio.h>
 #include <mach/pxafb.h>
 #include <mach/udc.h>
@@ -183,6 +184,7 @@ MACHINE_START(E330, "Toshiba e330")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
 	.init_machine	= e330_init,
@@ -233,6 +235,7 @@ MACHINE_START(E350, "Toshiba e350")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
 	.init_machine	= e350_init,
@@ -356,6 +359,7 @@ MACHINE_START(E400, "Toshiba e400")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
 	.init_machine	= e400_init,
@@ -545,6 +549,7 @@ MACHINE_START(E740, "Toshiba e740")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
 	.init_machine	= e740_init,
@@ -737,6 +742,7 @@ MACHINE_START(E750, "Toshiba e750")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
 	.init_machine	= e750_init,
@@ -933,6 +939,7 @@ MACHINE_START(E800, "Toshiba e800")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= ESERIES_NR_IRQS,
 	.init_irq	= pxa25x_init_irq,
 	.fixup		= eseries_fixup,
 	.init_machine	= e800_init,
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 626c82b..3fe61f4 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -38,6 +38,8 @@
 #include "devices.h"
 #include "generic.h"

+#define EZX_NR_IRQS			(IRQ_BOARD_START + 24)
+
 #define GPIO12_A780_FLIP_LID 		12
 #define GPIO15_A1200_FLIP_LID 		15
 #define GPIO15_A910_FLIP_LID 		15
@@ -800,6 +802,7 @@ MACHINE_START(EZX_A780, "Motorola EZX A780")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = a780_init,
@@ -866,6 +869,7 @@ MACHINE_START(EZX_E680, "Motorola EZX E680")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = e680_init,
@@ -932,6 +936,7 @@ MACHINE_START(EZX_A1200, "Motorola EZX A1200")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = a1200_init,
@@ -1124,6 +1129,7 @@ MACHINE_START(EZX_A910, "Motorola EZX A910")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = a910_init,
@@ -1190,6 +1196,7 @@ MACHINE_START(EZX_E6, "Motorola EZX E6")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = e6_init,
@@ -1230,6 +1237,7 @@ MACHINE_START(EZX_E2, "Motorola EZX E2")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = e2_init,
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 848c861..10104f1 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -874,6 +874,7 @@ MACHINE_START(H4700, "HP iPAQ HX4700")
 	.io_pg_offst  = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params  = 0xa0000100,
 	.map_io       = pxa_map_io,
+	.nr_irqs      = HX4700_NR_IRQS,
 	.init_irq     = pxa27x_init_irq,
 	.init_machine = hx4700_init,
 	.timer        = &pxa_timer,
diff --git a/arch/arm/mach-pxa/include/mach/balloon3.h
b/arch/arm/mach-pxa/include/mach/balloon3.h
index eec92e6..561562b 100644
--- a/arch/arm/mach-pxa/include/mach/balloon3.h
+++ b/arch/arm/mach-pxa/include/mach/balloon3.h
@@ -174,6 +174,8 @@ enum balloon3_features {
 #define BALLOON3_CODEC_IRQ	IRQ_GPIO(BALLOON3_GPIO_CODEC_IRQ)
 #define BALLOON3_S0_CD_IRQ	IRQ_GPIO(BALLOON3_GPIO_S0_CD)

+#define BALLOON3_NR_IRQS	(IRQ_BOARD_START + 4)
+
 extern int balloon3_has(enum balloon3_features feature);

 #endif
diff --git a/arch/arm/mach-pxa/include/mach/eseries-irq.h
b/arch/arm/mach-pxa/include/mach/eseries-irq.h
index f2a93d5..de292b2 100644
--- a/arch/arm/mach-pxa/include/mach/eseries-irq.h
+++ b/arch/arm/mach-pxa/include/mach/eseries-irq.h
@@ -25,3 +25,4 @@
 #define TMIO_SD_IRQ     IRQ_TMIO(1)
 #define TMIO_USB_IRQ    IRQ_TMIO(2)

+#define ESERIES_NR_IRQS	(IRQ_BOARD_START + 16)
diff --git a/arch/arm/mach-pxa/include/mach/hx4700.h
b/arch/arm/mach-pxa/include/mach/hx4700.h
index 9eaeed1..3740844 100644
--- a/arch/arm/mach-pxa/include/mach/hx4700.h
+++ b/arch/arm/mach-pxa/include/mach/hx4700.h
@@ -17,6 +17,7 @@

 #define HX4700_ASIC3_GPIO_BASE	NR_BUILTIN_GPIO
 #define HX4700_EGPIO_BASE	(HX4700_ASIC3_GPIO_BASE + ASIC3_NUM_GPIOS)
+#define HX4700_NR_IRQS		(IRQ_BOARD_START + 70)

 /*
  * PXA GPIOs
diff --git a/arch/arm/mach-pxa/include/mach/irqs.h
b/arch/arm/mach-pxa/include/mach/irqs.h
index ffc8314..d372caa 100644
--- a/arch/arm/mach-pxa/include/mach/irqs.h
+++ b/arch/arm/mach-pxa/include/mach/irqs.h
@@ -117,48 +117,12 @@
 /*
  * The following interrupts are for board specific purposes. Since
  * the kernel can only run on one machine at a time, we can re-use
- * these.  There will be 16 IRQs by default.  If it is not enough,
- * IRQ_BOARD_END is allowed be customized for each board, but keep
- * the numbers within sensible limits and in descending order, so
- * when multiple config options are selected, the maximum will be
- * used.
+ * these.
+ * By default, no board IRQ is reserved. It should be finished in
+ * custom board since sparse IRQ is already enabled.
  */
 #define IRQ_BOARD_START		(PXA_GPIO_IRQ_BASE + PXA_GPIO_IRQ_NUM)

-#if defined(CONFIG_MACH_H4700)
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 70)
-#elif defined(CONFIG_MACH_ZYLONITE)
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 32)
-#elif defined(CONFIG_PXA_EZX)
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 23)
-#else
-#define IRQ_BOARD_END		(IRQ_BOARD_START + 16)
-#endif
-
-/*
- * Figure out the MAX IRQ number.
- *
- * If we have an SA1111, the max IRQ is S1_BVD1_STSCHG+1.
- * If we have an LoCoMo, the max IRQ is IRQ_LOCOMO_SPI_TEND+1
- * Otherwise, we have the standard IRQs only.
- */
-#ifdef CONFIG_SA1111
-#define NR_IRQS			(IRQ_BOARD_END + 55)
-#elif defined(CONFIG_PXA_HAVE_BOARD_IRQS)
-#define NR_IRQS			(IRQ_BOARD_END)
-#else
 #define NR_IRQS			(IRQ_BOARD_START)
-#endif
-
-/* add IT8152 IRQs beyond BOARD_END */
-#ifdef CONFIG_PCI_HOST_ITE8152
-#define IT8152_LAST_IRQ         (IRQ_BOARD_END + 40)
-
-#if NR_IRQS < (IT8152_LAST_IRQ+1)
-#undef NR_IRQS
-#define NR_IRQS (IT8152_LAST_IRQ+1)
-#endif
-
-#endif /* CONFIG_PCI_HOST_ITE8152 */

 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-pxa/include/mach/littleton.h
b/arch/arm/mach-pxa/include/mach/littleton.h
index 6c9b21c..2a5726c 100644
--- a/arch/arm/mach-pxa/include/mach/littleton.h
+++ b/arch/arm/mach-pxa/include/mach/littleton.h
@@ -10,4 +10,6 @@
 #define EXT0_GPIO_BASE	(NR_BUILTIN_GPIO)
 #define EXT0_GPIO(x)	(EXT0_GPIO_BASE + (x))

+#define LITTLETON_NR_IRQS	(IRQ_BOARD_START + 8)
+
 #endif /* __ASM_ARCH_LITTLETON_H */
diff --git a/arch/arm/mach-pxa/include/mach/lpd270.h
b/arch/arm/mach-pxa/include/mach/lpd270.h
index 0e6440c..cd07009 100644
--- a/arch/arm/mach-pxa/include/mach/lpd270.h
+++ b/arch/arm/mach-pxa/include/mach/lpd270.h
@@ -38,5 +38,6 @@
 #define LPD270_USBC_IRQ		LPD270_IRQ(2)
 #define LPD270_ETHERNET_IRQ	LPD270_IRQ(3)
 #define LPD270_AC97_IRQ		LPD270_IRQ(4)
+#define LPD270_NR_IRQS		(IRQ_BOARD_START + 5)

 #endif
diff --git a/arch/arm/mach-pxa/include/mach/lubbock.h
b/arch/arm/mach-pxa/include/mach/lubbock.h
index a0d4247..2a086e8 100644
--- a/arch/arm/mach-pxa/include/mach/lubbock.h
+++ b/arch/arm/mach-pxa/include/mach/lubbock.h
@@ -45,6 +45,9 @@
 #define LUBBOCK_USB_DISC_IRQ	LUBBOCK_IRQ(6)  /* usb disconnect */
 #define LUBBOCK_LAST_IRQ	LUBBOCK_IRQ(6)

+#define LUBBOCK_SA1111_IRQ_BASE	(IRQ_BOARD_START + 16)
+#define LUBBOCK_NR_IRQS		(IRQ_BOARD_START + 16 + 55)
+
 #ifndef __ASSEMBLY__
 extern void lubbock_set_misc_wr(unsigned int mask, unsigned int set);
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/magician.h
b/arch/arm/mach-pxa/include/mach/magician.h
index 20ef37d..0a2efcf 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -71,6 +71,8 @@
 #define IRQ_MAGICIAN_BT		(IRQ_BOARD_START + 2)
 #define IRQ_MAGICIAN_VBUS	(IRQ_BOARD_START + 3)

+#define MAGICIAN_NR_IRQS	(IRQ_BOARD_START + 8)
+
 /*
  * CPLD EGPIOs
  */
diff --git a/arch/arm/mach-pxa/include/mach/mainstone.h
b/arch/arm/mach-pxa/include/mach/mainstone.h
index 86e623a..4c2d11c 100644
--- a/arch/arm/mach-pxa/include/mach/mainstone.h
+++ b/arch/arm/mach-pxa/include/mach/mainstone.h
@@ -134,4 +134,6 @@
 #define MAINSTONE_S1_STSCHG_IRQ	MAINSTONE_IRQ(14)
 #define MAINSTONE_S1_IRQ	MAINSTONE_IRQ(15)

+#define MAINSTONE_NR_IRQS	(IRQ_BOARD_START + 16)
+
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/pcm027.h
b/arch/arm/mach-pxa/include/mach/pcm027.h
index 0408326..4bac588 100644
--- a/arch/arm/mach-pxa/include/mach/pcm027.h
+++ b/arch/arm/mach-pxa/include/mach/pcm027.h
@@ -30,6 +30,8 @@
 #define PCM027_MMCDET_IRQ      PCM027_IRQ(2)
 #define PCM027_PM_5V_IRQ       PCM027_IRQ(3)

+#define PCM027_NR_IRQS		(IRQ_BOARD_START + 32)
+
 /* I2C RTC */
 #define PCM027_RTC_IRQ_GPIO	0
 #define PCM027_RTC_IRQ		IRQ_GPIO(PCM027_RTC_IRQ_GPIO)
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h
b/arch/arm/mach-pxa/include/mach/poodle.h
index 0b3e6d0..83d1cfd 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -85,6 +85,8 @@
 #define POODLE_LOCOMO_GPIO_232VCC_ON   LOCOMO_GPIO(12)
 #define POODLE_LOCOMO_GPIO_JK_B        LOCOMO_GPIO(13)

+#define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
+
 extern struct platform_device poodle_locomo_device;

 #endif /* __ASM_ARCH_POODLE_H  */
diff --git a/arch/arm/mach-pxa/include/mach/tosa.h
b/arch/arm/mach-pxa/include/mach/tosa.h
index 1bbd1f2..1272c4b 100644
--- a/arch/arm/mach-pxa/include/mach/tosa.h
+++ b/arch/arm/mach-pxa/include/mach/tosa.h
@@ -20,6 +20,7 @@
 /* Jacket Scoop */
 #define TOSA_SCOOP_PHYS  	(PXA_CS5_PHYS + 0x00800000)

+#define TOSA_NR_IRQS		(IRQ_BOARD_START + TC6393XB_NR_IRQS)
 /*
  * SCOOP2 internal GPIOs
  */
diff --git a/arch/arm/mach-pxa/include/mach/zeus.h
b/arch/arm/mach-pxa/include/mach/zeus.h
index 6e11997..faa408a 100644
--- a/arch/arm/mach-pxa/include/mach/zeus.h
+++ b/arch/arm/mach-pxa/include/mach/zeus.h
@@ -15,6 +15,8 @@
 #ifndef _MACH_ZEUS_H
 #define _MACH_ZEUS_H

+#define ZEUS_NR_IRQS		(IRQ_BOARD_START + 48)
+
 /* Physical addresses */
 #define ZEUS_FLASH_PHYS		PXA_CS0_PHYS
 #define ZEUS_ETH0_PHYS		PXA_CS1_PHYS
diff --git a/arch/arm/mach-pxa/include/mach/zylonite.h
b/arch/arm/mach-pxa/include/mach/zylonite.h
index 9edf645..ea24998 100644
--- a/arch/arm/mach-pxa/include/mach/zylonite.h
+++ b/arch/arm/mach-pxa/include/mach/zylonite.h
@@ -5,6 +5,8 @@

 #define EXT_GPIO(x)		(128 + (x))

+#define ZYLONITE_NR_IRQS	(IRQ_BOARD_START + 32)
+
 /* the following variables are processor specific and initialized
  * by the corresponding zylonite_pxa3xx_init()
  */
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 9b90461..83f3236 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -441,6 +441,7 @@ MACHINE_START(LITTLETON, "Marvell Form Factor
Development Platform (aka Littleto
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= LITTLETON_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= littleton_init,
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index d279507..fc9502e 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -509,6 +509,7 @@ MACHINE_START(LOGICPD_PXA270, "LogicPD PXA270 Card Engine")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params	= 0xa0000100,
 	.map_io		= lpd270_map_io,
+	.nr_irqs	= LPD270_NR_IRQS,
 	.init_irq	= lpd270_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= lpd270_init,
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 330c328..1956c23 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -229,7 +229,7 @@ static struct resource sa1111_resources[] = {
 };

 static struct sa1111_platform_data sa1111_info = {
-	.irq_base	= IRQ_BOARD_END,
+	.irq_base	= LUBBOCK_SA1111_IRQ_BASE,
 };

 static struct platform_device sa1111_device = {
@@ -560,6 +560,7 @@ MACHINE_START(LUBBOCK, "Intel DBPXA250 Development
Platform (aka Lubbock)")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= lubbock_map_io,
+	.nr_irqs	= LUBBOCK_NR_IRQS,
 	.init_irq	= lubbock_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= lubbock_init,
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index e81dd0c..42a0c2b 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -768,6 +768,7 @@ MACHINE_START(MAGICIAN, "HTC Magician")
 	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params = 0xa0000100,
 	.map_io = pxa_map_io,
+	.nr_irqs = MAGICIAN_NR_IRQS,
 	.init_irq = pxa27x_init_irq,
 	.init_machine = magician_init,
 	.timer = &pxa_timer,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 5543c64..c2a8717 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -628,6 +628,7 @@ MACHINE_START(MAINSTONE, "Intel HCDDBBVA0
Development Platform (aka Mainstone)")
 	.boot_params	= 0xa0000100,	/* BLOB boot parameter setting */
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= mainstone_map_io,
+	.nr_irqs	= MAINSTONE_NR_IRQS,
 	.init_irq	= mainstone_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= mainstone_init,
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index 2190af0..90b08ba 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -262,6 +262,7 @@ MACHINE_START(PCM027, "Phytec Messtechnik GmbH
phyCORE-PXA270")
 	.phys_io	= 0x40000000,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pcm027_map_io,
+	.nr_irqs	= PCM027_NR_IRQS,
 	.init_irq	= pxa27x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= pcm027_init,
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 55e8fcd..c04e025 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -469,6 +469,7 @@ MACHINE_START(POODLE, "SHARP Poodle")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup		= fixup_poodle,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= POODLE_NR_IRQS,	/* 4 for LoCoMo */
 	.init_irq	= pxa25x_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= poodle_init,
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index a654d1e..62de073 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -56,6 +56,8 @@
 #include "devices.h"
 #include "generic.h"

+#define STARGATE_NR_IRQS	(IRQ_BOARD_START + 8)
+
 /* Bluetooth */
 #define SG2_BT_RESET		81

@@ -1011,6 +1013,7 @@ MACHINE_START(STARGATE2, "Stargate 2")
 	.phys_io = 0x40000000,
 	.io_pg_offst = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io = pxa_map_io,
+	.nr_irqs = STARGATE_NR_IRQS,
 	.init_irq = pxa27x_init_irq,
 	.timer = &pxa_timer,
 	.init_machine = stargate2_init,
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 83cc3a1..3a06e98 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -956,6 +956,7 @@ MACHINE_START(TOSA, "SHARP Tosa")
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.fixup          = fixup_tosa,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= TOSA_NR_IRQS,
 	.init_irq       = pxa25x_init_irq,
 	.init_machine   = tosa_init,
 	.timer          = &pxa_timer,
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 03b9cb9..9da2b62 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -904,6 +904,7 @@ MACHINE_START(ARCOM_ZEUS, "Arcom/Eurotech ZEUS")
 	.io_pg_offst	= ((io_p2v(0x40000000) >> 18) & 0xfffc),
 	.boot_params	= 0xa0000100,
 	.map_io		= zeus_map_io,
+	.nr_irqs	= ZEUS_NR_IRQS,
 	.init_irq	= zeus_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= zeus_init,
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index c479cbe..2edad61 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -415,6 +415,7 @@ MACHINE_START(ZYLONITE, "PXA3xx Platform
Development Kit (aka Zylonite)")
 	.boot_params	= 0xa0000100,
 	.io_pg_offst	= (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.map_io		= pxa_map_io,
+	.nr_irqs	= ZYLONITE_NR_IRQS,
 	.init_irq	= pxa3xx_init_irq,
 	.timer		= &pxa_timer,
 	.init_machine	= zylonite_init,
-- 
1.5.6.5
