From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Feb 2018 16:42:00 +0000
Subject: [PATCHv2 6/8] arm_pmu: explicitly enable/disable SPIs at hotplug
In-Reply-To: <20180205164202.26502-1-mark.rutland@arm.com>
References: <20180205164202.26502-1-mark.rutland@arm.com>
Message-ID: <20180205164202.26502-7-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support ACPI systems, we need to request IRQs before CPUs are
hotplugged, and thus we need to request IRQs before we know their
associated PMU.

This is problematic if a PMU IRQ is pending out of reset, as it may be
taken before we know the PMU, and thus the IRQ handler won't be able to
handle it, leaving it screaming.

To avoid such problems, lets request all IRQs in a disabled state, and
explicitly enable/disable them at hotplug time, when we're sure the PMU
has been probed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index ddcabd6a5d52..72118e6f9122 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -558,6 +558,7 @@ int armpmu_request_irq(struct arm_pmu *armpmu, int cpu)
 			    IRQF_NOBALANCING |
 			    IRQF_NO_THREAD;
 
+		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		err = request_irq(irq, handler, irq_flags, "arm-pmu",
 				  per_cpu_ptr(&hw_events->percpu_pmu, cpu));
 	} else if (cpumask_empty(&armpmu->active_irqs)) {
@@ -600,10 +601,10 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 
 	irq = armpmu_get_cpu_irq(pmu, cpu);
 	if (irq) {
-		if (irq_is_percpu_devid(irq)) {
+		if (irq_is_percpu_devid(irq))
 			enable_percpu_irq(irq, IRQ_TYPE_NONE);
-			return 0;
-		}
+		else
+			enable_irq(irq);
 	}
 
 	return 0;
@@ -618,8 +619,12 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
 		return 0;
 
 	irq = armpmu_get_cpu_irq(pmu, cpu);
-	if (irq && irq_is_percpu_devid(irq))
-		disable_percpu_irq(irq);
+	if (irq) {
+		if (irq_is_percpu_devid(irq))
+			disable_percpu_irq(irq);
+		else
+			disable_irq(irq);
+	}
 
 	return 0;
 }
-- 
2.11.0
