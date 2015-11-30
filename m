From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 29 Nov 2015 19:14:41 -0700
Subject: [PATCH V5 20/26] perf: changing pmu::setup_aux() parameter to include
 event
In-Reply-To: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
References: <1448849687-5724-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1448849687-5724-21-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For Coresight ETMv3/4 tracers the event carries information
about trace modes such as user or kernel space tracing and
whether tracing is allowed when operating in secure mode.

Since this information is to be embedded in the private
structure returned by setup_aux(),  changing the first
parameter to be of type struct perf_event * so that all
the necessary information can be conveyed.  Also changing
current customer of the API to reflect the modification.

Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/x86/kernel/cpu/perf_event_intel_bts.c | 4 +++-
 arch/x86/kernel/cpu/perf_event_intel_pt.c  | 5 +++--
 include/linux/perf_event.h                 | 2 +-
 kernel/events/ring_buffer.c                | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel_bts.c b/arch/x86/kernel/cpu/perf_event_intel_bts.c
index 2cad71d1b14c..4bb5bdc092f5 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_bts.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_bts.c
@@ -68,10 +68,12 @@ static size_t buf_size(struct page *page)
 }
 
 static void *
-bts_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool overwrite)
+bts_buffer_setup_aux(struct perf_event *event, void **pages,
+		     int nr_pages, bool overwrite)
 {
 	struct bts_buffer *buf;
 	struct page *page;
+	int cpu = event->cpu;
 	int node = (cpu == -1) ? cpu : cpu_to_node(cpu);
 	unsigned long offset;
 	size_t size = nr_pages << PAGE_SHIFT;
diff --git a/arch/x86/kernel/cpu/perf_event_intel_pt.c b/arch/x86/kernel/cpu/perf_event_intel_pt.c
index 868e1194337f..ba8077cbc755 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_pt.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_pt.c
@@ -860,10 +860,11 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, unsigned long nr_pages,
  * Return:	Our private PT buffer structure.
  */
 static void *
-pt_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool snapshot)
+pt_buffer_setup_aux(struct perf_event *event, void **pages,
+		    int nr_pages, bool snapshot)
 {
 	struct pt_buffer *buf;
-	int node, ret;
+	int node, ret, cpu = event->cpu;
 
 	if (!nr_pages)
 		return NULL;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d841d33bcdc9..da02d4a0baa2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -378,7 +378,7 @@ struct pmu {
 	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
-	void *(*setup_aux)		(int cpu, void **pages,
+	void *(*setup_aux)		(struct perf_event *event, void **pages,
 					 int nr_pages, bool overwrite);
 					/* optional */
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index b5d1ea79c595..b1316d12bb40 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -522,7 +522,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 			goto out;
 	}
 
-	rb->aux_priv = event->pmu->setup_aux(event->cpu, rb->aux_pages, nr_pages,
+	rb->aux_priv = event->pmu->setup_aux(event, rb->aux_pages, nr_pages,
 					     overwrite);
 	if (!rb->aux_priv)
 		goto out;
-- 
2.1.4
