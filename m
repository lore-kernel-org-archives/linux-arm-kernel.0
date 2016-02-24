From: dave.long@linaro.org (David Long)
Date: Wed, 24 Feb 2016 01:56:52 -0500
Subject: [PATCH 5/8] arm64: kprobes instruction simulation support
In-Reply-To: <56C720F0.9080108@arm.com>
References: <1455839301-26464-1-git-send-email-dave.long@linaro.org>
 <1455839301-26464-6-git-send-email-dave.long@linaro.org>
 <56C720F0.9080108@arm.com>
Message-ID: <56CD5434.30108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2016 09:04 AM, Marc Zyngier wrote:
> Hi David,
>
> On 18/02/16 23:48, David Long wrote:
>> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>
>> Kprobes needs simulation of instructions that cannot be stepped
>> from different memory location, e.g.: those instructions
>> that uses PC-relative addressing. In simulation, the behaviour
>> of the instruction is implemented using a copy of pt_regs.
>>
>> Following instruction catagories are simulated:
>>   - All branching instructions(conditional, register, and immediate)
>>   - Literal access instructions(load-literal, adr/adrp)
>>
>> Conditional execution is limited to branching instructions in
>> ARM v8. If conditions at PSTATE do not match the condition fields
>> of opcode, the instruction is effectively NOP. Kprobes considers
>> this case as 'miss'.
>>
>> This code also replaces the use of arch/arm/opcodes.c for
>> arm_check_condition().
>>
>> Thanks to Will Cohen for assorted suggested changes.
>>
>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>> Signed-off-by: William Cohen <wcohen@redhat.com>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> ---
>>   arch/arm64/include/asm/insn.h            |   3 +
>>   arch/arm64/include/asm/probes.h          |   5 +-
>>   arch/arm64/kernel/Makefile               |   6 +-
>>   arch/arm64/kernel/insn.c                 | 111 ++++++++++++++++++
>>   arch/arm64/kernel/kprobes-arm64.c        |  29 +++++
>>   arch/arm64/kernel/kprobes.c              |  32 +++++-
>>   arch/arm64/kernel/probes-simulate-insn.c | 187 +++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/probes-simulate-insn.h |  30 +++++
>>   8 files changed, 395 insertions(+), 8 deletions(-)
>>   create mode 100644 arch/arm64/kernel/probes-simulate-insn.c
>>   create mode 100644 arch/arm64/kernel/probes-simulate-insn.h
>>
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index cf43773..2cac976 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -407,6 +407,9 @@ u32 aarch64_insn_extract_system_reg(u32 insn);
>>   u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
>>   u32 aarch32_insn_mcr_extract_opc2(u32 insn);
>>   u32 aarch32_insn_mcr_extract_crm(u32 insn);
>> +
>> +typedef unsigned long (pstate_check_t)(unsigned long);
>> +
>>   #endif /* __ASSEMBLY__ */
>>
>>   #endif	/* __ASM_INSN_H */
>> diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
>> index c5fcbe6..d524f7d 100644
>> --- a/arch/arm64/include/asm/probes.h
>> +++ b/arch/arm64/include/asm/probes.h
>> @@ -15,11 +15,12 @@
>>   #ifndef _ARM_PROBES_H
>>   #define _ARM_PROBES_H
>>
>> +#include <asm/opcodes.h>
>> +
>>   struct kprobe;
>>   struct arch_specific_insn;
>>
>>   typedef u32 kprobe_opcode_t;
>> -typedef unsigned long (kprobes_pstate_check_t)(unsigned long);
>>   typedef void (kprobes_handler_t) (u32 opcode, long addr, struct pt_regs *);
>>
>>   enum pc_restore_type {
>> @@ -35,7 +36,7 @@ struct kprobe_pc_restore {
>>   /* architecture specific copy of original instruction */
>>   struct arch_specific_insn {
>>   	kprobe_opcode_t *insn;
>> -	kprobes_pstate_check_t *pstate_cc;
>> +	pstate_check_t *pstate_cc;
>>   	kprobes_handler_t *handler;
>>   	/* restore address after step xol */
>>   	struct kprobe_pc_restore restore;
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 5b0ee7d..08325e5 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -26,8 +26,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>>   	$(call if_changed,objcopy)
>>
>>   arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
>> -					   sys_compat.o entry32.o		\
>> -					   ../../arm/kernel/opcodes.o
>> +					   sys_compat.o entry32.o
>>   arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
>>   arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
>>   arm64-obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
>> @@ -37,7 +36,8 @@ arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
>>   arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>>   arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>>   arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>> -arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o
>> +arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o		\
>> +					   probes-simulate-insn.o
>>   arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
>>   arm64-obj-$(CONFIG_PCI)			+= pci.o
>>   arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>> index 60c1c71..74a08db 100644
>> --- a/arch/arm64/kernel/insn.c
>> +++ b/arch/arm64/kernel/insn.c
>> @@ -30,6 +30,7 @@
>>   #include <asm/cacheflush.h>
>>   #include <asm/debug-monitors.h>
>>   #include <asm/fixmap.h>
>> +#include <asm/opcodes.h>
>>   #include <asm/insn.h>
>>
>>   #define AARCH64_INSN_SF_BIT	BIT(31)
>> @@ -1234,3 +1235,113 @@ u32 aarch32_insn_mcr_extract_crm(u32 insn)
>>   {
>>   	return insn & CRM_MASK;
>>   }
>> +
>> +#define	ARM_OPCODE_CONDITION_UNCOND	0xf
>> +
>> +static unsigned long __kprobes __check_eq(unsigned long pstate)
>> +{
>> +	return pstate & PSR_Z_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_ne(unsigned long pstate)
>> +{
>> +	return (~pstate) & PSR_Z_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_cs(unsigned long pstate)
>> +{
>> +	return pstate & PSR_C_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_cc(unsigned long pstate)
>> +{
>> +	return (~pstate) & PSR_C_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_mi(unsigned long pstate)
>> +{
>> +	return pstate & PSR_N_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_pl(unsigned long pstate)
>> +{
>> +	return (~pstate) & PSR_N_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_vs(unsigned long pstate)
>> +{
>> +	return pstate & PSR_V_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_vc(unsigned long pstate)
>> +{
>> +	return (~pstate) & PSR_V_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_hi(unsigned long pstate)
>> +{
>> +	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
>> +	return pstate & PSR_C_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_ls(unsigned long pstate)
>> +{
>> +	pstate &= ~(pstate >> 1);	/* PSR_C_BIT &= ~PSR_Z_BIT */
>> +	return (~pstate) & PSR_C_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_ge(unsigned long pstate)
>> +{
>> +	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
>> +	return (~pstate) & PSR_N_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_lt(unsigned long pstate)
>> +{
>> +	pstate ^= (pstate << 3);	/* PSR_N_BIT ^= PSR_V_BIT */
>> +	return pstate & PSR_N_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_gt(unsigned long pstate)
>> +{
>> +	/*PSR_N_BIT ^= PSR_V_BIT */
>> +	unsigned long temp = pstate ^ (pstate << 3);
>> +
>> +	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
>> +	return (~temp) & PSR_N_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_le(unsigned long pstate)
>> +{
>> +	/*PSR_N_BIT ^= PSR_V_BIT */
>> +	unsigned long temp = pstate ^ (pstate << 3);
>> +
>> +	temp |= (pstate << 1);	/*PSR_N_BIT |= PSR_Z_BIT */
>> +	return temp & PSR_N_BIT;
>> +}
>> +
>> +static unsigned long __kprobes __check_al(unsigned long pstate)
>> +{
>> +	return true;
>> +}
>
> This is rather inconsistent. Either you're returning always returning a
> boolean, or returning a long that has a meaningful bit position in it.
> I'd vote for the first case, and the conversion of all __check_* functions.
>

I see your point.  Changes made.

>> +
>> +pstate_check_t * const opcode_condition_checks[16] = {
>> +	&__check_eq, &__check_ne, &__check_cs, &__check_cc,
>> +	&__check_mi, &__check_pl, &__check_vs, &__check_vc,
>> +	&__check_hi, &__check_ls, &__check_ge, &__check_lt,
>> +	&__check_gt, &__check_le, &__check_al, &__check_al
>
> You can probably loose the '&'.
>

Yup.  Changed.

>> +};
>> +
>> +asmlinkage unsigned int __kprobes arm_check_condition(u32 opcode, u32 psr)
>
> Why asmlinkage? This function is never called from assembly code on arm64.
>

This comes from the 32-bit ARM code that tests the condition from 
entry.S.  We include arch/arm/include/asm/opcodes.h in 
arch/arm64/include/asm/opcodes.h so it gets declared there with 
asmlinkage. I can remove the asmlinkage in the actual function 
definition and it still compiles but I'm not sure that is kosher. Will 
Deacon was advocating getting rid of the include of the 32-bit header 
file but it looked to me like this would mean a lot of duplicated 
defines and the work would be mostly unrelated to kprobes.

>> +{
>> +	u32 cc_bits  = opcode >> 28;
>> +
>> +	if (cc_bits != ARM_OPCODE_CONDITION_UNCOND) {
>> +		if ((*opcode_condition_checks[cc_bits])(psr))
>> +			return ARM_OPCODE_CONDTEST_PASS;
>> +		else
>> +			return ARM_OPCODE_CONDTEST_FAIL;
>> +	}
>> +	return ARM_OPCODE_CONDTEST_UNCOND;
>> +}
>> +EXPORT_SYMBOL_GPL(arm_check_condition);
>
> Why do we need this to be exported at all? Also, it'd be better located
> together with the deprecated instruction handling, possibly in a
> separate patch (nothing uses this function in this patch).
>

I've made the function static and moved it to armv8_deprecated.  I have 
to leave the static functions that test the individual conditions and 
the global array of pointers to them outside of the conditionally 
compiled armv8_deprecated.c as they have to always be present for 
kprobes to simulate a conditional branch.

>> diff --git a/arch/arm64/kernel/kprobes-arm64.c b/arch/arm64/kernel/kprobes-arm64.c
>> index e07727a..487238a 100644
>> --- a/arch/arm64/kernel/kprobes-arm64.c
>> +++ b/arch/arm64/kernel/kprobes-arm64.c
>> @@ -21,6 +21,7 @@
>>   #include <asm/sections.h>
>>
>>   #include "kprobes-arm64.h"
>> +#include "probes-simulate-insn.h"
>>
>>   static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>>   {
>> @@ -62,8 +63,36 @@ arm_probe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>>   	 */
>>   	if (aarch64_insn_is_steppable(insn))
>>   		return INSN_GOOD;
>> +
>> +	if (aarch64_insn_is_bcond(insn)) {
>> +		asi->handler = simulate_b_cond;
>> +	} else if (aarch64_insn_is_cbz(insn) ||
>> +	    aarch64_insn_is_cbnz(insn)) {
>> +		asi->handler = simulate_cbz_cbnz;
>> +	} else if (aarch64_insn_is_tbz(insn) ||
>> +	    aarch64_insn_is_tbnz(insn)) {
>> +		asi->handler = simulate_tbz_tbnz;
>> +	} else if (aarch64_insn_is_adr_adrp(insn))
>> +		asi->handler = simulate_adr_adrp;
>> +	else if (aarch64_insn_is_b(insn) ||
>> +	    aarch64_insn_is_bl(insn))
>> +		asi->handler = simulate_b_bl;
>> +	else if (aarch64_insn_is_br(insn) ||
>> +	    aarch64_insn_is_blr(insn) ||
>> +	    aarch64_insn_is_ret(insn))
>> +		asi->handler = simulate_br_blr_ret;
>> +	else if (aarch64_insn_is_ldr_lit(insn))
>> +		asi->handler = simulate_ldr_literal;
>> +	else if (aarch64_insn_is_ldrsw_lit(insn))
>> +		asi->handler = simulate_ldrsw_literal;
>>   	else
>> +		/*
>> +		 * Instruction cannot be stepped out-of-line and we don't
>> +		 * (yet) simulate it.
>> +		 */
>>   		return INSN_REJECTED;
>> +
>> +	return INSN_GOOD_NO_SLOT;
>>   }
>>
>>   static bool __kprobes
>> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
>> index 8db71a4..52f6c3d 100644
>> --- a/arch/arm64/kernel/kprobes.c
>> +++ b/arch/arm64/kernel/kprobes.c
>> @@ -40,6 +40,9 @@ void jprobe_return_break(void);
>>   DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>>   DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>>
>> +static void __kprobes
>> +post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
>> +
>>   static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>   {
>>   	/* prepare insn slot */
>> @@ -57,6 +60,24 @@ static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>>   	p->ainsn.restore.type = RESTORE_PC;
>>   }
>>
>> +static void __kprobes arch_prepare_simulate(struct kprobe *p)
>> +{
>> +	/* This instructions is not executed xol. No need to adjust the PC */
>> +	p->ainsn.restore.addr = 0;
>> +	p->ainsn.restore.type = NO_RESTORE;
>> +}
>> +
>> +static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
>> +{
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +	if (p->ainsn.handler)
>> +		p->ainsn.handler((u32)p->opcode, (long)p->addr, regs);
>> +
>> +	/* single step simulated, now go for post processing */
>> +	post_kprobe_handler(kcb, regs);
>> +}
>> +
>>   int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>   {
>>   	unsigned long probe_addr = (unsigned long)p->addr;
>> @@ -73,7 +94,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>   		return -EINVAL;
>>
>>   	case INSN_GOOD_NO_SLOT:	/* insn need simulation */
>> -		return -EINVAL;
>> +		p->ainsn.insn = NULL;
>> +		break;
>>
>>   	case INSN_GOOD:	/* instruction uses slot */
>>   		p->ainsn.insn = get_insn_slot();
>> @@ -83,7 +105,10 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>>   	};
>>
>>   	/* prepare the instruction */
>> -	arch_prepare_ss_slot(p);
>> +	if (p->ainsn.insn)
>> +		arch_prepare_ss_slot(p);
>> +	else
>> +		arch_prepare_simulate(p);
>>
>>   	return 0;
>>   }
>> @@ -225,7 +250,8 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>>   		kernel_enable_single_step(regs);
>>   		instruction_pointer(regs) = slot;
>>   	} else	{
>> -		BUG();
>> +		/* insn simulation */
>> +		arch_simulate_insn(p, regs);
>>   	}
>>   }
>>
>> diff --git a/arch/arm64/kernel/probes-simulate-insn.c b/arch/arm64/kernel/probes-simulate-insn.c
>> new file mode 100644
>> index 0000000..dfcece9
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes-simulate-insn.c
>> @@ -0,0 +1,187 @@
>> +/*
>> + * arch/arm64/kernel/probes-simulate-insn.c
>> + *
>> + * Copyright (C) 2013 Linaro Limited.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/kprobes.h>
>> +#include <linux/module.h>
>> +
>> +#include "probes-simulate-insn.h"
>> +
>> +#define sign_extend(x, signbit)		\
>> +	((x) | (0 - ((x) & (1 << (signbit)))))
>> +
>> +#define bbl_displacement(insn)		\
>> +	sign_extend(((insn) & 0x3ffffff) << 2, 27)
>> +
>> +#define bcond_displacement(insn)	\
>> +	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
>> +
>> +#define cbz_displacement(insn)	\
>> +	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
>> +
>> +#define tbz_displacement(insn)	\
>> +	sign_extend(((insn >> 5) & 0x3fff) << 2, 15)
>> +
>> +#define ldr_displacement(insn)	\
>> +	sign_extend(((insn >> 5) & 0x7ffff) << 2, 20)
>> +
>> +
>> +static unsigned long __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
>> +{
>> +	int xn = opcode & 0x1f;
>> +
>> +	return (opcode & (1 << 31)) ?
>> +	    !(regs->regs[xn]) : !(regs->regs[xn] & 0xffffffff);
>> +}
>> +
>> +static unsigned long __kprobes check_cbnz(u32 opcode, struct pt_regs *regs)
>> +{
>> +	int xn = opcode & 0x1f;
>> +
>> +	return (opcode & (1 << 31)) ?
>> +	    (regs->regs[xn]) : (regs->regs[xn] & 0xffffffff);
>> +}
>> +
>> +static unsigned long __kprobes check_tbz(u32 opcode, struct pt_regs *regs)
>> +{
>> +	int xn = opcode & 0x1f;
>> +	int bit_pos = ((opcode & (1 << 31)) >> 26) | ((opcode >> 19) & 0x1f);
>> +
>> +	return !((regs->regs[xn] >> bit_pos) & 0x1);
>> +}
>> +
>> +static unsigned long __kprobes check_tbnz(u32 opcode, struct pt_regs *regs)
>> +{
>> +	int xn = opcode & 0x1f;
>> +	int bit_pos = ((opcode & (1 << 31)) >> 26) | ((opcode >> 19) & 0x1f);
>> +
>> +	return (regs->regs[xn] >> bit_pos) & 0x1;
>> +}
>
> Same remark as above: these should be returning a boolean value.
>

Yup.  Fixed.

>> +
>> +/*
>> + * instruction simulation functions
>> + */
>> +void __kprobes
>> +simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs)
>> +{
>> +	long imm, xn, val;
>> +
>> +	xn = opcode & 0x1f;
>> +	imm = ((opcode >> 3) & 0x1ffffc) | ((opcode >> 29) & 0x3);
>> +	imm = sign_extend(imm, 20);
>> +	if (opcode & 0x80000000)
>> +		val = (imm<<12) + (addr & 0xfffffffffffff000);
>> +	else
>> +		val = imm + addr;
>> +
>> +	regs->regs[xn] = val;
>> +
>> +	instruction_pointer(regs) += 4;
>> +}
>> +
>> +void __kprobes
>> +simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
>> +{
>> +	int disp = bbl_displacement(opcode);
>> +
>> +	/* Link register is x30 */
>> +	if (opcode & (1 << 31))
>> +		regs->regs[30] = addr + 4;
>> +
>> +	instruction_pointer(regs) = addr + disp;
>> +}
>> +
>> +void __kprobes
>> +simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs)
>> +{
>> +	int disp = 4;
>> +
>> +	if (opcode_condition_checks[opcode & 0xf](regs->pstate & 0xffffffff))
>> +		disp = bcond_displacement(opcode);
>> +
>> +	instruction_pointer(regs) = addr + disp;
>> +}
>> +
>> +void __kprobes
>> +simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs)
>> +{
>> +	int xn = (opcode >> 5) & 0x1f;
>> +
>> +	/* Link register is x30 */
>> +	if (((opcode >> 21) & 0x3) == 1)
>> +		regs->regs[30] = addr + 4;
>> +
>> +	instruction_pointer(regs) = regs->regs[xn];
>> +}
>> +
>> +void __kprobes
>> +simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs)
>> +{
>> +	int disp = 4;
>> +
>> +	if (opcode & (1 << 24)) {
>> +		if (check_cbnz(opcode, regs))
>> +			disp = cbz_displacement(opcode);
>> +	} else {
>> +		if (check_cbz(opcode, regs))
>> +			disp = cbz_displacement(opcode);
>> +	}
>> +	instruction_pointer(regs) = addr + disp;
>> +}
>> +
>> +void __kprobes
>> +simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs)
>> +{
>> +	int disp = 4;
>> +
>> +	if (opcode & (1 << 24)) {
>> +		if (check_tbnz(opcode, regs))
>> +			disp = tbz_displacement(opcode);
>> +	} else {
>> +		if (check_tbz(opcode, regs))
>> +			disp = tbz_displacement(opcode);
>> +	}
>> +	instruction_pointer(regs) = addr + disp;
>> +}
>> +
>> +void __kprobes
>> +simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs)
>> +{
>> +	u64 *load_addr;
>> +	int xn = opcode & 0x1f;
>> +	int disp = ldr_displacement(opcode);
>> +
>> +	load_addr = (u64 *) (addr + disp);
>> +
>> +	if (opcode & (1 << 30))	/* x0-x31 */
>> +		regs->regs[xn] = *load_addr;
>> +	else			/* w0-w31 */
>> +		*(u32 *) (&regs->regs[xn]) = (*(u32 *) (load_addr));
>> +
>> +	instruction_pointer(regs) += 4;
>> +}
>> +
>> +void __kprobes
>> +simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
>> +{
>> +	s32 *load_addr;
>> +	int xn = opcode & 0x1f;
>> +	int disp = ldr_displacement(opcode);
>> +
>> +	load_addr = (s32 *) (addr + disp);
>> +	regs->regs[xn] = *load_addr;
>> +
>> +	instruction_pointer(regs) += 4;
>> +}
>> diff --git a/arch/arm64/kernel/probes-simulate-insn.h b/arch/arm64/kernel/probes-simulate-insn.h
>> new file mode 100644
>> index 0000000..337384e
>> --- /dev/null
>> +++ b/arch/arm64/kernel/probes-simulate-insn.h
>> @@ -0,0 +1,30 @@
>> +/*
>> + * arch/arm64/kernel/probes-simulate-insn.h
>> + *
>> + * Copyright (C) 2013 Linaro Limited
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + */
>> +
>> +#ifndef _ARM_KERNEL_PROBES_SIMULATE_INSN_H
>> +#define _ARM_KERNEL_PROBES_SIMULATE_INSN_H
>> +
>> +extern pstate_check_t * const opcode_condition_checks[16];
>> +
>> +void simulate_adr_adrp(u32 opcode, long addr, struct pt_regs *regs);
>> +void simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs);
>> +void simulate_b_cond(u32 opcode, long addr, struct pt_regs *regs);
>> +void simulate_br_blr_ret(u32 opcode, long addr, struct pt_regs *regs);
>> +void simulate_cbz_cbnz(u32 opcode, long addr, struct pt_regs *regs);
>> +void simulate_tbz_tbnz(u32 opcode, long addr, struct pt_regs *regs);
>> +void simulate_ldr_literal(u32 opcode, long addr, struct pt_regs *regs);
>> +void simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs);
>> +
>> +#endif /* _ARM_KERNEL_PROBES_SIMULATE_INSN_H */
>>
>
> Thanks,
>
> 	M.
>

Thanks for the review.

-dl
