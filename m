From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 11:51:57 +0000
Subject: [PATCH 40/40] ARM: vexpress: add sched_clock() for Versatile Express
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <E1PTYqr-0006kE-Bf@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a sched_clock() implementation to Versatile Express using the new
sched_clock() infrastructure for extending 32bit counters to full
64-bit nanoseconds.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                 |    1 +
 arch/arm/mach-vexpress/v2m.c     |    4 ++++
 arch/arm/plat-versatile/Makefile |    4 +---
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 34311f4..17b5ff0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -268,6 +268,7 @@ config ARCH_VEXPRESS
 	select COMMON_CLKDEV
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
+	select HAVE_SCHED_CLOCK
 	select ICST
 	select PLAT_VERSATILE
 	help
diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 7eaa232..8c28310 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -22,6 +22,8 @@
 #include <mach/clkdev.h>
 #include <mach/motherboard.h>
 
+#include <plat/sched_clock.h>
+
 #include <plat/timer-sp.h>
 
 #include "core.h"
@@ -50,6 +52,8 @@ void __init v2m_map_io(struct map_desc *tile, size_t num)
 
 static void __init v2m_timer_init(void)
 {
+	versatile_sched_clock_init(MMIO_P2V(V2M_SYS_24MHZ), 24000000);
+
 	writel(0, MMIO_P2V(V2M_TIMER0) + TIMER_CTRL);
 	writel(0, MMIO_P2V(V2M_TIMER1) + TIMER_CTRL);
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 5cf88e8..230eb37 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,7 +1,5 @@
-obj-y	:= clock.o
+obj-y	:= clock.o sched-clock.o
 obj-$(CONFIG_ARM_TIMER_SP804) += timer-sp.o
-obj-$(CONFIG_ARCH_REALVIEW) += sched-clock.o
-obj-$(CONFIG_ARCH_VERSATILE) += sched-clock.o
 ifeq ($(CONFIG_LEDS_CLASS),y)
 obj-$(CONFIG_ARCH_REALVIEW) += leds.o
 obj-$(CONFIG_ARCH_VERSATILE) += leds.o
-- 
1.6.2.5
