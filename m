From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 10 Mar 2017 01:28:45 -0500
Subject: [PATCH v6 08/11] drivers: perf: hisi: use poll method to avoid L3C
 counter overflow
Message-ID: <1489127325-112821-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hrtimer support which use poll method to avoid counter overflow
when overflow IRQ is not supported in hardware.
The L3 cache PMU use N-N SPI interrupt which has no support in kernel
mainline. So use hrtimer to poll and update event counter to avoid
overflow condition for L3 cache PMU.
An interval of 10 seconds is used for the hrtimer.

Signed-off-by: Dikshit N <dikshit.n@huawei.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_l3c.c | 47 ++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 82 ++++++++++++++++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pmu.h | 17 +++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c.c b/drivers/perf/hisilicon/hisi_uncore_l3c.c
index 7f80d07..f23fbc2 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c.c
@@ -20,6 +20,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/bitmap.h>
+#include <linux/hrtimer.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -53,6 +55,22 @@ enum armv8_hisi_l3c_counters {
 #define L3C_CNT0_REG_OFF 0x170
 #define L3C_EVENT_EN 0x1000000
 
+/*
+ * Default timer frequency to poll and avoid counter overflow.
+ * CPU speed = 2.4Ghz, Therefore Access time = 0.4ns
+ * L1 cache - 2 way set associative
+ * L2  - 16 way set associative
+ * L3  - 16 way set associative. L3 cache has 4 banks.
+ *
+ * Overflow time = 2^31 * (access time L1 + access time L2 + access time L3)
+ * = 2^31 * ((2 * 0.4ns) + (16 * 0.4ns) + (4 * 16 * 0.4ns)) = 70 seconds
+ *
+ * L3 cache is also used by devices like PCIe, SAS etc. at
+ * the same time. So the overflow time could be even smaller.
+ * So on a safe side we use a timer interval of 10sec
+ */
+#define L3C_HRTIMER_INTERVAL (10LL * MSEC_PER_SEC)
+
 #define GET_MODULE_ID(hwmod_data) hwmod_data->l3c_hwcfg.module_id
 #define GET_BANK_SEL(hwmod_data) hwmod_data->l3c_hwcfg.bank_select
 
@@ -474,11 +492,24 @@ static const struct attribute_group hisi_l3c_cpumask_attr_group = {
 	.attrs = hisi_l3c_cpumask_attrs,
 };
 
+static DEVICE_ATTR(hrtimer_interval, 0444, hisi_hrtimer_interval_sysfs_show,
+		   NULL);
+
+static struct attribute *hisi_l3c_hrtimer_interval_attrs[] = {
+	&dev_attr_hrtimer_interval.attr,
+	NULL,
+};
+
+static const struct attribute_group hisi_l3c_hrtimer_interval_attr_group = {
+	.attrs = hisi_l3c_hrtimer_interval_attrs,
+};
+
 static const struct attribute_group *hisi_l3c_pmu_attr_groups[] = {
 	&hisi_l3c_attr_group,
 	&hisi_l3c_format_group,
 	&hisi_l3c_events_group,
 	&hisi_l3c_cpumask_attr_group,
+	&hisi_l3c_hrtimer_interval_attr_group,
 	NULL,
 };
 
@@ -494,6 +525,15 @@ static struct hisi_uncore_ops hisi_uncore_l3c_ops = {
 	.write_counter = hisi_l3c_write_counter,
 };
 
+/* Initialize hrtimer to poll for avoiding counter overflow */
+static void hisi_l3c_hrtimer_init(struct hisi_pmu *l3c_pmu)
+{
+	INIT_LIST_HEAD(&l3c_pmu->active_list);
+	l3c_pmu->ops->start_hrtimer = hisi_hrtimer_start;
+	l3c_pmu->ops->stop_hrtimer = hisi_hrtimer_stop;
+	hisi_hrtimer_init(l3c_pmu, L3C_HRTIMER_INTERVAL);
+}
+
 static int hisi_l3c_pmu_init(struct hisi_pmu *l3c_pmu,
 			     struct hisi_djtag_client *client)
 {
@@ -503,6 +543,7 @@ static int hisi_l3c_pmu_init(struct hisi_pmu *l3c_pmu,
 
 	l3c_pmu->num_events = HISI_HWEVENT_L3C_EVENT_MAX;
 	l3c_pmu->num_counters = HISI_IDX_L3C_COUNTER_MAX;
+	l3c_pmu->num_active = 0;
 	l3c_pmu->scl_id = hisi_djtag_get_sclid(client);
 
 	l3c_pmu->name = kasprintf(GFP_KERNEL, "hisi_l3c%u_%u",
@@ -513,6 +554,12 @@ static int hisi_l3c_pmu_init(struct hisi_pmu *l3c_pmu,
 	/* Pick one core to use for cpumask attributes */
 	cpumask_set_cpu(smp_processor_id(), &l3c_pmu->cpu);
 
+	/*
+	 * Use poll method to avoid counter overflow as overflow IRQ
+	 * is not supported in v1,v2 hardware.
+	 */
+	hisi_l3c_hrtimer_init(l3c_pmu);
+
 	return 0;
 }
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 0e7b5f1..787602b 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -65,6 +65,70 @@ ssize_t hisi_cpumask_sysfs_show(struct device *dev,
 	return cpumap_print_to_pagebuf(true, buf, &hisi_pmu->cpu);
 }
 
+/*
+ * sysfs hrtimer_interval attributes
+ */
+ssize_t hisi_hrtimer_interval_sysfs_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
+
+	if (hisi_pmu->hrt_duration)
+		return sprintf(buf, "%llu\n", hisi_pmu->hrt_duration);
+	return 0;
+}
+
+/* The counter overflow IRQ is not supported for some PMUs
+ * use hrtimer to periodically poll and avoid overflow
+ */
+static enum hrtimer_restart hisi_hrtimer_callback(struct hrtimer *hrtimer)
+{
+	struct hisi_pmu *hisi_pmu = container_of(hrtimer,
+						 struct hisi_pmu, hrtimer);
+	struct perf_event *event;
+	struct hw_perf_event *hwc;
+	unsigned long flags;
+
+	/* Return if no active events */
+	if (!hisi_pmu->num_active)
+		return HRTIMER_NORESTART;
+
+	local_irq_save(flags);
+
+	/* Update event count for each active event */
+	list_for_each_entry(event, &hisi_pmu->active_list, active_entry) {
+		hwc = &event->hw;
+		/* Read hardware counter and update the Perf event counter */
+		hisi_pmu->ops->event_update(event, hwc, GET_CNTR_IDX(hwc));
+	}
+
+	local_irq_restore(flags);
+	hrtimer_forward_now(hrtimer, ms_to_ktime(hisi_pmu->hrt_duration));
+	return HRTIMER_RESTART;
+}
+
+void hisi_hrtimer_init(struct hisi_pmu *hisi_pmu, u64 timer_interval)
+{
+	/* hr timer clock initalization */
+	hrtimer_init(&hisi_pmu->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hisi_pmu->hrtimer.function = &hisi_hrtimer_callback;
+	hisi_pmu->hrt_duration = timer_interval;
+}
+
+void hisi_hrtimer_start(struct hisi_pmu *hisi_pmu)
+{
+	hrtimer_start(&hisi_pmu->hrtimer,
+		      ms_to_ktime(hisi_pmu->hrt_duration),
+		      HRTIMER_MODE_REL_PINNED);
+}
+
+void hisi_hrtimer_stop(struct hisi_pmu *hisi_pmu)
+{
+	hrtimer_cancel(&hisi_pmu->hrtimer);
+}
+
 /* djtag read interface - Call djtag driver to access SoC registers */
 int hisi_djtag_readreg(int module_id, int bank, u32 offset,
 		       struct hisi_djtag_client *client, u32 *value)
@@ -266,6 +330,15 @@ void hisi_uncore_pmu_start(struct perf_event *event, int flags)
 					     (u32) prev_raw_count);
 	}
 
+	/* Start hrtimer when the first event is started in this PMU */
+	if (hisi_pmu->ops->start_hrtimer) {
+		hisi_pmu->num_active++;
+		list_add_tail(&event->active_entry, &hisi_pmu->active_list);
+
+		if (hisi_pmu->num_active == 1)
+			hisi_pmu->ops->start_hrtimer(hisi_pmu);
+	}
+
 	hisi_uncore_pmu_enable_event(event);
 	perf_event_update_userpage(event);
 }
@@ -279,6 +352,15 @@ void hisi_uncore_pmu_stop(struct perf_event *event, int flags)
 	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 	hwc->state |= PERF_HES_STOPPED;
 
+	/* Stop hrtimer when the last event is stopped in this PMU */
+	if (hisi_pmu->ops->stop_hrtimer) {
+		hisi_pmu->num_active--;
+		list_del(&event->active_entry);
+
+		if (hisi_pmu->num_active == 0)
+			hisi_pmu->ops->stop_hrtimer(hisi_pmu);
+	}
+
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 14b8c53..1b1f08e 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -79,13 +79,20 @@ struct hisi_uncore_ops {
 	void (*disable_counter)(struct hisi_pmu *, int);
 	void (*start_counters)(struct hisi_pmu *);
 	void (*stop_counters)(struct hisi_pmu *);
+	void (*start_hrtimer)(struct hisi_pmu *);
+	void (*stop_hrtimer)(struct hisi_pmu *);
 };
 
 /* Generic pmu struct for different pmu types */
 struct hisi_pmu {
 	const char *name;
 	struct perf_event **hw_perf_events;
+	struct list_head active_list; /* Active events list */
 	struct hisi_uncore_ops *ops;
+	struct hrtimer hrtimer; /* hrtimer to handle the
+				 * counter overflow
+				 */
+	u64 hrt_duration; /* hrtimer timeout */
 	struct device *dev;
 	void *hwmod_data; /* Hardware module specific data */
 	cpumask_t cpu;
@@ -94,6 +101,7 @@ struct hisi_pmu {
 	u32 scl_id;
 	int num_counters;
 	int num_events;
+	int num_active;
 };
 
 void hisi_uncore_pmu_read(struct perf_event *event);
@@ -113,6 +121,15 @@ ssize_t hisi_format_sysfs_show(struct device *dev,
 			       struct device_attribute *attr, char *buf);
 ssize_t hisi_cpumask_sysfs_show(struct device *dev,
 				struct device_attribute *attr, char *buf);
+ssize_t hisi_hrtimer_interval_sysfs_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf);
+ssize_t hisi_hrtimer_interval_sysfs_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count);
+void hisi_hrtimer_init(struct hisi_pmu *hisi_pmu, u64 timer_interval);
+void hisi_hrtimer_start(struct hisi_pmu *hisi_pmu);
+void hisi_hrtimer_stop(struct hisi_pmu *hisi_pmu);
 int hisi_djtag_readreg(int module_id, int bank, u32 offset,
 		       struct hisi_djtag_client *client, u32 *value);
 int hisi_djtag_writereg(int module_id, int bank, u32 offset,
-- 
2.1.4
