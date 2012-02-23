From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Feb 2012 15:58:16 +0000
Subject: [PATCH 4/4] ARM: perf: fix overflow handling for xscale2 PMUs
In-Reply-To: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
References: <1330012696-13472-1-git-send-email-will.deacon@arm.com>
Message-ID: <1330012696-13472-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

xscale2 PMUs indicate overflow not via the PMU control register, but by
a separate overflow FLAG register instead.

This patch fixes the xscale2 PMU code to use this register to detect
to overflow and ensures that we clear any pending overflow when
disabling a counter.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_xscale.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event_xscale.c b/arch/arm/kernel/perf_event_xscale.c
index a5bbd36..71a21e6 100644
--- a/arch/arm/kernel/perf_event_xscale.c
+++ b/arch/arm/kernel/perf_event_xscale.c
@@ -598,7 +598,7 @@ xscale2pmu_handle_irq(int irq_num, void *dev)
 		if (!event)
 			continue;
 
-		if (!xscale2_pmnc_counter_has_overflowed(pmnc, idx))
+		if (!xscale2_pmnc_counter_has_overflowed(of_flags, idx))
 			continue;
 
 		hwc = &event->hw;
@@ -669,7 +669,7 @@ xscale2pmu_enable_event(struct hw_perf_event *hwc, int idx)
 static void
 xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 {
-	unsigned long flags, ien, evtsel;
+	unsigned long flags, ien, evtsel, of_flags;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
 
 	ien = xscale2pmu_read_int_enable();
@@ -678,26 +678,31 @@ xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 	switch (idx) {
 	case XSCALE_CYCLE_COUNTER:
 		ien &= ~XSCALE2_CCOUNT_INT_EN;
+		of_flags = XSCALE2_CCOUNT_OVERFLOW;
 		break;
 	case XSCALE_COUNTER0:
 		ien &= ~XSCALE2_COUNT0_INT_EN;
 		evtsel &= ~XSCALE2_COUNT0_EVT_MASK;
 		evtsel |= XSCALE_PERFCTR_UNUSED << XSCALE2_COUNT0_EVT_SHFT;
+		of_flags = XSCALE2_COUNT0_OVERFLOW;
 		break;
 	case XSCALE_COUNTER1:
 		ien &= ~XSCALE2_COUNT1_INT_EN;
 		evtsel &= ~XSCALE2_COUNT1_EVT_MASK;
 		evtsel |= XSCALE_PERFCTR_UNUSED << XSCALE2_COUNT1_EVT_SHFT;
+		of_flags = XSCALE2_COUNT1_OVERFLOW;
 		break;
 	case XSCALE_COUNTER2:
 		ien &= ~XSCALE2_COUNT2_INT_EN;
 		evtsel &= ~XSCALE2_COUNT2_EVT_MASK;
 		evtsel |= XSCALE_PERFCTR_UNUSED << XSCALE2_COUNT2_EVT_SHFT;
+		of_flags = XSCALE2_COUNT2_OVERFLOW;
 		break;
 	case XSCALE_COUNTER3:
 		ien &= ~XSCALE2_COUNT3_INT_EN;
 		evtsel &= ~XSCALE2_COUNT3_EVT_MASK;
 		evtsel |= XSCALE_PERFCTR_UNUSED << XSCALE2_COUNT3_EVT_SHFT;
+		of_flags = XSCALE2_COUNT3_OVERFLOW;
 		break;
 	default:
 		WARN_ONCE(1, "invalid counter number (%d)\n", idx);
@@ -707,6 +712,7 @@ xscale2pmu_disable_event(struct hw_perf_event *hwc, int idx)
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
 	xscale2pmu_write_event_select(evtsel);
 	xscale2pmu_write_int_enable(ien);
+	xscale2pmu_write_overflow_flags(of_flags);
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
 
-- 
1.7.4.1
