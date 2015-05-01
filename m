From: pawel.moll@arm.com (Pawel Moll)
Date: Fri,  1 May 2015 18:36:27 +0100
Subject: [PATCH 2/5] bus: arm-ccn: cpumask attribute
In-Reply-To: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
References: <1430501790-26918-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1430501790-26918-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a "cpumask" attribute to CCN's event_source class sysfs
directory. Perf user tool uses it to restrict events to the
processor(s) enumerated in this mask.

This patch provides a single CPU mask, making it possible to run "-a"
perf session (previously it would request the same CCN event, for
example cycle counter, on each available core and most likely fail).
Initially the mask is set to the CPU that happened to probe the driver,
but it will be changed when it is hot-un-plugged (active events are
migrated to another CPU then).

Example:

 Performance counter stats for 'system wide':

CPU0               2968148      cycles
CPU1               2236736      cycles
CPU2               1797968      cycles
CPU3               1831715      cycles
CPU1            1201850868      ccn/cycles/

       1.001241383 seconds time elapsed

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/arm/CCN.txt |  15 +++---
 drivers/bus/arm-ccn.c     | 128 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 126 insertions(+), 17 deletions(-)

diff --git a/Documentation/arm/CCN.txt b/Documentation/arm/CCN.txt
index 0632b3a..3a76048 100644
--- a/Documentation/arm/CCN.txt
+++ b/Documentation/arm/CCN.txt
@@ -33,6 +33,13 @@ directory, with first 8 configurable by user and additional
 Cycle counter is described by a "type" value 0xff and does
 not require any other settings.
 
+The driver also provides a "cpumask" sysfs attribute, which contains
+a single CPU ID, of the processor which will be used to handle all
+the CCN PMU events. It is recommended that the user space tools
+request the events on this processor (if not, the perf_event->cpu value
+will be overwritten anyway). In case of this processor being offlined,
+the events are migrated to another one and the attribute is updated.
+
 Example of perf tool use:
 
 / # perf list | grep ccn
@@ -41,12 +48,8 @@ Example of perf tool use:
   ccn/xp_valid_flit/                                 [Kernel PMU event]
 <...>
 
-/ # perf stat -C 0 -e ccn/cycles/,ccn/xp_valid_flit,xp=1,port=0,vc=1,dir=1/ \
+/ # perf stat -a -e ccn/cycles/,ccn/xp_valid_flit,xp=1,port=0,vc=1,dir=1/ \
                                                                        sleep 1
 
 The driver does not support sampling, therefore "perf record" will
-not work. Also notice that only single cpu is being selected
-("-C 0") - this is because perf framework does not support
-"non-CPU related" counters (yet?) so system-wide session ("-a")
-would try (and in most cases fail) to set up the same event
-per each CPU.
+not work. Per-task (without "-a") perf sessions are not supported.
diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 60397ec..3374dcb 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -166,13 +166,17 @@ struct arm_ccn_dt {
 
 	struct hrtimer hrtimer;
 
+	cpumask_t cpu;
+	struct notifier_block cpu_nb;
+
 	struct pmu pmu;
 };
 
 struct arm_ccn {
 	struct device *dev;
 	void __iomem *base;
-	unsigned irq_used:1;
+	unsigned int irq;
+
 	unsigned sbas_present:1;
 	unsigned sbsx_present:1;
 
@@ -521,6 +525,25 @@ static struct attribute_group arm_ccn_pmu_cmp_mask_attr_group = {
 	.attrs = arm_ccn_pmu_cmp_mask_attrs,
 };
 
+static ssize_t arm_ccn_pmu_cpumask_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct arm_ccn *ccn = pmu_to_arm_ccn(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, &ccn->dt.cpu);
+}
+
+static struct device_attribute arm_ccn_pmu_cpumask_attr =
+		__ATTR(cpumask, S_IRUGO, arm_ccn_pmu_cpumask_show, NULL);
+
+static struct attribute *arm_ccn_pmu_cpumask_attrs[] = {
+	&arm_ccn_pmu_cpumask_attr.attr,
+	NULL,
+};
+
+static struct attribute_group arm_ccn_pmu_cpumask_attr_group = {
+	.attrs = arm_ccn_pmu_cpumask_attrs,
+};
 
 /*
  * Default poll period is 10ms, which is way over the top anyway,
@@ -542,6 +565,7 @@ static const struct attribute_group *arm_ccn_pmu_attr_groups[] = {
 	&arm_ccn_pmu_events_attr_group,
 	&arm_ccn_pmu_format_attr_group,
 	&arm_ccn_pmu_cmp_mask_attr_group,
+	&arm_ccn_pmu_cpumask_attr_group,
 	NULL
 };
 
@@ -642,6 +666,16 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 		dev_warn(ccn->dev, "Can't provide per-task data!\n");
 		return -EOPNOTSUPP;
 	}
+	/*
+	 * Many perf core operations (eg. events rotation) operate on a
+	 * single CPU context. This is obvious for CPU PMUs, where one
+	 * expects the same sets of events being observed on all CPUs,
+	 * but can lead to issues for off-core PMUs, like CCN, where each
+	 * event could be theoretically assigned to a different CPU. To
+	 * mitigate this, we enforce CPU assignment to one, selected
+	 * processor (the one described in the "cpumask" attribute).
+	 */
+	event->cpu = cpumask_first(&ccn->dt.cpu);
 
 	node_xp = CCN_CONFIG_NODE(event->attr.config);
 	type = CCN_CONFIG_TYPE(event->attr.config);
@@ -835,9 +869,15 @@ static void arm_ccn_pmu_event_start(struct perf_event *event, int flags)
 			arm_ccn_pmu_read_counter(ccn, hw->idx));
 	hw->state = 0;
 
-	if (!ccn->irq_used)
-		hrtimer_start(&ccn->dt.hrtimer, arm_ccn_pmu_timer_period(),
-				HRTIMER_MODE_REL);
+	/*
+	 * Pin the timer, so that the overflows are handled by the chosen
+	 * event->cpu (this is the same one as presented in "cpumask"
+	 * attribute).
+	 */
+	if (!ccn->irq)
+		__hrtimer_start_range_ns(&ccn->dt.hrtimer,
+				arm_ccn_pmu_timer_period(), 0,
+				HRTIMER_MODE_REL_PINNED, 0);
 
 	/* Set the DT bus input, engaging the counter */
 	arm_ccn_pmu_xp_dt_config(event, 1);
@@ -852,7 +892,7 @@ static void arm_ccn_pmu_event_stop(struct perf_event *event, int flags)
 	/* Disable counting, setting the DT bus to pass-through mode */
 	arm_ccn_pmu_xp_dt_config(event, 0);
 
-	if (!ccn->irq_used)
+	if (!ccn->irq)
 		hrtimer_cancel(&ccn->dt.hrtimer);
 
 	/* Let the DT bus drain */
@@ -1079,12 +1119,39 @@ static enum hrtimer_restart arm_ccn_pmu_timer_handler(struct hrtimer *hrtimer)
 }
 
 
+static int arm_ccn_pmu_cpu_notifier(struct notifier_block *nb,
+		unsigned long action, void *hcpu)
+{
+	struct arm_ccn_dt *dt = container_of(nb, struct arm_ccn_dt, cpu_nb);
+	struct arm_ccn *ccn = container_of(dt, struct arm_ccn, dt);
+	unsigned int cpu = (long)hcpu; /* for (long) see kernel/cpu.c */
+	unsigned int target;
+
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_DOWN_PREPARE:
+		if (!cpumask_test_and_clear_cpu(cpu, &dt->cpu))
+			break;
+		target = cpumask_any_but(cpu_online_mask, cpu);
+		if (target < 0)
+			break;
+		perf_pmu_migrate_context(&dt->pmu, cpu, target);
+		cpumask_set_cpu(target, &dt->cpu);
+		WARN_ON(irq_set_affinity(ccn->irq, &dt->cpu) != 0);
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+
 static DEFINE_IDA(arm_ccn_pmu_ida);
 
 static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 {
 	int i;
 	char *name;
+	int err;
 
 	/* Initialize DT subsystem */
 	ccn->dt.base = ccn->base + CCN_REGION_SIZE;
@@ -1136,20 +1203,58 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	};
 
 	/* No overflow interrupt? Have to use a timer instead. */
-	if (!ccn->irq_used) {
+	if (!ccn->irq) {
 		dev_info(ccn->dev, "No access to interrupts, using timer.\n");
 		hrtimer_init(&ccn->dt.hrtimer, CLOCK_MONOTONIC,
 				HRTIMER_MODE_REL);
 		ccn->dt.hrtimer.function = arm_ccn_pmu_timer_handler;
 	}
 
-	return perf_pmu_register(&ccn->dt.pmu, name, -1);
+	/* Pick one CPU which we will use to collect data from CCN... */
+	cpumask_set_cpu(smp_processor_id(), &ccn->dt.cpu);
+
+	/*
+	 * ... and change the selection when it goes offline. Priority is
+	 * picked to have a chance to migrate events before perf is notified.
+	 */
+	ccn->dt.cpu_nb.notifier_call = arm_ccn_pmu_cpu_notifier;
+	ccn->dt.cpu_nb.priority = CPU_PRI_PERF + 1,
+	err = register_cpu_notifier(&ccn->dt.cpu_nb);
+	if (err)
+		goto error_cpu_notifier;
+
+	/* Also make sure that the overflow interrupt is handled by this CPU */
+	if (ccn->irq) {
+		err = irq_set_affinity(ccn->irq, &ccn->dt.cpu);
+		if (err) {
+			dev_err(ccn->dev, "Failed to set interrupt affinity!\n");
+			goto error_set_affinity;
+		}
+	}
+
+	err = perf_pmu_register(&ccn->dt.pmu, name, -1);
+	if (err)
+		goto error_pmu_register;
+
+	return 0;
+
+error_pmu_register:
+error_set_affinity:
+	unregister_cpu_notifier(&ccn->dt.cpu_nb);
+error_cpu_notifier:
+	ida_simple_remove(&arm_ccn_pmu_ida, ccn->dt.id);
+	for (i = 0; i < ccn->num_xps; i++)
+		writel(0, ccn->xp[i].base + CCN_XP_DT_CONTROL);
+	writel(0, ccn->dt.base + CCN_DT_PMCR);
+	return err;
 }
 
 static void arm_ccn_pmu_cleanup(struct arm_ccn *ccn)
 {
 	int i;
 
+	irq_set_affinity(ccn->irq, cpu_possible_mask);
+	unregister_cpu_notifier(&ccn->dt.cpu_nb);
 	for (i = 0; i < ccn->num_xps; i++)
 		writel(0, ccn->xp[i].base + CCN_XP_DT_CONTROL);
 	writel(0, ccn->dt.base + CCN_DT_PMCR);
@@ -1285,6 +1390,7 @@ static int arm_ccn_probe(struct platform_device *pdev)
 {
 	struct arm_ccn *ccn;
 	struct resource *res;
+	unsigned int irq;
 	int err;
 
 	ccn = devm_kzalloc(&pdev->dev, sizeof(*ccn), GFP_KERNEL);
@@ -1309,6 +1415,7 @@ static int arm_ccn_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (!res)
 		return -EINVAL;
+	irq = res->start;
 
 	/* Check if we can use the interrupt */
 	writel(CCN_MN_ERRINT_STATUS__PMU_EVENTS__DISABLE,
@@ -1318,13 +1425,12 @@ static int arm_ccn_probe(struct platform_device *pdev)
 		/* Can set 'disable' bits, so can acknowledge interrupts */
 		writel(CCN_MN_ERRINT_STATUS__PMU_EVENTS__ENABLE,
 				ccn->base + CCN_MN_ERRINT_STATUS);
-		err = devm_request_irq(ccn->dev, res->start,
-				arm_ccn_irq_handler, 0, dev_name(ccn->dev),
-				ccn);
+		err = devm_request_irq(ccn->dev, irq, arm_ccn_irq_handler, 0,
+				dev_name(ccn->dev), ccn);
 		if (err)
 			return err;
 
-		ccn->irq_used = 1;
+		ccn->irq = irq;
 	}
 
 
-- 
2.1.0
