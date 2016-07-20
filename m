From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 20 Jul 2016 14:38:16 -0600
Subject: [PATCH V2 2/6] perf: Passing struct perf_event to function setup_aux()
In-Reply-To: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1469047100-18131-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some information, like driver specific configuration, is found
in the hw_perf_event  structure.  As such pass a 'struct perf_event'
to function setup_aux() rather than just the CPU number so that
individual drivers can make the right configuration when setting
up a session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/events/intel/bts.c                      | 4 +++-
 arch/x86/events/intel/pt.c                       | 5 +++--
 drivers/hwtracing/coresight/coresight-etm-perf.c | 4 ++--
 include/linux/perf_event.h                       | 2 +-
 kernel/events/ring_buffer.c                      | 2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 0a6e393a2e62..98155c2dfcce 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -68,8 +68,10 @@ static size_t buf_size(struct page *page)
 }
 
 static void *
-bts_buffer_setup_aux(int cpu, void **pages, int nr_pages, bool overwrite)
+bts_buffer_setup_aux(struct perf_event *event, void **pages,
+		     int nr_pages, bool overwrite)
 {
+	int cpu = event->cpu;
 	struct bts_buffer *buf;
 	struct page *page;
 	int node = (cpu == -1) ? cpu : cpu_to_node(cpu);
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 04bb5fb5a8d7..5178c5de0b19 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1003,10 +1003,11 @@ static int pt_buffer_init_topa(struct pt_buffer *buf, unsigned long nr_pages,
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
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 755125f7917f..f4174f36c5a0 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -155,7 +155,7 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
-static void *etm_setup_aux(int event_cpu, void **pages,
+static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
 	int cpu;
@@ -163,7 +163,7 @@ static void *etm_setup_aux(int event_cpu, void **pages,
 	struct coresight_device *sink;
 	struct etm_event_data *event_data = NULL;
 
-	event_data = alloc_event_data(event_cpu);
+	event_data = alloc_event_data(event->cpu);
 	if (!event_data)
 		return NULL;
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 59d61a12cf9d..5275b6594989 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -407,7 +407,7 @@ struct pmu {
 	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
-	void *(*setup_aux)		(int cpu, void **pages,
+	void *(*setup_aux)		(struct perf_event *event, void **pages,
 					 int nr_pages, bool overwrite);
 					/* optional */
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index ae9b90dc9a5a..56aba90af437 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -616,7 +616,7 @@ int rb_alloc_aux(struct ring_buffer *rb, struct perf_event *event,
 			goto out;
 	}
 
-	rb->aux_priv = event->pmu->setup_aux(event->cpu, rb->aux_pages, nr_pages,
+	rb->aux_priv = event->pmu->setup_aux(event, rb->aux_pages, nr_pages,
 					     overwrite);
 	if (!rb->aux_priv)
 		goto out;
-- 
2.7.4
