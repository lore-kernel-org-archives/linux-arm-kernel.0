From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Jul 2016 13:51:24 -0600
Subject: [PATCH 03/10] coresight: etm-perf: configuring filters from perf core
In-Reply-To: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
References: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1468871491-10997-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements the required API needed to access
and retrieve range and start/stop filters from the perf core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 146 ++++++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm-perf.h |  32 +++++
 2 files changed, 162 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 78a1bc0013a2..fde7f42149c5 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -29,6 +29,7 @@
 #include <linux/workqueue.h>
 
 #include "coresight-priv.h"
+#include "coresight-etm-perf.h"
 
 static struct pmu etm_pmu;
 static bool etm_perf_up;
@@ -83,12 +84,44 @@ static const struct attribute_group *etm_pmu_attr_groups[] = {
 
 static void etm_event_read(struct perf_event *event) {}
 
+static int etm_addr_filters_alloc(struct perf_event *event)
+{
+	struct etm_filters *filters;
+	int node = event->cpu == -1 ? -1 : cpu_to_node(event->cpu);
+
+	filters = kzalloc_node(sizeof(struct etm_filters), GFP_KERNEL, node);
+	if (!filters)
+		return -ENOMEM;
+
+	if (event->parent)
+		memcpy(filters, event->parent->hw.addr_filters,
+		       sizeof(*filters));
+
+	event->hw.addr_filters = filters;
+
+	return 0;
+}
+
+static void etm_event_destroy(struct perf_event *event)
+{
+	kfree(event->hw.addr_filters);
+	event->hw.addr_filters = NULL;
+}
+
 static int etm_event_init(struct perf_event *event)
 {
+	int ret;
+
 	if (event->attr.type != etm_pmu.type)
 		return -ENOENT;
 
-	return 0;
+	ret = etm_addr_filters_alloc(event);
+	if (ret)
+		return ret;
+
+	event->destroy = etm_event_destroy;
+
+	return ret;
 }
 
 static void free_event_data(struct work_struct *work)
@@ -456,6 +489,85 @@ static void etm_free_drv_configs(struct perf_event *event)
 	}
 }
 
+static int etm_addr_filters_validate(struct list_head *filters)
+{
+	bool range = false, address = false;
+	int index = 0;
+	struct perf_addr_filter *filter;
+
+	list_for_each_entry(filter, filters, entry) {
+		/*
+		 * No need to go further if there's no more
+		 * room for filters.
+		 */
+		if (++index > ETM_ADDR_CMP_MAX)
+			return -EOPNOTSUPP;
+
+		/*
+		 * As taken from the struct perf_addr_filter documentation:
+		 *	@range:	1: range, 0: address
+		 *
+		 * At this time we don't allow range and start/stop filtering
+		 * to cohabitate, they have to be mutually exclusive.
+		 */
+		if ((filter->range == 1) && address)
+			return -EOPNOTSUPP;
+
+		if ((filter->range == 0) && range)
+			return -EOPNOTSUPP;
+
+		/*
+		 * For range filtering, the second address in the address
+		 * range comparator needs to be higher than the first.
+		 * Invalid otherwise.
+		 */
+		if (filter->range && filter->size == 0)
+			return -EINVAL;
+
+		/*
+		 * Everything checks out with this filter, record what we've
+		 * received before moving on to the next one.
+		 */
+		if (filter->range)
+			range = true;
+		else
+			address = true;
+	}
+
+	return 0;
+}
+
+static void etm_addr_filters_sync(struct perf_event *event)
+{
+	struct perf_addr_filters_head *head = perf_event_addr_filters(event);
+	unsigned long start, stop, *offs = event->addr_filters_offs;
+	struct etm_filters *filters = event->hw.addr_filters;
+	struct perf_addr_filter *filter;
+	int i = 0;
+
+	list_for_each_entry(filter, &head->list, entry) {
+		start = filter->offset + offs[i];
+		stop = start + filter->size;
+
+		if (filter->range == 1) {
+			filters->filter[i].start_addr = start;
+			filters->filter[i].stop_addr = stop;
+			filters->filter[i].type = ETM_ADDR_TYPE_RANGE;
+		} else {
+			if (filter->filter == 1) {
+				filters->filter[i].start_addr = start;
+				filters->filter[i].type = ETM_ADDR_TYPE_START;
+			} else {
+				filters->filter[i].stop_addr = stop;
+				filters->filter[i].type = ETM_ADDR_TYPE_STOP;
+			}
+		}
+		i++;
+	}
+
+	filters->nr_filters = i;
+}
+
 int etm_perf_symlink(struct coresight_device *csdev, bool link)
 {
 	char entry[sizeof("cpu9999999")];
@@ -485,21 +597,23 @@ static int __init etm_perf_init(void)
 {
 	int ret;
 
-	etm_pmu.capabilities	= PERF_PMU_CAP_EXCLUSIVE;
-
-	etm_pmu.attr_groups	= etm_pmu_attr_groups;
-	etm_pmu.task_ctx_nr	= perf_sw_context;
-	etm_pmu.read		= etm_event_read;
-	etm_pmu.event_init	= etm_event_init;
-	etm_pmu.setup_aux	= etm_setup_aux;
-	etm_pmu.free_aux	= etm_free_aux;
-	etm_pmu.start		= etm_event_start;
-	etm_pmu.stop		= etm_event_stop;
-	etm_pmu.add		= etm_event_add;
-	etm_pmu.del		= etm_event_del;
-	etm_pmu.get_drv_configs	= etm_get_drv_configs;
-	etm_pmu.free_drv_configs
-				= etm_free_drv_configs;
+	etm_pmu.capabilities		= PERF_PMU_CAP_EXCLUSIVE;
+
+	etm_pmu.attr_groups		= etm_pmu_attr_groups;
+	etm_pmu.task_ctx_nr		= perf_sw_context;
+	etm_pmu.read			= etm_event_read;
+	etm_pmu.event_init		= etm_event_init;
+	etm_pmu.setup_aux		= etm_setup_aux;
+	etm_pmu.free_aux		= etm_free_aux;
+	etm_pmu.start			= etm_event_start;
+	etm_pmu.stop			= etm_event_stop;
+	etm_pmu.add			= etm_event_add;
+	etm_pmu.del			= etm_event_del;
+	etm_pmu.get_drv_configs		= etm_get_drv_configs;
+	etm_pmu.free_drv_configs	= etm_free_drv_configs;
+	etm_pmu.addr_filters_sync	= etm_addr_filters_sync;
+	etm_pmu.addr_filters_validate	= etm_addr_filters_validate;
+	etm_pmu.nr_addr_filters		= ETM_ADDR_CMP_MAX;
 
 	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
 	if (ret == 0)
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 87f5a134eb6f..28be38a9be60 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -20,6 +20,38 @@
 
 struct coresight_device;
 
+/*
+ * In both ETMv3 and v4 the maximum number of address comparator implentable
+ * is 8.  The actual number is implementation specific and will be checked
+ * when filters are applied.
+ */
+#define ETM_ADDR_CMP_MAX	8
+
+/**
+ * struct etm_filter - single instruction range or start/stop configuration.
+ * @start_addr:	The address to start tracing on.
+ * @stop_addr:	The address to stop tracing on.
+ * @type:	Is this a range or start/stop filter.
+ */
+struct etm_filter {
+	unsigned long start_addr;
+	unsigned long stop_addr;
+	enum etm_addr_type type;
+};
+
+/**
+ * struct etm_filters - set of filters for a session
+ * @etm_filter:	All the filters for this session.
+ * @nr_filters:	Number of filters
+ * @ssstatus:	Status of the start/stop logic.
+ */
+struct etm_filters {
+	struct etm_filter	filter[ETM_ADDR_CMP_MAX];
+	unsigned int		nr_filters;
+	bool			ssstatus;
+};
+
+
 #ifdef CONFIG_CORESIGHT
 int etm_perf_symlink(struct coresight_device *csdev, bool link);
 
-- 
2.7.4
