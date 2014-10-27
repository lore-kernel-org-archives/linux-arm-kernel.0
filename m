From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Oct 2014 12:06:37 +0000
Subject: [PATCHv2 7/9] arm: perf: fold percpu_pmu into pmu_hw_events
In-Reply-To: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
References: <1414411599-1938-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1414411599-1938-8-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the percpu_pmu pointers used as percpu_irq dev_id values are
defined separately from the other per-cpu accounting data, which make
dynamically allocating the data (as will be required for systems with
heterogeneous CPUs) difficult.

This patch moves the percpu_pmu pointers into pmu_hw_events (which is
itself allocated per cpu), which will allow for easier dynamic
allocation. Both percpu and regular irqs are requested using percpu_pmu
pointers as tokens, freeing us from having to know whether an irq is
percpu within the handler, and thus avoiding a radix tree lookup on the
handler path.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/include/asm/pmu.h       |  6 ++++++
 arch/arm/kernel/perf_event.c     | 14 +++++++++-----
 arch/arm/kernel/perf_event_cpu.c | 14 ++++++++------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index f273dd2..cc01498 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -81,6 +81,12 @@ struct pmu_hw_events {
 	 * read/modify/write sequences.
 	 */
 	raw_spinlock_t		pmu_lock;
+
+	/*
+	 * When using percpu IRQs, we need a percpu dev_id. Place it here as we
+	 * already have to allocate this struct per cpu.
+	 */
+	struct arm_pmu		*percpu_pmu;
 };
 
 struct arm_pmu {
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 05ac5ee..e34934f 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -304,17 +304,21 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 	int ret;
 	u64 start_clock, finish_clock;
 
-	if (irq_is_percpu(irq))
-		dev = *(void **)dev;
-	armpmu = dev;
+	/*
+	 * we request the IRQ with a (possibly percpu) struct arm_pmu**, but
+	 * the handlers expect a struct arm_pmu*. The percpu_irq framework will
+	 * do any necessary shifting, we just need to perform the first
+	 * dereference.
+	 */
+	armpmu = *(void **)dev;
 	plat_device = armpmu->plat_device;
 	plat = dev_get_platdata(&plat_device->dev);
 
 	start_clock = sched_clock();
 	if (plat && plat->handle_irq)
-		ret = plat->handle_irq(irq, dev, armpmu->handle_irq);
+		ret = plat->handle_irq(irq, armpmu, armpmu->handle_irq);
 	else
-		ret = armpmu->handle_irq(irq, dev);
+		ret = armpmu->handle_irq(irq, armpmu);
 	finish_clock = sched_clock();
 
 	perf_sample_event_took(finish_clock - start_clock);
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index d3fa1cc..5eecfe9 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -35,7 +35,6 @@
 /* Set at runtime when we know what CPU type we are. */
 static struct arm_pmu *cpu_pmu;
 
-static DEFINE_PER_CPU(struct arm_pmu *, percpu_pmu);
 static DEFINE_PER_CPU(struct pmu_hw_events, cpu_hw_events);
 
 /*
@@ -85,20 +84,21 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 {
 	int i, irq, irqs;
 	struct platform_device *pmu_device = cpu_pmu->plat_device;
+	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
 
 	irqs = min(pmu_device->num_resources, num_possible_cpus());
 
 	irq = platform_get_irq(pmu_device, 0);
 	if (irq >= 0 && irq_is_percpu(irq)) {
 		on_each_cpu(cpu_pmu_disable_percpu_irq, &irq, 1);
-		free_percpu_irq(irq, &percpu_pmu);
+		free_percpu_irq(irq, &hw_events->percpu_pmu);
 	} else {
 		for (i = 0; i < irqs; ++i) {
 			if (!cpumask_test_and_clear_cpu(i, &cpu_pmu->active_irqs))
 				continue;
 			irq = platform_get_irq(pmu_device, i);
 			if (irq >= 0)
-				free_irq(irq, cpu_pmu);
+				free_irq(irq, per_cpu_ptr(&hw_events->percpu_pmu, i));
 		}
 	}
 }
@@ -107,6 +107,7 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 {
 	int i, err, irq, irqs;
 	struct platform_device *pmu_device = cpu_pmu->plat_device;
+	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
 
 	if (!pmu_device)
 		return -ENODEV;
@@ -119,7 +120,8 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 
 	irq = platform_get_irq(pmu_device, 0);
 	if (irq >= 0 && irq_is_percpu(irq)) {
-		err = request_percpu_irq(irq, handler, "arm-pmu", &percpu_pmu);
+		err = request_percpu_irq(irq, handler, "arm-pmu",
+					 &hw_events->percpu_pmu);
 		if (err) {
 			pr_err("unable to request IRQ%d for ARM PMU counters\n",
 				irq);
@@ -146,7 +148,7 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 
 			err = request_irq(irq, handler,
 					  IRQF_NOBALANCING | IRQF_NO_THREAD, "arm-pmu",
-					  cpu_pmu);
+					  per_cpu_ptr(&hw_events->percpu_pmu, i));
 			if (err) {
 				pr_err("unable to request IRQ%d for ARM PMU counters\n",
 					irq);
@@ -166,7 +168,7 @@ static void cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	for_each_possible_cpu(cpu) {
 		struct pmu_hw_events *events = &per_cpu(cpu_hw_events, cpu);
 		raw_spin_lock_init(&events->pmu_lock);
-		per_cpu(percpu_pmu, cpu) = cpu_pmu;
+		events->percpu_pmu = cpu_pmu;
 	}
 
 	cpu_pmu->hw_events	= &cpu_hw_events;
-- 
1.9.1
