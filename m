From: klimov.linux@gmail.com (Alexey Klimov)
Date: Tue, 28 Jul 2015 00:28:32 +0300
Subject: [RFC PATCH 1/3] clocksource: exynos_mct: allow mct to read counter
 from coprocessor
Message-ID: <1438032512.17734.47.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was discovered that 64-bit mmio MCT counter holds
the same value as ARM arch timer 64-bit physical counter.
Even more: arch timer and MCT are same underlying hardware
timer.

Patch adds code to MCT to allow it to read 64-bit counter
from coprocessor cp15 registers since it's way more
faster than reading the same counter from MCT mmio region.

That functionality triggers only if special property
use-cp15-phys-counter is present in device tree,
only on 32-bit ARMv7 systems and only if HYP mode is
available.

Idea of rewriting accessors is taken from arm_arch_timer.c.

By default MCT will read counter from mmio since it's
guaranteed to work.

Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
---
 drivers/clocksource/exynos_mct.c | 77 ++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 9064ff7..039b41c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -26,6 +26,9 @@
 #include <linux/clocksource.h>
 #include <linux/sched_clock.h>
 
+#include <asm/arch_timer.h>	/* for cp15 physical arch timer counter */
+#include <asm/virt.h>		/* for checking HYP mode */
+
 #define EXYNOS4_MCTREG(x)		(x)
 #define EXYNOS4_MCT_G_CNT_L		EXYNOS4_MCTREG(0x100)
 #define EXYNOS4_MCT_G_CNT_U		EXYNOS4_MCTREG(0x104)
@@ -82,6 +85,17 @@ static unsigned long clk_rate;
 static unsigned int mct_int_type;
 static int mct_irqs[MCT_NR_IRQS];
 
+static u32 notrace __exynos4_read_count_32(void);
+static u64 __exynos4_read_count_64(void);
+
+/*
+ * Default to __exynos4_read_count_{32,64} functions that reads counter from
+ * MCT mmio region and this method is guaranteed
+ * to exist (if MCT was successfully initialized).
+ */
+u32 (*exynos4_read_count_32)(void) = __exynos4_read_count_32;
+u64 (*exynos4_read_count_64)(void) = __exynos4_read_count_64;
+
 struct mct_clock_event_device {
 	struct clock_event_device evt;
 	unsigned long base;
@@ -163,16 +177,16 @@ static void exynos4_mct_frc_start(void)
 }
 
 /**
- * exynos4_read_count_64 - Read all 64-bits of the global counter
+ * __exynos4_read_count_64 - Read all 64-bits of the global counter
  *
- * This will read all 64-bits of the global counter taking care to make sure
- * that the upper and lower half match.  Note that reading the MCT can be quite
- * slow (hundreds of nanoseconds) so you should use the 32-bit (lower half
- * only) version when possible.
+ * This will read all 64-bits of the global counter from MCT mmio region
+ * taking care to make sure that the upper and lower half match.
+ * Note that reading the MCT can be quite slow (hundreds of nanoseconds)
+ * so you should use the 32-bit (lower half only) version when possible.
  *
  * Returns the number of cycles in the global counter.
  */
-static u64 exynos4_read_count_64(void)
+static u64 __exynos4_read_count_64(void)
 {
 	unsigned int lo, hi;
 	u32 hi2 = readl_relaxed(reg_base + EXYNOS4_MCT_G_CNT_U);
@@ -187,18 +201,45 @@ static u64 exynos4_read_count_64(void)
 }
 
 /**
- * exynos4_read_count_32 - Read the lower 32-bits of the global counter
+ * __exynos4_read_cp15_count_64 - Read all 64-bits of the global counter
+ * from coprocessor regisers.
  *
- * This will read just the lower 32-bits of the global counter.  This is marked
- * as notrace so it can be used by the scheduler clock.
+ * Note that reading here is faster than reading from MCT mmio region.
+ *
+ * Returns the number of cycles in the global counter.
+ */
+static u64 __exynos4_read_cp15_count_64(void)
+{
+	return arch_counter_get_cntpct();
+}
+
+/**
+ * __exynos4_read_count_32 - Read the lower 32-bits of the global counter
+ *
+ * This will read just the lower 32-bits of the global counter from
+ * MCT mmio region.
+ * This is marked as notrace so it can be used by the scheduler clock.
  *
  * Returns the number of cycles in the global counter (lower 32 bits).
  */
-static u32 notrace exynos4_read_count_32(void)
+static u32 notrace __exynos4_read_count_32(void)
 {
 	return readl_relaxed(reg_base + EXYNOS4_MCT_G_CNT_L);
 }
 
+/**
+ * __exynos4_read_cp15_count_32 - Read the lower 32-bits of the global counter
+ *
+ * This will read global counter from coprocessor regisers.
+ * This is marked as notrace so it can be used by the scheduler clock.
+ *
+ * Returns the number of cycles in the global counter (lower 32 bits).
+ */
+static u32 notrace __exynos4_read_cp15_count_32(void)
+{
+	return arch_counter_get_cntpct();
+}
+
 static cycle_t exynos4_frc_read(struct clocksource *cs)
 {
 	return exynos4_read_count_32();
@@ -599,6 +640,22 @@ static void __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
+	/*
+	 * If use-cp15-phys-counter property is present in device tree
+	 * then use CP15 ARM arch timer 64-bit physical counter
+	 * to speedup reading since it keeps the same value like
+	 * 64-bit counter in MCT mmio region.
+	 * If HYP mode is available we can rely on physical
+	 * timer counter to be accessible from PL1.
+	 */
+	if (IS_ENABLED(CONFIG_ARM) && is_hyp_mode_available() &&
+		of_property_read_bool(np, "use-cp15-phys-counter")) {
+
+		/* point MCT functions to read counter from coprocessor */
+		exynos4_read_count_32 = __exynos4_read_cp15_count_32;
+		exynos4_read_count_64 = __exynos4_read_cp15_count_64;
+	}
+
 	exynos4_timer_resources(np, of_iomap(np, 0));
 	exynos4_clocksource_init();
 	exynos4_clockevent_init();
-- 
2.1.4
