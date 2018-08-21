From: nhillery@codeaurora.org (Nathan Hillery)
Date: Tue, 21 Aug 2018 17:45:00 -0400
Subject: [RFC,V5,3/4] perf: qcom: Add PC capture support to CPU PMU
In-Reply-To: <1534887901-24734-1-git-send-email-nhillery@codeaurora.org>
References: <1534887901-24734-1-git-send-email-nhillery@codeaurora.org>
Message-ID: <1534887901-24734-4-git-send-email-nhillery@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Program Counter (PC) capture is an IMPLEMENTATION DEFINED extension to
the ARMv8 PMUv3 that allows more precise PC sampling by storing the PC
in a system register when an event counter overflow occurs. This reduces
skid and allows sampling when interrupts are disabled (since the PMI is
a maskable interrupt in arm64). Note that there is only one PC capture
register, so we only allow one event at a time to use it.

Support for this extension is indicated by the presence of the Falkor or
Saphira PMU device node under a CPU device node in the DSDT ACPI table
containing the u8 _DSD property "qcom,pmu-pcc-support" set to non-zero.
E.g.:

    Device (CPU0)
    {
        Name (_HID, "ACPI0007" /* Processor Device */)
        ...
        Device (PMU0)
        {
            Name (_HID, "QCOM8150") /* Qualcomm Falkor PMU device */
            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"qcom,pmu-pcc-support", 1}
                }
            })
        }
    }

Signed-off-by: Nathan Hillery <nhillery@codeaurora.org>
---
 arch/arm64/include/asm/perf_event.h |  18 +
 arch/arm64/kernel/perf_event.c      | 925 +++++++++++++++++++++++++++++++++++-
 drivers/perf/Makefile               |   2 +-
 drivers/perf/qcom_arm_pmu.c         | 398 ++++++++++++++++
 include/linux/perf_event.h          |   4 +-
 5 files changed, 1325 insertions(+), 22 deletions(-)
 create mode 100644 drivers/perf/qcom_arm_pmu.c

diff --git a/arch/arm64/include/asm/perf_event.h b/arch/arm64/include/asm/perf_event.h
index f9ccc36..76b95a3 100644
--- a/arch/arm64/include/asm/perf_event.h
+++ b/arch/arm64/include/asm/perf_event.h
@@ -24,6 +24,24 @@
 #define	ARMV8_PMU_COUNTER_MASK	(ARMV8_PMU_MAX_COUNTERS - 1)
 
 /*
+ * Perf Events' indices
+ */
+#define	ARMV8_IDX_CYCLE_COUNTER	0
+#define	ARMV8_IDX_COUNTER0	1
+#define	ARMV8_IDX_COUNTER_LAST(cpu_pmu) \
+	(ARMV8_IDX_CYCLE_COUNTER + cpu_pmu->num_events - 1)
+
+/*
+ * ARMv8 low level PMU access
+ */
+
+/*
+ * Perf Event to low level counters mapping
+ */
+#define	ARMV8_IDX_TO_COUNTER(x)	\
+	(((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
+
+/*
  * Per-CPU PMCR: config reg
  */
 #define ARMV8_PMU_PMCR_E	(1 << 0) /* Enable all counters */
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 85a251b..be410e3 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -439,6 +439,11 @@
 	return 0;
 }
 
+static bool armv8pmu_has_long_counter(struct perf_event *event)
+{
+	return !!(event->attr.config & BIT_ULL(32));
+}
+
 static struct attribute_group armv8_pmuv3_events_attr_group = {
 	.name = "events",
 	.attrs = armv8_pmuv3_event_attrs,
@@ -446,9 +451,11 @@
 };
 
 PMU_FORMAT_ATTR(event, "config:0-15");
+PMU_FORMAT_ATTR(lc,    "config:32");
 
 static struct attribute *armv8_pmuv3_format_attrs[] = {
 	&format_attr_event.attr,
+	&format_attr_lc.attr,
 	NULL,
 };
 
@@ -457,6 +464,43 @@
 	.attrs = armv8_pmuv3_format_attrs,
 };
 
+#define QC_ATTR_PCC    BIT(8)
+PMU_FORMAT_ATTR(pcc,   "config2:8");
+
+/* NRCCG format for qc perf raw codes. */
+PMU_FORMAT_ATTR(prefix, "config2:16-19");
+PMU_FORMAT_ATTR(reg,    "config2:12-15");
+PMU_FORMAT_ATTR(code,   "config2:4-11");
+PMU_FORMAT_ATTR(group,  "config2:0-3");
+
+static struct attribute *qc_ev_formats[] = {
+	&format_attr_event.attr,
+	&format_attr_lc.attr,
+	&format_attr_group.attr,
+	&format_attr_code.attr,
+	&format_attr_reg.attr,
+	&format_attr_prefix.attr,
+	&format_attr_pcc.attr,
+	NULL,
+};
+
+static struct attribute_group qc_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = qc_ev_formats,
+};
+
+static u32 armv8pmu_event_mask;
+static bool qc_pmu;
+static bool qc_pcc_support;
+static bool qc_rbb_support;
+static void qc_pmu_enable_event(struct perf_event *event,
+				struct hw_perf_event *hwc, int idx);
+static void qc_pmu_disable_event(struct perf_event *event,
+				 struct hw_perf_event *hwc);
+static void qc_handle_irq(struct perf_event *event, struct pt_regs *regs,
+			  struct perf_sample_data *datap);
+static void qc_branch_dump(struct perf_sample_data *datap);
+
 /*
  * Perf Events' indices
  */
@@ -512,19 +556,29 @@ static inline int armv8pmu_select_counter(int idx)
 	return idx;
 }
 
-static inline u32 armv8pmu_read_counter(struct perf_event *event)
+static inline u64 armv8pmu_read_counter(struct perf_event *event)
 {
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
-	u32 value = 0;
+	u64 value = 0;
+	u64 value_high;
 
 	if (!armv8pmu_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u reading wrong counter %d\n",
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER)
 		value = read_sysreg(pmccntr_el0);
-	else if (armv8pmu_select_counter(idx) == idx)
+	else if (armv8pmu_has_long_counter(event)) {
+		armv8pmu_select_counter(idx + 1);
+		do {
+			value_high = read_sysreg(pmxevcntr_el0);
+			armv8pmu_select_counter(idx);
+			value = read_sysreg(pmxevcntr_el0);
+			armv8pmu_select_counter(idx + 1);
+		} while (read_sysreg(pmxevcntr_el0) != value_high);
+		value |= value_high << 32;
+	} else if (armv8pmu_select_counter(idx) == idx)
 		value = read_sysreg(pmxevcntr_el0);
 
 	return value;
@@ -535,21 +589,30 @@ static inline void armv8pmu_write_counter(struct perf_event *event, u32 value)
 	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx;
+	bool long_counter = armv8pmu_has_long_counter(event);
 
 	if (!armv8pmu_counter_valid(cpu_pmu, idx))
 		pr_err("CPU%u writing wrong counter %d\n",
 			smp_processor_id(), idx);
 	else if (idx == ARMV8_IDX_CYCLE_COUNTER) {
-		/*
-		 * Set the upper 32bits as this is a 64bit counter but we only
-		 * count using the lower 32bits and we want an interrupt when
-		 * it overflows.
-		 */
+		u64 value64 = value;
+
+		if (!long_counter)
+			/*
+			 * If using this as a 32 bit counter set the upper
+			 * 32 bits so we only count using the lower 32 bits
+			 * and will get an interrupt when it overflows.
+			 */
 		u64 value64 = 0xffffffff00000000ULL | value;
 
 		write_sysreg(value64, pmccntr_el0);
-	} else if (armv8pmu_select_counter(idx) == idx)
+	} else if (armv8pmu_select_counter(idx) == idx) {
 		write_sysreg(value, pmxevcntr_el0);
+		if (long_counter) {
+			armv8pmu_select_counter(idx + 1);
+			write_sysreg(0, pmxevcntr_el0);
+		}
+	}
 }
 
 static inline void armv8pmu_write_evtype(int idx, u32 val)
@@ -626,15 +689,35 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	 */
 	armv8pmu_disable_counter(idx);
 
-	/*
-	 * Set event (if destined for PMNx counters).
-	 */
-	armv8pmu_write_evtype(idx, hwc->config_base);
+	if (qc_pmu)
+		qc_pmu_enable_event(event, hwc, idx);
+	else
+		/*
+		 * Set event (if destined for PMNx counters).
+		 */
+		armv8pmu_write_evtype(idx, hwc->config_base);
 
 	/*
-	 * Enable interrupt for this counter
+	 * If chaining, repeat for the chained counter
 	 */
-	armv8pmu_enable_intens(idx);
+	if (cpu_pmu->has_long_counter(event) &&
+	    (idx != ARMV8_IDX_CYCLE_COUNTER)) {
+		/* ISB required per ARM ARM */
+		isb();
+		armv8pmu_disable_counter(idx + 1);
+		/* Keep flags, replace event with chaining event */
+		armv8pmu_write_evtype(idx + 1,
+			      (hwc->config_base & ~armv8pmu_event_mask) |
+			      ARMV8_PMUV3_PERFCTR_CHAIN);
+		armv8pmu_enable_intens(idx + 1);
+		armv8pmu_enable_counter(idx + 1);
+		isb();
+	} else {
+		/*
+		 * Enable interrupt for this counter, only for non-chained
+		 */
+		armv8pmu_enable_intens(idx);
+	}
 
 	/*
 	 * Enable counter
@@ -662,10 +745,21 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	 */
 	armv8pmu_disable_counter(idx);
 
-	/*
-	 * Disable interrupt for this counter
-	 */
-	armv8pmu_disable_intens(idx);
+	if (qc_pmu)
+		qc_pmu_disable_event(event, hwc);
+
+	if (cpu_pmu->has_long_counter(event) &&
+	    (idx != ARMV8_IDX_CYCLE_COUNTER)) {
+		/* ISB required per ARM ARM */
+		isb();
+		armv8pmu_disable_counter(idx + 1);
+		armv8pmu_disable_intens(idx + 1);
+	} else {
+		/*
+		 * Disable interrupt for this counter, only if not chained
+		 */
+		armv8pmu_disable_intens(idx);
+	}
 
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
 }
@@ -677,6 +771,7 @@ static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
 	struct arm_pmu *cpu_pmu = (struct arm_pmu *)dev;
 	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
 	struct pt_regs *regs;
+	struct pt_regs regs_copy;
 	int idx;
 
 	/*
@@ -695,6 +790,15 @@ static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
 	 */
 	regs = get_irq_regs();
 
+	if (qc_pmu) {
+		/*
+		 * Prepare to update regs->pc with pcc, but only update local
+		 * copy, not the actual irq regs
+		 */
+		regs_copy = *regs;
+		regs = &regs_copy;
+	}
+
 	for (idx = 0; idx < cpu_pmu->num_events; ++idx) {
 		struct perf_event *event = cpuc->events[idx];
 		struct hw_perf_event *hwc;
@@ -716,10 +820,16 @@ static irqreturn_t armv8pmu_handle_irq(int irq_num, void *dev)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		if (qc_pmu)
+			qc_handle_irq(event, regs, &data);
+
 		if (perf_event_overflow(event, &data, regs))
 			cpu_pmu->disable(event);
 	}
 
+	if (cpu_pmu->hw_config)
+		cpu_pmu->hw_config(ARMPMU_CALLCHAIN_CLEAR, NULL, 0);
+
 	/*
 	 * Handle the pending perf events.
 	 *
@@ -771,6 +881,34 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	/*
 	 * Otherwise use events counters
 	 */
+	if (cpu_pmu->has_long_counter(event)) {
+		unsigned int num_basic_counters = cpu_pmu->num_events - 1;
+		DECLARE_BITMAP(shifted_used_mask, ARMPMU_MAX_HWEVENTS);
+
+		/*
+		 * used_mask has the cycle counter in bit 0, then
+		 * even numbered counters are in odd-numbered positions
+		 * within the mask. For a chained pair of counters we need
+		 * an even/odd pair of counters. Shift the mask so that
+		 * even counters are in even positions in the mask, which
+		 * allows bitmap_find_next_zero_area to return a correctly
+		 * aligned pair of bits.
+		 */
+		bitmap_shift_right(shifted_used_mask, cpuc->used_mask, 1,
+				  num_basic_counters);
+		idx = bitmap_find_next_zero_area(shifted_used_mask,
+						 num_basic_counters, 0, 2, 1);
+		if (idx >= num_basic_counters)
+			return -EAGAIN;
+
+		/* Rebase into original mask offset */
+		idx++;
+
+		bitmap_set(cpuc->used_mask, idx, 2);
+		cpuc->events[idx + 1] = event;
+		return idx;
+	}
+
 	for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
 		if (!test_and_set_bit(idx, cpuc->used_mask))
 			return idx;
@@ -780,6 +918,24 @@ static int armv8pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	return -EAGAIN;
 }
 
+static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
+				     struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+
+	/*
+	 * For chaining, clear the used_mask for the
+	 * second of the two adjacent counters
+	 */
+	if (cpu_pmu->has_long_counter(event) &&
+	    (idx != ARMV8_IDX_CYCLE_COUNTER)) {
+		cpuc->events[idx + 1] = NULL;
+		clear_bit(idx + 1, cpuc->used_mask);
+	}
+}
+
 /*
  * Add an event filter to a given event. This will only work for PMUv2 PMUs.
  */
@@ -867,6 +1023,617 @@ static int armv8_pmuv3_map_event(struct perf_event *event)
 	return __armv8_pmuv3_map_event(event, NULL, NULL);
 }
 
+/*
+ * Events for Qualcomm Technologies CPU PMU can be envisioned as a 2D
+ * array. Each column represents a group of events. There are 8 groups.
+ * Only one entry from each group can be in use at a time.
+ *
+ * There are several of these arrays, each controlled by a Region Event
+ * Selection Register (RESR).
+ *
+ * To distinguish Qualcomm Technologies events from ARM architecural events
+ * there is a prefix value specified in event encoding. Currently the only
+ * non-0 value defined is 1.
+ *
+ * Qualcomm Technologies events are specified as 0xNRCCG, where:
+ *   N  = Prefix (1 = Qualcomm Technologies events)
+ *   R  = RESR
+ *   CC = code (2 hex digits specifying array row)
+ *   G  = group (array column).
+ *
+ * In addition the ARM architecural events are also supported. They are
+ * differentiated from the Qualcomm Technologies events by having Prefix = 0.
+ */
+#define pmresr0_el0         sys_reg(3, 5, 11, 3, 0)
+#define pmresr1_el0         sys_reg(3, 5, 11, 3, 2)
+#define pmresr2_el0         sys_reg(3, 5, 11, 3, 4)
+#define pmxevcntcr_el0      sys_reg(3, 5, 11, 0, 3)
+#define pmpccptr_el0        sys_reg(3, 5, 11, 4, 0)
+#define pmpccptcr0_el0      sys_reg(3, 5, 11, 4, 1)
+
+#define PCCPTR_UNAUTH       BIT(0)
+#define PCC_CPT_PME0        BIT(0)
+#define PCC_CPT_EVENT(x)    (PCC_CPT_PME0 << (x))
+#define PCC_CPT_PMOVNEVT0   BIT(16)
+#define PCC_CPT_EVENT_OV(x) (PCC_CPT_PMOVNEVT0 << (x))
+
+#define QC_RESR_ENABLE      BIT_ULL(63)
+
+#define QC_EVT_PREFIX       1
+#define QC_EVT_PFX_SHIFT    16
+#define QC_EVT_REG_SHIFT    12
+#define QC_EVT_CODE_SHIFT   4
+#define QC_EVT_GRP_SHIFT    0
+#define QC_EVT_MASK         GENMASK(QC_EVT_PFX_SHIFT + 3,  0)
+#define QC_EVT_PFX_MASK     GENMASK(QC_EVT_PFX_SHIFT + 3,  QC_EVT_PFX_SHIFT)
+#define QC_EVT_REG_MASK     GENMASK(QC_EVT_REG_SHIFT + 3,  QC_EVT_REG_SHIFT)
+#define QC_EVT_CODE_MASK    GENMASK(QC_EVT_CODE_SHIFT + 7, QC_EVT_CODE_SHIFT)
+#define QC_EVT_GRP_MASK     GENMASK(QC_EVT_GRP_SHIFT + 3,  QC_EVT_GRP_SHIFT)
+#define QC_EVT_PFX(event)   (((event) & QC_EVT_PFX_MASK)  >> QC_EVT_PFX_SHIFT)
+#define QC_EVT_REG(event)   (((event) & QC_EVT_REG_MASK)  >> QC_EVT_REG_SHIFT)
+#define QC_EVT_CODE(event)  (((event) & QC_EVT_CODE_MASK) >> QC_EVT_CODE_SHIFT)
+#define QC_EVT_GROUP(event) (((event) & QC_EVT_GRP_MASK)  >> QC_EVT_GRP_SHIFT)
+
+#define QC_GROUPS_PER_REG   8
+#define QC_BITS_PER_GROUP   8
+#define QC_MAX_GROUP        7
+#define QC_FALKOR_MAX_RESR  2
+
+/*
+ * No CPU implementation can exceed this number of RESRS
+ *
+ * Used as a sanity check: detect a future CPU with number of RESRs * groups
+ * which exceeds the size of the event_conflicts element.
+ */
+#define QC_MAX_RESRS (ARMPMU_MAX_EVENT_CONFLICTS / (QC_MAX_GROUP + 1))
+
+static int qc_max_resr;
+static DEFINE_PER_CPU(u32[QC_MAX_RESRS][QC_MAX_GROUP + 1], qc_saved_cc);
+
+static const u8 qc_evt_type_base[3] = {0xd8, 0xe0, 0xe8};
+
+static inline void qc_write_pmxevcntcr(u32 val)
+{
+	write_sysreg_s(val, pmxevcntcr_el0);
+}
+
+static void qc_write_pmresr(int reg, u64 val)
+{
+	if (reg > qc_max_resr)
+		return;
+
+	switch (reg) {
+	case 0:
+		write_sysreg_s(val, pmresr0_el0);
+		break;
+	case 1:
+		write_sysreg_s(val, pmresr1_el0);
+		break;
+	case 2:
+		write_sysreg_s(val, pmresr2_el0);
+		break;
+	}
+}
+
+static u64 qc_read_pmresr(int reg)
+{
+	u64 val = 0;
+
+	if (reg > qc_max_resr)
+		return 0;
+
+	switch (reg) {
+	case 0:
+		val = read_sysreg_s(pmresr0_el0);
+		break;
+	case 1:
+		val = read_sysreg_s(pmresr1_el0);
+		break;
+	case 2:
+		val = read_sysreg_s(pmresr2_el0);
+		break;
+	}
+
+	return val;
+}
+
+static inline u64 qc_get_columnmask(u32 group)
+{
+	u32 shift = QC_BITS_PER_GROUP * group;
+	u32 mask_size = QC_BITS_PER_GROUP;
+
+	/*
+	 * The max group is 1 bit smaller than the other groups,
+	 * because the MS bit in the register is the enable.
+	 */
+	if (group == QC_MAX_GROUP)
+		mask_size--;
+
+	return GENMASK_ULL(shift + mask_size - 1, shift);
+}
+
+static void qc_set_resr(int reg, int code, int group)
+{
+	u64 val;
+
+	val = qc_read_pmresr(reg) & ~qc_get_columnmask(group);
+	val |= ((u64)code << (group * QC_BITS_PER_GROUP));
+	val |= QC_RESR_ENABLE;
+	qc_write_pmresr(reg, val);
+}
+
+static void qc_clear_resr(int reg, int group)
+{
+	u64 val = qc_read_pmresr(reg) & ~qc_get_columnmask(group);
+
+	qc_write_pmresr(reg, val);
+}
+
+static void qc_clear_resrs(void)
+{
+	unsigned int i;
+
+	for (i = 0; i <= qc_max_resr; i++)
+		qc_write_pmresr(i, 0);
+}
+
+static void qc_pmu_reset(void *info)
+{
+	qc_clear_resrs();
+	armv8pmu_reset(info);
+}
+
+static int qc_verify_event(struct perf_event *event)
+{
+	struct perf_event *sibling;
+	u8 prefix  = QC_EVT_PFX(event->attr.config);
+	u8 reg     = QC_EVT_REG(event->attr.config);
+	u8 code    = QC_EVT_CODE(event->attr.config);
+	u8 group   = QC_EVT_GROUP(event->attr.config);
+
+	/* No prefix, so not a qc event - nothing else to verify */
+	if (!prefix)
+		return 0;
+
+	if ((group > QC_MAX_GROUP) || (reg > qc_max_resr) ||
+	    (prefix != QC_EVT_PREFIX))
+		return -ENOENT;
+
+	/* Column exclusion for the same reg and group, but a different code */
+
+	if ((event != event->group_leader) &&
+	    (QC_EVT_PFX(event->group_leader->attr.config) == QC_EVT_PREFIX) &&
+	    (QC_EVT_REG(event->group_leader->attr.config) == reg) &&
+	    (QC_EVT_GROUP(event->group_leader->attr.config) == group) &&
+	    (QC_EVT_CODE(event->group_leader->attr.config) != code)) {
+		pr_debug_ratelimited(
+			 "Column exclusion: conflicting events %llx %llx\n",
+		       event->group_leader->attr.config,
+		       event->attr.config);
+		return -ENOENT;
+	}
+
+	list_for_each_entry(sibling, &event->group_leader->sibling_list,
+			    group_entry) {
+		if ((sibling != event) &&
+		    (QC_EVT_PFX(sibling->attr.config) == QC_EVT_PREFIX) &&
+		    (QC_EVT_REG(sibling->attr.config) == reg) &&
+		    (QC_EVT_GROUP(sibling->attr.config) == group) &&
+		    (QC_EVT_CODE(sibling->attr.config) != code)) {
+			pr_debug_ratelimited(
+			     "Column exclusion: conflicting events %llx %llx\n",
+					    sibling->attr.config,
+					    event->attr.config);
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
+
+static void qc_pmu_enable_event(struct perf_event *event,
+				struct hw_perf_event *hwc, int idx)
+{
+	unsigned int reg, code, group;
+	u64 pcc;
+
+	if (QC_EVT_PFX(hwc->config_base) != QC_EVT_PREFIX) {
+		armv8pmu_write_evtype(idx, hwc->config_base & ~QC_ATTR_PCC);
+		if (hwc->config_base & QC_ATTR_PCC) {
+			pcc = PCC_CPT_EVENT(idx - ARMV8_IDX_COUNTER0) |
+				PCC_CPT_EVENT_OV(idx - ARMV8_IDX_COUNTER0);
+			write_sysreg_s(pcc, pmpccptcr0_el0);
+		}
+		return;
+	}
+
+	reg = QC_EVT_REG(hwc->config_base);
+	code = QC_EVT_CODE(hwc->config_base);
+	group = QC_EVT_GROUP(hwc->config_base);
+
+	armv8pmu_write_evtype(idx,
+			      (hwc->config_base & ~QC_EVT_MASK) |
+			      qc_evt_type_base[reg] | group);
+	qc_write_pmxevcntcr(0);
+	qc_set_resr(reg, code, group);
+}
+
+static void qc_pmu_disable_event(struct perf_event *event,
+				 struct hw_perf_event *hwc)
+{
+	u64 pcc;
+
+	if (QC_EVT_PFX(hwc->config_base) == QC_EVT_PREFIX) {
+		qc_clear_resr(QC_EVT_REG(hwc->config_base),
+			      QC_EVT_GROUP(hwc->config_base));
+	} else {
+		if (hwc->config_base & QC_ATTR_PCC) {
+			pcc = read_sysreg_s(pmpccptcr0_el0);
+			pcc &= ~(PCC_CPT_EVENT(hwc->idx - ARMV8_IDX_COUNTER0) |
+			       PCC_CPT_EVENT_OV(hwc->idx - ARMV8_IDX_COUNTER0));
+			write_sysreg_s(pcc, pmpccptcr0_el0);
+		}
+	}
+}
+
+static int qc_get_event_idx(struct pmu_hw_events *cpuc,
+			    struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int bit = -1;
+	int cpu;
+	unsigned int reg, code, group;
+
+	/*
+	 * Check for column exclusion: event column already in use by another
+	 * event. This is for events which are not in the same group.
+	 * Conflicting events in the same group are detected in event_init.
+	 */
+	if (QC_EVT_PFX(hwc->config_base) == QC_EVT_PREFIX) {
+		reg = QC_EVT_REG(hwc->config_base);
+		code = QC_EVT_CODE(hwc->config_base);
+		group = QC_EVT_GROUP(hwc->config_base);
+		cpu = smp_processor_id();
+
+		bit = reg * QC_GROUPS_PER_REG + group;
+		if (test_bit(bit, cpuc->event_conflicts)) {
+			/*
+			 * If this is a duplicate event, but the CC is the
+			 * same as for the existing event, then allow it,
+			 * because the filter bits may be different.
+			 * Otherwise fail for column exclusion.
+			 */
+			if (per_cpu(qc_saved_cc[reg][group], cpu) != code) {
+				pr_err("column exclusion error for evt %lx\n",
+				       hwc->config_base & armv8pmu_event_mask);
+				return -EAGAIN;
+			}
+		}
+	} else {
+		/*
+		 * PCC is only supported for architected events.
+		 * If PCC was specified, but PCC is not supported by h/w,
+		 * remove the PCC flag so we default to using regular PC and
+		 * don't try to access the non-supported PCC registers.
+		 */
+		if ((hwc->config_base & QC_ATTR_PCC) && !qc_pcc_support)
+			hwc->config_base = hwc->config_base & ~QC_ATTR_PCC;
+	}
+
+	idx = armv8pmu_get_event_idx(cpuc, event);
+
+	if ((idx >= 0) && (bit >= 0)) {
+		set_bit(bit, cpuc->event_conflicts);
+		per_cpu(qc_saved_cc[reg][group], cpu) = code;
+	}
+
+	return idx;
+}
+
+static void qc_clear_event_idx(struct pmu_hw_events *cpuc,
+			    struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	unsigned int reg, group;
+
+	armv8pmu_clear_event_idx(cpuc, event);
+
+	if (QC_EVT_PFX(hwc->config_base) == QC_EVT_PREFIX) {
+		reg = QC_EVT_REG(hwc->config_base);
+		group = QC_EVT_GROUP(hwc->config_base);
+		clear_bit(reg * QC_GROUPS_PER_REG + group,
+			  cpuc->event_conflicts);
+	}
+}
+
+static void qc_handle_irq(struct perf_event *event, struct pt_regs *regs,
+			  struct perf_sample_data *datap)
+{
+	u64 pcc;
+	struct hw_perf_event *hwc = &event->hw;
+
+	/*
+	 * If the sampling event specified PCC & no callchain,
+	 * replace PC with valid PCC value
+	 */
+	if (is_sampling_event(event) &&
+	    (hwc->config_base & QC_ATTR_PCC) &&
+	    !(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)) {
+		pcc = read_sysreg_s(pmpccptr_el0);
+		if (!(pcc & PCCPTR_UNAUTH))
+			regs->pc = pcc;
+	}
+
+	/* Branch sampling, not call stack - copy branches into data */
+	if (is_sampling_event(event) && has_branch_stack(event) &&
+	    !(event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK))
+		qc_branch_dump(datap);
+}
+
+static int qc_callchain_invalidate_and_clear(void)
+{
+	u64 cr;
+
+	cr = read_sysreg_s(pmrbbcr_el0);
+	if (!(cr & RBB_CR_EN))
+		return -EINVAL;
+
+	cr |= RBB_CR_INVLCLR;
+	write_sysreg_s(cr, pmrbbcr_el0);
+	return 0;
+}
+
+static void qc_sched_task(struct perf_event_context *ctx,
+			    bool sched_in)
+{
+	if (sched_in)
+		qc_callchain_invalidate_and_clear();
+}
+
+static u64 qc_callchain_get_cr(struct perf_event *event)
+{
+	u64 new_cr;
+	u64 br_sample = event->attr.branch_sample_type;
+
+	if (br_sample & PERF_SAMPLE_BRANCH_CALL_STACK) {
+		new_cr = RBB_CR_CALLCHAIN;
+	} else {
+		new_cr = RBB_CR_CONFIG_MASK & ~RBB_CR_POPRET;
+		if (br_sample & PERF_SAMPLE_BRANCH_ANY)
+			new_cr &= ~(RBB_CR_FBC | RBB_CR_FBR | RBB_CR_FBI |
+				    RBB_CR_FDBNCR);
+		if (br_sample & PERF_SAMPLE_BRANCH_ANY_CALL)
+			new_cr &= ~RBB_CR_FBC;
+		if (br_sample & PERF_SAMPLE_BRANCH_ANY_RETURN)
+			new_cr &= ~RBB_CR_FBR;
+		if (br_sample & PERF_SAMPLE_BRANCH_IND_CALL)
+			new_cr &= ~RBB_CR_FBI;
+		if (br_sample & PERF_SAMPLE_BRANCH_USER)
+			new_cr &= ~RBB_CR_FEL0NS;
+		if (br_sample & PERF_SAMPLE_BRANCH_KERNEL)
+			new_cr &= ~RBB_CR_FEL1NS;
+	}
+
+	if (event->attr.exclude_user)
+		new_cr |= RBB_CR_FEL0NS;
+	if (event->attr.exclude_kernel)
+		new_cr |= RBB_CR_FEL1NS;
+
+	return new_cr;
+}
+
+static void qc_callchain_add(struct perf_event *event, int idx)
+{
+	u64 cr;
+	u64 new_cr;
+
+	 /* enable callback to invalidate buffer on context switch */
+	perf_sched_cb_inc(event->ctx->pmu);
+
+	new_cr = qc_callchain_get_cr(event);
+	cr = read_sysreg_s(pmrbbcr_el0);
+
+	if (cr & RBB_CR_EN) {
+		/*
+		 * If it's already enabled, and not using our options,
+		 * don't do anything, because someone else may be using RBB
+		 */
+		if ((cr & RBB_CR_CONFIG_MASK) != new_cr) {
+			pr_err("CRs don't match: actual %llx new %llx\n",
+			       cr & RBB_CR_CALLCHAIN_MASK, new_cr);
+			return;
+		}
+		/* if already enabled for our config, just add in this idx */
+		cr |= RBB_CR_EVENT(idx) | RBB_CR_EVENT_OV(idx);
+	} else {
+		/* Not enabled - first time use */
+		cr = RBB_CR_EN | new_cr |
+			RBB_CR_EVENT(idx) | RBB_CR_EVENT_OV(idx);
+	}
+
+	write_sysreg_s(cr, pmrbbcr_el0);
+	qc_callchain_invalidate_and_clear();
+	/* clear lock */
+	write_sysreg_s(0, pmrbbsr_el0);
+}
+
+static void qc_callchain_del(struct perf_event *event, int idx)
+{
+	u64 cr;
+	u64 new_cr;
+
+	/* disable callback to invalidate buffer on context switch */
+	perf_sched_cb_dec(event->ctx->pmu);
+
+	new_cr = qc_callchain_get_cr(event);
+	cr = read_sysreg_s(pmrbbcr_el0);
+	/* if it's not set up for our config, do nothing */
+	if ((cr & RBB_CR_CONFIG_MASK) != new_cr)
+		return;
+
+	/* clear the specified event idx */
+	cr &= ~(RBB_CR_EVENT(idx) | RBB_CR_EVENT_OV(idx));
+
+	/* if there are no other events enabled, disable rbb */
+	if ((cr & RBB_CR_EVENT_MASK) == 0)
+		cr &= ~RBB_CR_EN;
+
+	write_sysreg_s(cr, pmrbbcr_el0);
+}
+
+struct cpu_hw_events {
+	bool                            initialised;
+	struct perf_branch_stack	rbb_stack;
+	struct perf_branch_entry	rbb_entries[RBB_BUFSIZE];
+};
+
+static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
+	.initialised = false
+};
+
+static void qc_callchain(enum armpmu_callchain action,
+			 struct perf_event *event, int idx)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!cpuc->initialised) {
+		write_sysreg_s(0, pmrbbcr_el0);
+		cpuc->initialised = true;
+	}
+
+	if (action == ARMPMU_CALLCHAIN_CLEAR) {
+		if (!qc_callchain_invalidate_and_clear())
+			/* Clear lock */
+			write_sysreg_s(0, pmrbbsr_el0);
+		return;
+	}
+
+	/* No support for cycle counter event */
+	if (idx < ARMV8_IDX_COUNTER0)
+		return;
+
+	idx -= ARMV8_IDX_COUNTER0;
+
+	if (action == ARMPMU_CALLCHAIN_ADD)
+		qc_callchain_add(event, idx);
+	else if (action == ARMPMU_CALLCHAIN_DEL)
+		qc_callchain_del(event, idx);
+}
+
+static void qc_branch_dump(struct perf_sample_data *datap)
+{
+	int idx;
+	int saved_idx;
+	int i;
+	u64 sr;
+	u64 inst;
+	u64 targ;
+	int count = 0;
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	sr = read_sysreg_s(pmrbbsr_el0);
+
+	/* don't do anything if rbb is not locked */
+	if (!(sr & RBB_SR_LOCK))
+		return;
+
+	idx = read_sysreg_s(pmrbbptr_el0);
+	saved_idx = idx;
+
+	for (i = 0; i < RBB_BUFSIZE; i++) {
+		idx = (idx - 1) & RBB_PTR_MASK;
+		write_sysreg_s(idx, pmrbbptr_el0);
+		isb();
+
+		inst = read_sysreg_s(pmrbbxinst_el0);
+		if (!(inst & RBB_XINST_VALID))
+			break;
+		if (inst & RBB_XINST_UNAUTH)
+			continue;
+		inst &= RBB_XINST_ADDR_MASK;
+		if (inst & RBB_XINST_ADDR_MS)
+			inst |= RBB_XINST_SIGN_EXTEND;
+		targ = read_sysreg_s(pmrbbxtar_el0);
+		if (targ & RBB_XINST_ADDR_MS)
+			targ |= RBB_XINST_SIGN_EXTEND;
+
+		cpuc->rbb_entries[i].from	= inst;
+		cpuc->rbb_entries[i].to		= targ;
+		cpuc->rbb_entries[i].mispred	= 0;
+		cpuc->rbb_entries[i].predicted	= 0;
+		cpuc->rbb_entries[i].in_tx	= 0;
+		cpuc->rbb_entries[i].abort	= 0;
+		cpuc->rbb_entries[i].cycles	= 0;
+		cpuc->rbb_entries[i].reserved	= 0;
+		count++;
+	}
+
+	cpuc->rbb_stack.nr = count;
+	datap->br_stack = &cpuc->rbb_stack;
+	write_sysreg_s(saved_idx, pmrbbptr_el0);
+}
+
+static int qc_callchain_dump(struct perf_callchain_entry_ctx *entry)
+{
+	int idx;
+	int saved_idx;
+	int i;
+	u64 ip;
+	u64 sr;
+	u64 pcc_ptr;
+	u64 inst;
+
+	sr = read_sysreg_s(pmrbbsr_el0);
+
+	/* don't do anything if rbb is not locked */
+	if (!(sr & RBB_SR_LOCK))
+		return -EINVAL;
+
+	idx = read_sysreg_s(pmrbbptr_el0);
+	saved_idx = idx;
+	pcc_ptr = read_sysreg_s(pmrbbpc_el0);
+
+	/*
+	 * UNAUTH or !VALID can happen when there are no valid entries. This can
+	 * happen when there are no un-returned function calls between the last
+	 * sample and this one.
+	 */
+	if ((pcc_ptr & RBBPC_UNAUTH) || !(pcc_ptr & RBBPC_VALID))
+		return -EINVAL;
+
+	ip = pcc_ptr & RBBPC_PCSAMPLE_MASK;
+	perf_callchain_store(entry, ip);
+
+	for (i = 0; i < RBB_BUFSIZE; i++) {
+		idx = (idx - 1) & RBB_PTR_MASK;
+		write_sysreg_s(idx, pmrbbptr_el0);
+		isb();
+
+		inst = read_sysreg_s(pmrbbxinst_el0);
+		if (!(inst & RBB_XINST_VALID))
+			break;
+		if (inst & RBB_XINST_UNAUTH)
+			continue;
+		inst &= RBB_XINST_ADDR_MASK;
+		if (inst & RBB_XINST_ADDR_MS)
+			inst |= RBB_XINST_SIGN_EXTEND;
+
+		perf_callchain_store(entry, inst);
+	}
+
+	write_sysreg_s(saved_idx, pmrbbptr_el0);
+
+	/*
+	 * RBB is cleared, invalidated and unlocked by irq handler call to
+	 * armpmu->hw_config(ARMPMU_CALLCHAIN_CLEAR), because this function may
+	 * be called more than once (kernel and user) so we can't clear
+	 * it here.
+	 */
+
+	return 0;
+}
+
 static int armv8_a53_map_event(struct perf_event *event)
 {
 	return __armv8_pmuv3_map_event(event, NULL, &armv8_a53_perf_cache_map);
@@ -899,6 +1666,30 @@ struct armv8pmu_probe_info {
 	bool present;
 };
 
+static int armv8_qc_map_event(struct perf_event *event)
+{
+	int err;
+	int hw_event_id;
+	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
+
+	err = qc_verify_event(event);
+	if (err < 0)
+		return err;
+
+	hw_event_id = armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				       &armv8_pmuv3_perf_cache_map,
+				       QC_EVT_MASK);
+	if (hw_event_id < 0)
+		return hw_event_id;
+
+	/* disable micro/arch events not supported by this PMU */
+	if ((hw_event_id < ARMV8_PMUV3_MAX_COMMON_EVENTS) &&
+	    !test_bit(hw_event_id, armpmu->pmceid_bitmap))
+		return -EOPNOTSUPP;
+
+	return hw_event_id;
+}
+
 static void __armv8pmu_probe_pmu(void *info)
 {
 	struct armv8pmu_probe_info *probe = info;
@@ -949,6 +1740,7 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int ret = armv8pmu_probe_pmu(cpu_pmu);
+
 	if (ret)
 		return ret;
 
@@ -958,11 +1750,14 @@ static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->read_counter		= armv8pmu_read_counter,
 	cpu_pmu->write_counter		= armv8pmu_write_counter,
 	cpu_pmu->get_event_idx		= armv8pmu_get_event_idx,
+	cpu_pmu->clear_event_idx	= armv8pmu_clear_event_idx,
 	cpu_pmu->start			= armv8pmu_start,
 	cpu_pmu->stop			= armv8pmu_stop,
 	cpu_pmu->reset			= armv8pmu_reset,
 	cpu_pmu->max_period		= (1LLU << 32) - 1,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+	cpu_pmu->has_long_counter	= armv8pmu_has_long_counter;
+	armv8pmu_event_mask		= ARMV8_PMU_EVTYPE_EVENT;
 
 	return 0;
 }
@@ -1095,6 +1890,43 @@ static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
 	return 0;
 }
 
+static int armv8_falkor_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	int ret = armv8_pmu_init(cpu_pmu);
+
+	if (ret)
+		return ret;
+
+	cpu_pmu->name			= "qcom_pmuv3";
+	cpu_pmu->map_event		= armv8_qc_map_event;
+	cpu_pmu->reset			= qc_pmu_reset;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_EVENTS] =
+		&armv8_pmuv3_events_attr_group;
+	cpu_pmu->attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&qc_pmu_format_attr_group;
+	cpu_pmu->get_event_idx		= qc_get_event_idx;
+	cpu_pmu->clear_event_idx	= qc_clear_event_idx;
+
+	armv8pmu_event_mask		= ARMV8_QC_EVTYPE_EVENT;
+	qc_max_resr = QC_FALKOR_MAX_RESR;
+	qc_clear_resrs();
+	qc_pmu = true;
+
+	if (qc_max_resr > QC_MAX_RESRS) {
+		/* Sanity check */
+		pr_err("qcom_pmuv3: max number of RESRs exceeded\n");
+		return -EINVAL;
+	}
+
+	if (qc_rbb_support) {
+		cpu_pmu->hw_config	= qc_callchain;
+		cpu_pmu->pmu.sched_task = qc_sched_task;
+		perf_register_callchain_dump(qc_callchain_dump);
+	}
+
+	return 0;
+}
+
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
 	{.compatible = "arm,cortex-a35-pmu",	.data = armv8_a35_pmu_init},
@@ -1112,6 +1944,47 @@ static int armv8_pmu_device_probe(struct platform_device *pdev)
 	return arm_pmu_device_probe(pdev, armv8_pmu_of_device_ids, NULL);
 }
 
+static const struct acpi_device_id qcom_pmu_extensions_acpi_match[] = {
+	{ "QCOM8150", },
+	{ }
+};
+
+static int armv8_qcom_pmu_extensions_probe(struct platform_device *pdev)
+{
+	int val;
+	int ret;
+	unsigned int cpuid = read_cpuid_id();
+
+	ret = device_property_read_u32(&pdev->dev, "qcom,pmu-pcc-support",
+				       &val);
+	if (!ret) {
+		qc_pcc_support = true;
+		dev_info(&pdev->dev, "PCC support detected\n");
+	}
+
+	/* RBB only supported on falkor v2 */
+	if ((MIDR_IMPLEMENTOR(cpuid) == ARM_CPU_IMP_QCOM) &&
+	    (MIDR_PARTNUM(cpuid) == QCOM_CPU_PART_FALKOR)) {
+		ret = device_property_read_u32(&pdev->dev,
+					       "qcom,pmu-rbb-support", &val);
+		if (!ret) {
+			qc_rbb_support = true;
+			dev_info(&pdev->dev, "RBB support detected\n");
+		}
+
+	}
+
+	return 0;
+}
+
+static struct platform_driver armv8_qcom_pmu_extensions = {
+	.driver = {
+		.name = "qcom-pmu-extensions",
+		.acpi_match_table = ACPI_PTR(qcom_pmu_extensions_acpi_match),
+	},
+	.probe = armv8_qcom_pmu_extensions_probe,
+};
+
 static struct platform_driver armv8_pmu_driver = {
 	.driver		= {
 		.name	= ARMV8_PMU_PDEV_NAME,
@@ -1122,9 +1995,21 @@ static int armv8_pmu_device_probe(struct platform_device *pdev)
 
 static int __init armv8_pmu_driver_init(void)
 {
+	unsigned int cpuid;
+
 	if (acpi_disabled)
 		return platform_driver_register(&armv8_pmu_driver);
-	else
+	else {
+		cpuid = read_cpuid_id();
+		/* Only for Falkor CPUs not running as guest */
+		if ((MIDR_IMPLEMENTOR(cpuid) == ARM_CPU_IMP_QCOM) &&
+		    ((MIDR_PARTNUM(cpuid) == QCOM_CPU_PART_FALKOR_V1) ||
+		     (MIDR_PARTNUM(cpuid) == QCOM_CPU_PART_FALKOR)) &&
+		    is_hyp_mode_available()) {
+			platform_driver_register(&armv8_qcom_pmu_extensions);
+			return arm_pmu_acpi_probe(armv8_falkor_pmu_init);
+		}
 		return arm_pmu_acpi_probe(armv8_pmuv3_init);
+	}
 }
 device_initcall(armv8_pmu_driver_init)
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index b3902bd..a61afd9 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_ARM_CCI_PMU) += arm-cci.o
 obj-$(CONFIG_ARM_CCN) += arm-ccn.o
 obj-$(CONFIG_ARM_DSU_PMU) += arm_dsu_pmu.o
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o arm_pmu_platform.o
-obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o
+obj-$(CONFIG_ARM_PMU_ACPI) += arm_pmu_acpi.o qcom_arm_pmu.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
diff --git a/drivers/perf/qcom_arm_pmu.c b/drivers/perf/qcom_arm_pmu.c
new file mode 100644
index 0000000..54b11e6df
--- /dev/null
+++ b/drivers/perf/qcom_arm_pmu.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/*
+ * Qualcomm Technologies CPU PMU IMPLEMENTATION DEFINED extensions support
+ *
+ * Current extensions supported:
+ *
+ * - PC capture (PCC):
+ *   Allows more precise PC sampling by storing the PC in a separate system
+ *   register when an event counter overflow occurs. Reduces skid and allows
+ *   sampling when interrupts are disabled (the PMI is a maskable interrupt
+ *   in arm64). Note that there is only one PC capture register so we only
+ *   allow one event at a time to use it.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/perf_event.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+#include <asm/barrier.h>
+#include <asm/sysreg.h>
+
+#include <linux/perf/arm_pmu.h>
+
+/*
+ * Low-level PCC definitions
+ */
+
+#define PCCPTR_UNAUTH       BIT(0)
+#define PCCPTR_PC_MS_SP     BIT(55)
+#define PCCPTR_PC_MASK_SP   GENMASK_ULL(55, 2)
+#define PCCPTR_SIGN_EXT_SP  GENMASK_ULL(63, 56);
+#define PCC_CPT_PME0        BIT(0)
+#define PCC_CPT_EVENT_EN(x) (PCC_CPT_PME0 << (x))
+#define PCC_CPT_PMOVNEVT0   BIT(16)
+#define PCC_CPT_EVENT_OV(x) (PCC_CPT_PMOVNEVT0 << (x))
+#define QC_EVT_PCC_SHIFT    0
+#define QC_EVT_PCC_MASK     GENMASK(QC_EVT_PCC_SHIFT + 1, QC_EVT_PCC_SHIFT)
+#define QC_EVT_PCC(event)						\
+	(((event)->attr.config1 & QC_EVT_PCC_MASK) >> QC_EVT_PCC_SHIFT)
+
+struct pcc_ops {
+	/* Retrieve the PC from the IMP DEF pmpccptr_el0 register */
+	void (*read_pmpccptr_el0_pc)(u64 *pc);
+	/* Read/write the IMP DEF pmpccptcr0_el0 register */
+	u64 (*read_pmpccptcr0_el0)(void);
+	void (*write_pmpccptcr0_el0)(u64 val);
+};
+
+static struct arm_pmu *def_ops;
+static const struct pcc_ops *pcc_ops;
+
+/*
+ * Low-level Falkor operations
+ */
+
+static void falkor_read_pmpccptr_el0_pc(u64 *pc)
+{
+	u64 pcc = read_sysreg_s(sys_reg(3, 5, 11, 4, 0));
+
+	/*
+	 * Leave pc unchanged if we are not allowed to read the PC
+	 *  (e.g. if the overflow occurred in secure code)
+	 */
+	if (pcc & PCCPTR_UNAUTH)
+		return;
+
+	*pc = pcc;
+}
+
+static void falkor_write_pmpccptcr0_el0(u64 val)
+{
+	write_sysreg_s(val, sys_reg(3, 5, 11, 4, 1));
+}
+
+static u64 falkor_read_pmpccptcr0_el0(void)
+{
+	return read_sysreg_s(sys_reg(3, 5, 11, 4, 1));
+}
+
+static const struct pcc_ops falkor_pcc_ops = {
+	.read_pmpccptr_el0_pc = falkor_read_pmpccptr_el0_pc,
+	.read_pmpccptcr0_el0 = falkor_read_pmpccptcr0_el0,
+	.write_pmpccptcr0_el0 = falkor_write_pmpccptcr0_el0
+};
+
+/*
+ * Low-level Saphira operations
+ */
+
+static void saphira_read_pmpccptr_el0_pc(u64 *pc)
+{
+	u64 pcc = read_sysreg_s(sys_reg(3, 5, 11, 5, 0));
+
+	/*
+	 * Leave pc unchanged if we are not allowed to read the PC
+	 *  (e.g. if the overflow occurred in secure code)
+	 */
+	if (pcc & PCCPTR_UNAUTH)
+		return;
+
+	*pc = pcc & PCCPTR_PC_MASK_SP;
+	/* In Saphira we need to sign extend */
+	if (pcc & PCCPTR_PC_MS_SP)
+		*pc |= PCCPTR_SIGN_EXT_SP;
+}
+
+static void saphira_write_pmpccptcr0_el0(u64 val)
+{
+	write_sysreg_s(val, sys_reg(3, 5, 11, 5, 1));
+}
+
+static u64 saphira_read_pmpccptcr0_el0(void)
+{
+	return read_sysreg_s(sys_reg(3, 5, 11, 5, 1));
+}
+
+static const struct pcc_ops saphira_pcc_ops = {
+	.read_pmpccptr_el0_pc = saphira_read_pmpccptr_el0_pc,
+	.read_pmpccptcr0_el0 = saphira_read_pmpccptcr0_el0,
+	.write_pmpccptcr0_el0 = saphira_write_pmpccptcr0_el0
+};
+
+/*
+ * Check if the given event uses PCC
+ */
+static bool has_pcc(struct perf_event *event)
+{
+	/* PCC not enabled */
+	if (!pcc_ops)
+		return false;
+
+	/* PCC only used for sampling events */
+	if (!is_sampling_event(event))
+		return false;
+
+	/*
+	 * PCC only used without callchain because software callchain might
+	 * provide misleading entries
+	 */
+	if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+		return false;
+
+	return QC_EVT_PCC(event);
+}
+
+/*
+ * Check if the given event is for the raw or dynamic PMU type
+ */
+static inline bool is_raw_or_dynamic(struct perf_event *event)
+{
+	int type = event->attr.type;
+
+	return (type == PERF_TYPE_RAW) || (type == event->pmu->type);
+}
+
+/*
+ * Check if e1 and e2 conflict with each other
+ *
+ * e1 is an event that has extensions and we are checking against e2.
+ */
+static inline bool events_conflict(struct perf_event *e1, struct perf_event *e2)
+{
+	int type = e2->attr.type;
+	int dynamic = e1->pmu->type;
+
+	/* Same event? */
+	if (e1 == e2)
+		return false;
+
+	/* Other PMU that is not the RAW or this PMU's dynamic type? */
+	if ((e1->pmu != e2->pmu) && (type != PERF_TYPE_RAW) && (type != dynamic))
+		return false;
+
+	/* No conflict if using different pcc or if pcc is not enabled */
+	if (pcc_ops && is_sampling_event(e2) && (QC_EVT_PCC(e1) == QC_EVT_PCC(e2))) {
+		pr_debug_ratelimited("PCC exclusion: conflicting events %llx %llx\n",
+				     e1->attr.config,
+				     e2->attr.config);
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Handle a PCC event overflow
+ *
+ * No extra checks needed here since we do all of that during map, event_idx,
+ * and enable. We only let one PCC event per-CPU pass-through to this.
+ */
+static void pcc_overflow_handler(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 struct pt_regs *regs)
+{
+	u64 irq_pc = regs->pc;
+
+	/* Override with hardware PC */
+	pcc_ops->read_pmpccptr_el0_pc(&regs->pc);
+
+	/* Let the original handler finish the operation */
+	event->orig_overflow_handler(event, data, regs);
+
+	/* Restore */
+	regs->pc = irq_pc;
+}
+
+/*
+ * Check if the given event is valid for the PMU and if so return the value
+ * that can be used in PMXEVTYPER_EL0 to select the event
+ */
+static int qcom_arm_pmu_map_event(struct perf_event *event)
+{
+	if (is_raw_or_dynamic(event) && has_pcc(event)) {
+		struct perf_event *leader;
+		struct perf_event *sibling;
+
+		/* Check if the event is compatible with its group */
+		leader = event->group_leader;
+		if (events_conflict(event, leader))
+			return -ENOENT;
+
+		for_each_sibling_event(sibling, leader)
+			if (events_conflict(event, sibling))
+				return -ENOENT;
+	}
+
+	return def_ops->map_event(event);
+}
+
+/*
+ * Find a slot for the event on the current CPU
+ */
+static int qcom_arm_pmu_get_event_idx(struct pmu_hw_events *cpuc, struct perf_event *event)
+{
+	int idx;
+
+	if (is_raw_or_dynamic(event) && has_pcc(event)) {
+		struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
+		int idx;
+
+		/* Check for conflicts with existing events */
+		for_each_set_bit(idx, cpuc->used_mask, ARMPMU_MAX_HWEVENTS)
+			if (cpuc->events[idx] &&
+			    events_conflict(event, cpuc->events[idx]))
+				return -ENOENT;
+
+		/*
+		 * PCC is requested for this event so we need to use an event
+		 * counter even for the cycle counter (PCC does not work with
+		 * the dedicated cycle counter).
+		 */
+		for (idx = ARMV8_IDX_COUNTER0; idx < cpu_pmu->num_events; ++idx) {
+			if (!test_and_set_bit(idx, cpuc->used_mask))
+				return idx;
+		}
+
+		/* The counters are all in use. */
+		return -EAGAIN;
+	}
+
+	/* Let the original op handle the rest */
+	idx = def_ops->get_event_idx(cpuc, event);
+
+	/*
+	 * This is called for actually allocating the events, but also with
+	 * a dummy pmu_hw_events when validating groups, for that case we
+	 * need to ensure that cpuc->events[idx] is NULL so we don't use
+	 * an uninitialized pointer. Conflicts for matrix events in groups
+	 * are checked during event mapping anyway (see falkor_event_map).
+	 */
+	cpuc->events[idx] = NULL;
+
+	return idx;
+}
+
+/*
+ * Enable the given event
+ */
+static void qcom_arm_pmu_enable(struct perf_event *event)
+{
+	if (has_pcc(event)) {
+		int idx = event->hw.idx;
+		u32 pcc = PCC_CPT_EVENT_EN(ARMV8_IDX_TO_COUNTER(idx)) |
+			  PCC_CPT_EVENT_OV(ARMV8_IDX_TO_COUNTER(idx));
+
+		pcc_ops->write_pmpccptcr0_el0(pcc);
+		event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
+		WRITE_ONCE(event->overflow_handler, pcc_overflow_handler);
+	}
+
+	/* Let the original op handle the rest */
+	def_ops->enable(event);
+}
+
+/*
+ * Disable the given event
+ */
+static void qcom_arm_pmu_disable(struct perf_event *event)
+{
+	/* Use the original op to disable the counter and interrupt  */
+	def_ops->enable(event);
+
+	if (has_pcc(event)) {
+		int idx = event->hw.idx;
+		u32 pcc = pcc_ops->read_pmpccptcr0_el0();
+
+		pcc &= ~(PCC_CPT_EVENT_EN(ARMV8_IDX_TO_COUNTER(idx)) |
+			 PCC_CPT_EVENT_OV(ARMV8_IDX_TO_COUNTER(idx)));
+		pcc_ops->write_pmpccptcr0_el0(pcc);
+		if (event->orig_overflow_handler)
+			WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
+	}
+}
+
+PMU_FORMAT_ATTR(event, "config:0-15");
+PMU_FORMAT_ATTR(pcc,   "config1:0");
+
+static struct attribute *pmu_formats[] = {
+	&format_attr_event.attr,
+	&format_attr_pcc.attr,
+	NULL,
+};
+
+static struct attribute_group pmu_format_attr_group = {
+	.name = "format",
+	.attrs = pmu_formats,
+};
+
+static inline bool pcc_supported(struct device *dev)
+{
+	u8 pcc = 0;
+
+	acpi_node_prop_read(dev->fwnode, "qcom,pmu-pcc-support",
+			    DEV_PROP_U8, &pcc, 1);
+	return pcc != 0;
+}
+
+static int qcom_pmu_init(struct arm_pmu *pmu, struct device *dev)
+{
+	/* Save base arm_pmu so we can invoke its ops when appropriate */
+	def_ops = devm_kmemdup(dev, pmu, sizeof(*def_ops), GFP_KERNEL);
+	if (!def_ops) {
+		pr_warn("Failed to allocate arm_pmu for QCOM extensions");
+		return -ENODEV;
+	}
+
+	pmu->name = "qcom_pmuv3";
+
+	/* Override the necessary ops */
+	pmu->map_event     = qcom_arm_pmu_map_event;
+	pmu->get_event_idx = qcom_arm_pmu_get_event_idx;
+	pmu->enable        = qcom_arm_pmu_enable;
+	pmu->disable       = qcom_arm_pmu_disable;
+
+	/* Override the necessary attributes */
+	pmu->pmu.attr_groups[ARMPMU_ATTR_GROUP_FORMATS] =
+		&pmu_format_attr_group;
+
+	return 1;
+}
+
+static int qcom_falkor_pmu_init(struct arm_pmu *pmu, struct device *dev)
+{
+	if (pcc_supported(dev))
+		pcc_ops = &falkor_pcc_ops;
+	else
+		return -ENODEV;
+
+	return qcom_pmu_init(pmu, dev);
+}
+
+static int qcom_saphira_pmu_init(struct arm_pmu *pmu, struct device *dev)
+{
+	if (pcc_supported(dev))
+		pcc_ops = &saphira_pcc_ops;
+	else
+		return -ENODEV;
+
+	return qcom_pmu_init(pmu, dev);
+}
+
+ACPI_DECLARE_PMU_VARIANT(qcom_falkor,  "QCOM8150", qcom_falkor_pmu_init);
+ACPI_DECLARE_PMU_VARIANT(qcom_saphira, "QCOM8151", qcom_saphira_pmu_init);
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e71e99e..a5e09d4 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -677,8 +677,10 @@ struct perf_event {
 	u64				(*clock)(void);
 	perf_overflow_handler_t		overflow_handler;
 	void				*overflow_handler_context;
-#ifdef CONFIG_BPF_SYSCALL
+#if defined(CONFIG_BPF_SYSCALL) || defined(CONFIG_ARM_PMU_ACPI)
 	perf_overflow_handler_t		orig_overflow_handler;
+#endif
+#ifdef CONFIG_BPF_SYSCALL
 	struct bpf_prog			*prog;
 #endif
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
