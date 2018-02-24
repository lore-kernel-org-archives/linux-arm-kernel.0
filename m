From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 23 Feb 2018 16:19:38 -0800
Subject: [PATCH v1 2/2] perf/core: Add support for PMUs that can be read from
 any CPU
In-Reply-To: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
Message-ID: <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some PMUs events can be read from any CPU. So allow the PMU to mark
events as such. For these events, we don't need to reject reads or
make smp calls to the event's CPU and cause unnecessary wake ups.

Good examples of such events would be events from caches shared across
all CPUs.

Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
---
 include/linux/perf_event.h |  3 +++
 kernel/events/core.c       | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7546822..ee8978f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -510,9 +510,12 @@ typedef void (*perf_overflow_handler_t)(struct perf_event *,
  * PERF_EV_CAP_SOFTWARE: Is a software event.
  * PERF_EV_CAP_READ_ACTIVE_PKG: A CPU event (or cgroup event) that can be read
  * from any CPU in the package where it is active.
+ * PERF_EV_CAP_READ_ANY_CPU: A CPU event (or cgroup event) that can be read
+ * from any CPU.
  */
 #define PERF_EV_CAP_SOFTWARE		BIT(0)
 #define PERF_EV_CAP_READ_ACTIVE_PKG	BIT(1)
+#define PERF_EV_CAP_READ_ANY_CPU	BIT(2)
 
 #define SWEVENT_HLIST_BITS		8
 #define SWEVENT_HLIST_SIZE		(1 << SWEVENT_HLIST_BITS)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5d3df58..570187b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3484,6 +3484,10 @@ static int __perf_event_read_cpu(struct perf_event *event, int event_cpu)
 {
 	u16 local_pkg, event_pkg;
 
+	if (event->group_caps & PERF_EV_CAP_READ_ANY_CPU) {
+		return smp_processor_id();
+	}
+
 	if (event->group_caps & PERF_EV_CAP_READ_ACTIVE_PKG) {
 		int local_cpu = smp_processor_id();
 
@@ -3575,6 +3579,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 {
 	unsigned long flags;
 	int ret = 0;
+	bool is_any_cpu = !!(event->group_caps & PERF_EV_CAP_READ_ANY_CPU);
 
 	/*
 	 * Disabling interrupts avoids all counter scheduling (context
@@ -3600,7 +3605,8 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 
 	/* If this is a per-CPU event, it must be for this CPU */
 	if (!(event->attach_state & PERF_ATTACH_TASK) &&
-	    event->cpu != smp_processor_id()) {
+	    event->cpu != smp_processor_id() &&
+	    !is_any_cpu) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3610,7 +3616,7 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 	 * or local to this CPU. Furthermore it means its ACTIVE (otherwise
 	 * oncpu == -1).
 	 */
-	if (event->oncpu == smp_processor_id())
+	if (event->oncpu == smp_processor_id() || is_any_cpu)
 		event->pmu->read(event);
 
 	*value = local64_read(&event->count);
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
