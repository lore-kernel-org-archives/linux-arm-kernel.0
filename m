From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu,  5 Jul 2018 16:13:42 -0600
Subject: [PATCH v2 2/7] perf/core: Use ioctl to communicate driver
 configuration to kernel
In-Reply-To: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530828827-11604-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1530828827-11604-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the mechanic needed for user space to send PMU specific
configuration to the kernel driver using an ioctl() command.  That way
events can keep track of options that don't fit in the perf_event_attr
structure like the selection of a CoreSight sink to use for the session.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/perf_event.h | 45 +++++++++++++++++++++++++++
 kernel/events/core.c       | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1fa12887ec02..7064b513ca2b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -114,6 +114,14 @@ struct hw_perf_event_extra {
 	int		idx;	/* index in shared_regs->regs[] */
 };
 
+/*
+ * PMU driver configuration
+ */
+struct pmu_drv_config {
+	void		*config;
+	raw_spinlock_t	lock;
+};
+
 /**
  * struct hw_perf_event - performance event hardware details:
  */
@@ -178,6 +186,9 @@ struct hw_perf_event {
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
 
+	/* PMU driver configuration */
+	struct pmu_drv_config		drv_config;
+
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
  */
@@ -447,6 +458,23 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * Valiate complex PMU configuration that don't fit in the
+	 * perf_event_attr struct.  Returns a PMU specific pointer or an error
+	 * value < 0.
+	 *
+	 * As with addr_filters_validate(), runs in the context of the ioctl()
+	 * process and is not serialized with the rest of the PMU callbacks.
+	 */
+	void *(*drv_config_validate)	(struct perf_event *event,
+					 char *config_str);
+
+	/*
+	 * Release PMU specific configuration acquired by
+	 * drv_config_validate()
+	 */
+	void (*drv_config_free)		(void *drv_data);
 };
 
 enum perf_addr_filter_action_t {
@@ -1234,6 +1262,12 @@ static inline bool has_addr_filter(struct perf_event *event)
 	return event->pmu->nr_addr_filters;
 }
 
+static inline bool has_drv_config(struct perf_event *event)
+{
+	return event->pmu->drv_config_validate &&
+	       event->pmu->drv_config_free;
+}
+
 /*
  * An inherited event uses parent's filters
  */
@@ -1248,6 +1282,17 @@ perf_event_addr_filters(struct perf_event *event)
 	return ifh;
 }
 
+static inline struct pmu_drv_config *
+perf_event_get_drv_config(struct perf_event *event)
+{
+	struct pmu_drv_config *cfg = &event->hw.drv_config;
+
+	if (event->parent)
+		cfg = &event->parent->hw.drv_config;
+
+	return cfg;
+}
+
 extern void perf_event_addr_filters_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f0434a9951a..ccff64e9451e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4410,6 +4410,7 @@ static bool exclusive_event_installable(struct perf_event *event,
 
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
+static void perf_drv_config_replace(struct perf_event *event, void *drv_data);
 
 static void _free_event(struct perf_event *event)
 {
@@ -4440,6 +4441,7 @@ static void _free_event(struct perf_event *event)
 	perf_event_free_bpf_prog(event);
 	perf_addr_filters_splice(event, NULL);
 	kfree(event->addr_filters_offs);
+	perf_drv_config_replace(event, NULL);
 
 	if (event->destroy)
 		event->destroy(event);
@@ -5002,6 +5004,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
+static int perf_event_set_drv_config(struct perf_event *event,
+				     void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
@@ -5088,6 +5092,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_SET_DRV_CONFIG:
+		return perf_event_set_drv_config(event, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -9086,6 +9094,75 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	return ret;
 }
 
+static void perf_drv_config_replace(struct perf_event *event, void *drv_data)
+{
+	unsigned long flags;
+	void *old_drv_data;
+	struct pmu_drv_config *drv_config = &event->hw.drv_config;
+
+	if (!has_drv_config(event))
+		return;
+
+	/* Children take their configuration from their parent */
+	if (event->parent)
+		return;
+
+	/* Make sure the PMU doesn't get a handle on the data */
+	raw_spin_lock_irqsave(&drv_config->lock, flags);
+
+	old_drv_data = drv_config->config;
+	drv_config->config = drv_data;
+
+	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
+
+	/* Free PMU private data allocated by pmu::drv_config_validate() */
+	event->pmu->drv_config_free(old_drv_data);
+}
+
+static int
+perf_event_process_drv_config(struct perf_event *event, char *config_str)
+{
+	int ret = -EINVAL;
+	void *drv_data;
+
+	/* Make sure ctx.mutex is held */
+	lockdep_assert_held(&event->ctx->mutex);
+
+	/* Children take their configuration from their parent */
+	if (WARN_ON_ONCE(event->parent))
+		goto out;
+
+	drv_data = event->pmu->drv_config_validate(event, config_str);
+	if (IS_ERR(drv_data)) {
+		ret = PTR_ERR(drv_data);
+		goto out;
+	}
+
+	perf_drv_config_replace(event, drv_data);
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static int perf_event_set_drv_config(struct perf_event *event, void __user *arg)
+{
+	int ret = -EINVAL;
+	char *config_str;
+
+	if (!has_drv_config(event))
+		return ret;
+
+	config_str = strndup_user(arg, PAGE_SIZE);
+	if (IS_ERR(config_str))
+		return PTR_ERR(config_str);
+
+	ret = perf_event_process_drv_config(event, config_str);
+
+	kfree(config_str);
+	return ret;
+}
+
 /*
  * hrtimer based swevent callback
  */
-- 
2.7.4
