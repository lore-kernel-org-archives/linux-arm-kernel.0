From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 23 Sep 2013 19:17:53 -0400
Subject: [PATCH 10/13] ARM: bL_switcher: Basic trace events support
In-Reply-To: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
References: <1379978276-31241-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1379978276-31241-11-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@linaro.org>

This patch adds simple trace events to the b.L switcher code
to allow tracing of CPU migration events.

To make use of the trace events, you will need:

CONFIG_FTRACE=y
CONFIG_ENABLE_DEFAULT_TRACERS=y

The following events are added:
  * power:cpu_migrate_begin
  * power:cpu_migrate_finish

each with the following data:
    u64     timestamp;
    u32     cpu_hwid;

power:cpu_migrate_begin occurs immediately before the
switcher-specific migration operations start.
power:cpu_migrate_finish occurs immediately when migration is
completed.

The cpu_hwid field contains the ID fields of the MPIDR.

* For power:cpu_migrate_begin, cpu_hwid is the ID of the outbound
  physical CPU (equivalent to (from_phys_cpu,from_phys_cluster)).

* For power:cpu_migrate_finish, cpu_hwid is the ID of the inbound
  physical CPU (equivalent to (to_phys_cpu,to_phys_cluster)).

By design, the cpu_hwid field is masked in the same way as the
device tree cpu node reg property, allowing direct correlation to
the DT description of the hardware.

The timestamp is added in order to minimise timing noise.  An
accurate system-wide clock should be used for generating this
(hopefully getnstimeofday is appropriate, but it could be changed).
It could be any monotonic shared clock, since the aim is to allow
accurate deltas to be computed.  We don't necessarily care about
accurate synchronisation with wall clock time.

In practice, each switch takes place on a single logical CPU,
and the trace infrastructure should guarantee that events are
well-ordered with respect to a single logical CPU.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/common/bL_switcher.c            | 17 ++++++++
 include/trace/events/power_cpu_migrate.h | 66 ++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 include/trace/events/power_cpu_migrate.h

diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
index dc53eb8dcc..7002de360d 100644
--- a/arch/arm/common/bL_switcher.c
+++ b/arch/arm/common/bL_switcher.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/kthread.h>
 #include <linux/wait.h>
+#include <linux/time.h>
 #include <linux/clockchips.h>
 #include <linux/hrtimer.h>
 #include <linux/tick.h>
@@ -33,10 +34,14 @@
 #include <linux/moduleparam.h>
 
 #include <asm/smp_plat.h>
+#include <asm/cputype.h>
 #include <asm/suspend.h>
 #include <asm/mcpm.h>
 #include <asm/bL_switcher.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/power_cpu_migrate.h>
+
 
 /*
  * Use our own MPIDR accessors as the generic ones in asm/cputype.h have
@@ -52,6 +57,16 @@ static int read_mpidr(void)
 }
 
 /*
+ * Get a global nanosecond time stamp for tracing.
+ */
+static s64 get_ns(void)
+{
+	struct timespec ts;
+	getnstimeofday(&ts);
+	return timespec_to_ns(&ts);
+}
+
+/*
  * bL switcher core code.
  */
 
@@ -208,6 +223,7 @@ static int bL_switch_to(unsigned int new_cluster_id)
 	 */
 	local_irq_disable();
 	local_fiq_disable();
+	trace_cpu_migrate_begin(get_ns(), ob_mpidr);
 
 	/* redirect GIC's SGIs to our counterpart */
 	gic_migrate_target(bL_gic_id[ib_cpu][ib_cluster]);
@@ -250,6 +266,7 @@ static int bL_switch_to(unsigned int new_cluster_id)
 					  tdev->evtdev->next_event, 1);
 	}
 
+	trace_cpu_migrate_finish(get_ns(), ib_mpidr);
 	local_fiq_enable();
 	local_irq_enable();
 
diff --git a/include/trace/events/power_cpu_migrate.h b/include/trace/events/power_cpu_migrate.h
new file mode 100644
index 0000000000..3694af0f5b
--- /dev/null
+++ b/include/trace/events/power_cpu_migrate.h
@@ -0,0 +1,66 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM power
+
+#if !defined(_TRACE_POWER_CPU_MIGRATE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_POWER_CPU_MIGRATE_H
+
+#include <linux/tracepoint.h>
+
+#define __cpu_migrate_proto			\
+	TP_PROTO(u64 timestamp,			\
+		 u32 cpu_hwid)
+#define __cpu_migrate_args			\
+	TP_ARGS(timestamp,			\
+		cpu_hwid)
+
+DECLARE_EVENT_CLASS(cpu_migrate,
+
+	__cpu_migrate_proto,
+	__cpu_migrate_args,
+
+	TP_STRUCT__entry(
+		__field(u64,	timestamp		)
+		__field(u32,	cpu_hwid		)
+	),
+
+	TP_fast_assign(
+		__entry->timestamp = timestamp;
+		__entry->cpu_hwid = cpu_hwid;
+	),
+
+	TP_printk("timestamp=%llu cpu_hwid=0x%08lX",
+		(unsigned long long)__entry->timestamp,
+		(unsigned long)__entry->cpu_hwid
+	)
+);
+
+#define __define_cpu_migrate_event(name)		\
+	DEFINE_EVENT(cpu_migrate, cpu_migrate_##name,	\
+		__cpu_migrate_proto,			\
+		__cpu_migrate_args			\
+	)
+
+__define_cpu_migrate_event(begin);
+__define_cpu_migrate_event(finish);
+
+#undef __define_cpu_migrate
+#undef __cpu_migrate_proto
+#undef __cpu_migrate_args
+
+/* This file can get included multiple times, TRACE_HEADER_MULTI_READ at top */
+#ifndef _PWR_CPU_MIGRATE_EVENT_AVOID_DOUBLE_DEFINING
+#define _PWR_CPU_MIGRATE_EVENT_AVOID_DOUBLE_DEFINING
+
+/*
+ * Set from_phys_cpu and to_phys_cpu to CPU_MIGRATE_ALL_CPUS to indicate
+ * a whole-cluster migration:
+ */
+#define CPU_MIGRATE_ALL_CPUS 0x80000000U
+#endif
+
+#endif /* _TRACE_POWER_CPU_MIGRATE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE power_cpu_migrate
+#include <trace/define_trace.h>
-- 
1.8.4.98.gb022869
