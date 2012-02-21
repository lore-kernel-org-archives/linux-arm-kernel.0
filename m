From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Feb 2012 17:36:27 +0000
Subject: [PATCH] ARM: perf: do not handle deleted counter in irq handler
 to avoid oops
In-Reply-To: <20120221155707.GD23133@mudshark.cambridge.arm.com>
References: <1329799058-27082-1-git-send-email-tom.leiming@gmail.com>
 <20120221133228.GK19696@mudshark.cambridge.arm.com>
 <CACVXFVMxpRDsG_hNn_WaX17uEdZCJmcraOvDwCL6JQ7Xyz5nig@mail.gmail.com>
 <20120221151909.GA23133@mudshark.cambridge.arm.com>
 <CACVXFVOR7oF1nq9p55+3b2at2Appa_YyFEWhD=dF8jGfy0H+OQ@mail.gmail.com>
 <20120221154007.GB23133@mudshark.cambridge.arm.com>
 <CACVXFVNrWgeEKjZyrEgugGrKkLz030aeMwwNWd_jwdMA5-=N=Q@mail.gmail.com>
 <20120221155707.GD23133@mudshark.cambridge.arm.com>
Message-ID: <20120221173626.GK23133@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 03:57:07PM +0000, Will Deacon wrote:
> On Tue, Feb 21, 2012 at 03:49:22PM +0000, Ming Lei wrote:
> > 
> > Sorry for missing it, but looks xscale uses standalone overflow
> > register and does not
> > clear its overflow flag.
> 
> Hmmm, I don't know very much about the xscale PMUs (the perf code is based
> on the old OProfile code). The xscale2 overflow handler is certainly doing
> something with some overflow flags though, but then it checks the pmnc again
> for each counter...

Bah, I got curious and took the plunge into the excitingly titled `Intel
XScale Core Developer's Manual'. It looks like the interrupt handler
currently has a bug, so this should sort it out (I'll try and test it on my
xscale board, but that has > 200 days of uptime so I'm reluctant to reboot
it).

Will

>From b3dc51a39347c000745939000faa1d7d50514fa2 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Tue, 21 Feb 2012 17:14:34 +0000
Subject: [PATCH] ARM: perf: fix overflow handling for xscale2 PMUs

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
