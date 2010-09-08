From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed,  8 Sep 2010 09:42:42 -0400
Subject: [PATCH 4/4] ARM: mmp: support sparse irq
In-Reply-To: <1283953362-2363-3-git-send-email-haojian.zhuang@marvell.com>
References: <1283953362-2363-1-git-send-email-haojian.zhuang@marvell.com>
	<1283953362-2363-2-git-send-email-haojian.zhuang@marvell.com>
	<1283953362-2363-3-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1283953362-2363-4-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add sparse IRQ support in ARCH_MMP.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-mmp/aspenite.c          |    3 +++
 arch/arm/mach-mmp/flint.c             |    4 ++++
 arch/arm/mach-mmp/include/mach/irqs.h |    4 +---
 arch/arm/mach-mmp/jasper.c            |    5 ++++-
 arch/arm/mach-mmp/ttc_dkb.c           |    4 ++++
 6 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45f93e1..eb1d43d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -511,6 +511,7 @@ config ARCH_MMP
 	select GENERIC_CLOCKEVENTS
 	select TICK_ONESHOT
 	select PLAT_PXA
+	select SPARSE_IRQ
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 9e1bd6b..9b1ef76 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -16,6 +16,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -212,6 +213,7 @@ MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= mmp_map_io,
+	.nr_irqs	= IRQ_BOARD_START,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = common_init,
@@ -221,6 +223,7 @@ MACHINE_START(ZYLONITE2, "PXA168-based Zylonite2 Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= mmp_map_io,
+	.nr_irqs	= IRQ_BOARD_START,
 	.init_irq       = pxa168_init_irq,
 	.timer          = &pxa168_timer,
 	.init_machine   = common_init,
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index e4312d2..c558425 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -16,6 +16,7 @@
 #include <linux/smc91x.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -25,6 +26,8 @@
 
 #include "common.h"
 
+#define FLINT_NR_IRQS	(IRQ_BOARD_START + 48)
+
 static unsigned long flint_pin_config[] __initdata = {
 	/* UART1 */
 	GPIO45_UART1_RXD,
@@ -116,6 +119,7 @@ MACHINE_START(FLINT, "Flint Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= mmp_map_io,
+	.nr_irqs	= FLINT_NR_IRQS,
 	.init_irq       = mmp2_init_irq,
 	.timer          = &mmp2_timer,
 	.init_machine   = flint_init,
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
index b379cde..a09d328 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -222,10 +222,8 @@
 #define IRQ_GPIO_NUM			192
 #define IRQ_GPIO(x)			(IRQ_GPIO_START + (x))
 
-/* Board IRQ - 64 by default, increase if not enough */
 #define IRQ_BOARD_START			(IRQ_GPIO_START + IRQ_GPIO_NUM)
-#define IRQ_BOARD_END			(IRQ_BOARD_START + 64)
 
-#define NR_IRQS				(IRQ_BOARD_END)
+#define NR_IRQS				(IRQ_BOARD_START)
 
 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 80c3e7a..940ee03 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -18,16 +18,18 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max8649.h>
 #include <linux/mfd/max8925.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
 #include <mach/mfp-mmp2.h>
 #include <mach/mmp2.h>
-#include <mach/irqs.h>
 
 #include "common.h"
 
+#define JASPER_NR_IRQS		(IRQ_BOARD_START + 48)
+
 static unsigned long jasper_pin_config[] __initdata = {
 	/* UART1 */
 	GPIO29_UART1_RXD,
@@ -137,6 +139,7 @@ MACHINE_START(MARVELL_JASPER, "Jasper Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= mmp_map_io,
+	.nr_irqs	= JASPER_NR_IRQS,
 	.init_irq       = mmp2_init_irq,
 	.timer          = &mmp2_timer,
 	.init_machine   = jasper_init,
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index ee65e05..5457113 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -14,6 +14,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/onenand.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -24,6 +25,8 @@
 
 #include "common.h"
 
+#define TTCDKB_NR_IRQS		(IRQ_BOARD_START + 24)
+
 static unsigned long ttc_dkb_pin_config[] __initdata = {
 	/* UART2 */
 	GPIO47_UART2_RXD,
@@ -125,6 +128,7 @@ MACHINE_START(TTC_DKB, "PXA910-based TTC_DKB Development Platform")
 	.phys_io        = APB_PHYS_BASE,
 	.io_pg_offst    = (APB_VIRT_BASE >> 18) & 0xfffc,
 	.map_io		= mmp_map_io,
+	.nr_irqs	= TTCDKB_NR_IRQS,
 	.init_irq       = pxa910_init_irq,
 	.timer          = &pxa910_timer,
 	.init_machine   = ttc_dkb_init,
-- 
1.5.6.5
