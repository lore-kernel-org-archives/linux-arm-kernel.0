From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 20 Aug 2010 15:23:59 +0800
Subject: [PATCH 1/1] [ARM] pxa: encode IRQ number into .nr_irqs
Message-ID: <mailman.207.1282293749.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/Kconfig                             |    1 +
 arch/arm/mach-pxa/Kconfig                    |   17 ----------
 arch/arm/mach-pxa/balloon3.c                 |    1 +
 arch/arm/mach-pxa/cm-x2xx.c                  |    4 ++
 arch/arm/mach-pxa/eseries.c                  |    7 ++++
 arch/arm/mach-pxa/ezx.c                      |    5 +++
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
 32 files changed, 59 insertions(+), 57 deletions(-)

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
index 3d4926e..357cb2f 100644
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
@@ -478,7 +468,6 @@ config MACH_POODLE
 	depends on PXA_SHARPSL
 	select PXA25x
 	select SHARP_LOCOMO
-	select PXA_HAVE_BOARD_IRQS

 config MACH_CORGI
 	bool "Enable Sharp SL-C700 (Corgi) Support"
@@ -523,7 +512,6 @@ config MACH_TOSA
 	bool "Enable Sharp SL-6000x (Tosa) Support"
 	depends on PXA_SHARPSL
 	select PXA25x
-	select PXA_HAVE_BOARD_IRQS

 config TOSA_BT
 	tristate "Control the state of built-in bluetooth chip on Sharp SL-6000"
@@ -552,7 +540,6 @@ config MACH_ICONTROL
 config ARCH_PXA_ESERIES
 	bool "PXA based Toshiba e-series PDAs"
 	select PXA25x
-	select PXA_HAVE_BOARD_IRQS

 config MACH_E330
 	bool "Toshiba e330"
@@ -606,7 +593,6 @@ config MACH_ZIPIT2
 	bool "Zipit Z2 Handheld"
 	select PXA27x
 	select HAVE_PWM
-	select PXA_HAVE_BOARD_IRQS

 endmenu

@@ -693,9 +679,6 @@ config SHARPSL_PM_MAX1111
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
index 626c82b..67dd3b7 100644
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
@@ -1124,6 +1126,7 @@ MACHINE_START(EZX_A910, "Motorola EZX A910")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = a910_init,
@@ -1190,6 +1193,7 @@ MACHINE_START(EZX_E6, "Motorola EZX E6")
 	.io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
 	.boot_params    = 0xa0000100,
 	.map_io         = pxa_map_io,
+	.nr_irqs	= EZX_NR_IRQS,
 	.init_irq       = pxa27x_init_irq,
 	.timer          = &pxa_timer,
 	.init_machine   = e6_init,
@@ -1230,6 +1234,7 @@ MACHINE_START(EZX_E2, "Motorola EZX E2")
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

--0016e649c9eae341ba048e3d46dc
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001--ARM-pxa-encode-IRQ-number-into-.nr_irqs.patch"
Content-Disposition: attachment; 
	filename="0001--ARM-pxa-encode-IRQ-number-into-.nr_irqs.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd2scj8c0

RnJvbSA3ZjY5ZTZlMzFkMmJmMzRiYmYxNTZlOTM4NWRhYmEwODA3OWFhMzhjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW9qaWFuIFpodWFuZyA8aGFvamlhbi56aHVhbmdAbWFydmVs
bC5jb20+CkRhdGU6IEZyaSwgMjAgQXVnIDIwMTAgMTU6MjM6NTkgKzA4MDAKU3ViamVjdDogW1BB
VENIIDEvMV0gW0FSTV0gcHhhOiBlbmNvZGUgSVJRIG51bWJlciBpbnRvIC5ucl9pcnFzCgpTaWdu
ZWQtb2ZmLWJ5OiBFcmljIE1pYW8gPGVyaWMueS5taWFvQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1i
eTogSGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQG1hcnZlbGwuY29tPgotLS0KIGFyY2gv
YXJtL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArCiBhcmNoL2Fy
bS9tYWNoLXB4YS9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAgMTcgLS0tLS0tLS0tLQog
YXJjaC9hcm0vbWFjaC1weGEvYmFsbG9vbjMuYyAgICAgICAgICAgICAgICAgfCAgICAxICsKIGFy
Y2gvYXJtL21hY2gtcHhhL2NtLXgyeHguYyAgICAgICAgICAgICAgICAgIHwgICAgNCArKwogYXJj
aC9hcm0vbWFjaC1weGEvZXNlcmllcy5jICAgICAgICAgICAgICAgICAgfCAgICA3ICsrKysKIGFy
Y2gvYXJtL21hY2gtcHhhL2V6eC5jICAgICAgICAgICAgICAgICAgICAgIHwgICAgNSArKysKIGFy
Y2gvYXJtL21hY2gtcHhhL2h4NDcwMC5jICAgICAgICAgICAgICAgICAgIHwgICAgMSArCiBhcmNo
L2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvYmFsbG9vbjMuaCAgICB8ICAgIDIgKwogYXJjaC9h
cm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2VzZXJpZXMtaXJxLmggfCAgICAxICsKIGFyY2gvYXJt
L21hY2gtcHhhL2luY2x1ZGUvbWFjaC9oeDQ3MDAuaCAgICAgIHwgICAgMSArCiBhcmNoL2FybS9t
YWNoLXB4YS9pbmNsdWRlL21hY2gvaXJxcy5oICAgICAgICB8ICAgNDIgKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIGFyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9saXR0bGV0b24uaCAg
IHwgICAgMiArCiBhcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvbHBkMjcwLmggICAgICB8
ICAgIDEgKwogYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2x1YmJvY2suaCAgICAgfCAg
ICAzICsrCiBhcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvbWFnaWNpYW4uaCAgICB8ICAg
IDIgKwogYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL21haW5zdG9uZS5oICAgfCAgICAy
ICsKIGFyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9wY20wMjcuaCAgICAgIHwgICAgMiAr
CiBhcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvcG9vZGxlLmggICAgICB8ICAgIDIgKwog
YXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3Rvc2EuaCAgICAgICAgfCAgICAxICsKIGFy
Y2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC96ZXVzLmggICAgICAgIHwgICAgMiArCiBhcmNo
L2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvenlsb25pdGUuaCAgICB8ICAgIDIgKwogYXJjaC9h
cm0vbWFjaC1weGEvbGl0dGxldG9uLmMgICAgICAgICAgICAgICAgfCAgICAxICsKIGFyY2gvYXJt
L21hY2gtcHhhL2xwZDI3MC5jICAgICAgICAgICAgICAgICAgIHwgICAgMSArCiBhcmNoL2FybS9t
YWNoLXB4YS9sdWJib2NrLmMgICAgICAgICAgICAgICAgICB8ICAgIDMgKy0KIGFyY2gvYXJtL21h
Y2gtcHhhL21hZ2ljaWFuLmMgICAgICAgICAgICAgICAgIHwgICAgMSArCiBhcmNoL2FybS9tYWNo
LXB4YS9tYWluc3RvbmUuYyAgICAgICAgICAgICAgICB8ICAgIDEgKwogYXJjaC9hcm0vbWFjaC1w
eGEvcGNtMDI3LmMgICAgICAgICAgICAgICAgICAgfCAgICAxICsKIGFyY2gvYXJtL21hY2gtcHhh
L3Bvb2RsZS5jICAgICAgICAgICAgICAgICAgIHwgICAgMSArCiBhcmNoL2FybS9tYWNoLXB4YS9z
dGFyZ2F0ZTIuYyAgICAgICAgICAgICAgICB8ICAgIDMgKysKIGFyY2gvYXJtL21hY2gtcHhhL3Rv
c2EuYyAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArCiBhcmNoL2FybS9tYWNoLXB4YS96ZXVz
LmMgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKwogYXJjaC9hcm0vbWFjaC1weGEvenlsb25p
dGUuYyAgICAgICAgICAgICAgICAgfCAgICAxICsKIDMyIGZpbGVzIGNoYW5nZWQsIDU5IGluc2Vy
dGlvbnMoKyksIDU3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL0tjb25maWcg
Yi9hcmNoL2FybS9LY29uZmlnCmluZGV4IDkyOTUxMTAuLjQ1ZjkzZTEgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL0tjb25maWcKKysrIGIvYXJjaC9hcm0vS2NvbmZpZwpAQCAtNTg4LDYgKzU4OCw3IEBA
IGNvbmZpZyBBUkNIX1BYQQogCXNlbGVjdCBHRU5FUklDX0NMT0NLRVZFTlRTCiAJc2VsZWN0IFRJ
Q0tfT05FU0hPVAogCXNlbGVjdCBQTEFUX1BYQQorCXNlbGVjdCBTUEFSU0VfSVJRCiAJaGVscAog
CSAgU3VwcG9ydCBmb3IgSW50ZWwvTWFydmVsbCdzIFBYQTJ4eC9QWEEzeHggcHJvY2Vzc29yIGxp
bmUuCiAKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL0tjb25maWcgYi9hcmNoL2FybS9t
YWNoLXB4YS9LY29uZmlnCmluZGV4IDNkNDkyNmUuLjM1N2NiMmYgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL21hY2gtcHhhL0tjb25maWcKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEvS2NvbmZpZwpAQCAt
OCwxOSArOCwxNiBAQCBjb25maWcgQVJDSF9MVUJCT0NLCiAJYm9vbCAiSW50ZWwgREJQWEEyNTAg
RGV2ZWxvcG1lbnQgUGxhdGZvcm0gKGFrYSBMdWJib2NrKSIKIAlzZWxlY3QgUFhBMjV4CiAJc2Vs
ZWN0IFNBMTExMQotCXNlbGVjdCBQWEFfSEFWRV9CT0FSRF9JUlFTCiAKIGNvbmZpZyBNQUNIX01B
SU5TVE9ORQogCWJvb2wgIkludGVsIEhDRERCQlZBMCBEZXZlbG9wbWVudCBQbGF0Zm9ybSAoYWth
IE1haW5zdG9uZSkiCiAJc2VsZWN0IFBYQTI3eAogCXNlbGVjdCBIQVZFX1BXTQotCXNlbGVjdCBQ
WEFfSEFWRV9CT0FSRF9JUlFTCiAKIGNvbmZpZyBNQUNIX1pZTE9OSVRFCiAJYm9vbAogCXNlbGVj
dCBQWEEzeHgKIAlzZWxlY3QgSEFWRV9QV00KLQlzZWxlY3QgUFhBX0hBVkVfQk9BUkRfSVJRUwog
CiBjb25maWcgTUFDSF9aWUxPTklURTMwMAogCWJvb2wgIlBYQTN4eCBEZXZlbG9wbWVudCBQbGF0
Zm9ybSAoYWthIFp5bG9uaXRlKSBQWEEzMDAvMzEwIgpAQCAtNjEsNyArNTgsNiBAQCBjb25maWcg
QVJDSF9WSVBFUgogCXNlbGVjdCBJU0EKIAlzZWxlY3QgSTJDX0dQSU8KIAlzZWxlY3QgSEFWRV9Q
V00KLQlzZWxlY3QgUFhBX0hBVkVfQk9BUkRfSVJRUwogCXNlbGVjdCBQWEFfSEFWRV9JU0FfSVJR
UwogCXNlbGVjdCBBUkNPTV9QQ01DSUEKIApAQCAtNjksNyArNjUsNiBAQCBjb25maWcgTUFDSF9B
UkNPTV9aRVVTCiAJYm9vbCAiQXJjb20vRXVyb3RlY2ggWkVVUyBTQkMiCiAJc2VsZWN0IFBYQTI3
eAogCXNlbGVjdCBJU0EKLQlzZWxlY3QgUFhBX0hBVkVfQk9BUkRfSVJRUwogCXNlbGVjdCBQWEFf
SEFWRV9JU0FfSVJRUwogCXNlbGVjdCBBUkNPTV9QQ01DSUEKIApAQCAtNzcsNyArNzIsNiBAQCBj
b25maWcgTUFDSF9CQUxMT09OMwogCWJvb2wgIkJhbGxvb24gMyBib2FyZCIKIAlzZWxlY3QgUFhB
Mjd4CiAJc2VsZWN0IElXTU1YVAotCXNlbGVjdCBQWEFfSEFWRV9CT0FSRF9JUlFTCiAKIGNvbmZp
ZyBNQUNIX0NTQjcyNgogCWJvb2wgIkVuYWJsZSBDb2dlbnQgQ1NCNzI2IFN5c3RlbSBPbiBhIE1v
ZHVsZSIKQEAgLTE0MCwxMyArMTM0LDExIEBAIGNvbmZpZyBNQUNIX0lOVEVMTU9URTIKIAlib29s
ICJJbnRlbCBNb3RlIDIgUGxhdGZvcm0iCiAJc2VsZWN0IFBYQTI3eAogCXNlbGVjdCBJV01NWFQK
LQlzZWxlY3QgUFhBX0hBVkVfQk9BUkRfSVJRUwogCiBjb25maWcgTUFDSF9TVEFSR0FURTIKIAli
b29sICJJbnRlbCBTdGFyZ2F0ZSAyIFBsYXRmb3JtIgogCXNlbGVjdCBQWEEyN3gKIAlzZWxlY3Qg
SVdNTVhUCi0Jc2VsZWN0IFBYQV9IQVZFX0JPQVJEX0lSUVMKIAogY29uZmlnIE1BQ0hfWENFUAog
CWJvb2wgIklza3JhdGVsIEVsZWN0cm9uaWNzIFhDRVAiCkBAIC0yMDYsMTMgKzE5OCwxMSBAQCBj
b25maWcgTUFDSF9MT0dJQ1BEX1BYQTI3MAogCWJvb2wgIkxvZ2ljUEQgUFhBMjcwIENhcmQgRW5n
aW5lIERldmVsb3BtZW50IFBsYXRmb3JtIgogCXNlbGVjdCBQWEEyN3gKIAlzZWxlY3QgSEFWRV9Q
V00KLQlzZWxlY3QgUFhBX0hBVkVfQk9BUkRfSVJRUwogCiBjb25maWcgTUFDSF9QQ00wMjcKIAli
b29sICJQaHl0ZWMgcGh5Q09SRS1QWEEyNzAgQ1BVIG1vZHVsZSAoUENNLTAyNykiCiAJc2VsZWN0
IFBYQTI3eAogCXNlbGVjdCBJV01NWFQKLQlzZWxlY3QgUFhBX0hBVkVfQk9BUkRfSVJRUwogCiBj
b25maWcgTUFDSF9QQ005OTBfQkFTRUJPQVJECiAJYm9vbCAiUEhZVEVDIFBDTS05OTAgZGV2ZWxv
cG1lbnQgYm9hcmQiCkBAIC00NzgsNyArNDY4LDYgQEAgY29uZmlnIE1BQ0hfUE9PRExFCiAJZGVw
ZW5kcyBvbiBQWEFfU0hBUlBTTAogCXNlbGVjdCBQWEEyNXgKIAlzZWxlY3QgU0hBUlBfTE9DT01P
Ci0Jc2VsZWN0IFBYQV9IQVZFX0JPQVJEX0lSUVMKIAogY29uZmlnIE1BQ0hfQ09SR0kKIAlib29s
ICJFbmFibGUgU2hhcnAgU0wtQzcwMCAoQ29yZ2kpIFN1cHBvcnQiCkBAIC01MjMsNyArNTEyLDYg
QEAgY29uZmlnIE1BQ0hfVE9TQQogCWJvb2wgIkVuYWJsZSBTaGFycCBTTC02MDAweCAoVG9zYSkg
U3VwcG9ydCIKIAlkZXBlbmRzIG9uIFBYQV9TSEFSUFNMCiAJc2VsZWN0IFBYQTI1eAotCXNlbGVj
dCBQWEFfSEFWRV9CT0FSRF9JUlFTCiAKIGNvbmZpZyBUT1NBX0JUCiAJdHJpc3RhdGUgIkNvbnRy
b2wgdGhlIHN0YXRlIG9mIGJ1aWx0LWluIGJsdWV0b290aCBjaGlwIG9uIFNoYXJwIFNMLTYwMDAi
CkBAIC01NTIsNyArNTQwLDYgQEAgY29uZmlnIE1BQ0hfSUNPTlRST0wKIGNvbmZpZyBBUkNIX1BY
QV9FU0VSSUVTCiAJYm9vbCAiUFhBIGJhc2VkIFRvc2hpYmEgZS1zZXJpZXMgUERBcyIKIAlzZWxl
Y3QgUFhBMjV4Ci0Jc2VsZWN0IFBYQV9IQVZFX0JPQVJEX0lSUVMKIAogY29uZmlnIE1BQ0hfRTMz
MAogCWJvb2wgIlRvc2hpYmEgZTMzMCIKQEAgLTYwNiw3ICs1OTMsNiBAQCBjb25maWcgTUFDSF9a
SVBJVDIKIAlib29sICJaaXBpdCBaMiBIYW5kaGVsZCIKIAlzZWxlY3QgUFhBMjd4CiAJc2VsZWN0
IEhBVkVfUFdNCi0Jc2VsZWN0IFBYQV9IQVZFX0JPQVJEX0lSUVMKIAogZW5kbWVudQogCkBAIC02
OTMsOSArNjc5LDYgQEAgY29uZmlnIFNIQVJQU0xfUE1fTUFYMTExMQogCXNlbGVjdCBIV01PTgog
CXNlbGVjdCBTRU5TT1JTX01BWDExMTEKIAotY29uZmlnIFBYQV9IQVZFX0JPQVJEX0lSUVMKLQli
b29sCi0KIGNvbmZpZyBQWEFfSEFWRV9JU0FfSVJRUwogCWJvb2wKIApkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC1weGEvYmFsbG9vbjMuYyBiL2FyY2gvYXJtL21hY2gtcHhhL2JhbGxvb24zLmMK
aW5kZXggOTA0MTM0MC4uMmI4MWU2NCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvYmFs
bG9vbjMuYworKysgYi9hcmNoL2FybS9tYWNoLXB4YS9iYWxsb29uMy5jCkBAIC03NzksNiArNzc5
LDcgQEAgTUFDSElORV9TVEFSVChCQUxMT09OMywgIkJhbGxvb24zIikKIAkucGh5c19pbwk9IDB4
NDAwMDAwMDAsCiAJLmlvX3BnX29mZnN0CT0gKGlvX3AydigweDQwMDAwMDAwKSA+PiAxOCkgJiAw
eGZmZmMsCiAJLm1hcF9pbwkJPSBiYWxsb29uM19tYXBfaW8sCisJLm5yX2lycXMJPSBCQUxMT09O
M19OUl9JUlFTLAogCS5pbml0X2lycQk9IGJhbGxvb24zX2luaXRfaXJxLAogCS50aW1lcgkJPSAm
cHhhX3RpbWVyLAogCS5pbml0X21hY2hpbmUJPSBiYWxsb29uM19pbml0LApkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vbWFjaC1weGEvY20teDJ4eC5jIGIvYXJjaC9hcm0vbWFjaC1weGEvY20teDJ4eC5j
CmluZGV4IGJmZjZlNzguLmFkNDBlN2IgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL2Nt
LXgyeHguYworKysgYi9hcmNoL2FybS9tYWNoLXB4YS9jbS14Mnh4LmMKQEAgLTMzLDYgKzMzLDkg
QEAKIGV4dGVybiB2b2lkIGNteDI1NV9pbml0KHZvaWQpOwogZXh0ZXJuIHZvaWQgY214MjcwX2lu
aXQodm9pZCk7CiAKKy8qIHJlc2VydmUgSVJRcyBmb3IgSVQ4MTUyICovCisjZGVmaW5lIENNWDJY
WF9OUl9JUlFTCQkoSVJRX0JPQVJEX1NUQVJUICsgNDApCisKIC8qIHZpcnR1YWwgYWRkcmVzc2Vz
IGZvciBzdGF0aWNhbGx5IG1hcHBlZCByZWdpb25zICovCiAjZGVmaW5lIENNWDJYWF9WSVJUX0JB
U0UJKDB4ZTgwMDAwMDApCiAjZGVmaW5lIENNWDJYWF9JVDgxNTJfVklSVAkoQ01YMlhYX1ZJUlRf
QkFTRSkKQEAgLTUxNCw2ICs1MTcsNyBAQCBNQUNISU5FX1NUQVJUKEFSTUNPUkUsICJDb21wdWxh
YiBDTS1YMlhYIikKIAkucGh5c19pbwk9IDB4NDAwMDAwMDAsCiAJLmlvX3BnX29mZnN0CT0gKGlv
X3AydigweDQwMDAwMDAwKSA+PiAxOCkgJiAweGZmZmMsCiAJLm1hcF9pbwkJPSBjbXgyeHhfbWFw
X2lvLAorCS5ucl9pcnFzCT0gQ01YMlhYX05SX0lSUVMsCiAJLmluaXRfaXJxCT0gY214Mnh4X2lu
aXRfaXJxLAogCS50aW1lcgkJPSAmcHhhX3RpbWVyLAogCS5pbml0X21hY2hpbmUJPSBjbXgyeHhf
aW5pdCwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL2VzZXJpZXMuYyBiL2FyY2gvYXJt
L21hY2gtcHhhL2VzZXJpZXMuYwppbmRleCAzNDkyMTJhLi40OTcxY2UxIDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLXB4YS9lc2VyaWVzLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEvZXNlcmll
cy5jCkBAIC0yOSw2ICsyOSw3IEBACiAKICNpbmNsdWRlIDxtYWNoL3B4YTI1eC5oPgogI2luY2x1
ZGUgPG1hY2gvZXNlcmllcy1ncGlvLmg+CisjaW5jbHVkZSA8bWFjaC9lc2VyaWVzLWlycS5oPgog
I2luY2x1ZGUgPG1hY2gvYXVkaW8uaD4KICNpbmNsdWRlIDxtYWNoL3B4YWZiLmg+CiAjaW5jbHVk
ZSA8bWFjaC91ZGMuaD4KQEAgLTE4Myw2ICsxODQsNyBAQCBNQUNISU5FX1NUQVJUKEUzMzAsICJU
b3NoaWJhIGUzMzAiKQogCS5pb19wZ19vZmZzdAk9IChpb19wMnYoMHg0MDAwMDAwMCkgPj4gMTgp
ICYgMHhmZmZjLAogCS5ib290X3BhcmFtcwk9IDB4YTAwMDAxMDAsCiAJLm1hcF9pbwkJPSBweGFf
bWFwX2lvLAorCS5ucl9pcnFzCT0gRVNFUklFU19OUl9JUlFTLAogCS5pbml0X2lycQk9IHB4YTI1
eF9pbml0X2lycSwKIAkuZml4dXAJCT0gZXNlcmllc19maXh1cCwKIAkuaW5pdF9tYWNoaW5lCT0g
ZTMzMF9pbml0LApAQCAtMjMzLDYgKzIzNSw3IEBAIE1BQ0hJTkVfU1RBUlQoRTM1MCwgIlRvc2hp
YmEgZTM1MCIpCiAJLmlvX3BnX29mZnN0CT0gKGlvX3AydigweDQwMDAwMDAwKSA+PiAxOCkgJiAw
eGZmZmMsCiAJLmJvb3RfcGFyYW1zCT0gMHhhMDAwMDEwMCwKIAkubWFwX2lvCQk9IHB4YV9tYXBf
aW8sCisJLm5yX2lycXMJPSBFU0VSSUVTX05SX0lSUVMsCiAJLmluaXRfaXJxCT0gcHhhMjV4X2lu
aXRfaXJxLAogCS5maXh1cAkJPSBlc2VyaWVzX2ZpeHVwLAogCS5pbml0X21hY2hpbmUJPSBlMzUw
X2luaXQsCkBAIC0zNTYsNiArMzU5LDcgQEAgTUFDSElORV9TVEFSVChFNDAwLCAiVG9zaGliYSBl
NDAwIikKIAkuaW9fcGdfb2Zmc3QJPSAoaW9fcDJ2KDB4NDAwMDAwMDApID4+IDE4KSAmIDB4ZmZm
YywKIAkuYm9vdF9wYXJhbXMJPSAweGEwMDAwMTAwLAogCS5tYXBfaW8JCT0gcHhhX21hcF9pbywK
KwkubnJfaXJxcwk9IEVTRVJJRVNfTlJfSVJRUywKIAkuaW5pdF9pcnEJPSBweGEyNXhfaW5pdF9p
cnEsCiAJLmZpeHVwCQk9IGVzZXJpZXNfZml4dXAsCiAJLmluaXRfbWFjaGluZQk9IGU0MDBfaW5p
dCwKQEAgLTU0NSw2ICs1NDksNyBAQCBNQUNISU5FX1NUQVJUKEU3NDAsICJUb3NoaWJhIGU3NDAi
KQogCS5pb19wZ19vZmZzdAk9IChpb19wMnYoMHg0MDAwMDAwMCkgPj4gMTgpICYgMHhmZmZjLAog
CS5ib290X3BhcmFtcwk9IDB4YTAwMDAxMDAsCiAJLm1hcF9pbwkJPSBweGFfbWFwX2lvLAorCS5u
cl9pcnFzCT0gRVNFUklFU19OUl9JUlFTLAogCS5pbml0X2lycQk9IHB4YTI1eF9pbml0X2lycSwK
IAkuZml4dXAJCT0gZXNlcmllc19maXh1cCwKIAkuaW5pdF9tYWNoaW5lCT0gZTc0MF9pbml0LApA
QCAtNzM3LDYgKzc0Miw3IEBAIE1BQ0hJTkVfU1RBUlQoRTc1MCwgIlRvc2hpYmEgZTc1MCIpCiAJ
LmlvX3BnX29mZnN0CT0gKGlvX3AydigweDQwMDAwMDAwKSA+PiAxOCkgJiAweGZmZmMsCiAJLmJv
b3RfcGFyYW1zCT0gMHhhMDAwMDEwMCwKIAkubWFwX2lvCQk9IHB4YV9tYXBfaW8sCisJLm5yX2ly
cXMJPSBFU0VSSUVTX05SX0lSUVMsCiAJLmluaXRfaXJxCT0gcHhhMjV4X2luaXRfaXJxLAogCS5m
aXh1cAkJPSBlc2VyaWVzX2ZpeHVwLAogCS5pbml0X21hY2hpbmUJPSBlNzUwX2luaXQsCkBAIC05
MzMsNiArOTM5LDcgQEAgTUFDSElORV9TVEFSVChFODAwLCAiVG9zaGliYSBlODAwIikKIAkuaW9f
cGdfb2Zmc3QJPSAoaW9fcDJ2KDB4NDAwMDAwMDApID4+IDE4KSAmIDB4ZmZmYywKIAkuYm9vdF9w
YXJhbXMJPSAweGEwMDAwMTAwLAogCS5tYXBfaW8JCT0gcHhhX21hcF9pbywKKwkubnJfaXJxcwk9
IEVTRVJJRVNfTlJfSVJRUywKIAkuaW5pdF9pcnEJPSBweGEyNXhfaW5pdF9pcnEsCiAJLmZpeHVw
CQk9IGVzZXJpZXNfZml4dXAsCiAJLmluaXRfbWFjaGluZQk9IGU4MDBfaW5pdCwKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtcHhhL2V6eC5jIGIvYXJjaC9hcm0vbWFjaC1weGEvZXp4LmMKaW5k
ZXggNjI2YzgyYi4uNjdkZDNiNyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvZXp4LmMK
KysrIGIvYXJjaC9hcm0vbWFjaC1weGEvZXp4LmMKQEAgLTM4LDYgKzM4LDggQEAKICNpbmNsdWRl
ICJkZXZpY2VzLmgiCiAjaW5jbHVkZSAiZ2VuZXJpYy5oIgogCisjZGVmaW5lIEVaWF9OUl9JUlFT
CQkJKElSUV9CT0FSRF9TVEFSVCArIDI0KQorCiAjZGVmaW5lIEdQSU8xMl9BNzgwX0ZMSVBfTElE
IAkJMTIKICNkZWZpbmUgR1BJTzE1X0ExMjAwX0ZMSVBfTElEIAkJMTUKICNkZWZpbmUgR1BJTzE1
X0E5MTBfRkxJUF9MSUQgCQkxNQpAQCAtMTEyNCw2ICsxMTI2LDcgQEAgTUFDSElORV9TVEFSVChF
WlhfQTkxMCwgIk1vdG9yb2xhIEVaWCBBOTEwIikKIAkuaW9fcGdfb2Zmc3QgICAgPSAoaW9fcDJ2
KDB4NDAwMDAwMDApID4+IDE4KSAmIDB4ZmZmYywKIAkuYm9vdF9wYXJhbXMgICAgPSAweGEwMDAw
MTAwLAogCS5tYXBfaW8gICAgICAgICA9IHB4YV9tYXBfaW8sCisJLm5yX2lycXMJPSBFWlhfTlJf
SVJRUywKIAkuaW5pdF9pcnEgICAgICAgPSBweGEyN3hfaW5pdF9pcnEsCiAJLnRpbWVyICAgICAg
ICAgID0gJnB4YV90aW1lciwKIAkuaW5pdF9tYWNoaW5lICAgPSBhOTEwX2luaXQsCkBAIC0xMTkw
LDYgKzExOTMsNyBAQCBNQUNISU5FX1NUQVJUKEVaWF9FNiwgIk1vdG9yb2xhIEVaWCBFNiIpCiAJ
LmlvX3BnX29mZnN0ICAgID0gKGlvX3AydigweDQwMDAwMDAwKSA+PiAxOCkgJiAweGZmZmMsCiAJ
LmJvb3RfcGFyYW1zICAgID0gMHhhMDAwMDEwMCwKIAkubWFwX2lvICAgICAgICAgPSBweGFfbWFw
X2lvLAorCS5ucl9pcnFzCT0gRVpYX05SX0lSUVMsCiAJLmluaXRfaXJxICAgICAgID0gcHhhMjd4
X2luaXRfaXJxLAogCS50aW1lciAgICAgICAgICA9ICZweGFfdGltZXIsCiAJLmluaXRfbWFjaGlu
ZSAgID0gZTZfaW5pdCwKQEAgLTEyMzAsNiArMTIzNCw3IEBAIE1BQ0hJTkVfU1RBUlQoRVpYX0Uy
LCAiTW90b3JvbGEgRVpYIEUyIikKIAkuaW9fcGdfb2Zmc3QgICAgPSAoaW9fcDJ2KDB4NDAwMDAw
MDApID4+IDE4KSAmIDB4ZmZmYywKIAkuYm9vdF9wYXJhbXMgICAgPSAweGEwMDAwMTAwLAogCS5t
YXBfaW8gICAgICAgICA9IHB4YV9tYXBfaW8sCisJLm5yX2lycXMJPSBFWlhfTlJfSVJRUywKIAku
aW5pdF9pcnEgICAgICAgPSBweGEyN3hfaW5pdF9pcnEsCiAJLnRpbWVyICAgICAgICAgID0gJnB4
YV90aW1lciwKIAkuaW5pdF9tYWNoaW5lICAgPSBlMl9pbml0LApkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbWFjaC1weGEvaHg0NzAwLmMgYi9hcmNoL2FybS9tYWNoLXB4YS9oeDQ3MDAuYwppbmRleCA4
NDhjODYxLi4xMDEwNGYxIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLXB4YS9oeDQ3MDAuYwor
KysgYi9hcmNoL2FybS9tYWNoLXB4YS9oeDQ3MDAuYwpAQCAtODc0LDYgKzg3NCw3IEBAIE1BQ0hJ
TkVfU1RBUlQoSDQ3MDAsICJIUCBpUEFRIEhYNDcwMCIpCiAJLmlvX3BnX29mZnN0ICA9IChpb19w
MnYoMHg0MDAwMDAwMCkgPj4gMTgpICYgMHhmZmZjLAogCS5ib290X3BhcmFtcyAgPSAweGEwMDAw
MTAwLAogCS5tYXBfaW8gICAgICAgPSBweGFfbWFwX2lvLAorCS5ucl9pcnFzICAgICAgPSBIWDQ3
MDBfTlJfSVJRUywKIAkuaW5pdF9pcnEgICAgID0gcHhhMjd4X2luaXRfaXJxLAogCS5pbml0X21h
Y2hpbmUgPSBoeDQ3MDBfaW5pdCwKIAkudGltZXIgICAgICAgID0gJnB4YV90aW1lciwKZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9iYWxsb29uMy5oIGIvYXJjaC9h
cm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2JhbGxvb24zLmgKaW5kZXggZWVjOTJlNi4uNTYxNTYy
YiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2JhbGxvb24zLmgK
KysrIGIvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2JhbGxvb24zLmgKQEAgLTE3NCw2
ICsxNzQsOCBAQCBlbnVtIGJhbGxvb24zX2ZlYXR1cmVzIHsKICNkZWZpbmUgQkFMTE9PTjNfQ09E
RUNfSVJRCUlSUV9HUElPKEJBTExPT04zX0dQSU9fQ09ERUNfSVJRKQogI2RlZmluZSBCQUxMT09O
M19TMF9DRF9JUlEJSVJRX0dQSU8oQkFMTE9PTjNfR1BJT19TMF9DRCkKIAorI2RlZmluZSBCQUxM
T09OM19OUl9JUlFTCShJUlFfQk9BUkRfU1RBUlQgKyA0KQorCiBleHRlcm4gaW50IGJhbGxvb24z
X2hhcyhlbnVtIGJhbGxvb24zX2ZlYXR1cmVzIGZlYXR1cmUpOwogCiAjZW5kaWYKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9lc2VyaWVzLWlycS5oIGIvYXJjaC9h
cm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2VzZXJpZXMtaXJxLmgKaW5kZXggZjJhOTNkNS4uZGUy
OTJiMiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2VzZXJpZXMt
aXJxLmgKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2VzZXJpZXMtaXJxLmgK
QEAgLTI1LDMgKzI1LDQgQEAKICNkZWZpbmUgVE1JT19TRF9JUlEgICAgIElSUV9UTUlPKDEpCiAj
ZGVmaW5lIFRNSU9fVVNCX0lSUSAgICBJUlFfVE1JTygyKQogCisjZGVmaW5lIEVTRVJJRVNfTlJf
SVJRUwkoSVJRX0JPQVJEX1NUQVJUICsgMTYpCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXB4
YS9pbmNsdWRlL21hY2gvaHg0NzAwLmggYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gv
aHg0NzAwLmgKaW5kZXggOWVhZWVkMS4uMzc0MDg0NCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFj
aC1weGEvaW5jbHVkZS9tYWNoL2h4NDcwMC5oCisrKyBiL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1
ZGUvbWFjaC9oeDQ3MDAuaApAQCAtMTcsNiArMTcsNyBAQAogCiAjZGVmaW5lIEhYNDcwMF9BU0lD
M19HUElPX0JBU0UJTlJfQlVJTFRJTl9HUElPCiAjZGVmaW5lIEhYNDcwMF9FR1BJT19CQVNFCShI
WDQ3MDBfQVNJQzNfR1BJT19CQVNFICsgQVNJQzNfTlVNX0dQSU9TKQorI2RlZmluZSBIWDQ3MDBf
TlJfSVJRUwkJKElSUV9CT0FSRF9TVEFSVCArIDcwKQogCiAvKgogICogUFhBIEdQSU9zCmRpZmYg
LS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvaXJxcy5oIGIvYXJjaC9hcm0v
bWFjaC1weGEvaW5jbHVkZS9tYWNoL2lycXMuaAppbmRleCBmZmM4MzE0Li5kMzcyY2FhIDEwMDY0
NAotLS0gYS9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvaXJxcy5oCisrKyBiL2FyY2gv
YXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9pcnFzLmgKQEAgLTExNyw0OCArMTE3LDEyIEBACiAv
KgogICogVGhlIGZvbGxvd2luZyBpbnRlcnJ1cHRzIGFyZSBmb3IgYm9hcmQgc3BlY2lmaWMgcHVy
cG9zZXMuIFNpbmNlCiAgKiB0aGUga2VybmVsIGNhbiBvbmx5IHJ1biBvbiBvbmUgbWFjaGluZSBh
dCBhIHRpbWUsIHdlIGNhbiByZS11c2UKLSAqIHRoZXNlLiAgVGhlcmUgd2lsbCBiZSAxNiBJUlFz
IGJ5IGRlZmF1bHQuICBJZiBpdCBpcyBub3QgZW5vdWdoLAotICogSVJRX0JPQVJEX0VORCBpcyBh
bGxvd2VkIGJlIGN1c3RvbWl6ZWQgZm9yIGVhY2ggYm9hcmQsIGJ1dCBrZWVwCi0gKiB0aGUgbnVt
YmVycyB3aXRoaW4gc2Vuc2libGUgbGltaXRzIGFuZCBpbiBkZXNjZW5kaW5nIG9yZGVyLCBzbwot
ICogd2hlbiBtdWx0aXBsZSBjb25maWcgb3B0aW9ucyBhcmUgc2VsZWN0ZWQsIHRoZSBtYXhpbXVt
IHdpbGwgYmUKLSAqIHVzZWQuCisgKiB0aGVzZS4KKyAqIEJ5IGRlZmF1bHQsIG5vIGJvYXJkIElS
USBpcyByZXNlcnZlZC4gSXQgc2hvdWxkIGJlIGZpbmlzaGVkIGluCisgKiBjdXN0b20gYm9hcmQg
c2luY2Ugc3BhcnNlIElSUSBpcyBhbHJlYWR5IGVuYWJsZWQuCiAgKi8KICNkZWZpbmUgSVJRX0JP
QVJEX1NUQVJUCQkoUFhBX0dQSU9fSVJRX0JBU0UgKyBQWEFfR1BJT19JUlFfTlVNKQogCi0jaWYg
ZGVmaW5lZChDT05GSUdfTUFDSF9INDcwMCkKLSNkZWZpbmUgSVJRX0JPQVJEX0VORAkJKElSUV9C
T0FSRF9TVEFSVCArIDcwKQotI2VsaWYgZGVmaW5lZChDT05GSUdfTUFDSF9aWUxPTklURSkKLSNk
ZWZpbmUgSVJRX0JPQVJEX0VORAkJKElSUV9CT0FSRF9TVEFSVCArIDMyKQotI2VsaWYgZGVmaW5l
ZChDT05GSUdfUFhBX0VaWCkKLSNkZWZpbmUgSVJRX0JPQVJEX0VORAkJKElSUV9CT0FSRF9TVEFS
VCArIDIzKQotI2Vsc2UKLSNkZWZpbmUgSVJRX0JPQVJEX0VORAkJKElSUV9CT0FSRF9TVEFSVCAr
IDE2KQotI2VuZGlmCi0KLS8qCi0gKiBGaWd1cmUgb3V0IHRoZSBNQVggSVJRIG51bWJlci4KLSAq
Ci0gKiBJZiB3ZSBoYXZlIGFuIFNBMTExMSwgdGhlIG1heCBJUlEgaXMgUzFfQlZEMV9TVFNDSEcr
MS4KLSAqIElmIHdlIGhhdmUgYW4gTG9Db01vLCB0aGUgbWF4IElSUSBpcyBJUlFfTE9DT01PX1NQ
SV9URU5EKzEKLSAqIE90aGVyd2lzZSwgd2UgaGF2ZSB0aGUgc3RhbmRhcmQgSVJRcyBvbmx5Lgot
ICovCi0jaWZkZWYgQ09ORklHX1NBMTExMQotI2RlZmluZSBOUl9JUlFTCQkJKElSUV9CT0FSRF9F
TkQgKyA1NSkKLSNlbGlmIGRlZmluZWQoQ09ORklHX1BYQV9IQVZFX0JPQVJEX0lSUVMpCi0jZGVm
aW5lIE5SX0lSUVMJCQkoSVJRX0JPQVJEX0VORCkKLSNlbHNlCiAjZGVmaW5lIE5SX0lSUVMJCQko
SVJRX0JPQVJEX1NUQVJUKQotI2VuZGlmCi0KLS8qIGFkZCBJVDgxNTIgSVJRcyBiZXlvbmQgQk9B
UkRfRU5EICovCi0jaWZkZWYgQ09ORklHX1BDSV9IT1NUX0lURTgxNTIKLSNkZWZpbmUgSVQ4MTUy
X0xBU1RfSVJRICAgICAgICAgKElSUV9CT0FSRF9FTkQgKyA0MCkKLQotI2lmIE5SX0lSUVMgPCAo
SVQ4MTUyX0xBU1RfSVJRKzEpCi0jdW5kZWYgTlJfSVJRUwotI2RlZmluZSBOUl9JUlFTIChJVDgx
NTJfTEFTVF9JUlErMSkKLSNlbmRpZgotCi0jZW5kaWYgLyogQ09ORklHX1BDSV9IT1NUX0lURTgx
NTIgKi8KIAogI2VuZGlmIC8qIF9fQVNNX01BQ0hfSVJRU19IICovCmRpZmYgLS1naXQgYS9hcmNo
L2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvbGl0dGxldG9uLmggYi9hcmNoL2FybS9tYWNoLXB4
YS9pbmNsdWRlL21hY2gvbGl0dGxldG9uLmgKaW5kZXggNmM5YjIxYy4uMmE1NzI2YyAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2xpdHRsZXRvbi5oCisrKyBiL2Fy
Y2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9saXR0bGV0b24uaApAQCAtMTAsNCArMTAsNiBA
QAogI2RlZmluZSBFWFQwX0dQSU9fQkFTRQkoTlJfQlVJTFRJTl9HUElPKQogI2RlZmluZSBFWFQw
X0dQSU8oeCkJKEVYVDBfR1BJT19CQVNFICsgKHgpKQogCisjZGVmaW5lIExJVFRMRVRPTl9OUl9J
UlFTCShJUlFfQk9BUkRfU1RBUlQgKyA4KQorCiAjZW5kaWYgLyogX19BU01fQVJDSF9MSVRUTEVU
T05fSCAqLwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2xwZDI3
MC5oIGIvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL2xwZDI3MC5oCmluZGV4IDBlNjQ0
MGMuLmNkMDcwMDkgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9s
cGQyNzAuaAorKysgYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvbHBkMjcwLmgKQEAg
LTM4LDUgKzM4LDYgQEAKICNkZWZpbmUgTFBEMjcwX1VTQkNfSVJRCQlMUEQyNzBfSVJRKDIpCiAj
ZGVmaW5lIExQRDI3MF9FVEhFUk5FVF9JUlEJTFBEMjcwX0lSUSgzKQogI2RlZmluZSBMUEQyNzBf
QUM5N19JUlEJCUxQRDI3MF9JUlEoNCkKKyNkZWZpbmUgTFBEMjcwX05SX0lSUVMJCShJUlFfQk9B
UkRfU1RBUlQgKyA1KQogCiAjZW5kaWYKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL2lu
Y2x1ZGUvbWFjaC9sdWJib2NrLmggYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvbHVi
Ym9jay5oCmluZGV4IGEwZDQyNDcuLjJhMDg2ZTggMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gt
cHhhL2luY2x1ZGUvbWFjaC9sdWJib2NrLmgKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVk
ZS9tYWNoL2x1YmJvY2suaApAQCAtNDUsNiArNDUsOSBAQAogI2RlZmluZSBMVUJCT0NLX1VTQl9E
SVNDX0lSUQlMVUJCT0NLX0lSUSg2KSAgLyogdXNiIGRpc2Nvbm5lY3QgKi8KICNkZWZpbmUgTFVC
Qk9DS19MQVNUX0lSUQlMVUJCT0NLX0lSUSg2KQogCisjZGVmaW5lIExVQkJPQ0tfU0ExMTExX0lS
UV9CQVNFCShJUlFfQk9BUkRfU1RBUlQgKyAxNikKKyNkZWZpbmUgTFVCQk9DS19OUl9JUlFTCQko
SVJRX0JPQVJEX1NUQVJUICsgMTYgKyA1NSkKKwogI2lmbmRlZiBfX0FTU0VNQkxZX18KIGV4dGVy
biB2b2lkIGx1YmJvY2tfc2V0X21pc2Nfd3IodW5zaWduZWQgaW50IG1hc2ssIHVuc2lnbmVkIGlu
dCBzZXQpOwogI2VuZGlmCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21h
Y2gvbWFnaWNpYW4uaCBiL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9tYWdpY2lhbi5o
CmluZGV4IDIwZWYzN2QuLjBhMmVmY2YgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL2lu
Y2x1ZGUvbWFjaC9tYWdpY2lhbi5oCisrKyBiL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFj
aC9tYWdpY2lhbi5oCkBAIC03MSw2ICs3MSw4IEBACiAjZGVmaW5lIElSUV9NQUdJQ0lBTl9CVAkJ
KElSUV9CT0FSRF9TVEFSVCArIDIpCiAjZGVmaW5lIElSUV9NQUdJQ0lBTl9WQlVTCShJUlFfQk9B
UkRfU1RBUlQgKyAzKQogCisjZGVmaW5lIE1BR0lDSUFOX05SX0lSUVMJKElSUV9CT0FSRF9TVEFS
VCArIDgpCisKIC8qCiAgKiBDUExEIEVHUElPcwogICovCmRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLXB4YS9pbmNsdWRlL21hY2gvbWFpbnN0b25lLmggYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNs
dWRlL21hY2gvbWFpbnN0b25lLmgKaW5kZXggODZlNjIzYS4uNGMyZDExYyAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL21haW5zdG9uZS5oCisrKyBiL2FyY2gvYXJt
L21hY2gtcHhhL2luY2x1ZGUvbWFjaC9tYWluc3RvbmUuaApAQCAtMTM0LDQgKzEzNCw2IEBACiAj
ZGVmaW5lIE1BSU5TVE9ORV9TMV9TVFNDSEdfSVJRCU1BSU5TVE9ORV9JUlEoMTQpCiAjZGVmaW5l
IE1BSU5TVE9ORV9TMV9JUlEJTUFJTlNUT05FX0lSUSgxNSkKIAorI2RlZmluZSBNQUlOU1RPTkVf
TlJfSVJRUwkoSVJRX0JPQVJEX1NUQVJUICsgMTYpCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3BjbTAyNy5oIGIvYXJjaC9hcm0vbWFjaC1weGEv
aW5jbHVkZS9tYWNoL3BjbTAyNy5oCmluZGV4IDA0MDgzMjYuLjRiYWM1ODggMTAwNjQ0Ci0tLSBh
L2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9wY20wMjcuaAorKysgYi9hcmNoL2FybS9t
YWNoLXB4YS9pbmNsdWRlL21hY2gvcGNtMDI3LmgKQEAgLTMwLDYgKzMwLDggQEAKICNkZWZpbmUg
UENNMDI3X01NQ0RFVF9JUlEgICAgICBQQ00wMjdfSVJRKDIpCiAjZGVmaW5lIFBDTTAyN19QTV81
Vl9JUlEgICAgICAgUENNMDI3X0lSUSgzKQogCisjZGVmaW5lIFBDTTAyN19OUl9JUlFTCQkoSVJR
X0JPQVJEX1NUQVJUICsgMzIpCisKIC8qIEkyQyBSVEMgKi8KICNkZWZpbmUgUENNMDI3X1JUQ19J
UlFfR1BJTwkwCiAjZGVmaW5lIFBDTTAyN19SVENfSVJRCQlJUlFfR1BJTyhQQ00wMjdfUlRDX0lS
UV9HUElPKQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3Bvb2Rs
ZS5oIGIvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3Bvb2RsZS5oCmluZGV4IDBiM2U2
ZDAuLjgzZDFjZmQgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC9w
b29kbGUuaAorKysgYi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvcG9vZGxlLmgKQEAg
LTg1LDYgKzg1LDggQEAKICNkZWZpbmUgUE9PRExFX0xPQ09NT19HUElPXzIzMlZDQ19PTiAgIExP
Q09NT19HUElPKDEyKQogI2RlZmluZSBQT09ETEVfTE9DT01PX0dQSU9fSktfQiAgICAgICAgTE9D
T01PX0dQSU8oMTMpCiAKKyNkZWZpbmUgUE9PRExFX05SX0lSUVMJCShJUlFfQk9BUkRfU1RBUlQg
KyA0KQkvKiA0IGZvciBMb0NvTW8gKi8KKwogZXh0ZXJuIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
cG9vZGxlX2xvY29tb19kZXZpY2U7CiAKICNlbmRpZiAvKiBfX0FTTV9BUkNIX1BPT0RMRV9IICAq
LwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3Rvc2EuaCBiL2Fy
Y2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC90b3NhLmgKaW5kZXggMWJiZDFmMi4uMTI3MmM0
YiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3Rvc2EuaAorKysg
Yi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvdG9zYS5oCkBAIC0yMCw2ICsyMCw3IEBA
CiAvKiBKYWNrZXQgU2Nvb3AgKi8KICNkZWZpbmUgVE9TQV9TQ09PUF9QSFlTICAJKFBYQV9DUzVf
UEhZUyArIDB4MDA4MDAwMDApCiAKKyNkZWZpbmUgVE9TQV9OUl9JUlFTCQkoSVJRX0JPQVJEX1NU
QVJUICsgVEM2MzkzWEJfTlJfSVJRUykKIC8qCiAgKiBTQ09PUDIgaW50ZXJuYWwgR1BJT3MKICAq
LwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3pldXMuaCBiL2Fy
Y2gvYXJtL21hY2gtcHhhL2luY2x1ZGUvbWFjaC96ZXVzLmgKaW5kZXggNmUxMTk5Ny4uZmFhNDA4
YSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNoL3pldXMuaAorKysg
Yi9hcmNoL2FybS9tYWNoLXB4YS9pbmNsdWRlL21hY2gvemV1cy5oCkBAIC0xNSw2ICsxNSw4IEBA
CiAjaWZuZGVmIF9NQUNIX1pFVVNfSAogI2RlZmluZSBfTUFDSF9aRVVTX0gKIAorI2RlZmluZSBa
RVVTX05SX0lSUVMJCShJUlFfQk9BUkRfU1RBUlQgKyA0OCkKKwogLyogUGh5c2ljYWwgYWRkcmVz
c2VzICovCiAjZGVmaW5lIFpFVVNfRkxBU0hfUEhZUwkJUFhBX0NTMF9QSFlTCiAjZGVmaW5lIFpF
VVNfRVRIMF9QSFlTCQlQWEFfQ1MxX1BIWVMKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhh
L2luY2x1ZGUvbWFjaC96eWxvbml0ZS5oIGIvYXJjaC9hcm0vbWFjaC1weGEvaW5jbHVkZS9tYWNo
L3p5bG9uaXRlLmgKaW5kZXggOWVkZjY0NS4uZWEyNDk5OCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0v
bWFjaC1weGEvaW5jbHVkZS9tYWNoL3p5bG9uaXRlLmgKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEv
aW5jbHVkZS9tYWNoL3p5bG9uaXRlLmgKQEAgLTUsNiArNSw4IEBACiAKICNkZWZpbmUgRVhUX0dQ
SU8oeCkJCSgxMjggKyAoeCkpCiAKKyNkZWZpbmUgWllMT05JVEVfTlJfSVJRUwkoSVJRX0JPQVJE
X1NUQVJUICsgMzIpCisKIC8qIHRoZSBmb2xsb3dpbmcgdmFyaWFibGVzIGFyZSBwcm9jZXNzb3Ig
c3BlY2lmaWMgYW5kIGluaXRpYWxpemVkCiAgKiBieSB0aGUgY29ycmVzcG9uZGluZyB6eWxvbml0
ZV9weGEzeHhfaW5pdCgpCiAgKi8KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL2xpdHRs
ZXRvbi5jIGIvYXJjaC9hcm0vbWFjaC1weGEvbGl0dGxldG9uLmMKaW5kZXggOWI5MDQ2MS4uODNm
MzIzNiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvbGl0dGxldG9uLmMKKysrIGIvYXJj
aC9hcm0vbWFjaC1weGEvbGl0dGxldG9uLmMKQEAgLTQ0MSw2ICs0NDEsNyBAQCBNQUNISU5FX1NU
QVJUKExJVFRMRVRPTiwgIk1hcnZlbGwgRm9ybSBGYWN0b3IgRGV2ZWxvcG1lbnQgUGxhdGZvcm0g
KGFrYSBMaXR0bGV0bwogCS5ib290X3BhcmFtcwk9IDB4YTAwMDAxMDAsCiAJLmlvX3BnX29mZnN0
CT0gKGlvX3AydigweDQwMDAwMDAwKSA+PiAxOCkgJiAweGZmZmMsCiAJLm1hcF9pbwkJPSBweGFf
bWFwX2lvLAorCS5ucl9pcnFzCT0gTElUVExFVE9OX05SX0lSUVMsCiAJLmluaXRfaXJxCT0gcHhh
M3h4X2luaXRfaXJxLAogCS50aW1lcgkJPSAmcHhhX3RpbWVyLAogCS5pbml0X21hY2hpbmUJPSBs
aXR0bGV0b25faW5pdCwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL2xwZDI3MC5jIGIv
YXJjaC9hcm0vbWFjaC1weGEvbHBkMjcwLmMKaW5kZXggZDI3OTUwNy4uZmM5NTAyZSAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvbHBkMjcwLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEv
bHBkMjcwLmMKQEAgLTUwOSw2ICs1MDksNyBAQCBNQUNISU5FX1NUQVJUKExPR0lDUERfUFhBMjcw
LCAiTG9naWNQRCBQWEEyNzAgQ2FyZCBFbmdpbmUiKQogCS5pb19wZ19vZmZzdAk9IChpb19wMnYo
MHg0MDAwMDAwMCkgPj4gMTgpICYgMHhmZmZjLAogCS5ib290X3BhcmFtcwk9IDB4YTAwMDAxMDAs
CiAJLm1hcF9pbwkJPSBscGQyNzBfbWFwX2lvLAorCS5ucl9pcnFzCT0gTFBEMjcwX05SX0lSUVMs
CiAJLmluaXRfaXJxCT0gbHBkMjcwX2luaXRfaXJxLAogCS50aW1lcgkJPSAmcHhhX3RpbWVyLAog
CS5pbml0X21hY2hpbmUJPSBscGQyNzBfaW5pdCwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gt
cHhhL2x1YmJvY2suYyBiL2FyY2gvYXJtL21hY2gtcHhhL2x1YmJvY2suYwppbmRleCAzMzBjMzI4
Li4xOTU2YzIzIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLXB4YS9sdWJib2NrLmMKKysrIGIv
YXJjaC9hcm0vbWFjaC1weGEvbHViYm9jay5jCkBAIC0yMjksNyArMjI5LDcgQEAgc3RhdGljIHN0
cnVjdCByZXNvdXJjZSBzYTExMTFfcmVzb3VyY2VzW10gPSB7CiB9OwogCiBzdGF0aWMgc3RydWN0
IHNhMTExMV9wbGF0Zm9ybV9kYXRhIHNhMTExMV9pbmZvID0gewotCS5pcnFfYmFzZQk9IElSUV9C
T0FSRF9FTkQsCisJLmlycV9iYXNlCT0gTFVCQk9DS19TQTExMTFfSVJRX0JBU0UsCiB9OwogCiBz
dGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBzYTExMTFfZGV2aWNlID0gewpAQCAtNTYwLDYg
KzU2MCw3IEBAIE1BQ0hJTkVfU1RBUlQoTFVCQk9DSywgIkludGVsIERCUFhBMjUwIERldmVsb3Bt
ZW50IFBsYXRmb3JtIChha2EgTHViYm9jaykiKQogCS5waHlzX2lvCT0gMHg0MDAwMDAwMCwKIAku
aW9fcGdfb2Zmc3QJPSAoaW9fcDJ2KDB4NDAwMDAwMDApID4+IDE4KSAmIDB4ZmZmYywKIAkubWFw
X2lvCQk9IGx1YmJvY2tfbWFwX2lvLAorCS5ucl9pcnFzCT0gTFVCQk9DS19OUl9JUlFTLAogCS5p
bml0X2lycQk9IGx1YmJvY2tfaW5pdF9pcnEsCiAJLnRpbWVyCQk9ICZweGFfdGltZXIsCiAJLmlu
aXRfbWFjaGluZQk9IGx1YmJvY2tfaW5pdCwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhh
L21hZ2ljaWFuLmMgYi9hcmNoL2FybS9tYWNoLXB4YS9tYWdpY2lhbi5jCmluZGV4IGU4MWRkMGMu
LjQyYTBjMmIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL21hZ2ljaWFuLmMKKysrIGIv
YXJjaC9hcm0vbWFjaC1weGEvbWFnaWNpYW4uYwpAQCAtNzY4LDYgKzc2OCw3IEBAIE1BQ0hJTkVf
U1RBUlQoTUFHSUNJQU4sICJIVEMgTWFnaWNpYW4iKQogCS5pb19wZ19vZmZzdCA9IChpb19wMnYo
MHg0MDAwMDAwMCkgPj4gMTgpICYgMHhmZmZjLAogCS5ib290X3BhcmFtcyA9IDB4YTAwMDAxMDAs
CiAJLm1hcF9pbyA9IHB4YV9tYXBfaW8sCisJLm5yX2lycXMgPSBNQUdJQ0lBTl9OUl9JUlFTLAog
CS5pbml0X2lycSA9IHB4YTI3eF9pbml0X2lycSwKIAkuaW5pdF9tYWNoaW5lID0gbWFnaWNpYW5f
aW5pdCwKIAkudGltZXIgPSAmcHhhX3RpbWVyLApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1w
eGEvbWFpbnN0b25lLmMgYi9hcmNoL2FybS9tYWNoLXB4YS9tYWluc3RvbmUuYwppbmRleCA1NTQz
YzY0Li5jMmE4NzE3IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLXB4YS9tYWluc3RvbmUuYwor
KysgYi9hcmNoL2FybS9tYWNoLXB4YS9tYWluc3RvbmUuYwpAQCAtNjI4LDYgKzYyOCw3IEBAIE1B
Q0hJTkVfU1RBUlQoTUFJTlNUT05FLCAiSW50ZWwgSENEREJCVkEwIERldmVsb3BtZW50IFBsYXRm
b3JtIChha2EgTWFpbnN0b25lKSIpCiAJLmJvb3RfcGFyYW1zCT0gMHhhMDAwMDEwMCwJLyogQkxP
QiBib290IHBhcmFtZXRlciBzZXR0aW5nICovCiAJLmlvX3BnX29mZnN0CT0gKGlvX3AydigweDQw
MDAwMDAwKSA+PiAxOCkgJiAweGZmZmMsCiAJLm1hcF9pbwkJPSBtYWluc3RvbmVfbWFwX2lvLAor
CS5ucl9pcnFzCT0gTUFJTlNUT05FX05SX0lSUVMsCiAJLmluaXRfaXJxCT0gbWFpbnN0b25lX2lu
aXRfaXJxLAogCS50aW1lcgkJPSAmcHhhX3RpbWVyLAogCS5pbml0X21hY2hpbmUJPSBtYWluc3Rv
bmVfaW5pdCwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL3BjbTAyNy5jIGIvYXJjaC9h
cm0vbWFjaC1weGEvcGNtMDI3LmMKaW5kZXggMjE5MGFmMC4uOTBiMDhiYSAxMDA2NDQKLS0tIGEv
YXJjaC9hcm0vbWFjaC1weGEvcGNtMDI3LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1weGEvcGNtMDI3
LmMKQEAgLTI2Miw2ICsyNjIsNyBAQCBNQUNISU5FX1NUQVJUKFBDTTAyNywgIlBoeXRlYyBNZXNz
dGVjaG5payBHbWJIIHBoeUNPUkUtUFhBMjcwIikKIAkucGh5c19pbwk9IDB4NDAwMDAwMDAsCiAJ
LmlvX3BnX29mZnN0CT0gKGlvX3AydigweDQwMDAwMDAwKSA+PiAxOCkgJiAweGZmZmMsCiAJLm1h
cF9pbwkJPSBwY20wMjdfbWFwX2lvLAorCS5ucl9pcnFzCT0gUENNMDI3X05SX0lSUVMsCiAJLmlu
aXRfaXJxCT0gcHhhMjd4X2luaXRfaXJxLAogCS50aW1lcgkJPSAmcHhhX3RpbWVyLAogCS5pbml0
X21hY2hpbmUJPSBwY20wMjdfaW5pdCwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL3Bv
b2RsZS5jIGIvYXJjaC9hcm0vbWFjaC1weGEvcG9vZGxlLmMKaW5kZXggNTVlOGZjZC4uYzA0ZTAy
NSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvcG9vZGxlLmMKKysrIGIvYXJjaC9hcm0v
bWFjaC1weGEvcG9vZGxlLmMKQEAgLTQ2OSw2ICs0NjksNyBAQCBNQUNISU5FX1NUQVJUKFBPT0RM
RSwgIlNIQVJQIFBvb2RsZSIpCiAJLmlvX3BnX29mZnN0CT0gKGlvX3AydigweDQwMDAwMDAwKSA+
PiAxOCkgJiAweGZmZmMsCiAJLmZpeHVwCQk9IGZpeHVwX3Bvb2RsZSwKIAkubWFwX2lvCQk9IHB4
YV9tYXBfaW8sCisJLm5yX2lycXMJPSBQT09ETEVfTlJfSVJRUywJLyogNCBmb3IgTG9Db01vICov
CiAJLmluaXRfaXJxCT0gcHhhMjV4X2luaXRfaXJxLAogCS50aW1lcgkJPSAmcHhhX3RpbWVyLAog
CS5pbml0X21hY2hpbmUJPSBwb29kbGVfaW5pdCwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gt
cHhhL3N0YXJnYXRlMi5jIGIvYXJjaC9hcm0vbWFjaC1weGEvc3RhcmdhdGUyLmMKaW5kZXggYTY1
NGQxZS4uNjJkZTA3MyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvc3RhcmdhdGUyLmMK
KysrIGIvYXJjaC9hcm0vbWFjaC1weGEvc3RhcmdhdGUyLmMKQEAgLTU2LDYgKzU2LDggQEAKICNp
bmNsdWRlICJkZXZpY2VzLmgiCiAjaW5jbHVkZSAiZ2VuZXJpYy5oIgogCisjZGVmaW5lIFNUQVJH
QVRFX05SX0lSUVMJKElSUV9CT0FSRF9TVEFSVCArIDgpCisKIC8qIEJsdWV0b290aCAqLwogI2Rl
ZmluZSBTRzJfQlRfUkVTRVQJCTgxCiAKQEAgLTEwMTEsNiArMTAxMyw3IEBAIE1BQ0hJTkVfU1RB
UlQoU1RBUkdBVEUyLCAiU3RhcmdhdGUgMiIpCiAJLnBoeXNfaW8gPSAweDQwMDAwMDAwLAogCS5p
b19wZ19vZmZzdCA9IChpb19wMnYoMHg0MDAwMDAwMCkgPj4gMTgpICYgMHhmZmZjLAogCS5tYXBf
aW8gPSBweGFfbWFwX2lvLAorCS5ucl9pcnFzID0gU1RBUkdBVEVfTlJfSVJRUywKIAkuaW5pdF9p
cnEgPSBweGEyN3hfaW5pdF9pcnEsCiAJLnRpbWVyID0gJnB4YV90aW1lciwKIAkuaW5pdF9tYWNo
aW5lID0gc3RhcmdhdGUyX2luaXQsCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS90b3Nh
LmMgYi9hcmNoL2FybS9tYWNoLXB4YS90b3NhLmMKaW5kZXggODNjYzNhMS4uM2EwNmU5OCAxMDA2
NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvdG9zYS5jCisrKyBiL2FyY2gvYXJtL21hY2gtcHhh
L3Rvc2EuYwpAQCAtOTU2LDYgKzk1Niw3IEBAIE1BQ0hJTkVfU1RBUlQoVE9TQSwgIlNIQVJQIFRv
c2EiKQogCS5pb19wZ19vZmZzdAk9IChpb19wMnYoMHg0MDAwMDAwMCkgPj4gMTgpICYgMHhmZmZj
LAogCS5maXh1cCAgICAgICAgICA9IGZpeHVwX3Rvc2EsCiAJLm1hcF9pbyAgICAgICAgID0gcHhh
X21hcF9pbywKKwkubnJfaXJxcwk9IFRPU0FfTlJfSVJRUywKIAkuaW5pdF9pcnEgICAgICAgPSBw
eGEyNXhfaW5pdF9pcnEsCiAJLmluaXRfbWFjaGluZSAgID0gdG9zYV9pbml0LAogCS50aW1lciAg
ICAgICAgICA9ICZweGFfdGltZXIsCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLXB4YS96ZXVz
LmMgYi9hcmNoL2FybS9tYWNoLXB4YS96ZXVzLmMKaW5kZXggMDNiOWNiOS4uOWRhMmI2MiAxMDA2
NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1weGEvemV1cy5jCisrKyBiL2FyY2gvYXJtL21hY2gtcHhh
L3pldXMuYwpAQCAtOTA0LDYgKzkwNCw3IEBAIE1BQ0hJTkVfU1RBUlQoQVJDT01fWkVVUywgIkFy
Y29tL0V1cm90ZWNoIFpFVVMiKQogCS5pb19wZ19vZmZzdAk9ICgoaW9fcDJ2KDB4NDAwMDAwMDAp
ID4+IDE4KSAmIDB4ZmZmYyksCiAJLmJvb3RfcGFyYW1zCT0gMHhhMDAwMDEwMCwKIAkubWFwX2lv
CQk9IHpldXNfbWFwX2lvLAorCS5ucl9pcnFzCT0gWkVVU19OUl9JUlFTLAogCS5pbml0X2lycQk9
IHpldXNfaW5pdF9pcnEsCiAJLnRpbWVyCQk9ICZweGFfdGltZXIsCiAJLmluaXRfbWFjaGluZQk9
IHpldXNfaW5pdCwKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtcHhhL3p5bG9uaXRlLmMgYi9h
cmNoL2FybS9tYWNoLXB4YS96eWxvbml0ZS5jCmluZGV4IGM0NzljYmUuLjJlZGFkNjEgMTAwNjQ0
Ci0tLSBhL2FyY2gvYXJtL21hY2gtcHhhL3p5bG9uaXRlLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1w
eGEvenlsb25pdGUuYwpAQCAtNDE1LDYgKzQxNSw3IEBAIE1BQ0hJTkVfU1RBUlQoWllMT05JVEUs
ICJQWEEzeHggUGxhdGZvcm0gRGV2ZWxvcG1lbnQgS2l0IChha2EgWnlsb25pdGUpIikKIAkuYm9v
dF9wYXJhbXMJPSAweGEwMDAwMTAwLAogCS5pb19wZ19vZmZzdAk9IChpb19wMnYoMHg0MDAwMDAw
MCkgPj4gMTgpICYgMHhmZmZjLAogCS5tYXBfaW8JCT0gcHhhX21hcF9pbywKKwkubnJfaXJxcwk9
IFpZTE9OSVRFX05SX0lSUVMsCiAJLmluaXRfaXJxCT0gcHhhM3h4X2luaXRfaXJxLAogCS50aW1l
cgkJPSAmcHhhX3RpbWVyLAogCS5pbml0X21hY2hpbmUJPSB6eWxvbml0ZV9pbml0LAotLSAKMS41
LjYuNQoK
--0016e649c9eae341ba048e3d46dc--
