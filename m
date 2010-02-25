From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Feb 2010 18:56:14 +0000
Subject: [PATCH 5/6] ARM: oprofile: use perf-events framework as backend
In-Reply-To: <1267124175-21721-5-git-send-email-will.deacon@arm.com>
References: <1267124175-21721-1-git-send-email-will.deacon@arm.com>
	<1267124175-21721-2-git-send-email-will.deacon@arm.com>
	<1267124175-21721-3-git-send-email-will.deacon@arm.com>
	<1267124175-21721-4-git-send-email-will.deacon@arm.com>
	<1267124175-21721-5-git-send-email-will.deacon@arm.com>
Message-ID: <1267124175-21721-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are currently two hardware performance monitoring subsystems in the
kernel for ARM: OProfile and perf-events. This creates the following problems:

1.) Duplicate PMU accessor code. Inevitable code drift may lead to bugs in one
framework that are fixed in the other.

2.) Locking issues. OProfile doesn't reprogram hardware counters between
profiling runs if the events to be monitored have not been changed. This means
that other profiling frameworks cannot use the counters if OProfile is in use.

3.) Due to differences in the two frameworks, it may not be possible to
compare the results obtained by OProfile with those obtained by perf.

This patch removes the OProfile PMU driver code and replaces it with calls
to perf, therefore solving the issues mentioned above.

The only userspace-visible change is the lack of SCU counter support for
11MPCore. This is currently unsupported by OProfile userspace tools anyway and
therefore shouldn't cause any problems.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/oprofile/common.c |  356 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 307 insertions(+), 49 deletions(-)

diff --git a/arch/arm/oprofile/common.c b/arch/arm/oprofile/common.c
index 3fcd752..e74dd4b 100644
--- a/arch/arm/oprofile/common.c
+++ b/arch/arm/oprofile/common.c
@@ -2,32 +2,210 @@
  * @file common.c
  *
  * @remark Copyright 2004 Oprofile Authors
+ * @remark Copyright 2010 ARM Ltd.
  * @remark Read the file COPYING
  *
  * @author Zwane Mwaikambo
+ * @author Will Deacon [move to perf]
  */
 
+#include <linux/cpumask.h>
+#include <linux/errno.h>
 #include <linux/init.h>
+#include <linux/mutex.h>
 #include <linux/oprofile.h>
-#include <linux/errno.h>
+#include <linux/perf_event.h>
 #include <linux/slab.h>
 #include <linux/sysdev.h>
-#include <linux/mutex.h>
+#include <asm/stacktrace.h>
+#include <linux/uaccess.h>
 
-#include "op_counter.h"
-#include "op_arm_model.h"
+#include <asm/perf_event.h>
+#include <asm/ptrace.h>
+
+#ifdef CONFIG_HW_PERF_EVENTS
+/*
+ * Per performance monitor configuration as set via oprofilefs.
+ */
+struct op_counter_config {
+	unsigned long count;
+	unsigned long enabled;
+	unsigned long event;
+	unsigned long unit_mask;
+	unsigned long kernel;
+	unsigned long user;
+	struct perf_event_attr attr;
+};
 
-static struct op_arm_model_spec *op_arm_model;
 static int op_arm_enabled;
 static DEFINE_MUTEX(op_arm_mutex);
 
-struct op_counter_config *counter_config;
+static struct op_counter_config *counter_config;
+static struct perf_event **perf_events[nr_cpumask_bits];
+static int perf_num_counters;
+
+/*
+ * Create perf attributes to mirror the oprofile settings in counter_config.
+ * Attributes are created in the disabled state and are permanently scheduled
+ * on the PMU.
+ */
+static void op_setup_counter_attrs(void)
+{
+	int i;
+	u32 size = sizeof(struct perf_event_attr);
+	struct perf_event_attr *attr;
+
+	for (i = 0; i < perf_num_counters; ++i) {
+		attr = &counter_config[i].attr;
+		memset(attr, 0, size);
+		attr->type		= PERF_TYPE_RAW;
+		attr->size		= size;
+		attr->config		= counter_config[i].event;
+		attr->sample_period	= counter_config[i].count;
+		attr->pinned		= 1;
+		attr->disabled		= 1;
+	}
+}
+
+/*
+ * Overflow callback for oprofile.
+ */
+static void op_overflow_handler(struct perf_event *event, int unused,
+			struct perf_sample_data *data, struct pt_regs *regs)
+{
+	int id;
+	u32 cpu = smp_processor_id();
+
+	for (id = 0; id < perf_num_counters; ++id)
+		if (perf_events[cpu][id] == event)
+			break;
+
+	if (id != perf_num_counters)
+		oprofile_add_sample(regs, id);
+	else
+		pr_warning("oprofile: ignoring spurious overflow "
+				"on cpu %u\n", cpu);
+}
+
+/*
+ * Create a new perf event for event `id' on cpu `cpu' using the latest
+ * perf attribute for the corresponding counter.
+ */
+static int op_update_perf_event(int cpu, int id)
+{
+	int ret = 0;
+	struct perf_event *event = perf_events[cpu][id];
+	struct perf_event_attr *attr = &counter_config[id].attr;
+
+	if (event != NULL)
+		perf_event_release_kernel(event);
+
+	event = perf_event_create_kernel_counter(attr, cpu, -1,
+						op_overflow_handler);
+	if (IS_ERR(event)) {
+		ret = PTR_ERR(event);
+		event = NULL;
+	}
+
+	perf_events[cpu][id] = event;
+	return ret;
+}
+
+/*
+ * Called by op_arm_setup to program the PMU with the parameters held in
+ * counter_config.
+ */
+static int op_perf_setup(void)
+{
+	int cpu, event, ret = 0;
+
+	op_setup_counter_attrs();
+
+	for_each_online_cpu(cpu) {
+		for (event = 0; event < perf_num_counters; ++event) {
+			ret = op_update_perf_event(cpu, event);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Enable the perf events whose counter_configs are also enabled.
+ * We check that the event becomes active because we specify that
+ * the attribute is pinned.
+ */
+static int op_enable_counter(int cpu, int event)
+{
+	int ret = 0;
+
+	if (counter_config[event].enabled) {
+		perf_event_enable(perf_events[cpu][event]);
+		if (perf_events[cpu][event]->state != PERF_EVENT_STATE_ACTIVE) {
+			pr_warning("oprofile: failed to enable event %d "
+					"on CPU %d\n", event, cpu);
+			ret = -EBUSY;
+		}
+	}
+
+	return ret;
+}
+
+static void op_perf_stop(void)
+{
+	int cpu, event;
+
+	for_each_online_cpu(cpu) {
+		for (event = 0; event < perf_num_counters; ++event)
+			perf_event_disable(perf_events[cpu][event]);
+	}
+}
+
+static int op_perf_start(void)
+{
+	int cpu, event, ret = 0;
+
+	for_each_online_cpu(cpu) {
+		for (event = 0; event < perf_num_counters; ++event) {
+			ret = op_enable_counter(cpu, event);
+			if (ret) {
+				/* Disabling a disabled event is idempotent. */
+				op_perf_stop();
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static char *op_name_from_perf_id(int id)
+{
+	switch (id) {
+	case ARM_PERF_PMU_ID_XSCALE1:
+		return "arm/xscale1";
+	case ARM_PERF_PMU_ID_XSCALE2:
+		return "arm/xscale2";
+	case ARM_PERF_PMU_ID_V6:
+		return "arm/armv6";
+	case ARM_PERF_PMU_ID_V6MP:
+		return "arm/mpcore";
+	case ARM_PERF_PMU_ID_CA8:
+		return "arm/armv7";
+	case ARM_PERF_PMU_ID_CA9:
+		return "arm/armv7-ca9";
+	default:
+		return NULL;
+	}
+}
 
 static int op_arm_create_files(struct super_block *sb, struct dentry *root)
 {
 	unsigned int i;
 
-	for (i = 0; i < op_arm_model->num_counters; i++) {
+	for (i = 0; i < perf_num_counters; i++) {
 		struct dentry *dir;
 		char buf[4];
 
@@ -49,7 +227,7 @@ static int op_arm_setup(void)
 	int ret;
 
 	spin_lock(&oprofilefs_lock);
-	ret = op_arm_model->setup_ctrs();
+	ret = op_perf_setup();
 	spin_unlock(&oprofilefs_lock);
 	return ret;
 }
@@ -60,8 +238,9 @@ static int op_arm_start(void)
 
 	mutex_lock(&op_arm_mutex);
 	if (!op_arm_enabled) {
-		ret = op_arm_model->start();
-		op_arm_enabled = !ret;
+		ret = 0;
+		op_perf_start();
+		op_arm_enabled = 1;
 	}
 	mutex_unlock(&op_arm_mutex);
 	return ret;
@@ -71,7 +250,7 @@ static void op_arm_stop(void)
 {
 	mutex_lock(&op_arm_mutex);
 	if (op_arm_enabled)
-		op_arm_model->stop();
+		op_perf_stop();
 	op_arm_enabled = 0;
 	mutex_unlock(&op_arm_mutex);
 }
@@ -81,7 +260,7 @@ static int op_arm_suspend(struct sys_device *dev, pm_message_t state)
 {
 	mutex_lock(&op_arm_mutex);
 	if (op_arm_enabled)
-		op_arm_model->stop();
+		op_perf_stop();
 	mutex_unlock(&op_arm_mutex);
 	return 0;
 }
@@ -89,7 +268,7 @@ static int op_arm_suspend(struct sys_device *dev, pm_message_t state)
 static int op_arm_resume(struct sys_device *dev)
 {
 	mutex_lock(&op_arm_mutex);
-	if (op_arm_enabled && op_arm_model->start())
+	if (op_arm_enabled && op_perf_start())
 		op_arm_enabled = 0;
 	mutex_unlock(&op_arm_mutex);
 	return 0;
@@ -126,58 +305,137 @@ static void  exit_driverfs(void)
 #define exit_driverfs() do { } while (0)
 #endif /* CONFIG_PM */
 
-int __init oprofile_arch_init(struct oprofile_operations *ops)
+static int report_trace(struct stackframe *frame, void *d)
 {
-	struct op_arm_model_spec *spec = NULL;
-	int ret = -ENODEV;
+	unsigned int *depth = d;
 
-	ops->backtrace = arm_backtrace;
+	if (*depth) {
+		oprofile_add_trace(frame->pc);
+		(*depth)--;
+	}
+
+	return *depth == 0;
+}
 
-#ifdef CONFIG_CPU_XSCALE
-	spec = &op_xscale_spec;
-#endif
+/*
+ * The registers we're interested in are at the end of the variable
+ * length saved register structure. The fp points at the end of this
+ * structure so the address of this struct is:
+ * (struct frame_tail *)(xxx->fp)-1
+ */
+struct frame_tail {
+	struct frame_tail *fp;
+	unsigned long sp;
+	unsigned long lr;
+} __attribute__((packed));
 
-#ifdef CONFIG_OPROFILE_ARMV6
-	spec = &op_armv6_spec;
-#endif
+static struct frame_tail* user_backtrace(struct frame_tail *tail)
+{
+	struct frame_tail buftail[2];
 
-#ifdef CONFIG_OPROFILE_MPCORE
-	spec = &op_mpcore_spec;
-#endif
+	/* Also check accessibility of one struct frame_tail beyond */
+	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
+		return NULL;
+	if (__copy_from_user_inatomic(buftail, tail, sizeof(buftail)))
+		return NULL;
 
-#ifdef CONFIG_OPROFILE_ARMV7
-	spec = &op_armv7_spec;
-#endif
+	oprofile_add_trace(buftail[0].lr);
 
-	if (spec) {
-		ret = spec->init();
-		if (ret < 0)
-			return ret;
+	/* frame pointers should strictly progress back up the stack
+	 * (towards higher addresses) */
+	if (tail >= buftail[0].fp)
+		return NULL;
 
-		counter_config = kcalloc(spec->num_counters, sizeof(struct op_counter_config),
-					 GFP_KERNEL);
-		if (!counter_config)
-			return -ENOMEM;
+	return buftail[0].fp-1;
+}
 
-		op_arm_model = spec;
-		init_driverfs();
-		ops->create_files = op_arm_create_files;
-		ops->setup = op_arm_setup;
-		ops->shutdown = op_arm_stop;
-		ops->start = op_arm_start;
-		ops->stop = op_arm_stop;
-		ops->cpu_type = op_arm_model->name;
-		printk(KERN_INFO "oprofile: using %s\n", spec->name);
+static void arm_backtrace(struct pt_regs * const regs, unsigned int depth)
+{
+	struct frame_tail *tail = ((struct frame_tail *) regs->ARM_fp) - 1;
+
+	if (!user_mode(regs)) {
+		struct stackframe frame;
+		frame.fp = regs->ARM_fp;
+		frame.sp = regs->ARM_sp;
+		frame.lr = regs->ARM_lr;
+		frame.pc = regs->ARM_pc;
+		walk_stackframe(&frame, report_trace, &depth);
+		return;
 	}
 
+	while (depth-- && tail && !((unsigned long) tail & 3))
+		tail = user_backtrace(tail);
+}
+
+int __init oprofile_arch_init(struct oprofile_operations *ops)
+{
+	int cpu, ret = 0;
+
+	perf_num_counters = perf_get_max_events();
+
+	counter_config = kcalloc(perf_num_counters,
+			sizeof(struct op_counter_config), GFP_KERNEL);
+
+	if (!counter_config) {
+		pr_info("oprofile: failed to allocate %d "
+				"counters\n", perf_num_counters);
+		return -ENOMEM;
+	}
+
+	for_each_possible_cpu(cpu) {
+		perf_events[cpu] = kcalloc(perf_num_counters,
+				sizeof(struct perf_event *), GFP_KERNEL);
+		if (!perf_events[cpu]) {
+			pr_info("oprofile: failed to allocate %d perf events "
+					"for cpu %d\n", perf_num_counters, cpu);
+			while (--cpu >= 0)
+				kfree(perf_events[cpu]);
+			return -ENOMEM;
+		}
+	}
+
+	init_driverfs();
+	ops->backtrace		= arm_backtrace;
+	ops->create_files	= op_arm_create_files;
+	ops->setup		= op_arm_setup;
+	ops->shutdown		= op_arm_stop;
+	ops->start		= op_arm_start;
+	ops->stop		= op_arm_stop;
+	ops->cpu_type		= op_name_from_perf_id(armpmu_get_pmu_id());
+
+	if (!ops->cpu_type)
+		ret = -ENODEV;
+	else
+		pr_info("oprofile: using %s\n", ops->cpu_type);
+
 	return ret;
 }
 
 void oprofile_arch_exit(void)
 {
-	if (op_arm_model) {
+	int cpu, id;
+	struct perf_event *event;
+
+	if (*perf_events) {
 		exit_driverfs();
-		op_arm_model = NULL;
+		for_each_possible_cpu(cpu) {
+			for (id = 0; id < perf_num_counters; ++id) {
+				event = perf_events[cpu][id];
+				if (event != NULL)
+					perf_event_release_kernel(event);
+			}
+			kfree(perf_events[cpu]);
+		}
 	}
-	kfree(counter_config);
+
+	if (counter_config)
+		kfree(counter_config);
+}
+#else
+int __init oprofile_arch_init(struct oprofile_operations *ops)
+{
+	pr_info("oprofile: hardware counters not available\n");
+	return -ENODEV;
 }
+void oprofile_arch_exit(void) {}
+#endif /* CONFIG_HW_PERF_EVENTS */
-- 
1.6.3.3
