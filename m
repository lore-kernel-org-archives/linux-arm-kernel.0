From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Apr 2013 14:37:30 +0100
Subject: [PATCH v3 10/32] arm64: KVM: system register handling
In-Reply-To: <20130423230138.GK20569@gmail.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-11-git-send-email-marc.zyngier@arm.com>
 <20130423230138.GK20569@gmail.com>
Message-ID: <5177E01A.1030908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/13 00:01, Christoffer Dall wrote:
> On Mon, Apr 08, 2013 at 05:17:12PM +0100, Marc Zyngier wrote:
>> Provide 64bit system register handling, modeled after the cp15
>> handling for ARM.
>>
>> Reviewed-by: Christopher Covington <cov@codeaurora.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_coproc.h |  51 +++
>>  arch/arm64/include/uapi/asm/kvm.h   |  29 ++
>>  arch/arm64/kvm/sys_regs.c           | 871 ++++++++++++++++++++++++++++++++++++
>>  arch/arm64/kvm/sys_regs.h           | 138 ++++++
>>  include/uapi/linux/kvm.h            |   1 +
>>  5 files changed, 1090 insertions(+)
>>  create mode 100644 arch/arm64/include/asm/kvm_coproc.h
>>  create mode 100644 arch/arm64/kvm/sys_regs.c
>>  create mode 100644 arch/arm64/kvm/sys_regs.h
>>
>> diff --git a/arch/arm64/include/asm/kvm_coproc.h b/arch/arm64/include/asm/kvm_coproc.h
>> new file mode 100644
>> index 0000000..9b4477a
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kvm_coproc.h
>> @@ -0,0 +1,51 @@
>> +/*
>> + * Copyright (C) 2012,2013 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * Derived from arch/arm/include/asm/kvm_coproc.h
>> + * Copyright (C) 2012 Rusty Russell IBM Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ARM64_KVM_COPROC_H__
>> +#define __ARM64_KVM_COPROC_H__
>> +
>> +#include <linux/kvm_host.h>
>> +
>> +void kvm_reset_sys_regs(struct kvm_vcpu *vcpu);
>> +
>> +struct kvm_sys_reg_table {
>> + const struct sys_reg_desc *table;
>> + size_t num;
>> +};
>> +
>> +struct kvm_sys_reg_target_table {
>> + struct kvm_sys_reg_table table64;
>> +};
>> +
>> +void kvm_register_target_sys_reg_table(unsigned int target,
>> +       struct kvm_sys_reg_target_table *table);
>> +
>> +int kvm_handle_sys_reg(struct kvm_vcpu *vcpu, struct kvm_run *run);
>> +
>> +#define kvm_coproc_table_init kvm_sys_reg_table_init
>> +void kvm_sys_reg_table_init(void);
>> +
>> +struct kvm_one_reg;
>> +int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
>> +int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
>> +int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *);
>> +unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
>> +
>> +#endif /* __ARM64_KVM_COPROC_H__ */
>> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
>> index 4e64570..ebac919 100644
>> --- a/arch/arm64/include/uapi/asm/kvm.h
>> +++ b/arch/arm64/include/uapi/asm/kvm.h
>> @@ -92,6 +92,35 @@ struct kvm_sync_regs {
>>  struct kvm_arch_memory_slot {
>>  };
>>
>> +/* If you need to interpret the index values, here is the key: */
>> +#define KVM_REG_ARM_COPROC_MASK 0x000000000FFF0000
>> +#define KVM_REG_ARM_COPROC_SHIFT 16
>> +
>> +/* Normal registers are mapped as coprocessor 16. */
>> +#define KVM_REG_ARM_CORE (0x0010 << KVM_REG_ARM_COPROC_SHIFT)
>> +#define KVM_REG_ARM_CORE_REG(name) (offsetof(struct kvm_regs, name) / sizeof(__u32))
>> +
>> +/* Some registers need more space to represent values. */
>> +#define KVM_REG_ARM_DEMUX (0x0011 << KVM_REG_ARM_COPROC_SHIFT)
>> +#define KVM_REG_ARM_DEMUX_ID_MASK 0x000000000000FF00
>> +#define KVM_REG_ARM_DEMUX_ID_SHIFT 8
>> +#define KVM_REG_ARM_DEMUX_ID_CCSIDR (0x00 << KVM_REG_ARM_DEMUX_ID_SHIFT)
>> +#define KVM_REG_ARM_DEMUX_VAL_MASK 0x00000000000000FF
>> +#define KVM_REG_ARM_DEMUX_VAL_SHIFT 0
>> +
>> +/* AArch64 system registers */
>> +#define KVM_REG_ARM64_SYSREG (0x0013 << KVM_REG_ARM_COPROC_SHIFT)
>> +#define KVM_REG_ARM64_SYSREG_OP0_MASK 0x000000000000c000
>> +#define KVM_REG_ARM64_SYSREG_OP0_SHIFT 14
>> +#define KVM_REG_ARM64_SYSREG_OP1_MASK 0x0000000000003800
>> +#define KVM_REG_ARM64_SYSREG_OP1_SHIFT 11
>> +#define KVM_REG_ARM64_SYSREG_CRN_MASK 0x0000000000000780
>> +#define KVM_REG_ARM64_SYSREG_CRN_SHIFT 7
>> +#define KVM_REG_ARM64_SYSREG_CRM_MASK 0x0000000000000078
>> +#define KVM_REG_ARM64_SYSREG_CRM_SHIFT 3
>> +#define KVM_REG_ARM64_SYSREG_OP2_MASK 0x0000000000000007
>> +#define KVM_REG_ARM64_SYSREG_OP2_SHIFT 0
>> +
>>  /* KVM_IRQ_LINE irq field index values */
>>  #define KVM_ARM_IRQ_TYPE_SHIFT 24
>>  #define KVM_ARM_IRQ_TYPE_MASK 0xff
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> new file mode 100644
>> index 0000000..9df3b32
>> --- /dev/null
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -0,0 +1,871 @@
>> +/*
>> + * Copyright (C) 2012,2013 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * Derived from arch/arm/kvm/coproc.c:
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Authors: Rusty Russell <rusty@rustcorp.com.au>
>> + *          Christoffer Dall <c.dall@virtualopensystems.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/mm.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/uaccess.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_host.h>
>> +#include <asm/kvm_emulate.h>
>> +#include <asm/kvm_coproc.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/cputype.h>
>> +#include <trace/events/kvm.h>
>> +
>> +#include "sys_regs.h"
>> +
>> +/*
>> + * All of this file is extremly similar to the ARM coproc.c, but the
>> + * types are different. My gut feeling is that it should be pretty
>> + * easy to merge, but that would be an ABI breakage -- again. VFP
>> + * would also need to be abstracted.
>> + */
> 
> What API would we break here by sharing more of the code? Can you
> elaborate.

The sys_regs encoding has 5 fields, while cp15 only has 4. If we change
this, we break the ABI.

> VFP should probably be separated into its own file on the arm side as
> well in any case.
> 
>> +
>> +/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
>> +static u32 cache_levels;
>> +
>> +/* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>> +#define CSSELR_MAX 12
>> +
>> +/* Which cache CCSIDR represents depends on CSSELR value. */
>> +static u32 get_ccsidr(u32 csselr)
>> +{
>> + u32 ccsidr;
>> +
>> + /* Make sure noone else changes CSSELR during this! */
>> + local_irq_disable();
>> + /* Put value into CSSELR */
>> + asm volatile("msr csselr_el1, %x0" : : "r" (csselr));
>> + /* Read result out of CCSIDR */
>> + asm volatile("mrs %0, ccsidr_el1" : "=r" (ccsidr));
>> + local_irq_enable();
>> +
>> + return ccsidr;
>> +}
>> +
>> +static void do_dc_cisw(u32 val)
>> +{
>> + asm volatile("dc cisw, %x0" : : "r" (val));
>> +}
>> +
>> +static void do_dc_csw(u32 val)
>> +{
>> + asm volatile("dc csw, %x0" : : "r" (val));
>> +}
>> +
>> +/* See note at ARM ARM B1.14.4 */
>> +static bool access_dcsw(struct kvm_vcpu *vcpu,
>> + const struct sys_reg_params *p,
>> + const struct sys_reg_desc *r)
>> +{
>> + unsigned long val;
>> + int cpu;
>> +
>> + cpu = get_cpu();
> 
> you have that unbalanced get_cpu here again, but you know that
> already...

I do. It's fixed in my tree already.

[...]

>> +static int emulate_sys_reg(struct kvm_vcpu *vcpu,
>> +   const struct sys_reg_params *params)
>> +{
>> + size_t num;
>> + const struct sys_reg_desc *table, *r;
>> +
>> + table = get_target_table(vcpu->arch.target, &num);
>> +
>> + /* Search target-specific then generic table. */
>> + r = find_reg(params, table, num);
>> + if (!r)
>> + r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
>> +
>> + if (likely(r)) {
>> + /* If we don't have an accessor, we should never get here! */
>> + BUG_ON(!r->access);
> 
> that's a little rough, you don't have to stop the entire host kernel...

I'm not sure. It means you've decided to trap a sys_reg, but you're not
prepared to handle it... Surely that's a bug.

I'll probably turn that into an UNDEF and a big fat screaming warning,
but you may want to do something about it on the 32bit side too.

[...]

>> +/* ->val is filled in by kvm_invariant_sys_reg_table_init() */
> 
> kvm_sys_reg_table_init ?

Ah, yes. Thanks.

>> +static struct sys_reg_desc invariant_sys_regs[] = {
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0000), Op2(0b000),
>> +  NULL, get_midr_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0000), Op2(0b110),
>> +  NULL, get_revidr_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b000),
>> +  NULL, get_id_pfr0_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b001),
>> +  NULL, get_id_pfr1_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b010),
>> +  NULL, get_id_dfr0_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b011),
>> +  NULL, get_id_afr0_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b100),
>> +  NULL, get_id_mmfr0_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b101),
>> +  NULL, get_id_mmfr1_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b110),
>> +  NULL, get_id_mmfr2_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0001), Op2(0b111),
>> +  NULL, get_id_mmfr3_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b000),
>> +  NULL, get_id_isar0_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b001),
>> +  NULL, get_id_isar1_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b010),
>> +  NULL, get_id_isar2_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b011),
>> +  NULL, get_id_isar3_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b100),
>> +  NULL, get_id_isar4_el1 },
>> + { Op0(0b11), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b101),
>> +  NULL, get_id_isar5_el1 },
>> + { Op0(0b11), Op1(0b001), CRn(0b0000), CRm(0b0000), Op2(0b001),
>> +  NULL, get_clidr_el1 },
>> + { Op0(0b11), Op1(0b001), CRn(0b0000), CRm(0b0000), Op2(0b111),
>> +  NULL, get_aidr_el1 },
>> + { Op0(0b11), Op1(0b011), CRn(0b0000), CRm(0b0000), Op2(0b001),
>> +  NULL, get_ctr_el0 },
>> +};
> 
> would you consider using spaces instead of tabs here, this becomes completely unreadable on an 80 chars display...

Sure.

[...]

>> +static bool is_valid_cache(u32 val)
>> +{
>> + u32 level, ctype;
>> +
>> + if (val >= CSSELR_MAX)
>> + return -ENOENT;
>> +
>> + /* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
>> +        level = (val >> 1);
>> +        ctype = (cache_levels >> (level * 3)) & 7;
> 
> replace spaces with tab here

OK.

[...]

>> +int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> +{
>> + const struct sys_reg_desc *r;
>> + void __user *uaddr = (void __user *)(unsigned long)reg->addr;
>> +
>> + if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_DEMUX)
>> + return demux_c15_get(reg->id, uaddr);
>> +
>> + r = index_to_sys_reg_desc(vcpu, reg->id);
>> + if (!r)
>> + return get_invariant_sys_reg(reg->id, uaddr);
>> +
>> + /* Note: copies two regs if size is 64 bit. */
> 
> is this still true?

Hmmm... Not any more. It is actually an arbitrary size, and should be
validated.

	M.
-- 
Jazz is not dead. It just smells funny...
