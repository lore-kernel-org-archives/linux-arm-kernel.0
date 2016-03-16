From: ashoks@broadcom.com (Ashok Kumar)
Date: Wed, 16 Mar 2016 06:01:47 -0700
Subject: [PATCH 3/5] arm64/perf: Add Broadcom Vulcan PMU support
In-Reply-To: <1458133309-17045-1-git-send-email-ashoks@broadcom.com>
References: <1458133309-17045-1-git-send-email-ashoks@broadcom.com>
Message-ID: <1458133309-17045-4-git-send-email-ashoks@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom Vulcan uses ARMv8 PMUv3 and supports most of
the ARMv8 recommended implementation defined events.

Added Vulcan events mapping for perf and perf_cache.

Created separate event_attrs structure for vulcan as
it supports more events and doesn't support few events
(like PC_WRITE, MEM_ERROR) from the generic armv8
event_attrs structure.

Signed-off-by: Ashok Kumar <ashoks@broadcom.com>
---
 arch/arm64/kernel/perf_event.c | 253 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 3207b5f..1bb06d3 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -232,6 +232,20 @@ static const unsigned armv8_thunder_perf_map[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV8_PMUV3_PERFCTR_STALL_BACKEND,
 };
 
+/* Broadcom Vulcan events mapping */
+static const unsigned armv8_vulcan_perf_map[PERF_COUNT_HW_MAX] = {
+	PERF_MAP_ALL_UNSUPPORTED,
+	[PERF_COUNT_HW_CPU_CYCLES]		= ARMV8_PMUV3_PERFCTR_CLOCK_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]		= ARMV8_PMUV3_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]	= ARMV8_PMUV3_PERFCTR_L1D_CACHE_ACCESS,
+	[PERF_COUNT_HW_CACHE_MISSES]		= ARMV8_PMUV3_PERFCTR_L1D_CACHE_REFILL,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= ARMV8_PMUV3_PERFCTR_BR_RETIRED,
+	[PERF_COUNT_HW_BRANCH_MISSES]		= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+	[PERF_COUNT_HW_BUS_CYCLES]		= ARMV8_PMUV3_PERFCTR_BUS_CYCLES,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= ARMV8_PMUV3_PERFCTR_STALL_FRONTEND,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= ARMV8_PMUV3_PERFCTR_STALL_BACKEND,
+};
+
 static const unsigned armv8_pmuv3_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 						[PERF_COUNT_HW_CACHE_OP_MAX]
 						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
@@ -324,6 +338,36 @@ static const unsigned armv8_thunder_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
 };
 
+static const unsigned armv8_vulcan_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					      [PERF_COUNT_HW_CACHE_OP_MAX]
+					      [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	PERF_CACHE_MAP_ALL_UNSUPPORTED,
+
+	[C(L1D)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_ACCESS_LD,
+	[C(L1D)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_LD,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_ACCESS_ST,
+	[C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_ST,
+
+	[C(L1I)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE_ACCESS,
+	[C(L1I)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_CACHE_REFILL,
+
+	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB_REFILL,
+	[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_L1I_TLB_ACCESS,
+
+	[C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_L1D_TLB_ACCESS_LD,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_ACCESS_ST,
+	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_LD,
+	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_ST,
+
+	[C(BPU)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+	[C(BPU)][C(OP_READ)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_ACCESS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_PRED,
+	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)]	= ARMV8_PMUV3_PERFCTR_PC_BRANCH_MIS_PRED,
+
+	[C(NODE)][C(OP_READ)][C(RESULT_ACCESS)]	= ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_LD,
+	[C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_ST,
+};
+
 #define ARMV8_EVENT_ATTR_RESOLVE(m) #m
 #define ARMV8_EVENT_ATTR(name, config) \
 	PMU_EVENT_ATTR_STRING(name, armv8_event_attr_##name, \
@@ -379,6 +423,74 @@ ARMV8_EVENT_ATTR(l2i_tlb_refill, ARMV8_PMUV3_PERFCTR_L2I_TLB_REFILL);
 ARMV8_EVENT_ATTR(l2d_tlb_access, ARMV8_PMUV3_PERFCTR_L2D_TLB_ACCESS);
 ARMV8_EVENT_ATTR(l2i_tlb_access, ARMV8_PMUV3_PERFCTR_L2I_TLB_ACCESS);
 
+ARMV8_EVENT_ATTR(l1d_cache_access_ld, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_ACCESS_LD);
+ARMV8_EVENT_ATTR(l1d_cache_refill_ld, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_LD);
+ARMV8_EVENT_ATTR(l1d_cache_access_st, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_ACCESS_ST);
+ARMV8_EVENT_ATTR(l1d_cache_refill_st, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_ST);
+ARMV8_EVENT_ATTR(l1d_tlb_access_ld, ARMV8_IMPDEF_PERFCTR_L1D_TLB_ACCESS_LD);
+ARMV8_EVENT_ATTR(l1d_tlb_access_st, ARMV8_IMPDEF_PERFCTR_L1D_TLB_ACCESS_ST);
+ARMV8_EVENT_ATTR(l1d_tlb_refill_ld, ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_LD);
+ARMV8_EVENT_ATTR(l1d_tlb_refill_st, ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_ST);
+ARMV8_EVENT_ATTR(bus_access_ld, ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_LD);
+ARMV8_EVENT_ATTR(bus_access_st, ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_ST);
+ARMV8_EVENT_ATTR(l1d_cache_refill_inner, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_INNER);
+ARMV8_EVENT_ATTR(l1d_cache_refill_outer, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_OUTER);
+ARMV8_EVENT_ATTR(l1d_cache_wb_victim, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WB_VICTIM);
+ARMV8_EVENT_ATTR(l1d_cache_wb_clean, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WB_CLEAN);
+ARMV8_EVENT_ATTR(l1d_cache_inval, ARMV8_IMPDEF_PERFCTR_L1D_CACHE_INVAL);
+ARMV8_EVENT_ATTR(mem_access_ld, ARMV8_IMPDEF_PERFCTR_MEM_ACCESS_LD);
+ARMV8_EVENT_ATTR(mem_access_st, ARMV8_IMPDEF_PERFCTR_MEM_ACCESS_ST);
+ARMV8_EVENT_ATTR(unaligned_ld_spec, ARMV8_IMPDEF_PERFCTR_UNALIGNED_LD_SPEC);
+ARMV8_EVENT_ATTR(unaligned_st_spec, ARMV8_IMPDEF_PERFCTR_UNALIGNED_ST_SPEC);
+ARMV8_EVENT_ATTR(unaligned_ldst_spec, ARMV8_IMPDEF_PERFCTR_UNALIGNED_LDST_SPEC);
+ARMV8_EVENT_ATTR(ldrex_spec, ARMV8_IMPDEF_PERFCTR_LDREX_SPEC);
+ARMV8_EVENT_ATTR(strex_pass_spec, ARMV8_IMPDEF_PERFCTR_STREX_PASS_SPEC);
+ARMV8_EVENT_ATTR(strex_fail_spec, ARMV8_IMPDEF_PERFCTR_STREX_FAIL_SPEC);
+ARMV8_EVENT_ATTR(strex_spec, ARMV8_IMPDEF_PERFCTR_STREX_SPEC);
+ARMV8_EVENT_ATTR(ld_spec, ARMV8_IMPDEF_PERFCTR_LD_SPEC);
+ARMV8_EVENT_ATTR(st_spec, ARMV8_IMPDEF_PERFCTR_ST_SPEC);
+ARMV8_EVENT_ATTR(ldst_spec, ARMV8_IMPDEF_PERFCTR_LDST_SPEC);
+ARMV8_EVENT_ATTR(dsb_spec, ARMV8_IMPDEF_PERFCTR_DSB_SPEC);
+ARMV8_EVENT_ATTR(dmb_spec, ARMV8_IMPDEF_PERFCTR_DMB_SPEC);
+ARMV8_EVENT_ATTR(rc_ld_spec, ARMV8_IMPDEF_PERFCTR_RC_LD_SPEC);
+ARMV8_EVENT_ATTR(rc_st_spec, ARMV8_IMPDEF_PERFCTR_RC_ST_SPEC);
+ARMV8_EVENT_ATTR(l2d_cache_access_ld, ARMV8_IMPDEF_PERFCTR_L2D_CACHE_ACCESS_LD);
+ARMV8_EVENT_ATTR(l2d_cache_access_st, ARMV8_IMPDEF_PERFCTR_L2D_CACHE_ACCESS_ST);
+ARMV8_EVENT_ATTR(l2d_cache_refill_ld, ARMV8_IMPDEF_PERFCTR_L2D_CACHE_REFILL_LD);
+ARMV8_EVENT_ATTR(l2d_cache_refill_st, ARMV8_IMPDEF_PERFCTR_L2D_CACHE_REFILL_ST);
+ARMV8_EVENT_ATTR(l2d_cache_wb_victim, ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WB_VICTIM);
+ARMV8_EVENT_ATTR(l2d_cache_wb_clean, ARMV8_IMPDEF_PERFCTR_L2D_CACHE_WB_CLEAN);
+ARMV8_EVENT_ATTR(l2d_cache_inval, ARMV8_IMPDEF_PERFCTR_L2D_CACHE_INVAL);
+ARMV8_EVENT_ATTR(bus_access_shared, ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_SHARED);
+ARMV8_EVENT_ATTR(bus_access_not_shared, ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_NOT_SHARED);
+ARMV8_EVENT_ATTR(bus_access_normal, ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_NORMAL);
+ARMV8_EVENT_ATTR(bus_access_periph, ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_PERIPH);
+ARMV8_EVENT_ATTR(l2d_tlb_refill_ld, ARMV8_IMPDEF_PERFCTR_L2D_TLB_REFILL_LD);
+ARMV8_EVENT_ATTR(l2d_tlb_refill_st, ARMV8_IMPDEF_PERFCTR_L2D_TLB_REFILL_ST);
+ARMV8_EVENT_ATTR(l2d_tlb_access_ld, ARMV8_IMPDEF_PERFCTR_L2D_TLB_ACCESS_LD);
+ARMV8_EVENT_ATTR(l2d_tlb_access_st, ARMV8_IMPDEF_PERFCTR_L2D_TLB_ACCESS_ST);
+ARMV8_EVENT_ATTR(integer_dp_spec, ARMV8_IMPDEF_PERFCTR_INTEGER_DP_SPEC);
+ARMV8_EVENT_ATTR(br_immed_spec, ARMV8_IMPDEF_PERFCTR_BR_IMMED_SPEC);
+ARMV8_EVENT_ATTR(br_return_spec, ARMV8_IMPDEF_PERFCTR_BR_RETURN_SPEC);
+ARMV8_EVENT_ATTR(br_indirect_spec, ARMV8_IMPDEF_PERFCTR_BR_INDIRECT_SPEC);
+ARMV8_EVENT_ATTR(ase_spec, ARMV8_IMPDEF_PERFCTR_ASE_SPEC);
+ARMV8_EVENT_ATTR(vfp_spec, ARMV8_IMPDEF_PERFCTR_VFP_SPEC);
+ARMV8_EVENT_ATTR(crypto_spec, ARMV8_IMPDEF_PERFCTR_CRYPTO_SPEC);
+ARMV8_EVENT_ATTR(isb_spec, ARMV8_IMPDEF_PERFCTR_ISB_SPEC);
+ARMV8_EVENT_ATTR(exc_undef, ARMV8_IMPDEF_PERFCTR_EXC_UNDEF);
+ARMV8_EVENT_ATTR(exc_svc, ARMV8_IMPDEF_PERFCTR_EXC_SVC);
+ARMV8_EVENT_ATTR(exc_instr_abort, ARMV8_IMPDEF_PERFCTR_EXC_INSTR_ABORT);
+ARMV8_EVENT_ATTR(exc_data_abort, ARMV8_IMPDEF_PERFCTR_EXC_DATA_ABORT);
+ARMV8_EVENT_ATTR(exc_irq, ARMV8_IMPDEF_PERFCTR_EXC_IRQ);
+ARMV8_EVENT_ATTR(exc_fiq, ARMV8_IMPDEF_PERFCTR_EXC_FIQ);
+ARMV8_EVENT_ATTR(exc_smc, ARMV8_IMPDEF_PERFCTR_EXC_SMC);
+ARMV8_EVENT_ATTR(exc_hvc, ARMV8_IMPDEF_PERFCTR_EXC_HVC);
+ARMV8_EVENT_ATTR(exc_trap_instr_abort, ARMV8_IMPDEF_PERFCTR_EXC_TRAP_INSTR_ABORT);
+ARMV8_EVENT_ATTR(exc_trap_data_abort, ARMV8_IMPDEF_PERFCTR_EXC_TRAP_DATA_ABORT);
+ARMV8_EVENT_ATTR(exc_trap_other, ARMV8_IMPDEF_PERFCTR_EXC_TRAP_OTHER);
+ARMV8_EVENT_ATTR(exc_trap_irq, ARMV8_IMPDEF_PERFCTR_EXC_TRAP_IRQ);
+ARMV8_EVENT_ATTR(exc_trap_fiq, ARMV8_IMPDEF_PERFCTR_EXC_TRAP_FIQ);
+
 static struct attribute *armv8_pmuv3_event_attrs[] = {
 	&armv8_event_attr_sw_incr.attr.attr,
 	&armv8_event_attr_l1i_cache_refill.attr.attr,
@@ -432,11 +544,129 @@ static struct attribute *armv8_pmuv3_event_attrs[] = {
 	NULL,
 };
 
+static struct attribute *vulcan_pmuv3_event_attrs[] = {
+	&armv8_event_attr_sw_incr.attr.attr,
+	&armv8_event_attr_l1i_cache_refill.attr.attr,
+	&armv8_event_attr_l1i_tlb_refill.attr.attr,
+	&armv8_event_attr_l1d_cache_refill.attr.attr,
+	&armv8_event_attr_l1d_cache_access.attr.attr,
+	&armv8_event_attr_l1d_tlb_refill.attr.attr,
+	&armv8_event_attr_ld_retired.attr.attr,
+	&armv8_event_attr_st_retired.attr.attr,
+	&armv8_event_attr_inst_retired.attr.attr,
+	&armv8_event_attr_exc_taken.attr.attr,
+	&armv8_event_attr_exc_return.attr.attr,
+	&armv8_event_attr_cid_write_retired.attr.attr,
+	&armv8_event_attr_br_immed_retired.attr.attr,
+	&armv8_event_attr_br_return_retired.attr.attr,
+	&armv8_event_attr_unaligned_ldst_retired.attr.attr,
+	&armv8_event_attr_br_mis_pred.attr.attr,
+	&armv8_event_attr_cpu_cycles.attr.attr,
+	&armv8_event_attr_br_pred.attr.attr,
+	&armv8_event_attr_mem_access.attr.attr,
+	&armv8_event_attr_l1i_cache_access.attr.attr,
+	&armv8_event_attr_l1d_cache_wb.attr.attr,
+	&armv8_event_attr_l2d_cache_access.attr.attr,
+	&armv8_event_attr_l2d_cache_refill.attr.attr,
+	&armv8_event_attr_l2d_cache_wb.attr.attr,
+	&armv8_event_attr_bus_access.attr.attr,
+	&armv8_event_attr_inst_spec.attr.attr,
+	&armv8_event_attr_ttbr_write_retired.attr.attr,
+	&armv8_event_attr_bus_cycles.attr.attr,
+	&armv8_event_attr_chain.attr.attr,
+	&armv8_event_attr_l1d_cache_allocate.attr.attr,
+	&armv8_event_attr_l2d_cache_allocate.attr.attr,
+	&armv8_event_attr_br_retired.attr.attr,
+	&armv8_event_attr_br_mis_pred_retired.attr.attr,
+	&armv8_event_attr_stall_frontend.attr.attr,
+	&armv8_event_attr_stall_backend.attr.attr,
+	&armv8_event_attr_l1d_tlb_access.attr.attr,
+	&armv8_event_attr_l1i_tlb_access.attr.attr,
+	&armv8_event_attr_l2d_tlb_refill.attr.attr,
+	&armv8_event_attr_l2i_tlb_refill.attr.attr,
+	&armv8_event_attr_l2d_tlb_access.attr.attr,
+	&armv8_event_attr_l2i_tlb_access.attr.attr,
+
+	&armv8_event_attr_l1d_cache_access_ld.attr.attr,
+	&armv8_event_attr_l1d_cache_refill_ld.attr.attr,
+	&armv8_event_attr_l1d_cache_access_st.attr.attr,
+	&armv8_event_attr_l1d_cache_refill_st.attr.attr,
+	&armv8_event_attr_l1d_tlb_access_ld.attr.attr,
+	&armv8_event_attr_l1d_tlb_access_st.attr.attr,
+	&armv8_event_attr_l1d_tlb_refill_ld.attr.attr,
+	&armv8_event_attr_l1d_tlb_refill_st.attr.attr,
+	&armv8_event_attr_bus_access_ld.attr.attr,
+	&armv8_event_attr_bus_access_st.attr.attr,
+	&armv8_event_attr_l1d_cache_refill_inner.attr.attr,
+	&armv8_event_attr_l1d_cache_refill_outer.attr.attr,
+	&armv8_event_attr_l1d_cache_wb_victim.attr.attr,
+	&armv8_event_attr_l1d_cache_wb_clean.attr.attr,
+	&armv8_event_attr_l1d_cache_inval.attr.attr,
+	&armv8_event_attr_mem_access_ld.attr.attr,
+	&armv8_event_attr_mem_access_st.attr.attr,
+	&armv8_event_attr_unaligned_ld_spec.attr.attr,
+	&armv8_event_attr_unaligned_st_spec.attr.attr,
+	&armv8_event_attr_unaligned_ldst_spec.attr.attr,
+	&armv8_event_attr_ldrex_spec.attr.attr,
+	&armv8_event_attr_strex_pass_spec.attr.attr,
+	&armv8_event_attr_strex_fail_spec.attr.attr,
+	&armv8_event_attr_strex_spec.attr.attr,
+	&armv8_event_attr_ld_spec.attr.attr,
+	&armv8_event_attr_st_spec.attr.attr,
+	&armv8_event_attr_ldst_spec.attr.attr,
+	&armv8_event_attr_dsb_spec.attr.attr,
+	&armv8_event_attr_dmb_spec.attr.attr,
+	&armv8_event_attr_rc_ld_spec.attr.attr,
+	&armv8_event_attr_rc_st_spec.attr.attr,
+	&armv8_event_attr_l2d_cache_access_ld.attr.attr,
+	&armv8_event_attr_l2d_cache_access_st.attr.attr,
+	&armv8_event_attr_l2d_cache_refill_ld.attr.attr,
+	&armv8_event_attr_l2d_cache_refill_st.attr.attr,
+	&armv8_event_attr_l2d_cache_wb_victim.attr.attr,
+	&armv8_event_attr_l2d_cache_wb_clean.attr.attr,
+	&armv8_event_attr_l2d_cache_inval.attr.attr,
+	&armv8_event_attr_bus_access_shared.attr.attr,
+	&armv8_event_attr_bus_access_not_shared.attr.attr,
+	&armv8_event_attr_bus_access_normal.attr.attr,
+	&armv8_event_attr_bus_access_periph.attr.attr,
+	&armv8_event_attr_l2d_tlb_refill_ld.attr.attr,
+	&armv8_event_attr_l2d_tlb_refill_st.attr.attr,
+	&armv8_event_attr_l2d_tlb_access_ld.attr.attr,
+	&armv8_event_attr_l2d_tlb_access_st.attr.attr,
+	&armv8_event_attr_integer_dp_spec.attr.attr,
+	&armv8_event_attr_br_immed_spec.attr.attr,
+	&armv8_event_attr_br_return_spec.attr.attr,
+	&armv8_event_attr_br_indirect_spec.attr.attr,
+	&armv8_event_attr_ase_spec.attr.attr,
+	&armv8_event_attr_vfp_spec.attr.attr,
+	&armv8_event_attr_crypto_spec.attr.attr,
+	&armv8_event_attr_isb_spec.attr.attr,
+	&armv8_event_attr_exc_undef.attr.attr,
+	&armv8_event_attr_exc_svc.attr.attr,
+	&armv8_event_attr_exc_instr_abort.attr.attr,
+	&armv8_event_attr_exc_data_abort.attr.attr,
+	&armv8_event_attr_exc_irq.attr.attr,
+	&armv8_event_attr_exc_fiq.attr.attr,
+	&armv8_event_attr_exc_smc.attr.attr,
+	&armv8_event_attr_exc_hvc.attr.attr,
+	&armv8_event_attr_exc_trap_instr_abort.attr.attr,
+	&armv8_event_attr_exc_trap_data_abort.attr.attr,
+	&armv8_event_attr_exc_trap_other.attr.attr,
+	&armv8_event_attr_exc_trap_irq.attr.attr,
+	&armv8_event_attr_exc_trap_fiq.attr.attr,
+	NULL,
+};
+
 static struct attribute_group armv8_pmuv3_events_attr_group = {
 	.name = "events",
 	.attrs = armv8_pmuv3_event_attrs,
 };
 
+static struct attribute_group vulcan_pmuv3_events_attr_group = {
+	.name = "events",
+	.attrs = vulcan_pmuv3_event_attrs,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-9");
 
 static struct attribute *armv8_pmuv3_format_attrs[] = {
@@ -455,6 +685,12 @@ static const struct attribute_group *armv8_pmuv3_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *vulcan_pmuv3_attr_groups[] = {
+	&vulcan_pmuv3_events_attr_group,
+	&armv8_pmuv3_format_attr_group,
+	NULL,
+};
+
 /*
  * Perf Events' indices
  */
@@ -891,6 +1127,13 @@ static int armv8_thunder_map_event(struct perf_event *event)
 				ARMV8_EVTYPE_EVENT);
 }
 
+static int armv8_vulcan_map_event(struct perf_event *event)
+{
+	return armpmu_map_event(event, &armv8_vulcan_perf_map,
+				&armv8_vulcan_perf_cache_map,
+				ARMV8_EVTYPE_EVENT);
+}
+
 static void armv8pmu_read_num_pmnc_events(void *info)
 {
 	int *nb_cnt = info;
@@ -968,12 +1211,22 @@ static int armv8_thunder_pmu_init(struct arm_pmu *cpu_pmu)
 	return armv8pmu_probe_num_events(cpu_pmu);
 }
 
+static int armv8_vulcan_pmu_init(struct arm_pmu *cpu_pmu)
+{
+	armv8_pmu_init(cpu_pmu);
+	cpu_pmu->name			= "armv8_brcm_vulcan";
+	cpu_pmu->map_event		= armv8_vulcan_map_event;
+	cpu_pmu->pmu.attr_groups	= vulcan_pmuv3_attr_groups;
+	return armv8pmu_probe_num_events(cpu_pmu);
+}
+
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_init},
 	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_a53_pmu_init},
 	{.compatible = "arm,cortex-a57-pmu",	.data = armv8_a57_pmu_init},
 	{.compatible = "arm,cortex-a72-pmu",	.data = armv8_a72_pmu_init},
 	{.compatible = "cavium,thunder-pmu",	.data = armv8_thunder_pmu_init},
+	{.compatible = "brcm,vulcan-pmu",	.data = armv8_vulcan_pmu_init},
 	{},
 };
 
-- 
2.1.0
