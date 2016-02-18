From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 17 Feb 2016 17:52:01 -0700
Subject: [PATCH 19/21] coresight: etm-perf: new PMU driver for ETM tracers
In-Reply-To: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
References: <1455756723-8456-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1455756723-8456-20-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Perf is a well known and used tool for performance monitoring
and much more. A such it is an ideal candidate for integration
with coresight based HW tracing.

This patch introduces a PMU that represent a coresight tracer to
the Perf core.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Makefile             |   3 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c | 393 +++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm-perf.h |  32 ++
 drivers/hwtracing/coresight/coresight-etm3x.c    |   7 +
 include/linux/coresight-pmu.h                    |  27 ++
 5 files changed, 461 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.c
 create mode 100644 drivers/hwtracing/coresight/coresight-etm-perf.h
 create mode 100644 include/linux/coresight-pmu.h

diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 233d66cf22d3..cf8c6d689747 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CORESIGHT_SINK_ETBV10) += coresight-etb10.o
 obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
 					   coresight-replicator.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o coresight-etm-cp14.o \
-					coresight-etm3x-sysfs.o
+					coresight-etm3x-sysfs.o \
+					coresight-etm-perf.o
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o
 obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
new file mode 100644
index 000000000000..36153a77e982
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -0,0 +1,393 @@
+/*
+ * Copyright(C) 2015 Linaro Limited. All rights reserved.
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/coresight.h>
+#include <linux/coresight-pmu.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include "coresight-priv.h"
+
+static struct pmu etm_pmu;
+static bool etm_perf_up;
+
+/**
+ * struct etm_event_data - Coresight specifics associated to an event
+ * @work:		Handle to free allocated memory outside IRQ context.
+ * @mask:		Hold the CPU(s) this event was set for.
+ * @snk_config:		The sink configuration.
+ * @path:		An array of path, each slot for one CPU.
+ */
+struct etm_event_data {
+	struct work_struct work;
+	cpumask_t mask;
+	void *snk_config;
+	struct list_head **path;
+};
+
+static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
+static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
+
+/* ETMv3.5/PTM's ETMCR is 'config' */
+PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
+PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
+
+static struct attribute *etm_config_formats_attr[] = {
+	&format_attr_cycacc.attr,
+	&format_attr_timestamp.attr,
+	NULL,
+};
+
+static struct attribute_group etm_pmu_format_group = {
+	.name   = "format",
+	.attrs  = etm_config_formats_attr,
+};
+
+static const struct attribute_group *etm_pmu_attr_groups[] = {
+	&etm_pmu_format_group,
+	NULL,
+};
+
+static void etm_event_read(struct perf_event *event) {}
+
+static int etm_event_init(struct perf_event *event)
+{
+	if (event->attr.type != etm_pmu.type)
+		return -ENOENT;
+
+	return 0;
+}
+
+static void free_event_data(struct work_struct *work)
+{
+	int cpu;
+	cpumask_t *mask;
+	struct etm_event_data *event_data;
+	struct coresight_device *sink;
+
+	event_data = container_of(work, struct etm_event_data, work);
+	mask = &event_data->mask;
+	/*
+	 * First deal with the sink configuration.  See comment in
+	 * etm_setup_aux() about why we take the first available path.
+	 */
+	if (event_data->snk_config) {
+		cpu = cpumask_first(mask);
+		sink = coresight_get_sink(event_data->path[cpu]);
+		if (sink_ops(sink)->free_buffer)
+			sink_ops(sink)->free_buffer(event_data->snk_config);
+	}
+
+	for_each_cpu(cpu, mask) {
+		if (event_data->path[cpu])
+			coresight_release_path(event_data->path[cpu]);
+	}
+
+	kfree(event_data->path);
+	kfree(event_data);
+}
+
+static void *alloc_event_data(int cpu)
+{
+	int size;
+	cpumask_t *mask;
+	struct etm_event_data *event_data;
+
+	/* First get memory for the session's data */
+	event_data = kzalloc(sizeof(struct etm_event_data), GFP_KERNEL);
+	if (!event_data)
+		return NULL;
+
+	/* Make sure nothing disappears under us */
+	get_online_cpus();
+	size = num_online_cpus();
+
+	mask = &event_data->mask;
+	if (cpu != -1)
+		cpumask_set_cpu(cpu, mask);
+	else
+		cpumask_copy(mask, cpu_online_mask);
+	put_online_cpus();
+
+	/*
+	 * Each CPU has a single path between source and destination.  As such
+	 * allocate an array using CPU numbers as indexes.  That way a path
+	 * for any CPU can easily be accessed at any given time.  We proceed
+	 * the same way for sessions involving a single CPU.  The cost of
+	 * unused memory when dealing with single CPU trace scenarios is small
+	 * compared to the cost of searching through an optimized array.
+	 */
+	event_data->path = kcalloc(size,
+				   sizeof(struct list_head *), GFP_KERNEL);
+	if (!event_data->path) {
+		kfree(event_data);
+		return NULL;
+	}
+
+	return event_data;
+}
+
+static void etm_free_aux(void *data)
+{
+	struct etm_event_data *event_data = data;
+
+	schedule_work(&event_data->work);
+}
+
+static void *etm_setup_aux(int event_cpu, void **pages,
+			   int nr_pages, bool overwrite)
+{
+	int cpu;
+	cpumask_t *mask;
+	struct coresight_device *sink;
+	struct etm_event_data *event_data = NULL;
+
+	event_data = alloc_event_data(event_cpu);
+	if (!event_data)
+		return NULL;
+
+	INIT_WORK(&event_data->work, free_event_data);
+
+	mask = &event_data->mask;
+
+	/* Setup the path for each CPU in a trace session */
+	for_each_cpu(cpu, mask) {
+		struct coresight_device *csdev;
+
+		csdev = per_cpu(csdev_src, cpu);
+		if (!csdev)
+			goto err;
+
+		/*
+		 * Building a path doesn't enable it, it simply builds a
+		 * list of devices from source to sink that can be
+		 * referenced later when the path is actually needed.
+		 */
+		event_data->path[cpu] = coresight_build_path(csdev);
+		if (!event_data->path[cpu])
+			goto err;
+	}
+
+	/*
+	 * In theory nothing prevent tracers in a trace session from being
+	 * associated with different sinks, nor having a sink per tracer.  But
+	 * until we have HW with this kind of topology and a way to convey
+	 * sink assignement from the perf cmd line we need to assume tracers
+	 * in a trace session are using the same sink.  Therefore pick the sink
+	 * found at the end of the first available path.
+	 */
+	cpu = cpumask_first(mask);
+	/* Grab the sink at the end of the path */
+	sink = coresight_get_sink(event_data->path[cpu]);
+	if (!sink)
+		goto err;
+
+	if (!sink_ops(sink)->alloc_buffer)
+		goto err;
+
+	/* Get the AUX specific data from the sink buffer */
+	event_data->snk_config =
+			sink_ops(sink)->alloc_buffer(sink, cpu, pages,
+						     nr_pages, overwrite);
+	if (!event_data->snk_config)
+		goto err;
+
+out:
+	return event_data;
+
+err:
+	etm_free_aux(event_data);
+	event_data = NULL;
+	goto out;
+}
+
+static void etm_event_start(struct perf_event *event, int flags)
+{
+	int cpu = smp_processor_id();
+	struct etm_event_data *event_data;
+	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
+	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
+
+	if (!csdev)
+		goto fail;
+
+	/*
+	 * Deal with the ring buffer API and get a handle on the
+	 * session's information.
+	 */
+	event_data = perf_aux_output_begin(handle, event);
+	if (!event_data)
+		goto fail;
+
+	/* We need a sink, no need to continue without one */
+	sink = coresight_get_sink(event_data->path[cpu]);
+	if (WARN_ON_ONCE(!sink || !sink_ops(sink)->set_buffer))
+		goto fail_end_stop;
+
+	/* Configure the sink */
+	if (sink_ops(sink)->set_buffer(sink, handle,
+				       event_data->snk_config))
+		goto fail_end_stop;
+
+	/* Nothing will happen without a path */
+	if (coresight_enable_path(event_data->path[cpu], CS_MODE_PERF))
+		goto fail_end_stop;
+
+	/* Tell the perf core the event is alive */
+	event->hw.state = 0;
+
+	/* Finally enable the tracer */
+	if (source_ops(csdev)->enable(csdev, &event->attr, CS_MODE_PERF))
+		goto fail_end_stop;
+
+out:
+	return;
+
+fail_end_stop:
+	perf_aux_output_end(handle, 0, true);
+fail:
+	event->hw.state = PERF_HES_STOPPED;
+	goto out;
+}
+
+static void etm_event_stop(struct perf_event *event, int mode)
+{
+	bool lost;
+	int cpu = smp_processor_id();
+	unsigned long size;
+	struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
+	struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
+	struct etm_event_data *event_data = perf_get_aux(handle);
+
+	if (event->hw.state == PERF_HES_STOPPED)
+		return;
+
+	if (!csdev)
+		return;
+
+	sink = coresight_get_sink(event_data->path[cpu]);
+	if (!sink)
+		return;
+
+	/* stop tracer */
+	source_ops(csdev)->disable(csdev);
+
+	/* tell the core */
+	event->hw.state = PERF_HES_STOPPED;
+
+	if (mode & PERF_EF_UPDATE) {
+		if (WARN_ON_ONCE(handle->event != event))
+			return;
+
+		/* update trace information */
+		if (!sink_ops(sink)->update_buffer)
+			return;
+
+		sink_ops(sink)->update_buffer(sink, handle,
+					      event_data->snk_config);
+
+		if (!sink_ops(sink)->reset_buffer)
+			return;
+
+		size = sink_ops(sink)->reset_buffer(sink, handle,
+						    event_data->snk_config,
+						    &lost);
+
+		perf_aux_output_end(handle, size, lost);
+	}
+
+	/* Disabling the path make its elements available to other sessions */
+	coresight_disable_path(event_data->path[cpu]);
+}
+
+static int etm_event_add(struct perf_event *event, int mode)
+{
+	int ret = 0;
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (mode & PERF_EF_START) {
+		etm_event_start(event, 0);
+		if (hwc->state & PERF_HES_STOPPED)
+			ret = -EINVAL;
+	} else {
+		hwc->state = PERF_HES_STOPPED;
+	}
+
+	return ret;
+}
+
+static void etm_event_del(struct perf_event *event, int mode)
+{
+	etm_event_stop(event, PERF_EF_UPDATE);
+}
+
+int etm_perf_symlink(struct coresight_device *csdev, bool link)
+{
+	char entry[sizeof("cpu9999999")];
+	int ret = 0, cpu = source_ops(csdev)->cpu_id(csdev);
+	struct device *pmu_dev = etm_pmu.dev;
+	struct device *cs_dev = &csdev->dev;
+
+	sprintf(entry, "cpu%d", cpu);
+
+	if (!etm_perf_up)
+		return -EPROBE_DEFER;
+
+	if (link) {
+		ret = sysfs_create_link(&pmu_dev->kobj, &cs_dev->kobj, entry);
+		if (ret)
+			return ret;
+		per_cpu(csdev_src, cpu) = csdev;
+	} else {
+		sysfs_remove_link(&pmu_dev->kobj, entry);
+		per_cpu(csdev_src, cpu) = NULL;
+	}
+
+	return 0;
+}
+
+static int __init etm_perf_init(void)
+{
+	int ret;
+
+	etm_pmu.capabilities	= PERF_PMU_CAP_EXCLUSIVE;
+
+	etm_pmu.attr_groups	= etm_pmu_attr_groups;
+	etm_pmu.task_ctx_nr	= perf_sw_context;
+	etm_pmu.read		= etm_event_read;
+	etm_pmu.event_init	= etm_event_init;
+	etm_pmu.setup_aux	= etm_setup_aux;
+	etm_pmu.free_aux	= etm_free_aux;
+	etm_pmu.start		= etm_event_start;
+	etm_pmu.stop		= etm_event_stop;
+	etm_pmu.add		= etm_event_add;
+	etm_pmu.del		= etm_event_del;
+
+	ret = perf_pmu_register(&etm_pmu, CORESIGHT_ETM_PMU_NAME, -1);
+	if (ret == 0)
+		etm_perf_up = true;
+
+	return ret;
+}
+module_init(etm_perf_init);
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
new file mode 100644
index 000000000000..87f5a134eb6f
--- /dev/null
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright(C) 2015 Linaro Limited. All rights reserved.
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _CORESIGHT_ETM_PERF_H
+#define _CORESIGHT_ETM_PERF_H
+
+struct coresight_device;
+
+#ifdef CONFIG_CORESIGHT
+int etm_perf_symlink(struct coresight_device *csdev, bool link);
+
+#else
+static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
+{ return -EINVAL; }
+
+#endif /* CONFIG_CORESIGHT */
+
+#endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index a9b820ec16aa..77b37413803f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -35,6 +35,7 @@
 #include <asm/sections.h>
 
 #include "coresight-etm.h"
+#include "coresight-etm-perf.h"
 
 static int boot_enable;
 module_param_named(boot_enable, boot_enable, int, S_IRUGO);
@@ -827,6 +828,12 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_arch_supported;
 	}
 
+	ret = etm_perf_symlink(drvdata->csdev, true);
+	if (ret) {
+		coresight_unregister(drvdata->csdev);
+		goto err_arch_supported;
+	}
+
 	pm_runtime_put(&adev->dev);
 	dev_info(dev, "%s initialized\n", (char *)id->data);
 
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
new file mode 100644
index 000000000000..6c5386b23b10
--- /dev/null
+++ b/include/linux/coresight-pmu.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright(C) 2015 Linaro Limited. All rights reserved.
+ * Author: Mathieu Poirier <mathieu.poirier@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef _LINUX_CORESIGHT_PMU_H
+#define _LINUX_CORESIGHT_PMU_H
+
+#define CORESIGHT_ETM_PMU_NAME "cs_etm"
+
+/* ETMv3.5/PTM's ETMCR config bit */
+#define ETM_OPT_CYCACC  12
+#define ETM_OPT_TS      28
+
+#endif
-- 
2.1.4
