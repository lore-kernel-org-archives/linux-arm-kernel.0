From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:04 +0100
Subject: [PATCH 03/10] ARM: perf: use cpumask_t to record active IRQs
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 5dfc54e0 ("ARM: GIC: avoid routing interrupts to offline CPUs")
prevents the GIC from setting the affinity of an IRQ to a CPU with
id >= nr_cpu_ids. This was previously abused by perf on some platforms
where more IRQs were registered than possible CPUs.

This patch fixes the problem by using a cpumask_t to keep track of the
active (requested) interrupts in perf. The same effect could be achieved
by limiting the number of IRQs to the number of CPUs, but using a mask
instead will be useful for adding extended CPU hotplug support in the
future.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c |   64 ++++++++++++++++++++---------------------
 1 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 8514855..d507fe1 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -69,6 +69,7 @@ static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
 
 struct arm_pmu {
 	enum arm_perf_pmu_ids id;
+	cpumask_t	active_irqs;
 	const char	*name;
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 	void		(*enable)(struct hw_perf_event *evt, int idx);
@@ -388,6 +389,25 @@ static irqreturn_t armpmu_platform_irq(int irq, void *dev)
 	return plat->handle_irq(irq, dev, armpmu->handle_irq);
 }
 
+static void
+armpmu_release_hardware(void)
+{
+	int i, irq, irqs;
+
+	irqs = min(pmu_device->num_resources, num_possible_cpus());
+
+	for (i = 0; i < irqs; ++i) {
+		if (!cpumask_test_and_clear_cpu(i, &armpmu->active_irqs))
+			continue;
+		irq = platform_get_irq(pmu_device, i);
+		if (irq >= 0)
+			free_irq(irq, NULL);
+	}
+
+	armpmu->stop();
+	release_pmu(ARM_PMU_DEVICE_CPU);
+}
+
 static int
 armpmu_reserve_hardware(void)
 {
@@ -401,20 +421,20 @@ armpmu_reserve_hardware(void)
 		return err;
 	}
 
-	irqs = pmu_device->num_resources;
-
 	plat = dev_get_platdata(&pmu_device->dev);
 	if (plat && plat->handle_irq)
 		handle_irq = armpmu_platform_irq;
 	else
 		handle_irq = armpmu->handle_irq;
 
+	irqs = min(pmu_device->num_resources, num_possible_cpus());
 	if (irqs < 1) {
 		pr_err("no irqs for PMUs defined\n");
 		return -ENODEV;
 	}
 
 	for (i = 0; i < irqs; ++i) {
+		err = 0;
 		irq = platform_get_irq(pmu_device, i);
 		if (irq < 0)
 			continue;
@@ -422,13 +442,12 @@ armpmu_reserve_hardware(void)
 		/*
 		 * If we have a single PMU interrupt that we can't shift,
 		 * assume that we're running on a uniprocessor machine and
-		 * continue.
+		 * continue. Otherwise, continue without this interrupt.
 		 */
-		err = irq_set_affinity(irq, cpumask_of(i));
-		if (err && irqs > 1) {
-			pr_err("unable to set irq affinity (irq=%d, cpu=%u)\n",
-				irq, i);
-			break;
+		if (irq_set_affinity(irq, cpumask_of(i)) && irqs > 1) {
+			pr_warning("unable to set irq affinity (irq=%d, cpu=%u)\n",
+				    irq, i);
+			continue;
 		}
 
 		err = request_irq(irq, handle_irq,
@@ -437,35 +456,14 @@ armpmu_reserve_hardware(void)
 		if (err) {
 			pr_err("unable to request IRQ%d for ARM PMU counters\n",
 				irq);
-			break;
+			armpmu_release_hardware();
+			return err;
 		}
-	}
 
-	if (err) {
-		for (i = i - 1; i >= 0; --i) {
-			irq = platform_get_irq(pmu_device, i);
-			if (irq >= 0)
-				free_irq(irq, NULL);
-		}
-		release_pmu(ARM_PMU_DEVICE_CPU);
+		cpumask_set_cpu(i, &armpmu->active_irqs);
 	}
 
-	return err;
-}
-
-static void
-armpmu_release_hardware(void)
-{
-	int i, irq;
-
-	for (i = pmu_device->num_resources - 1; i >= 0; --i) {
-		irq = platform_get_irq(pmu_device, i);
-		if (irq >= 0)
-			free_irq(irq, NULL);
-	}
-	armpmu->stop();
-
-	release_pmu(ARM_PMU_DEVICE_CPU);
+	return 0;
 }
 
 static atomic_t active_events = ATOMIC_INIT(0);
-- 
1.7.0.4
