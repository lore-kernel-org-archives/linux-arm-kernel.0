From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 20 Oct 2014 18:35:31 +0100
Subject: [PATCH 1/1] bus: cci: move away from arm_pmu framework
In-Reply-To: <1413826531-23462-1-git-send-email-mark.rutland@arm.com>
References: <1413826531-23462-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1413826531-23462-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM CPU PMUs and the ARM CCI PMU are using the same framework
despite being substantially different in programming model, which makes
it difficult to handle either particularly well.

This patch migrates the ARM CCI PMU driver away from the arm_pmu
framework, matching the style of the CCN PMU driver and other 'uncore'
PMU drivers. This enables better support for the CCI PMU (including
migration of events across CPUs across hotplug) and will allow for
refactoring of the arm_pmu framework to better support CPU PMUs.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/bus/arm-cci.c | 549 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 441 insertions(+), 108 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 7af78df..65c902e 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -16,17 +16,17 @@
 
 #include <linux/arm-cci.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #include <asm/cacheflush.h>
-#include <asm/irq_regs.h>
-#include <asm/pmu.h>
 #include <asm/smp_plat.h>
 
 #define DRIVER_NAME		"CCI-400"
@@ -98,6 +98,8 @@ static unsigned long cci_ctrl_phys;
 
 #define CCI_PMU_CNTR_BASE(idx)	((idx) * SZ_4K)
 
+#define CCI_PMU_CNTR_MASK	((1ULL << 32) -1)
+
 /*
  * Instead of an event id to monitor CCI cycles, a dedicated counter is
  * provided. Use 0xff to represent CCI cycles and hope that no future revisions
@@ -170,18 +172,29 @@ static char *const pmu_names[] = {
 	[CCI_REV_R1] = "CCI_400_r1",
 };
 
-struct cci_pmu_drv_data {
+struct cci_pmu_hw_events {
+	struct perf_event *events[CCI_PMU_MAX_HW_EVENTS];
+	unsigned long used_mask[BITS_TO_LONGS(CCI_PMU_MAX_HW_EVENTS)];
+	raw_spinlock_t pmu_lock;
+};
+
+struct cci_pmu {
 	void __iomem *base;
-	struct arm_pmu *cci_pmu;
+	struct pmu pmu;
 	int nr_irqs;
 	int irqs[CCI_PMU_MAX_HW_EVENTS];
 	unsigned long active_irqs;
-	struct perf_event *events[CCI_PMU_MAX_HW_EVENTS];
-	unsigned long used_mask[BITS_TO_LONGS(CCI_PMU_MAX_HW_EVENTS)];
 	struct pmu_port_event_ranges *port_ranges;
-	struct pmu_hw_events hw_events;
+	struct cci_pmu_hw_events hw_events;
+	struct platform_device *plat_device;
+	int num_events;
+	atomic_t active_events;
+	struct mutex reserve_mutex;
+	cpumask_t cpus;
 };
-static struct cci_pmu_drv_data *pmu;
+static struct cci_pmu *pmu;
+
+#define to_cci_pmu(c)	(container_of(c, struct cci_pmu, pmu))
 
 static bool is_duplicate_irq(int irq, int *irqs, int nr_irqs)
 {
@@ -252,7 +265,7 @@ static int pmu_validate_hw_event(u8 hw_event)
 	return -ENOENT;
 }
 
-static int pmu_is_valid_counter(struct arm_pmu *cci_pmu, int idx)
+static int pmu_is_valid_counter(struct cci_pmu *cci_pmu, int idx)
 {
 	return CCI_PMU_CYCLE_CNTR_IDX <= idx &&
 		idx <= CCI_PMU_CNTR_LAST(cci_pmu);
@@ -293,14 +306,9 @@ static u32 pmu_get_max_counters(void)
 	return n_cnts + 1;
 }
 
-static struct pmu_hw_events *pmu_get_hw_events(void)
-{
-	return &pmu->hw_events;
-}
-
-static int pmu_get_event_idx(struct pmu_hw_events *hw, struct perf_event *event)
+static int pmu_get_event_idx(struct cci_pmu_hw_events *hw, struct perf_event *event)
 {
-	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
 	struct hw_perf_event *hw_event = &event->hw;
 	unsigned long cci_event = hw_event->config_base & CCI_PMU_EVENT_MASK;
 	int idx;
@@ -336,7 +344,7 @@ static int pmu_map_event(struct perf_event *event)
 	return mapping;
 }
 
-static int pmu_request_irq(struct arm_pmu *cci_pmu, irq_handler_t handler)
+static int pmu_request_irq(struct cci_pmu *cci_pmu, irq_handler_t handler)
 {
 	int i;
 	struct platform_device *pmu_device = cci_pmu->plat_device;
@@ -371,17 +379,91 @@ static int pmu_request_irq(struct arm_pmu *cci_pmu, irq_handler_t handler)
 	return 0;
 }
 
+static void pmu_free_irq(struct cci_pmu *cci_pmu)
+{
+	int i;
+
+	for (i = 0; i < pmu->nr_irqs; i++) {
+		if (!test_and_clear_bit(i, &pmu->active_irqs))
+			continue;
+
+		free_irq(pmu->irqs[i], cci_pmu);
+	}
+}
+
+static u32 pmu_read_counter(struct perf_event *event)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	struct hw_perf_event *hw_counter = &event->hw;
+	int idx = hw_counter->idx;
+	u32 value;
+
+	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
+		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
+		return 0;
+	}
+	value = pmu_read_register(idx, CCI_PMU_CNTR);
+
+	return value;
+}
+
+static void pmu_write_counter(struct perf_event *event, u32 value)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	struct hw_perf_event *hw_counter = &event->hw;
+	int idx = hw_counter->idx;
+
+	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx)))
+		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
+	else
+		pmu_write_register(value, idx, CCI_PMU_CNTR);
+}
+
+static u64 pmu_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_raw_count, new_raw_count;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = pmu_read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+		 new_raw_count) != prev_raw_count);
+
+	delta = (new_raw_count - prev_raw_count) & CCI_PMU_CNTR_MASK;
+
+	local64_add(delta, &event->count);
+
+	return new_raw_count;
+}
+
+static void pmu_read(struct perf_event *event)
+{
+	pmu_event_update(event);
+}
+
+void pmu_event_set_period(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	/*
+	 * The CCI PMU counters have a period of 2^32. To account for the
+	 * possiblity of extreme interrupt latency we program for a period of
+	 * half that. Hopefully we can handle the interrupt before another 2^31
+	 * events occur and the counter overtakes its previous value.
+	 */
+	u64 val = 1ULL << 31;
+	local64_set(&hwc->prev_count, val);
+	pmu_write_counter(event, val);
+}
+
 static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
 {
 	unsigned long flags;
-	struct arm_pmu *cci_pmu = (struct arm_pmu *)dev;
-	struct pmu_hw_events *events = cci_pmu->get_hw_events();
-	struct perf_sample_data data;
-	struct pt_regs *regs;
+	struct cci_pmu *cci_pmu = dev;
+	struct cci_pmu_hw_events *events = &pmu->hw_events;
 	int idx, handled = IRQ_NONE;
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
-	regs = get_irq_regs();
 	/*
 	 * Iterate over counters and update the corresponding perf events.
 	 * This should work regardless of whether we have per-counter overflow
@@ -403,154 +485,404 @@ static irqreturn_t pmu_handle_irq(int irq_num, void *dev)
 
 		pmu_write_register(CCI_PMU_OVRFLW_FLAG, idx, CCI_PMU_OVRFLW);
 
+		pmu_event_update(event);
+		pmu_event_set_period(event);
 		handled = IRQ_HANDLED;
-
-		armpmu_event_update(event);
-		perf_sample_data_init(&data, 0, hw_counter->last_period);
-		if (!armpmu_event_set_period(event))
-			continue;
-
-		if (perf_event_overflow(event, &data, regs))
-			cci_pmu->disable(event);
 	}
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 
 	return IRQ_RETVAL(handled);
 }
 
-static void pmu_free_irq(struct arm_pmu *cci_pmu)
+static int cci_pmu_get_hw(struct cci_pmu *cci_pmu)
 {
-	int i;
+	int ret = pmu_request_irq(cci_pmu, pmu_handle_irq);
+	if (ret) {
+		pmu_free_irq(cci_pmu);
+		return ret;
+	}
+	return 0;
+}
 
-	for (i = 0; i < pmu->nr_irqs; i++) {
-		if (!test_and_clear_bit(i, &pmu->active_irqs))
-			continue;
+static void cci_pmu_put_hw(struct cci_pmu *cci_pmu)
+{
+	pmu_free_irq(cci_pmu);
+}
 
-		free_irq(pmu->irqs[i], cci_pmu);
+static void hw_perf_event_destroy(struct perf_event *event)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	atomic_t *active_events = &cci_pmu->active_events;
+	struct mutex *reserve_mutex = &cci_pmu->reserve_mutex;
+
+	if (atomic_dec_and_mutex_lock(active_events, reserve_mutex)) {
+		cci_pmu_put_hw(cci_pmu);
+		mutex_unlock(reserve_mutex);
 	}
 }
 
-static void pmu_enable_event(struct perf_event *event)
+static void cci_pmu_enable(struct pmu *pmu)
 {
+	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_events);
 	unsigned long flags;
-	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
-	struct pmu_hw_events *events = cci_pmu->get_hw_events();
-	struct hw_perf_event *hw_counter = &event->hw;
-	int idx = hw_counter->idx;
+	u32 val;
+
+	if (!enabled)
+		return;
+
+	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
+
+	/* Enable all the PMU counters. */
+	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
+	writel(val, cci_ctrl_base + CCI_PMCR);
+	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
+
+}
+
+static void cci_pmu_disable(struct pmu *pmu)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
+
+	/* Disable all the PMU counters. */
+	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
+	writel(val, cci_ctrl_base + CCI_PMCR);
+	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
+}
+
+static void cci_pmu_start(struct perf_event *event, int pmu_flags)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	unsigned long flags;
+
+	/*
+	 * To handle interrupt latency, we always reprogram the period
+	 * regardlesss of PERF_EF_RELOAD.
+	 */
+	if (pmu_flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
 
 	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
 		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
 		return;
 	}
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	raw_spin_lock_irqsave(&hw_events->pmu_lock, flags);
 
 	/* Configure the event to count, unless you are counting cycles */
 	if (idx != CCI_PMU_CYCLE_CNTR_IDX)
-		pmu_set_event(idx, hw_counter->config_base);
+		pmu_set_event(idx, hwc->config_base);
 
+	pmu_event_set_period(event);
 	pmu_enable_counter(idx);
 
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+	raw_spin_unlock_irqrestore(&hw_events->pmu_lock, flags);
 }
 
-static void pmu_disable_event(struct perf_event *event)
+static void cci_pmu_stop(struct perf_event *event, int pmu_flags)
 {
-	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
-	struct hw_perf_event *hw_counter = &event->hw;
-	int idx = hw_counter->idx;
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
 
 	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
 		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
 		return;
 	}
 
+	/*
+	 * We always reprogram the counter, so ignore PERF_EF_UPDATE. See
+	 * cci_pmu_start()
+	 */
 	pmu_disable_counter(idx);
+	pmu_event_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
 }
 
-static void pmu_start(struct arm_pmu *cci_pmu)
+static int cci_pmu_add(struct perf_event *event, int flags)
 {
-	u32 val;
-	unsigned long flags;
-	struct pmu_hw_events *events = cci_pmu->get_hw_events();
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int err = 0;
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	perf_pmu_disable(event->pmu);
 
-	/* Enable all the PMU counters. */
-	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) | CCI_PMCR_CEN;
-	writel(val, cci_ctrl_base + CCI_PMCR);
+	/* If we don't have a space for the counter then finish early. */
+	idx = pmu_get_event_idx(hw_events, event);
+	if (idx < 0) {
+		err = idx;
+		goto out;
+	}
 
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+	event->hw.idx = idx;
+	hw_events->events[idx] = event;
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	if (flags & PERF_EF_START)
+		cci_pmu_start(event, PERF_EF_RELOAD);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+out:
+	perf_pmu_enable(event->pmu);
+	return err;
 }
 
-static void pmu_stop(struct arm_pmu *cci_pmu)
+static void cci_pmu_del(struct perf_event *event, int flags)
 {
-	u32 val;
-	unsigned long flags;
-	struct pmu_hw_events *events = cci_pmu->get_hw_events();
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
 
-	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+	cci_pmu_stop(event, PERF_EF_UPDATE);
+	hw_events->events[idx] = NULL;
+	clear_bit(idx, hw_events->used_mask);
 
-	/* Disable all the PMU counters. */
-	val = readl_relaxed(cci_ctrl_base + CCI_PMCR) & ~CCI_PMCR_CEN;
-	writel(val, cci_ctrl_base + CCI_PMCR);
+	perf_event_update_userpage(event);
+}
 
-	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+static int
+validate_event(struct cci_pmu_hw_events *hw_events,
+	       struct perf_event *event)
+{
+	if (is_software_event(event))
+		return 1;
+
+	if (event->state < PERF_EVENT_STATE_OFF)
+		return 1;
+
+	if (event->state == PERF_EVENT_STATE_OFF && !event->attr.enable_on_exec)
+		return 1;
+
+	return pmu_get_event_idx(hw_events, event) >= 0;
 }
 
-static u32 pmu_read_counter(struct perf_event *event)
+static int
+validate_group(struct perf_event *event)
 {
-	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
-	struct hw_perf_event *hw_counter = &event->hw;
-	int idx = hw_counter->idx;
-	u32 value;
+	struct perf_event *sibling, *leader = event->group_leader;
+	struct cci_pmu_hw_events fake_pmu = {
+		/*
+		 * Initialise the fake PMU. We only need to populate the
+		 * used_mask for the purposes of validation.
+		 */
+		.used_mask = CPU_BITS_NONE,
+	};
 
-	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx))) {
-		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
-		return 0;
+	if (!validate_event(&fake_pmu, leader))
+		return -EINVAL;
+
+	list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+		if (!validate_event(&fake_pmu, sibling))
+			return -EINVAL;
 	}
-	value = pmu_read_register(idx, CCI_PMU_CNTR);
 
-	return value;
+	if (!validate_event(&fake_pmu, event))
+		return -EINVAL;
+
+	return 0;
 }
 
-static void pmu_write_counter(struct perf_event *event, u32 value)
+static int
+__hw_perf_event_init(struct perf_event *event)
 {
-	struct arm_pmu *cci_pmu = to_arm_pmu(event->pmu);
-	struct hw_perf_event *hw_counter = &event->hw;
-	int idx = hw_counter->idx;
+	struct hw_perf_event *hwc = &event->hw;
+	int mapping;
 
-	if (unlikely(!pmu_is_valid_counter(cci_pmu, idx)))
-		dev_err(&cci_pmu->plat_device->dev, "Invalid CCI PMU counter %d\n", idx);
-	else
-		pmu_write_register(value, idx, CCI_PMU_CNTR);
+	mapping = pmu_map_event(event);
+
+	if (mapping < 0) {
+		pr_debug("event %x:%llx not supported\n", event->attr.type,
+			 event->attr.config);
+		return mapping;
+	}
+
+	/*
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet.
+	 */
+	hwc->idx		= -1;
+	hwc->config_base	= 0;
+	hwc->config		= 0;
+	hwc->event_base		= 0;
+
+	/*
+	 * Store the event encoding into the config_base field.
+	 */
+	hwc->config_base	    |= (unsigned long)mapping;
+
+	/*
+	 * Limit the sample_period to half of the counter width. That way, the
+	 * new counter value is far less likely to overtake the previous one
+	 * unless you have some serious IRQ latency issues.
+	 */
+	hwc->sample_period  = CCI_PMU_CNTR_MASK >> 1;
+	hwc->last_period    = hwc->sample_period;
+	local64_set(&hwc->period_left, hwc->sample_period);
+
+	if (event->group_leader != event) {
+		if (validate_group(event) != 0)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cci_pmu_event_init(struct perf_event *event)
+{
+	struct cci_pmu *cci_pmu = to_cci_pmu(event->pmu);
+	atomic_t *active_events = &cci_pmu->active_events;
+	int err = 0;
+	int cpu;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* Shared by all CPUs, no meaningful state to sample */
+	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
+		return -EOPNOTSUPP;
+	
+	/* We have no filtering of any kind */
+	if (event->attr.exclude_user	||
+	    event->attr.exclude_kernel	||
+	    event->attr.exclude_hv	||
+	    event->attr.exclude_idle	||
+	    event->attr.exclude_host	||
+	    event->attr.exclude_guest)
+		return -EINVAL;
+
+	/*
+	 * Following the example set by other "uncore" PMUs, we accept any CPU
+	 * and rewrite its affinity dynamically rather than having perf core
+	 * handle cpu == -1 and pid == -1 for this case.
+	 *
+	 * The perf core will pin online CPUs for the duration of this call and
+	 * the event being installed into its context, so the PMU's CPU can't
+	 * change under our feet.
+	 */
+	cpu = cpumask_first(&cci_pmu->cpus);
+	if (event->cpu < 0 || cpu < 0)
+		return -EINVAL;
+	event->cpu = cpu;
+
+	event->destroy = hw_perf_event_destroy;
+	if (!atomic_inc_not_zero(active_events)) {
+		mutex_lock(&cci_pmu->reserve_mutex);
+		if (atomic_read(active_events) == 0)
+			err = cci_pmu_get_hw(cci_pmu);
+		if (!err)
+			atomic_inc(active_events);
+		mutex_unlock(&cci_pmu->reserve_mutex);
+	}
+	if (err)
+		return err;
+
+	err = __hw_perf_event_init(event);
+	if (err)
+		hw_perf_event_destroy(event);
+	
+	return err;
 }
 
-static int cci_pmu_init(struct arm_pmu *cci_pmu, struct platform_device *pdev)
+static ssize_t pmu_attr_cpumask_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
-	*cci_pmu = (struct arm_pmu){
-		.name		  = pmu_names[probe_cci_revision()],
-		.max_period       = (1LLU << 32) - 1,
-		.get_hw_events    = pmu_get_hw_events,
-		.get_event_idx    = pmu_get_event_idx,
-		.map_event        = pmu_map_event,
-		.request_irq      = pmu_request_irq,
-		.handle_irq       = pmu_handle_irq,
-		.free_irq         = pmu_free_irq,
-		.enable           = pmu_enable_event,
-		.disable          = pmu_disable_event,
-		.start            = pmu_start,
-		.stop             = pmu_stop,
-		.read_counter     = pmu_read_counter,
-		.write_counter    = pmu_write_counter,
+	int n = cpulist_scnprintf(buf, PAGE_SIZE - 2, &pmu->cpus);
+
+	buf[n++] = '\n';
+	buf[n] = '\0';
+	return n;
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, pmu_attr_cpumask_show, NULL);
+
+static struct attribute *pmu_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static struct attribute_group pmu_attr_group = {
+	.attrs = pmu_attrs,
+};
+
+static const struct attribute_group *pmu_attr_groups[] = {
+	&pmu_attr_group,
+	NULL
+};
+
+static int cci_pmu_init(struct cci_pmu *cci_pmu, struct platform_device *pdev)
+{
+	char *name = pmu_names[probe_cci_revision()];
+	cci_pmu->pmu = (struct pmu) {
+		.name		= pmu_names[probe_cci_revision()],
+		.task_ctx_nr	= perf_invalid_context,
+		.pmu_enable	= cci_pmu_enable,
+		.pmu_disable	= cci_pmu_disable,
+		.event_init	= cci_pmu_event_init,
+		.add		= cci_pmu_add,
+		.del		= cci_pmu_del,
+		.start		= cci_pmu_start,
+		.stop		= cci_pmu_stop,
+		.read		= pmu_read,
+		.attr_groups	= pmu_attr_groups,
 	};
 
 	cci_pmu->plat_device = pdev;
 	cci_pmu->num_events = pmu_get_max_counters();
 
-	return armpmu_register(cci_pmu, -1);
+	return perf_pmu_register(&cci_pmu->pmu, name, -1);
 }
 
+static int cci_pmu_cpu_notifier(struct notifier_block *self,
+				unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (long)hcpu;
+	unsigned int target;
+
+	switch (action & ~CPU_TASKS_FROZEN) {
+	case CPU_DOWN_PREPARE:
+		if (!cpumask_test_and_clear_cpu(cpu, &pmu->cpus))
+			break;
+		target = cpumask_any_but(cpu_online_mask, cpu);
+		if (target < 0) // UP, last CPU
+			break;
+		perf_pmu_migrate_context(&pmu->pmu, cpu, target);
+		cpumask_set_cpu(target, &pmu->cpus);
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cci_pmu_cpu_nb = {
+	.notifier_call	= cci_pmu_cpu_notifier,
+	/*
+	 * to migrate uncore events, our notifier should be executed
+	 * before perf core's notifier.
+	 */
+	.priority	= CPU_PRI_PERF + 1,
+};
+
 static const struct of_device_id arm_cci_pmu_matches[] = {
 	{
 		.compatible = "arm,cci-400-pmu",
@@ -604,15 +936,16 @@ static int cci_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pmu->cci_pmu = devm_kzalloc(&pdev->dev, sizeof(*(pmu->cci_pmu)), GFP_KERNEL);
-	if (!pmu->cci_pmu)
-		return -ENOMEM;
-
-	pmu->hw_events.events = pmu->events;
-	pmu->hw_events.used_mask = pmu->used_mask;
 	raw_spin_lock_init(&pmu->hw_events.pmu_lock);
+	mutex_init(&pmu->reserve_mutex);
+	atomic_set(&pmu->active_events, 0);
+	cpumask_set_cpu(smp_processor_id(), &pmu->cpus);
+
+	ret = register_cpu_notifier(&cci_pmu_cpu_nb);
+	if (ret)
+		return ret;
 
-	ret = cci_pmu_init(pmu->cci_pmu, pdev);
+	ret = cci_pmu_init(pmu, pdev);
 	if (ret)
 		return ret;
 
-- 
1.9.1
