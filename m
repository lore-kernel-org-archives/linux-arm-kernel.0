From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  5 Aug 2014 14:54:12 +0530
Subject: [RFC PATCH 3/6] ARM: perf: Re-enable overflow interrupt from
 interrupt handler
In-Reply-To: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
References: <1407230655-28864-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1407230655-28864-4-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A hypervisor will typically mask the overflow interrupt before
forwarding it to Guest Linux hence we need to re-enable the overflow
interrupt after clearing it in Guest Linux. Also, this re-enabling
of overflow interrupt does not harm in non-virtualized scenarios.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
---
 arch/arm/kernel/perf_event_v7.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 1d37568..581cca5 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1355,6 +1355,14 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 		if (!armv7_pmnc_counter_has_overflowed(pmnc, idx))
 			continue;
 
+		/*
+		 * If we are running under a hypervisor such as KVM then
+		 * hypervisor will mask the interrupt before forwarding
+		 * it to Guest Linux hence re-enable interrupt for the
+		 * overflowed counter.
+		 */
+		armv7_pmnc_enable_intens(idx);
+
 		hwc = &event->hw;
 		armpmu_event_update(event);
 		perf_sample_data_init(&data, 0, hwc->last_period);
-- 
1.7.9.5
