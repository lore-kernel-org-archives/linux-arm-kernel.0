From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 10 Mar 2017 10:46:15 +0000
Subject: [PATCHv4 3/3] drivers/perf: arm_pmu: split irq request from enable
In-Reply-To: <1489142775-11290-1-git-send-email-mark.rutland@arm.com>
References: <1489142775-11290-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489142775-11290-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historical reasons, we lazily request and free interrupts in the
arm pmu driver. This requires us to refcount use of the pmu (by way of
counting the active events) in order to request/free interrupts at the
correct times, which complicates the driver somewhat.

The existing logic is flawed, as it only considers currently online CPUs
when requesting, freeing, or managing the affinity of interrupts.
Intervening hotplug events can result in erroneous IRQ affinity, online
CPUs for which interrupts have not been requested, or offline CPUs whose
interrupts are still requested.

To fix this, this patch splits the requesting of interrupts from any
per-cpu management (i.e. per-cpu enable/disable, and configuration of
cpu affinity). We now request all interrupts up-front at probe time (and
never free them, since we never unregister PMUs).

The management of affinity, and per-cpu enable/disable now happens in
our cpu hotplug callback, ensuring it occurs consistently. This means
that we must now invoke the CPU hotplug callback at boot time in order
to configure IRQs, and since the callback also resets the PMU hardware,
we can remove the duplicate reset in the probe path.

This rework renders our event refcounting unnecessary, so this is
removed.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/perf/arm_pmu.c       | 153 ++++++++++++++-----------------------------
 include/linux/perf/arm_pmu.h |   4 --
 2 files changed, 50 insertions(+), 107 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 68d9f08..8b0aaa9 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -352,37 +352,6 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 	return ret;
 }
 
-static void
-armpmu_release_hardware(struct arm_pmu *armpmu)
-{
-	armpmu->free_irq(armpmu);
-}
-
-static int
-armpmu_reserve_hardware(struct arm_pmu *armpmu)
-{
-	int err = armpmu->request_irq(armpmu, armpmu_dispatch_irq);
-	if (err) {
-		armpmu_release_hardware(armpmu);
-		return err;
-	}
-
-	return 0;
-}
-
-static void
-hw_perf_event_destroy(struct perf_event *event)
-{
-	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	atomic_t *active_events	 = &armpmu->active_events;
-	struct mutex *pmu_reserve_mutex = &armpmu->reserve_mutex;
-
-	if (atomic_dec_and_mutex_lock(active_events, pmu_reserve_mutex)) {
-		armpmu_release_hardware(armpmu);
-		mutex_unlock(pmu_reserve_mutex);
-	}
-}
-
 static int
 event_requires_mode_exclusion(struct perf_event_attr *attr)
 {
@@ -455,8 +424,6 @@ static irqreturn_t armpmu_dispatch_irq(int irq, void *dev)
 static int armpmu_event_init(struct perf_event *event)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
-	int err = 0;
-	atomic_t *active_events = &armpmu->active_events;
 
 	/*
 	 * Reject CPU-affine events for CPUs that are of a different class to
@@ -476,26 +443,7 @@ static int armpmu_event_init(struct perf_event *event)
 	if (armpmu->map_event(event) == -ENOENT)
 		return -ENOENT;
 
-	event->destroy = hw_perf_event_destroy;
-
-	if (!atomic_inc_not_zero(active_events)) {
-		mutex_lock(&armpmu->reserve_mutex);
-		if (atomic_read(active_events) == 0)
-			err = armpmu_reserve_hardware(armpmu);
-
-		if (!err)
-			atomic_inc(active_events);
-		mutex_unlock(&armpmu->reserve_mutex);
-	}
-
-	if (err)
-		return err;
-
-	err = __hw_perf_event_init(event);
-	if (err)
-		hw_perf_event_destroy(event);
-
-	return err;
+	return __hw_perf_event_init(event);
 }
 
 static void armpmu_enable(struct pmu *pmu)
@@ -555,9 +503,6 @@ static ssize_t armpmu_cpumask_show(struct device *dev,
 
 static void armpmu_init(struct arm_pmu *armpmu)
 {
-	atomic_set(&armpmu->active_events, 0);
-	mutex_init(&armpmu->reserve_mutex);
-
 	armpmu->pmu = (struct pmu) {
 		.pmu_enable	= armpmu_enable,
 		.pmu_disable	= armpmu_disable,
@@ -601,21 +546,7 @@ int perf_num_counters(void)
 }
 EXPORT_SYMBOL_GPL(perf_num_counters);
 
-static void cpu_pmu_enable_percpu_irq(void *data)
-{
-	int irq = *(int *)data;
-
-	enable_percpu_irq(irq, IRQ_TYPE_NONE);
-}
-
-static void cpu_pmu_disable_percpu_irq(void *data)
-{
-	int irq = *(int *)data;
-
-	disable_percpu_irq(irq);
-}
-
-static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
+static void cpu_pmu_free_irqs(struct arm_pmu *cpu_pmu)
 {
 	int cpu;
 	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
@@ -626,10 +557,7 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 			continue;
 
 		if (irq_is_percpu(irq)) {
-			on_each_cpu_mask(&cpu_pmu->supported_cpus,
-					 cpu_pmu_disable_percpu_irq, &irq, 1);
 			free_percpu_irq(irq, &hw_events->percpu_pmu);
-
 			break;
 		}
 
@@ -640,7 +568,7 @@ static void cpu_pmu_free_irq(struct arm_pmu *cpu_pmu)
 	}
 }
 
-static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
+static int cpu_pmu_request_irqs(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 {
 	int cpu, err;
 	struct pmu_hw_events __percpu *hw_events = cpu_pmu->hw_events;
@@ -656,25 +584,9 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 			if (err) {
 				pr_err("unable to request IRQ%d for ARM PMU counters\n",
 					irq);
-				return err;
 			}
 
-			on_each_cpu_mask(&cpu_pmu->supported_cpus,
-					 cpu_pmu_enable_percpu_irq, &irq, 1);
-
-			break;
-		}
-
-		/*
-		 * If we have a single PMU interrupt that we can't shift,
-		 * assume that we're running on a uniprocessor machine and
-		 * continue. Otherwise, continue without this interrupt.
-		 */
-		if (irq_set_affinity(irq, cpumask_of(cpu)) &&
-		    num_possible_cpus() > 1) {
-			pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n",
-				irq, cpu);
-			continue;
+			return err;
 		}
 
 		err = request_irq(irq, handler,
@@ -692,6 +604,12 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 	return 0;
 }
 
+int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
+{
+	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
+	return per_cpu(hw_events->irq, cpu);
+}
+
 /*
  * PMU hardware loses all context when a CPU goes offline.
  * When a CPU is hotplugged back in, since some hardware registers are
@@ -701,11 +619,42 @@ static int cpu_pmu_request_irq(struct arm_pmu *cpu_pmu, irq_handler_t handler)
 static int arm_perf_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct arm_pmu *pmu = hlist_entry_safe(node, struct arm_pmu, node);
+	int irq;
 
 	if (!cpumask_test_cpu(cpu, &pmu->supported_cpus))
 		return 0;
 	if (pmu->reset)
 		pmu->reset(pmu);
+
+	irq = armpmu_get_cpu_irq(pmu, cpu);
+	if (irq) {
+		if (irq_is_percpu(irq)) {
+			enable_percpu_irq(irq, IRQ_TYPE_NONE);
+			return 0;
+		}
+
+		if (irq_force_affinity(irq, cpumask_of(cpu)) &&
+		    num_possible_cpus() > 1) {
+			pr_warn("unable to set irq affinity (irq=%d, cpu=%u)\n",
+				irq, cpu);
+		}
+	}
+
+	return 0;
+}
+
+static int arm_perf_teardown_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct arm_pmu *pmu = hlist_entry_safe(node, struct arm_pmu, node);
+	int irq;
+
+	if (!cpumask_test_cpu(cpu, &pmu->supported_cpus))
+		return 0;
+
+	irq = armpmu_get_cpu_irq(pmu, cpu);
+	if (irq && irq_is_percpu(irq))
+		disable_percpu_irq(irq);
+
 	return 0;
 }
 
@@ -811,8 +760,12 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int err;
 
-	err = cpuhp_state_add_instance_nocalls(CPUHP_AP_PERF_ARM_STARTING,
-					       &cpu_pmu->node);
+	err = cpu_pmu_request_irqs(cpu_pmu, armpmu_dispatch_irq);
+	if (err)
+		goto out;
+
+	err = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_STARTING,
+				       &cpu_pmu->node);
 	if (err)
 		goto out;
 
@@ -820,14 +773,6 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	if (err)
 		goto out_unregister;
 
-	cpu_pmu->request_irq	= cpu_pmu_request_irq;
-	cpu_pmu->free_irq	= cpu_pmu_free_irq;
-
-	/* Ensure the PMU has sane values out of reset. */
-	if (cpu_pmu->reset)
-		on_each_cpu_mask(&cpu_pmu->supported_cpus, cpu_pmu->reset,
-			 cpu_pmu, 1);
-
 	/*
 	 * This is a CPU PMU potentially in a heterogeneous configuration (e.g.
 	 * big.LITTLE). This is not an uncore PMU, and we have taken ctx
@@ -842,6 +787,7 @@ static int cpu_pmu_init(struct arm_pmu *cpu_pmu)
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_STARTING,
 					    &cpu_pmu->node);
 out:
+	cpu_pmu_free_irqs(cpu_pmu);
 	return err;
 }
 
@@ -1122,7 +1068,8 @@ static int arm_pmu_hp_init(void)
 
 	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_STARTING,
 				      "perf/arm/pmu:starting",
-				      arm_perf_starting_cpu, NULL);
+				      arm_perf_starting_cpu,
+				      arm_perf_teardown_cpu);
 	if (ret)
 		pr_err("CPU hotplug notifier for ARM PMU could not be registered: %d\n",
 		       ret);
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 05a3eb4..44f43fc 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -105,12 +105,8 @@ struct arm_pmu {
 	void		(*start)(struct arm_pmu *);
 	void		(*stop)(struct arm_pmu *);
 	void		(*reset)(void *);
-	int		(*request_irq)(struct arm_pmu *, irq_handler_t handler);
-	void		(*free_irq)(struct arm_pmu *);
 	int		(*map_event)(struct perf_event *event);
 	int		num_events;
-	atomic_t	active_events;
-	struct mutex	reserve_mutex;
 	u64		max_period;
 	bool		secure_access; /* 32-bit ARM only */
 #define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
-- 
1.9.1
