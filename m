From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 20 Sep 2012 18:20:12 +0200
Subject: [PATCH] ARM: nomadik/ux500: convert to SPARSE_IRQ
Message-ID: <1348158012-424-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This converts the Nomadik and Ux500 over to using sparse IRQ,
including some pokes around the pinctrl driver. To avoid
referencing unnecessary header files, the plat-nomadik timer
driver is augmented to pass an irq number at init time, and
the change is applied across both platforms simultaneously
for this reason.

The change works fine for the Nomadik with it's VIC IRQ
controller, whereas the GIC on ux500 complains like this:

------------[ cut here ]------------
WARNING: at /home/elinwal/linux-stericsson/arch/arm/common/gic.c:713 gic_init_bases+0xe8/0x290()
Cannot allocate irq_descs @ IRQ16, assuming pre-allocated
Modules linked in:
[<c0014710>] (unwind_backtrace+0x0/0xf8) from [<c001d304>] (warn_slowpath_common+0x4c/0x64)
[<c001d304>] (warn_slowpath_common+0x4c/0x64) from [<c001d3b0>] (warn_slowpath_fmt+0x30/0x40)
[<c001d3b0>] (warn_slowpath_fmt+0x30/0x40) from [<c03e60f8>] (gic_init_bases+0xe8/0x290)
[<c03e60f8>] (gic_init_bases+0xe8/0x290) from [<c03e6560>] (ux500_init_irq+0xb0/0xfc)
[<c03e6560>] (ux500_init_irq+0xb0/0xfc) from [<c03e2114>] (init_IRQ+0x14/0x1c)
[<c03e2114>] (init_IRQ+0x14/0x1c) from [<c03df698>] (start_kernel+0x198/0x2ec)
[<c03df698>] (start_kernel+0x198/0x2ec) from [<00008044>] (0x8044)
---[ end trace 1b75b31a2719ed1c ]---

This is beacause the .nr_irqs member of the MACHINE descriptor
will allocate 0->(number of IRQs on this machine) interrupts.

If I understand it correctly, the warning is there to tell you that
your platform is in flight for transition to non pre-allocated IRQs,
so if we want it to go away completely the .nr_irqs member of the
MACHINE descriptor should be zero and all IRQ descriptors allocated
dynamically (with or without irq domains as helper). This means
changing a few dozed irq_chips for ux500 and needs to happen over
time.

So I am assuming that the warning message is acceptable for now
and applying this anyway.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                          | 2 ++
 arch/arm/mach-nomadik/board-nhk8815.c     | 5 +++--
 arch/arm/mach-nomadik/include/mach/irqs.h | 2 +-
 arch/arm/mach-ux500/board-mop500.c        | 4 ++++
 arch/arm/mach-ux500/cpu-db8500.c          | 1 +
 arch/arm/mach-ux500/devices-common.c      | 1 +
 arch/arm/mach-ux500/devices-db8500.c      | 1 +
 arch/arm/mach-ux500/devices-db8500.h      | 1 +
 arch/arm/mach-ux500/include/mach/irqs.h   | 2 +-
 arch/arm/mach-ux500/timer.c               | 2 +-
 arch/arm/plat-nomadik/include/plat/mtu.h  | 2 +-
 arch/arm/plat-nomadik/timer.c             | 4 ++--
 drivers/pinctrl/pinctrl-nomadik.c         | 1 +
 13 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2f88d8d..bec5d08 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -945,6 +945,7 @@ config ARCH_U8500
 	select ARCH_HAS_CPUFREQ
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
+	select SPARSE_IRQ
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
@@ -958,6 +959,7 @@ config ARCH_NOMADIK
 	select PINCTRL
 	select MIGHT_HAVE_CACHE_L2X0
 	select ARCH_REQUIRE_GPIOLIB
+	select SPARSE_IRQ
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
diff --git a/arch/arm/mach-nomadik/board-nhk8815.c b/arch/arm/mach-nomadik/board-nhk8815.c
index f4535a7..22b62b8 100644
--- a/arch/arm/mach-nomadik/board-nhk8815.c
+++ b/arch/arm/mach-nomadik/board-nhk8815.c
@@ -27,7 +27,6 @@
 #include <asm/sizes.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/irq.h>
 #include <asm/mach/flash.h>
 #include <asm/mach/time.h>
 
@@ -36,6 +35,7 @@
 
 #include <mach/nand.h>
 #include <mach/fsmc.h>
+#include <mach/irqs.h>
 
 #include "cpu-8815.h"
 
@@ -260,7 +260,7 @@ static void __init nomadik_timer_init(void)
 	src_cr |= SRC_CR_INIT_VAL;
 	writel(src_cr, io_p2v(NOMADIK_SRC_BASE));
 
-	nmdk_timer_init(io_p2v(NOMADIK_MTU0_BASE));
+	nmdk_timer_init(io_p2v(NOMADIK_MTU0_BASE), IRQ_MTU0);
 }
 
 static struct sys_timer nomadik_timer = {
@@ -313,6 +313,7 @@ MACHINE_START(NOMADIK, "NHK8815")
 	/* Maintainer: ST MicroElectronics */
 	.atag_offset	= 0x100,
 	.map_io		= cpu8815_map_io,
+	.nr_irqs	= NOMADIK_NR_IRQS,
 	.init_irq	= cpu8815_init_irq,
 	.handle_irq	= vic_handle_irq,
 	.timer		= &nomadik_timer,
diff --git a/arch/arm/mach-nomadik/include/mach/irqs.h b/arch/arm/mach-nomadik/include/mach/irqs.h
index a118e61..b549d05 100644
--- a/arch/arm/mach-nomadik/include/mach/irqs.h
+++ b/arch/arm/mach-nomadik/include/mach/irqs.h
@@ -72,7 +72,7 @@
 #define NOMADIK_NR_GPIO			128 /* last 4 not wired to pins */
 #define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + NOMADIK_GPIO_OFFSET)
 #define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - NOMADIK_GPIO_OFFSET)
-#define NR_IRQS				NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
+#define NOMADIK_NR_IRQS			NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
 
 /* Following two are used by entry_macro.S, to access our dual-vic */
 #define VIC_REG_IRQSR0		0
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index a534d88..f5f979f 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -695,6 +695,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	/* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
 	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
+	.nr_irqs	= UX500_NR_IRQS,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
@@ -706,6 +707,7 @@ MACHINE_END
 MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
 	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
+	.nr_irqs	= UX500_NR_IRQS,
 	.init_irq	= ux500_init_irq,
 	.timer		= &ux500_timer,
 	.handle_irq	= gic_handle_irq,
@@ -716,6 +718,7 @@ MACHINE_END
 MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
 	.atag_offset	= 0x100,
 	.map_io		= u8500_map_io,
+	.nr_irqs	= UX500_NR_IRQS,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
@@ -845,6 +848,7 @@ static const char * u8500_dt_board_compat[] = {
 
 DT_MACHINE_START(U8500_DT, "ST-Ericsson U8500 platform (Device Tree Support)")
 	.map_io		= u8500_map_io,
+	.nr_irqs	= UX500_NR_IRQS,
 	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &ux500_timer,
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index db3c52d..0a09647 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -26,6 +26,7 @@
 #include <mach/devices.h>
 #include <mach/usb.h>
 #include <mach/db8500-regs.h>
+#include <mach/irqs.h>
 
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index dfdd4a5..0923dbd 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -15,6 +15,7 @@
 #include <plat/gpio-nomadik.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 
 #include "devices-common.h"
 
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 91754a8..bec92a7 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -17,6 +17,7 @@
 
 #include <mach/hardware.h>
 #include <mach/setup.h>
+#include <mach/irqs.h>
 
 #include "ste-dma40-db8500.h"
 
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index 3c8010f..4b24c99 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -8,6 +8,7 @@
 #ifndef __DEVICES_DB8500_H
 #define __DEVICES_DB8500_H
 
+#include <mach/irqs.h>
 #include "devices-common.h"
 
 struct ske_keypad_platform_data;
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index e892854..fc77b42 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -46,6 +46,6 @@
 #include <mach/irqs-board-mop500.h>
 #endif
 
-#define NR_IRQS			IRQ_BOARD_END
+#define UX500_NR_IRQS		IRQ_BOARD_END
 
 #endif /* ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 66e7f00..4395ca5 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -96,7 +96,7 @@ dt_fail:
 	 *
 	 */
 
-	nmdk_timer_init(mtu_timer_base);
+	nmdk_timer_init(mtu_timer_base, IRQ_MTU0);
 	clksrc_dbx500_prcmu_init(prcmu_timer_base);
 	ux500_twd_init();
 }
diff --git a/arch/arm/plat-nomadik/include/plat/mtu.h b/arch/arm/plat-nomadik/include/plat/mtu.h
index 582641f..8008897 100644
--- a/arch/arm/plat-nomadik/include/plat/mtu.h
+++ b/arch/arm/plat-nomadik/include/plat/mtu.h
@@ -1,7 +1,7 @@
 #ifndef __PLAT_MTU_H
 #define __PLAT_MTU_H
 
-void nmdk_timer_init(void __iomem *base);
+void nmdk_timer_init(void __iomem *base, int irq);
 void nmdk_clkevt_reset(void);
 void nmdk_clksrc_reset(void);
 
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index 9222e55..0ae2b06 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -174,7 +174,7 @@ void nmdk_clksrc_reset(void)
 	       mtu_base + MTU_CR(0));
 }
 
-void __init nmdk_timer_init(void __iomem *base)
+void __init nmdk_timer_init(void __iomem *base, int irq)
 {
 	unsigned long rate;
 	struct clk *clk0;
@@ -217,7 +217,7 @@ void __init nmdk_timer_init(void __iomem *base)
 #endif
 
 	/* Timer 1 is used for events, register irq and clockevents */
-	setup_irq(IRQ_MTU0, &nmdk_timer_irq);
+	setup_irq(irq, &nmdk_timer_irq);
 	nmdk_clkevt.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&nmdk_clkevt, rate, 2, 0xffffffffU);
 }
diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 3dde653..2844e50 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -35,6 +35,7 @@
 
 #include <plat/pincfg.h>
 #include <plat/gpio-nomadik.h>
+#include <mach/irqs.h>
 
 #include "pinctrl-nomadik.h"
 
-- 
1.7.11.3
