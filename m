From: robherring2@gmail.com (Rob Herring)
Date: Mon, 16 Jan 2012 20:40:11 -0600
Subject: [PATCH 1/2] ARM: timer-sp: add sched_clock support
Message-ID: <1326768012-2719-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add a sched_clock support for the sp804 timer. The clocksource timer
can optionally initialize itself as sched_clock timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                         |    1 +
 arch/arm/common/timer-sp.c               |   17 ++++++++++++++++-
 arch/arm/include/asm/hardware/timer-sp.h |   15 ++++++++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..6afd574 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1129,6 +1129,7 @@ config PLAT_VERSATILE
 config ARM_TIMER_SP804
 	bool
 	select CLKSRC_MMIO
+	select HAVE_SCHED_CLOCK
 
 source arch/arm/mm/Kconfig
 
diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index 8794a34..df13a3f 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -26,6 +26,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
+#include <asm/sched_clock.h>
 #include <asm/hardware/arm_timer.h>
 
 static long __init sp804_get_clock_rate(const char *name)
@@ -67,7 +68,16 @@ static long __init sp804_get_clock_rate(const char *name)
 	return rate;
 }
 
-void __init sp804_clocksource_init(void __iomem *base, const char *name)
+static void __iomem *sched_clock_base;
+
+static u32 sp804_read(void)
+{
+	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
+}
+
+void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
+						     const char *name,
+						     int use_sched_clock)
 {
 	long rate = sp804_get_clock_rate(name);
 
@@ -83,6 +93,11 @@ void __init sp804_clocksource_init(void __iomem *base, const char *name)
 
 	clocksource_mmio_init(base + TIMER_VALUE, name,
 		rate, 200, 32, clocksource_mmio_readl_down);
+
+	if (use_sched_clock) {
+		sched_clock_base = base;
+		setup_sched_clock(sp804_read, 32, rate);
+	}
 }
 
 
diff --git a/arch/arm/include/asm/hardware/timer-sp.h b/arch/arm/include/asm/hardware/timer-sp.h
index 4384d81..2dd9d3f 100644
--- a/arch/arm/include/asm/hardware/timer-sp.h
+++ b/arch/arm/include/asm/hardware/timer-sp.h
@@ -1,2 +1,15 @@
-void sp804_clocksource_init(void __iomem *, const char *);
+void __sp804_clocksource_and_sched_clock_init(void __iomem *,
+					      const char *, int);
+
+static inline void sp804_clocksource_init(void __iomem *base, const char *name)
+{
+	__sp804_clocksource_and_sched_clock_init(base, name, 0);
+}
+
+static inline void sp804_clocksource_and_sched_clock_init(void __iomem *base,
+							  const char *name)
+{
+	__sp804_clocksource_and_sched_clock_init(base, name, 1);
+}
+
 void sp804_clockevents_init(void __iomem *, unsigned int, const char *);
-- 
1.7.5.4
