From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 13 Aug 2012 13:58:23 +0200
Subject: [PATCH 7/7] ARM: u300: convert to sparse IRQs
Message-ID: <1344859103-29517-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This converts the U300 to use sparse IRQs, which is simple now
that the number of machines are reduced.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                       | 1 +
 arch/arm/mach-u300/core.c              | 3 ++-
 arch/arm/mach-u300/include/mach/irqs.h | 2 +-
 arch/arm/mach-u300/timer.c             | 3 ++-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..0fb682d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -937,6 +937,7 @@ config ARCH_U300
 	select COMMON_CLK
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
+	select SPARSE_IRQ
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
index 31cc926..ef6f602 100644
--- a/arch/arm/mach-u300/core.c
+++ b/arch/arm/mach-u300/core.c
@@ -38,13 +38,13 @@
 #include <asm/memory.h>
 #include <asm/hardware/vic.h>
 #include <asm/mach/map.h>
-#include <asm/mach/irq.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
 #include <mach/coh901318.h>
 #include <mach/hardware.h>
 #include <mach/syscon.h>
+#include <mach/irqs.h>
 
 #include "timer.h"
 #include "spi.h"
@@ -1807,6 +1807,7 @@ MACHINE_START(U300, "Ericsson AB U335 S335/B335 Prototype Board")
 	/* Maintainer: Linus Walleij <linus.walleij@stericsson.com> */
 	.atag_offset	= 0x100,
 	.map_io		= u300_map_io,
+	.nr_irqs	= NR_IRQS_U300,
 	.init_irq	= u300_init_irq,
 	.handle_irq	= vic_handle_irq,
 	.timer		= &u300_timer,
diff --git a/arch/arm/mach-u300/include/mach/irqs.h b/arch/arm/mach-u300/include/mach/irqs.h
index c09386b..e27425a 100644
--- a/arch/arm/mach-u300/include/mach/irqs.h
+++ b/arch/arm/mach-u300/include/mach/irqs.h
@@ -85,6 +85,6 @@
 #define IRQ_U300_GPIO_END		(U300_VIC_IRQS_END)
 #endif
 
-#define NR_IRQS				(IRQ_U300_GPIO_END - IRQ_U300_INTCON0_START)
+#define NR_IRQS_U300			(IRQ_U300_GPIO_END - IRQ_U300_INTCON0_START)
 
 #endif
diff --git a/arch/arm/mach-u300/timer.c b/arch/arm/mach-u300/timer.c
index 146e815..1da10e2 100644
--- a/arch/arm/mach-u300/timer.c
+++ b/arch/arm/mach-u300/timer.c
@@ -17,14 +17,15 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 
 /* Generic stuff */
 #include <asm/sched_clock.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/mach/irq.h>
 
 #include "timer.h"
 
-- 
1.7.11.3
