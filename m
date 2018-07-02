From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  2 Jul 2018 16:33:29 -0600
Subject: [PATCH 5/6] perf/core: Use ioctl to communicate driver configuration
 to kernel
In-Reply-To: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch follows what has been done for filters by adding an ioctl()
option to communicate to the kernel arbitrary PMU specific configuration
that don't fit in the conventional struct perf_event_attr to the kernel.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/perf_event.h |  54 ++++++++++++++++++++++
 kernel/events/core.c       | 110 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4d9c8f30ca6c..6e06b63c262f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -178,6 +178,12 @@ struct hw_perf_event {
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
 
+	/* PMU driver configuration */
+	void				*drv_config;
+
+	/* Last sync'ed generation of driver config */
+	unsigned long			drv_config_gen;
+
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
  */
@@ -447,6 +453,26 @@ struct pmu {
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
+	/* Synchronize PMU driver configuration */
+	void (*drv_config_sync)		(struct perf_event *event);
+
+	/*
+	 * Release PMU specific configuration acquired by
+	 * drv_config_validate()
+	 */
+	void (*drv_config_free)		(void *drv_data);
 };
 
 enum perf_addr_filter_action_t {
@@ -489,6 +515,11 @@ struct perf_addr_filters_head {
 	unsigned int		nr_file_filters;
 };
 
+struct perf_drv_config {
+	void		*drv_config;
+	raw_spinlock_t	lock;
+};
+
 /**
  * enum perf_event_state - the states of a event
  */
@@ -668,6 +699,10 @@ struct perf_event {
 	unsigned long			*addr_filters_offs;
 	unsigned long			addr_filters_gen;
 
+	/* PMU driver specific configuration */
+	struct perf_drv_config		drv_config;
+	unsigned long			drv_config_gen;
+
 	void (*destroy)(struct perf_event *);
 	struct rcu_head			rcu_head;
 
@@ -1234,6 +1269,13 @@ static inline bool has_addr_filter(struct perf_event *event)
 	return event->pmu->nr_addr_filters;
 }
 
+static inline bool has_drv_config(struct perf_event *event)
+{
+	return event->pmu->drv_config_validate &&
+	       event->pmu->drv_config_sync &&
+	       event->pmu->drv_config_free;
+}
+
 /*
  * An inherited event uses parent's filters
  */
@@ -1248,7 +1290,19 @@ perf_event_addr_filters(struct perf_event *event)
 	return ifh;
 }
 
+static inline struct perf_drv_config *
+perf_event_get_drv_config(struct perf_event *event)
+{
+	struct perf_drv_config *cfg = &event->drv_config;
+
+	if (event->parent)
+		cfg = &event->parent->drv_config;
+
+	return cfg;
+}
+
 extern void perf_event_addr_filters_sync(struct perf_event *event);
+extern void perf_event_drv_config_sync(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_event *event, unsigned int size);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f0434a9951a..701839866789 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2829,6 +2829,29 @@ void perf_event_addr_filters_sync(struct perf_event *event)
 }
 EXPORT_SYMBOL_GPL(perf_event_addr_filters_sync);
 
+/*
+ * PMU driver configuration works the same way as filter management above,
+ * but without the need to deal with memory mapping.  Driver configuration
+ * arrives through the SET_DRV_CONFIG ioctl() where it is validated and applied
+ * to the event.  When the PMU is ready it calls perf_event_drv_config_sync() to
+ * bring the configuration information within reach of the PMU.
+ */
+void perf_event_drv_config_sync(struct perf_event *event)
+{
+	struct perf_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	if (!has_drv_config(event))
+		return;
+
+	raw_spin_lock(&drv_config->lock);
+	if (event->drv_config_gen != event->hw.drv_config_gen) {
+		event->pmu->drv_config_sync(event);
+		event->hw.drv_config_gen = event->drv_config_gen;
+	}
+	raw_spin_unlock(&drv_config->lock);
+}
+EXPORT_SYMBOL_GPL(perf_event_drv_config_sync);
+
 static int _perf_event_refresh(struct perf_event *event, int refresh)
 {
 	/*
@@ -4410,6 +4433,7 @@ static bool exclusive_event_installable(struct perf_event *event,
 
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
+static void perf_drv_config_splice(struct perf_event *event, void *drv_data);
 
 static void _free_event(struct perf_event *event)
 {
@@ -4440,6 +4464,7 @@ static void _free_event(struct perf_event *event)
 	perf_event_free_bpf_prog(event);
 	perf_addr_filters_splice(event, NULL);
 	kfree(event->addr_filters_offs);
+	perf_drv_config_splice(event, NULL);
 
 	if (event->destroy)
 		event->destroy(event);
@@ -5002,6 +5027,8 @@ static inline int perf_fget_light(int fd, struct fd *p)
 static int perf_event_set_output(struct perf_event *event,
 				 struct perf_event *output_event);
 static int perf_event_set_filter(struct perf_event *event, void __user *arg);
+static int perf_event_set_drv_config(struct perf_event *event,
+				     void __user *arg);
 static int perf_event_set_bpf_prog(struct perf_event *event, u32 prog_fd);
 static int perf_copy_attr(struct perf_event_attr __user *uattr,
 			  struct perf_event_attr *attr);
@@ -5088,6 +5115,10 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 
 		return perf_event_modify_attr(event,  &new_attr);
 	}
+
+	case PERF_EVENT_IOC_SET_DRV_CONFIG:
+		return perf_event_set_drv_config(event, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -9086,6 +9117,85 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	return ret;
 }
 
+static void perf_drv_config_splice(struct perf_event *event, void *drv_data)
+{
+	unsigned long flags;
+	void *old_drv_data;
+
+	if (!has_drv_config(event))
+		return;
+
+	/* Children take their configuration from their parent */
+	if (event->parent)
+		return;
+
+	raw_spin_lock_irqsave(&event->drv_config.lock, flags);
+
+	old_drv_data = event->drv_config.drv_config;
+	event->drv_config.drv_config = drv_data;
+
+	raw_spin_unlock_irqrestore(&event->drv_config.lock, flags);
+
+	event->pmu->drv_config_free(old_drv_data);
+}
+
+static void perf_event_drv_config_apply(struct perf_event *event)
+{
+	unsigned long flags;
+	struct perf_drv_config *drv_config = perf_event_get_drv_config(event);
+
+	/* Notify event that a new configuration is available */
+	raw_spin_lock_irqsave(&drv_config->lock, flags);
+	event->drv_config_gen++;
+	raw_spin_unlock_irqrestore(&drv_config->lock, flags);
+}
+
+static int
+perf_event_process_drv_config(struct perf_event *event, char *config_str)
+{
+	int ret = -EINVAL;
+	void *drv_data;
+
+	/* Make sure ctx.mutex it held */
+	lockdep_assert_held(&event->ctx->mutex);
+
+	/* Children take their configuration from their parent */
+	if (WARN_ON_ONCE(event->parent))
+		goto out;
+
+	drv_data = event->pmu->drv_config_validate(event, config_str);
+	if (!drv_data)
+		goto out;
+	if (IS_ERR(drv_data)) {
+		ret = PTR_ERR(drv_data);
+		goto out;
+	}
+
+	perf_drv_config_splice(event, drv_data);
+
+	perf_event_for_each_child(event, perf_event_drv_config_apply);
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
+	config_str = strndup_user(arg, PAGE_SIZE);
+	if (IS_ERR(config_str))
+		return PTR_ERR(config_str);
+
+	if (has_drv_config(event))
+		ret = perf_event_process_drv_config(event, config_str);
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
