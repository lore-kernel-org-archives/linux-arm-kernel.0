From: anurupvasu@gmail.com (Anurup M)
Date: Wed,  3 Aug 2016 02:34:38 -0400
Subject: [RFC PATCH v1 09/10] arm64:perf: L3 cache(LLC) event listing in perf
In-Reply-To: <1470206079-73280-1-git-send-email-anurup.m@huawei.com>
References: <1470206079-73280-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1470206079-73280-10-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Add L3 caches events to /sys/devices/hisi_l3c/events/
	   The events can be selected as shown in perf list
	   e.g.: For L3C_READ_ALLOCATE event for Super CPU cluster 2 the
		 event format is
		 -e "hisi_l3c/l3c_read_allocate,bank=0xf,cpu_die=0x2/"

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c.c | 50 ++++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 28 ++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 20 +++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c.c b/drivers/perf/hisilicon/hisi_uncore_l3c.c
index e606cc4..1c5e8d9 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c.c
@@ -411,6 +411,55 @@ static void hisi_free_l3c_data(struct hisi_hwmod_unit *punit)
 	kfree(punit->hwmod_data);
 }
 
+static struct attribute *hisi_l3c_format_attr[] = {
+	HISI_PMU_FORMAT_ATTR(event, "config:0-11"),
+	HISI_PMU_FORMAT_ATTR(bank, "config:12-15"),
+	HISI_PMU_FORMAT_ATTR(cpu_cluster, "config:16-19"),
+	HISI_PMU_FORMAT_ATTR(cpu_die, "config:20-23"),
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
+			"event=0x301,bank=?,cpu_die=?"),
+	HISI_PMU_EVENT_ATTR_STR(write_allocate,
+			"event=0x302,bank=?,cpu_die=?"),
+	HISI_PMU_EVENT_ATTR_STR(read_noallocate,
+			"event=0x303,bank=?,cpu_die=?"),
+	HISI_PMU_EVENT_ATTR_STR(write_noallocate,
+			"event=0x304,bank=?,cpu_die=?"),
+	HISI_PMU_EVENT_ATTR_STR(read_hit,
+			"event=0x305,bank=?,cpu_die=?"),
+	HISI_PMU_EVENT_ATTR_STR(write_hit,
+			"event=0x306,bank=?,cpu_die=?"),
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
+static const struct attribute_group *hisi_l3c_pmu_attr_groups[] = {
+	&hisi_l3c_attr_group,
+	&hisi_l3c_format_group,
+	&hisi_l3c_events_group,
+	NULL
+};
+
 void hisi_l3c_pmu_init(struct platform_device *pdev,
 					struct hisi_pmu *pl3c_pmu)
 {
@@ -458,6 +507,7 @@ static int hisi_pmu_l3c_dev_probe(struct platform_device *pdev)
 				.start = hisi_uncore_pmu_start,
 				.stop = hisi_uncore_pmu_stop,
 				.read = hisi_uncore_pmu_read,
+				.attr_groups = hisi_l3c_pmu_attr_groups,
 		};
 
 		ret = hisi_uncore_pmu_setup(pl3c_pmu, pdev, "hip05_l3c");
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index d0dffc3..4c81477 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -27,6 +27,34 @@
 #include "hisi_uncore_l3c.h"
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
+				  struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr =
+		container_of(attr, struct perf_pmu_events_attr, attr);
+
+	if (pmu_attr->event_str)
+		return sprintf(page, "%s", pmu_attr->event_str);
+
+	return 0;
+}
+
 /* djtag read interface - Call djtag driver to access SoC registers */
 int hisi_djtag_readreg(int module_id, int bank, u32 offset,
 				struct device_node *djtag_node, u32 *pvalue)
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 75ef282..e93690d 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -56,6 +56,22 @@
 	(((event_code & HISI_SCCL_MASK) >>	\
 			   HISI_SCCL_SHIFT) - 1)
 
+#define HISI_PMU_FORMAT_ATTR(_name, _config)		\
+	(&((struct dev_ext_attribute[]) {		\
+		{ .attr = __ATTR(_name, S_IRUGO,	\
+			hisi_format_sysfs_show, NULL),	\
+		  .var = (void *) _config,		\
+		}					\
+	})[0].attr.attr)
+
+#define HISI_PMU_EVENT_ATTR_STR(_name, _str)		\
+	(&((struct perf_pmu_events_attr[]) {		\
+		{ .attr = __ATTR(_name, S_IRUGO,	\
+			 hisi_event_sysfs_show, NULL),	\
+		  .event_str = _str,			\
+		}					\
+	  })[0].attr.attr)
+
 enum hisi_hwmod_type {
 	HISI_L3C = 0x0,
 };
@@ -125,4 +141,8 @@ int hisi_pmu_unit_init(struct platform_device *,
 				struct hisi_hwmod_unit *,
 						int, int);
 struct hisi_pmu *hisi_pmu_alloc(struct platform_device *);
+ssize_t hisi_event_sysfs_show(struct device *,
+				  struct device_attribute *, char *);
+ssize_t hisi_format_sysfs_show(struct device *,
+				  struct device_attribute *, char *);
 #endif /* __HISI_UNCORE_PMU_H__ */
-- 
2.1.4
