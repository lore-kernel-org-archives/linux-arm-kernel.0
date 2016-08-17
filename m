From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Aug 2016 17:26:31 +0100
Subject: [PATCH] arm: l2x0: add PMU support
Message-ID: <1471451191-18090-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The L2C-220 (AKA L220) and L2C-310 (AKA PL310) cache controllers feature
a Performance Monitoring Unit (PMU), which can be useful for tuning
and/or debugging. This hardware is always present and the relevant
registers are accessible to non-secure accesses. Thus, no special
firmware interface is necessary.

This patch adds support for the PMU, plugging into the usual perf
infrastructure. The overflow interrupt is not always available (e.g. on
RealView PBX A9 it is not wired up at all), and the hardware counters
saturate, so the driver does not make use of this. Instead, the driver
periodically polls and reset counters as required to avoid losing
events due to saturation.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |   9 +
 arch/arm/mm/Kconfig                        |   7 +
 arch/arm/mm/cache-l2x0.c                   | 554 +++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h                 |   1 +
 4 files changed, 571 insertions(+)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 3a5ec1c..e476350 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -87,6 +87,15 @@
 #define L310_CACHE_ID_RTL_R3P2		0x08
 #define L310_CACHE_ID_RTL_R3P3		0x09
 
+#define L2X0_EVENT_CNT_CTRL_ENABLE	BIT(0)
+
+#define L2X0_EVENT_CNT_CFG_SRC_SHIFT	2
+#define L2X0_EVENT_CNT_CFG_SRC_MASK	0xf
+#define L2X0_EVENT_CNT_CFG_SRC_DISABLED	0
+#define L2X0_EVENT_CNT_CFG_INT_DISABLED	0
+#define L2X0_EVENT_CNT_CFG_INT_INCR	1
+#define L2X0_EVENT_CNT_CFG_INT_OVERFLOW	2
+
 /* L2C auxiliary control register - bits common to L2C-210/220/310 */
 #define L2C_AUX_CTRL_WAY_SIZE_SHIFT		17
 #define L2C_AUX_CTRL_WAY_SIZE_MASK		(7 << 17)
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index d15a7fe..0e8cbac 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -916,6 +916,13 @@ config CACHE_L2X0
 	help
 	  This option enables the L2x0 PrimeCell.
 
+config CACHE_L2X0_PMU
+	bool "L2x0 performance monitor support" if CACHE_L2X0
+	depends on PERF_EVENTS
+	help
+	  This option enables support for the performance monitoring features
+	  of the L220 and PL310 outer cache controllers.
+
 if CACHE_L2X0
 
 config PL310_ERRATA_588369
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index cc12905..4961a82 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -18,9 +18,17 @@
  */
 #include <linux/cpu.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/hrtimer.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/perf_event.h>
+#include <linux/printk.h>
 #include <linux/smp.h>
 #include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/types.h>
 #include <linux/log2.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -57,6 +65,14 @@ static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
 
 struct l2x0_regs l2x0_saved_regs;
 
+#ifdef CONFIG_CACHE_L2X0_PMU
+static void l2x0_pmu_suspend(void);
+static void l2x0_pmu_resume(void);
+#else
+static inline void l2x0_pmu_suspend(void) { }
+static inline void l2x0_pmu_resume(void) { }
+#endif
+
 /*
  * Common code for all cache controllers.
  */
@@ -142,6 +158,8 @@ static void l2c_disable(void)
 {
 	void __iomem *base = l2x0_base;
 
+	l2x0_pmu_suspend();
+
 	outer_cache.flush_all();
 	l2c_write_sec(0, base, L2X0_CTRL);
 	dsb(st);
@@ -159,6 +177,8 @@ static void l2c_resume(void)
 	/* Do not touch the controller if already enabled. */
 	if (!(readl_relaxed(base + L2X0_CTRL) & L2X0_CTRL_EN))
 		l2c_enable(base, l2x0_data->num_lock);
+
+	l2x0_pmu_resume();
 }
 
 /*
@@ -1801,3 +1821,537 @@ int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
 	return __l2c_init(data, aux_val, aux_mask, cache_id, nosync);
 }
 #endif
+
+#ifdef CONFIG_CACHE_L2X0_PMU
+#define PMU_NR_COUNTERS 2
+
+static struct pmu *l2x0_pmu;
+static cpumask_t pmu_cpu;
+
+static ktime_t l2x0_pmu_poll_period;
+static struct hrtimer l2x0_pmu_hrtimer;
+
+/*
+ * The L220/PL310 PMU has two equivalent counters, Counter1 and Counter0.
+ * Registers controlling these are laid out in pairs, in descending order, i.e.
+ * the register for Counter1 comes first, followed by the register for
+ * Counter0.
+ * We ensure that idx 0 -> Counter0, and idx1 -> Counter1.
+ */
+static struct perf_event *events[PMU_NR_COUNTERS];
+
+/* Find an unused counter */
+static int l2x0_pmu_find_idx(void)
+{
+	int i;
+
+	for (i = 0; i < PMU_NR_COUNTERS; i++) {
+		if (!events[i])
+			return i;
+	}
+
+	return -1;
+}
+
+/* How many counters are allocated? */
+static bool l2x0_pmu_num_active_counters(void)
+{
+	int i, cnt = 0;
+
+	for (i = 0; i < PMU_NR_COUNTERS; i++) {
+		if (events[i])
+			cnt++;
+	}
+
+	return cnt;
+}
+
+static void l2x0_pmu_counter_config_write(int idx, u32 val)
+{
+	writel(val, l2x0_base + L2X0_EVENT_CNT0_CFG - 4 * idx);
+}
+
+static u32 l2x0_pmu_counter_read(int idx)
+{
+	return readl(l2x0_base + L2X0_EVENT_CNT0_VAL - 4 * idx);
+}
+
+static void l2x0_pmu_counter_write(int idx, u32 val)
+{
+	writel(val, l2x0_base + L2X0_EVENT_CNT0_VAL - 4 * idx);
+}
+
+static void __l2x0_pmu_enable(void)
+{
+	u32 val = readl(l2x0_base + L2X0_EVENT_CNT_CTRL);
+	val |= L2X0_EVENT_CNT_CTRL_ENABLE;
+	writel(val, l2x0_base + L2X0_EVENT_CNT_CTRL);
+}
+
+static void __l2x0_pmu_disable(void)
+{
+	u32 val = readl(l2x0_base + L2X0_EVENT_CNT_CTRL);
+	val &= ~L2X0_EVENT_CNT_CTRL_ENABLE;
+	writel(val, l2x0_base + L2X0_EVENT_CNT_CTRL);
+}
+
+static void l2x0_pmu_enable(struct pmu *pmu)
+{
+	if (l2x0_pmu_num_active_counters() == 0)
+		return;
+
+	__l2x0_pmu_enable();
+}
+
+static void l2x0_pmu_disable(struct pmu *pmu)
+{
+	if (l2x0_pmu_num_active_counters() == 0)
+		return;
+
+	__l2x0_pmu_disable();
+}
+
+static void warn_if_saturated(u32 count)
+{
+	if (count != 0xffffffff)
+		return;
+
+	pr_warn_ratelimited("L2X0 counter saturated. Poll period too long\n");
+}
+
+static void l2x0_pmu_event_read(struct perf_event *event)
+{
+	struct hw_perf_event *hw = &event->hw;
+	u64 prev_count, new_count, mask;
+
+	do {
+		 prev_count = local64_read(&hw->prev_count);
+		 new_count = l2x0_pmu_counter_read(hw->idx);
+	} while (local64_xchg(&hw->prev_count, new_count) != prev_count);
+
+	mask = GENMASK_ULL(31, 0);
+	local64_add((new_count - prev_count) & mask, &event->count);
+
+	warn_if_saturated(new_count);
+}
+
+static void l2x0_pmu_event_configure(struct perf_event *event)
+{
+	struct hw_perf_event *hw = &event->hw;
+
+	/*
+	 * The L2X0 counters saturate at 0xffffffff rather than wrapping, so we
+	 * will *always* lose some number of events when a counter saturates,
+	 * and have no way of detecting how many were lost.
+	 *
+	 * To minimize the impact of this, we try to maximize the period by
+	 * always starting counters at zero. To ensure that group ratios are
+	 * representative, we poll periodically to avoid counters saturating.
+	 * See l2x0_pmu_poll().
+	 */
+	local64_set(&hw->prev_count, 0);
+	l2x0_pmu_counter_write(hw->idx, 0);
+}
+
+static enum hrtimer_restart l2x0_pmu_poll(struct hrtimer *hrtimer)
+{
+	unsigned long flags;
+	int i;
+
+	local_irq_save(flags);
+	__l2x0_pmu_disable();
+
+	for (i = 0; i < PMU_NR_COUNTERS; i++) {
+		struct perf_event *event = events[i];
+
+		if (!event)
+			continue;
+
+		l2x0_pmu_event_read(event);
+		l2x0_pmu_event_configure(event);
+	}
+
+	__l2x0_pmu_enable();
+	local_irq_restore(flags);
+
+	hrtimer_forward_now(hrtimer, l2x0_pmu_poll_period);
+	return HRTIMER_RESTART;
+}
+
+
+static void __l2x0_pmu_event_enable(int idx, u32 event)
+{
+	u32 val;
+
+	val = event << L2X0_EVENT_CNT_CFG_SRC_SHIFT;
+	val |= L2X0_EVENT_CNT_CFG_INT_DISABLED;
+	l2x0_pmu_counter_config_write(idx, val);
+}
+
+static void l2x0_pmu_event_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hw = &event->hw;
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD) {
+		WARN_ON_ONCE(!(hw->state & PERF_HES_UPTODATE));
+		l2x0_pmu_event_configure(event);
+	}
+
+	hw->state = 0;
+
+	__l2x0_pmu_event_enable(hw->idx, hw->config_base);
+}
+
+static void __l2x0_pmu_event_disable(int idx)
+{
+	u32 val;
+
+	val = L2X0_EVENT_CNT_CFG_SRC_DISABLED << L2X0_EVENT_CNT_CFG_SRC_SHIFT;
+	val |= L2X0_EVENT_CNT_CFG_INT_DISABLED;
+	l2x0_pmu_counter_config_write(idx, val);
+}
+
+static void l2x0_pmu_event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hw = &event->hw;
+
+	if (WARN_ON_ONCE(event->hw.state & PERF_HES_STOPPED))
+		return;
+
+	__l2x0_pmu_event_disable(hw->idx);
+
+	hw->state |= PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_UPDATE) {
+		l2x0_pmu_event_read(event);
+		hw->state |= PERF_HES_UPTODATE;
+	}
+}
+
+static int l2x0_pmu_event_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hw = &event->hw;
+	int idx = l2x0_pmu_find_idx();
+
+	if (idx == -1)
+		return -EAGAIN;
+
+	/*
+	 * Pin the timer, so that the overflows are handled by the chosen
+	 * event->cpu (this is the same one as presented in "cpumask"
+	 * attribute).
+	 */
+	if (l2x0_pmu_num_active_counters() == 0)
+		hrtimer_start(&l2x0_pmu_hrtimer, l2x0_pmu_poll_period,
+			      HRTIMER_MODE_REL_PINNED);
+
+	events[idx] = event;
+	hw->idx = idx;
+
+	l2x0_pmu_event_configure(event);
+
+	hw->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		l2x0_pmu_event_start(event, 0);
+
+	return 0;
+}
+
+static void l2x0_pmu_event_del(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hw = &event->hw;
+
+	l2x0_pmu_event_stop(event, PERF_EF_UPDATE);
+
+	events[hw->idx] = NULL;
+	hw->idx = -1;
+
+	if (l2x0_pmu_num_active_counters() == 0)
+		hrtimer_cancel(&l2x0_pmu_hrtimer);
+}
+
+static bool l2x0_pmu_group_is_valid(struct perf_event *event)
+{
+	struct pmu *pmu = event->pmu;
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	int num_hw = 0;
+
+	if (leader->pmu == pmu)
+		num_hw++;
+	else if (!is_software_event(leader))
+		return false;
+
+	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+		if (sibling->pmu == pmu)
+			num_hw++;
+		else if (!is_software_event(sibling))
+			return false;
+	}
+
+	return num_hw <= PMU_NR_COUNTERS;
+}
+
+static int l2x0_pmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hw = &event->hw;
+
+	if (event->attr.type != l2x0_pmu->type)
+		return -ENOENT;
+
+	if (is_sampling_event(event) ||
+	    event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	if (event->attr.exclude_user   ||
+	    event->attr.exclude_kernel ||
+	    event->attr.exclude_hv     ||
+	    event->attr.exclude_idle   ||
+	    event->attr.exclude_host   ||
+	    event->attr.exclude_guest)
+		return -EINVAL;
+
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	if (event->attr.config & ~L2X0_EVENT_CNT_CFG_SRC_MASK)
+		return -EINVAL;
+
+	hw->config_base = event->attr.config;
+
+	if (!l2x0_pmu_group_is_valid(event))
+		return -EINVAL;
+
+	event->cpu = cpumask_first(&pmu_cpu);
+
+	return 0;
+}
+
+struct l2x0_event_attribute {
+	struct device_attribute attr;
+	unsigned int config;
+	bool pl310_only;
+};
+
+#define L2X0_EVENT_ATTR(_name, _config, _pl310_only)				\
+	(&((struct l2x0_event_attribute[]) {{					\
+		.attr = __ATTR(_name, S_IRUGO, l2x0_pmu_event_show, NULL),	\
+		.config = _config,						\
+		.pl310_only = _pl310_only,					\
+	}})[0].attr.attr)
+
+#define L220_PLUS_EVENT_ATTR(_name, _config)					\
+	L2X0_EVENT_ATTR(_name, _config, false)
+
+#define PL310_EVENT_ATTR(_name, _config)					\
+	L2X0_EVENT_ATTR(_name, _config, true)
+
+static ssize_t l2x0_pmu_event_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct l2x0_event_attribute *lattr;
+
+	lattr = container_of(attr, typeof(*lattr), attr);
+	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
+}
+
+static umode_t l2x0_pmu_event_attr_is_visible(struct kobject *kobj,
+					      struct attribute *attr,
+					      int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct l2x0_event_attribute *lattr;
+
+	lattr = container_of(attr, typeof(*lattr), attr.attr);
+
+	if (!lattr->pl310_only || strcmp("l2c_310", pmu->name) == 0)
+		return attr->mode;
+
+	return 0;
+}
+
+static struct attribute *l2x0_pmu_event_attrs[] = {
+	L220_PLUS_EVENT_ATTR(co,	0x1),
+	L220_PLUS_EVENT_ATTR(drhit,	0x2),
+	L220_PLUS_EVENT_ATTR(drreq,	0x3),
+	L220_PLUS_EVENT_ATTR(dwhit,	0x4),
+	L220_PLUS_EVENT_ATTR(dwreq,	0x5),
+	L220_PLUS_EVENT_ATTR(dwtreq,	0x6),
+	L220_PLUS_EVENT_ATTR(irhit,	0x7),
+	L220_PLUS_EVENT_ATTR(irreq,	0x8),
+	L220_PLUS_EVENT_ATTR(wa,	0x9),
+	PL310_EVENT_ATTR(ipfalloc,	0xa),
+	PL310_EVENT_ATTR(epfhit,	0xb),
+	PL310_EVENT_ATTR(epfalloc,	0xc),
+	PL310_EVENT_ATTR(srrcvd,	0xd),
+	PL310_EVENT_ATTR(srconf,	0xe),
+	PL310_EVENT_ATTR(epfrcvd,	0xf),
+	NULL
+};
+
+static struct attribute_group l2x0_pmu_event_attrs_group = {
+	.name = "events",
+	.attrs = l2x0_pmu_event_attrs,
+	.is_visible = l2x0_pmu_event_attr_is_visible,
+};
+
+static ssize_t l2x0_pmu_cpumask_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &pmu_cpu);
+}
+
+static struct device_attribute l2x0_pmu_cpumask_attr =
+		__ATTR(cpumask, S_IRUGO, l2x0_pmu_cpumask_show, NULL);
+
+static struct attribute *l2x0_pmu_cpumask_attrs[] = {
+	&l2x0_pmu_cpumask_attr.attr,
+	NULL,
+};
+
+static struct attribute_group l2x0_pmu_cpumask_attr_group = {
+	.attrs = l2x0_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *l2x0_pmu_attr_groups[] = {
+	&l2x0_pmu_event_attrs_group,
+	&l2x0_pmu_cpumask_attr_group,
+	NULL,
+};
+
+static void l2x0_pmu_reset(void)
+{
+	int i;
+
+	__l2x0_pmu_disable();
+
+	for (i = 0; i < PMU_NR_COUNTERS; i++)
+		__l2x0_pmu_event_disable(i);
+}
+
+static void l2x0_pmu_suspend(void)
+{
+	int i;
+
+	if (!l2x0_pmu)
+		return;
+
+	l2x0_pmu_disable(l2x0_pmu);
+
+	for (i = 0; i < PMU_NR_COUNTERS; i++) {
+		if (events[i])
+			l2x0_pmu_event_stop(events[i], PERF_EF_UPDATE);
+	}
+
+}
+
+static void l2x0_pmu_resume(void)
+{
+	int i;
+
+	if (!l2x0_pmu)
+		return;
+
+	l2x0_pmu_reset();
+
+	for (i = 0; i < PMU_NR_COUNTERS; i++) {
+		if (events[i])
+			l2x0_pmu_event_start(events[i], PERF_EF_RELOAD);
+	}
+
+	l2x0_pmu_enable(l2x0_pmu);
+}
+
+static int l2x0_pmu_offline_cpu(unsigned int cpu)
+{
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &pmu_cpu))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	perf_pmu_migrate_context(l2x0_pmu, cpu, target);
+	cpumask_set_cpu(target, &pmu_cpu);
+
+	return 0;
+}
+
+static __init int l2x0_pmu_register(void)
+{
+	int ret;
+	const char *name;
+
+	if (!l2x0_base)
+		return 0;
+
+	/* Only L220 and PL310 have a PMU */
+	if (strcmp("L2C-220", l2x0_data->type) == 0)
+		name = "l2c_220";
+	if (strcmp("L2C-310", l2x0_data->type) == 0)
+		name = "l2c_310";
+	else
+		return 0;
+
+	l2x0_pmu = kzalloc(sizeof(*l2x0_pmu), GFP_KERNEL);
+	if (!l2x0_pmu)
+		return -ENOMEM;
+
+	*l2x0_pmu = (struct pmu) {
+		.task_ctx_nr = perf_invalid_context,
+		.pmu_enable = l2x0_pmu_enable,
+		.pmu_disable = l2x0_pmu_disable,
+		.read = l2x0_pmu_event_read,
+		.start = l2x0_pmu_event_start,
+		.stop = l2x0_pmu_event_stop,
+		.add = l2x0_pmu_event_add,
+		.del = l2x0_pmu_event_del,
+		.event_init = l2x0_pmu_event_init,
+		.attr_groups = l2x0_pmu_attr_groups,
+	};
+
+	l2x0_pmu_reset();
+
+	/*
+	 * We always use a hrtimer rather than an interrupt.
+	 * See comments in l2x0_pmu_event_configure and l2x0_pmu_poll.
+	 *
+	 * Polling once a second allows the counters to fill up to 1/128th on a
+	 * quad-core test chip with cores clocked at 400MHz. Hopefully this
+	 * leaves sufficient headroom to avoid overflow on production silicon
+	 * at higher frequencies.
+	 */
+	l2x0_pmu_poll_period = ms_to_ktime(1000);
+	hrtimer_init(&l2x0_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	l2x0_pmu_hrtimer.function = l2x0_pmu_poll;
+
+	cpumask_set_cpu(0, &pmu_cpu);
+	ret = cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_L2X0_ONLINE,
+					"AP_PERF_ARM_L2X0_ONLINE", NULL,
+					l2x0_pmu_offline_cpu);
+	if (ret)
+		goto out_pmu;
+
+	ret = perf_pmu_register(l2x0_pmu, name, -1);
+	if (ret)
+		goto out_cpuhp;
+
+	return 0;
+
+out_cpuhp:
+	cpuhp_remove_state_nocalls(CPUHP_AP_PERF_ARM_L2X0_ONLINE);
+out_pmu:
+	kfree(l2x0_pmu);
+	l2x0_pmu = NULL;
+	return ret;
+}
+device_initcall(l2x0_pmu_register);
+
+ #endif /* CONFIG_CACHE_L2X0_PMU */
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 242bf53..7e1ba14 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -86,6 +86,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
+	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_NOTIFY_ONLINE,
-- 
1.9.1
