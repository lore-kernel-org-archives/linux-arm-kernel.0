From: dave.long@linaro.org (David Long)
Date: Thu, 26 May 2016 15:25:54 -0400
Subject: [PATCH v12 05/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160518122935.39fd7acc63d6f9c17fcbe275@kernel.org>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
 <1461783185-9056-6-git-send-email-dave.long@linaro.org>
 <20160517085807.GA842@sha-win-210.asiapac.arm.com>
 <20160518122935.39fd7acc63d6f9c17fcbe275@kernel.org>
Message-ID: <57474DC2.5070400@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2016 11:29 PM, Masami Hiramatsu wrote:
> On Tue, 17 May 2016 16:58:09 +0800
> Huang Shijie <shijie.huang@arm.com> wrote:
>
>> On Wed, Apr 27, 2016 at 02:53:00PM -0400, David Long wrote:
>>> +
>>> +/*
>>> + * Interrupts need to be disabled before single-step mode is set, and not
>>> + * reenabled until after single-step mode ends.
>>> + * Without disabling interrupt on local CPU, there is a chance of
>>> + * interrupt occurrence in the period of exception return and  start of
>>> + * out-of-line single-step, that result in wrongly single stepping
>>> + * into the interrupt handler.
>>> + */
>>> +static void __kprobes kprobes_save_local_irqflag(struct pt_regs *regs)
>>> +{
>>> +     struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>>
>> Why not add a parameter for this function to save the @kcb?
>
> Good catch, it should use same kcb of caller.
>

I've made the change for the next version of the patch.

>>
>>> +
>>> +     kcb->saved_irqflag = regs->pstate;
>>> +     regs->pstate |= PSR_I_BIT;
>>> +}
>>> +
>>> +static void __kprobes kprobes_restore_local_irqflag(struct pt_regs *regs)
>>> +{
>>> +     struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>> ditto.
>>

I've made the change.

>>> +
>>> +     if (kcb->saved_irqflag & PSR_I_BIT)
>>> +             regs->pstate |= PSR_I_BIT;
>>> +     else
>>> +             regs->pstate &= ~PSR_I_BIT;
>>> +}
>>> +
>>> +static void __kprobes
>>> +set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
>>> +{
>>> +     kcb->ss_ctx.ss_pending = true;
>>> +     kcb->ss_ctx.match_addr = addr + sizeof(kprobe_opcode_t);
>>> +}
>>> +
>>> +static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
>>> +{
>>> +     kcb->ss_ctx.ss_pending = false;
>>> +     kcb->ss_ctx.match_addr = 0;
>>> +}
>>> +
>>> +static void __kprobes setup_singlestep(struct kprobe *p,
>>> +                                    struct pt_regs *regs,
>>> +                                    struct kprobe_ctlblk *kcb, int reenter)
>>> +{
>>> +     unsigned long slot;
>>> +
>>> +     if (reenter) {
>>> +             save_previous_kprobe(kcb);
>>> +             set_current_kprobe(p);
>>> +             kcb->kprobe_status = KPROBE_REENTER;
>>> +     } else {
>>> +             kcb->kprobe_status = KPROBE_HIT_SS;
>>> +     }
>>> +
>>> +     if (p->ainsn.insn) {
>>> +             /* prepare for single stepping */
>>> +             slot = (unsigned long)p->ainsn.insn;
>>> +
>>> +             set_ss_context(kcb, slot);      /* mark pending ss */
>>> +
>>> +             if (kcb->kprobe_status == KPROBE_REENTER)
>>> +                     spsr_set_debug_flag(regs, 0);
>>> +
>>> +             /* IRQs and single stepping do not mix well. */
>>> +             kprobes_save_local_irqflag(regs);
>>> +             kernel_enable_single_step(regs);
>>> +             instruction_pointer(regs) = slot;
>>> +     } else  {
>>> +             BUG();
>
> You'd better use BUG_ON(!p->ainsn.insn);
>

I have that change ready but the BUG*() is removed entirely in patch 
07/10 and the indentation changed back to the above, resulting in more 
diffs and the same final code.

>>> +     }
>>> +}
>>> +
>>> +static int __kprobes reenter_kprobe(struct kprobe *p,
>>> +                                 struct pt_regs *regs,
>>> +                                 struct kprobe_ctlblk *kcb)
>>> +{
>>> +     switch (kcb->kprobe_status) {
>>> +     case KPROBE_HIT_SSDONE:
>>> +     case KPROBE_HIT_ACTIVE:
>>> +             kprobes_inc_nmissed_count(p);
>>> +             setup_singlestep(p, regs, kcb, 1);
>>> +             break;
>>> +     case KPROBE_HIT_SS:
>>> +     case KPROBE_REENTER:
>>> +             pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
>>> +             dump_kprobe(p);
>>> +             BUG();
>>> +             break;
>>> +     default:
>>> +             WARN_ON(1);
>>> +             return 0;
>>> +     }
>>> +
>>> +     return 1;
>>> +}
>>> +
>>> +static void __kprobes
>>> +post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
>>> +{
>>> +     struct kprobe *cur = kprobe_running();
>>> +
>>> +     if (!cur)
>>> +             return;
>>> +
>>> +     /* return addr restore if non-branching insn */
>>> +     if (cur->ainsn.restore.type == RESTORE_PC) {
>>> +             instruction_pointer(regs) = cur->ainsn.restore.addr;
>>> +             if (!instruction_pointer(regs))
>>> +                     BUG();
>>> +     }
>>> +
>>> +     /* restore back original saved kprobe variables and continue */
>>> +     if (kcb->kprobe_status == KPROBE_REENTER) {
>>> +             restore_previous_kprobe(kcb);
>>> +             return;
>>> +     }
>>> +     /* call post handler */
>>> +     kcb->kprobe_status = KPROBE_HIT_SSDONE;
>>> +     if (cur->post_handler)  {
>>> +             /* post_handler can hit breakpoint and single step
>>> +              * again, so we enable D-flag for recursive exception.
>>> +              */
>>> +             cur->post_handler(cur, regs, 0);
>>> +     }
>>> +
>>> +     reset_current_kprobe();
>>> +}
>>> +
>>> +int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
>>> +{
>>> +     struct kprobe *cur = kprobe_running();
>>> +     struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>>> +
>>> +     switch (kcb->kprobe_status) {
>>> +     case KPROBE_HIT_SS:
>>> +     case KPROBE_REENTER:
>>> +             /*
>>> +              * We are here because the instruction being single
>>> +              * stepped caused a page fault. We reset the current
>>> +              * kprobe and the ip points back to the probe address
>>> +              * and allow the page fault handler to continue as a
>>> +              * normal page fault.
>>> +              */
>>> +             instruction_pointer(regs) = (unsigned long)cur->addr;
>>> +             if (!instruction_pointer(regs))
>>> +                     BUG();
>
> This can be BUG_ON(!instruction_pointer(regs)).
>

I've made the change.

>>> +             if (kcb->kprobe_status == KPROBE_REENTER)
>>> +                     restore_previous_kprobe(kcb);
>>> +             else
>>> +                     reset_current_kprobe();
>>> +
>>> +             break;
>>> +     case KPROBE_HIT_ACTIVE:
>>> +     case KPROBE_HIT_SSDONE:
>>> +             /*
>>> +              * We increment the nmissed count for accounting,
>>> +              * we can also use npre/npostfault count for accounting
>>> +              * these specific fault cases.
>>> +              */
>>> +             kprobes_inc_nmissed_count(cur);
>>> +
>>> +             /*
>>> +              * We come here because instructions in the pre/post
>>> +              * handler caused the page_fault, this could happen
>>> +              * if handler tries to access user space by
>>> +              * copy_from_user(), get_user() etc. Let the
>>> +              * user-specified handler try to fix it first.
>>> +              */
>>> +             if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
>>> +                     return 1;
>>> +
>>> +             /*
>>> +              * In case the user-specified fault handler returned
>>> +              * zero, try to fix up.
>>> +              */
>>> +             if (fixup_exception(regs))
>>> +                     return 1;
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>>> +                                    unsigned long val, void *data)
>>> +{
>>> +     return NOTIFY_DONE;
>>> +}
>>> +
>>> +static void __kprobes kprobe_handler(struct pt_regs *regs)
>>> +{
>>> +     struct kprobe *p, *cur_kprobe;
>>> +     struct kprobe_ctlblk *kcb;
>>> +     unsigned long addr = instruction_pointer(regs);
>>> +
>>> +     kcb = get_kprobe_ctlblk();
>>> +     cur_kprobe = kprobe_running();
>>> +
>>> +     p = get_kprobe((kprobe_opcode_t *) addr);
>>> +
>>> +     if (p) {
>>> +             if (cur_kprobe) {
>>> +                     if (reenter_kprobe(p, regs, kcb))
>>> +                             return;
>>> +             } else {
>>> +                     /* Probe hit */
>>> +                     set_current_kprobe(p);
>>> +                     kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>>> +
>>> +                     /*
>>> +                      * If we have no pre-handler or it returned 0, we
>>> +                      * continue with normal processing.  If we have a
>>> +                      * pre-handler and it returned non-zero, it prepped
>>> +                      * for calling the break_handler below on re-entry,
>>> +                      * so get out doing nothing more here.
>>> +                      *
>>> +                      * pre_handler can hit a breakpoint and can step thru
>>> +                      * before return, keep PSTATE D-flag enabled until
>>> +                      * pre_handler return back.
>>> +                      */
>>> +                     if (!p->pre_handler || !p->pre_handler(p, regs)) {
>>> +                             kcb->kprobe_status = KPROBE_HIT_SS;
>> The above line is duplicated.
>> You will set KPROBE_HIT_SS in the setup_singlestep.
>
> Right.
>

I've removed it.

>>
>>> +                             setup_singlestep(p, regs, kcb, 0);
>>> +                             return;
>>> +                     }
>>> +             }
>>> +     } else if ((le32_to_cpu(*(kprobe_opcode_t *) addr) ==
>>> +         BRK64_OPCODE_KPROBES) && cur_kprobe) {
>>> +             /* We probably hit a jprobe.  Call its break handler. */
>>> +             if (cur_kprobe->break_handler  &&
>>> +                  cur_kprobe->break_handler(cur_kprobe, regs)) {
>>> +                     kcb->kprobe_status = KPROBE_HIT_SS;
>> ditto

I've removed it.

>>> +                     setup_singlestep(cur_kprobe, regs, kcb, 0);
>>> +                     return;
>>> +             }
>>> +     }
>>> +     /*
>>> +      * The breakpoint instruction was removed right
>>> +      * after we hit it.  Another cpu has removed
>>> +      * either a probepoint or a debugger breakpoint
>>> +      * at this address.  In either case, no further
>>> +      * handling of this interrupt is appropriate.
>>> +      * Return back to original instruction, and continue.
>>> +      */
>>> +}
>
> Thanks,
>
>
>

Thanks,
-dl
