From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  5 Aug 2014 14:54:11 +0530
Subject: [RFC PATCH 2/6] ARM64: perf: Re-enable overflow interrupt from
 interrupt handler
In-Reply-To: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1407230655-28864-3-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A hypervisor will typically mask the overflow interrupt before
forwarding it to Guest Linux hence we need to re-enable the overflow
interrupt after clearing it in Guest Linux. Also, this re-enabling
of overflow interrupt does not harm in non-virtualized scenarios.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
---
 arch/arm64/kernel/perf_event.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 47dfb8b..19fb140 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1076,6 +1076,14 @@ static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
 		if (!armv8pmu_counter_has_overflowed(pmovsr, idx))
 			continue;
 
+		/*
+		 * If we are running under a hypervisor such as KVM then
+		 * hypervisor will mask the interrupt before forwarding
+		 * it to Guest Linux hence re-enable interrupt for the
+		 * overflowed counter.
+		 */
+		armv8pmu_enable_intens(idx);
+
 		hwc = &event->hw;
 		armpmu_event_update(event, hwc, idx);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-- 
1.7.9.5
