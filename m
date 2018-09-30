From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 30 Sep 2018 23:16:06 +0200
Subject: [PATCH 1/3] ARM: ep93xx: Move timer driver to the clocksource
 subsystem
Message-ID: <20180930211608.5516-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before starting to expand the EP93xx timer driver to be more
self-contained and before adding device tree support, move it
over to the clocksource subsystem.

Provide a base passed in to the init function, and add a
static inline in the EP93xx soc.h local header to call down
into the timer driver. Expose the init function in a new
platform data header that can eventually go away the day
we have converted all EP93xx platforms over to use device
tree.

Also pass the IRQ as a parameter, else this will never work
with sparse IRQs.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Clocksource: please ACK this if OK so I can merge this
patch through the ARM SoC tree.
---
 arch/arm/Kconfig                                    |  2 +-
 arch/arm/mach-ep93xx/Makefile                       |  2 +-
 arch/arm/mach-ep93xx/core.c                         |  1 +
 arch/arm/mach-ep93xx/include/mach/platform.h        |  1 -
 arch/arm/mach-ep93xx/soc.h                          |  8 ++++++++
 drivers/clocksource/Kconfig                         |  8 ++++++++
 drivers/clocksource/Makefile                        |  1 +
 .../clocksource}/timer-ep93xx.c                     | 13 +++++++++----
 include/linux/platform_data/timer-ep93xx.h          |  7 +++++++
 9 files changed, 36 insertions(+), 7 deletions(-)
 rename {arch/arm/mach-ep93xx => drivers/clocksource}/timer-ep93xx.c (94%)
 create mode 100644 include/linux/platform_data/timer-ep93xx.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a5b04c..8d279e41cd9d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -375,8 +375,8 @@ config ARCH_EP93XX
 	select ARM_VIC
 	select AUTO_ZRELADDR
 	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
 	select CPU_ARM920T
+	select EP93XX_TIMER
 	select GENERIC_CLOCKEVENTS
 	select GPIOLIB
 	help
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index 86768495f61d..6c8e4366e6cf 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for the linux kernel.
 #
-obj-y			:= core.o clock.o timer-ep93xx.o
+obj-y			:= core.o clock.o
 
 obj-$(CONFIG_EP93XX_DMA)	+= dma.o
 
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 927234d2a7ba..48b36eff0a94 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -40,6 +40,7 @@
 #include <linux/random.h>
 
 #include <mach/hardware.h>
+#include <linux/platform_data/timer-ep93xx.h>
 #include <linux/platform_data/video-ep93xx.h>
 #include <linux/platform_data/keypad-ep93xx.h>
 #include <linux/platform_data/spi-ep93xx.h>
diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 8165d998b7fe..5c3c00f119f0 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -56,7 +56,6 @@ int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
 void ep93xx_ide_release_gpio(struct platform_device *pdev);
 
 struct device *ep93xx_init_devices(void);
-extern void ep93xx_timer_init(void);
 
 void ep93xx_restart(enum reboot_mode, const char *);
 void ep93xx_init_late(void);
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index d20e631164cf..5d19b216e3c3 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -14,6 +14,9 @@
 #define _EP93XX_SOC_H
 
 #include <mach/ep93xx-regs.h>
+#include <mach/irqs.h>
+#include <linux/io.h>
+#include <linux/platform_data/timer-ep93xx.h>
 
 /*
  * EP93xx Physical Memory Map:
@@ -212,4 +215,9 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
 	ep93xx_devcfg_set_clear(0x00, bits);
 }
 
+static inline void __init ep93xx_timer_init(void)
+{
+	ep93xx_timer_init_common(EP93XX_TIMER_BASE, IRQ_EP93XX_TIMER3);
+}
+
 #endif /* _EP93XX_SOC_H */
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a11f4ba98b05..7a68cd3df3dc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -59,6 +59,14 @@ config DW_APB_TIMER_OF
 	select DW_APB_TIMER
 	select TIMER_OF
 
+config EP93XX_TIMER
+	bool "Cirrus Logic EP93xx timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	help
+	  Enables support for the Cirrus Logic EP93xx family
+	  SoCs.
+
 config FTTMR010_TIMER
 	bool "Faraday Technology timer driver" if COMPILE_TEST
 	depends on HAS_IOMEM
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index db51b2427e8a..ae6cbddb519b 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_DIGICOLOR_TIMER)	+= timer-digicolor.o
 obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
+obj-$(CONFIG_EP93XX_TIMER)	+= timer-ep93xx.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
 obj-$(CONFIG_ROCKCHIP_TIMER)      += rockchip_timer.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
similarity index 94%
rename from arch/arm/mach-ep93xx/timer-ep93xx.c
rename to drivers/clocksource/timer-ep93xx.c
index de998830f534..9b5e98446d77 100644
--- a/arch/arm/mach-ep93xx/timer-ep93xx.c
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -7,8 +7,10 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/platform_data/timer-ep93xx.h>
 #include <asm/mach/time.h>
-#include "soc.h"
+
+static void __iomem *ep93xx_base;
 
 /*************************************************************************
  * Timer handling for EP93xx
@@ -28,7 +30,7 @@
  * a stable 40 bit time base.
  *************************************************************************
  */
-#define EP93XX_TIMER_REG(x)		(EP93XX_TIMER_BASE + (x))
+#define EP93XX_TIMER_REG(x)		(ep93xx_base + (x))
 #define EP93XX_TIMER1_LOAD		EP93XX_TIMER_REG(0x00)
 #define EP93XX_TIMER1_VALUE		EP93XX_TIMER_REG(0x04)
 #define EP93XX_TIMER1_CONTROL		EP93XX_TIMER_REG(0x08)
@@ -124,8 +126,10 @@ static struct irqaction ep93xx_timer_irq = {
 	.dev_id		= &ep93xx_clockevent,
 };
 
-void __init ep93xx_timer_init(void)
+int __init ep93xx_timer_init_common(void __iomem *base, int irq)
 {
+	ep93xx_base = base;
+
 	/* Enable and register clocksource and sched_clock on timer 4 */
 	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
 	       EP93XX_TIMER4_VALUE_HIGH);
@@ -136,9 +140,10 @@ void __init ep93xx_timer_init(void)
 			     EP93XX_TIMER4_RATE);
 
 	/* Set up clockevent on timer 3 */
-	setup_irq(IRQ_EP93XX_TIMER3, &ep93xx_timer_irq);
+	setup_irq(irq, &ep93xx_timer_irq);
 	clockevents_config_and_register(&ep93xx_clockevent,
 					EP93XX_TIMER123_RATE,
 					1,
 					0xffffffffU);
+	return 0;
 }
diff --git a/include/linux/platform_data/timer-ep93xx.h b/include/linux/platform_data/timer-ep93xx.h
new file mode 100644
index 000000000000..e839e2051d81
--- /dev/null
+++ b/include/linux/platform_data/timer-ep93xx.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TIMER_EP93XX_H
+#define __TIMER_EP93XX_H
+
+extern int ep93xx_timer_init_common(void __iomem *base, int irq);
+
+#endif
-- 
2.17.1
