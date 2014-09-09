From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 09 Sep 2014 10:54:45 -0700
Subject: [PATCH] ARM: perf: Don't sleep while atomic when enabling per-cpu
 interrupts
In-Reply-To: <20140909113943.GG1754@arm.com>
References: <1410200814-25878-1-git-send-email-sboyd@codeaurora.org>
 <20140909113943.GG1754@arm.com>
Message-ID: <540F3EE5.90500@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/14 04:39, Will Deacon wrote:
> It's interesting that arm64 isn't affected by this problem, since we don't
> update the active_irqs mask for PPIs there and consequently just pass the
> irq instead of the cpu_pmu. I can't see why we actually need to update the
> active_irqs mask for arch/arm/, so could we remove that and follow arm64's
> lead instead? That would remove the need for a new struct definition too.
>

I guess you're saying that we don't need the active_irqs mask in the
percpu irq case? It looks like we still use it to determine when the
last CPU PMU has been disabled in the non-percpu case.

Here's the interdiff. Is there a reason arm64 casts data to an unsigned
int pointer when what's passed is an int pointer?

----8<-----

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 1f24b47cd81e..4bf4cce759fe 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -74,28 +74,17 @@ static struct pmu_hw_events *cpu_pmu_get_cpu_events(void)
 	return this_cpu_ptr(&cpu_hw_events);
 }
 
-struct pmu_enable {
-	struct arm_pmu *pmu;
-	int irq;
-};
-
 static void cpu_pmu_enable_percpu_irq(void *data)
 {
-	struct pmu_enable *pmu_enable = data;
-	struct arm_pmu *cpu_pmu = pmu_enable->pmu;
-	int irq = pmu_enable->irq;
+	int irq = *(int *)data;
 
 	enable_percpu_irq(irq, IRQ_TYPE_NONE);
-	cpumask_set_cpu(smp_processor_id(), &cpu_pmu->active_irqs);
 }
 
 static void cpu_pmu_disable_percpu_irq(void *data)
 {
-	struct pmu_enable *pmu_enable = data;
-	struct arm_pmu *cpu_pmu = pmu_enable->pmu;
-	int irq = pmu_enable->irq;
+	int irq = *(int *)data;
 
-	cpumask_clear_cpu(smp_processor_id(), &cpu_pmu->active_irqs);
 	disable_percpu_irq(irq);
 }
 
@@ -103,15 +92,12 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 {
 	int i, irq, irqs;
 	struct platform_device *pmu_device = cpu_pmu->plat_device;
-	struct pmu_enable pmu_enable;
 
 	irqs = min(pmu_device->num_resources, num_possible_cpus());
 
 	irq = platform_get_irq(pmu_device, 0);
 	if (irq >= 0 && irq_is_percpu(irq)) {
-		pmu_enable.pmu = cpu_pmu;
-		pmu_enable.irq = irq;
-		on_each_cpu(cpu_pmu_disable_percpu_irq, &pmu_enable, 1);
+		on_each_cpu(cpu_pmu_disable_percpu_irq, &irq, 1);
 		free_percpu_irq(irq, &percpu_pmu);
 	} else {
 		for (i = 0; i < irqs; ++i) {
@@ -128,7 +114,6 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 {
 	int i, err, irq, irqs;
 	struct platform_device *pmu_device = cpu_pmu->plat_device;
-	struct pmu_enable pmu_enable;
 
 	if (!pmu_device)
 		return -ENODEV;
@@ -147,9 +132,7 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 				irq);
 			return err;
 		}
-		pmu_enable.pmu = cpu_pmu;
-		pmu_enable.irq = irq;
-		on_each_cpu(cpu_pmu_enable_percpu_irq, &pmu_enable, 1);
+		on_each_cpu(cpu_pmu_enable_percpu_irq, &irq, 1);
 	} else {
 		for (i = 0; i < irqs; ++i) {
 			err = 0;


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
