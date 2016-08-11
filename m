From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 11 Aug 2016 10:20:59 -0600
Subject: [PATCH V5 4/9] perf/core: Adding PMU driver specific configuration
In-Reply-To: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
References: <1470932464-726-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1470932464-726-5-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch somewhat mimics the work done on address filters to
add the infrastructure needed to pass PMU specific HW
configuration to the driver before a session starts.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/perf_event.h            |  31 ++++++
 include/uapi/linux/perf_event.h       |   1 +
 kernel/events/core.c                  | 179 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h |   1 +
 4 files changed, 211 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8ed4326164cc..1ea2028d9848 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -181,6 +181,10 @@ struct hw_perf_event {
 	/* Last sync'ed generation of filters */
 	unsigned long			addr_filters_gen;
 
+	/* HW specific configuration */
+	void				*drv_configs;
+	raw_spinlock_t			drv_configs_lock;
+
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
  */
@@ -455,6 +459,13 @@ struct pmu {
 	 * Filter events for PMU-specific reasons.
 	 */
 	int (*filter_match)		(struct perf_event *event); /* optional */
+
+	/*
+	 * PMU driver specific configuration.
+	 */
+	int (*set_drv_configs)		(struct perf_event *event,
+					 struct list_head *drv_configs);
+					/* optional */
 };
 
 /**
@@ -492,6 +503,18 @@ struct perf_addr_filters_head {
 };
 
 /**
+ * struct perf_drv_config - PMU specific configuration as specified by users
+ * @entry:	link to the list.
+ * @config:	name of the configuration option.
+ * @option:	value associated to @config as set by users(optional).
+ */
+struct perf_drv_config {
+	struct list_head	entry;
+	char			*config;
+	char			*option;
+};
+
+/**
  * enum perf_event_active_state - the states of a event
  */
 enum perf_event_active_state {
@@ -1194,6 +1217,11 @@ static inline bool has_addr_filter(struct perf_event *event)
 	return event->pmu->nr_addr_filters;
 }
 
+static inline bool has_drv_config(struct perf_event *event)
+{
+	return event->pmu->set_drv_configs;
+}
+
 /*
  * An inherited event uses parent's filters
  */
@@ -1209,6 +1237,9 @@ perf_event_addr_filters(struct perf_event *event)
 }
 
 extern void perf_event_addr_filters_sync(struct perf_event *event);
+extern void *perf_event_drv_configs_set(struct perf_event *event,
+					void *drv_configs);
+extern void *perf_event_drv_configs_get(struct perf_event *event);
 
 extern int perf_output_begin(struct perf_output_handle *handle,
 			     struct perf_event *event, unsigned int size);
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
index b5022836649a..c5c66cc7cd8c 100644
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
@@ -8044,10 +8051,180 @@ static int perf_event_set_filter(struct perf_event *event, void __user *arg)
 	return ret;
 }
 
+static struct perf_drv_config *
+perf_drv_config_new(int cpu, struct list_head *drv_config_list)
+{
+	int node = cpu_to_node(cpu == -1 ? 0 : cpu);
+	struct perf_drv_config *drv_config;
+
+	drv_config = kzalloc_node(sizeof(*drv_config), GFP_KERNEL, node);
+	if (!drv_config)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&drv_config->entry);
+	list_add_tail(&drv_config->entry, drv_config_list);
+
+	return drv_config;
+}
+
+static void free_drv_config_list(struct list_head *drv_config_list)
+{
+	struct perf_drv_config *drv_config, *itr;
+
+	list_for_each_entry_safe(drv_config, itr, drv_config_list, entry) {
+		list_del(&drv_config->entry);
+		kfree(drv_config->config);
+		kfree(drv_config->option);
+		kfree(drv_config);
+	}
+}
+
+/* How long does a configuration option really need to be?  */
+#define PERF_DRV_CONFIG_MAX	128
+
 /*
- * hrtimer based swevent callback
+ * PMU specific driver configuration as specified from user space.
+ * The data come in the form of an ascii string pushed down to the kernel
+ * using an ioctl() call.
+ *
+ * Two format are accepted: a singleton and in pairs.  All of the following
+ * are valid: cfg1, cfg2=config2, cfg3=anything_is_possible.
+ *
+ * It is up to each PMU driver to make sure they can work with the
+ * submitted configurables.
  */
+static int
+perf_event_parse_drv_config(struct perf_event *event, char *options,
+			    struct list_head *drv_config_list)
+{
+	char *token;
+	int ret;
+	struct perf_drv_config *drv_config;
+
+	/*
+	 * First split the @options string in nibbles.  Using the above
+	 * example "cfg1", "cfg2=option2" and "cfg3=anything_is_possible"
+	 * will be processed.
+	 */
+	while ((token = strsep(&options, ",")) != NULL) {
+		char *nibble, *config, *option;
+
+		if (!*token)
+			continue;
+
+		/* Allocate a new driver config structure and queue it. */
+		drv_config = perf_drv_config_new(event->cpu, drv_config_list);
+		if (IS_ERR(drv_config)) {
+			ret = PTR_ERR(drv_config);
+			goto fail;
+		}
+
+		/*
+		 * The nibbles are either a "config" or a "config=option"
+		 * pair.  First get the config part.  Since strsep() sets
+		 * @nibble to the next valid token, nibble will be equal to
+		 * the option part or NULL after the first call.
+		 */
+		nibble = token;
+		config = strsep(&nibble, "=");
+		option = nibble;
+
+		/* This shouldn't be happening */
+		if (!config) {
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		drv_config->config = kstrndup(config,
+					      PERF_DRV_CONFIG_MAX, GFP_KERNEL);
+		if (!drv_config->config) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		if (option) {
+			drv_config->option = kstrndup(option,
+						      PERF_DRV_CONFIG_MAX,
+						      GFP_KERNEL);
+			if (!drv_config->option) {
+				ret = -ENOMEM;
+				goto fail;
+			}
+		}
+	}
 
+	return 0;
+
+fail:
+	free_drv_config_list(drv_config_list);
+	return ret;
+}
+
+static int
+perf_event_set_drv_configs(struct perf_event *event, void __user *arg)
+{
+	char *drv_config_str;
+	int ret = 0;
+	LIST_HEAD(drv_config_list);
+
+	/*
+	 * No point in going further if the PMU driver doesn't support
+	 * cmd line configuration.
+	 */
+	if (!has_drv_config(event))
+		return -EINVAL;
+
+	/* Get a handle on user specified configuration */
+	drv_config_str = strndup_user(arg, PAGE_SIZE);
+	if (IS_ERR(drv_config_str))
+		return PTR_ERR(drv_config_str);
+
+	/* Make sure we have the right format */
+	ret = perf_event_parse_drv_config(event,
+					  drv_config_str, &drv_config_list);
+	if (ret)
+		goto out;
+
+	ret = event->pmu->set_drv_configs(event, &drv_config_list);
+	if (ret)
+		goto out;
+
+out:
+	kfree(drv_config_str);
+	free_drv_config_list(&drv_config_list);
+	return ret;
+}
+
+void *perf_event_drv_configs_set(struct perf_event *event, void *drv_configs)
+{
+	unsigned long flags;
+	void *old_drv_configs;
+
+	if (!event)
+		return ERR_PTR(-EINVAL);
+
+	raw_spin_lock_irqsave(&event->hw.drv_configs_lock, flags);
+	old_drv_configs = event->hw.drv_configs;
+	event->hw.drv_configs = drv_configs;
+	raw_spin_unlock_irqrestore(&event->hw.drv_configs_lock, flags);
+
+	return old_drv_configs;
+}
+EXPORT_SYMBOL_GPL(perf_event_drv_configs_set);
+
+void *perf_event_drv_configs_get(struct perf_event *event)
+{
+	if (!event)
+		return ERR_PTR(-EINVAL);
+
+	return perf_event_drv_configs_set(event, event->hw.drv_configs);
+
+}
+EXPORT_SYMBOL_GPL(perf_event_drv_configs_get);
+
+/*
+ * hrtimer based swevent callback
+ */
 static enum hrtimer_restart perf_swevent_hrtimer(struct hrtimer *hrtimer)
 {
 	enum hrtimer_restart ret = HRTIMER_RESTART;
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
