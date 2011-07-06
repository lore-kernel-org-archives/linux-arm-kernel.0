From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 6 Jul 2011 21:11:01 +0800
Subject: [PATCH] ARM: mxc: use ARCH_NR_GPIOS to define gpio number
Message-ID: <mailman.14.1310051235.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch removes MXC_GPIO_IRQS and instead uses ARCH_NR_GPIOS to
define gpio number.  This change is need when we change mxc gpio
driver to be device tree aware.  When migrating the driver to device
tree, pdev->id becomes unusable.  It requires driver get gpio range
from gpio core, which will dynamically allocates number from
ARCH_NR_GPIOS to 0.

As a bonus point, it removes lines of '#if' and make the code a
little bit cleaner.

It also cleans a couple of unnecessary headers in mach/gpio.h.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/plat-mxc/include/mach/gpio.h |    9 ++++++---
 arch/arm/plat-mxc/include/mach/irqs.h |   21 +++------------------
 2 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 31c820c..f3b26f7 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -19,10 +19,13 @@
 #ifndef __ASM_ARCH_MXC_GPIO_H__
 #define __ASM_ARCH_MXC_GPIO_H__
 
-#include <linux/spinlock.h>
-#include <mach/hardware.h>
-#include <asm-generic/gpio.h>
+/*
+ * Define our own ARCH_NR_GPIOS here to override the one
+ * externally defined in asm-generic/gpio.h
+ */
+#define ARCH_NR_GPIOS	224
 
+#include <asm-generic/gpio.h>
 
 /* There's a off-by-one betweem the gpio bank number and the gpiochip */
 /* range e.g. GPIO_1_5 is gpio 5 under linux */
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 35c89bc..62228f1 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -11,6 +11,8 @@
 #ifndef __ASM_ARCH_MXC_IRQS_H__
 #define __ASM_ARCH_MXC_IRQS_H__
 
+#include <mach/gpio.h>
+
 /*
  * SoCs with TZIC interrupt controller have 128 IRQs, those with AVIC have 64
  */
@@ -22,30 +24,13 @@
 
 #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
 
-/* these are ordered by size to support multi-SoC kernels */
-#if defined CONFIG_SOC_IMX53
-#define MXC_GPIO_IRQS		(32 * 7)
-#elif defined CONFIG_ARCH_MX2
-#define MXC_GPIO_IRQS		(32 * 6)
-#elif defined CONFIG_SOC_IMX50
-#define MXC_GPIO_IRQS		(32 * 6)
-#elif defined CONFIG_ARCH_MX1
-#define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MX25
-#define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_SOC_IMX51
-#define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MX3
-#define MXC_GPIO_IRQS		(32 * 3)
-#endif
-
 /*
  * The next 16 interrupts are for board specific purposes.  Since
  * the kernel can only run on one machine at a time, we can re-use
  * these.  If you need more, increase MXC_BOARD_IRQS, but keep it
  * within sensible limits.
  */
-#define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + MXC_GPIO_IRQS)
+#define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + ARCH_NR_GPIOS)
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
 #define MXC_BOARD_IRQS  80

-- 
Regards,
Shawn
