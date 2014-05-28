From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 May 2014 11:27:23 +0100
Subject: [PATCH v2 3/9] arm64: KVM: add trap handlers for AArch64 debug
 registers
In-Reply-To: <20140525153450.GD3866@lvm>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
 <1400604945-25247-4-git-send-email-marc.zyngier@arm.com>
 <20140525153450.GD3866@lvm>
Message-ID: <5385BA0B.7080200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/14 16:34, Christoffer Dall wrote:
> On Tue, May 20, 2014 at 05:55:39PM +0100, Marc Zyngier wrote:
>> Add handlers for all the AArch64 debug registers that are accessible
>> from EL0 or EL1. The trapping code keeps track of the state of the
>> debug registers, allowing for the switch code to implement a lazy
>> switching strategy.
>>
>> Reviewed-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  arch/arm64/include/asm/kvm_asm.h  |  28 ++++++--
>>  arch/arm64/include/asm/kvm_host.h |   3 +
>>  arch/arm64/kvm/sys_regs.c         | 130 +++++++++++++++++++++++++++++++++++++-
>>  3 files changed, 151 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
>> index 9fcd54b..e6b159a 100644
>> --- a/arch/arm64/include/asm/kvm_asm.h
>> +++ b/arch/arm64/include/asm/kvm_asm.h
>> @@ -43,14 +43,25 @@
>>  #define      AMAIR_EL1       19      /* Aux Memory Attribute Indirection Register */
>>  #define      CNTKCTL_EL1     20      /* Timer Control Register (EL1) */
>>  #define      PAR_EL1         21      /* Physical Address Register */
>> +#define MDSCR_EL1    22      /* Monitor Debug System Control Register */
>> +#define DBGBCR0_EL1  23      /* Debug Breakpoint Control Registers (0-15) */
>> +#define DBGBCR15_EL1 38
>> +#define DBGBVR0_EL1  39      /* Debug Breakpoint Value Registers (0-15) */
>> +#define DBGBVR15_EL1 54
>> +#define DBGWCR0_EL1  55      /* Debug Watchpoint Control Registers (0-15) */
>> +#define DBGWCR15_EL1 70
>> +#define DBGWVR0_EL1  71      /* Debug Watchpoint Value Registers (0-15) */
>> +#define DBGWVR15_EL1 86
>> +#define MDCCINT_EL1  87      /* Monitor Debug Comms Channel Interrupt Enable Reg */
>> +
>>  /* 32bit specific registers. Keep them at the end of the range */
>> -#define      DACR32_EL2      22      /* Domain Access Control Register */
>> -#define      IFSR32_EL2      23      /* Instruction Fault Status Register */
>> -#define      FPEXC32_EL2     24      /* Floating-Point Exception Control Register */
>> -#define      DBGVCR32_EL2    25      /* Debug Vector Catch Register */
>> -#define      TEECR32_EL1     26      /* ThumbEE Configuration Register */
>> -#define      TEEHBR32_EL1    27      /* ThumbEE Handler Base Register */
>> -#define      NR_SYS_REGS     28
>> +#define      DACR32_EL2      88      /* Domain Access Control Register */
>> +#define      IFSR32_EL2      89      /* Instruction Fault Status Register */
>> +#define      FPEXC32_EL2     90      /* Floating-Point Exception Control Register */
>> +#define      DBGVCR32_EL2    91      /* Debug Vector Catch Register */
>> +#define      TEECR32_EL1     92      /* ThumbEE Configuration Register */
>> +#define      TEEHBR32_EL1    93      /* ThumbEE Handler Base Register */
>> +#define      NR_SYS_REGS     94
>>
>>  /* 32bit mapping */
>>  #define c0_MPIDR     (MPIDR_EL1 * 2) /* MultiProcessor ID Register */
>> @@ -87,6 +98,9 @@
>>  #define ARM_EXCEPTION_IRQ      0
>>  #define ARM_EXCEPTION_TRAP     1
>>
>> +#define KVM_ARM64_DEBUG_DIRTY_SHIFT  0
>> +#define KVM_ARM64_DEBUG_DIRTY                (1 << KVM_ARM64_DEBUG_DIRTY_SHIFT)
>> +
>>  #ifndef __ASSEMBLY__
>>  struct kvm;
>>  struct kvm_vcpu;
>> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
>> index 0a1d697..4737961 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -101,6 +101,9 @@ struct kvm_vcpu_arch {
>>       /* Exception Information */
>>       struct kvm_vcpu_fault_info fault;
>>
>> +     /* Debug state */
>> +     u64 debug_flags;
>> +
>>       /* Pointer to host CPU context */
>>       kvm_cpu_context_t *host_cpu_context;
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index c3d28f1..d46a965 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -30,6 +30,7 @@
>>  #include <asm/kvm_mmu.h>
>>  #include <asm/cacheflush.h>
>>  #include <asm/cputype.h>
>> +#include <asm/debug-monitors.h>
>>  #include <trace/events/kvm.h>
>>
>>  #include "sys_regs.h"
>> @@ -173,6 +174,58 @@ static bool trap_raz_wi(struct kvm_vcpu *vcpu,
>>               return read_zero(vcpu, p);
>>  }
>>
>> +static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
>> +                        const struct sys_reg_params *p,
>> +                        const struct sys_reg_desc *r)
>> +{
>> +     if (p->is_write) {
>> +             return ignore_write(vcpu, p);
>> +     } else {
>> +             *vcpu_reg(vcpu, p->Rt) = (1 << 3);
>> +             return true;
>> +     }
>> +}
>> +
>> +static bool trap_dbgauthstatus_el1(struct kvm_vcpu *vcpu,
>> +                                const struct sys_reg_params *p,
>> +                                const struct sys_reg_desc *r)
>> +{
>> +     if (p->is_write) {
>> +             return ignore_write(vcpu, p);
>> +     } else {
>> +             *vcpu_reg(vcpu, p->Rt) = 0x2222; /* Implemented and disabled */
> 
> is this always safe?  What happens when you stop trapping accesses to
> this register and the hardware tells you something different?
> 
> Are we assuming that this is always the case since otherwise none of
> this works, or?

No, that's probably a leftover from a previous implementation that
didn't disable traps. I can make it return the actual value on the host,
but we may see it change with migration anyway.

>> +             return true;
>> +     }
>> +}
>> +
>> +/*
>> + * Trap handler for DBG[BW][CV]Rn_EL1 and MDSCR_EL1. We track the
>> + * "dirtiness" of the registers.
>> + */
>> +static bool trap_debug_regs(struct kvm_vcpu *vcpu,
>> +                         const struct sys_reg_params *p,
>> +                         const struct sys_reg_desc *r)
>> +{
>> +     /*
>> +      * The best thing to do would be to trap MDSCR_EL1
>> +      * independently, test if DBG_MDSCR_KDE or DBG_MDSCR_MDE is
>> +      * getting set, and only set the DIRTY bit in that case.
> 
> this comment is really hard to understand in this patch without any
> explanation of what the dirty flag does.  Readers new to this code may
> be in the same situation.  Perhaps add a comment on the dirty bit (what
> does this imply?) or explain the rationale here; iow. We want to avoid
> world-switching all the DBG registers all the time, blah blah blah...

Sure.

>> +      *
>> +      * Unfortunately, "old" Linux kernels tend to hit MDSCR_EL1
>> +      * like a woodpecker on a tree, and it is better to disable
>> +      * trapping as soon as possible in this case. Some day, make
>> +      * this a tuneable...
>> +      */
>> +     if (p->is_write) {
>> +             vcpu_sys_reg(vcpu, r->reg) = *vcpu_reg(vcpu, p->Rt);
>> +             vcpu->arch.debug_flags |= KVM_ARM64_DEBUG_DIRTY;
>> +     } else {
>> +             *vcpu_reg(vcpu, p->Rt) = vcpu_sys_reg(vcpu, r->reg);
>> +     }
>> +
>> +     return true;
>> +}
>> +
>>  static void reset_amair_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>>  {
>>       u64 amair;
>> @@ -189,6 +242,21 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>>       vcpu_sys_reg(vcpu, MPIDR_EL1) = (1UL << 31) | (vcpu->vcpu_id & 0xff);
>>  }
>>
>> +/* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go*/
>> +#define DBG_BCR_BVR_WCR_WVR_EL1(n)                                   \
>> +     /* DBGBVRn_EL1 */                                               \
>> +     { Op0(0b10), Op1(0b000), CRn(0b0000), CRm((n)), Op2(0b100),     \
>> +       trap_debug_regs, reset_val, (DBGBCR0_EL1 + (n)), 0 },         \
> 
> Shouldn't the reg field here be DBGBVR0_EL1?
> 
> 
>> +     /* DBGBCRn_EL1 */                                               \
>> +     { Op0(0b10), Op1(0b000), CRn(0b0000), CRm((n)), Op2(0b101),     \
>> +       trap_debug_regs, reset_val, (DBGBVR0_EL1 + (n)), 0 },         \
> 
> Shouldn't the reg field here be DBGBCR0_EL1?
> 
>> +     /* DBGWVRn_EL1 */                                               \
>> +     { Op0(0b10), Op1(0b000), CRn(0b0000), CRm((n)), Op2(0b110),     \
>> +       trap_debug_regs, reset_val, (DBGWCR0_EL1 + (n)), 0 },         \
> 
> and DBGWVR0_EL1 here?
> 
>> +     /* DBGWCRn_EL1 */                                               \
>> +     { Op0(0b10), Op1(0b000), CRn(0b0000), CRm((n)), Op2(0b111),     \
>> +       trap_debug_regs, reset_val, (DBGWVR0_EL1 + (n)), 0 }
> 
> and DBGWCR0_EL1 here?

Blah. Nice catch!

>> +
>>  /*
>>   * Architected system registers.
>>   * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
>> @@ -200,9 +268,6 @@ static void reset_mpidr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
>>   * Therefore we tell the guest we have 0 counters.  Unfortunately, we
>>   * must always support PMCCNTR (the cycle counter): we just RAZ/WI for
>>   * all PM registers, which doesn't crash the guest kernel at least.
>> - *
>> - * Same goes for the whole debug infrastructure, which probably breaks
>> - * some guest functionnality. This should be fixed.
>>   */
>>  static const struct sys_reg_desc sys_reg_descs[] = {
>>       /* DC ISW */
>> @@ -215,12 +280,71 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>>       { Op0(0b01), Op1(0b000), CRn(0b0111), CRm(0b1110), Op2(0b010),
>>         access_dcsw },
>>
>> +     DBG_BCR_BVR_WCR_WVR_EL1(0),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(1),
>> +     /* MDCCINT_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b000),
>> +       trap_debug_regs, reset_val, MDCCINT_EL1, 0 },
>> +     /* MDSCR_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0000), CRm(0b0010), Op2(0b010),
>> +       trap_debug_regs, reset_val, MDSCR_EL1, 0 },
>> +     DBG_BCR_BVR_WCR_WVR_EL1(2),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(3),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(4),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(5),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(6),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(7),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(8),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(9),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(10),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(11),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(12),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(13),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(14),
>> +     DBG_BCR_BVR_WCR_WVR_EL1(15),
>> +
>> +     /* MDRAR_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b000),
>> +       trap_raz_wi },
>> +     /* OSLAR_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0001), CRm(0b0000), Op2(0b100),
>> +       trap_raz_wi },
> 
> so as long as you're trapping, if the guest writes to OSLK[1] and sets
> the OS lock then it won't actually lock it, because when you read it
> back from OSLSR_EL1 it will read as unlocked?  Is that in line with the
> architecture?

The OSlock can always be cleared by external debug at any time, so I
imagine that would be a valid implementation.

>> +     /* OSLSR_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0001), CRm(0b0001), Op2(0b100),
>> +       trap_oslsr_el1 },
>> +     /* OSDLR_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0001), CRm(0b0011), Op2(0b100),
>> +       trap_raz_wi },
>> +     /* DBGPRCR_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0001), CRm(0b0100), Op2(0b100),
>> +       trap_raz_wi },
>> +     /* DBGCLAIMSET_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0111), CRm(0b1000), Op2(0b110),
>> +       trap_raz_wi },
>> +     /* DBGCLAIMCLR_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0111), CRm(0b1001), Op2(0b110),
>> +       trap_raz_wi },
>> +     /* DBGAUTHSTATUS_EL1 */
>> +     { Op0(0b10), Op1(0b000), CRn(0b0111), CRm(0b1110), Op2(0b110),
>> +       trap_dbgauthstatus_el1 },
>> +
>>       /* TEECR32_EL1 */
>>       { Op0(0b10), Op1(0b010), CRn(0b0000), CRm(0b0000), Op2(0b000),
>>         NULL, reset_val, TEECR32_EL1, 0 },
>>       /* TEEHBR32_EL1 */
>>       { Op0(0b10), Op1(0b010), CRn(0b0001), CRm(0b0000), Op2(0b000),
>>         NULL, reset_val, TEEHBR32_EL1, 0 },
>> +
>> +     /* MDCCSR_EL1 */
>> +     { Op0(0b10), Op1(0b011), CRn(0b0000), CRm(0b0001), Op2(0b000),
>> +       trap_raz_wi },
>> +     /* DBGDTR_EL0 */
>> +     { Op0(0b10), Op1(0b011), CRn(0b0000), CRm(0b0100), Op2(0b000),
>> +       trap_raz_wi },
>> +     /* DBGDTR[TR]X_EL0 */
>> +     { Op0(0b10), Op1(0b011), CRn(0b0000), CRm(0b0101), Op2(0b000),
>> +       trap_raz_wi },
>> +
>>       /* DBGVCR32_EL2 */
>>       { Op0(0b10), Op1(0b100), CRn(0b0000), CRm(0b0111), Op2(0b000),
>>         NULL, reset_val, DBGVCR32_EL2, 0 },
>> --
>> 1.8.3.4
>>
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
