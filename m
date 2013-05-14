From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:37 +0100
Subject: [PATCH v4 09/32] arm64: KVM: system register handling
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide 64bit system register handling, modeled after the cp15
handling for ARM.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_coproc.h |  51 +++
 arch/arm64/include/uapi/asm/kvm.h   |  29 ++
 arch/arm64/kvm/sys_regs.c           | 883 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/sys_regs.h           | 138 ++++++
 include/uapi/linux/kvm.h            |   1 +
 5 files changed, 1102 insertions(+)
 create mode 100644 arch/arm64/include/asm/kvm_coproc.h
 create mode 100644 arch/arm64/kvm/sys_regs.c
 create mode 100644 arch/arm64/kvm/sys_regs.h

diff --git a/arch/arm64/include/asm/kvm_coproc.h b/arch/arm64/include/asm/kvm_coproc.h
new file mode 100644
index 0000000..9b4477a
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_coproc.h
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Derived from arch/arm/include/asm/kvm_coproc.h
+ * Copyright (C) 2012 Rusty Russell IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ARM64_KVM_COPROC_H__
+#define __ARM64_KVM_COPROC_H__
+
+#include <linux/kvm_host.h>
+
+void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
+
+struct kvm_sys_reg_table {
+	const struct sys_reg_desc *table;
+	size_t num;
+};
+
+struct kvm_sys_reg_target_table {
+	struct kvm_sys_reg_table table64;
+};
+
+void kvm_register_target_sys_reg_table(unsigned int target,
+				       struct kvm_sys_reg_target_table *table);
+
+int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run);
+
+#define kvm_coproc_table_init kvm_sys_reg_table_init
+void kvm_sys_reg_table_init(void);
+
+struct kvm_one_reg;
+int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
+int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
+int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
+unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
+
+#endif /* __ARM64_KVM_COPROC_H__ */
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 4e64570..ebac919 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -92,6 +92,35 @@ struct kvm_sync_regs {
 struct kvm_arch_memory_slot {
 };
 
+/* If you need to interpret the index values, here is the key: */
+#define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
+#define KVM_REG_ARM_COPROC_SHIFT	16
+
+/* Normal registers are mapped as coprocessor 16. */
+#define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / sizeof(__u32))
+
+/* Some registers need more space to represent values. */
+#define KVM_REG_ARM_DEMUX		(0x0011 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_DEMUX_ID_MASK	0x000000000000FF00
+#define KVM_REG_ARM_DEMUX_ID_SHIFT	8
+#define KVM_REG_ARM_DEMUX_ID_CCSIDR	(0x00 << KVM_REG_ARM_DEMUX_ID_SHIFT)
+#define KVM_REG_ARM_DEMUX_VAL_MASK	0x00000000000000FF
+#define KVM_REG_ARM_DEMUX_VAL_SHIFT	0
+
+/* AArch64 system registers */
+#define KVM_REG_ARM64_SYSREG		(0x0013 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM64_SYSREG_OP0_MASK	0x000000000000c000
+#define KVM_REG_ARM64_SYSREG_OP0_SHIFT	14
+#define KVM_REG_ARM64_SYSREG_OP1_MASK	0x0000000000003800
+#define KVM_REG_ARM64_SYSREG_OP1_SHIFT	11
+#define KVM_REG_ARM64_SYSREG_CRN_MASK	0x0000000000000780
+#define KVM_REG_ARM64_SYSREG_CRN_SHIFT	7
+#define KVM_REG_ARM64_SYSREG_CRM_MASK	0x0000000000000078
+#define KVM_REG_ARM64_SYSREG_CRM_SHIFT	3
+#define KVM_REG_ARM64_SYSREG_OP2_MASK	0x0000000000000007
+#define KVM_REG_ARM64_SYSREG_OP2_SHIFT	0
+
 /* KVM_IRQ_LINE irq field index values */
 #define KVM_ARM_IRQ_TYPE_SHIFT		24
 #define KVM_ARM_IRQ_TYPE_MASK		0xff
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
new file mode 100644
index 0000000..52fff0a
--- /dev/null
+++ b/arch/arm64/kvm/sys_regs.c
@@ -0,0 +1,883 @@
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Derived from arch/arm/kvm/coproc.c:
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Authors: Rusty Russell <rusty@rustcorp.com.au>
+ *          Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/mm.h>
+#include <linux/kvm_host.h>
+#include <linux/uaccess.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_coproc.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <trace/events/kvm.h>
+
+#include "sys_regs.h"
+
+/*
+ * All of this file is extremly similar to the ARM coproc.c, but the
+ * types are different. My gut feeling is that it should be pretty
+ * easy to merge, but that would be an ABI breakage -- again. VFP
+ * would also need to be abstracted.
+ */
+
+/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
+static u32 cache_levels;
+
+/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
+#define CSSELR_MAX 12
+
+/* Which cache CCSIDR represents depends on CSSELR value. */
+static u32 get_ccsidr(u32 csselr)
+{
+	u32 ccsidr;
+
+	/* Make sure noone else changes CSSELR during this! */
+	local_irq_disable();
+	/* Put value into CSSELR */
+	asm volatile("msr csselr_el1, %x0" : : "r" (csselr));
+	isb();
+	/* Read result out of CCSIDR */
+	asm volatile("mrs %0, ccsidr_el1" : "=r" (ccsidr));
+	local_irq_enable();
+
+	return ccsidr;
+}
+
+static void do_dc_cisw(u32 val)
+{
+	asm volatile("dc cisw, %x0" : : "r" (val));
+	dsb();
+}
+
+static void do_dc_csw(u32 val)
+{
+	asm volatile("dc csw, %x0" : : "r" (val));
+	dsb();
+}
+
+/* See note at ARM ARM B1.14.4 */
+static bool access_dcsw(struct kvm_vcpu *vcpu,
+			const struct sys_reg_params *p,
+			const struct sys_reg_desc *r)
+{
+	unsigned long val;
+	int cpu;
+
+	if (!p->is_write)
+		return read_from_write_only(vcpu, p);
+
+	cpu = get_cpu();
+
+	cpumask_setall(&vcpu->arch.require_dcache_flush);
+	cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);
+
+	/* If we were already preempted, take the long way around */
+	if (cpu != vcpu->arch.last_pcpu) {
+		flush_cache_all();
+		goto done;
+	}
+
+	val = *vcpu_reg(vcpu, p->Rt);
+
+	switch (p->CRm) {
+	case 6:			/* Upgrade DCISW to DCCISW, as per HCR.SWIO */
+	case 14:		/* DCCISW */
+		do_dc_cisw(val);
+		break;
+
+	case 10:		/* DCCSW */
+		do_dc_csw(val);
+		break;
+	}
+
+done:
+	put_cpu();
+
+	return true;
+}
+
+/*
+ * We could trap ID_DFR0 and tell the guest we don't support performance
+ * monitoring.  Unfortunately the patch to make the kernel check ID_DFR0 was
+ * NAKed, so it will read the PMCR anyway.
+ *
+ * Therefore we tell the guest we have 0 counters.  Unfortunately, we
+ * must always support PMCCNTR (the cycle counter): we just RAZ/WI for
+ * all PM registers, which doesn't crash the guest kernel at least.
+ */
+static bool pm_fake(struct kvm_vcpu *vcpu,
+		    const struct sys_reg_params *p,
+		    const struct sys_reg_desc *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+	else
+		return read_zero(vcpu, p);
+}
+
+static void reset_amair_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	u64 amair;
+
+	asm volatile("mrs %0, amair_el1\n" : "=r" (amair));
+	vcpu_sys_reg(vcpu, AMAIR_EL1) = amair;
+}
+
+static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	/*
+	 * Simply map the vcpu_id into the Aff0 field of the MPIDR.
+	 */
+	vcpu_sys_reg(vcpu, MPIDR_EL1) = (1UL << 31) | (vcpu->vcpu_id & 0xff);
+}
+
+/*
+ * Architected system registers.
+ * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
+ */
+static const struct sys_reg_desc sys_reg_descs[] = {
+	/* DC ISW */
+	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b0110), Op2(0b010),
+	  access_dcsw },
+	/* DC CSW */
+	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1010), Op2(0b010),
+	  access_dcsw },
+	/* DC CISW */
+	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1110), Op2(0b010),
+	  access_dcsw },
+
+	/* MPIDR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0000), Op2(0b101),
+	  NULL, reset_mpidr, MPIDR_EL1 },
+	/* SCTLR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b000),
+	  NULL, reset_val, SCTLR_EL1, 0x00C50078 },
+	/* CPACR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b010),
+	  NULL, reset_val, CPACR_EL1, 0 },
+	/* TTBR0_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b000),
+	  NULL, reset_unknown, TTBR0_EL1 },
+	/* TTBR1_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b001),
+	  NULL, reset_unknown, TTBR1_EL1 },
+	/* TCR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b010),
+	  NULL, reset_val, TCR_EL1, 0 },
+
+	/* AFSR0_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b000),
+	  NULL, reset_unknown, AFSR0_EL1 },
+	/* AFSR1_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b001),
+	  NULL, reset_unknown, AFSR1_EL1 },
+	/* ESR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0010), Op2(0b000),
+	  NULL, reset_unknown, ESR_EL1 },
+	/* FAR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b0110), CRm(0b0000), Op2(0b000),
+	  NULL, reset_unknown, FAR_EL1 },
+
+	/* PMINTENSET_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
+	  pm_fake },
+	/* PMINTENCLR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b010),
+	  pm_fake },
+
+	/* MAIR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
+	  NULL, reset_unknown, MAIR_EL1 },
+	/* AMAIR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0011), Op2(0b000),
+	  NULL, reset_amair_el1, AMAIR_EL1 },
+
+	/* VBAR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
+	  NULL, reset_val, VBAR_EL1, 0 },
+	/* CONTEXTIDR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
+	  NULL, reset_val, CONTEXTIDR_EL1, 0 },
+	/* TPIDR_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b100),
+	  NULL, reset_unknown, TPIDR_EL1 },
+
+	/* CNTKCTL_EL1 */
+	{ Op0(0b11), Op1(0b000), CRn(0b1110), CRm(0b0001), Op2(0b000),
+	  NULL, reset_val, CNTKCTL_EL1, 0},
+
+	/* CSSELR_EL1 */
+	{ Op0(0b11), Op1(0b010), CRn(0b0000), CRm(0b0000), Op2(0b000),
+	  NULL, reset_unknown, CSSELR_EL1 },
+
+	/* PMCR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b000),
+	  pm_fake },
+	/* PMCNTENSET_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b001),
+	  pm_fake },
+	/* PMCNTENCLR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b010),
+	  pm_fake },
+	/* PMOVSCLR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b011),
+	  pm_fake },
+	/* PMSWINC_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b100),
+	  pm_fake },
+	/* PMSELR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b101),
+	  pm_fake },
+	/* PMCEID0_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b110),
+	  pm_fake },
+	/* PMCEID1_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b111),
+	  pm_fake },
+	/* PMCCNTR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b000),
+	  pm_fake },
+	/* PMXEVTYPER_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b001),
+	  pm_fake },
+	/* PMXEVCNTR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b010),
+	  pm_fake },
+	/* PMUSERENR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b000),
+	  pm_fake },
+	/* PMOVSSET_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b011),
+	  pm_fake },
+
+	/* TPIDR_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b010),
+	  NULL, reset_unknown, TPIDR_EL0 },
+	/* TPIDRRO_EL0 */
+	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b011),
+	  NULL, reset_unknown, TPIDRRO_EL0 },
+};
+
+/* Target specific emulation tables */
+static struct kvm_sys_reg_target_table *target_tables[KVM_ARM_NUM_TARGETS];
+
+void kvm_register_target_sys_reg_table(unsigned int target,
+				       struct kvm_sys_reg_target_table *table)
+{
+	target_tables[target] = table;
+}
+
+/* Get specific register table for this target. */
+static const struct sys_reg_desc *get_target_table(unsigned target, size_t *num)
+{
+	struct kvm_sys_reg_target_table *table;
+
+	table = target_tables[target];
+	*num = table->table64.num;
+	return table->table64.table;
+}
+
+static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
+					 const struct sys_reg_desc table[],
+					 unsigned int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		const struct sys_reg_desc *r = &table[i];
+
+		if (params->Op0 != r->Op0)
+			continue;
+		if (params->Op1 != r->Op1)
+			continue;
+		if (params->CRn != r->CRn)
+			continue;
+		if (params->CRm != r->CRm)
+			continue;
+		if (params->Op2 != r->Op2)
+			continue;
+
+		return r;
+	}
+	return NULL;
+}
+
+static int emulate_sys_reg(struct kvm_vcpu *vcpu,
+			   const struct sys_reg_params *params)
+{
+	size_t num;
+	const struct sys_reg_desc *table, *r;
+
+	table = get_target_table(vcpu->arch.target, &num);
+
+	/* Search target-specific then generic table. */
+	r = find_reg(params, table, num);
+	if (!r)
+		r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+
+	if (likely(r)) {
+		/*
+		 * Not having an accessor means that we have
+		 * configured a trap that we don't know how to
+		 * handle. This certainly qualifies as a gross bug
+		 * that should be fixed right away.
+		 */
+		BUG_ON(!r->access);
+
+		if (likely(r->access(vcpu, params, r))) {
+			/* Skip instruction, since it was emulated */
+			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
+			return 1;
+		}
+		/* If access function fails, it should complain. */
+	} else {
+		kvm_err("Unsupported guest sys_reg access at: %lx\n",
+			*vcpu_pc(vcpu));
+		print_sys_reg_instr(params);
+	}
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+static void reset_sys_reg_descs(struct kvm_vcpu *vcpu,
+			      const struct sys_reg_desc *table, size_t num)
+{
+	unsigned long i;
+
+	for (i = 0; i < num; i++)
+		if (table[i].reset)
+			table[i].reset(vcpu, &table[i]);
+}
+
+/**
+ * kvm_handle_sys_reg -- handles a mrs/msr trap on a guest sys_reg access
+ * @vcpu: The VCPU pointer
+ * @run:  The kvm_run struct
+ */
+int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	struct sys_reg_params params;
+	unsigned long esr = kvm_vcpu_get_hsr(vcpu);
+
+	params.Op0 = (esr >> 20) & 3;
+	params.Op1 = (esr >> 14) & 0x7;
+	params.CRn = (esr >> 10) & 0xf;
+	params.CRm = (esr >> 1) & 0xf;
+	params.Op2 = (esr >> 17) & 0x7;
+	params.Rt = (esr >> 5) & 0x1f;
+	params.is_write = !(esr & 1);
+
+	return emulate_sys_reg(vcpu, &params);
+}
+
+/******************************************************************************
+ * Userspace API
+ *****************************************************************************/
+
+static bool index_to_params(u64 id, struct sys_reg_params *params)
+{
+	switch (id & KVM_REG_SIZE_MASK) {
+	case KVM_REG_SIZE_U64:
+		/* Any unused index bits means it's not valid. */
+		if (id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK
+			      | KVM_REG_ARM_COPROC_MASK
+			      | KVM_REG_ARM64_SYSREG_OP0_MASK
+			      | KVM_REG_ARM64_SYSREG_OP1_MASK
+			      | KVM_REG_ARM64_SYSREG_CRN_MASK
+			      | KVM_REG_ARM64_SYSREG_CRM_MASK
+			      | KVM_REG_ARM64_SYSREG_OP2_MASK))
+			return false;
+		params->Op0 = ((id & KVM_REG_ARM64_SYSREG_OP0_MASK)
+			       >> KVM_REG_ARM64_SYSREG_OP0_SHIFT);
+		params->Op1 = ((id & KVM_REG_ARM64_SYSREG_OP1_MASK)
+			       >> KVM_REG_ARM64_SYSREG_OP1_SHIFT);
+		params->CRn = ((id & KVM_REG_ARM64_SYSREG_CRN_MASK)
+			       >> KVM_REG_ARM64_SYSREG_CRN_SHIFT);
+		params->CRm = ((id & KVM_REG_ARM64_SYSREG_CRM_MASK)
+			       >> KVM_REG_ARM64_SYSREG_CRM_SHIFT);
+		params->Op2 = ((id & KVM_REG_ARM64_SYSREG_OP2_MASK)
+			       >> KVM_REG_ARM64_SYSREG_OP2_SHIFT);
+		return true;
+	default:
+		return false;
+	}
+}
+
+/* Decode an index value, and find the sys_reg_desc entry. */
+static const struct sys_reg_desc *index_to_sys_reg_desc(struct kvm_vcpu *vcpu,
+						    u64 id)
+{
+	size_t num;
+	const struct sys_reg_desc *table, *r;
+	struct sys_reg_params params;
+
+	/* We only do sys_reg for now. */
+	if ((id & KVM_REG_ARM_COPROC_MASK) != KVM_REG_ARM64_SYSREG)
+		return NULL;
+
+	if (!index_to_params(id, &params))
+		return NULL;
+
+	table = get_target_table(vcpu->arch.target, &num);
+	r = find_reg(&params, table, num);
+	if (!r)
+		r = find_reg(&params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+
+	/* Not saved in the sys_reg array? */
+	if (r && !r->reg)
+		r = NULL;
+
+	return r;
+}
+
+/*
+ * These are the invariant sys_reg registers: we let the guest see the
+ * host versions of these, so they're part of the guest state.
+ *
+ * A future CPU may provide a mechanism to present different values to
+ * the guest, or a future kvm may trap them.
+ */
+
+#define FUNCTION_INVARIANT(reg)						\
+	static void get_##reg(struct kvm_vcpu *v,			\
+			      const struct sys_reg_desc *r)		\
+	{								\
+		u64 val;						\
+									\
+		asm volatile("mrs %0, " __stringify(reg) "\n"		\
+			     : "=r" (val));				\
+		((struct sys_reg_desc *)r)->val = val;			\
+	}
+
+FUNCTION_INVARIANT(midr_el1)
+FUNCTION_INVARIANT(ctr_el0)
+FUNCTION_INVARIANT(revidr_el1)
+FUNCTION_INVARIANT(id_pfr0_el1)
+FUNCTION_INVARIANT(id_pfr1_el1)
+FUNCTION_INVARIANT(id_dfr0_el1)
+FUNCTION_INVARIANT(id_afr0_el1)
+FUNCTION_INVARIANT(id_mmfr0_el1)
+FUNCTION_INVARIANT(id_mmfr1_el1)
+FUNCTION_INVARIANT(id_mmfr2_el1)
+FUNCTION_INVARIANT(id_mmfr3_el1)
+FUNCTION_INVARIANT(id_isar0_el1)
+FUNCTION_INVARIANT(id_isar1_el1)
+FUNCTION_INVARIANT(id_isar2_el1)
+FUNCTION_INVARIANT(id_isar3_el1)
+FUNCTION_INVARIANT(id_isar4_el1)
+FUNCTION_INVARIANT(id_isar5_el1)
+FUNCTION_INVARIANT(clidr_el1)
+FUNCTION_INVARIANT(aidr_el1)
+
+/* ->val is filled in by kvm_sys_reg_table_init() */
+static struct sys_reg_desc invariant_sys_regs[] = {
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0000), Op2(0b000),
+	  NULL, get_midr_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0000), Op2(0b110),
+	  NULL, get_revidr_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b000),
+	  NULL, get_id_pfr0_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b001),
+	  NULL, get_id_pfr1_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b010),
+	  NULL, get_id_dfr0_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b011),
+	  NULL, get_id_afr0_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b100),
+	  NULL, get_id_mmfr0_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b101),
+	  NULL, get_id_mmfr1_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b110),
+	  NULL, get_id_mmfr2_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b111),
+	  NULL, get_id_mmfr3_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b000),
+	  NULL, get_id_isar0_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b001),
+	  NULL, get_id_isar1_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b010),
+	  NULL, get_id_isar2_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b011),
+	  NULL, get_id_isar3_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b100),
+	  NULL, get_id_isar4_el1 },
+	{ Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b101),
+	  NULL, get_id_isar5_el1 },
+	{ Op0(0b11), Op1(0b001), CRn(0b0000), CRm(0b0000), Op2(0b001),
+	  NULL, get_clidr_el1 },
+	{ Op0(0b11), Op1(0b001), CRn(0b0000), CRm(0b0000), Op2(0b111),
+	  NULL, get_aidr_el1 },
+	{ Op0(0b11), Op1(0b011), CRn(0b0000), CRm(0b0000), Op2(0b001),
+	  NULL, get_ctr_el0 },
+};
+
+static int reg_from_user(void *val, const void __user *uaddr, u64 id)
+{
+	/* This Just Works because we are little endian. */
+	if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
+		return -EFAULT;
+	return 0;
+}
+
+static int reg_to_user(void __user *uaddr, const void *val, u64 id)
+{
+	/* This Just Works because we are little endian. */
+	if (copy_to_user(uaddr, val, KVM_REG_SIZE(id)) != 0)
+		return -EFAULT;
+	return 0;
+}
+
+static int get_invariant_sys_reg(u64 id, void __user *uaddr)
+{
+	struct sys_reg_params params;
+	const struct sys_reg_desc *r;
+
+	if (!index_to_params(id, &params))
+		return -ENOENT;
+
+	r = find_reg(&params, invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs));
+	if (!r)
+		return -ENOENT;
+
+	return reg_to_user(uaddr, &r->val, id);
+}
+
+static int set_invariant_sys_reg(u64 id, void __user *uaddr)
+{
+	struct sys_reg_params params;
+	const struct sys_reg_desc *r;
+	int err;
+	u64 val = 0; /* Make sure high bits are 0 for 32-bit regs */
+
+	if (!index_to_params(id, &params))
+		return -ENOENT;
+	r = find_reg(&params, invariant_sys_regs, ARRAY_SIZE(invariant_sys_regs));
+	if (!r)
+		return -ENOENT;
+
+	err = reg_from_user(&val, uaddr, id);
+	if (err)
+		return err;
+
+	/* This is what we mean by invariant: you can't change it. */
+	if (r->val != val)
+		return -EINVAL;
+
+	return 0;
+}
+
+static bool is_valid_cache(u32 val)
+{
+	u32 level, ctype;
+
+	if (val >= CSSELR_MAX)
+		return -ENOENT;
+
+	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
+	level = (val >> 1);
+	ctype = (cache_levels >> (level * 3)) & 7;
+
+	switch (ctype) {
+	case 0: /* No cache */
+		return false;
+	case 1: /* Instruction cache only */
+		return (val & 1);
+	case 2: /* Data cache only */
+	case 4: /* Unified cache */
+		return !(val & 1);
+	case 3: /* Separate instruction and data caches */
+		return true;
+	default: /* Reserved: we can't know instruction or data. */
+		return false;
+	}
+}
+
+static int demux_c15_get(u64 id, void __user *uaddr)
+{
+	u32 val;
+	u32 __user *uval = uaddr;
+
+	/* Fail if we have unknown bits set. */
+	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
+		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
+		return -ENOENT;
+
+	switch (id & KVM_REG_ARM_DEMUX_ID_MASK) {
+	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
+		if (KVM_REG_SIZE(id) != 4)
+			return -ENOENT;
+		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
+			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
+		if (!is_valid_cache(val))
+			return -ENOENT;
+
+		return put_user(get_ccsidr(val), uval);
+	default:
+		return -ENOENT;
+	}
+}
+
+static int demux_c15_set(u64 id, void __user *uaddr)
+{
+	u32 val, newval;
+	u32 __user *uval = uaddr;
+
+	/* Fail if we have unknown bits set. */
+	if (id & ~(KVM_REG_ARCH_MASK|KVM_REG_SIZE_MASK|KVM_REG_ARM_COPROC_MASK
+		   | ((1 << KVM_REG_ARM_COPROC_SHIFT)-1)))
+		return -ENOENT;
+
+	switch (id & KVM_REG_ARM_DEMUX_ID_MASK) {
+	case KVM_REG_ARM_DEMUX_ID_CCSIDR:
+		if (KVM_REG_SIZE(id) != 4)
+			return -ENOENT;
+		val = (id & KVM_REG_ARM_DEMUX_VAL_MASK)
+			>> KVM_REG_ARM_DEMUX_VAL_SHIFT;
+		if (!is_valid_cache(val))
+			return -ENOENT;
+
+		if (get_user(newval, uval))
+			return -EFAULT;
+
+		/* This is also invariant: you can't change it. */
+		if (newval != get_ccsidr(val))
+			return -EINVAL;
+		return 0;
+	default:
+		return -ENOENT;
+	}
+}
+
+int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	const struct sys_reg_desc *r;
+	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
+
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return demux_c15_get(reg->id, uaddr);
+
+	if (KVM_REG_SIZE(reg->id) != sizeof(__u64))
+		return -ENOENT;
+
+	r = index_to_sys_reg_desc(vcpu, reg->id);
+	if (!r)
+		return get_invariant_sys_reg(reg->id, uaddr);
+
+	return reg_to_user(uaddr, &vcpu_sys_reg(vcpu, r->reg), reg->id);
+}
+
+int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	const struct sys_reg_desc *r;
+	void __user *uaddr = (void __user *)(unsigned long)reg->addr;
+
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
+		return demux_c15_set(reg->id, uaddr);
+
+	if (KVM_REG_SIZE(reg->id) != sizeof(__u64))
+		return -ENOENT;
+
+	r = index_to_sys_reg_desc(vcpu, reg->id);
+	if (!r)
+		return set_invariant_sys_reg(reg->id, uaddr);
+
+	return reg_from_user(&vcpu_sys_reg(vcpu, r->reg), uaddr, reg->id);
+}
+
+static unsigned int num_demux_regs(void)
+{
+	unsigned int i, count = 0;
+
+	for (i = 0; i < CSSELR_MAX; i++)
+		if (is_valid_cache(i))
+			count++;
+
+	return count;
+}
+
+static int write_demux_regids(u64 __user *uindices)
+{
+	u64 val = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX;
+	unsigned int i;
+
+	val |= KVM_REG_ARM_DEMUX_ID_CCSIDR;
+	for (i = 0; i < CSSELR_MAX; i++) {
+		if (!is_valid_cache(i))
+			continue;
+		if (put_user(val | i, uindices))
+			return -EFAULT;
+		uindices++;
+	}
+	return 0;
+}
+
+static u64 sys_reg_to_index(const struct sys_reg_desc *reg)
+{
+	return (KVM_REG_ARM64 | KVM_REG_SIZE_U64 |
+		KVM_REG_ARM64_SYSREG |
+		(reg->Op0 << KVM_REG_ARM64_SYSREG_OP0_SHIFT) |
+		(reg->Op1 << KVM_REG_ARM64_SYSREG_OP1_SHIFT) |
+		(reg->CRn << KVM_REG_ARM64_SYSREG_CRN_SHIFT) |
+		(reg->CRm << KVM_REG_ARM64_SYSREG_CRM_SHIFT) |
+		(reg->Op2 << KVM_REG_ARM64_SYSREG_OP2_SHIFT));
+}
+
+static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
+{
+	if (!*uind)
+		return true;
+
+	if (put_user(sys_reg_to_index(reg), *uind))
+		return false;
+
+	(*uind)++;
+	return true;
+}
+
+/* Assumed ordered tables, see kvm_sys_reg_table_init. */
+static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
+{
+	const struct sys_reg_desc *i1, *i2, *end1, *end2;
+	unsigned int total = 0;
+	size_t num;
+
+	/* We check for duplicates here, to allow arch-specific overrides. */
+	i1 = get_target_table(vcpu->arch.target, &num);
+	end1 = i1 + num;
+	i2 = sys_reg_descs;
+	end2 = sys_reg_descs + ARRAY_SIZE(sys_reg_descs);
+
+	BUG_ON(i1 == end1 || i2 == end2);
+
+	/* Walk carefully, as both tables may refer to the same register. */
+	while (i1 || i2) {
+		int cmp = cmp_sys_reg(i1, i2);
+		/* target-specific overrides generic entry. */
+		if (cmp <= 0) {
+			/* Ignore registers we trap but don't save. */
+			if (i1->reg) {
+				if (!copy_reg_to_user(i1, &uind))
+					return -EFAULT;
+				total++;
+			}
+		} else {
+			/* Ignore registers we trap but don't save. */
+			if (i2->reg) {
+				if (!copy_reg_to_user(i2, &uind))
+					return -EFAULT;
+				total++;
+			}
+		}
+
+		if (cmp <= 0 && ++i1 == end1)
+			i1 = NULL;
+		if (cmp >= 0 && ++i2 == end2)
+			i2 = NULL;
+	}
+	return total;
+}
+
+unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu)
+{
+	return ARRAY_SIZE(invariant_sys_regs)
+		+ num_demux_regs()
+		+ walk_sys_regs(vcpu, (u64 __user *)NULL);
+}
+
+int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	unsigned int i;
+	int err;
+
+	/* Then give them all the invariant registers' indices. */
+	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++) {
+		if (put_user(sys_reg_to_index(&invariant_sys_regs[i]), uindices))
+			return -EFAULT;
+		uindices++;
+	}
+
+	err = walk_sys_regs(vcpu, uindices);
+	if (err < 0)
+		return err;
+	uindices += err;
+
+	return write_demux_regids(uindices);
+}
+
+void kvm_sys_reg_table_init(void)
+{
+	unsigned int i;
+	struct sys_reg_desc clidr;
+
+	/* Make sure tables are unique and in order. */
+	for (i = 1; i < ARRAY_SIZE(sys_reg_descs); i++)
+		BUG_ON(cmp_sys_reg(&sys_reg_descs[i-1], &sys_reg_descs[i]) >= 0);
+
+	/* We abuse the reset function to overwrite the table itself. */
+	for (i = 0; i < ARRAY_SIZE(invariant_sys_regs); i++)
+		invariant_sys_regs[i].reset(NULL, &invariant_sys_regs[i]);
+
+	/*
+	 * CLIDR format is awkward, so clean it up.  See ARM B4.1.20:
+	 *
+	 *   If software reads the Cache Type fields from Ctype1
+	 *   upwards, once it has seen a value of 0b000, no caches
+	 *   exist@further-out levels of the hierarchy. So, for
+	 *   example, if Ctype3 is the first Cache Type field with a
+	 *   value of 0b000, the values of Ctype4 to Ctype7 must be
+	 *   ignored.
+	 */
+	get_clidr_el1(NULL, &clidr); /* Ugly... */
+	cache_levels = clidr.val;
+	for (i = 0; i < 7; i++)
+		if (((cache_levels >> (i*3)) & 7) == 0)
+			break;
+	/* Clear all higher bits. */
+	cache_levels &= (1 << (i*3))-1;
+}
+
+/**
+ * kvm_reset_sys_regs - sets system registers to reset value
+ * @vcpu: The VCPU pointer
+ *
+ * This function finds the right table above and sets the registers on the
+ * virtual CPU struct to their architecturally defined reset values.
+ */
+void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
+{
+	size_t num;
+	const struct sys_reg_desc *table;
+
+	/* Catch someone adding a register without putting in reset entry. */
+	memset(&vcpu->arch.ctxt.sys_regs, 0x42, sizeof(vcpu->arch.ctxt.sys_regs));
+
+	/* Generic chip reset first (so target could override). */
+	reset_sys_reg_descs(vcpu, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
+
+	table = get_target_table(vcpu->arch.target, &num);
+	reset_sys_reg_descs(vcpu, table, num);
+
+	for (num = 1; num < NR_SYS_REGS; num++)
+		if (vcpu_sys_reg(vcpu, num) == 0x4242424242424242)
+			panic("Didn't reset vcpu_sys_reg(%zi)", num);
+}
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
new file mode 100644
index 0000000..d50d372
--- /dev/null
+++ b/arch/arm64/kvm/sys_regs.h
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2012,2013 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ *
+ * Derived from arch/arm/kvm/coproc.h
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Authors: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __ARM64_KVM_SYS_REGS_LOCAL_H__
+#define __ARM64_KVM_SYS_REGS_LOCAL_H__
+
+struct sys_reg_params {
+	u8	Op0;
+	u8	Op1;
+	u8	CRn;
+	u8	CRm;
+	u8	Op2;
+	u8	Rt;
+	bool	is_write;
+};
+
+struct sys_reg_desc {
+	/* MRS/MSR instruction which accesses it. */
+	u8	Op0;
+	u8	Op1;
+	u8	CRn;
+	u8	CRm;
+	u8	Op2;
+
+	/* Trapped access from guest, if non-NULL. */
+	bool (*access)(struct kvm_vcpu *,
+		       const struct sys_reg_params *,
+		       const struct sys_reg_desc *);
+
+	/* Initialization for vcpu. */
+	void (*reset)(struct kvm_vcpu *, const struct sys_reg_desc *);
+
+	/* Index into sys_reg[], or 0 if we don't need to save it. */
+	int reg;
+
+	/* Value (usually reset value) */
+	u64 val;
+};
+
+static inline void print_sys_reg_instr(const struct sys_reg_params *p)
+{
+	/* Look, we even formatted it for you to paste into the table! */
+	kvm_pr_unimpl(" { Op0(%2u), Op1(%2u), CRn(%2u), CRm(%2u), Op2(%2u), func_%s },\n",
+		      p->Op0, p->Op1, p->CRn, p->CRm, p->Op2, p->is_write ? "write" : "read");
+}
+
+static inline bool ignore_write(struct kvm_vcpu *vcpu,
+				const struct sys_reg_params *p)
+{
+	return true;
+}
+
+static inline bool read_zero(struct kvm_vcpu *vcpu,
+			     const struct sys_reg_params *p)
+{
+	*vcpu_reg(vcpu, p->Rt) = 0;
+	return true;
+}
+
+static inline bool write_to_read_only(struct kvm_vcpu *vcpu,
+				      const struct sys_reg_params *params)
+{
+	kvm_debug("sys_reg write to read-only register at: %lx\n",
+		  *vcpu_pc(vcpu));
+	print_sys_reg_instr(params);
+	return false;
+}
+
+static inline bool read_from_write_only(struct kvm_vcpu *vcpu,
+					const struct sys_reg_params *params)
+{
+	kvm_debug("sys_reg read to write-only register at: %lx\n",
+		  *vcpu_pc(vcpu));
+	print_sys_reg_instr(params);
+	return false;
+}
+
+/* Reset functions */
+static inline void reset_unknown(struct kvm_vcpu *vcpu,
+				 const struct sys_reg_desc *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg >= NR_SYS_REGS);
+	vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL;
+}
+
+static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg >= NR_SYS_REGS);
+	vcpu_sys_reg(vcpu, r->reg) = r->val;
+}
+
+static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
+			      const struct sys_reg_desc *i2)
+{
+	BUG_ON(i1 == i2);
+	if (!i1)
+		return 1;
+	else if (!i2)
+		return -1;
+	if (i1->Op0 != i2->Op0)
+		return i1->Op0 - i2->Op0;
+	if (i1->Op1 != i2->Op1)
+		return i1->Op1 - i2->Op1;
+	if (i1->CRn != i2->CRn)
+		return i1->CRn - i2->CRn;
+	if (i1->CRm != i2->CRm)
+		return i1->CRm - i2->CRm;
+	return i1->Op2 - i2->Op2;
+}
+
+
+#define Op0(_x) 	.Op0 = _x
+#define Op1(_x) 	.Op1 = _x
+#define CRn(_x)		.CRn = _x
+#define CRm(_x) 	.CRm = _x
+#define Op2(_x) 	.Op2 = _x
+
+#endif /* __ARM64_KVM_SYS_REGS_LOCAL_H__ */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a5c86fc..2d1bcb8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -783,6 +783,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_IA64		0x3000000000000000ULL
 #define KVM_REG_ARM		0x4000000000000000ULL
 #define KVM_REG_S390		0x5000000000000000ULL
+#define KVM_REG_ARM64		0x6000000000000000ULL
 
 #define KVM_REG_SIZE_SHIFT	52
 #define KVM_REG_SIZE_MASK	0x00f0000000000000ULL
-- 
1.8.2.3
