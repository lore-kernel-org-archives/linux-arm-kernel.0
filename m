From: agraf@suse.de (Alexander Graf)
Date: Thu, 7 Mar 2013 11:30:20 +0100
Subject: [kvmarm] [PATCH 09/29] arm64: KVM: system register handling
In-Reply-To: <1362455265-24165-10-git-send-email-marc.zyngier@arm.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <2CF940F9-4643-4C32-8A71-23DAD18EE9FA@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05.03.2013, at 04:47, Marc Zyngier wrote:

> Provide 64bit system register handling, modeled after the cp15
> handling for ARM.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> arch/arm64/include/asm/kvm_coproc.h |  51 ++
> arch/arm64/include/uapi/asm/kvm.h   |  56 +++
> arch/arm64/kvm/sys_regs.c           | 962 ++++++++++++++++++++++++++++++++++++
> arch/arm64/kvm/sys_regs.h           | 141 ++++++
> include/uapi/linux/kvm.h            |   1 +
> 5 files changed, 1211 insertions(+)
> create mode 100644 arch/arm64/include/asm/kvm_coproc.h
> create mode 100644 arch/arm64/kvm/sys_regs.c
> create mode 100644 arch/arm64/kvm/sys_regs.h
> 
> diff --git a/arch/arm64/include/asm/kvm_coproc.h b/arch/arm64/include/asm/kvm_coproc.h
> new file mode 100644
> index 0000000..e791894
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_coproc.h
> @@ -0,0 +1,51 @@
> +/*
> + * Copyright (C) 2012 - ARM Ltd
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + * Derived from arch/arm/include/asm/kvm_coproc.h
> + * Copyright (C) 2012 Rusty Russell IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef __ARM64_KVM_COPROC_H__
> +#define __ARM64_KVM_COPROC_H__
> +
> +#include <linux/kvm_host.h>
> +
> +void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
> +
> +struct kvm_sys_reg_table {
> +	const struct sys_reg_desc *table;
> +	size_t num;
> +};
> +
> +struct kvm_sys_reg_target_table {
> +	unsigned target;
> +	struct kvm_sys_reg_table table64;
> +};
> +
> +void kvm_register_target_sys_reg_table(struct kvm_sys_reg_target_table *table);
> +
> +int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run);
> +
> +#define kvm_coproc_table_init kvm_sys_reg_table_init
> +void kvm_sys_reg_table_init(void);
> +
> +struct kvm_one_reg;
> +int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
> +int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
> +int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
> +unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
> +
> +#endif /* __ARM64_KVM_COPROC_H__ */
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index f5525f1..fffeb11 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -87,6 +87,62 @@ struct kvm_sync_regs {
> struct kvm_arch_memory_slot {
> };
> 
> +/* If you need to interpret the index values, here is the key: */
> +#define KVM_REG_ARM_COPROC_MASK		0x000000000FFF0000
> +#define KVM_REG_ARM_COPROC_SHIFT	16
> +#define KVM_REG_ARM_32_OPC2_MASK	0x0000000000000007
> +#define KVM_REG_ARM_32_OPC2_SHIFT	0
> +#define KVM_REG_ARM_OPC1_MASK		0x0000000000000078
> +#define KVM_REG_ARM_OPC1_SHIFT		3
> +#define KVM_REG_ARM_CRM_MASK		0x0000000000000780
> +#define KVM_REG_ARM_CRM_SHIFT		7
> +#define KVM_REG_ARM_32_CRN_MASK		0x0000000000007800
> +#define KVM_REG_ARM_32_CRN_SHIFT	11
> +
> +/* Normal registers are mapped as coprocessor 16. */
> +#define KVM_REG_ARM_CORE		(0x0010 << KVM_REG_ARM_COPROC_SHIFT)
> +#define KVM_REG_ARM_CORE_REG(name)	(offsetof(struct kvm_regs, name) / sizeof(unsigned long))
> +
> +/* Some registers need more space to represent values. */
> +#define KVM_REG_ARM_DEMUX		(0x0011 << KVM_REG_ARM_COPROC_SHIFT)
> +#define KVM_REG_ARM_DEMUX_ID_MASK	0x000000000000FF00
> +#define KVM_REG_ARM_DEMUX_ID_SHIFT	8
> +#define KVM_REG_ARM_DEMUX_ID_CCSIDR	(0x00 << KVM_REG_ARM_DEMUX_ID_SHIFT)
> +#define KVM_REG_ARM_DEMUX_VAL_MASK	0x00000000000000FF
> +#define KVM_REG_ARM_DEMUX_VAL_SHIFT	0
> +
> +/* VFP registers: we could overload CP10 like ARM does, but that's ugly. */
> +#define KVM_REG_ARM_VFP			(0x0012 << KVM_REG_ARM_COPROC_SHIFT)
> +#define KVM_REG_ARM_VFP_MASK		0x000000000000FFFF
> +#define KVM_REG_ARM_VFP_BASE_REG	0x0
> +#define KVM_REG_ARM_VFP_FPSID		0x1000
> +#define KVM_REG_ARM_VFP_FPSCR		0x1001
> +#define KVM_REG_ARM_VFP_MVFR1		0x1006
> +#define KVM_REG_ARM_VFP_MVFR0		0x1007
> +#define KVM_REG_ARM_VFP_FPEXC		0x1008
> +#define KVM_REG_ARM_VFP_FPINST		0x1009
> +#define KVM_REG_ARM_VFP_FPINST2		0x100A
> +
> +/* AArch64 system registers */
> +#define KVM_REG_ARM64_SYSREG		(0x0013 << KVM_REG_ARM_COPROC_SHIFT)
> +#define KVM_REG_ARM64_SYSREG_OP0_MASK	0x000000000000c000
> +#define KVM_REG_ARM64_SYSREG_OP0_SHIFT	14
> +#define KVM_REG_ARM64_SYSREG_OP1_MASK	0x0000000000003800
> +#define KVM_REG_ARM64_SYSREG_OP1_SHIFT	11
> +#define KVM_REG_ARM64_SYSREG_CRN_MASK	0x0000000000000780
> +#define KVM_REG_ARM64_SYSREG_CRN_SHIFT	7
> +#define KVM_REG_ARM64_SYSREG_CRM_MASK	0x0000000000000078
> +#define KVM_REG_ARM64_SYSREG_CRM_SHIFT	3
> +#define KVM_REG_ARM64_SYSREG_OP2_MASK	0x0000000000000007
> +#define KVM_REG_ARM64_SYSREG_OP2_SHIFT	0
> +
> +/* FP-SIMD registers */
> +#define KVM_REG_ARM64_FP_SIMD		(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
> +#define KVM_REG_ARM64_FP_SIMD_MASK	0x000000000000FFFF
> +#define KVM_REG_ARM64_FP_SIMD_BASE_REG	0x0
> +#define KVM_REG_ARM64_FP_SIMD_FPSR	0x1000
> +#define KVM_REG_ARM64_FP_SIMD_FPCR	0x1001
> +
> /* KVM_IRQ_LINE irq field index values */
> #define KVM_ARM_IRQ_TYPE_SHIFT		24
> #define KVM_ARM_IRQ_TYPE_MASK		0xff
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> new file mode 100644
> index 0000000..9fc8c17
> --- /dev/null
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -0,0 +1,962 @@
> +/*
> + * Copyright (C) 2012 - ARM Ltd
> + * Author: Marc Zyngier <marc.zyngier@arm.com>
> + *
> + * Derived from arch/arm/kvm/coproc.c:
> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
> + * Authors: Rusty Russell <rusty@rustcorp.com.au>
> + *          Christoffer Dall <c.dall@virtualopensystems.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/kvm_host.h>
> +#include <linux/uaccess.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_host.h>
> +#include <asm/kvm_emulate.h>
> +#include <asm/kvm_coproc.h>
> +#include <asm/cacheflush.h>
> +#include <asm/cputype.h>
> +#include <trace/events/kvm.h>
> +
> +#include "sys_regs.h"
> +
> +/*
> + * All of this file is extremly similar to the ARM coproc.c, but the
> + * types are different. My gut feeling is that it should be pretty
> + * easy to merge, but that would be an ABI breakage -- again. VFP
> + * would also need to be abstracted.
> + */
> +
> +/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
> +static u32 cache_levels;
> +
> +/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
> +#define CSSELR_MAX 12
> +
> +/* Which cache CCSIDR represents depends on CSSELR value. */
> +static u32 get_ccsidr(u32 csselr)
> +{
> +	u32 ccsidr;
> +
> +	/* Make sure noone else changes CSSELR during this! */
> +	local_irq_disable();
> +	/* Put value into CSSELR */
> +	asm volatile("msr csselr_el1, %x0" : : "r" (csselr));
> +	/* Read result out of CCSIDR */
> +	asm volatile("mrs %0, ccsidr_el1" : "=r" (ccsidr));
> +	local_irq_enable();
> +
> +	return ccsidr;
> +}
> +
> +static void do_dc_cisw(u32 val)
> +{
> +	asm volatile("dc cisw, %x0" : : "r" (val));
> +}
> +
> +static void do_dc_csw(u32 val)
> +{
> +	asm volatile("dc csw, %x0" : : "r" (val));
> +}
> +
> +/* See note at ARM ARM B1.14.4 */
> +static bool access_dcsw(struct kvm_vcpu *vcpu,
> +			const struct sys_reg_params *p,
> +			const struct sys_reg_desc *r)
> +{
> +	unsigned long val;
> +	int cpu;
> +
> +	cpu = get_cpu();
> +
> +	if (!p->is_write)
> +		return read_from_write_only(vcpu, p);
> +
> +	cpumask_setall(&vcpu->arch.require_dcache_flush);
> +	cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);
> +
> +	/* If we were already preempted, take the long way around */
> +	if (cpu != vcpu->arch.last_pcpu) {
> +		flush_cache_all();
> +		goto done;
> +	}
> +
> +	val = *vcpu_reg(vcpu, p->Rt);
> +
> +	switch (p->CRm) {
> +	case 6:			/* Upgrade DCISW to DCCISW, as per HCR.SWIO */
> +	case 14:		/* DCCISW */
> +		do_dc_cisw(val);
> +		break;
> +
> +	case 10:		/* DCCSW */
> +		do_dc_csw(val);
> +		break;
> +	}
> +
> +done:
> +	put_cpu();
> +
> +	return true;
> +}
> +
> +/*
> + * We could trap ID_DFR0 and tell the guest we don't support performance
> + * monitoring.  Unfortunately the patch to make the kernel check ID_DFR0 was
> + * NAKed, so it will read the PMCR anyway.
> + *
> + * Therefore we tell the guest we have 0 counters.  Unfortunately, we
> + * must always support PMCCNTR (the cycle counter): we just RAZ/WI for
> + * all PM registers, which doesn't crash the guest kernel at least.
> + */
> +static bool pm_fake(struct kvm_vcpu *vcpu,
> +		    const struct sys_reg_params *p,
> +		    const struct sys_reg_desc *r)
> +{
> +	if (p->is_write)
> +		return ignore_write(vcpu, p);
> +	else
> +		return read_zero(vcpu, p);
> +}
> +
> +static void reset_amair_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
> +{
> +	u64 amair;
> +
> +	asm volatile("mrs %0, amair_el1\n" : "=r" (amair));
> +	vcpu->arch.sys_regs[AMAIR_EL1] = amair;
> +}
> +
> +/*
> + * Architected system registers.
> + * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
> + */
> +static const struct sys_reg_desc sys_reg_descs[] = {
> +	/* DC ISW */
> +	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b0110), Op2(0b010),
> +	  access_dcsw },
> +	/* DC CSW */
> +	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1010), Op2(0b010),
> +	  access_dcsw },
> +	/* DC CISW */
> +	{ Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1110), Op2(0b010),
> +	  access_dcsw },
> +
> +	/* TTBR0_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b000),
> +	  NULL, reset_unknown, TTBR0_EL1 },
> +	/* TTBR1_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b001),
> +	  NULL, reset_unknown, TTBR1_EL1 },
> +	/* TCR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0010), CRm(0b0000), Op2(0b010),
> +	  NULL, reset_val, TCR_EL1, 0 },
> +
> +	/* AFSR0_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b000),
> +	  NULL, reset_unknown, AFSR0_EL1 },
> +	/* AFSR1_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0001), Op2(0b001),
> +	  NULL, reset_unknown, AFSR1_EL1 },
> +	/* ESR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0101), CRm(0b0010), Op2(0b000),
> +	  NULL, reset_unknown, ESR_EL1 },
> +	/* FAR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b0110), CRm(0b0000), Op2(0b000),
> +	  NULL, reset_unknown, FAR_EL1 },
> +
> +	/* PMINTENSET_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b001),
> +	  pm_fake },
> +	/* PMINTENCLR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1001), CRm(0b1110), Op2(0b010),
> +	  pm_fake },
> +
> +	/* MAIR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0010), Op2(0b000),
> +	  NULL, reset_unknown, MAIR_EL1 },
> +	/* AMAIR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1010), CRm(0b0011), Op2(0b000),
> +	  NULL, reset_amair_el1, AMAIR_EL1 },
> +
> +	/* VBAR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1100), CRm(0b0000), Op2(0b000),
> +	  NULL, reset_val, VBAR_EL1, 0 },
> +	/* CONTEXTIDR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b001),
> +	  NULL, reset_val, CONTEXTIDR_EL1, 0 },
> +	/* TPIDR_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1101), CRm(0b0000), Op2(0b100),
> +	  NULL, reset_unknown, TPIDR_EL1 },
> +
> +	/* CNTKCTL_EL1 */
> +	{ Op0(0b11), Op1(0b000), CRn(0b1110), CRm(0b0001), Op2(0b000),
> +	  NULL, reset_val, CNTKCTL_EL1, 0},
> +
> +	/* CSSELR_EL1 */
> +	{ Op0(0b11), Op1(0b010), CRn(0b0000), CRm(0b0000), Op2(0b000),
> +	  NULL, reset_unknown, CSSELR_EL1 },
> +
> +	/* PMCR_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b000),
> +	  pm_fake },
> +	/* PMCNTENSET_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b001),
> +	  pm_fake },
> +	/* PMCNTENCLR_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b010),
> +	  pm_fake },
> +	/* PMOVSCLR_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b011),
> +	  pm_fake },
> +	/* PMSWINC_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b100),
> +	  pm_fake },
> +	/* PMSELR_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b101),
> +	  pm_fake },
> +	/* PMCEID0_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b110),
> +	  pm_fake },
> +	/* PMCEID1_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1100), Op2(0b111),
> +	  pm_fake },
> +	/* PMCCNTR_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b000),
> +	  pm_fake },
> +	/* PMXEVTYPER_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b001),
> +	  pm_fake },
> +	/* PMXEVCNTR_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1101), Op2(0b010),
> +	  pm_fake },
> +	/* PMUSERENR_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b000),
> +	  pm_fake },
> +	/* PMOVSSET_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1001), CRm(0b1110), Op2(0b011),
> +	  pm_fake },
> +
> +	/* TPIDR_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b010),
> +	  NULL, reset_unknown, TPIDR_EL0 },
> +	/* TPIDRRO_EL0 */
> +	{ Op0(0b11), Op1(0b011), CRn(0b1101), CRm(0b0000), Op2(0b011),
> +	  NULL, reset_unknown, TPIDRRO_EL0 },
> +};
> +
> +/* Target specific emulation tables */
> +static struct kvm_sys_reg_target_table *target_tables[KVM_ARM_NUM_TARGETS];
> +
> +void kvm_register_target_sys_reg_table(struct kvm_sys_reg_target_table *table)
> +{
> +	target_tables[table->target] = table;
> +}
> +
> +/* Get specific register table for this target. */
> +static const struct sys_reg_desc *get_target_table(unsigned target, size_t *num)
> +{
> +	struct kvm_sys_reg_target_table *table;
> +
> +	table = target_tables[target];
> +	*num = table->table64.num;
> +	return table->table64.table;
> +}
> +
> +static const struct sys_reg_desc *find_reg(const struct sys_reg_params *params,
> +					 const struct sys_reg_desc table[],
> +					 unsigned int num)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < num; i++) {
> +		const struct sys_reg_desc *r = &table[i];
> +
> +		if (params->Op0 != r->Op0)
> +			continue;
> +		if (params->Op1 != r->Op1)
> +			continue;
> +		if (params->CRn != r->CRn)
> +			continue;
> +		if (params->CRm != r->CRm)
> +			continue;
> +		if (params->Op2 != r->Op2)
> +			continue;
> +
> +		return r;
> +	}
> +	return NULL;
> +}
> +
> +static int emulate_sys_reg(struct kvm_vcpu *vcpu,
> +			   const struct sys_reg_params *params)
> +{
> +	size_t num;
> +	const struct sys_reg_desc *table, *r;
> +
> +	table = get_target_table(vcpu->arch.target, &num);
> +
> +	/* Search target-specific then generic table. */
> +	r = find_reg(params, table, num);
> +	if (!r)
> +		r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));

Searching through the whole list sounds quite slow. Especially since the TLS register is at the very bottom of it.

Can't you make this a simple switch() statement through a bit of #define and maybe #include magic? After all, the sysreg target encoding is all part of the opcode. And from my experience in the PPC instruction emulator, switch()es are _a lot_ faster than any other way of lookup I've tried.


Alex
