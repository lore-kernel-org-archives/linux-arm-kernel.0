From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:29 -0400
Subject: [PATCH 8/8] arm64:perf: L3 cache(LLC) event listing in perf
In-Reply-To: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1467107429-55477-9-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Add L3 caches events to /sys/devices/hisi_l3c/events/
	   The events can be selected as shown in perf list
	   e.g.: For LLC_READ_ALLOCATE event for Super CPU cluster 2 the
		 event format is
		 -e "hisi_l3c/l3c_read_allocate,bank=0xf,cluster=0x2/"

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/hisi_uncore_llc.c | 75 +++++++++++++++++++++++++++++++-
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 12 +++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 16 +++++++
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_llc.c b/drivers/perf/hisilicon/hisi_uncore_llc.c
index a771e1a..316167a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_llc.c
+++ b/drivers/perf/hisilicon/hisi_uncore_llc.c
@@ -25,11 +25,11 @@
 #include "hisi_uncore_llc.h"
 
 /* Map cfg_en values for LLC Banks */
-const int llc_cfgen_map[] = { HISI_LLC_BANK0_CFGEN, HISI_LLC_BANK1_CFGEN,
+static const int llc_cfgen_map[] = { HISI_LLC_BANK0_CFGEN, HISI_LLC_BANK1_CFGEN,
 				HISI_LLC_BANK2_CFGEN, HISI_LLC_BANK3_CFGEN
 };
 
-struct hisi_pmu *hisi_uncore_llc;
+static struct hisi_pmu *hisi_uncore_llc;
 
 static inline int hisi_llc_counter_valid(int idx)
 {
@@ -442,6 +442,76 @@ static void hisi_free_llc_data(struct hisi_hwmod_unit *punit)
 	kfree(punit->hwmod_data);
 }
 
+PMU_FORMAT_ATTR(event, "config:0-11");
+PMU_FORMAT_ATTR(bank, "config:12-15");
+PMU_FORMAT_ATTR(module, "config:16-19");
+PMU_FORMAT_ATTR(cluster, "config:20-23");
+PMU_FORMAT_ATTR(socket, "config:24-25");
+
+#define HISI_UNCORE_EVENT_DESC(_name, _config)			\
+{								\
+	.attr   = __ATTR(_name, 0444, uncore_event_show, NULL), \
+	.config = _config,					\
+}
+
+static struct attribute *hisi_llc_format_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_bank.attr,
+	&format_attr_module.attr,
+	&format_attr_cluster.attr,
+	&format_attr_socket.attr,
+	NULL,
+};
+
+static struct attribute_group hisi_llc_format_group = {
+	.name = "format",
+	.attrs = hisi_llc_format_attr,
+};
+
+EVENT_ATTR_STR(l3c_read_allocate,
+			"event=0x301,bank=?,module=0x4,cluster=?,socket=0x1");
+EVENT_ATTR_STR(l3c_write_allocate,
+			"event=0x302,bank=?,module=0x4,cluster=?,socket=0x1");
+EVENT_ATTR_STR(l3c_read_noallocate,
+			"event=0x303,bank=?,module=0x4,cluster=?,socket=0x1");
+EVENT_ATTR_STR(l3c_write_noallocate,
+			"event=0x304,bank=?,module=0x4,cluster=?,socket=0x1");
+EVENT_ATTR_STR(l3c_read_hit,
+			"event=0x305,bank=?,module=0x4,cluster=?,socket=0x1");
+EVENT_ATTR_STR(l3c_write_hit,
+			"event=0x306,bank=?,module=0x4,cluster=?,socket=0x1");
+
+
+static struct attribute *hisi_llc_events_attr[] = {
+	EVENT_PTR(l3c_read_allocate),
+	EVENT_PTR(l3c_write_allocate),
+	EVENT_PTR(l3c_read_noallocate),
+	EVENT_PTR(l3c_write_noallocate),
+	EVENT_PTR(l3c_read_hit),
+	EVENT_PTR(l3c_write_hit),
+	NULL,
+};
+
+static struct attribute_group hisi_llc_events_group = {
+	.name = "events",
+	.attrs = hisi_llc_events_attr,
+};
+
+static struct attribute *hisi_llc_attrs[] = {
+	NULL,
+};
+
+struct attribute_group hisi_llc_attr_group = {
+	.attrs = hisi_llc_attrs,
+};
+
+static const struct attribute_group *hisi_llc_pmu_attr_groups[] = {
+	&hisi_llc_attr_group,
+	&hisi_llc_format_group,
+	&hisi_llc_events_group,
+	NULL
+};
+
 void hisi_llc_pmu_init(struct platform_device *pdev,
 					struct hisi_pmu *pllc_pmu)
 {
@@ -489,6 +559,7 @@ static int hisi_pmu_llc_dev_probe(struct platform_device *pdev)
 				.start = hisi_uncore_pmu_start,
 				.stop = hisi_uncore_pmu_stop,
 				.read = hisi_uncore_pmu_read,
+				.attr_groups = hisi_llc_pmu_attr_groups,
 		};
 
 		ret = hisi_uncore_pmu_setup(pllc_pmu, pdev, "hisi_l3c");
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index e02cb81..5f404a6 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -26,6 +26,18 @@
 #include "hisi_uncore_pmu.h"
 #include "hisi_uncore_llc.h"
 
+ssize_t hisi_events_sysfs_show(struct device *dev,
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
index dfc8c83..4bc60e0 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -46,6 +46,20 @@
 #define MAX_COUNTERS 30
 #define MAX_UNITS 8
 
+#define EVENT_PTR(_id) (&event_attr_##_id.attr.attr)
+
+#define EVENT_ATTR(_name, _val)						   \
+static struct perf_pmu_events_attr event_attr_##_name = {		   \
+	.attr	   = __ATTR(_name, 0444, hisi_events_sysfs_show, NULL),	   \
+	.event_str = "event=" __stringify(_val),			   \
+}
+
+#define EVENT_ATTR_STR(_name, _str)					   \
+static struct perf_pmu_events_attr event_attr_##_name = {		   \
+	.attr	   = __ATTR(_name, 0444, hisi_events_sysfs_show, NULL),    \
+	.event_str = _str,						   \
+}
+
 enum hisi_hwmod_type {
 	HISI_LLC = 0x0,
 };
@@ -125,4 +139,6 @@ int hisi_pmu_unit_init(struct platform_device *,
 				struct hisi_hwmod_unit *,
 						int, int);
 struct hisi_pmu *hisi_pmu_alloc(struct platform_device *);
+ssize_t hisi_events_sysfs_show(struct device *,
+				  struct device_attribute *, char *);
 #endif /* __HISI_UNCORE_PMU_H__ */
-- 
2.1.4
