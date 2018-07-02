From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  2 Jul 2018 16:33:25 -0600
Subject: [PATCH 1/6] perf tools: Use ioctl to communicate driver configuration
 to kernel
In-Reply-To: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1530570810-28929-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following in the footsteps of what was done for filters, adding the
necessary mechanic needed to push down driver specific configuration
to the kernel using an ioctl. By proceeding this way PMU specific
configuration can be communicated to each event.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/uapi/linux/perf_event.h       | 1 +
 tools/include/uapi/linux/perf_event.h | 1 +
 tools/perf/util/evsel.c               | 7 +++++++
 tools/perf/util/evsel.h               | 1 +
 4 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b8e288a1f740..b5b3241877df 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -460,6 +460,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b8e288a1f740..b5b3241877df 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -460,6 +460,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_SET_DRV_CONFIG		_IOW('$', 12, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 94fce4f537e9..534aca4c642c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1162,6 +1162,13 @@ static int perf_evsel__append_filter(struct perf_evsel *evsel,
 	return -1;
 }
 
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, const char *config)
+{
+	return perf_evsel__run_ioctl(evsel,
+				     PERF_EVENT_IOC_SET_DRV_CONFIG,
+				     (void *)config);
+}
+
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter)
 {
 	return perf_evsel__append_filter(evsel, "(%s) && (%s)", filter);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d277930b19a1..0f671bd2a988 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -271,6 +271,7 @@ int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
 				   const char *filter);
 int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
+int perf_evsel__apply_drv_config(struct perf_evsel *evsel, const char *config);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
-- 
2.7.4
