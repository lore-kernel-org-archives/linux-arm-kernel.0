From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Feb 2012 21:32:11 -0600
Subject: [PATCH 1/4] ARM: sa1100: fix sa1100 after sparse irq conversion
In-Reply-To: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329449534-23811-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

SA1100 was converted to sparse irq in parallel with include of mach/irqs.h
being removed from asm/irq.h when sparse irq is enabled, resulting in lots
of compile errors.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-sa1100/assabet.c           |    2 ++
 arch/arm/mach-sa1100/badge4.c            |    1 +
 arch/arm/mach-sa1100/cerf.c              |    2 ++
 arch/arm/mach-sa1100/collie.c            |    2 ++
 arch/arm/mach-sa1100/generic.c           |    4 +++-
 arch/arm/mach-sa1100/h3100.c             |    2 ++
 arch/arm/mach-sa1100/h3600.c             |    2 ++
 arch/arm/mach-sa1100/hackkit.c           |    5 ++++-
 arch/arm/mach-sa1100/include/mach/irqs.h |    2 +-
 arch/arm/mach-sa1100/irq.c               |    1 +
 arch/arm/mach-sa1100/jornada720.c        |    5 ++++-
 arch/arm/mach-sa1100/lart.c              |    2 ++
 arch/arm/mach-sa1100/nanoengine.c        |    2 ++
 arch/arm/mach-sa1100/neponset.c          |    1 +
 arch/arm/mach-sa1100/pleb.c              |    1 +
 arch/arm/mach-sa1100/shannon.c           |    2 ++
 arch/arm/mach-sa1100/simpad.c            |    2 ++
 arch/arm/mach-sa1100/ssp.c               |    1 +
 arch/arm/mach-sa1100/time.c              |    1 +
 drivers/gpio/gpio-sa1100.c               |    1 +
 drivers/net/ethernet/smsc/smc91x.c       |    4 ++++
 drivers/tty/serial/sa1100.c              |    1 +
 22 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index e708a93..25c662d 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -39,6 +39,7 @@
 #include <asm/mach/serial_sa1100.h>
 #include <mach/assabet.h>
 #include <mach/mcp.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -534,6 +535,7 @@ MACHINE_START(ASSABET, "Intel-Assabet")
 	.atag_offset	= 0x100,
 	.fixup		= fixup_assabet,
 	.map_io		= assabet_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= assabet_init,
diff --git a/arch/arm/mach-sa1100/badge4.c b/arch/arm/mach-sa1100/badge4.c
index 266ec0f..e0f0c03 100644
--- a/arch/arm/mach-sa1100/badge4.c
+++ b/arch/arm/mach-sa1100/badge4.c
@@ -303,6 +303,7 @@ static void __init badge4_map_io(void)
 MACHINE_START(BADGE4, "Hewlett-Packard Laboratories BadgePAD 4")
 	.atag_offset	= 0x100,
 	.map_io		= badge4_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 #ifdef CONFIG_SA1111
diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 8015604..6a925de 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -30,6 +30,7 @@
 
 #include <mach/cerf.h>
 #include <mach/mcp.h>
+#include <mach/irqs.h>
 #include "generic.h"
 
 static struct resource cerfuart2_resources[] = {
@@ -130,6 +131,7 @@ static void __init cerf_init(void)
 MACHINE_START(CERF, "Intrinsyc CerfBoard/CerfCube")
 	/* Maintainer: support at intrinsyc.com */
 	.map_io		= cerf_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= cerf_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= cerf_init,
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index d4339d6..6e5ab42 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -47,6 +47,7 @@
 #include <asm/mach/sharpsl_param.h>
 #include <asm/hardware/locomo.h>
 #include <mach/mcp.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -393,6 +394,7 @@ static void __init collie_map_io(void)
 
 MACHINE_START(COLLIE, "Sharp-Collie")
 	.map_io		= collie_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= collie_init,
diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 97e9bdf..b184704 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -23,12 +23,14 @@
 #include <video/sa1100fb.h>
 
 #include <asm/div64.h>
-#include <mach/hardware.h>
 #include <asm/system.h>
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 #include <asm/irq.h>
 
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
 #include "generic.h"
 
 unsigned int reset_status;
diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index f23e7d0..b2e8d0f 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -21,6 +21,7 @@
 #include <asm/mach/irda.h>
 
 #include <mach/h3xxx.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -105,6 +106,7 @@ static void __init h3100_mach_init(void)
 MACHINE_START(H3100, "Compaq iPAQ H3100")
 	.atag_offset	= 0x100,
 	.map_io		= h3100_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= h3100_mach_init,
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 2feac56..cb6659f 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -21,6 +21,7 @@
 #include <asm/mach/irda.h>
 
 #include <mach/h3xxx.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -155,6 +156,7 @@ static void __init h3600_mach_init(void)
 MACHINE_START(H3600, "Compaq iPAQ H3600")
 	.atag_offset	= 0x100,
 	.map_io		= h3600_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= h3600_mach_init,
diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 37d381a..55052e4 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -22,7 +22,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -35,6 +34,9 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/serial_sa1100.h>
 
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
 #include "generic.h"
 
 /**********************************************************************
@@ -194,6 +196,7 @@ static void __init hackkit_init(void)
 MACHINE_START(HACKKIT, "HackKit Cpu Board")
 	.atag_offset	= 0x100,
 	.map_io		= hackkit_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= hackkit_init,
diff --git a/arch/arm/mach-sa1100/include/mach/irqs.h b/arch/arm/mach-sa1100/include/mach/irqs.h
index db0699a..ce3bb03 100644
--- a/arch/arm/mach-sa1100/include/mach/irqs.h
+++ b/arch/arm/mach-sa1100/include/mach/irqs.h
@@ -83,4 +83,4 @@
 #define NR_IRQS_LOCOMO		0
 #endif
 
-#define NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)
+#define SA1100_NR_IRQS (IRQ_BOARD_START + NR_IRQS_LOCOMO)
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 5d12a30..516ccc2 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -17,6 +17,7 @@
 #include <linux/syscore_ops.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/mach/irq.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-sa1100/jornada720.c b/arch/arm/mach-sa1100/jornada720.c
index 0c9a0bd..cfcaaef 100644
--- a/arch/arm/mach-sa1100/jornada720.c
+++ b/arch/arm/mach-sa1100/jornada720.c
@@ -23,7 +23,6 @@
 #include <linux/mtd/partitions.h>
 #include <video/s1d13xxxfb.h>
 
-#include <mach/hardware.h>
 #include <asm/hardware/sa1111.h>
 #include <asm/irq.h>
 #include <asm/page.h>
@@ -34,6 +33,9 @@
 #include <asm/mach/map.h>
 #include <asm/mach/serial_sa1100.h>
 
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+
 #include "generic.h"
 
 /*
@@ -343,6 +345,7 @@ MACHINE_START(JORNADA720, "HP Jornada 720")
 	/* Maintainer: Kristoffer Ericson <Kristoffer.Ericson@gmail.com> */
 	.atag_offset	= 0x100,
 	.map_io		= jornada720_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= jornada720_mach_init,
diff --git a/arch/arm/mach-sa1100/lart.c b/arch/arm/mach-sa1100/lart.c
index 570f75f..eb6534e 100644
--- a/arch/arm/mach-sa1100/lart.c
+++ b/arch/arm/mach-sa1100/lart.c
@@ -17,6 +17,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/serial_sa1100.h>
 #include <mach/mcp.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -143,6 +144,7 @@ static void __init lart_map_io(void)
 MACHINE_START(LART, "LART")
 	.atag_offset	= 0x100,
 	.map_io		= lart_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.init_machine	= lart_init,
 	.timer		= &sa1100_timer,
diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index 3923911..8f6446b 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -28,6 +28,7 @@
 
 #include <mach/hardware.h>
 #include <mach/nanoengine.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -107,6 +108,7 @@ static void __init nanoengine_init(void)
 MACHINE_START(NANOENGINE, "BSE nanoEngine")
 	.atag_offset	= 0x100,
 	.map_io		= nanoengine_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= nanoengine_init,
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 3e43af4..6c58f01 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -21,6 +21,7 @@
 #include <mach/hardware.h>
 #include <mach/assabet.h>
 #include <mach/neponset.h>
+#include <mach/irqs.h>
 
 #define NEP_IRQ_SMC91X	0
 #define NEP_IRQ_USAR	1
diff --git a/arch/arm/mach-sa1100/pleb.c b/arch/arm/mach-sa1100/pleb.c
index ca5d33b..1602575 100644
--- a/arch/arm/mach-sa1100/pleb.c
+++ b/arch/arm/mach-sa1100/pleb.c
@@ -131,6 +131,7 @@ static void __init pleb_map_io(void)
 
 MACHINE_START(PLEB, "PLEB")
 	.map_io		= pleb_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine   = pleb_init,
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 08bb122..ca8bf59 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -21,6 +21,7 @@
 #include <asm/mach/serial_sa1100.h>
 #include <mach/mcp.h>
 #include <mach/shannon.h>
+#include <mach/irqs.h>
 
 #include "generic.h"
 
@@ -99,6 +100,7 @@ static void __init shannon_map_io(void)
 MACHINE_START(SHANNON, "Shannon (AKA: Tuxscreen)")
 	.atag_offset	= 0x100,
 	.map_io		= shannon_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.init_machine	= shannon_init,
diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 255c37d..0a08d71 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -27,6 +27,7 @@
 #include <asm/mach/serial_sa1100.h>
 #include <mach/mcp.h>
 #include <mach/simpad.h>
+#include <mach/irqs.h>
 
 #include <linux/serial_core.h>
 #include <linux/ioport.h>
@@ -393,6 +394,7 @@ MACHINE_START(SIMPAD, "Simpad")
 	/* Maintainer: Holger Freyther */
 	.atag_offset	= 0x100,
 	.map_io		= simpad_map_io,
+	.nr_irqs	= SA1100_NR_IRQS,
 	.init_irq	= sa1100_init_irq,
 	.timer		= &sa1100_timer,
 	.restart	= sa11x0_restart,
diff --git a/arch/arm/mach-sa1100/ssp.c b/arch/arm/mach-sa1100/ssp.c
index b20ff93..1c14617 100644
--- a/arch/arm/mach-sa1100/ssp.c
+++ b/arch/arm/mach-sa1100/ssp.c
@@ -21,6 +21,7 @@
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/hardware/ssp.h>
 
 #define TIMEOUT 100000
diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 69e3353..6af26e8 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -18,6 +18,7 @@
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 
 static u32 notrace sa1100_read_sched_clock(void)
 {
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index 7eecf69..8ea3b33 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 
 static int sa1100_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 0dba050..0c16c0a 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -89,6 +89,10 @@ static const char version[] =
 
 #include <asm/io.h>
 
+#if defined(CONFIG_SA1100_ASSABET)
+#include <mach/neponset.h>
+#endif
+
 #include "smc91x.h"
 
 #ifndef SMC_NOWAIT
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index ef7a21a..2ca5959 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -38,6 +38,7 @@
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/mach/serial_sa1100.h>
 
 /* We've been assigned a range on the "Low-density serial ports" major */
-- 
1.7.5.4
