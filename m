From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 May 2015 13:44:44 +0100
Subject: [PATCH v2 2/2] ARM: move Dual-Timer SP804 driver to
 drivers/clocksource
In-Reply-To: <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
References: <1430390662-18246-1-git-send-email-sudeep.holla@arm.com>
 <1431953084-15700-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1431953084-15700-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM Dual-Timer SP804 module is peripheral found not only on ARM32
platforms but also on ARM64 platforms.

This patch moves the driver out of arch/arm to driver/clocksource
so that it can be used on ARM64 platforms also.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/Kconfig                                                   | 5 -----
 arch/arm/common/Makefile                                           | 1 -
 arch/arm/mach-nspire/nspire.c                                      | 2 --
 arch/arm/mach-realview/core.c                                      | 4 ++--
 arch/arm/mach-versatile/core.c                                     | 3 ++-
 drivers/clocksource/Kconfig                                        | 5 +++++
 drivers/clocksource/Makefile                                       | 1 +
 drivers/clocksource/timer-integrator-ap.c                          | 3 ++-
 .../asm/hardware/arm_timer.h => drivers/clocksource/timer-sp.h     | 5 -----
 arch/arm/common/timer-sp.c => drivers/clocksource/timer-sp804.c    | 7 ++++---
 .../asm/hardware/timer-sp.h => include/clocksource/timer-sp804.h   | 4 ++++
 11 files changed, 20 insertions(+), 20 deletions(-)
 rename arch/arm/include/asm/hardware/arm_timer.h => drivers/clocksource/timer-sp.h (93%)
 rename arch/arm/common/timer-sp.c => drivers/clocksource/timer-sp804.c (98%)
 rename arch/arm/include/asm/hardware/timer-sp.h => include/clocksource/timer-sp804.h (90%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48ba0b12..3a1eb1bdac03 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -975,11 +975,6 @@ config PLAT_PXA
 config PLAT_VERSATILE
 	bool

-config ARM_TIMER_SP804
-	bool
-	select CLKSRC_MMIO
-	select CLKSRC_OF if OF
-
 source "arch/arm/firmware/Kconfig"

 source arch/arm/mm/Kconfig
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 70b1eff477b3..6ee5959a813b 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
-obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
 AFLAGS_mcpm_head.o		:= -march=armv7-a
diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 3445a5686805..34c2a1b32e7d 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -22,8 +22,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>

-#include <asm/hardware/timer-sp.h>
-
 #include "mmio.h"
 #include "clcd.h"

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index c611f489bdd2..44575edc44b1 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -35,6 +35,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/memblock.h>

+#include <clocksource/timer-sp804.h>
+
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
@@ -44,10 +46,8 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/map.h>

-
 #include <mach/platform.h>
 #include <mach/irqs.h>
-#include <asm/hardware/timer-sp.h>

 #include <plat/sched_clock.h>

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index f98c1961be6a..23a04fe5d2ad 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -41,6 +41,8 @@
 #include <linux/bitops.h>
 #include <linux/reboot.h>

+#include <clocksource/timer-sp804.h>
+
 #include <asm/irq.h>
 #include <asm/hardware/icst.h>
 #include <asm/mach-types.h>
@@ -51,7 +53,6 @@
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
 #include <mach/platform.h>
-#include <asm/hardware/timer-sp.h>

 #include <plat/sched_clock.h>

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 51d7865fdddb..0f1c0e7f86da 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -132,6 +132,11 @@ config ARM_GLOBAL_TIMER
 	help
 	  This options enables support for the ARM global timer unit

+config ARM_TIMER_SP804
+	bool "Support for Dual Timer SP804 module"
+	select CLKSRC_MMIO
+	select CLKSRC_OF if OF
+
 config CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	bool
 	depends on ARM_GLOBAL_TIMER
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5b85f6adb258..5ca59f9b377f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_MTK_TIMER)		+= mtk_timer.o

 obj-$(CONFIG_ARM_ARCH_TIMER)		+= arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+= arm_global_timer.o
+obj-$(CONFIG_ARM_TIMER_SP804)		+= timer-sp804.o
 obj-$(CONFIG_CLKSRC_METAG_GENERIC)	+= metag_generic.o
 obj-$(CONFIG_ARCH_HAS_TICK_BROADCAST)	+= dummy_timer.o
 obj-$(CONFIG_ARCH_KEYSTONE)		+= timer-keystone.o
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index b9efd30513d5..d7d21e4dcef0 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -26,7 +26,8 @@
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/sched_clock.h>
-#include <asm/hardware/arm_timer.h>
+
+#include "timer-sp.h"

 static void __iomem * sched_clk_base;

diff --git a/arch/arm/include/asm/hardware/arm_timer.h b/drivers/clocksource/timer-sp.h
similarity index 93%
rename from arch/arm/include/asm/hardware/arm_timer.h
rename to drivers/clocksource/timer-sp.h
index d6030ff599db..050d88561e9c 100644
--- a/arch/arm/include/asm/hardware/arm_timer.h
+++ b/drivers/clocksource/timer-sp.h
@@ -1,6 +1,3 @@
-#ifndef __ASM_ARM_HARDWARE_ARM_TIMER_H
-#define __ASM_ARM_HARDWARE_ARM_TIMER_H
-
 /*
  * ARM timer implementation, found in Integrator, Versatile and Realview
  * platforms.  Not all platforms support all registers and bits in these
@@ -31,5 +28,3 @@
 #define TIMER_RIS	0x10			/*  CVR ro */
 #define TIMER_MIS	0x14			/*  CVR ro */
 #define TIMER_BGLOAD	0x18			/*  CVR rw */
-
-#endif
diff --git a/arch/arm/common/timer-sp.c b/drivers/clocksource/timer-sp804.c
similarity index 98%
rename from arch/arm/common/timer-sp.c
rename to drivers/clocksource/timer-sp804.c
index 000aea3722bc..ca02503f17d1 100644
--- a/arch/arm/common/timer-sp.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -1,5 +1,5 @@
 /*
- *  linux/arch/arm/common/timer-sp.c
+ *  linux/drivers/clocksource/timer-sp.c
  *
  *  Copyright (C) 1999 - 2003 ARM Limited
  *  Copyright (C) 2000 Deep Blue Solutions Ltd
@@ -30,8 +30,9 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>

-#include <asm/hardware/arm_timer.h>
-#include <asm/hardware/timer-sp.h>
+#include <clocksource/timer-sp804.h>
+
+#include "timer-sp.h"

 static long __init sp804_get_clock_rate(struct clk *clk)
 {
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/include/clocksource/timer-sp804.h
similarity index 90%
rename from arch/arm/include/asm/hardware/timer-sp.h
rename to include/clocksource/timer-sp804.h
index 05eaefa46742..1f8a1caa7cb4 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/include/clocksource/timer-sp804.h
@@ -1,3 +1,6 @@
+#ifndef __CLKSOURCE_TIMER_SP804_H
+#define __CLKSOURCE_TIMER_SP804_H
+
 struct clk;

 void __sp804_clocksource_and_sched_clock_init(void __iomem *,
@@ -22,3 +25,4 @@ static inline void sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	__sp804_clockevents_init(base, irq, NULL, name);

 }
+#endif
--
1.9.1
