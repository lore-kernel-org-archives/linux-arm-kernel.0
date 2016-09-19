From: Frank.Li@nxp.com (Frank Li)
Date: Mon, 19 Sep 2016 12:57:29 -0500
Subject: [PATCH 1/1 v8] ARM: imx: Added perf functionality to mmdc driver
Message-ID: <1474307849-7341-1-git-send-email-Frank.Li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhengyu Shen <zhengyu.shen@nxp.com>

MMDC is a multi-mode DDR controller that supports DDR3/DDR3L x16/x32/x64
and LPDDR2 two channel x16/x32 memory types. MMDC is configurable, high
performance, and optimized. MMDC is present on i.MX6 Quad and i.MX6
QuadPlus devices, but this driver only supports i.MX6 Quad at the moment.
MMDC provides registers for performance counters which read via this
driver to help debug memory throughput and similar issues.

$ perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':

         898021787      mmdc/busy-cycles/
          14819600      mmdc/read-accesses/
            471.30 MB   mmdc/read-bytes/
        2815419216      mmdc/total-cycles/
          13367354      mmdc/write-accesses/
            427.76 MB   mmdc/write-bytes/

       5.334757334 seconds time elapsed

Signed-off-by: Zhengyu Shen <zhengyu.shen@nxp.com>
Signed-off-by: Frank Li <frank.li@nxp.com>
---
Changes from v7 to v8
    fix a group event check problem, should be slibling.

Changes from v6 to v7
    use mmdc_pmu prefix
    remove unnecessary check
    improve group event check according to mark's feedback.
    check pmu_mmdc->mmdc_events[cfg] at event_add
    only check == 0 at event_del

Changes from v5 to v6
    Improve group event error handle

Changes from v4 to v5
    Remove mmdc_pmu:irq
    remove static variable cpuhp_mmdc_pmu
    remove spin_lock
    check is_sampling_event(event)
    remove unnecessary cast
    use hw_perf_event::prev_count

Changes from v3 to v4:
    Tested and fixed crash relating to removing events with perf fuzzer
    Adjusted formatting
    Moved all perf event code under CONFIG_PERF_EVENTS
        Switched cpuhp_setup_state to cpuhp_setup_state_nocalls

Changes from v2 to v3:
    Use WARN_ONCE instead of returning generic error values
    Replace CPU Notifiers with newer state machine hotplug
    Added additional checks on event_init for grouping and sampling
    Remove useless mmdc_enable_profiling function
    Added comments
    Moved start index of events from 0x01 to 0x00
    Added a counter to pmu_mmdc to only stop hrtimer after all events are finished
    Replace readl_relaxed and writel_relaxed with readl and writel
    Removed duplicate update function
    Used devm_kasprintf when naming mmdcs probed

Changes from v1 to v2:
    Added cpumask and migration handling support to driver
    Validated event during event_init
    Added code to properly stop counters
    Used perf_invalid_context instead of perf_sw_context
    Added hrtimer to poll for overflow
    Added better description
    Added support for multiple mmdcs

 arch/arm/mach-imx/mmdc.c | 459 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 457 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index db9621c..d82d14c 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011,2016 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  *
  * The code contained herein is licensed under the GNU General Public
@@ -10,12 +10,16 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/hrtimer.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/perf_event.h>
+#include <linux/slab.h>
 
 #include "common.h"
 
@@ -27,8 +31,458 @@
 #define BM_MMDC_MDMISC_DDR_TYPE	0x18
 #define BP_MMDC_MDMISC_DDR_TYPE	0x3
 
+#define TOTAL_CYCLES		0x0
+#define BUSY_CYCLES		0x1
+#define READ_ACCESSES		0x2
+#define WRITE_ACCESSES		0x3
+#define READ_BYTES		0x4
+#define WRITE_BYTES		0x5
+
+/* Enables, resets, freezes, overflow profiling*/
+#define DBG_DIS			0x0
+#define DBG_EN			0x1
+#define DBG_RST			0x2
+#define PRF_FRZ			0x4
+#define CYC_OVF			0x8
+
+#define MMDC_MADPCR0	0x410
+#define MMDC_MADPSR0	0x418
+#define MMDC_MADPSR1	0x41C
+#define MMDC_MADPSR2	0x420
+#define MMDC_MADPSR3	0x424
+#define MMDC_MADPSR4	0x428
+#define MMDC_MADPSR5	0x42C
+
+#define MMDC_NUM_COUNTERS	6
+
+#define to_mmdc_pmu(p) container_of(p, struct mmdc_pmu, pmu)
+
 static int ddr_type;
 
+#ifdef CONFIG_PERF_EVENTS
+
+static DEFINE_IDA(mmdc_ida);
+
+PMU_EVENT_ATTR_STRING(total-cycles, mmdc_pmu_total_cycles, "event=0x00")
+PMU_EVENT_ATTR_STRING(busy-cycles, mmdc_pmu_busy_cycles, "event=0x01")
+PMU_EVENT_ATTR_STRING(read-accesses, mmdc_pmu_read_accesses, "event=0x02")
+PMU_EVENT_ATTR_STRING(write-accesses, mmdc_pmu_write_accesses, "config=0x03")
+PMU_EVENT_ATTR_STRING(read-bytes, mmdc_pmu_read_bytes, "event=0x04")
+PMU_EVENT_ATTR_STRING(read-bytes.unit, mmdc_pmu_read_bytes_unit, "MB");
+PMU_EVENT_ATTR_STRING(read-bytes.scale, mmdc_pmu_read_bytes_scale, "0.000001");
+PMU_EVENT_ATTR_STRING(write-bytes, mmdc_pmu_write_bytes, "event=0x05")
+PMU_EVENT_ATTR_STRING(write-bytes.unit, mmdc_pmu_write_bytes_unit, "MB");
+PMU_EVENT_ATTR_STRING(write-bytes.scale, mmdc_pmu_write_bytes_scale, "0.000001");
+
+struct mmdc_pmu {
+	struct pmu pmu;
+	void __iomem *mmdc_base;
+	cpumask_t cpu;
+	struct hrtimer hrtimer;
+	unsigned int active_events;
+	struct device *dev;
+	struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
+	struct hlist_node node;
+};
+
+/*
+ * Polling period is set to one second, overflow of total-cycles (the fastest
+ * increasing counter) takes ten seconds so one second is safe
+ */
+static unsigned int mmdc_pmu_poll_period_us = 1000000;
+
+module_param_named(pmu_pmu_poll_period_us, mmdc_pmu_poll_period_us, uint,
+		S_IRUGO | S_IWUSR);
+
+static ktime_t mmdc_pmu_timer_period(void)
+{
+	return ns_to_ktime((u64)mmdc_pmu_poll_period_us * 1000);
+}
+
+static ssize_t mmdc_pmu_cpumask_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mmdc_pmu *pmu_mmdc = dev_get_drvdata(dev);
+
+	return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
+}
+
+static struct device_attribute mmdc_pmu_cpumask_attr =
+	__ATTR(cpumask, S_IRUGO, mmdc_pmu_cpumask_show, NULL);
+
+static struct attribute *mmdc_pmu_cpumask_attrs[] = {
+	&mmdc_pmu_cpumask_attr.attr,
+	NULL,
+};
+
+static struct attribute_group mmdc_pmu_cpumask_attr_group = {
+	.attrs = mmdc_pmu_cpumask_attrs,
+};
+
+static struct attribute *mmdc_pmu_events_attrs[] = {
+	&mmdc_pmu_total_cycles.attr.attr,
+	&mmdc_pmu_busy_cycles.attr.attr,
+	&mmdc_pmu_read_accesses.attr.attr,
+	&mmdc_pmu_write_accesses.attr.attr,
+	&mmdc_pmu_read_bytes.attr.attr,
+	&mmdc_pmu_read_bytes_unit.attr.attr,
+	&mmdc_pmu_read_bytes_scale.attr.attr,
+	&mmdc_pmu_write_bytes.attr.attr,
+	&mmdc_pmu_write_bytes_unit.attr.attr,
+	&mmdc_pmu_write_bytes_scale.attr.attr,
+	NULL,
+};
+
+static struct attribute_group mmdc_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = mmdc_pmu_events_attrs,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-63");
+static struct attribute *mmdc_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group mmdc_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = mmdc_pmu_format_attrs,
+};
+
+static const struct attribute_group *attr_groups[] = {
+	&mmdc_pmu_events_attr_group,
+	&mmdc_pmu_format_attr_group,
+	&mmdc_pmu_cpumask_attr_group,
+	NULL,
+};
+
+static u32 mmdc_pmu_read_counter(struct mmdc_pmu *pmu_mmdc, int cfg)
+{
+	void __iomem *mmdc_base, *reg;
+
+	mmdc_base = pmu_mmdc->mmdc_base;
+
+	switch (cfg) {
+	case TOTAL_CYCLES:
+		reg = mmdc_base + MMDC_MADPSR0;
+		break;
+	case BUSY_CYCLES:
+		reg = mmdc_base + MMDC_MADPSR1;
+		break;
+	case READ_ACCESSES:
+		reg = mmdc_base + MMDC_MADPSR2;
+		break;
+	case WRITE_ACCESSES:
+		reg = mmdc_base + MMDC_MADPSR3;
+		break;
+	case READ_BYTES:
+		reg = mmdc_base + MMDC_MADPSR4;
+		break;
+	case WRITE_BYTES:
+		reg = mmdc_base + MMDC_MADPSR5;
+		break;
+	default:
+		return WARN_ONCE(1,
+			"invalid configuration %d for mmdc counter", cfg);
+	}
+	return readl(reg);
+}
+
+static int mmdc_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct mmdc_pmu *pmu_mmdc = hlist_entry_safe(node, struct mmdc_pmu, node);
+	int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &pmu_mmdc->cpu))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(&pmu_mmdc->pmu, cpu, target);
+	cpumask_set_cpu(target, &pmu_mmdc->cpu);
+
+	return 0;
+}
+
+static bool mmdc_pmu_group_event_is_valid(struct perf_event *event,
+					  struct pmu *pmu,
+					  unsigned long *used_counters)
+{
+	int cfg = event->attr.config;
+
+	if (is_software_event(event))
+		return true;
+
+	if (event->pmu != pmu)
+		return false;
+
+	return !test_and_set_bit(cfg, used_counters);
+}
+
+/*
+ * Each event has a single fixed-purpose counter, so we can only have a
+ * single active event for each at any point in time. Here we just check
+ * for duplicates, and rely on mmdc_pmu_event_init to verify that the HW
+ * event numbers are valid.
+ */
+static bool mmdc_pmu_group_is_valid(struct perf_event *event)
+{
+	struct pmu *pmu = event->pmu;
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	unsigned long counter_mask = 0;
+
+	set_bit(leader->attr.config, &counter_mask);
+
+	if (event != leader) {
+		if (!mmdc_pmu_group_event_is_valid(event, pmu, &counter_mask))
+			return false;
+	}
+
+	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+		if (!mmdc_pmu_group_event_is_valid(sibling, pmu, &counter_mask))
+			return false;
+	}
+
+	return true;
+}
+
+static int mmdc_pmu_event_init(struct perf_event *event)
+{
+	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
+	int cfg = event->attr.config;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+
+	if (event->cpu < 0) {
+		dev_warn(pmu_mmdc->dev, "Can't provide per-task data!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (event->attr.exclude_user		||
+			event->attr.exclude_kernel	||
+			event->attr.exclude_hv		||
+			event->attr.exclude_idle	||
+			event->attr.exclude_host	||
+			event->attr.exclude_guest	||
+			event->attr.sample_period)
+		return -EINVAL;
+
+	if (cfg < 0 || cfg >= MMDC_NUM_COUNTERS)
+		return -EINVAL;
+
+	if (!mmdc_pmu_group_is_valid(event))
+		return -EINVAL;
+
+	event->cpu = cpumask_first(&pmu_mmdc->cpu);
+	return 0;
+}
+
+static void mmdc_pmu_event_update(struct perf_event *event)
+{
+	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_raw_count, new_raw_count;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = mmdc_pmu_read_counter(pmu_mmdc,
+						      event->attr.config);
+	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+		new_raw_count) != prev_raw_count);
+
+	delta = (new_raw_count - prev_raw_count) & 0xFFFFFFFF;
+
+	local64_add(delta, &event->count);
+}
+
+static void mmdc_pmu_event_start(struct perf_event *event, int flags)
+{
+	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	void __iomem *mmdc_base, *reg;
+
+	mmdc_base = pmu_mmdc->mmdc_base;
+	reg = mmdc_base + MMDC_MADPCR0;
+
+	/*
+	 * hrtimer is required because mmdc does not provide an interrupt so
+	 * polling is necessary
+	 */
+	hrtimer_start(&pmu_mmdc->hrtimer, mmdc_pmu_timer_period(),
+			HRTIMER_MODE_REL_PINNED);
+
+	local64_set(&hwc->prev_count, 0);
+
+	writel(DBG_RST, reg);
+	writel(DBG_EN, reg);
+}
+
+static int mmdc_pmu_event_add(struct perf_event *event, int flags)
+{
+	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	int cfg = event->attr.config;
+
+	if (flags & PERF_EF_START)
+		mmdc_pmu_event_start(event, flags);
+
+	if (pmu_mmdc->mmdc_events[cfg] != NULL)
+		return -EAGAIN;
+
+	pmu_mmdc->mmdc_events[cfg] = event;
+	pmu_mmdc->active_events++;
+
+	local64_set(&hwc->prev_count, mmdc_pmu_read_counter(pmu_mmdc, cfg));
+
+	return 0;
+}
+
+static void mmdc_pmu_event_stop(struct perf_event *event, int flags)
+{
+	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
+	void __iomem *mmdc_base, *reg;
+
+	mmdc_base = pmu_mmdc->mmdc_base;
+	reg = mmdc_base + MMDC_MADPCR0;
+
+	writel(PRF_FRZ, reg);
+	mmdc_pmu_event_update(event);
+}
+
+static void mmdc_pmu_event_del(struct perf_event *event, int flags)
+{
+	struct mmdc_pmu *pmu_mmdc = to_mmdc_pmu(event->pmu);
+	int cfg = event->attr.config;
+
+	pmu_mmdc->mmdc_events[cfg] = NULL;
+	pmu_mmdc->active_events--;
+
+	if (pmu_mmdc->active_events == 0)
+		hrtimer_cancel(&pmu_mmdc->hrtimer);
+
+	mmdc_pmu_event_stop(event, PERF_EF_UPDATE);
+}
+
+static void mmdc_pmu_overflow_handler(struct mmdc_pmu *pmu_mmdc)
+{
+	int i;
+
+	for (i = 0; i < MMDC_NUM_COUNTERS; i++) {
+		struct perf_event *event = pmu_mmdc->mmdc_events[i];
+
+		if (event)
+			mmdc_pmu_event_update(event);
+	}
+}
+
+static enum hrtimer_restart mmdc_pmu_timer_handler(struct hrtimer *hrtimer)
+{
+	struct mmdc_pmu *pmu_mmdc = container_of(hrtimer, struct mmdc_pmu,
+			hrtimer);
+
+	mmdc_pmu_overflow_handler(pmu_mmdc);
+	hrtimer_forward_now(hrtimer, mmdc_pmu_timer_period());
+
+	return HRTIMER_RESTART;
+}
+
+static int mmdc_pmu_init(struct mmdc_pmu *pmu_mmdc,
+		void __iomem *mmdc_base, struct device *dev)
+{
+	int mmdc_num;
+
+	*pmu_mmdc = (struct mmdc_pmu) {
+		.pmu = (struct pmu) {
+			.task_ctx_nr    = perf_invalid_context,
+			.attr_groups    = attr_groups,
+			.event_init     = mmdc_pmu_event_init,
+			.add            = mmdc_pmu_event_add,
+			.del            = mmdc_pmu_event_del,
+			.start          = mmdc_pmu_event_start,
+			.stop           = mmdc_pmu_event_stop,
+			.read           = mmdc_pmu_event_update,
+		},
+		.mmdc_base = mmdc_base,
+		.dev = dev,
+		.active_events = 0,
+	};
+
+	mmdc_num = ida_simple_get(&mmdc_ida, 0, 0, GFP_KERNEL);
+
+	return mmdc_num;
+}
+
+static int imx_mmdc_remove(struct platform_device *pdev)
+{
+	struct mmdc_pmu *pmu_mmdc = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&pmu_mmdc->pmu);
+	cpuhp_remove_state_nocalls(CPUHP_ONLINE);
+	kfree(pmu_mmdc);
+	return 0;
+}
+
+static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_base)
+{
+	struct mmdc_pmu *pmu_mmdc;
+	char *name;
+	int mmdc_num;
+	int ret;
+
+	pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);
+	if (!pmu_mmdc) {
+		pr_err("failed to allocate PMU device!\n");
+		return -ENOMEM;
+	}
+
+	mmdc_num = mmdc_pmu_init(pmu_mmdc, mmdc_base, &pdev->dev);
+	if (mmdc_num == 0)
+		name = "mmdc";
+	else
+		name = devm_kasprintf(&pdev->dev,
+				GFP_KERNEL, "mmdc%d", mmdc_num);
+
+	hrtimer_init(&pmu_mmdc->hrtimer, CLOCK_MONOTONIC,
+			HRTIMER_MODE_REL);
+	pmu_mmdc->hrtimer.function = mmdc_pmu_timer_handler;
+
+	cpuhp_state_add_instance_nocalls(CPUHP_ONLINE,
+					 &pmu_mmdc->node);
+	cpumask_set_cpu(smp_processor_id(), &pmu_mmdc->cpu);
+	ret = cpuhp_setup_state_multi(CPUHP_AP_NOTIFY_ONLINE,
+				      "MMDC_ONLINE", NULL,
+				      mmdc_pmu_offline_cpu);
+	if (ret) {
+		pr_err("cpuhp_setup_state_multi failure\n");
+		goto pmu_register_err;
+	}
+
+	ret = perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
+	platform_set_drvdata(pdev, pmu_mmdc);
+	if (ret)
+		goto pmu_register_err;
+	return 0;
+
+pmu_register_err:
+	pr_warn("MMDC Perf PMU failed (%d), disabled\n", ret);
+	hrtimer_cancel(&pmu_mmdc->hrtimer);
+	kfree(pmu_mmdc);
+	return ret;
+}
+
+#else
+#define imx_mmdc_remove NULL
+#define imx_mmdc_perf_init(pdev, mmdc_base) 0
+#endif
+
 static int imx_mmdc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -62,7 +516,7 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	return 0;
+	return imx_mmdc_perf_init(pdev, mmdc_base);
 }
 
 int imx_mmdc_get_ddr_type(void)
@@ -81,6 +535,7 @@ static struct platform_driver imx_mmdc_driver = {
 		.of_match_table = imx_mmdc_dt_ids,
 	},
 	.probe		= imx_mmdc_probe,
+	.remove		= imx_mmdc_remove,
 };
 
 static int __init imx_mmdc_init(void)
-- 
2.5.2
