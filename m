From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu,  4 Aug 2016 10:53:19 -0600
Subject: [PATCH V4 1/6] perf/core: Adding PMU driver specific configuration
In-Reply-To: <1470329604-14356-1-git-send-email-mathieu.poirier@linaro.org>
References: <1470329604-14356-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1470329604-14356-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch somewhat mimics the work done on address filters to
add the infrastructure needed to pass PMU specific HW
configuration to the driver before a session starts.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/perf_event.h            |  9 +++++++++
 include/uapi/linux/perf_event.h       |  1 +
 kernel/events/core.c                  | 16 ++++++++++++++++
 tools/include/uapi/linux/perf_event.h |  1 +
 4 files changed, 27 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7921f4f20a58..59d61a12cf9d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -168,6 +168,9 @@ struct hw_perf_event {
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
 
+	/* HW specific configuration */
+	void				*drv_configs;
+
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
  */
@@ -442,6 +445,12 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * PMU driver specific configuration.
+	 */
+	int (*set_drv_configs)		(struct perf_event *event,
+					 void __user *arg); /* optional */
 };
 
 /**
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c66a485a24ac..90fbc5fd3925 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -407,6 +407,7 @@ struct perf_event_attr {
 #define PERF_EVENT_IOC_ID		_IOR('$', 7, __u64 *)
 #define PERF_EVENT_IOC_SET_BPF		_IOW('$', 8, __u32)
 #define PERF_EVENT_IOC_PAUSE_OUTPUT	_IOW('$', 9, __u32)
+#define PERF_EVENT_IOC_SET_DRV_CONFIGS	_IOW('$', 10, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 79dae188a987..9208e6ec036f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4457,6 +4457,8 @@ static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
+static int perf_event_set_drv_configs(struct perf_event *event,
+				      void __user *arg);
 
 static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned long arg)
 {
@@ -4526,6 +4528,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 		rcu_read_unlock();
 		return 0;
 	}
+
+	case PERF_EVENT_IOC_SET_DRV_CONFIGS:
+		return perf_event_set_drv_configs(event, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -4558,6 +4564,7 @@ static long perf_compat_ioctl(struct file *file, unsigned int cmd,
 	switch (_IOC_NR(cmd)) {
 	case _IOC_NR(PERF_EVENT_IOC_SET_FILTER):
 	case _IOC_NR(PERF_EVENT_IOC_ID):
+	case _IOC_NR(PERF_EVENT_IOC_SET_DRV_CONFIGS):
 		/* Fix up pointer size (usually 4 -> 8 in 32-on-64-bit case */
 		if (_IOC_SIZE(cmd) == sizeof(compat_uptr_t)) {
 			cmd &= ~IOCSIZE_MASK;
@@ -7633,6 +7640,15 @@ void perf_bp_event(struct perf_event *bp, void *data)
 }
 #endif
 
+static int perf_event_set_drv_configs(struct perf_event *event,
+				  void __user *arg)
+{
+	if (!event->pmu->set_drv_configs)
+		return -EINVAL;
+
+	return event->pmu->set_drv_configs(event, arg);
+}
+
 /*
  * Allocate a new address filter
  */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index c66a485a24ac..90fbc5fd3925 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -407,6 +407,7 @@ struct perf_event_attr {
 #define PERF_EVENT_IOC_ID		_IOR('$', 7, __u64 *)
 #define PERF_EVENT_IOC_SET_BPF		_IOW('$', 8, __u32)
 #define PERF_EVENT_IOC_PAUSE_OUTPUT	_IOW('$', 9, __u32)
+#define PERF_EVENT_IOC_SET_DRV_CONFIGS	_IOW('$', 10, char *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
-- 
2.7.4
