From: anurupvasu@gmail.com (Anurup M)
Date: Thu,  3 Nov 2016 01:42:04 -0400
Subject: [RESEND PATCH v1 08/11] perf: hisi: Add sysfs attributes for L3
 cache(L3C) PMU
In-Reply-To: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
References: <1478151727-20250-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1478151727-20250-9-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Add L3 caches events to /sys/devices/hisi_l3c2/events/
	  The events can be selected as shown in perf list
	  e.g.: For L3C_READ_ALLOCATE event for Super CPU cluster 2 the
	  event format is
	    -e "hisi_l3c2/read_allocate/"
	2. Add cpu_mask attribute group for showing the available CPU
	   for counting.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c.c | 57 ++++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 40 ++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 22 ++++++++++++
 3 files changed, 119 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c.c b/drivers/perf/hisilicon/hisi_uncore_l3c.c
index f78f7b2..428fba0 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c.c
@@ -436,6 +436,62 @@ static int init_hisi_l3c_data(struct device *dev,
 	return ret;
 }
 
+static struct attribute *hisi_l3c_format_attr[] = {
+	HISI_PMU_FORMAT_ATTR(event, "config:0-11"),
+	NULL,
+};
+
+static struct attribute_group hisi_l3c_format_group = {
+	.name = "format",
+	.attrs = hisi_l3c_format_attr,
+};
+
+static struct attribute *hisi_l3c_events_attr[] = {
+	HISI_PMU_EVENT_ATTR_STR(read_allocate,
+					"event=0x0"),
+	HISI_PMU_EVENT_ATTR_STR(write_allocate,
+					"event=0x01"),
+	HISI_PMU_EVENT_ATTR_STR(read_noallocate,
+					"event=0x02"),
+	HISI_PMU_EVENT_ATTR_STR(write_noallocate,
+					"event=0x03"),
+	HISI_PMU_EVENT_ATTR_STR(read_hit, "event=0x04"),
+	HISI_PMU_EVENT_ATTR_STR(write_hit, "event=0x05"),
+	NULL,
+};
+
+static struct attribute_group hisi_l3c_events_group = {
+	.name = "events",
+	.attrs = hisi_l3c_events_attr,
+};
+
+static struct attribute *hisi_l3c_attrs[] = {
+	NULL,
+};
+
+struct attribute_group hisi_l3c_attr_group = {
+	.attrs = hisi_l3c_attrs,
+};
+
+static DEVICE_ATTR(cpumask, 0444, hisi_cpumask_sysfs_show, NULL);
+
+static struct attribute *hisi_l3c_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static const struct attribute_group hisi_l3c_cpumask_attr_group = {
+	.attrs = hisi_l3c_cpumask_attrs,
+};
+
+static const struct attribute_group *hisi_l3c_pmu_attr_groups[] = {
+	&hisi_l3c_attr_group,
+	&hisi_l3c_format_group,
+	&hisi_l3c_events_group,
+	&hisi_l3c_cpumask_attr_group,
+	NULL,
+};
+
 static struct hisi_uncore_ops hisi_uncore_l3c_ops = {
 	.set_evtype = hisi_set_l3c_evtype,
 	.set_event_period = hisi_pmu_set_event_period,
@@ -496,6 +552,7 @@ static int hisi_pmu_l3c_dev_probe(struct hisi_djtag_client *client)
 		.start = hisi_uncore_pmu_start,
 		.stop = hisi_uncore_pmu_stop,
 		.read = hisi_uncore_pmu_read,
+		.attr_groups = hisi_l3c_pmu_attr_groups,
 	};
 
 	ret = hisi_uncore_pmu_setup(pl3c_pmu, pl3c_pmu->name);
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 8d29fcc..d0a911a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -26,6 +26,46 @@
 #include <linux/perf_event.h>
 #include "hisi_uncore_pmu.h"
 
+/*
+ * PMU format attributes
+ */
+ssize_t hisi_format_sysfs_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute,
+					     attr);
+	return sprintf(buf, "%s\n", (char *) eattr->var);
+}
+
+/*
+ * PMU event attributes
+ */
+ssize_t hisi_event_sysfs_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	if (pmu_attr->event_str)
+		return sprintf(buf, "%s", pmu_attr->event_str);
+
+	return 0;
+}
+
+/*
+ * sysfs cpumask attributes
+ */
+ssize_t hisi_cpumask_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
+
+	return cpumap_print_to_pagebuf(true, buf, &hisi_pmu->cpu);
+}
+
 /* djtag read interface - Call djtag driver to access SoC registers */
 int hisi_djtag_readreg(int module_id, int bank, u32 offset,
 				struct hisi_djtag_client *client, u32 *pvalue)
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index b6b16df..a948752 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -51,6 +51,22 @@
 	(((event_code & HISI_SCCL_MASK) >>	\
 			   HISI_SCCL_SHIFT) - 1)
 
+#define HISI_PMU_FORMAT_ATTR(_name, _config)		\
+	(&((struct dev_ext_attribute[]) {		\
+		{ .attr = __ATTR(_name, 0444,	\
+			hisi_format_sysfs_show, NULL),	\
+		  .var = (void *) _config,		\
+		}					\
+	})[0].attr.attr)
+
+#define HISI_PMU_EVENT_ATTR_STR(_name, _str)		\
+	(&((struct perf_pmu_events_attr[]) {		\
+		{ .attr = __ATTR(_name, 0444,	\
+			 hisi_event_sysfs_show, NULL),	\
+		  .event_str = _str,			\
+		}					\
+	  })[0].attr.attr)
+
 struct hisi_pmu;
 
 struct hisi_uncore_ops {
@@ -105,4 +121,10 @@ int hisi_djtag_writereg(int module_id, int bank,
 struct hisi_pmu *hisi_pmu_alloc(struct device *dev);
 int hisi_uncore_common_fwprop_read(struct device *dev,
 					struct hisi_pmu *phisi_pmu);
+ssize_t hisi_event_sysfs_show(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+ssize_t hisi_format_sysfs_show(struct device *dev,
+				  struct device_attribute *attr, char *buf);
+ssize_t hisi_cpumask_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *buf);
 #endif /* __HISI_UNCORE_PMU_H__ */
-- 
2.1.4
