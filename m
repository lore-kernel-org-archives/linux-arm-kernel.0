From: dave.long@linaro.org (David Long)
Date: Mon, 13 Jun 2016 00:10:29 -0400
Subject: [PATCH v13 05/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160608100714.4abbcebcf356eb72173d0ce3@kernel.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
 <1464924384-15269-6-git-send-email-dave.long@linaro.org>
 <20160608100714.4abbcebcf356eb72173d0ce3@kernel.org>
Message-ID: <575E3235.1020904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2016 09:07 PM, Masami Hiramatsu wrote:
> On Thu,  2 Jun 2016 23:26:19 -0400
> David Long <dave.long@linaro.org> wrote:
>
>> From: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>>
>> Add support for basic kernel probes(kprobes) and jump probes
>> (jprobes) for ARM64.
>>
>> Kprobes utilizes software breakpoint and single step debug
>> exceptions supported on ARM v8.
>>
>> A software breakpoint is placed at the probe address to trap the
>> kernel execution into the kprobe handler.
>>
>> ARM v8 supports enabling single stepping before the break exception
>> return (ERET), with next PC in exception return address (ELR_EL1). The
>> kprobe handler prepares an executable memory slot for out-of-line
>> execution with a copy of the original instruction being probed, and
>> enables single stepping. The PC is set to the out-of-line slot address
>> before the ERET. With this scheme, the instruction is executed with the
>> exact same register context except for the PC (and DAIF) registers.
>>
>> Debug mask (PSTATE.D) is enabled only when single stepping a recursive
>> kprobe, e.g.: during kprobes reenter so that probed instruction can be
>> single stepped within the kprobe handler -exception- context.
>> The recursion depth of kprobe is always 2, i.e. upon probe re-entry,
>> any further re-entry is prevented by not calling handlers and the case
>> counted as a missed kprobe).
>>
>> Single stepping from the x-o-l slot has a drawback for PC-relative accesses
>> like branching and symbolic literals access as the offset from the new PC
>> (slot address) may not be ensured to fit in the immediate value of
>> the opcode. Such instructions need simulation, so reject
>> probing them.
>>
>> Instructions generating exceptions or cpu mode change are rejected
>> for probing.
>>
>> Exclusive load/store instructions are rejected too.  Additionally, the
>> code is checked to see if it is inside an exclusive load/store sequence
>> (code from Pratyush).
>>
>> System instructions are mostly enabled for stepping, except MSR/MRS
>> accesses to "DAIF" flags in PSTATE, which are not safe for
>> probing.
>>
>> Thanks to Steve Capper and Pratyush Anand for several suggested
>> Changes.
>
> Basically looks good to me.
> I have some trivial comments.
>
>>
>> Signed-off-by: Sandeepa Prabhu <sandeepa.s.prabhu@gmail.com>
>> Signed-off-by: David A. Long <dave.long@linaro.org>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>>   arch/arm64/Kconfig                      |   1 +
>>   arch/arm64/include/asm/debug-monitors.h |   5 +
>>   arch/arm64/include/asm/insn.h           |   4 +-
>>   arch/arm64/include/asm/kprobes.h        |  60 ++++
>>   arch/arm64/include/asm/probes.h         |  44 +++
>>   arch/arm64/kernel/Makefile              |   1 +
>>   arch/arm64/kernel/debug-monitors.c      |  18 +-
>>   arch/arm64/kernel/kprobes-arm64.c       | 144 +++++++++
>>   arch/arm64/kernel/kprobes-arm64.h       |  35 +++
>>   arch/arm64/kernel/kprobes.c             | 526 ++++++++++++++++++++++++++++++++
>
> Not sure why kprobes.c and kprobes-arm64.c are splitted.
>
>

This comes from the model of the arm32 kprobes code where handling of 
the low-level instruction simulation is implemented in separate files 
for 32-bit vs. thumb instructions.  It should make a little more sense 
in the future when additional instruction simulation code will hopefully 
be added for those instructions we cannot currently single-step 
out-of-line.  It also probably *could* be merged into one file.

>>   arch/arm64/kernel/vmlinux.lds.S         |   1 +
>>   arch/arm64/mm/fault.c                   |  27 +-
>>   12 files changed, 861 insertions(+), 5 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/kprobes.h
>>   create mode 100644 arch/arm64/include/asm/probes.h
>>   create mode 100644 arch/arm64/kernel/kprobes-arm64.c
>>   create mode 100644 arch/arm64/kernel/kprobes-arm64.h
>>   create mode 100644 arch/arm64/kernel/kprobes.c
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 0f7a624..5496b75 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -88,6 +88,7 @@ config ARM64
>>   	select HAVE_REGS_AND_STACK_ACCESS_API
>>   	select HAVE_RCU_TABLE_FREE
>>   	select HAVE_SYSCALL_TRACEPOINTS
>> +	select HAVE_KPROBES
>>   	select IOMMU_DMA if IOMMU_SUPPORT
>>   	select IRQ_DOMAIN
>>   	select IRQ_FORCED_THREADING
>> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
>> index 2fcb9b7..4b6b3f7 100644
>> --- a/arch/arm64/include/asm/debug-monitors.h
>> +++ b/arch/arm64/include/asm/debug-monitors.h
>> @@ -66,6 +66,11 @@
>>
>>   #define CACHE_FLUSH_IS_SAFE		1
>>
>> +/* kprobes BRK opcodes with ESR encoding  */
>> +#define BRK64_ESR_MASK		0xFFFF
>> +#define BRK64_ESR_KPROBES	0x0004
>> +#define BRK64_OPCODE_KPROBES	(AARCH64_BREAK_MON | (BRK64_ESR_KPROBES << 5))
>> +
>>   /* AArch32 */
>>   #define DBG_ESR_EVT_BKPT	0x4
>>   #define DBG_ESR_EVT_VECC	0x5
>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index 98e4edd..be2d2b9 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -253,6 +253,8 @@ __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
>>   __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
>>   __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
>>   __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
>> +__AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
>> +__AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
>>   __AARCH64_INSN_FUNCS(stp_post,	0x7FC00000, 0x28800000)
>>   __AARCH64_INSN_FUNCS(ldp_post,	0x7FC00000, 0x28C00000)
>>   __AARCH64_INSN_FUNCS(stp_pre,	0x7FC00000, 0x29800000)
>> @@ -402,7 +404,7 @@ bool aarch32_insn_is_wide(u32 insn);
>>   #define A32_RT_OFFSET	12
>>   #define A32_RT2_OFFSET	 0
>>
>> -u32 aarch64_extract_system_register(u32 insn);
>> +u32 aarch64_insn_extract_system_reg(u32 insn);
>>   u32 aarch32_insn_extract_reg_num(u32 insn, int offset);
>>   u32 aarch32_insn_mcr_extract_opc2(u32 insn);
>>   u32 aarch32_insn_mcr_extract_crm(u32 insn);
>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>> new file mode 100644
>> index 0000000..79c9511
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/kprobes.h
>> @@ -0,0 +1,60 @@
>> +/*
>> + * arch/arm64/include/asm/kprobes.h
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
>> +#ifndef _ARM_KPROBES_H
>> +#define _ARM_KPROBES_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/ptrace.h>
>> +#include <linux/percpu.h>
>> +
>> +#define __ARCH_WANT_KPROBES_INSN_SLOT
>> +#define MAX_INSN_SIZE			1
>> +#define MAX_STACK_SIZE			128
>> +
>> +#define flush_insn_slot(p)		do { } while (0)
>> +#define kretprobe_blacklist_size	0
>> +
>> +#include <asm/probes.h>
>> +
>> +struct prev_kprobe {
>> +	struct kprobe *kp;
>> +	unsigned int status;
>> +};
>> +
>> +/* Single step context for kprobe */
>> +struct kprobe_step_ctx {
>> +	unsigned long ss_pending;
>> +	unsigned long match_addr;
>> +};
>> +
>> +/* per-cpu kprobe control block */
>> +struct kprobe_ctlblk {
>> +	unsigned int kprobe_status;
>> +	unsigned long saved_irqflag;
>> +	struct prev_kprobe prev_kprobe;
>> +	struct kprobe_step_ctx ss_ctx;
>> +	struct pt_regs jprobe_saved_regs;
>> +	char jprobes_stack[MAX_STACK_SIZE];
>> +};
>> +
>> +void arch_remove_kprobe(struct kprobe *);
>> +int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
>> +int kprobe_exceptions_notify(struct notifier_block *self,
>> +			     unsigned long val, void *data);
>> +int kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr);
>> +int kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr);
>> +
>> +#endif /* _ARM_KPROBES_H */
>> diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
>> new file mode 100644
>> index 0000000..c5fcbe6
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/probes.h
>> @@ -0,0 +1,44 @@
>> +/*
>> + * arch/arm64/include/asm/probes.h
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
>> +#ifndef _ARM_PROBES_H
>> +#define _ARM_PROBES_H
>> +
>> +struct kprobe;
>> +struct arch_specific_insn;
>> +
>> +typedef u32 kprobe_opcode_t;
>> +typedef unsigned long (kprobes_pstate_check_t)(unsigned long);
>> +typedef void (kprobes_handler_t) (u32 opcode, long addr, struct pt_regs *);
>> +
>> +enum pc_restore_type {
>> +	NO_RESTORE,
>> +	RESTORE_PC,
>> +};
>> +
>> +struct kprobe_pc_restore {
>> +	enum pc_restore_type type;
>> +	unsigned long addr;
>> +};
>
> These seems overcoding. You just need "unsigned long restore_pc"
> and if it is 0, skip it :)
>

I see your point.  I've made this change.

>> +
>> +/* architecture specific copy of original instruction */
>> +struct arch_specific_insn {
>> +	kprobe_opcode_t *insn;
>> +	kprobes_pstate_check_t *pstate_cc;
>> +	kprobes_handler_t *handler;
>> +	/* restore address after step xol */
>> +	struct kprobe_pc_restore restore;
>> +};
>> +
>> +#endif
>> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
>> index 4653aca..d78ed62 100644
>> --- a/arch/arm64/kernel/Makefile
>> +++ b/arch/arm64/kernel/Makefile
>> @@ -37,6 +37,7 @@ arm64-obj-$(CONFIG_CPU_PM)		+= sleep.o suspend.o
>>   arm64-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>>   arm64-obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
>>   arm64-obj-$(CONFIG_KGDB)		+= kgdb.o
>> +arm64-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-arm64.o
>>   arm64-obj-$(CONFIG_EFI)			+= efi.o efi-entry.stub.o
>>   arm64-obj-$(CONFIG_PCI)			+= pci.o
>>   arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
>> diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
>> index 65ee636..fcedced 100644
>> --- a/arch/arm64/kernel/debug-monitors.c
>> +++ b/arch/arm64/kernel/debug-monitors.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/init.h>
>>   #include <linux/kprobes.h>
>>   #include <linux/ptrace.h>
>> +#include <linux/kprobes.h>
>>   #include <linux/stat.h>
>>   #include <linux/uaccess.h>
>>
>> @@ -274,10 +275,14 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
>>   		 */
>>   		user_rewind_single_step(current);
>>   	} else {
>> +#ifdef	CONFIG_KPROBES
>> +		if (kprobe_single_step_handler(regs, esr) == DBG_HOOK_HANDLED)
>> +			return 0;
>> +#endif
>>   		if (call_step_hook(regs, esr) == DBG_HOOK_HANDLED)
>>   			return 0;
>>
>> -		pr_warning("Unexpected kernel single-step exception at EL1\n");
>> +		pr_warn("Unexpected kernel single-step exception at EL1\n");
>
> This change would better be splitted, anyway, it depends on the maintainer
> of this file (Will and Catalin?)
>

I've removed this cleanup from this patch set.

>>   		/*
>>   		 * Re-enable stepping since we know that we will be
>>   		 * returning to regs.
>> @@ -332,8 +337,15 @@ static int brk_handler(unsigned long addr, unsigned int esr,
>>   {
>>   	if (user_mode(regs)) {
>>   		send_user_sigtrap(TRAP_BRKPT);
>> -	} else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
>> -		pr_warning("Unexpected kernel BRK exception at EL1\n");
>> +	}
>> +#ifdef	CONFIG_KPROBES
>> +	else if ((esr & BRK64_ESR_MASK) == BRK64_ESR_KPROBES) {
>> +		if (kprobe_breakpoint_handler(regs, esr) != DBG_HOOK_HANDLED)
>> +			return -EFAULT;
>> +	}
>> +#endif
>> +	else if (call_break_hook(regs, esr) != DBG_HOOK_HANDLED) {
>> +		pr_warn("Unexpected kernel BRK exception at EL1\n");
>>   		return -EFAULT;
>>   	}
>>
>> diff --git a/arch/arm64/kernel/kprobes-arm64.c b/arch/arm64/kernel/kprobes-arm64.c
>> new file mode 100644
>> index 0000000..0af5d94
>> --- /dev/null
>> +++ b/arch/arm64/kernel/kprobes-arm64.c
>> @@ -0,0 +1,144 @@
>> +/*
>> + * arch/arm64/kernel/kprobes-arm64.c
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
>> +#include <asm/kprobes.h>
>> +#include <asm/insn.h>
>> +#include <asm/sections.h>
>> +
>> +#include "kprobes-arm64.h"
>> +
>> +static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>> +{
>> +	/*
>> +	 * Branch instructions will write a new value into the PC which is
>> +	 * likely to be relative to the XOL address and therefore invalid.
>> +	 * Deliberate generation of an exception during stepping is also not
>> +	 * currently safe. Lastly, MSR instructions can do any number of nasty
>> +	 * things we can't handle during single-stepping.
>> +	 */
>> +	if (aarch64_get_insn_class(insn) == AARCH64_INSN_CLS_BR_SYS) {
>> +		if (aarch64_insn_is_branch(insn) ||
>> +		    aarch64_insn_is_msr_imm(insn) ||
>> +		    aarch64_insn_is_msr_reg(insn) ||
>> +		    aarch64_insn_is_exception(insn) ||
>> +		    aarch64_insn_is_eret(insn))
>> +			return false;
>> +
>> +		/*
>> +		 * The MRS instruction may not return a correct value when
>> +		 * executing in the single-stepping environment. We do make one
>> +		 * exception, for reading the DAIF bits.
>> +		 */
>> +		if (aarch64_insn_is_mrs(insn))
>> +			return aarch64_insn_extract_system_reg(insn)
>> +			     != AARCH64_INSN_SPCLREG_DAIF;
>> +
>> +		/*
>> +		 * The HINT instruction is is problematic when single-stepping,
>> +		 * except for the NOP case.
>> +		 */
>> +		if (aarch64_insn_is_hint(insn))
>> +			return aarch64_insn_is_nop(insn);
>> +
>> +		return true;
>> +	}
>> +
>> +	/*
>> +	 * Instructions which load PC relative literals are not going to work
>> +	 * when executed from an XOL slot. Instructions doing an exclusive
>> +	 * load/store are not going to complete successfully when single-step
>> +	 * exception handling happens in the middle of the sequence.
>> +	 */
>> +	if (aarch64_insn_uses_literal(insn) ||
>> +	    aarch64_insn_is_exclusive(insn))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +/* Return:
>> + *   INSN_REJECTED     If instruction is one not allowed to kprobe,
>> + *   INSN_GOOD         If instruction is supported and uses instruction slot,
>> + *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
>
> Is there any chance to return INSN_GOOD_NO_SLOT?
>

Ah, that gets used later when simulation support is added.  I've removed 
this enum value from this commit and will add it to the later one. 
Please no one complain about using an enum instead of a bool, it will 
eventually have three possible values.

>> + */
>> +static enum kprobe_insn __kprobes
>> +arm_probe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi)
>> +{
>> +	/*
>> +	 * Instructions reading or modifying the PC won't work from the XOL
>> +	 * slot.
>> +	 */
>> +	if (aarch64_insn_is_steppable(insn))
>> +		return INSN_GOOD;
>> +	else
>> +		return INSN_REJECTED;
>> +}
>> +
>> +static bool __kprobes
>> +is_probed_address_atomic(kprobe_opcode_t *scan_start, kprobe_opcode_t *scan_end)
>> +{
>> +	while (scan_start > scan_end) {
>> +		/*
>> +		 * atomic region starts from exclusive load and ends with
>> +		 * exclusive store.
>> +		 */
>> +		if (aarch64_insn_is_store_ex(le32_to_cpu(*scan_start)))
>> +			return false;
>> +		else if (aarch64_insn_is_load_ex(le32_to_cpu(*scan_start)))
>> +			return true;
>> +		scan_start--;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +enum kprobe_insn __kprobes
>> +arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
>> +{
>> +	enum kprobe_insn decoded;
>> +	kprobe_opcode_t insn = le32_to_cpu(*addr);
>> +	kprobe_opcode_t *scan_start = addr - 1;
>> +	kprobe_opcode_t *scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
>> +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
>> +	struct module *mod;
>> +#endif
>> +
>> +	if (addr >= (kprobe_opcode_t *)_text &&
>> +	    scan_end < (kprobe_opcode_t *)_text)
>> +		scan_end = (kprobe_opcode_t *)_text;
>> +#if defined(CONFIG_MODULES) && defined(MODULES_VADDR)
>> +	else {
>> +		preempt_disable();
>> +		mod = __module_address((unsigned long)addr);
>> +		if (mod && within_module_init((unsigned long)addr, mod) &&
>> +			!within_module_init((unsigned long)scan_end, mod))
>> +			scan_end = (kprobe_opcode_t *)mod->init_layout.base;
>> +		else if (mod && within_module_core((unsigned long)addr, mod) &&
>> +			!within_module_core((unsigned long)scan_end, mod))
>> +			scan_end = (kprobe_opcode_t *)mod->core_layout.base;
>
> What happen if mod == NULL? it should be return error, isn't it?
>

No, it should be fine.  It just means it didn't have to do either of the 
extra checks to limit the end of the search through the code to the 
boundary of one of the corresponding module text sections. It means the 
instruction is in the regular kernel (non-module) text segment.

>> +		preempt_enable();
>> +	}
>> +#endif
>> +	decoded = arm_probe_decode_insn(insn, asi);
>> +
>> +	if (decoded == INSN_REJECTED ||
>> +			is_probed_address_atomic(scan_start, scan_end))
>> +		return INSN_REJECTED;
>> +
>> +	return decoded;
>> +}
>
> Thank you,
>

Thanks,
-dl
