From: drew.richardson@arm.com (Drew Richardson)
Date: Fri, 9 Oct 2015 09:53:32 -0700
Subject: [PATCHv2] arm: perf: Add event descriptions
In-Reply-To: <20151009101338.GH26278@arm.com>
References: <20151007182735.GA18706@dreric01-gentoo.localdomain>
 <20151009101338.GH26278@arm.com>
Message-ID: <20151009165330.GA22415@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 09, 2015 at 11:13:38AM +0100, Will Deacon wrote:
> On Wed, Oct 07, 2015 at 11:28:18AM -0700, Drew Richardson wrote:
> > Add additional information about the ARM architected hardware events
> > to make counters self describing. This makes the hardware PMUs easier
> > to use as perf list contains possible events instead of users having
> > to refer to documentation like the ARM TRMs.
> > 
> > Signed-off-by: Drew Richardson <drew.richardson@arm.com>
> > ---
> >  arch/arm/kernel/perf_event_v7.c | 96 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/perf/arm_pmu.c          |  1 +
> >  2 files changed, 97 insertions(+)
> > 
> > diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
> > index 126dc679b230..6623bd0d8a1d 100644
> > --- a/arch/arm/kernel/perf_event_v7.c
> > +++ b/arch/arm/kernel/perf_event_v7.c
> > @@ -547,6 +547,95 @@ static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
> >  	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
> >  };
> >  
> > +static ssize_t armv7_event_sysfs_show(struct device *dev,
> > +				      struct device_attribute *attr, char *page)
> > +{
> > +	struct perf_pmu_events_attr *pmu_attr;
> > +
> > +	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> > +
> > +	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
> > +}
> 
> Can we not do this with a couple of macros, stringification of the event
> code and PMU_EVENT_ATTR_STRING, therefore avoiding this function entirely?

I assumed that doing it this way would be smaller, but using
PMU_EVENT_ATTR_STRING is a few hundred bytes smaller, see
below. (Please let me know if you'd prefer I send it out in a separate
email or even a new thread)

> > +#define ARMV7_EVENT_ATTR(name, config) \
> > +	PMU_EVENT_ATTR(name, armv7_event_attr_##name, config, \
> > +		       armv7_event_sysfs_show);
> > +
> > +ARMV7_EVENT_ATTR(sw_incr, ARMV7_PERFCTR_PMNC_SW_INCR);
> > +ARMV7_EVENT_ATTR(l1i_cache_refill, ARMV7_PERFCTR_L1_ICACHE_REFILL);
> > +ARMV7_EVENT_ATTR(l1i_tlb_refill, ARMV7_PERFCTR_ITLB_REFILL);
> > +ARMV7_EVENT_ATTR(l1d_cache_refill, ARMV7_PERFCTR_L1_DCACHE_REFILL);
> > +ARMV7_EVENT_ATTR(l1d_cache, ARMV7_PERFCTR_L1_DCACHE_ACCESS);
> > +ARMV7_EVENT_ATTR(l1d_tlb_refill, ARMV7_PERFCTR_DTLB_REFILL);
> > +ARMV7_EVENT_ATTR(ld_retired, ARMV7_PERFCTR_MEM_READ);
> > +ARMV7_EVENT_ATTR(st_retired, ARMV7_PERFCTR_MEM_WRITE);
> > +ARMV7_EVENT_ATTR(inst_retired, ARMV7_PERFCTR_INSTR_EXECUTED);
> > +ARMV7_EVENT_ATTR(exc_taken, ARMV7_PERFCTR_EXC_TAKEN);
> > +ARMV7_EVENT_ATTR(exc_return, ARMV7_PERFCTR_EXC_EXECUTED);
> > +ARMV7_EVENT_ATTR(cid_write_retired, ARMV7_PERFCTR_CID_WRITE);
> > +ARMV7_EVENT_ATTR(pc_write_retired, ARMV7_PERFCTR_PC_WRITE);
> > +ARMV7_EVENT_ATTR(br_immed_retired, ARMV7_PERFCTR_PC_IMM_BRANCH);
> > +ARMV7_EVENT_ATTR(br_return_retired, ARMV7_PERFCTR_PC_PROC_RETURN);
> > +ARMV7_EVENT_ATTR(unaligned_ldst_retired, ARMV7_PERFCTR_MEM_UNALIGNED_ACCESS);
> > +ARMV7_EVENT_ATTR(br_mis_pred, ARMV7_PERFCTR_PC_BRANCH_MIS_PRED);
> > +ARMV7_EVENT_ATTR(cpu_cycles, ARMV7_PERFCTR_CLOCK_CYCLES);
> > +ARMV7_EVENT_ATTR(br_pred, ARMV7_PERFCTR_PC_BRANCH_PRED);
> > +ARMV7_EVENT_ATTR(mem_access, ARMV7_PERFCTR_MEM_ACCESS);
> > +ARMV7_EVENT_ATTR(l1i_cache, ARMV7_PERFCTR_L1_ICACHE_ACCESS);
> > +ARMV7_EVENT_ATTR(l1d_cache_wb, ARMV7_PERFCTR_L1_DCACHE_WB);
> > +ARMV7_EVENT_ATTR(l2d_cache, ARMV7_PERFCTR_L2_CACHE_ACCESS);
> > +ARMV7_EVENT_ATTR(l2d_cache_refill, ARMV7_PERFCTR_L2_CACHE_REFILL);
> > +ARMV7_EVENT_ATTR(l2d_cache_wb, ARMV7_PERFCTR_L2_CACHE_WB);
> > +ARMV7_EVENT_ATTR(bus_access, ARMV7_PERFCTR_BUS_ACCESS);
> > +ARMV7_EVENT_ATTR(memory_error, ARMV7_PERFCTR_MEM_ERROR);
> > +ARMV7_EVENT_ATTR(inst_spec, ARMV7_PERFCTR_INSTR_SPEC);
> > +ARMV7_EVENT_ATTR(ttbr_write_retired, ARMV7_PERFCTR_TTBR_WRITE);
> > +ARMV7_EVENT_ATTR(bus_cycles, ARMV7_PERFCTR_BUS_CYCLES);
> > +
> > +static struct attribute *armv7_pmuv2_event_attrs[] = {
> > +	&armv7_event_attr_sw_incr.attr.attr,
> > +	&armv7_event_attr_l1i_cache_refill.attr.attr,
> > +	&armv7_event_attr_l1i_tlb_refill.attr.attr,
> > +	&armv7_event_attr_l1d_cache_refill.attr.attr,
> > +	&armv7_event_attr_l1d_cache.attr.attr,
> > +	&armv7_event_attr_l1d_tlb_refill.attr.attr,
> > +	&armv7_event_attr_ld_retired.attr.attr,
> > +	&armv7_event_attr_st_retired.attr.attr,
> > +	&armv7_event_attr_inst_retired.attr.attr,
> > +	&armv7_event_attr_exc_taken.attr.attr,
> > +	&armv7_event_attr_exc_return.attr.attr,
> > +	&armv7_event_attr_cid_write_retired.attr.attr,
> > +	&armv7_event_attr_pc_write_retired.attr.attr,
> > +	&armv7_event_attr_br_immed_retired.attr.attr,
> > +	&armv7_event_attr_br_return_retired.attr.attr,
> > +	&armv7_event_attr_unaligned_ldst_retired.attr.attr,
> > +	&armv7_event_attr_br_mis_pred.attr.attr,
> > +	&armv7_event_attr_cpu_cycles.attr.attr,
> > +	&armv7_event_attr_br_pred.attr.attr,
> > +	&armv7_event_attr_mem_access.attr.attr,
> > +	&armv7_event_attr_l1i_cache.attr.attr,
> > +	&armv7_event_attr_l1d_cache_wb.attr.attr,
> > +	&armv7_event_attr_l2d_cache.attr.attr,
> > +	&armv7_event_attr_l2d_cache_refill.attr.attr,
> > +	&armv7_event_attr_l2d_cache_wb.attr.attr,
> > +	&armv7_event_attr_bus_access.attr.attr,
> > +	&armv7_event_attr_memory_error.attr.attr,
> > +	&armv7_event_attr_inst_spec.attr.attr,
> > +	&armv7_event_attr_ttbr_write_retired.attr.attr,
> > +	&armv7_event_attr_bus_cycles.attr.attr,
> > +	NULL
> > +};
> > +
> > +static struct attribute_group armv7_pmuv2_events_attr_group = {
> > +	.name = "events",
> > +	.attrs = armv7_pmuv2_event_attrs,
> > +};
> > +
> > +static const struct attribute_group *armv7_pmuv2_attr_groups[] = {
> > +	&armv7_pmuv2_events_attr_group,
> > +	NULL
> > +};
> > +
> >  /*
> >   * Perf Events' indices
> >   */
> > @@ -1085,6 +1174,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
> >  	armv7pmu_init(cpu_pmu);
> >  	cpu_pmu->name		= "armv7_cortex_a8";
> >  	cpu_pmu->map_event	= armv7_a8_map_event;
> > +	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
> >  	return armv7_probe_num_events(cpu_pmu);
> >  }
> >  
> > @@ -1093,6 +1183,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
> >  	armv7pmu_init(cpu_pmu);
> >  	cpu_pmu->name		= "armv7_cortex_a9";
> >  	cpu_pmu->map_event	= armv7_a9_map_event;
> > +	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
> 
> I didn't think these guys supported PMUv2, or is that backwards compatible
> with the older event definitions?

You're correct. I've added a PMUv1 for the A8, A9 and A5 (the A5 seems
to have some PMUv2 events but not all of them and is not documented as
having PMUv2 support).

> Also, would you be able to do something similar for AArch64 too, please?
> (take a look at our for-next/core branch for the latest perf changes).

I'll do that and send something out soon.

---

Add additional information about the ARM architected hardware events
to make counters self describing. This makes the hardware PMUs easier
to use as perf list contains possible events instead of users having
to refer to documentation like the ARM TRMs.

Signed-off-by: Drew Richardson <drew.richardson@arm.com>
---
 arch/arm/kernel/perf_event_v7.c | 119 ++++++++++++++++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c          |   1 +
 2 files changed, 120 insertions(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 126dc679b230..3e94e6c22e16 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -547,6 +547,118 @@ static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
 };
 
+#define ARMV7_EVENT_ATTR(name, config) \
+	PMU_EVENT_ATTR_STRING(name, armv7_event_attr_##name, "event=" #config)
+
+ARMV7_EVENT_ATTR(sw_incr, 0x00);
+ARMV7_EVENT_ATTR(l1i_cache_refill, 0x01);
+ARMV7_EVENT_ATTR(l1i_tlb_refill, 0x02);
+ARMV7_EVENT_ATTR(l1d_cache_refill, 0x03);
+ARMV7_EVENT_ATTR(l1d_cache, 0x04);
+ARMV7_EVENT_ATTR(l1d_tlb_refill, 0x05);
+ARMV7_EVENT_ATTR(ld_retired, 0x06);
+ARMV7_EVENT_ATTR(st_retired, 0x07);
+ARMV7_EVENT_ATTR(inst_retired, 0x08);
+ARMV7_EVENT_ATTR(exc_taken, 0x09);
+ARMV7_EVENT_ATTR(exc_return, 0x0a);
+ARMV7_EVENT_ATTR(cid_write_retired, 0x0b);
+ARMV7_EVENT_ATTR(pc_write_retired, 0x0c);
+ARMV7_EVENT_ATTR(br_immed_retired, 0x0d);
+ARMV7_EVENT_ATTR(br_return_retired, 0x0e);
+ARMV7_EVENT_ATTR(unaligned_ldst_retired, 0x0f);
+ARMV7_EVENT_ATTR(br_mis_pred, 0x10);
+ARMV7_EVENT_ATTR(cpu_cycles, 0x11);
+ARMV7_EVENT_ATTR(br_pred, 0x12);
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
+ARMV7_EVENT_ATTR(mem_access, 0x13);
+ARMV7_EVENT_ATTR(l1i_cache, 0x14);
+ARMV7_EVENT_ATTR(l1d_cache_wb, 0x15);
+ARMV7_EVENT_ATTR(l2d_cache, 0x16);
+ARMV7_EVENT_ATTR(l2d_cache_refill, 0x17);
+ARMV7_EVENT_ATTR(l2d_cache_wb, 0x18);
+ARMV7_EVENT_ATTR(bus_access, 0x19);
+ARMV7_EVENT_ATTR(memory_error, 0x1a);
+ARMV7_EVENT_ATTR(inst_spec, 0x1b);
+ARMV7_EVENT_ATTR(ttbr_write_retired, 0x1c);
+ARMV7_EVENT_ATTR(bus_cycles, 0x1d);
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
@@ -1085,6 +1197,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a8";
 	cpu_pmu->map_event	= armv7_a8_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1093,6 +1206,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a9";
 	cpu_pmu->map_event	= armv7_a9_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1101,6 +1215,7 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a5";
 	cpu_pmu->map_event	= armv7_a5_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv1_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1110,6 +1225,7 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a15";
 	cpu_pmu->map_event	= armv7_a15_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1119,6 +1235,7 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a7";
 	cpu_pmu->map_event	= armv7_a7_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1128,6 +1245,7 @@ static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a12";
 	cpu_pmu->map_event	= armv7_a12_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_pmuv2_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1135,6 +1253,7 @@ static int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
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
