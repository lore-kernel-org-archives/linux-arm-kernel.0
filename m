From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Mar 2010 10:41:28 +0000
Subject: [PATCH 4/6] perf-events: export enable/disable event symbols to
	kernel modules
In-Reply-To: <1268217690-29712-4-git-send-email-will.deacon@arm.com>
References: <1268217690-29712-1-git-send-email-will.deacon@arm.com>
	<1268217690-29712-2-git-send-email-will.deacon@arm.com>
	<1268217690-29712-3-git-send-email-will.deacon@arm.com>
	<1268217690-29712-4-git-send-email-will.deacon@arm.com>
Message-ID: <1268217690-29712-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The perf_event_enable and perf_event_disable functions are used to
control the activation of perf-events for a given context or CPU.

This patch exports these symbols so that they can be used by kernel
modules. Without these symbols, an event must be destroyed and recreated
to disable or enable it respectively. The maximum number of perf-events
is also made available to modules via the perf_get_max_events function.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/perf_event.h |    1 +
 kernel/perf_event.c        |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a177698..c28a0ee 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -741,6 +741,7 @@ struct perf_output_handle {
  * Set by architecture code:
  */
 extern int perf_max_events;
+extern int perf_get_max_events(void);
 
 extern const struct pmu *hw_perf_event_init(struct perf_event *event);
 
diff --git a/kernel/perf_event.c b/kernel/perf_event.c
index 2ae7409..0157033 100644
--- a/kernel/perf_event.c
+++ b/kernel/perf_event.c
@@ -39,6 +39,12 @@
 static DEFINE_PER_CPU(struct perf_cpu_context, perf_cpu_context);
 
 int perf_max_events __read_mostly = 1;
+int perf_get_max_events(void)
+{
+	return perf_max_events;
+}
+EXPORT_SYMBOL_GPL(perf_get_max_events);
+
 static int perf_reserved_percpu __read_mostly;
 static int perf_overcommit __read_mostly = 1;
 
@@ -604,6 +610,7 @@ void perf_event_disable(struct perf_event *event)
 
 	raw_spin_unlock_irq(&ctx->lock);
 }
+EXPORT_SYMBOL_GPL(perf_event_disable);
 
 static int
 event_sched_in(struct perf_event *event,
@@ -1028,6 +1035,7 @@ void perf_event_enable(struct perf_event *event)
  out:
 	raw_spin_unlock_irq(&ctx->lock);
 }
+EXPORT_SYMBOL_GPL(perf_event_enable);
 
 static int perf_event_refresh(struct perf_event *event, int refresh)
 {
-- 
1.6.3.3
