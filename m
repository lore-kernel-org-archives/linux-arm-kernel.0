From: ashoks@broadcom.com (Ashok Kumar)
Date: Thu, 24 Mar 2016 05:52:37 -0700
Subject: [PATCH v2 3/6] arm64/perf: Filter common events based on PMCEIDn_EL0
In-Reply-To: <1458823960-32760-1-git-send-email-ashoks@broadcom.com>
References: <1458823960-32760-1-git-send-email-ashoks@broadcom.com>
Message-ID: <1458823960-32760-4-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The complete common architectural and micro-architectural
event number structure is filtered based on PMCEIDn_EL0 and
copied to a new structure which is exposed to /sys

The function which derives event bitmap from PMCEIDn_EL0 is
executed in the cpus, which has the pmu being initialized,
for heterogeneous pmu support.

Enforced armv8_pmuv3_event_attrs array for event number
ordering as this is indexed with event number now.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
 arch/arm64/kernel/perf_event.c | 281 ++++++++++++++++++++++++++++-------------
 1 file changed, 195 insertions(+), 86 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 5358587..a025ec2 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -378,62 +378,106 @@ ARMV8_EVENT_ATTR(l2i_tlb_refill, ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL);
 ARMV8_EVENT_ATTR(l2d_tlb, ARMV8_PMUV3_PERFCTR_L2D_TLB);
 ARMV8_EVENT_ATTR(l2i_tlb, ARMV8_PMUV3_PERFCTR_L2I_TLB);
 
-static struct attribute *armv8_pmuv3_event_attrs[] = {
-	&armv8_event_attr_sw_incr.attr.attr,
-	&armv8_event_attr_l1i_cache_refill.attr.attr,
-	&armv8_event_attr_l1i_tlb_refill.attr.attr,
-	&armv8_event_attr_l1d_cache_refill.attr.attr,
-	&armv8_event_attr_l1d_cache.attr.attr,
-	&armv8_event_attr_l1d_tlb_refill.attr.attr,
-	&armv8_event_attr_ld_retired.attr.attr,
-	&armv8_event_attr_st_retired.attr.attr,
-	&armv8_event_attr_inst_retired.attr.attr,
-	&armv8_event_attr_exc_taken.attr.attr,
-	&armv8_event_attr_exc_return.attr.attr,
-	&armv8_event_attr_cid_write_retired.attr.attr,
-	&armv8_event_attr_pc_write_retired.attr.attr,
-	&armv8_event_attr_br_immed_retired.attr.attr,
-	&armv8_event_attr_br_return_retired.attr.attr,
-	&armv8_event_attr_unaligned_ldst_retired.attr.attr,
-	&armv8_event_attr_br_mis_pred.attr.attr,
-	&armv8_event_attr_cpu_cycles.attr.attr,
-	&armv8_event_attr_br_pred.attr.attr,
-	&armv8_event_attr_mem_access.attr.attr,
-	&armv8_event_attr_l1i_cache.attr.attr,
-	&armv8_event_attr_l1d_cache_wb.attr.attr,
-	&armv8_event_attr_l2d_cache.attr.attr,
-	&armv8_event_attr_l2d_cache_refill.attr.attr,
-	&armv8_event_attr_l2d_cache_wb.attr.attr,
-	&armv8_event_attr_bus_access.attr.attr,
-	&armv8_event_attr_memory_error.attr.attr,
-	&armv8_event_attr_inst_spec.attr.attr,
-	&armv8_event_attr_ttbr_write_retired.attr.attr,
-	&armv8_event_attr_bus_cycles.attr.attr,
-	&armv8_event_attr_chain.attr.attr,
-	&armv8_event_attr_l1d_cache_allocate.attr.attr,
-	&armv8_event_attr_l2d_cache_allocate.attr.attr,
-	&armv8_event_attr_br_retired.attr.attr,
-	&armv8_event_attr_br_mis_pred_retired.attr.attr,
-	&armv8_event_attr_stall_frontend.attr.attr,
-	&armv8_event_attr_stall_backend.attr.attr,
-	&armv8_event_attr_l1d_tlb.attr.attr,
-	&armv8_event_attr_l1i_tlb.attr.attr,
-	&armv8_event_attr_l2i_cache.attr.attr,
-	&armv8_event_attr_l2i_cache_refill.attr.attr,
-	&armv8_event_attr_l3d_cache_allocate.attr.attr,
-	&armv8_event_attr_l3d_cache_refill.attr.attr,
-	&armv8_event_attr_l3d_cache.attr.attr,
-	&armv8_event_attr_l3d_cache_wb.attr.attr,
-	&armv8_event_attr_l2d_tlb_refill.attr.attr,
-	&armv8_event_attr_l2i_tlb_refill.attr.attr,
-	&armv8_event_attr_l2d_tlb.attr.attr,
-	&armv8_event_attr_l2i_tlb.attr.attr,
-	NULL,
-};
-
-static struct attribute_group armv8_pmuv3_events_attr_group = {
-	.name = "events",
-	.attrs = armv8_pmuv3_event_attrs,
+#define ARMV8_PMUV3_MAX_COMMON_EVENTS 0x40
+static struct attribute *armv8_pmuv3_event_attrs[ARMV8_PMUV3_MAX_COMMON_EVENTS] = {
+	[ARMV8_PMUV3_PERFCTR_SW_INCR] =
+		&armv8_event_attr_sw_incr.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL] =
+		&armv8_event_attr_l1i_cache_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL] =
+		&armv8_event_attr_l1i_tlb_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL] =
+		&armv8_event_attr_l1d_cache_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1D_CACHE] =
+		&armv8_event_attr_l1d_cache.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1D_TLB_REFILL] =
+		&armv8_event_attr_l1d_tlb_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_LD_RETIRED] =
+		&armv8_event_attr_ld_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_ST_RETIRED] =
+		&armv8_event_attr_st_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_INST_RETIRED] =
+		&armv8_event_attr_inst_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_EXC_TAKEN] =
+		&armv8_event_attr_exc_taken.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_EXC_RETURN] =
+		&armv8_event_attr_exc_return.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_CID_WRITE_RETIRED] =
+		&armv8_event_attr_cid_write_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_PC_WRITE_RETIRED] =
+		&armv8_event_attr_pc_write_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_BR_IMMED_RETIRED] =
+		&armv8_event_attr_br_immed_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_BR_RETURN_RETIRED] =
+		&armv8_event_attr_br_return_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_UNALIGNED_LDST_RETIRED] =
+		&armv8_event_attr_unaligned_ldst_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_BR_MIS_PRED] =
+		&armv8_event_attr_br_mis_pred.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_CPU_CYCLES] =
+		&armv8_event_attr_cpu_cycles.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_BR_PRED] =
+		&armv8_event_attr_br_pred.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_MEM_ACCESS] =
+		&armv8_event_attr_mem_access.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1I_CACHE] =
+		&armv8_event_attr_l1i_cache.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1D_CACHE_WB] =
+		&armv8_event_attr_l1d_cache_wb.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2D_CACHE] =
+		&armv8_event_attr_l2d_cache.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2D_CACHE_REFILL] =
+		&armv8_event_attr_l2d_cache_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2D_CACHE_WB] =
+		&armv8_event_attr_l2d_cache_wb.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_BUS_ACCESS] =
+		&armv8_event_attr_bus_access.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_MEMORY_ERROR] =
+		&armv8_event_attr_memory_error.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_INST_SPEC] =
+		&armv8_event_attr_inst_spec.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_TTBR_WRITE_RETIRED] =
+		&armv8_event_attr_ttbr_write_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_BUS_CYCLES] =
+		&armv8_event_attr_bus_cycles.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_CHAIN] =
+		&armv8_event_attr_chain.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1D_CACHE_ALLOCATE] =
+		&armv8_event_attr_l1d_cache_allocate.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2D_CACHE_ALLOCATE] =
+		&armv8_event_attr_l2d_cache_allocate.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_BR_RETIRED] =
+		&armv8_event_attr_br_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_BR_MIS_PRED_RETIRED] =
+		&armv8_event_attr_br_mis_pred_retired.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_STALL_FRONTEND] =
+		&armv8_event_attr_stall_frontend.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_STALL_BACKEND] =
+		&armv8_event_attr_stall_backend.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1D_TLB] =
+		&armv8_event_attr_l1d_tlb.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L1I_TLB] =
+		&armv8_event_attr_l1i_tlb.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2I_CACHE] =
+		&armv8_event_attr_l2i_cache.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2I_CACHE_REFILL] =
+		&armv8_event_attr_l2i_cache_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L3D_CACHE_ALLOCATE] =
+		&armv8_event_attr_l3d_cache_allocate.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L3D_CACHE_REFILL] =
+		&armv8_event_attr_l3d_cache_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L3D_CACHE] =
+		&armv8_event_attr_l3d_cache.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L3D_CACHE_WB] =
+		&armv8_event_attr_l3d_cache_wb.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2D_TLB_REFILL] =
+		&armv8_event_attr_l2d_tlb_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL] =
+		&armv8_event_attr_l2i_tlb_refill.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2D_TLB] =
+		&armv8_event_attr_l2d_tlb.attr.attr,
+	[ARMV8_PMUV3_PERFCTR_L2I_TLB] =
+		&armv8_event_attr_l2i_tlb.attr.attr,
 };
 
 PMU_FORMAT_ATTR(event, "config:0-9");
@@ -448,12 +492,6 @@ static struct attribute_group armv8_pmuv3_format_attr_group = {
 	.attrs = armv8_pmuv3_format_attrs,
 };
 
-static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
-	&armv8_pmuv3_events_attr_group,
-	&armv8_pmuv3_format_attr_group,
-	NULL,
-};
-
 /*
  * Perf Events' indices
  */
@@ -522,6 +560,18 @@ static inline void armv8pmu_pmcr_write(u32 val)
 	asm volatile("msr pmcr_el0, %0" :: "r" (val));
 }
 
+static inline u32 armv8pmu_pmceidn_read(int reg)
+{
+	u32 val = 0;
+
+	if (reg == 0)
+		asm volatile("mrs %0, pmceid0_el0" : "=r" (val));
+	else if (reg == 1)
+		asm volatile("mrs %0, pmceid1_el0" : "=r" (val));
+
+	return val;
+}
+
 static inline int armv8pmu_has_overflowed(u32 pmovsr)
 {
 	return pmovsr & ARMV8_OVERFLOWED_MASK;
@@ -890,26 +940,53 @@ static int armv8_thunder_map_event(struct perf_event *event)
 				ARMV8_EVTYPE_EVENT);
 }
 
-static void armv8pmu_read_num_pmnc_events(void *info)
+static unsigned int armv8pmu_read_num_pmnc_events(void)
 {
-	int *nb_cnt = info;
-
+	unsigned int nb_cnt;
 	/* Read the nb of CNTx counters supported from PMNC */
-	*nb_cnt = (armv8pmu_pmcr_read() >> ARMV8_PMCR_N_SHIFT) & ARMV8_PMCR_N_MASK;
+	nb_cnt = (armv8pmu_pmcr_read() >> ARMV8_PMCR_N_SHIFT) & ARMV8_PMCR_N_MASK;
 
 	/* Add the CPU cycles counter */
-	*nb_cnt += 1;
+	nb_cnt += 1;
+
+	return nb_cnt;
+}
+
+static void armv8pmu_read_common_events_bitmap(unsigned long *bmp)
+{
+	u32 reg[2];
+
+	reg[0] = armv8pmu_pmceidn_read(0);
+	reg[1] = armv8pmu_pmceidn_read(1);
+
+	bitmap_from_u32array(bmp, ARMV8_PMUV3_MAX_COMMON_EVENTS,
+			     reg, ARRAY_SIZE(reg));
+	return;
 }
 
-static int armv8pmu_probe_num_events(struct arm_pmu *arm_pmu)
+struct armv8pmu_probe_pmu_data {
+	int num_evt_cntrs;
+	DECLARE_BITMAP(events_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
+};
+
+static void armv8pmu_probe_pmu(void *info)
 {
-	return smp_call_function_any(&arm_pmu->supported_cpus,
-				    armv8pmu_read_num_pmnc_events,
-				    &arm_pmu->num_events, 1);
+	struct armv8pmu_probe_pmu_data *data = info;
+
+	data->num_evt_cntrs = armv8pmu_read_num_pmnc_events();
+	armv8pmu_read_common_events_bitmap(data->events_bitmap);
 }
 
-static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
+static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 {
+	u32 evt, idx = 0;
+	struct attribute **event_attrs;
+	struct attribute_group *events_attr_group;
+	const struct attribute_group **attr_groups;
+	struct device *dev = &cpu_pmu->plat_device->dev;
+	struct armv8pmu_probe_pmu_data pmu_data;
+	int error;
+
 	cpu_pmu->handle_irq		= armv8pmu_handle_irq,
 	cpu_pmu->enable			= armv8pmu_enable_event,
 	cpu_pmu->disable		= armv8pmu_disable_event,
@@ -921,50 +998,82 @@ static void armv8_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->reset			= armv8pmu_reset,
 	cpu_pmu->max_period		= (1LLU << 32) - 1,
 	cpu_pmu->set_event_filter	= armv8pmu_set_event_filter;
+
+	error = smp_call_function_any(&cpu_pmu->supported_cpus,
+			      armv8pmu_probe_pmu,
+			      &pmu_data, 1);
+	if (error)
+		goto out;
+
+	cpu_pmu->num_events = pmu_data.num_evt_cntrs;
+
+	event_attrs = devm_kcalloc(dev, bitmap_weight(pmu_data.events_bitmap,
+				   ARMV8_PMUV3_MAX_COMMON_EVENTS) + 1,
+				   sizeof(*event_attrs), GFP_KERNEL);
+	if (!event_attrs)
+		goto mem_out;
+
+	events_attr_group = devm_kzalloc(dev, sizeof(*events_attr_group),
+					 GFP_KERNEL);
+	if (!events_attr_group)
+		goto mem_out;
+
+	attr_groups = devm_kcalloc(dev, 3, sizeof(*attr_groups), GFP_KERNEL);
+	if (!attr_groups)
+		goto mem_out;
+
+	for_each_set_bit(evt, pmu_data.events_bitmap,
+			 ARMV8_PMUV3_MAX_COMMON_EVENTS)
+		event_attrs[idx++] = armv8_pmuv3_event_attrs[evt];
+
+	events_attr_group->name = "events";
+	events_attr_group->attrs = event_attrs;
+
+	attr_groups[0] = events_attr_group;
+	attr_groups[1] = &armv8_pmuv3_format_attr_group;
+
+	cpu_pmu->pmu.attr_groups = attr_groups;
+
+	return 0;
+mem_out:
+	error = -ENOMEM;
+out:
+	return error;
 }
 
 static int armv8_pmuv3_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_pmuv3";
 	cpu_pmu->map_event		= armv8_pmuv3_map_event;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8_pmu_init(cpu_pmu);
 }
 
 static int armv8_a53_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_cortex_a53";
 	cpu_pmu->map_event		= armv8_a53_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8_pmu_init(cpu_pmu);
 }
 
 static int armv8_a57_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_cortex_a57";
 	cpu_pmu->map_event		= armv8_a57_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8_pmu_init(cpu_pmu);
 }
 
 static int armv8_a72_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_cortex_a72";
 	cpu_pmu->map_event		= armv8_a57_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8_pmu_init(cpu_pmu);
 }
 
 static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
 {
-	armv8_pmu_init(cpu_pmu);
 	cpu_pmu->name			= "armv8_cavium_thunder";
 	cpu_pmu->map_event		= armv8_thunder_map_event;
-	cpu_pmu->pmu.attr_groups	= armv8_pmuv3_attr_groups;
-	return armv8pmu_probe_num_events(cpu_pmu);
+	return armv8_pmu_init(cpu_pmu);
 }
 
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
-- 
2.1.0
