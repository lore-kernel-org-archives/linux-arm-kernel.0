From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Nov 2010 17:17:23 +0000
Subject: [PATCH] ARM: perf: use raw_spinlock_t for pmu_lock
Message-ID: <1291137443-13821-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For kernels built with PREEMPT_RT, critical sections protected
by standard spinlocks are preemptible. This is not acceptable
on perf as (a) we may be scheduled onto a different CPU whilst
reading/writing banked PMU registers and (b) the latency when
reading the PMU registers becomes unpredictable.

This patch upgrades the pmu_lock spinlock to a raw_spinlock
instead.

Reported-by: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c        |    2 +-
 arch/arm/kernel/perf_event_v6.c     |   20 ++++++++++----------
 arch/arm/kernel/perf_event_v7.c     |   16 ++++++++--------
 arch/arm/kernel/perf_event_xscale.c |   32 ++++++++++++++++----------------
 4 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 50c197b..624e2a5 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -32,7 +32,7 @@ static struct platform_device *pmu_device;
  * Hardware lock to serialize accesses to PMU registers. Needed for the
  * read/modify/write sequences.
  */
-static DEFINE_SPINLOCK(pmu_lock);
+static DEFINE_RAW_SPINLOCK(pmu_lock);
 
 /*
  * ARMv6 supports a maximum of 3 events, starting from index 1. If we add
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index 3f427aa..c058bfc 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -426,12 +426,12 @@ armv6pmu_enable_event(struct hw_perf_event *hwc,
 	 * Mask out the current event and set the counter to count the event
 	 * that we're interested in.
 	 */
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static irqreturn_t
@@ -500,11 +500,11 @@ armv6pmu_start(void)
 {
 	unsigned long flags, val;
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val |= ARMV6_PMCR_ENABLE;
 	armv6_pmcr_write(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static void
@@ -512,11 +512,11 @@ armv6pmu_stop(void)
 {
 	unsigned long flags, val;
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~ARMV6_PMCR_ENABLE;
 	armv6_pmcr_write(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static int
@@ -570,12 +570,12 @@ armv6pmu_disable_event(struct hw_perf_event *hwc,
 	 * of ETM bus signal assertion cycles. The external reporting should
 	 * be disabled and so this should never increment.
 	 */
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static void
@@ -599,12 +599,12 @@ armv6mpcore_pmu_disable_event(struct hw_perf_event *hwc,
 	 * Unlike UP ARMv6, we don't have a way of stopping the counters. We
 	 * simply disable the interrupt reporting.
 	 */
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = armv6_pmcr_read();
 	val &= ~mask;
 	val |= evt;
 	armv6_pmcr_write(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static const struct arm_pmu armv6pmu = {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index a68ff1c..2e14025 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -689,7 +689,7 @@ static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 	 * Enable counter and interrupt, and set the counter to count
 	 * the event that we're interested in.
 	 */
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -713,7 +713,7 @@ static void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
 	 */
 	armv7_pmnc_enable_counter(idx);
 
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
@@ -723,7 +723,7 @@ static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
 	/*
 	 * Disable counter and interrupt
 	 */
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 
 	/*
 	 * Disable counter
@@ -735,7 +735,7 @@ static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
 	 */
 	armv7_pmnc_disable_intens(idx);
 
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
@@ -805,20 +805,20 @@ static void armv7pmu_start(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	/* Enable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static void armv7pmu_stop(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	/* Disable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() & ~ARMV7_PMNC_E);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index f14fbb6..28cd3b0 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -291,12 +291,12 @@ xscale1pmu_enable_event(struct hw_perf_event *hwc, int idx)
 		return;
 	}
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~mask;
 	val |= evt;
 	xscale1pmu_write_pmnc(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static void
@@ -322,12 +322,12 @@ xscale1pmu_disable_event(struct hw_perf_event *hwc, int idx)
 		return;
 	}
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~mask;
 	val |= evt;
 	xscale1pmu_write_pmnc(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static int
@@ -355,11 +355,11 @@ xscale1pmu_start(void)
 {
 	unsigned long flags, val;
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val |= XSCALE_PMU_ENABLE;
 	xscale1pmu_write_pmnc(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static void
@@ -367,11 +367,11 @@ xscale1pmu_stop(void)
 {
 	unsigned long flags, val;
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = xscale1pmu_read_pmnc();
 	val &= ~XSCALE_PMU_ENABLE;
 	xscale1pmu_write_pmnc(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static inline u32
@@ -635,10 +635,10 @@ xscale2pmu_enable_event(struct hw_perf_event *hwc, int idx)
 		return;
 	}
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static void
@@ -678,10 +678,10 @@ xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 		return;
 	}
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static int
@@ -705,11 +705,11 @@ xscale2pmu_start(void)
 {
 	unsigned long flags, val;
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = xscale2pmu_read_pmnc() & ~XSCALE_PMU_CNT64;
 	val |= XSCALE_PMU_ENABLE;
 	xscale2pmu_write_pmnc(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static void
@@ -717,11 +717,11 @@ xscale2pmu_stop(void)
 {
 	unsigned long flags, val;
 
-	spin_lock_irqsave(&pmu_lock, flags);
+	raw_spin_lock_irqsave(&pmu_lock, flags);
 	val = xscale2pmu_read_pmnc();
 	val &= ~XSCALE_PMU_ENABLE;
 	xscale2pmu_write_pmnc(val);
-	spin_unlock_irqrestore(&pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&pmu_lock, flags);
 }
 
 static inline u32
-- 
1.7.0.4
