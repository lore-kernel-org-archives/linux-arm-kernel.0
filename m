From: drew.richardson@arm.com (Drew Richardson)
Date: Mon, 3 Aug 2015 17:15:26 -0700
Subject: [PATCH] arm: perf: Add event descriptions
Message-ID: <20150804001522.GA13214@dreric01-gentoo.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add additional information about hardware events to make counters self
describing. This makes the hardware PMUs easier to use as perf list
contains the possible events instead of users having to refer to
documentation like the ARM TRMs. This could also allow tools like
oprofile to support PMUs without requiring an update.

Signed-off-by: Drew Richardson <drew.richardson@arm.com>
---
 arch/arm/kernel/perf_event.c    |   1 +
 arch/arm/kernel/perf_event_v7.c | 617 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 618 insertions(+)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 54272e0be713..a7f2c84bae15 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -548,6 +548,7 @@ static void armpmu_init(struct arm_pmu *armpmu)
 		.stop		= armpmu_stop,
 		.read		= armpmu_read,
 		.filter_match	= armpmu_filter_match,
+		.attr_groups	= armpmu->pmu.attr_groups,
 	};
 }
 
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index f9b37f876e20..d46bc78b5997 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -547,6 +547,616 @@ static const unsigned scorpion_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 	[C(BPU)][C(OP_WRITE)][C(RESULT_MISS)] = ARMV7_PERFCTR_PC_BRANCH_MIS_PRED,
 };
 
+static ssize_t armv7_event_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *ea = container_of(attr,
+						    struct dev_ext_attribute,
+						    attr);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", (char *)ea->var);
+}
+
+#define ARMV7_EVENT_ATTR(config, name) \
+	struct dev_ext_attribute armv7_event_attr_##config##_##name = \
+		{ __ATTR(name, S_IRUGO, armv7_event_show, NULL), \
+		  "config=0x" #config }
+
+static ARMV7_EVENT_ATTR(00, sw_incr);
+static ARMV7_EVENT_ATTR(01, l1i_cache_refill);
+static ARMV7_EVENT_ATTR(02, l1i_tlb_refill);
+static ARMV7_EVENT_ATTR(03, l1d_cache_refill);
+static ARMV7_EVENT_ATTR(04, l1d_cache);
+static ARMV7_EVENT_ATTR(05, l1d_tlb_refill);
+static ARMV7_EVENT_ATTR(06, ld_retired);
+static ARMV7_EVENT_ATTR(07, st_retired);
+static ARMV7_EVENT_ATTR(08, inst_retired);
+static ARMV7_EVENT_ATTR(09, exc_taken);
+static ARMV7_EVENT_ATTR(0a, exc_return);
+static ARMV7_EVENT_ATTR(0b, cid_write_retired);
+static ARMV7_EVENT_ATTR(0c, pc_write_retired);
+static ARMV7_EVENT_ATTR(0d, br_immed_retired);
+static ARMV7_EVENT_ATTR(0e, br_return_retired);
+static ARMV7_EVENT_ATTR(0f, unaligned_ldst_retired);
+static ARMV7_EVENT_ATTR(10, br_mis_pred);
+static ARMV7_EVENT_ATTR(11, cpu_cycles);
+static ARMV7_EVENT_ATTR(12, br_pred);
+static ARMV7_EVENT_ATTR(13, mem_access);
+static ARMV7_EVENT_ATTR(14, l1i_cache);
+static ARMV7_EVENT_ATTR(15, l1d_cache_wb);
+static ARMV7_EVENT_ATTR(16, l2d_cache);
+static ARMV7_EVENT_ATTR(17, l2d_cache_refill);
+static ARMV7_EVENT_ATTR(18, l2d_cache_wb);
+static ARMV7_EVENT_ATTR(19, bus_access);
+static ARMV7_EVENT_ATTR(1a, memory_error);
+static ARMV7_EVENT_ATTR(1b, inst_spec);
+static ARMV7_EVENT_ATTR(1c, ttbr_write_retired);
+static ARMV7_EVENT_ATTR(1d, bus_cycles);
+static ARMV7_EVENT_ATTR(40, java_bc_exec);
+static ARMV7_EVENT_ATTR(40, l1d_cache_ld);
+static ARMV7_EVENT_ATTR(40, wb_full);
+static ARMV7_EVENT_ATTR(41, java_swbc_exec);
+static ARMV7_EVENT_ATTR(41, l1d_cache_st);
+static ARMV7_EVENT_ATTR(41, l2_store_merged);
+static ARMV7_EVENT_ATTR(42, jazelle_branch_executed);
+static ARMV7_EVENT_ATTR(42, l1d_cache_refill_ld);
+static ARMV7_EVENT_ATTR(42, l2_store_bufferable);
+static ARMV7_EVENT_ATTR(43, l1d_cache_refill_st);
+static ARMV7_EVENT_ATTR(43, l2_access);
+static ARMV7_EVENT_ATTR(44, l2_miss);
+static ARMV7_EVENT_ATTR(45, axi_read);
+static ARMV7_EVENT_ATTR(46, axi_write);
+static ARMV7_EVENT_ATTR(46, l1d_cache_wb_victim);
+static ARMV7_EVENT_ATTR(47, l1d_cache_wb_clean);
+static ARMV7_EVENT_ATTR(47, mem_replay);
+static ARMV7_EVENT_ATTR(48, l1d_cache_inval);
+static ARMV7_EVENT_ATTR(48, mem_replay_unaligned);
+static ARMV7_EVENT_ATTR(49, l1d_miss_hash);
+static ARMV7_EVENT_ATTR(4a, l1i_miss_hash);
+static ARMV7_EVENT_ATTR(4b, l1d_page_coloring);
+static ARMV7_EVENT_ATTR(4c, l1d_hit_neon);
+static ARMV7_EVENT_ATTR(4c, l1d_tlb_refill_ld);
+static ARMV7_EVENT_ATTR(4d, l1d_access_neon);
+static ARMV7_EVENT_ATTR(4d, l1d_tlb_refill_st);
+static ARMV7_EVENT_ATTR(4e, l2_access_neon);
+static ARMV7_EVENT_ATTR(4f, l2_hit_neon);
+static ARMV7_EVENT_ATTR(50, coherent_miss);
+static ARMV7_EVENT_ATTR(50, l1i_access);
+static ARMV7_EVENT_ATTR(50, l2d_cache_ld);
+static ARMV7_EVENT_ATTR(51, coherent_hit);
+static ARMV7_EVENT_ATTR(51, l2d_cache_st);
+static ARMV7_EVENT_ATTR(51, return_mispredict);
+static ARMV7_EVENT_ATTR(52, branch_mispredict);
+static ARMV7_EVENT_ATTR(52, l2d_cache_refill_ld);
+static ARMV7_EVENT_ATTR(53, branch_predict_taken);
+static ARMV7_EVENT_ATTR(53, l2d_cache_refill_st);
+static ARMV7_EVENT_ATTR(54, branch_predictable_taken);
+static ARMV7_EVENT_ATTR(55, operation_issued);
+static ARMV7_EVENT_ATTR(56, inst_stall);
+static ARMV7_EVENT_ATTR(56, l2d_cache_wb_victim);
+static ARMV7_EVENT_ATTR(57, inst_issued);
+static ARMV7_EVENT_ATTR(57, l2d_cache_wb_clean);
+static ARMV7_EVENT_ATTR(58, l2d_cache_inval);
+static ARMV7_EVENT_ATTR(58, stall_neon_data);
+static ARMV7_EVENT_ATTR(59, stall_neon_inst);
+static ARMV7_EVENT_ATTR(5a, int_neon_busy);
+static ARMV7_EVENT_ATTR(60, bus_access_ld);
+static ARMV7_EVENT_ATTR(60, stall_inst);
+static ARMV7_EVENT_ATTR(61, bus_access_st);
+static ARMV7_EVENT_ATTR(61, stall_data);
+static ARMV7_EVENT_ATTR(62, bus_access_shared);
+static ARMV7_EVENT_ATTR(62, stall_tlb);
+static ARMV7_EVENT_ATTR(63, bus_access_not_shared);
+static ARMV7_EVENT_ATTR(63, strex_pass);
+static ARMV7_EVENT_ATTR(64, bus_access_normal);
+static ARMV7_EVENT_ATTR(64, strex_failed);
+static ARMV7_EVENT_ATTR(65, bus_access_periph);
+static ARMV7_EVENT_ATTR(65, data_evict);
+static ARMV7_EVENT_ATTR(66, issue_no_dispatch);
+static ARMV7_EVENT_ATTR(66, mem_access_ld);
+static ARMV7_EVENT_ATTR(67, issue_empty);
+static ARMV7_EVENT_ATTR(67, mem_access_st);
+static ARMV7_EVENT_ATTR(68, inst_exec);
+static ARMV7_EVENT_ATTR(68, unaligned_ld_spec);
+static ARMV7_EVENT_ATTR(69, cache_linefill);
+static ARMV7_EVENT_ATTR(69, unaligned_st_spec);
+static ARMV7_EVENT_ATTR(6a, prefetch_linefill);
+static ARMV7_EVENT_ATTR(6a, unaligned_ldst_spec);
+static ARMV7_EVENT_ATTR(6b, prefetch_hit);
+static ARMV7_EVENT_ATTR(6c, ldrex_spec);
+static ARMV7_EVENT_ATTR(6d, strex_pass_spec);
+static ARMV7_EVENT_ATTR(6e, predictable_ret);
+static ARMV7_EVENT_ATTR(6e, strex_fail_spec);
+static ARMV7_EVENT_ATTR(6f, strex_spec);
+static ARMV7_EVENT_ATTR(70, inst_main_exec);
+static ARMV7_EVENT_ATTR(70, ld_spec);
+static ARMV7_EVENT_ATTR(70, pmuextin0);
+static ARMV7_EVENT_ATTR(71, inst_second_exec);
+static ARMV7_EVENT_ATTR(71, pmuextin1);
+static ARMV7_EVENT_ATTR(71, st_spec);
+static ARMV7_EVENT_ATTR(72, inst_load_store);
+static ARMV7_EVENT_ATTR(72, ldst_spec);
+static ARMV7_EVENT_ATTR(72, pmuextin);
+static ARMV7_EVENT_ATTR(73, dp_spec);
+static ARMV7_EVENT_ATTR(73, inst_fp);
+static ARMV7_EVENT_ATTR(74, ase_spec);
+static ARMV7_EVENT_ATTR(74, inst_neon);
+static ARMV7_EVENT_ATTR(75, vfp_spec);
+static ARMV7_EVENT_ATTR(76, pc_write_spec);
+static ARMV7_EVENT_ATTR(78, br_immed_spec);
+static ARMV7_EVENT_ATTR(79, br_return_spec);
+static ARMV7_EVENT_ATTR(7a, br_indirect_spec);
+static ARMV7_EVENT_ATTR(7c, isb_spec);
+static ARMV7_EVENT_ATTR(7d, dsb_spec);
+static ARMV7_EVENT_ATTR(7e, dmb_spec);
+static ARMV7_EVENT_ATTR(80, stall_pld);
+static ARMV7_EVENT_ATTR(81, exc_undef);
+static ARMV7_EVENT_ATTR(81, stall_write);
+static ARMV7_EVENT_ATTR(82, stall_inst_tlb);
+static ARMV7_EVENT_ATTR(83, stall_data_tlb);
+static ARMV7_EVENT_ATTR(84, stall_inst_mtlb);
+static ARMV7_EVENT_ATTR(85, stall_data_mtlb);
+static ARMV7_EVENT_ATTR(86, exc_irq);
+static ARMV7_EVENT_ATTR(86, stall_dmb);
+static ARMV7_EVENT_ATTR(87, exc_fiq);
+static ARMV7_EVENT_ATTR(8a, clock_int);
+static ARMV7_EVENT_ATTR(8a, exc_hvc);
+static ARMV7_EVENT_ATTR(8b, clock_data);
+static ARMV7_EVENT_ATTR(8c, clock_neon);
+static ARMV7_EVENT_ATTR(8d, tlb_inst);
+static ARMV7_EVENT_ATTR(8e, tlb_data);
+static ARMV7_EVENT_ATTR(90, inst_isb);
+static ARMV7_EVENT_ATTR(91, inst_dsb);
+static ARMV7_EVENT_ATTR(92, inst_dmb);
+static ARMV7_EVENT_ATTR(93, ext_irq);
+static ARMV7_EVENT_ATTR(c0, ext_mem_req);
+static ARMV7_EVENT_ATTR(c0, stall_inst_linefill);
+static ARMV7_EVENT_ATTR(c1, ext_mem_req_nc);
+static ARMV7_EVENT_ATTR(c1, stall_inst_tlb);
+static ARMV7_EVENT_ATTR(c2, cache_tag);
+static ARMV7_EVENT_ATTR(c2, prefetch_linefill);
+static ARMV7_EVENT_ATTR(c3, cache_data);
+static ARMV7_EVENT_ATTR(c3, prefetch_linefill_drop);
+static ARMV7_EVENT_ATTR(c4, cache_btac);
+static ARMV7_EVENT_ATTR(c4, read_alloc_enter);
+static ARMV7_EVENT_ATTR(c5, read_alloc);
+static ARMV7_EVENT_ATTR(c7, etm_out0);
+static ARMV7_EVENT_ATTR(c8, etm_out1);
+static ARMV7_EVENT_ATTR(c9, stall_sb_full);
+static ARMV7_EVENT_ATTR(ca, local_cluster_snoop);
+static ARMV7_EVENT_ATTR(d3, busy_lsu);
+static ARMV7_EVENT_ATTR(d8, busy_lsi);
+static ARMV7_EVENT_ATTR(d9, busy_dpi);
+static ARMV7_EVENT_ATTR(da, busy_dei);
+static ARMV7_EVENT_ATTR(db, neon_cond_fail);
+static ARMV7_EVENT_ATTR(dc, trap_hv);
+static ARMV7_EVENT_ATTR(de, ptm_extout0);
+static ARMV7_EVENT_ATTR(df, ptm_extout1);
+static ARMV7_EVENT_ATTR(e0, mmu_walk);
+static ARMV7_EVENT_ATTR(e1, mmu_s1_walk);
+static ARMV7_EVENT_ATTR(e2, mmu_s2_walk);
+static ARMV7_EVENT_ATTR(e3, mmu_lsu_walk);
+static ARMV7_EVENT_ATTR(e4, mmu_inst_walk);
+static ARMV7_EVENT_ATTR(e5, mmu_pre_walk);
+static ARMV7_EVENT_ATTR(e6, mmu_cp15_walk);
+static ARMV7_EVENT_ATTR(e7, tlb_pld_refill);
+static ARMV7_EVENT_ATTR(e8, tlb_cp15_refill);
+static ARMV7_EVENT_ATTR(e9, tlb_flush);
+static ARMV7_EVENT_ATTR(ea, tlb_access);
+static ARMV7_EVENT_ATTR(eb, tlb_miss);
+
+static struct attribute *armv7_a8_event_attrs[] = {
+	&armv7_event_attr_00_sw_incr.attr.attr,
+	&armv7_event_attr_01_l1i_cache_refill.attr.attr,
+	&armv7_event_attr_02_l1i_tlb_refill.attr.attr,
+	&armv7_event_attr_03_l1d_cache_refill.attr.attr,
+	&armv7_event_attr_04_l1d_cache.attr.attr,
+	&armv7_event_attr_05_l1d_tlb_refill.attr.attr,
+	&armv7_event_attr_06_ld_retired.attr.attr,
+	&armv7_event_attr_07_st_retired.attr.attr,
+	&armv7_event_attr_08_inst_retired.attr.attr,
+	&armv7_event_attr_09_exc_taken.attr.attr,
+	&armv7_event_attr_0a_exc_return.attr.attr,
+	&armv7_event_attr_0b_cid_write_retired.attr.attr,
+	&armv7_event_attr_0c_pc_write_retired.attr.attr,
+	&armv7_event_attr_0d_br_immed_retired.attr.attr,
+	&armv7_event_attr_0e_br_return_retired.attr.attr,
+	&armv7_event_attr_0f_unaligned_ldst_retired.attr.attr,
+	&armv7_event_attr_10_br_mis_pred.attr.attr,
+	&armv7_event_attr_11_cpu_cycles.attr.attr,
+	&armv7_event_attr_12_br_pred.attr.attr,
+	&armv7_event_attr_40_wb_full.attr.attr,
+	&armv7_event_attr_41_l2_store_merged.attr.attr,
+	&armv7_event_attr_42_l2_store_bufferable.attr.attr,
+	&armv7_event_attr_43_l2_access.attr.attr,
+	&armv7_event_attr_44_l2_miss.attr.attr,
+	&armv7_event_attr_45_axi_read.attr.attr,
+	&armv7_event_attr_46_axi_write.attr.attr,
+	&armv7_event_attr_47_mem_replay.attr.attr,
+	&armv7_event_attr_48_mem_replay_unaligned.attr.attr,
+	&armv7_event_attr_49_l1d_miss_hash.attr.attr,
+	&armv7_event_attr_4a_l1i_miss_hash.attr.attr,
+	&armv7_event_attr_4b_l1d_page_coloring.attr.attr,
+	&armv7_event_attr_4c_l1d_hit_neon.attr.attr,
+	&armv7_event_attr_4d_l1d_access_neon.attr.attr,
+	&armv7_event_attr_4e_l2_access_neon.attr.attr,
+	&armv7_event_attr_4f_l2_hit_neon.attr.attr,
+	&armv7_event_attr_50_l1i_access.attr.attr,
+	&armv7_event_attr_51_return_mispredict.attr.attr,
+	&armv7_event_attr_52_branch_mispredict.attr.attr,
+	&armv7_event_attr_53_branch_predict_taken.attr.attr,
+	&armv7_event_attr_54_branch_predictable_taken.attr.attr,
+	&armv7_event_attr_55_operation_issued.attr.attr,
+	&armv7_event_attr_56_inst_stall.attr.attr,
+	&armv7_event_attr_57_inst_issued.attr.attr,
+	&armv7_event_attr_58_stall_neon_data.attr.attr,
+	&armv7_event_attr_59_stall_neon_inst.attr.attr,
+	&armv7_event_attr_5a_int_neon_busy.attr.attr,
+	&armv7_event_attr_70_pmuextin0.attr.attr,
+	&armv7_event_attr_71_pmuextin1.attr.attr,
+	&armv7_event_attr_72_pmuextin.attr.attr,
+	NULL
+};
+
+static struct attribute_group armv7_a8_events_attr_group = {
+	.name = "events",
+	.attrs = armv7_a8_event_attrs,
+};
+
+static const struct attribute_group *armv7_a8_attr_groups[] = {
+	&armv7_a8_events_attr_group,
+	NULL
+};
+
+static struct attribute *armv7_a9_event_attrs[] = {
+	&armv7_event_attr_00_sw_incr.attr.attr,
+	&armv7_event_attr_01_l1i_cache_refill.attr.attr,
+	&armv7_event_attr_02_l1i_tlb_refill.attr.attr,
+	&armv7_event_attr_03_l1d_cache_refill.attr.attr,
+	&armv7_event_attr_04_l1d_cache.attr.attr,
+	&armv7_event_attr_05_l1d_tlb_refill.attr.attr,
+	&armv7_event_attr_06_ld_retired.attr.attr,
+	&armv7_event_attr_07_st_retired.attr.attr,
+	&armv7_event_attr_09_exc_taken.attr.attr,
+	&armv7_event_attr_0a_exc_return.attr.attr,
+	&armv7_event_attr_0b_cid_write_retired.attr.attr,
+	&armv7_event_attr_0c_pc_write_retired.attr.attr,
+	&armv7_event_attr_0d_br_immed_retired.attr.attr,
+	&armv7_event_attr_0f_unaligned_ldst_retired.attr.attr,
+	&armv7_event_attr_10_br_mis_pred.attr.attr,
+	&armv7_event_attr_11_cpu_cycles.attr.attr,
+	&armv7_event_attr_12_br_pred.attr.attr,
+	&armv7_event_attr_40_java_bc_exec.attr.attr,
+	&armv7_event_attr_41_java_swbc_exec.attr.attr,
+	&armv7_event_attr_42_jazelle_branch_executed.attr.attr,
+	&armv7_event_attr_50_coherent_miss.attr.attr,
+	&armv7_event_attr_51_coherent_hit.attr.attr,
+	&armv7_event_attr_60_stall_inst.attr.attr,
+	&armv7_event_attr_61_stall_data.attr.attr,
+	&armv7_event_attr_62_stall_tlb.attr.attr,
+	&armv7_event_attr_63_strex_pass.attr.attr,
+	&armv7_event_attr_64_strex_failed.attr.attr,
+	&armv7_event_attr_65_data_evict.attr.attr,
+	&armv7_event_attr_66_issue_no_dispatch.attr.attr,
+	&armv7_event_attr_67_issue_empty.attr.attr,
+	&armv7_event_attr_68_inst_exec.attr.attr,
+	&armv7_event_attr_69_cache_linefill.attr.attr,
+	&armv7_event_attr_6a_prefetch_linefill.attr.attr,
+	&armv7_event_attr_6b_prefetch_hit.attr.attr,
+	&armv7_event_attr_6e_predictable_ret.attr.attr,
+	&armv7_event_attr_70_inst_main_exec.attr.attr,
+	&armv7_event_attr_71_inst_second_exec.attr.attr,
+	&armv7_event_attr_72_inst_load_store.attr.attr,
+	&armv7_event_attr_73_inst_fp.attr.attr,
+	&armv7_event_attr_74_inst_neon.attr.attr,
+	&armv7_event_attr_80_stall_pld.attr.attr,
+	&armv7_event_attr_81_stall_write.attr.attr,
+	&armv7_event_attr_82_stall_inst_tlb.attr.attr,
+	&armv7_event_attr_83_stall_data_tlb.attr.attr,
+	&armv7_event_attr_84_stall_inst_mtlb.attr.attr,
+	&armv7_event_attr_85_stall_data_mtlb.attr.attr,
+	&armv7_event_attr_86_stall_dmb.attr.attr,
+	&armv7_event_attr_8a_clock_int.attr.attr,
+	&armv7_event_attr_8b_clock_data.attr.attr,
+	&armv7_event_attr_8c_clock_neon.attr.attr,
+	&armv7_event_attr_8d_tlb_inst.attr.attr,
+	&armv7_event_attr_8e_tlb_data.attr.attr,
+	&armv7_event_attr_90_inst_isb.attr.attr,
+	&armv7_event_attr_91_inst_dsb.attr.attr,
+	&armv7_event_attr_92_inst_dmb.attr.attr,
+	&armv7_event_attr_93_ext_irq.attr.attr,
+	NULL
+};
+
+static struct attribute_group armv7_a9_events_attr_group = {
+	.name = "events",
+	.attrs = armv7_a9_event_attrs,
+};
+
+static const struct attribute_group *armv7_a9_attr_groups[] = {
+	&armv7_a9_events_attr_group,
+	NULL
+};
+
+static struct attribute *armv7_a5_event_attrs[] = {
+	&armv7_event_attr_00_sw_incr.attr.attr,
+	&armv7_event_attr_01_l1i_cache_refill.attr.attr,
+	&armv7_event_attr_02_l1i_tlb_refill.attr.attr,
+	&armv7_event_attr_03_l1d_cache_refill.attr.attr,
+	&armv7_event_attr_04_l1d_cache.attr.attr,
+	&armv7_event_attr_05_l1d_tlb_refill.attr.attr,
+	&armv7_event_attr_06_ld_retired.attr.attr,
+	&armv7_event_attr_07_st_retired.attr.attr,
+	&armv7_event_attr_08_inst_retired.attr.attr,
+	&armv7_event_attr_09_exc_taken.attr.attr,
+	&armv7_event_attr_0a_exc_return.attr.attr,
+	&armv7_event_attr_0b_cid_write_retired.attr.attr,
+	&armv7_event_attr_0c_pc_write_retired.attr.attr,
+	&armv7_event_attr_0d_br_immed_retired.attr.attr,
+	&armv7_event_attr_0e_br_return_retired.attr.attr,
+	&armv7_event_attr_0f_unaligned_ldst_retired.attr.attr,
+	&armv7_event_attr_10_br_mis_pred.attr.attr,
+	&armv7_event_attr_11_cpu_cycles.attr.attr,
+	&armv7_event_attr_12_br_pred.attr.attr,
+	&armv7_event_attr_13_mem_access.attr.attr,
+	&armv7_event_attr_14_l1i_cache.attr.attr,
+	&armv7_event_attr_15_l1d_cache_wb.attr.attr,
+	&armv7_event_attr_86_exc_irq.attr.attr,
+	&armv7_event_attr_87_exc_fiq.attr.attr,
+	&armv7_event_attr_c0_ext_mem_req.attr.attr,
+	&armv7_event_attr_c1_ext_mem_req_nc.attr.attr,
+	&armv7_event_attr_c2_prefetch_linefill.attr.attr,
+	&armv7_event_attr_c3_prefetch_linefill_drop.attr.attr,
+	&armv7_event_attr_c4_read_alloc_enter.attr.attr,
+	&armv7_event_attr_c5_read_alloc.attr.attr,
+	&armv7_event_attr_c7_etm_out0.attr.attr,
+	&armv7_event_attr_c8_etm_out1.attr.attr,
+	&armv7_event_attr_c9_stall_sb_full.attr.attr,
+	NULL
+};
+
+static struct attribute_group armv7_a5_events_attr_group = {
+	.name = "events",
+	.attrs = armv7_a5_event_attrs,
+};
+
+static const struct attribute_group *armv7_a5_attr_groups[] = {
+	&armv7_a5_events_attr_group,
+	NULL
+};
+
+static struct attribute *armv7_a15_event_attrs[] = {
+	&armv7_event_attr_00_sw_incr.attr.attr,
+	&armv7_event_attr_01_l1i_cache_refill.attr.attr,
+	&armv7_event_attr_02_l1i_tlb_refill.attr.attr,
+	&armv7_event_attr_03_l1d_cache_refill.attr.attr,
+	&armv7_event_attr_04_l1d_cache.attr.attr,
+	&armv7_event_attr_05_l1d_tlb_refill.attr.attr,
+	&armv7_event_attr_08_inst_retired.attr.attr,
+	&armv7_event_attr_09_exc_taken.attr.attr,
+	&armv7_event_attr_0a_exc_return.attr.attr,
+	&armv7_event_attr_0b_cid_write_retired.attr.attr,
+	&armv7_event_attr_10_br_mis_pred.attr.attr,
+	&armv7_event_attr_11_cpu_cycles.attr.attr,
+	&armv7_event_attr_12_br_pred.attr.attr,
+	&armv7_event_attr_13_mem_access.attr.attr,
+	&armv7_event_attr_14_l1i_cache.attr.attr,
+	&armv7_event_attr_15_l1d_cache_wb.attr.attr,
+	&armv7_event_attr_16_l2d_cache.attr.attr,
+	&armv7_event_attr_17_l2d_cache_refill.attr.attr,
+	&armv7_event_attr_18_l2d_cache_wb.attr.attr,
+	&armv7_event_attr_19_bus_access.attr.attr,
+	&armv7_event_attr_1a_memory_error.attr.attr,
+	&armv7_event_attr_1b_inst_spec.attr.attr,
+	&armv7_event_attr_1c_ttbr_write_retired.attr.attr,
+	&armv7_event_attr_1d_bus_cycles.attr.attr,
+	&armv7_event_attr_40_l1d_cache_ld.attr.attr,
+	&armv7_event_attr_41_l1d_cache_st.attr.attr,
+	&armv7_event_attr_42_l1d_cache_refill_ld.attr.attr,
+	&armv7_event_attr_43_l1d_cache_refill_st.attr.attr,
+	&armv7_event_attr_46_l1d_cache_wb_victim.attr.attr,
+	&armv7_event_attr_47_l1d_cache_wb_clean.attr.attr,
+	&armv7_event_attr_48_l1d_cache_inval.attr.attr,
+	&armv7_event_attr_4c_l1d_tlb_refill_ld.attr.attr,
+	&armv7_event_attr_4d_l1d_tlb_refill_st.attr.attr,
+	&armv7_event_attr_50_l2d_cache_ld.attr.attr,
+	&armv7_event_attr_51_l2d_cache_st.attr.attr,
+	&armv7_event_attr_52_l2d_cache_refill_ld.attr.attr,
+	&armv7_event_attr_53_l2d_cache_refill_st.attr.attr,
+	&armv7_event_attr_56_l2d_cache_wb_victim.attr.attr,
+	&armv7_event_attr_57_l2d_cache_wb_clean.attr.attr,
+	&armv7_event_attr_58_l2d_cache_inval.attr.attr,
+	&armv7_event_attr_60_bus_access_ld.attr.attr,
+	&armv7_event_attr_61_bus_access_st.attr.attr,
+	&armv7_event_attr_62_bus_access_shared.attr.attr,
+	&armv7_event_attr_63_bus_access_not_shared.attr.attr,
+	&armv7_event_attr_64_bus_access_normal.attr.attr,
+	&armv7_event_attr_65_bus_access_periph.attr.attr,
+	&armv7_event_attr_66_mem_access_ld.attr.attr,
+	&armv7_event_attr_67_mem_access_st.attr.attr,
+	&armv7_event_attr_68_unaligned_ld_spec.attr.attr,
+	&armv7_event_attr_69_unaligned_st_spec.attr.attr,
+	&armv7_event_attr_6a_unaligned_ldst_spec.attr.attr,
+	&armv7_event_attr_6c_ldrex_spec.attr.attr,
+	&armv7_event_attr_6d_strex_pass_spec.attr.attr,
+	&armv7_event_attr_6e_strex_fail_spec.attr.attr,
+	&armv7_event_attr_70_ld_spec.attr.attr,
+	&armv7_event_attr_71_st_spec.attr.attr,
+	&armv7_event_attr_72_ldst_spec.attr.attr,
+	&armv7_event_attr_73_dp_spec.attr.attr,
+	&armv7_event_attr_74_ase_spec.attr.attr,
+	&armv7_event_attr_75_vfp_spec.attr.attr,
+	&armv7_event_attr_76_pc_write_spec.attr.attr,
+	&armv7_event_attr_78_br_immed_spec.attr.attr,
+	&armv7_event_attr_79_br_return_spec.attr.attr,
+	&armv7_event_attr_7a_br_indirect_spec.attr.attr,
+	&armv7_event_attr_7c_isb_spec.attr.attr,
+	&armv7_event_attr_7d_dsb_spec.attr.attr,
+	&armv7_event_attr_7e_dmb_spec.attr.attr,
+	NULL
+};
+
+static struct attribute_group armv7_a15_events_attr_group = {
+	.name = "events",
+	.attrs = armv7_a15_event_attrs,
+};
+
+static const struct attribute_group *armv7_a15_attr_groups[] = {
+	&armv7_a15_events_attr_group,
+	NULL
+};
+
+static struct attribute *armv7_a7_event_attrs[] = {
+	&armv7_event_attr_00_sw_incr.attr.attr,
+	&armv7_event_attr_01_l1i_cache_refill.attr.attr,
+	&armv7_event_attr_02_l1i_tlb_refill.attr.attr,
+	&armv7_event_attr_03_l1d_cache_refill.attr.attr,
+	&armv7_event_attr_04_l1d_cache.attr.attr,
+	&armv7_event_attr_05_l1d_tlb_refill.attr.attr,
+	&armv7_event_attr_06_ld_retired.attr.attr,
+	&armv7_event_attr_07_st_retired.attr.attr,
+	&armv7_event_attr_08_inst_retired.attr.attr,
+	&armv7_event_attr_09_exc_taken.attr.attr,
+	&armv7_event_attr_0a_exc_return.attr.attr,
+	&armv7_event_attr_0b_cid_write_retired.attr.attr,
+	&armv7_event_attr_0c_pc_write_retired.attr.attr,
+	&armv7_event_attr_0d_br_immed_retired.attr.attr,
+	&armv7_event_attr_0e_br_return_retired.attr.attr,
+	&armv7_event_attr_0f_unaligned_ldst_retired.attr.attr,
+	&armv7_event_attr_10_br_mis_pred.attr.attr,
+	&armv7_event_attr_11_cpu_cycles.attr.attr,
+	&armv7_event_attr_12_br_pred.attr.attr,
+	&armv7_event_attr_13_mem_access.attr.attr,
+	&armv7_event_attr_14_l1i_cache.attr.attr,
+	&armv7_event_attr_15_l1d_cache_wb.attr.attr,
+	&armv7_event_attr_16_l2d_cache.attr.attr,
+	&armv7_event_attr_17_l2d_cache_refill.attr.attr,
+	&armv7_event_attr_18_l2d_cache_wb.attr.attr,
+	&armv7_event_attr_19_bus_access.attr.attr,
+	&armv7_event_attr_1d_bus_cycles.attr.attr,
+	&armv7_event_attr_60_bus_access_ld.attr.attr,
+	&armv7_event_attr_61_bus_access_st.attr.attr,
+	&armv7_event_attr_86_exc_irq.attr.attr,
+	&armv7_event_attr_87_exc_fiq.attr.attr,
+	&armv7_event_attr_c0_ext_mem_req.attr.attr,
+	&armv7_event_attr_c1_ext_mem_req_nc.attr.attr,
+	&armv7_event_attr_c2_prefetch_linefill.attr.attr,
+	&armv7_event_attr_c3_prefetch_linefill_drop.attr.attr,
+	&armv7_event_attr_c4_read_alloc_enter.attr.attr,
+	&armv7_event_attr_c5_read_alloc.attr.attr,
+	&armv7_event_attr_c7_etm_out0.attr.attr,
+	&armv7_event_attr_c8_etm_out1.attr.attr,
+	&armv7_event_attr_c9_stall_sb_full.attr.attr,
+	&armv7_event_attr_ca_local_cluster_snoop.attr.attr,
+	NULL
+};
+
+static struct attribute_group armv7_a7_events_attr_group = {
+	.name = "events",
+	.attrs = armv7_a7_event_attrs,
+};
+
+static const struct attribute_group *armv7_a7_attr_groups[] = {
+	&armv7_a7_events_attr_group,
+	NULL
+};
+
+static struct attribute *armv7_a17_event_attrs[] = {
+	&armv7_event_attr_01_l1i_cache_refill.attr.attr,
+	&armv7_event_attr_02_l1i_tlb_refill.attr.attr,
+	&armv7_event_attr_03_l1d_cache_refill.attr.attr,
+	&armv7_event_attr_04_l1d_cache.attr.attr,
+	&armv7_event_attr_05_l1d_tlb_refill.attr.attr,
+	&armv7_event_attr_08_inst_retired.attr.attr,
+	&armv7_event_attr_09_exc_taken.attr.attr,
+	&armv7_event_attr_0a_exc_return.attr.attr,
+	&armv7_event_attr_0b_cid_write_retired.attr.attr,
+	&armv7_event_attr_10_br_mis_pred.attr.attr,
+	&armv7_event_attr_11_cpu_cycles.attr.attr,
+	&armv7_event_attr_12_br_pred.attr.attr,
+	&armv7_event_attr_13_mem_access.attr.attr,
+	&armv7_event_attr_14_l1i_cache.attr.attr,
+	&armv7_event_attr_15_l1d_cache_wb.attr.attr,
+	&armv7_event_attr_16_l2d_cache.attr.attr,
+	&armv7_event_attr_17_l2d_cache_refill.attr.attr,
+	&armv7_event_attr_18_l2d_cache_wb.attr.attr,
+	&armv7_event_attr_19_bus_access.attr.attr,
+	&armv7_event_attr_1b_inst_spec.attr.attr,
+	&armv7_event_attr_1c_ttbr_write_retired.attr.attr,
+	&armv7_event_attr_1d_bus_cycles.attr.attr,
+	&armv7_event_attr_40_l1d_cache_ld.attr.attr,
+	&armv7_event_attr_41_l1d_cache_st.attr.attr,
+	&armv7_event_attr_50_l2d_cache_ld.attr.attr,
+	&armv7_event_attr_51_l2d_cache_st.attr.attr,
+	&armv7_event_attr_56_l2d_cache_wb_victim.attr.attr,
+	&armv7_event_attr_57_l2d_cache_wb_clean.attr.attr,
+	&armv7_event_attr_58_l2d_cache_inval.attr.attr,
+	&armv7_event_attr_62_bus_access_shared.attr.attr,
+	&armv7_event_attr_63_bus_access_not_shared.attr.attr,
+	&armv7_event_attr_64_bus_access_normal.attr.attr,
+	&armv7_event_attr_65_bus_access_periph.attr.attr,
+	&armv7_event_attr_66_mem_access_ld.attr.attr,
+	&armv7_event_attr_67_mem_access_st.attr.attr,
+	&armv7_event_attr_68_unaligned_ld_spec.attr.attr,
+	&armv7_event_attr_69_unaligned_st_spec.attr.attr,
+	&armv7_event_attr_6a_unaligned_ldst_spec.attr.attr,
+	&armv7_event_attr_6c_ldrex_spec.attr.attr,
+	&armv7_event_attr_6e_strex_fail_spec.attr.attr,
+	&armv7_event_attr_6f_strex_spec.attr.attr,
+	&armv7_event_attr_70_ld_spec.attr.attr,
+	&armv7_event_attr_71_st_spec.attr.attr,
+	&armv7_event_attr_72_ldst_spec.attr.attr,
+	&armv7_event_attr_73_dp_spec.attr.attr,
+	&armv7_event_attr_74_ase_spec.attr.attr,
+	&armv7_event_attr_75_vfp_spec.attr.attr,
+	&armv7_event_attr_76_pc_write_spec.attr.attr,
+	&armv7_event_attr_78_br_immed_spec.attr.attr,
+	&armv7_event_attr_79_br_return_spec.attr.attr,
+	&armv7_event_attr_7a_br_indirect_spec.attr.attr,
+	&armv7_event_attr_7c_isb_spec.attr.attr,
+	&armv7_event_attr_7d_dsb_spec.attr.attr,
+	&armv7_event_attr_7e_dmb_spec.attr.attr,
+	&armv7_event_attr_81_exc_undef.attr.attr,
+	&armv7_event_attr_8a_exc_hvc.attr.attr,
+	&armv7_event_attr_c0_stall_inst_linefill.attr.attr,
+	&armv7_event_attr_c1_stall_inst_tlb.attr.attr,
+	&armv7_event_attr_c2_cache_tag.attr.attr,
+	&armv7_event_attr_c3_cache_data.attr.attr,
+	&armv7_event_attr_c4_cache_btac.attr.attr,
+	&armv7_event_attr_ca_local_cluster_snoop.attr.attr,
+	&armv7_event_attr_d3_busy_lsu.attr.attr,
+	&armv7_event_attr_d8_busy_lsi.attr.attr,
+	&armv7_event_attr_d9_busy_dpi.attr.attr,
+	&armv7_event_attr_da_busy_dei.attr.attr,
+	&armv7_event_attr_db_neon_cond_fail.attr.attr,
+	&armv7_event_attr_dc_trap_hv.attr.attr,
+	&armv7_event_attr_de_ptm_extout0.attr.attr,
+	&armv7_event_attr_df_ptm_extout1.attr.attr,
+	&armv7_event_attr_e0_mmu_walk.attr.attr,
+	&armv7_event_attr_e1_mmu_s1_walk.attr.attr,
+	&armv7_event_attr_e2_mmu_s2_walk.attr.attr,
+	&armv7_event_attr_e3_mmu_lsu_walk.attr.attr,
+	&armv7_event_attr_e4_mmu_inst_walk.attr.attr,
+	&armv7_event_attr_e5_mmu_pre_walk.attr.attr,
+	&armv7_event_attr_e6_mmu_cp15_walk.attr.attr,
+	&armv7_event_attr_e7_tlb_pld_refill.attr.attr,
+	&armv7_event_attr_e8_tlb_cp15_refill.attr.attr,
+	&armv7_event_attr_e9_tlb_flush.attr.attr,
+	&armv7_event_attr_ea_tlb_access.attr.attr,
+	&armv7_event_attr_eb_tlb_miss.attr.attr,
+	NULL
+};
+
+static struct attribute_group armv7_a17_events_attr_group = {
+	.name = "events",
+	.attrs = armv7_a17_event_attrs,
+};
+
+static const struct attribute_group *armv7_a17_attr_groups[] = {
+	&armv7_a17_events_attr_group,
+	NULL
+};
+
 /*
  * Perf Events' indices
  */
@@ -1085,6 +1695,7 @@ static int armv7_a8_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a8";
 	cpu_pmu->map_event	= armv7_a8_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_a8_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1093,6 +1704,7 @@ static int armv7_a9_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a9";
 	cpu_pmu->map_event	= armv7_a9_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_a9_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1101,6 +1713,7 @@ static int armv7_a5_pmu_init(struct arm_pmu *cpu_pmu)
 	armv7pmu_init(cpu_pmu);
 	cpu_pmu->name		= "armv7_cortex_a5";
 	cpu_pmu->map_event	= armv7_a5_map_event;
+	cpu_pmu->pmu.attr_groups = armv7_a5_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1110,6 +1723,7 @@ static int armv7_a15_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a15";
 	cpu_pmu->map_event	= armv7_a15_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_a15_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1119,6 +1733,7 @@ static int armv7_a7_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a7";
 	cpu_pmu->map_event	= armv7_a7_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_a7_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1128,6 +1743,7 @@ static int armv7_a12_pmu_init(struct arm_pmu *cpu_pmu)
 	cpu_pmu->name		= "armv7_cortex_a12";
 	cpu_pmu->map_event	= armv7_a12_map_event;
 	cpu_pmu->set_event_filter = armv7pmu_set_event_filter;
+	cpu_pmu->pmu.attr_groups = armv7_a17_attr_groups;
 	return armv7_probe_num_events(cpu_pmu);
 }
 
@@ -1135,6 +1751,7 @@ static int armv7_a17_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int ret = armv7_a12_pmu_init(cpu_pmu);
 	cpu_pmu->name = "armv7_cortex_a17";
+	cpu_pmu->pmu.attr_groups = armv7_a17_attr_groups;
 	return ret;
 }
 
-- 
2.1.4
