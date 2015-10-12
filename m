From: drew.richardson@arm.com (Drew Richardson)
Date: Mon, 12 Oct 2015 11:10:38 -0700
Subject: [PATCHv2] arm: perf: Add event descriptions
In-Reply-To: <20151012143025.GG16124@arm.com>
References: <20151007182735.GA18706@dreric01-gentoo.localdomain>
 <20151009101338.GH26278@arm.com>
 <20151009165330.GA22415@dreric01-gentoo.localdomain>
 <20151012143025.GG16124@arm.com>
Message-ID: <20151012181037.GA16013@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 03:30:25PM +0100, Will Deacon wrote:
> I think this looks much better, thanks. The only thing left to do is
> re-use some of the existing event descriptions from the enum
> armv7_perf_types that we have at the top of the file, rather than
> duplicate the event -> ID mapping. Feel free to extend the enumeration
> if you need to (it's intended to cover all of the architected events).

OK, here you go. I agree that duplicating the event -> ID mapping is
undesirable, but some rather ugly preprocessor stuff is required to
convert the enum into it's hex value (is there a better way to do
this?). I think it may be less ugly if we build the string at runtime
instead of at compile time (ie, going back to using PMU_EVENT_ATTR
instead of PMU_EVENT_ATTR_STRING).

Drew

---

Add additional information about the ARM architected hardware events
to make counters self describing. This makes the hardware PMUs easier
to use as perf list contains possible events instead of users having
to refer to documentation like the ARM TRMs.

Signed-off-by: Drew Richardson <drew.richardson@arm.com>
---
 arch/arm/kernel/perf_event_v7.c | 241 +++++++++++++++++++++++++++++++++++-----
 drivers/perf/arm_pmu.c          |   1 +
 2 files changed, 212 insertions(+), 30 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 126dc679b230..a9a7c3e92741 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -36,18 +36,42 @@
  * they are not available.
  */
 enum armv7_perf_types {
-	ARMV7_PERFCTR_PMNC_SW_INCR			= 0x00,
-	ARMV7_PERFCTR_L1_ICACHE_REFILL			= 0x01,
-	ARMV7_PERFCTR_ITLB_REFILL			= 0x02,
-	ARMV7_PERFCTR_L1_DCACHE_REFILL			= 0x03,
-	ARMV7_PERFCTR_L1_DCACHE_ACCESS			= 0x04,
-	ARMV7_PERFCTR_DTLB_REFILL			= 0x05,
-	ARMV7_PERFCTR_MEM_READ				= 0x06,
-	ARMV7_PERFCTR_MEM_WRITE				= 0x07,
-	ARMV7_PERFCTR_INSTR_EXECUTED			= 0x08,
-	ARMV7_PERFCTR_EXC_TAKEN				= 0x09,
-	ARMV7_PERFCTR_EXC_EXECUTED			= 0x0A,
-	ARMV7_PERFCTR_CID_WRITE				= 0x0B,
+#define _ARMV7_PERFCTR_PMNC_SW_INCR			  0x00
+	ARMV7_PERFCTR_PMNC_SW_INCR
+	= _ARMV7_PERFCTR_PMNC_SW_INCR,
+#define _ARMV7_PERFCTR_L1_ICACHE_REFILL			  0x01
+	ARMV7_PERFCTR_L1_ICACHE_REFILL
+	= _ARMV7_PERFCTR_L1_ICACHE_REFILL,
+#define _ARMV7_PERFCTR_ITLB_REFILL			  0x02
+	ARMV7_PERFCTR_ITLB_REFILL
+	= _ARMV7_PERFCTR_ITLB_REFILL,
+#define _ARMV7_PERFCTR_L1_DCACHE_REFILL			  0x03
+	ARMV7_PERFCTR_L1_DCACHE_REFILL
+	= _ARMV7_PERFCTR_L1_DCACHE_REFILL,
+#define _ARMV7_PERFCTR_L1_DCACHE_ACCESS			  0x04
+	ARMV7_PERFCTR_L1_DCACHE_ACCESS
+	= _ARMV7_PERFCTR_L1_DCACHE_ACCESS,
+#define _ARMV7_PERFCTR_DTLB_REFILL			  0x05
+	ARMV7_PERFCTR_DTLB_REFILL
+	= _ARMV7_PERFCTR_DTLB_REFILL,
+#define _ARMV7_PERFCTR_MEM_READ				  0x06
+	ARMV7_PERFCTR_MEM_READ
+	= _ARMV7_PERFCTR_MEM_READ,
+#define _ARMV7_PERFCTR_MEM_WRITE			  0x07
+	ARMV7_PERFCTR_MEM_WRITE
+	= _ARMV7_PERFCTR_MEM_WRITE,
+#define _ARMV7_PERFCTR_INSTR_EXECUTED			  0x08
+	ARMV7_PERFCTR_INSTR_EXECUTED
+	= _ARMV7_PERFCTR_INSTR_EXECUTED,
+#define _ARMV7_PERFCTR_EXC_TAKEN			  0x09
+	ARMV7_PERFCTR_EXC_TAKEN
+	= _ARMV7_PERFCTR_EXC_TAKEN,
+#define _ARMV7_PERFCTR_EXC_EXECUTED			  0x0A
+	ARMV7_PERFCTR_EXC_EXECUTED
+	= _ARMV7_PERFCTR_EXC_EXECUTED,
+#define _ARMV7_PERFCTR_CID_WRITE			  0x0B
+	ARMV7_PERFCTR_CID_WRITE
+	= _ARMV7_PERFCTR_CID_WRITE,
 
 	/*
 	 * ARMV7_PERFCTR_PC_WRITE is equivalent to HW_BRANCH_INSTRUCTIONS.
@@ -56,26 +80,62 @@ enum armv7_perf_types {
 	 *  - instructions that explicitly write the PC,
 	 *  - exception generating instructions.
 	 */
-	ARMV7_PERFCTR_PC_WRITE				= 0x0C,
-	ARMV7_PERFCTR_PC_IMM_BRANCH			= 0x0D,
-	ARMV7_PERFCTR_PC_PROC_RETURN			= 0x0E,
-	ARMV7_PERFCTR_MEM_UNALIGNED_ACCESS		= 0x0F,
-	ARMV7_PERFCTR_PC_BRANCH_MIS_PRED		= 0x10,
-	ARMV7_PERFCTR_CLOCK_CYCLES			= 0x11,
-	ARMV7_PERFCTR_PC_BRANCH_PRED			= 0x12,
+#define _ARMV7_PERFCTR_PC_WRITE				  0x0C
+	ARMV7_PERFCTR_PC_WRITE
+	= _ARMV7_PERFCTR_PC_WRITE,
+#define _ARMV7_PERFCTR_PC_IMM_BRANCH			  0x0D
+	ARMV7_PERFCTR_PC_IMM_BRANCH
+	= _ARMV7_PERFCTR_PC_IMM_BRANCH,
+#define _ARMV7_PERFCTR_PC_PROC_RETURN			  0x0E
+	ARMV7_PERFCTR_PC_PROC_RETURN
+	= _ARMV7_PERFCTR_PC_PROC_RETURN,
+#define _ARMV7_PERFCTR_MEM_UNALIGNED_ACCESS		  0x0F
+	ARMV7_PERFCTR_MEM_UNALIGNED_ACCESS
+	= _ARMV7_PERFCTR_MEM_UNALIGNED_ACCESS,
+#define _ARMV7_PERFCTR_PC_BRANCH_MIS_PRED		  0x10
+	ARMV7_PERFCTR_PC_BRANCH_MIS_PRED
+	= _ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
+#define _ARMV7_PERFCTR_CLOCK_CYCLES			  0x11
+	ARMV7_PERFCTR_CLOCK_CYCLES
+	= _ARMV7_PERFCTR_CLOCK_CYCLES,
+#define _ARMV7_PERFCTR_PC_BRANCH_PRED			  0x12
+	ARMV7_PERFCTR_PC_BRANCH_PRED
+	= _ARMV7_PERFCTR_PC_BRANCH_PRED,
 
 	/* These events are defined by the PMUv2 supplement (ARM DDI 0457A). */
-	ARMV7_PERFCTR_MEM_ACCESS			= 0x13,
-	ARMV7_PERFCTR_L1_ICACHE_ACCESS			= 0x14,
-	ARMV7_PERFCTR_L1_DCACHE_WB			= 0x15,
-	ARMV7_PERFCTR_L2_CACHE_ACCESS			= 0x16,
-	ARMV7_PERFCTR_L2_CACHE_REFILL			= 0x17,
-	ARMV7_PERFCTR_L2_CACHE_WB			= 0x18,
-	ARMV7_PERFCTR_BUS_ACCESS			= 0x19,
-	ARMV7_PERFCTR_MEM_ERROR				= 0x1A,
-	ARMV7_PERFCTR_INSTR_SPEC			= 0x1B,
-	ARMV7_PERFCTR_TTBR_WRITE			= 0x1C,
-	ARMV7_PERFCTR_BUS_CYCLES			= 0x1D,
+#define _ARMV7_PERFCTR_MEM_ACCESS			  0x13
+	ARMV7_PERFCTR_MEM_ACCESS
+	= _ARMV7_PERFCTR_MEM_ACCESS,
+#define _ARMV7_PERFCTR_L1_ICACHE_ACCESS			  0x14
+	ARMV7_PERFCTR_L1_ICACHE_ACCESS
+	= _ARMV7_PERFCTR_L1_ICACHE_ACCESS,
+#define _ARMV7_PERFCTR_L1_DCACHE_WB			  0x15
+	ARMV7_PERFCTR_L1_DCACHE_WB
+	= _ARMV7_PERFCTR_L1_DCACHE_WB,
+#define _ARMV7_PERFCTR_L2_CACHE_ACCESS			  0x16
+	ARMV7_PERFCTR_L2_CACHE_ACCESS
+	= _ARMV7_PERFCTR_L2_CACHE_ACCESS,
+#define _ARMV7_PERFCTR_L2_CACHE_REFILL			  0x17
+	ARMV7_PERFCTR_L2_CACHE_REFILL
+	= _ARMV7_PERFCTR_L2_CACHE_REFILL,
+#define _ARMV7_PERFCTR_L2_CACHE_WB			  0x18
+	ARMV7_PERFCTR_L2_CACHE_WB
+	= _ARMV7_PERFCTR_L2_CACHE_WB,
+#define _ARMV7_PERFCTR_BUS_ACCESS			  0x19
+	ARMV7_PERFCTR_BUS_ACCESS
+	= _ARMV7_PERFCTR_BUS_ACCESS,
+#define _ARMV7_PERFCTR_MEM_ERROR			  0x1A
+	ARMV7_PERFCTR_MEM_ERROR
+	= _ARMV7_PERFCTR_MEM_ERROR,
+#define _ARMV7_PERFCTR_INSTR_SPEC			  0x1B
+	ARMV7_PERFCTR_INSTR_SPEC
+	= _ARMV7_PERFCTR_INSTR_SPEC,
+#define _ARMV7_PERFCTR_TTBR_WRITE			  0x1C
+	ARMV7_PERFCTR_TTBR_WRITE
+	= _ARMV7_PERFCTR_TTBR_WRITE,
+#define _ARMV7_PERFCTR_BUS_CYCLES			  0x1D
+	ARMV7_PERFCTR_BUS_CYCLES
+	= _ARMV7_PERFCTR_BUS_CYCLES,
 
 	ARMV7_PERFCTR_CPU_CYCLES			= 0xFF
 };
@@ -547,6 +607,120 @@ static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
 };
 
+#define ARMV7_EVENT_ATTR_RESOLVE(m) #m
+#define ARMV7_EVENT_ATTR(name, config) \
+	PMU_EVENT_ATTR_STRING(name, armv7_event_attr_##name, \
+			      "event=" ARMV7_EVENT_ATTR_RESOLVE(config))
+
+ARMV7_EVENT_ATTR(sw_incr, _ARMV7_PERFCTR_PMNC_SW_INCR);
+ARMV7_EVENT_ATTR(l1i_cache_refill, _ARMV7_PERFCTR_L1_ICACHE_REFILL);
+ARMV7_EVENT_ATTR(l1i_tlb_refill, _ARMV7_PERFCTR_ITLB_REFILL);
+ARMV7_EVENT_ATTR(l1d_cache_refill, _ARMV7_PERFCTR_L1_DCACHE_REFILL);
+ARMV7_EVENT_ATTR(l1d_cache, _ARMV7_PERFCTR_L1_DCACHE_ACCESS);
+ARMV7_EVENT_ATTR(l1d_tlb_refill, _ARMV7_PERFCTR_DTLB_REFILL);
+ARMV7_EVENT_ATTR(ld_retired, _ARMV7_PERFCTR_MEM_READ);
+ARMV7_EVENT_ATTR(st_retired, _ARMV7_PERFCTR_MEM_WRITE);
+ARMV7_EVENT_ATTR(inst_retired, _ARMV7_PERFCTR_INSTR_EXECUTED);
+ARMV7_EVENT_ATTR(exc_taken, _ARMV7_PERFCTR_EXC_TAKEN);
+ARMV7_EVENT_ATTR(exc_return, _ARMV7_PERFCTR_EXC_EXECUTED);
+ARMV7_EVENT_ATTR(cid_write_retired, _ARMV7_PERFCTR_CID_WRITE);
+ARMV7_EVENT_ATTR(pc_write_retired, _ARMV7_PERFCTR_PC_WRITE);
+ARMV7_EVENT_ATTR(br_immed_retired, _ARMV7_PERFCTR_PC_IMM_BRANCH);
+ARMV7_EVENT_ATTR(br_return_retired, _ARMV7_PERFCTR_PC_PROC_RETURN);
+ARMV7_EVENT_ATTR(unaligned_ldst_retired, _ARMV7_PERFCTR_MEM_UNALIGNED_ACCESS);
+ARMV7_EVENT_ATTR(br_mis_pred, _ARMV7_PERFCTR_PC_BRANCH_MIS_PRED);
+ARMV7_EVENT_ATTR(cpu_cycles, _ARMV7_PERFCTR_CLOCK_CYCLES);
+ARMV7_EVENT_ATTR(br_pred, _ARMV7_PERFCTR_PC_BRANCH_PRED);
+
+static struct attribute *armv7_pmuv1_event_attrs[] = {
+	&armv7_event_attr_sw_incr.attr.attr,
+	&armv7_event_attr_l1i_cache_refill.attr.attr,
+	&armv7_event_attr_l1i_tlb_refill.attr.attr,
+	&armv7_event_attr_l1d_cache_refill.attr.attr,
+	&armv7_event_attr_l1d_cache.attr.attr,
+	&armv7_event_attr_l1d_tlb_refill.attr.attr,
+	&armv7_event_attr_ld_retired.attr.attr,
+	&armv7_event_attr_st_retired.attr.attr,
+	&armv7_event_attr_inst_retired.attr.attr,
+	&armv7_event_attr_exc_taken.attr.attr,
+	&armv7_event_attr_exc_return.attr.attr,
+	&armv7_event_attr_cid_write_retired.attr.attr,
+	&armv7_event_attr_pc_write_retired.attr.attr,
+	&armv7_event_attr_br_immed_retired.attr.attr,
+	&armv7_event_attr_br_return_retired.attr.attr,
+	&armv7_event_attr_unaligned_ldst_retired.attr.attr,
+	&armv7_event_attr_br_mis_pred.attr.attr,
+	&armv7_event_attr_cpu_cycles.attr.attr,
+	&armv7_event_attr_br_pred.attr.attr,
+	NULL
+};
+
+static struct attribute_group armv7_pmuv1_events_attr_group = {
+	.name = "events",
+	.attrs = armv7_pmuv1_event_attrs,
+};
+
+static const struct attribute_group *armv7_pmuv1_attr_groups[] = {
+	&armv7_pmuv1_events_attr_group,
+	NULL
+};
+
+ARMV7_EVENT_ATTR(mem_access, _ARMV7_PERFCTR_MEM_ACCESS);
+ARMV7_EVENT_ATTR(l1i_cache, _ARMV7_PERFCTR_L1_ICACHE_ACCESS);
+ARMV7_EVENT_ATTR(l1d_cache_wb, _ARMV7_PERFCTR_L1_DCACHE_WB);
+ARMV7_EVENT_ATTR(l2d_cache, _ARMV7_PERFCTR_L2_CACHE_ACCESS);
+ARMV7_EVENT_ATTR(l2d_cache_refill, _ARMV7_PERFCTR_L2_CACHE_REFILL);
+ARMV7_EVENT_ATTR(l2d_cache_wb, _ARMV7_PERFCTR_L2_CACHE_WB);
+ARMV7_EVENT_ATTR(bus_access, _ARMV7_PERFCTR_BUS_ACCESS);
+ARMV7_EVENT_ATTR(memory_error, _ARMV7_PERFCTR_MEM_ERROR);
+ARMV7_EVENT_ATTR(inst_spec, _ARMV7_PERFCTR_INSTR_SPEC);
+ARMV7_EVENT_ATTR(ttbr_write_retired, _ARMV7_PERFCTR_TTBR_WRITE);
+ARMV7_EVENT_ATTR(bus_cycles, _ARMV7_PERFCTR_BUS_CYCLES);
+
+static struct attribute *armv7_pmuv2_event_attrs[] = {
+	&armv7_event_attr_sw_incr.attr.attr,
+	&armv7_event_attr_l1i_cache_refill.attr.attr,
+	&armv7_event_attr_l1i_tlb_refill.attr.attr,
+	&armv7_event_attr_l1d_cache_refill.attr.attr,
+	&armv7_event_attr_l1d_cache.attr.attr,
+	&armv7_event_attr_l1d_tlb_refill.attr.attr,
+	&armv7_event_attr_ld_retired.attr.attr,
+	&armv7_event_attr_st_retired.attr.attr,
+	&armv7_event_attr_inst_retired.attr.attr,
+	&armv7_event_attr_exc_taken.attr.attr,
+	&armv7_event_attr_exc_return.attr.attr,
+	&armv7_event_attr_cid_write_retired.attr.attr,
+	&armv7_event_attr_pc_write_retired.attr.attr,
+	&armv7_event_attr_br_immed_retired.attr.attr,
+	&armv7_event_attr_br_return_retired.attr.attr,
+	&armv7_event_attr_unaligned_ldst_retired.attr.attr,
+	&armv7_event_attr_br_mis_pred.attr.attr,
+	&armv7_event_attr_cpu_cycles.attr.attr,
+	&armv7_event_attr_br_pred.attr.attr,
+	&armv7_event_attr_mem_access.attr.attr,
+	&armv7_event_attr_l1i_cache.attr.attr,
+	&armv7_event_attr_l1d_cache_wb.attr.attr,
+	&armv7_event_attr_l2d_cache.attr.attr,
+	&armv7_event_attr_l2d_cache_refill.attr.attr,
+	&armv7_event_attr_l2d_cache_wb.attr.attr,
+	&armv7_event_attr_bus_access.attr.attr,
+	&armv7_event_attr_memory_error.attr.attr,
+	&armv7_event_attr_inst_spec.attr.attr,
+	&armv7_event_attr_ttbr_write_retired.attr.attr,
+	&armv7_event_attr_bus_cycles.attr.attr,
+	NULL
+};
+
+static struct attribute_group armv7_pmuv2_events_attr_group = {
+	.name = "events",
+	.attrs = armv7_pmuv2_event_attrs,
+};
+
+static const struct attribute_group *armv7_pmuv2_attr_groups[] = {
+	&armv7_pmuv2_events_attr_group,
+	NULL
+};
+
 /*
  * Perf Events' indices
  */
@@ -1085,6 +1259,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a8";
 	cpu_pmu->map_event	= armv7_a8_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1093,6 +1268,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a9";
 	cpu_pmu->map_event	= armv7_a9_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1101,6 +1277,7 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a5";
 	cpu_pmu->map_event	= armv7_a5_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1110,6 +1287,7 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a15";
 	cpu_pmu->map_event	= armv7_a15_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1119,6 +1297,7 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a7";
 	cpu_pmu->map_event	= armv7_a7_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1128,6 +1307,7 @@ static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a12";
 	cpu_pmu->map_event	= armv7_a12_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1135,6 +1315,7 @@ static int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int ret = armv7_a12_pmu_init(cpu_pmu);
 	cpu_pmu->name = "armv7_cortex_a17";
+	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
 	return ret;
 }
 
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 2365a32a595e..e933d2dd71c0 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -548,6 +548,7 @@ static void armpmu_init(struct arm_pmu *armpmu)
 		.stop		= armpmu_stop,
 		.read		= armpmu_read,
 		.filter_match	= armpmu_filter_match,
+		.attr_groups	= armpmu->pmu.attr_groups,
 	};
 }
 
-- 
2.1.4
