From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 21 Dec 2015 10:55:29 +0000
Subject: [PATCH v4 05/12] arm-cci: PMU: Add support for transactions
In-Reply-To: <20151218114751.GP6344@twins.programming.kicks-ass.net>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
 <1450374559-23315-6-git-send-email-suzuki.poulose@arm.com>
 <20151217184255.GI6344@twins.programming.kicks-ass.net>
 <5673DFC7.6060406@arm.com>
 <20151218104234.GN6344@twins.programming.kicks-ass.net>
 <5673E6C9.7040304@arm.com>
 <20151218114751.GP6344@twins.programming.kicks-ass.net>
Message-ID: <20151221105528.GA19617@e106634-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 12:47:51PM +0100, Peter Zijlstra wrote:
> On Fri, Dec 18, 2015 at 10:58:17AM +0000, Suzuki K. Poulose wrote:
>
> > We have a global Enable/Disable for CCI PMU and thats what we use
> > currently. To be able to reprogram the counters with the event period
> > (we program the counter with a specific count in pmu::start() and at
> > overflow irq handler, not to be confused with the sampling period, which
> > is not supported), we need to be sure that the counter value has been updated.
> >
> > May be we could check the event->hw->state to see if we need to reprogram it.
>
> Right, have a look at arch/x86/kernel/cpu/perf_event.c:x86_pmu_enable()
>

Thanks for that hint. Here is what I cam up with. We don't reschedule
the events, all we need to do is group the writes to the counters. Hence
we could as well add a flag for those events which need programming
and perform the write in pmu::pmu_enable().


----8>-----


arm-cci PMU: Delay counter writes to pmu_enable

Delay setting the event periods for enabled events to pmu::pmu_enable().
We mark the event.hw->state PERF_HES_ARCH for the events that we know
have their counts recorded and have been started. Since we reprogram the
counters every time before count, we can set the counters for all the
event counters which are !STOPPED && ARCH.

Grouping the writes to counters can ammortise the cost of the operation
on PMUs where it is expensive (e.g, CCI-500).


Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: peterz at infradead.org
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 0189f3a..c768ee4 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -916,6 +916,40 @@ static void hw_perf_event_destroy(struct perf_event *event)
        }
 }

+/*
+ * Program the CCI PMU counters which have PERF_HES_ARCH set
+ * with the event period and mark them ready before we enable
+ * PMU.
+ */
+void cci_pmu_update_counters(struct cci_pmu *cci_pmu)
+{
+       int i;
+       unsigned long mask[BITS_TO_LONGS(cci_pmu->num_cntrs)];
+
+       memset(mask, 0, BITS_TO_LONGS(cci_pmu->num_cntrs) * sizeof(unsigned long));
+
+       for_each_set_bit(i, cci_pmu->hw_events.used_mask, cci_pmu->num_cntrs) {
+               struct hw_perf_event *hwe;
+
+               if (!cci_pmu->hw_events.events[i]) {
+                       WARN_ON(1);
+                       continue;
+               }
+
+               hwe = &cci_pmu->hw_events.events[i]->hw;
+               /* Leave the events which are not counting */
+               if (hwe->state & PERF_HES_STOPPED)
+                       continue;
+               if (hwe->state & PERF_HES_ARCH) {
+                       set_bit(i, mask);
+                       hwe->state &= ~PERF_HES_ARCH;
+                       local64_set(&hwe->prev_count, CCI_CNTR_PERIOD);
+               }
+       }
+
+       pmu_write_counters(cci_pmu, mask, CCI_CNTR_PERIOD);
+}
+
 static void cci_pmu_enable(struct pmu *pmu)
 {
        struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
@@ -927,6 +961,7 @@ static void cci_pmu_enable(struct pmu *pmu)
                return;

        raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
+       cci_pmu_update_counters(cci_pmu);
        __cci_pmu_enable();
        raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);

@@ -980,8 +1015,11 @@ static void cci_pmu_start(struct perf_event *event, int pmu_flags)
        /* Configure the counter unless you are counting a fixed event */
        if (!pmu_fixed_hw_idx(cci_pmu, idx))
                pmu_set_event(cci_pmu, idx, hwc->config_base);
-
-       pmu_event_set_period(event);
+       /*
+        * Mark this counter, so that we can program the
+        * counter with the event_period. see cci_pmu_enable()
+        */
+       hwc->state = PERF_HES_ARCH;
        pmu_enable_counter(cci_pmu, idx);

        raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
--
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
