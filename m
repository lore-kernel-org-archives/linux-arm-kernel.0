From: nleeder@codeaurora.org (Neil Leeder)
Date: Wed,  1 Mar 2017 11:18:05 -0500
Subject: [PATCH/RFC] arm64: pmu: add Qualcomm Technologies extensions
Message-ID: <1488385085-19238-1-git-send-email-nleeder@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds CPU PMU perf events support for Qualcomm Technologies' Falkor CPU.

The Qualcomm Technologies CPU PMU is named qcom_pmuv3 and provides
extensions to the architected PMU events.

The extended events are implemented by a set of registers which
are programmed by shifting an event code into a group field.
The PMNx event then points to that region/group combo.

Restrictions that limit only one concurrent region/group combination
are also enforced.

Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
---
The Qualcomm Technologies CPU PMU extensions have an additional set of registers
which need to be programmed when configuring an event. These are the PMRESRs,
which are similar to the krait & scorpion registers in armv7, and the L2
variants in the Qualcomm Technologies L2 PMU driver.

This is an alpha patch where I'm looking for comments on design decisions. I'll
hit the highlights here, with my rationale for the decisions and some possible
alternatives.

For some functions (reset, get_event_idx) I've been able to add qc_* wrappers
for the additional code, and within them call the armv8pmu_* functions for
common code.

For [enable|disable]_event this isn't possible because the body has to be
surrounded by a spinlock. I considered the alternative of duplicating the
function and adding qc-specific code, but went with calling the qc functions
from within the armv8pmu functions. One reason for that is that future features,
for example adding chaining support, may have to be duplicated in both
functions which I wanted to avoid.

There are additional constraints on qc events. The armv7 implementation checks
these in get_event_idx, but during L2 PMU reviews it was thought better to do
these during init processing where possible. I added these in the map_event
callback because its the only callback from within armpmu_event_init(). I'm not
sure if that would be considered stretching the acceptable use of that interface,
so I'm open to other suggestions.

The qc driver also needs to check conflicts between events, using a bitmap. This
has similar use to the hw_events->used_mask. I added the event_conflicts bitmap
into hw_events, although I'm not sure if that's the best place for an
implementation-specific field. An alternative would be a static DEFINE_PER_CPU
bitmap, although that didn't seem as clean, but may be more acceptable.

qc_max_resr is a variable, rather than a constant, to accommodate future
processors with different numbers of RESRs.

This requires Jeremy Linton's patch sequence to add arm64 CPU PMU ACPI support:
https://patchwork.kernel.org/patch/9533677/

Thanks,
Neil

 arch/arm64/kernel/perf_event.c | 344 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/perf/arm_pmu.h   |   8 +
 2 files changed, 348 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 0fbd7ef..ed4842d 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -535,6 +535,32 @@
 	.attrs = armv8_pmuv3_format_attrs,
 };
 
+/* NRCCG format for qc perf raw codes. */
+PMU_FORMAT_ATTR(prefix, "config:16-19");
+PMU_FORMAT_ATTR(reg,    "config:12-15");
+PMU_FORMAT_ATTR(code,   "config:4-11");
+PMU_FORMAT_ATTR(group,  "config:0-3");
+
+static struct attribute *qc_ev_formats[] = {
+	&format_attr_prefix.attr,
+	&format_attr_reg.attr,
+	&format_attr_code.attr,
+	&format_attr_group.attr,
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group qc_pmu_format_attr_group = {
+	.name = "format",
+	.attrs = qc_ev_formats,
+};
+
+static bool qc_pmu;
+static void qc_pmu_enable_event(struct perf_event *event,
+				struct hw_perf_event *hwc, int idx);
+static void qc_pmu_disable_event(struct perf_event *event,
+				 struct hw_perf_event *hwc);
+
 /*
  * Perf Events' indices
  */
@@ -704,10 +730,13 @@ static void armv8pmu_enable_event(struct perf_event *event)
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
 	 * Enable interrupt for this counter
@@ -740,6 +769,9 @@ static void armv8pmu_disable_event(struct perf_event *event)
 	 */
 	armv8pmu_disable_counter(idx);
 
+	if (qc_pmu)
+		qc_pmu_disable_event(event, hwc);
+
 	/*
 	 * Disable interrupt for this counter
 	 */
@@ -929,6 +961,269 @@ static int armv8_pmuv3_map_event(struct perf_event *event)
 	return hw_event_id;
 }
 
+/*
+ * Events for Qualcomm Techologies CPU PMU can be envisioned as a 2-dimensional
+ * array. Each column represents a group of events. There are 8 groups.
+ * Only one entry from each group can be in use at a time.
+ *
+ * There are several of these arrays, each controlled by a Region Event
+ * Selection Register (RESR).
+ *
+ * To distinguish Qualcomm Techologies events from ARM architecural events
+ * there is a prefix value specified in event encoding. Currently the only
+ * non-0 value defined is 1.
+ *
+ * Qualcomm Techologies events are specified as 0xNRCCG, where:
+ *   N  = Prefix (1 = Qualcomm Techologies events)
+ *   R  = RESR
+ *   CC = code (2 hex digits specifying array row)
+ *   G  = group (array column).
+ *
+ * In addition the ARM architecural events are also supported. They are
+ * differentiated from the Qualcomm Techologies events by having Prefix = 0.
+ */
+#define pmresr0_el0         sys_reg(3, 5, 11, 3, 0)
+#define pmresr1_el0         sys_reg(3, 5, 11, 3, 2)
+#define pmresr2_el0         sys_reg(3, 5, 11, 3, 4)
+#define pmxevcntcr_el0      sys_reg(3, 5, 11, 0, 3)
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
+static int qc_max_resr;
+
+/*
+ * No CPU implementation can exceed this number of RESRS
+ *
+ * Used as a sanity check: detect a future CPU with number of RESRs * groups
+ * which exceeds the size of the event_conflicts element.
+ */
+#define QC_MAX_RESRS (ARMPMU_MAX_EVENT_CONFLICTS / (QC_MAX_GROUP + 1))
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
+	if ((event != event->group_leader) &&
+	    (QC_EVT_GROUP(event->group_leader->attr.config) == group)) {
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
+		    (QC_EVT_GROUP(sibling->attr.config) == group)) {
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
+
+	if (QC_EVT_PFX(hwc->config_base) != QC_EVT_PREFIX) {
+		armv8pmu_write_evtype(idx, hwc->config_base);
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
+	if (QC_EVT_PFX(hwc->config_base) == QC_EVT_PREFIX)
+		qc_clear_resr(QC_EVT_REG(hwc->config_base),
+			      QC_EVT_GROUP(hwc->config_base));
+}
+
+static int qc_get_event_idx(struct pmu_hw_events *cpuc,
+			    struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int bit = -1;
+	unsigned int reg, group;
+
+	/*
+	 * Check for column exclusion: event column already in use by another
+	 * event. This is for events which are not in the same group.
+	 * Conflicting events in the same group are detected in event_init.
+	 */
+	if (QC_EVT_PFX(hwc->config_base) == QC_EVT_PREFIX) {
+		reg = QC_EVT_REG(hwc->config_base);
+		group = QC_EVT_GROUP(hwc->config_base);
+
+		bit = reg * QC_GROUPS_PER_REG + group;
+		if (test_bit(bit, cpuc->event_conflicts))
+			return -EAGAIN;
+	}
+
+	idx = armv8pmu_get_event_idx(cpuc, event);
+
+	if ((idx >= 0) && (bit >= 0))
+		set_bit(bit, cpuc->event_conflicts);
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
+	if (QC_EVT_PFX(hwc->config_base) == QC_EVT_PREFIX) {
+		reg = QC_EVT_REG(hwc->config_base);
+		group = QC_EVT_GROUP(hwc->config_base);
+		clear_bit(reg * QC_GROUPS_PER_REG + group,
+			  cpuc->event_conflicts);
+	}
+}
+
 static int armv8_a53_map_event(struct perf_event *event)
 {
 	return armpmu_map_event(event, &armv8_a53_perf_map,
@@ -957,6 +1252,19 @@ static int armv8_vulcan_map_event(struct perf_event *event)
 				ARMV8_PMU_EVTYPE_EVENT);
 }
 
+static int armv8_qc_map_event(struct perf_event *event)
+{
+	int err;
+
+	err = qc_verify_event(event);
+	if (err < 0)
+		return err;
+
+	return armpmu_map_event(event, &armv8_pmuv3_perf_map,
+				&armv8_pmuv3_perf_cache_map,
+				QC_EVT_MASK);
+}
+
 static void __armv8pmu_probe_pmu(void *info)
 {
 	struct arm_pmu *cpu_pmu = info;
@@ -1071,6 +1379,32 @@ static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
 	return armv8pmu_probe_pmu(cpu_pmu);
 }
 
+static int armv8_falkor_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv8_pmu_init(cpu_pmu);
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
+	return armv8pmu_probe_pmu(cpu_pmu);
+}
+
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
 	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_a53_pmu_init},
@@ -1087,6 +1421,8 @@ static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
  * aren't supported by the current PMU are disabled.
  */
 static const struct pmu_probe_info armv8_pmu_probe_table[] = {
+	PMU_PROBE(QCOM_CPU_PART_FALKOR_V1 << MIDR_PARTNUM_SHIFT,
+		  MIDR_PARTNUM_MASK, armv8_falkor_pmu_init),
 	PMU_PROBE(0, 0, armv8_pmuv3_init), /* enable all defined counters */
 	{ /* sentinel value */ }
 };
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index f652cd1..d9b5f44 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -37,6 +37,8 @@ struct arm_pmu_platdata {
  */
 #define ARMPMU_MAX_HWEVENTS		32
 
+#define ARMPMU_MAX_EVENT_CONFLICTS	64
+
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
 #define CACHE_OP_UNSUPPORTED		0xFFFF
@@ -65,6 +67,12 @@ struct pmu_hw_events {
 	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
 
 	/*
+	 * Keep track of implementation-specific events that
+	 * hardware can't schedule concurrently
+	 */
+	DECLARE_BITMAP(event_conflicts, ARMPMU_MAX_EVENT_CONFLICTS);
+
+	/*
 	 * Hardware lock to serialize accesses to PMU registers. Needed for the
 	 * read/modify/write sequences.
 	 */
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
