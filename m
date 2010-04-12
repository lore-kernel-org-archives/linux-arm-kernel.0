From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Apr 2010 16:04:18 +0100
Subject: [PATCH 3/6] perf-events: allow modules to query the maximum number of
	perf events
In-Reply-To: <1271084661-2305-3-git-send-email-will.deacon@arm.com>
References: <1271084661-2305-1-git-send-email-will.deacon@arm.com>
	<1271084661-2305-2-git-send-email-will.deacon@arm.com>
	<1271084661-2305-3-git-send-email-will.deacon@arm.com>
Message-ID: <1271084661-2305-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An upper bound on the number of perf events is stored in the static
perf_max_events variable. Modules, such as OProfile, can use this
information to allocate and traverse data structures representing
the performance counters for a system.

This patch adds a function to return the value of perf_max_events
and exports this function to modules.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/perf_event.h |    1 +
 kernel/perf_event.c        |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9547703..a197bc5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -751,6 +751,7 @@ struct perf_output_handle {
  * Set by architecture code:
  */
 extern int perf_max_events;
+extern int perf_get_max_events(void);
 
 extern const struct pmu *hw_perf_event_init(struct perf_event *event);
 
diff --git a/kernel/perf_event.c b/kernel/perf_event.c
index 574ee58..464bda6 100644
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
 
-- 
1.6.3.3
