From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 13:05:32 +0800
Subject: [PATCH v3 01/11] clocksource: move sp timer driver
In-Reply-To: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1363151142-32162-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All clocksource drivers should be moved into drivers/clocksource
directory, since it's necessary for integrating them into clocksource_of
infrastructure.

Move ARM SP804 timer driver from arch/arm directory into
drivers/clocksource directory.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig                                                  |    5 -----
 arch/arm/common/Makefile                                          |    1 -
 arch/arm/mach-highbank/highbank.c                                 |    4 ++--
 arch/arm/mach-integrator/integrator_ap.c                          |    2 +-
 arch/arm/mach-integrator/integrator_cp.c                          |    4 ++--
 arch/arm/mach-realview/core.c                                     |    4 ++--
 arch/arm/mach-versatile/core.c                                    |    4 ++--
 arch/arm/mach-vexpress/ct-ca9x4.c                                 |    5 ++---
 arch/arm/mach-vexpress/v2m.c                                      |    4 ++--
 drivers/clocksource/Kconfig                                       |    5 +++++
 drivers/clocksource/Makefile                                      |    1 +
 {arch/arm/common => drivers/clocksource}/timer-sp.c               |    2 +-
 .../arm/include/asm/hardware => include/clocksource}/arm_timer.h  |    4 ++--
 {arch/arm/include/asm/hardware => include/clocksource}/timer-sp.h |    4 ++++
 14 files changed, 26 insertions(+), 23 deletions(-)
 rename {arch/arm/common => drivers/clocksource}/timer-sp.c (99%)
 rename {arch/arm/include/asm/hardware => include/clocksource}/arm_timer.h (93%)
 rename {arch/arm/include/asm/hardware => include/clocksource}/timer-sp.h (87%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2363926..10d7e2c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1177,11 +1177,6 @@ config PLAT_PXA
 config PLAT_VERSATILE
 	bool
 
-config ARM_TIMER_SP804
-	bool
-	select CLKSRC_MMIO
-	select HAVE_SCHED_CLOCK
-
 source arch/arm/mm/Kconfig
 
 config ARM_NR_BANKS
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 45f7eae..a4e49e7 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -12,4 +12,3 @@ obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
-obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index a4f9f50..cfd843b 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -27,14 +27,14 @@
 #include <linux/smp.h>
 #include <linux/amba/bus.h>
 #include <linux/clk-provider.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/arch_timer.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_twd.h>
-#include <asm/hardware/arm_timer.h>
-#include <asm/hardware/timer-sp.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ea96144..c2112ff 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -41,11 +41,11 @@
 #include <linux/stat.h>
 #include <linux/sys_soc.h>
 #include <linux/termios.h>
+#include <clocksource/arm_timer.h>
 #include <video/vga.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/setup.h>
 #include <asm/param.h>		/* HZ */
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 2b0db82..40373ec 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -28,12 +28,13 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/sys_soc.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <mach/hardware.h>
 #include <mach/platform.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <mach/cm.h>
@@ -45,7 +46,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
-#include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1d5ee5c..26a3da38 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -31,11 +31,12 @@
 #include <linux/amba/mmci.h>
 #include <linux/gfp.h>
 #include <linux/mtd/physmap.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 
 #include <asm/mach/arch.h>
@@ -45,7 +46,6 @@
 
 #include <mach/platform.h>
 #include <mach/irqs.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 25160ae..e894a1f 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -38,9 +38,10 @@
 #include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
 #include <linux/bitops.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/irq.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/icst.h>
 #include <asm/mach-types.h>
 
@@ -50,7 +51,6 @@
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <plat/clcd.h>
 #include <plat/sched_clock.h>
diff --git a/arch/arm/mach-vexpress/ct-ca9x4.c b/arch/arm/mach-vexpress/ct-ca9x4.c
index 6f34497..48f6676 100644
--- a/arch/arm/mach-vexpress/ct-ca9x4.c
+++ b/arch/arm/mach-vexpress/ct-ca9x4.c
@@ -11,16 +11,15 @@
 #include <linux/clkdev.h>
 #include <linux/vexpress.h>
 #include <linux/irqchip/arm-gic.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_scu.h>
 #include <asm/smp_twd.h>
 
 #include <mach/ct-ca9x4.h>
 
-#include <asm/hardware/timer-sp.h>
-
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 915683c..51e8701 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -21,6 +21,8 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/vexpress.h>
+#include <clocksource/arm_timer.h>
+#include <clocksource/timer-sp.h>
 
 #include <asm/arch_timer.h>
 #include <asm/mach-types.h>
@@ -29,9 +31,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
-#include <asm/hardware/arm_timer.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/hardware/timer-sp.h>
 
 #include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index e8c4532..4c04d19 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -63,6 +63,11 @@ config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
 config ARM_ARCH_TIMER
 	bool
 
+config ARM_TIMER_SP804
+	bool
+	select CLKSRC_MMIO
+	select HAVE_SCHED_CLOCK
+
 config CLKSRC_METAG_GENERIC
 	def_bool y if METAG
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 1c1b15d..9d3ad88 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -22,4 +22,5 @@ obj-$(CONFIG_VT8500_TIMER)	+= vt8500_timer.o
 obj-$(CONFIG_CLKSRC_EXYNOS_MCT)	+= exynos_mct.o
 
 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
+obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
diff --git a/arch/arm/common/timer-sp.c b/drivers/clocksource/timer-sp.c
similarity index 99%
rename from arch/arm/common/timer-sp.c
rename to drivers/clocksource/timer-sp.c
index 9d2d3ba..a7f2510 100644
--- a/arch/arm/common/timer-sp.c
+++ b/drivers/clocksource/timer-sp.c
@@ -25,9 +25,9 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <clocksource/arm_timer.h>
 
 #include <asm/sched_clock.h>
-#include <asm/hardware/arm_timer.h>
 
 static long __init sp804_get_clock_rate(const char *name)
 {
diff --git a/arch/arm/include/asm/hardware/arm_timer.h b/include/clocksource/arm_timer.h
similarity index 93%
rename from arch/arm/include/asm/hardware/arm_timer.h
rename to include/clocksource/arm_timer.h
index d6030ff..f4a443a 100644
--- a/arch/arm/include/asm/hardware/arm_timer.h
+++ b/include/clocksource/arm_timer.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_ARM_HARDWARE_ARM_TIMER_H
-#define __ASM_ARM_HARDWARE_ARM_TIMER_H
+#ifndef __CLOCKSOURCE_ARM_TIMER_H
+#define __CLOCKSOURCE_ARM_TIMER_H
 
 /*
  * ARM timer implementation, found in Integrator, Versatile and Realview
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/include/clocksource/timer-sp.h
similarity index 87%
rename from arch/arm/include/asm/hardware/timer-sp.h
rename to include/clocksource/timer-sp.h
index 2dd9d3f..0ad4186 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/include/clocksource/timer-sp.h
@@ -1,3 +1,6 @@
+#ifndef __TIMER_SP_H
+#define __TIMER_SP_H
+
 void __sp804_clocksource_and_sched_clock_init(void __iomem *,
 					      const char *, int);
 
@@ -13,3 +16,4 @@ static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
 }
 
 void sp804_clockevents_init(void __iomem *, unsigned int, const char *);
+#endif	/* __TIMER_SP_H */
-- 
1.7.10.4
