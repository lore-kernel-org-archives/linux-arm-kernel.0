From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:51 +0100
Subject: [PATCH 15/15] ARM: perf: handle muxed CPU IRQ lines
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When registering a PMU device, a platform can either use the generic
IRQ handler, or supplement it with one of its own. One of the reasons
a platform might choose to do this is to handle the case of muxed IRQ
lines. If this is the case and the IRQ is handled on the wrong CPU,
this patch sets affinity with the next successive online CPU.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/kernel/perf_event_v7.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index d3c5360..04a8867 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1069,8 +1069,18 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	/*
 	 * Did an overflow occur?
 	 */
-	if (!armv7_pmnc_has_overflowed(pmnc))
+	if (armv7_pmnc_has_overflowed(pmnc)) {
+		unsigned int next_cpu;
+
+		next_cpu = cpumask_next(smp_processor_id(), cpu_online_mask);
+
+		if (next_cpu >= nr_cpumask_bits)
+			next_cpu = cpumask_first(cpu_online_mask);
+
+		irq_set_affinity(irq_num, cpumask_of(next_cpu));
+
 		return IRQ_NONE;
+	}
 
 	/*
 	 * Handle the counter(s) overflow(s)
-- 
1.7.9.5
