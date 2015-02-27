From: dave.long@linaro.org (David Long)
Date: Fri, 27 Feb 2015 01:38:25 -0500
Subject: [PATCH v5 3/6] arm64: Kprobes with single stepping support
In-Reply-To: <54E4A8E7.2050708@hitachi.com>
References: <1424214701-4899-1-git-send-email-dave.long@linaro.org>
 <1424214701-4899-4-git-send-email-dave.long@linaro.org>
 <54E4A8E7.2050708@hitachi.com>
Message-ID: <54F010E1.2020106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/15 09:59, Masami Hiramatsu wrote:
> Hi,
> 
> (2015/02/18 8:11), David Long wrote:
>> From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>>
>> Add support for basic kernel probes(kprobes) and jump probes
>> (jprobes) for ARM64.
>>
>> Kprobes will utilize software breakpoint and single step debug
>> exceptions supported on ARM v8.
>>
>> Software breakpoint is placed at the probe address to trap the
>> kernel execution into kprobe handler.
>>
>> ARM v8 supports single stepping to be enabled while exception return
>> (ERET) with next PC in exception return address (ELR_EL1). The
>> kprobe handler prepares an executable memory slot for out-of-line
>> execution with a copy of the original instruction being probed, and
>> enables single stepping from the instruction slot. With this scheme,
>> the instruction is executed with the exact same register context
>> 'except PC' that points to instruction slot.
>>
>> Debug mask(PSTATE.D) is enabled only when single stepping a recursive
> 
> Is that same as "debug flag" in the code commment?
> 

Yes. The description in the commit might benefit from a little rewording.

>> kprobe, e.g.: during kprobes reenter so that probed instruction can be
>> single stepped within the kprobe handler -exception- context.
>> The recursion depth of kprobe is always 2, i.e. upon probe re-entry,
>> any further re-entry is prevented by not calling handlers and the case
>> counted as a missed kprobe).
> 
> So, would this mean the debug mask is required for single-stepping
> in exception context by specification?
> 

Not positive I exactly understand the question but:

1) We can't single-step at all until we've both set the SS mode bit
(PSTATE.SS) and unmasked debug exceptions (PSTATE.D).  The debug
exception is normally masked.
2) PSTATE.D will be set at exception entry.
3) We can't single-step again until we RTE from the current single-step.

>>
>> Single stepping from slot has a drawback on PC-relative accesses
>> like branching and symbolic literals access as offset from new PC
>> (slot address) may not be ensured to fit in immediate value of
>> opcode. Such instructions needs simulation, so reject
>> probing such instructions.
> 
> BTW, since while the single stepping IRQs are disabled, does that
> also requires fixups for irq-mask loading instruction or something
> like that? (sorry, I'm not good at aarch64 ISA...)

No, we disable interrupts and reject probing of the special instructions
that could reenable them *or* read the current status (since the
single-step environment will likely see a different value for that bit).
 In previous patches I did not reject the reading of this bit.

> 
>> Instructions generating exceptions or cpu mode change are rejected,
>> and not allowed to insert probe for these instructions.
>>
>> Instructions using Exclusive Monitor are rejected too.
>>
>> System instructions are mostly enabled for stepping, except MSR
>> immediate that updates "daif" flags in PSTATE, which are not safe
>> for probing.
>>
>> Thanks to Steve Capper and Pratyush Anand for several suggested
>> Changes.
> 
> Ok, I have some comments on the code.
> 
> [...]
>> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
>> new file mode 100644
>> index 0000000..1ead41f
>> --- /dev/null
>> +++ b/arch/arm64/kernel/kprobes.c
>> @@ -0,0 +1,551 @@
>> +/*
>> + * arch/arm64/kernel/kprobes.c
>> + *
>> + * Kprobes support for ARM64
>> + *
>> + * Copyright (C) 2013 Linaro Limited.
>> + * Author: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> + * General Public License for more details.
>> + *
>> + */
>> +#include <linux/kernel.h>
>> +#include <linux/kprobes.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/stop_machine.h>
>> +#include <linux/stringify.h>
>> +#include <asm/traps.h>
>> +#include <asm/ptrace.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/debug-monitors.h>
>> +#include <asm/system_misc.h>
>> +#include <asm/insn.h>
>> +
>> +#include "kprobes.h"
>> +#include "kprobes-arm64.h"
>> +
>> +#define MIN_STACK_SIZE(addr)	min((unsigned long)MAX_STACK_SIZE,	\
>> +	(unsigned long)current_thread_info() + THREAD_START_SP - (addr))
>> +
>> +DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>> +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>> +
>> +static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
>> +{
>> +	/* prepare insn slot */
>> +	p->ainsn.insn[0] = p->opcode;
>> +
>> +	flush_icache_range((uintptr_t) (p->ainsn.insn),
>> +			   (uintptr_t) (p->ainsn.insn) + MAX_INSN_SIZE);
>> +
>> +	/*
>> +	 * Needs restoring of return address after stepping xol.
>> +	 */
>> +	p->ainsn.restore.addr = (unsigned long) p->addr +
>> +	  sizeof(kprobe_opcode_t);
>> +	p->ainsn.restore.type = RESTORE_PC;
>> +}
>> +
>> +int __kprobes arch_prepare_kprobe(struct kprobe *p)
>> +{
>> +	kprobe_opcode_t insn;
>> +	unsigned long probe_addr = (unsigned long)p->addr;
>> +
>> +	/* copy instruction */
>> +	insn = *p->addr;
>> +	p->opcode = insn;
>> +
>> +	if (in_exception_text(probe_addr))
>> +		return -EINVAL;
>> +
>> +	/* decode instruction */
>> +	switch (arm_kprobe_decode_insn(insn, &p->ainsn)) {
>> +	case INSN_REJECTED:	/* insn not supported */
>> +		return -EINVAL;
>> +
>> +	case INSN_GOOD_NO_SLOT:	/* insn need simulation */
>> +		return -EINVAL;
>> +
>> +	case INSN_GOOD:	/* instruction uses slot */
>> +		p->ainsn.insn = get_insn_slot();
>> +		if (!p->ainsn.insn)
>> +			return -ENOMEM;
>> +		break;
>> +	};
>> +
>> +	/* prepare the instruction */
>> +	arch_prepare_ss_slot(p);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __kprobes patch_text(kprobe_opcode_t *addr, u32 opcode)
>> +{
>> +	void *addrs[1];
>> +	u32 insns[1];
>> +
>> +	addrs[0] = (void *)addr;
>> +	insns[0] = (u32)opcode;
>> +
>> +	return aarch64_insn_patch_text_sync(addrs, insns, 1);
>> +}
>> +
>> +/* arm kprobe: install breakpoint in text */
>> +void __kprobes arch_arm_kprobe(struct kprobe *p)
>> +{
>> +	patch_text(p->addr, BRK64_OPCODE_KPROBES);
>> +}
>> +
>> +/* disarm kprobe: remove breakpoint from text */
>> +void __kprobes arch_disarm_kprobe(struct kprobe *p)
>> +{
>> +	patch_text(p->addr, p->opcode);
>> +}
>> +
>> +void __kprobes arch_remove_kprobe(struct kprobe *p)
>> +{
>> +	if (p->ainsn.insn) {
>> +		free_insn_slot(p->ainsn.insn, 0);
>> +		p->ainsn.insn = NULL;
>> +	}
>> +}
>> +
>> +static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
>> +{
>> +	kcb->prev_kprobe.kp = kprobe_running();
>> +	kcb->prev_kprobe.status = kcb->kprobe_status;
>> +}
>> +
>> +static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
>> +{
>> +	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
>> +	kcb->kprobe_status = kcb->prev_kprobe.status;
>> +}
>> +
>> +static void __kprobes set_current_kprobe(struct kprobe *p)
>> +{
>> +	__this_cpu_write(current_kprobe, p);
>> +}
>> +
>> +/*
>> + * Debug flag (D-flag) is disabled upon exception entry.
>> + * Kprobes need to unmask D-flag -ONLY- in case of recursive
>> + * probe i.e. when probe hit from kprobe handler context upon
>> + * executing the pre/post handlers. In this case we return with
>> + * D-flag unmasked so that single-stepping can be carried-out.
>> + *
>> + * Keep D-flag masked in all other cases.
> 
> Here, we'd better choose D-flag or Debug mask.
> 

"Debug Mask" and "Debug exception mask" seems to be what the ARM calls
it.  I can change it to "Debug Mask".

>> + */
>> +static void __kprobes
>> +spsr_set_debug_flag(struct pt_regs *regs, int mask)
>> +{
>> +	unsigned long spsr = regs->pstate;
>> +
>> +	if (mask)
>> +		spsr |= PSR_D_BIT;
>> +	else
>> +		spsr &= ~PSR_D_BIT;
>> +
>> +	regs->pstate = spsr;
>> +}
>> +
>> +/*
>> + * Interrupts need to be disabled before single-step mode is set, and not
>> + * reenabled until after single-step mode ends.
>> + * Without disabling interrupt on local CPU, there is a chance of
>> + * interrupt occurrence in the period of exception return and  start of
>> + * out-of-line single-step, that result in wrongly single stepping
>> + * the interrupt handler.
>> + */
>> +static void __kprobes kprobes_save_local_irqflag(struct pt_regs *regs)
>> +{
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +	kcb->saved_irqflag = regs->pstate;
>> +	regs->pstate |= PSR_I_BIT;
>> +}
>> +
>> +static void __kprobes kprobes_restore_local_irqflag(struct pt_regs *regs)
>> +{
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +	if (kcb->saved_irqflag & PSR_I_BIT)
>> +		regs->pstate |= PSR_I_BIT;
>> +	else
>> +		regs->pstate &= ~PSR_I_BIT;
>> +}
>> +
>> +static void __kprobes
>> +set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
>> +{
>> +	kcb->ss_ctx.ss_status = KPROBES_STEP_PENDING;
>> +	kcb->ss_ctx.match_addr = addr + sizeof(kprobe_opcode_t);
>> +}
>> +
>> +static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
>> +{
>> +	kcb->ss_ctx.ss_status = KPROBES_STEP_NONE;
>> +	kcb->ss_ctx.match_addr = 0;
>> +}
>> +
>> +static void __kprobes
>> +skip_singlestep_missed(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
>> +{
>> +	/* set return addr to next pc to continue */
>> +	instruction_pointer(regs) += sizeof(kprobe_opcode_t);
>> +}
>> +
>> +static void __kprobes setup_singlestep(struct kprobe *p,
>> +				       struct pt_regs *regs,
>> +				       struct kprobe_ctlblk *kcb, int reenter)
>> +{
>> +	unsigned long slot;
>> +
>> +	if (reenter) {
>> +		save_previous_kprobe(kcb);
>> +		set_current_kprobe(p);
>> +		kcb->kprobe_status = KPROBE_REENTER;
>> +	} else {
>> +		kcb->kprobe_status = KPROBE_HIT_SS;
>> +	}
>> +
>> +	if (p->ainsn.insn) {
>> +		/* prepare for single stepping */
>> +		slot = (unsigned long)p->ainsn.insn;
>> +
>> +		set_ss_context(kcb, slot);	/* mark pending ss */
>> +
>> +		if (kcb->kprobe_status == KPROBE_REENTER)
>> +			spsr_set_debug_flag(regs, 0);
>> +
>> +		/* IRQs and single stepping do not mix well. */
>> +		kprobes_save_local_irqflag(regs);
>> +		kernel_enable_single_step(regs);
>> +		instruction_pointer(regs) = slot;
>> +	} else	{
>> +		BUG();
>> +	}
>> +}
>> +
>> +static int __kprobes reenter_kprobe(struct kprobe *p,
>> +				    struct pt_regs *regs,
>> +				    struct kprobe_ctlblk *kcb)
>> +{
>> +	switch (kcb->kprobe_status) {
>> +	case KPROBE_HIT_SSDONE:
>> +	case KPROBE_HIT_ACTIVE:
>> +		if (!p->ainsn.check_condn || p->ainsn.check_condn(p, regs)) {
>> +			kprobes_inc_nmissed_count(p);
>> +			setup_singlestep(p, regs, kcb, 1);
>> +		} else	{
>> +			/* condition check failed, skip stepping */
>> +			skip_singlestep_missed(kcb, regs);
>> +		}
>> +		break;
>> +	case KPROBE_HIT_SS:
> 
> Here, KPROBE_REENTER should be needed.

Yes.

> And also, do we really need to fail when KPROBE_HIT_SS case?
> On x86, I've fixed similar code, since kprobes can hit in single stepping
> if we put a handler in perf and it can be hit in NMI context, which
> happens on single-stepping...
> 

Pratyush at Red Hat has been trying to deal with this for uprobes and
the best information we have from ARM is that you can't single-step
while processing a single-step exception.

>> +		pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
>> +		dump_kprobe(p);
>> +		BUG();
>> +		break;
>> +	default:
>> +		WARN_ON(1);
>> +		return 0;
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +static void __kprobes
>> +post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
>> +{
>> +	struct kprobe *cur = kprobe_running();
>> +
>> +	if (!cur)
>> +		return;
>> +
>> +	/* return addr restore if non-branching insn */
>> +	if (cur->ainsn.restore.type == RESTORE_PC) {
>> +		instruction_pointer(regs) = cur->ainsn.restore.addr;
>> +		if (!instruction_pointer(regs))
>> +			BUG();
>> +	}
>> +
>> +	/* restore back original saved kprobe variables and continue */
>> +	if (kcb->kprobe_status == KPROBE_REENTER) {
>> +		restore_previous_kprobe(kcb);
>> +		return;
>> +	}
>> +	/* call post handler */
>> +	kcb->kprobe_status = KPROBE_HIT_SSDONE;
>> +	if (cur->post_handler)	{
>> +		/* post_handler can hit breakpoint and single step
>> +		 * again, so we enable D-flag for recursive exception.
>> +		 */
>> +		cur->post_handler(cur, regs, 0);
>> +	}
>> +
>> +	reset_current_kprobe();
>> +}
>> +
>> +int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
>> +{
>> +	struct kprobe *cur = kprobe_running();
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +	switch (kcb->kprobe_status) {
>> +	case KPROBE_HIT_SS:
>> +	case KPROBE_REENTER:
>> +		/*
>> +		 * We are here because the instruction being single
>> +		 * stepped caused a page fault. We reset the current
>> +		 * kprobe and the ip points back to the probe address
>> +		 * and allow the page fault handler to continue as a
>> +		 * normal page fault.
>> +		 */
>> +		instruction_pointer(regs) = (unsigned long)cur->addr;
>> +		if (!instruction_pointer(regs))
>> +			BUG();
>> +		if (kcb->kprobe_status == KPROBE_REENTER)
>> +			restore_previous_kprobe(kcb);
>> +		else
>> +			reset_current_kprobe();
>> +
>> +		break;
>> +	case KPROBE_HIT_ACTIVE:
>> +	case KPROBE_HIT_SSDONE:
>> +		/*
>> +		 * We increment the nmissed count for accounting,
>> +		 * we can also use npre/npostfault count for accounting
>> +		 * these specific fault cases.
>> +		 */
>> +		kprobes_inc_nmissed_count(cur);
>> +
>> +		/*
>> +		 * We come here because instructions in the pre/post
>> +		 * handler caused the page_fault, this could happen
>> +		 * if handler tries to access user space by
>> +		 * copy_from_user(), get_user() etc. Let the
>> +		 * user-specified handler try to fix it first.
>> +		 */
>> +		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
>> +			return 1;
>> +
>> +		/*
>> +		 * In case the user-specified fault handler returned
>> +		 * zero, try to fix up.
>> +		 */
>> +		if (fixup_exception(regs))
>> +			return 1;
>> +
>> +		break;
>> +	}
>> +	return 0;
>> +}
>> +
>> +int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>> +				       unsigned long val, void *data)
>> +{
>> +	return NOTIFY_DONE;
>> +}
>> +
>> +void __kprobes kprobe_handler(struct pt_regs *regs)
>> +{
>> +	struct kprobe *p, *cur;
>> +	struct kprobe_ctlblk *kcb;
>> +	unsigned long addr = instruction_pointer(regs);
>> +
>> +	kcb = get_kprobe_ctlblk();
>> +	cur = kprobe_running();
>> +
>> +	p = get_kprobe((kprobe_opcode_t *) addr);
> 
> BTW, I'd like to ensure that this handler runs under normal irqs are disabled.
> Or, we need preempt_disable() here.
> # From the same reason, x86 implementation is a bit odd...

The setup_singlestep() call in there will disable irq's before stepping.
 Is there something else in there that worries you?

> 
>> +
>> +	if (p) {
>> +		if (cur) {
>> +			if (reenter_kprobe(p, regs, kcb))
>> +				return;
>> +		} else if (!p->ainsn.check_condn ||
>> +			   p->ainsn.check_condn(p, regs)) {
>> +			/* Probe hit and conditional execution check ok. */
>> +			set_current_kprobe(p);
>> +			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>> +
>> +			/*
>> +			 * If we have no pre-handler or it returned 0, we
>> +			 * continue with normal processing.  If we have a
>> +			 * pre-handler and it returned non-zero, it prepped
>> +			 * for calling the break_handler below on re-entry,
>> +			 * so get out doing nothing more here.
>> +			 *
>> +			 * pre_handler can hit a breakpoint and can step thru
>> +			 * before return, keep PSTATE D-flag enabled until
>> +			 * pre_handler return back.
>> +			 */
>> +			if (!p->pre_handler || !p->pre_handler(p, regs)) {
>> +				kcb->kprobe_status = KPROBE_HIT_SS;
>> +				setup_singlestep(p, regs, kcb, 0);
>> +				return;
>> +			}
>> +		} else {
>> +			/*
>> +			 * Breakpoint hit but conditional check failed,
>> +			 * so just skip the instruction (NOP behaviour)
>> +			 */
>> +			skip_singlestep_missed(kcb, regs);
>> +			return;
>> +		}
>> +	} else if (*(kprobe_opcode_t *) addr != BRK64_OPCODE_KPROBES) {
>> +		/*
>> +		 * The breakpoint instruction was removed right
>> +		 * after we hit it.  Another cpu has removed
>> +		 * either a probepoint or a debugger breakpoint
>> +		 * at this address.  In either case, no further
>> +		 * handling of this interrupt is appropriate.
>> +		 * Return back to original instruction, and continue.
>> +		 */
>> +		return;
>> +	} else if (cur) {
>> +		/* We probably hit a jprobe.  Call its break handler. */
>> +		if (cur->break_handler && cur->break_handler(cur, regs)) {
>> +			kcb->kprobe_status = KPROBE_HIT_SS;
>> +			setup_singlestep(cur, regs, kcb, 0);
>> +			return;
>> +		}
>> +	} else {
>> +		/* breakpoint is removed, now in a race
>> +		 * Return back to original instruction & continue.
>> +		 */
>> +	}
>> +}
>> +
>> +static int __kprobes
>> +kprobe_ss_hit(struct kprobe_ctlblk *kcb, unsigned long addr)
>> +{
>> +	if ((kcb->ss_ctx.ss_status == KPROBES_STEP_PENDING)
>> +	    && (kcb->ss_ctx.match_addr == addr)) {
>> +		clear_ss_context(kcb);	/* clear pending ss */
>> +		return DBG_HOOK_HANDLED;
>> +	}
>> +	/* not ours, kprobes should ignore it */
>> +	return DBG_HOOK_ERROR;
>> +}
>> +
>> +static int __kprobes
>> +kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr)
>> +{
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +	int retval;
>> +
>> +	/* return error if this is not our step */
>> +	retval = kprobe_ss_hit(kcb, instruction_pointer(regs));
>> +
>> +	if (retval == DBG_HOOK_HANDLED) {
>> +		kprobes_restore_local_irqflag(regs);
>> +		kernel_disable_single_step();
>> +
>> +		if (kcb->kprobe_status == KPROBE_REENTER)
>> +			spsr_set_debug_flag(regs, 1);
>> +
>> +		post_kprobe_handler(kcb, regs);
>> +	}
>> +
>> +	return retval;
>> +}
>> +
>> +static int __kprobes
>> +kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
>> +{
>> +	kprobe_handler(regs);
>> +	return DBG_HOOK_HANDLED;
>> +}
>> +
>> +int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
>> +{
>> +	struct jprobe *jp = container_of(p, struct jprobe, kp);
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +	long stack_ptr = stack_pointer(regs);
>> +
>> +	kcb->jprobe_saved_regs = *regs;
>> +	memcpy(kcb->jprobes_stack, (void *)stack_ptr,
>> +	       MIN_STACK_SIZE(stack_ptr));
>> +
>> +	instruction_pointer(regs) = (long)jp->entry;
>> +	preempt_disable();
>> +	return 1;
>> +}
>> +
>> +void __kprobes jprobe_return(void)
>> +{
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +
>> +	/*
>> +	 * Jprobe handler return by entering break exception,
>> +	 * encoded same as kprobe, but with following conditions
>> +	 * -a magic number in x0 to identify from rest of other kprobes.
>> +	 * -restore stack addr to original saved pt_regs
>> +	 */
>> +	asm volatile ("ldr x0, [%0]\n\t"
>> +		      "mov sp, x0\n\t"
>> +		      "ldr x0, =" __stringify(JPROBES_MAGIC_NUM) "\n\t"
>> +		      "BRK %1\n\t"
>> +		      "NOP\n\t"
>> +		      :
>> +		      : "r"(&kcb->jprobe_saved_regs.sp),
>> +		      "I"(BRK64_ESR_KPROBES)
>> +		      : "memory");
>> +}
>> +
>> +int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>> +{
>> +	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> +	long stack_addr = kcb->jprobe_saved_regs.sp;
>> +	long orig_sp = stack_pointer(regs);
>> +	struct jprobe *jp = container_of(p, struct jprobe, kp);
>> +
>> +	if (regs->regs[0] == JPROBES_MAGIC_NUM) {
>> +		if (orig_sp != stack_addr) {
>> +			struct pt_regs *saved_regs =
>> +			    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
>> +			pr_err("current sp %lx does not match saved sp %lx\n",
>> +			       orig_sp, stack_addr);
>> +			pr_err("Saved registers for jprobe %p\n", jp);
>> +			show_regs(saved_regs);
>> +			pr_err("Current registers\n");
>> +			show_regs(regs);
>> +			BUG();
>> +		}
>> +		*regs = kcb->jprobe_saved_regs;
>> +		memcpy((void *)stack_addr, kcb->jprobes_stack,
>> +		       MIN_STACK_SIZE(stack_addr));
>> +		preempt_enable_no_resched();
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/* Break Handler hook */
>> +static struct break_hook kprobes_break_hook = {
>> +	.esr_mask = BRK64_ESR_MASK,
>> +	.esr_val = BRK64_ESR_KPROBES,
>> +	.fn = kprobe_breakpoint_handler,
>> +};
>> +
>> +/* Single Step handler hook */
>> +static struct step_hook kprobes_step_hook = {
>> +	.fn = kprobe_single_step_handler,
>> +};
>> +
>> +int __init arch_init_kprobes(void)
>> +{
>> +	register_break_hook(&kprobes_break_hook);
>> +	register_step_hook(&kprobes_step_hook);
> 
> I really recommend you to not use this "general hook caller" for
> kprobes, since it is called from anywhere, especially, if you
> enable lockdep, read_lock can involve so many functions. This
> means you can fall into the hell of the infinite loop of the
> breakpoint exceptions...
> 

OK.  I hope no one will object about any code duplication that results.

> Moreover, no one remove these hook handlers from the list.
> 

Since this is called from the architecture-independent kprobes code, and
since that code has no module_exit() code, I don't see a clean way to
get a call into a new arch_exit_kprobes() which could unregister these
hooks.  kprobes in general does not appear to be unloadable.

> Thank you,
> 
> 
