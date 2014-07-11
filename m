From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 11 Jul 2014 13:44:59 -0000
Subject: [patch 41/55] arm: bL_switcher:k Use ktime_get_real_ns()
References: <20140711133623.530368377@linutronix.de>
Message-ID: <20140711133708.760127423@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the nanoseconds based interface instead of converting from a
timespec.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/common/bL_switcher.c |   16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

Index: tip/arch/arm/common/bL_switcher.c
===================================================================
--- tip.orig/arch/arm/common/bL_switcher.c
+++ tip/arch/arm/common/bL_switcher.c
@@ -58,16 +58,6 @@ static int read_mpidr(void)
 }
 
 /*
- * Get a global nanosecond time stamp for tracing.
- */
-static s64 get_ns(void)
-{
-	struct timespec ts;
-	getnstimeofday(&ts);
-	return timespec_to_ns(&ts);
-}
-
-/*
  * bL switcher core code.
  */
 
@@ -224,7 +214,7 @@ static int bL_switch_to(unsigned int new
 	 */
 	local_irq_disable();
 	local_fiq_disable();
-	trace_cpu_migrate_begin(get_ns(), ob_mpidr);
+	trace_cpu_migrate_begin(ktime_get_real_ns(), ob_mpidr);
 
 	/* redirect GIC's SGIs to our counterpart */
 	gic_migrate_target(bL_gic_id[ib_cpu][ib_cluster]);
@@ -267,7 +257,7 @@ static int bL_switch_to(unsigned int new
 					  tdev->evtdev->next_event, 1);
 	}
 
-	trace_cpu_migrate_finish(get_ns(), ib_mpidr);
+	trace_cpu_migrate_finish(ktime_get_real_ns(), ib_mpidr);
 	local_fiq_enable();
 	local_irq_enable();
 
@@ -558,7 +548,7 @@ int bL_switcher_get_logical_index(u32 mp
 
 static void bL_switcher_trace_trigger_cpu(void *__always_unused info)
 {
-	trace_cpu_migrate_current(get_ns(), read_mpidr());
+	trace_cpu_migrate_current(ktime_get_real_ns(), read_mpidr());
 }
 
 int bL_switcher_trace_trigger(void)
