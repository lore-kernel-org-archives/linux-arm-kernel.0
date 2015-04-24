From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 24 Apr 2015 16:43:20 -0500
Subject: [PATCH 1/2] clocksource: arm_arch_timer: add arch_timer_okay_for_vdso
Message-ID: <1429911801-6069-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32-bit ARM VDSO needs to know whether a generic timer is present
and whether it is suitable for use by user space.  The VDSO
initialization code currently duplicates some of the logic from the
driver to make this determination, but unfortunately it is incomplete;
it will incorrectly enable the VDSO if HYP mode is available or if no
interrupt is provided for the virtual timer (see arch_timer_init).  In
these cases the driver will switch to memory-backed access while the
VDSO will attempt to access the counter using cp15 reads.

Add an arch_timer_okay_for_vdso API which can reliably inform the VDSO
init code whether the arch timer is present and usable.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 drivers/clocksource/arm_arch_timer.c | 12 ++++++++++++
 include/clocksource/arm_arch_timer.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 0aa135ddbf80..b75215523d2f 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -462,6 +462,18 @@ struct timecounter *arch_timer_get_timecounter(void)
 	return &timecounter;
 }
 
+/* The ARM VDSO init code needs to know:
+ * - whether a cp15-based arch timer is present; and if so
+ * - whether the physical or virtual counter is being used.
+ */
+bool arch_timer_okay_for_vdso(void)
+{
+	if (!(arch_timers_present & ARCH_CP15_TIMER))
+		return false;
+
+	return arch_timer_use_virtual;
+}
+
 static void __init arch_counter_register(unsigned type)
 {
 	u64 start_count;
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 9916d0e4eff5..bfc1e95280c4 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -48,6 +48,7 @@ enum arch_timer_reg {
 extern u32 arch_timer_get_rate(void);
 extern u64 (*arch_timer_read_counter)(void);
 extern struct timecounter *arch_timer_get_timecounter(void);
+extern bool arch_timer_okay_for_vdso(void);
 
 #else
 
@@ -66,6 +67,11 @@ static inline struct timecounter *arch_timer_get_timecounter(void)
 	return NULL;
 }
 
+static inline bool arch_timer_okay_for_vdso(void)
+{
+	return false;
+}
+
 #endif
 
 #endif
-- 
1.9.3
