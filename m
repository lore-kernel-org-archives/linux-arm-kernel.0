From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Aug 2010 11:25:31 +0100
Subject: [PATCH] ARM: perf: reword comments relating to perf_event_do_pending
Message-ID: <1281954331-5633-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is purely a cosmetic change to the ARM perf backend because the current
comments about the relationship between NMIs, interrupt context and
perf_event_do_pending are misleading.

This patch updates the comments so that they reflect what the code
actually does (which is in line with other architectures).

Cc: Jamie Iles <jamie.iles@picochip.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h |    2 +-
 arch/arm/kernel/perf_event.c      |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index 48837e6..b5799a3 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -17,7 +17,7 @@
  * counter interrupts are regular interrupts and not an NMI. This
  * means that when we receive the interrupt we can call
  * perf_event_do_pending() that handles all of the work with
- * interrupts enabled.
+ * interrupts disabled.
  */
 static inline void
 set_perf_event_pending(void)
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index de12536..b93a8db 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -1041,8 +1041,8 @@ armv6pmu_handle_irq(int irq_num,
 	/*
 	 * Handle the pending perf events.
 	 *
-	 * Note: this call *must* be run with interrupts enabled. For
-	 * platforms that can have the PMU interrupts raised as a PMI, this
+	 * Note: this call *must* be run with interrupts disabled. For
+	 * platforms that can have the PMU interrupts raised as an NMI, this
 	 * will not work.
 	 */
 	perf_event_do_pending();
@@ -2017,8 +2017,8 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	/*
 	 * Handle the pending perf events.
 	 *
-	 * Note: this call *must* be run with interrupts enabled. For
-	 * platforms that can have the PMU interrupts raised as a PMI, this
+	 * Note: this call *must* be run with interrupts disabled. For
+	 * platforms that can have the PMU interrupts raised as an NMI, this
 	 * will not work.
 	 */
 	perf_event_do_pending();
-- 
1.6.3.3
