From: anurupvasu@gmail.com (Anurup M)
Date: Thu,  2 Mar 2017 05:50:00 -0500
Subject: [PATCH v5 10/11] drivers: perf: hisi: use poll method when no IRQ for
 MN counter overflow
Message-ID: <1488451800-89077-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When no IRQ is supported in hardware, use hrtimer to poll and
update event counter and avoid overflow condition for MN PMU.
An interval of 8 seconds is used for the hrtimer.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Dikshit N <dikshit.n@huawei.com>
---
 drivers/perf/hisilicon/hisi_uncore_mn.c | 39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/perf/hisilicon/hisi_uncore_mn.c b/drivers/perf/hisilicon/hisi_uncore_mn.c
index 9a09798..375996a 100644
--- a/drivers/perf/hisilicon/hisi_uncore_mn.c
+++ b/drivers/perf/hisilicon/hisi_uncore_mn.c
@@ -20,6 +20,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 #include <linux/bitmap.h>
+#include <linux/hrtimer.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -56,6 +58,15 @@ enum armv8_hisi_mn_counters {
 
 #define GET_MODULE_ID(hwmod_data) hwmod_data->mn_hwcfg.module_id
 
+/*
+ * Default timer frequency to poll and avoid counter overflow.
+ * CPU speed = 2.4Ghz and number of CPU cores in a SCCL is 16.
+ * For a single MN event on a CPU core consumes 200 cycles.
+ * So overflow time = (2^31 * 200) / (16 * 2.4G) which is about 21 seconds
+ * So on a safe side we use a timer interval of 8sec
+ */
+#define MN1_HRTIMER_INTERVAL (8LL * MSEC_PER_SEC)
+
 struct hisi_mn_hwcfg {
 	u32 module_id;
 };
@@ -272,6 +283,15 @@ static const struct of_device_id mn_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, mn_of_match);
 
+/* Use hrtimer when no IRQ, to poll for avoiding counter overflow */
+static void hisi_mn_hrtimer_init(struct hisi_pmu *mn_pmu)
+{
+	INIT_LIST_HEAD(&mn_pmu->active_list);
+	mn_pmu->ops->start_hrtimer = hisi_hrtimer_start;
+	mn_pmu->ops->stop_hrtimer = hisi_hrtimer_stop;
+	hisi_hrtimer_init(mn_pmu, MN1_HRTIMER_INTERVAL);
+}
+
 static int hisi_mn_init_data(struct hisi_pmu *mn_pmu,
 			     struct hisi_djtag_client *client)
 {
@@ -314,6 +334,12 @@ static int hisi_mn_init_data(struct hisi_pmu *mn_pmu,
 	} else
 		return -EINVAL;
 
+	/*
+	 * Use poll method to avoid counter overflow as
+	 * overflow IRQ is not supported in hardware.
+	 */
+	hisi_mn_hrtimer_init(mn_pmu);
+
 	return 0;
 }
 
@@ -361,11 +387,24 @@ static const struct attribute_group hisi_mn_cpumask_attr_group = {
 	.attrs = hisi_mn_cpumask_attrs,
 };
 
+static DEVICE_ATTR(hrtimer_interval, 0444, hisi_hrtimer_interval_sysfs_show,
+		   NULL);
+
+static struct attribute *hisi_mn_hrtimer_interval_attrs[] = {
+	&dev_attr_hrtimer_interval.attr,
+	NULL,
+};
+
+static const struct attribute_group hisi_mn_hrtimer_interval_attr_group = {
+	.attrs = hisi_mn_hrtimer_interval_attrs,
+};
+
 static const struct attribute_group *hisi_mn_pmu_attr_groups[] = {
 	&hisi_mn_attr_group,
 	&hisi_mn_format_group,
 	&hisi_mn_events_group,
 	&hisi_mn_cpumask_attr_group,
+	&hisi_mn_hrtimer_interval_attr_group,
 	NULL,
 };
 
-- 
2.1.4
