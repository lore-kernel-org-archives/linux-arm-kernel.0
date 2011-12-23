From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 23 Dec 2011 23:27:20 +0530
Subject: [PATCH 2/2] ARM: davinci: convert sched_clock() to use common
 infrastructure
In-Reply-To: <1324663040-2859-1-git-send-email-nsekhar@ti.com>
References: <1324663040-2859-1-git-send-email-nsekhar@ti.com>
Message-ID: <1324663040-2859-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert davinci to use the common sched_clock() infrastructure
for extending 32bit counters to full 64-bit nanoseconds.

Eventually clocksource timer should be initialized from init_early
so there would be no need to use a dummy clocksource read at start.

Tested-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/Kconfig             |    1 +
 arch/arm/mach-davinci/time.c |   15 ++++++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 776d76b..3304316 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -925,6 +925,7 @@ config ARCH_DAVINCI
 	select ARCH_REQUIRE_GPIOLIB
 	select ZONE_DMA
 	select HAVE_IDE
+	select HAVE_SCHED_CLOCK
 	select CLKDEV_LOOKUP
 	select GENERIC_ALLOCATOR
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index f2afb2d..e7d8b52 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 
+#include <asm/sched_clock.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
@@ -291,15 +292,21 @@ static struct clocksource clocksource_davinci = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static DEFINE_CLOCK_DATA(cd);
+
 /*
  * Overwrite weak default sched_clock with something more precise
  */
 unsigned long long notrace sched_clock(void)
 {
-	const cycle_t cyc = clocksource_davinci.read(&clocksource_davinci);
+	u32 cyc = clocksource_davinci.read(&clocksource_davinci);
+	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+}
 
-	return clocksource_cyc2ns(cyc, clocksource_davinci.mult,
-				clocksource_davinci.shift);
+static void notrace davinci_update_sched_clock(void)
+{
+	u32 cyc = timer32_read(&timers[TID_CLOCKSOURCE]);
+	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 /*
@@ -401,6 +408,8 @@ static void __init davinci_timer_init(void)
 	/* setup clocksource */
 	clocksource_davinci.read = read_cycles;
 	clocksource_davinci.name = id_to_name[clocksource_id];
+	init_sched_clock(&cd, davinci_update_sched_clock, 32,
+			 davinci_clock_tick_rate);
 	if (clocksource_register_hz(&clocksource_davinci,
 				    davinci_clock_tick_rate))
 		printk(err, clocksource_davinci.name);
-- 
1.6.2.4
