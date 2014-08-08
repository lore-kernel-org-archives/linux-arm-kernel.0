From: wangnan0@huawei.com (Wang Nan)
Date: Fri, 8 Aug 2014 09:25:24 +0800
Subject: [RFC PATCH] kprobes: arm: enable OPTPROBES for arm 32
In-Reply-To: <53E323D1.8020209@hitachi.com>
References: <1407223697-74911-1-git-send-email-wangnan0@huawei.com>
 <53E1B2A0.1040807@hitachi.com> <53E1CA11.1030206@huawei.com>
 <53E323D1.8020209@hitachi.com>
Message-ID: <53E42704.3090909@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/8/7 14:59, Masami Hiramatsu wrote:
> (2014/08/06 15:24), Wang Nan wrote:
>>>> +
>>>> +static void
>>>> +optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
>>>> +{
>>>> +	unsigned long flags;
>>>> +
>>>> +	regs->ARM_pc = (unsigned long)op->kp.addr;
>>>> +	regs->ARM_ORIG_r0 = ~0UL;
>>>> +
>>>> +
>>>> +	local_irq_save(flags);
>>>> +	/* 
>>>> +	 * This is possible if op is under delayed unoptimizing.
>>>> +	 * We need simulate the replaced instruction.
>>>> +	 */
>>>> +	if (kprobe_disabled(&op->kp)) {
>>>> +		struct kprobe *p = &op->kp;
>>>> +		op->kp.ainsn.insn_singlestep(p->opcode, &p->ainsn, regs);
>>>> +	} else {
>>>> +		kprobe_handler(regs);
>>>> +	}
>>>
>>> You don't need brace "{}" for one statement.
>>> By the way, why don't you call opt_pre_handler()?
>>>
>>
>> I use kprobe_handler because it handles instruction emulation.
>>
>> In addition, I'm not very sure whether skipping the complex checks
>> in kprobe_handler() is safe or not.
> 
> That seems to do same thing on x86. Then you should do something like
> the optimized_callback() on x86 as below.
> 
> static void
> optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
> {
>         struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>         unsigned long flags;
> 
>         local_irq_save(flags);
>         if (kprobe_running()) {
>                 kprobes_inc_nmissed_count(&op->kp);

In this case we still need a singlestep, right?

>         } else {
>                 /* Save skipped registers */
>                 regs->ARM_pc = (unsigned long)op->kp.addr;
>                 regs->ARM_ORIG_r0 = ~0UL;
> 
>                 __this_cpu_write(current_kprobe, &op->kp);
>                 kcb->kprobe_status = KPROBE_HIT_ACTIVE;
>                 opt_pre_handler(&op->kp, regs);
>                 __this_cpu_write(current_kprobe, NULL);
> 		op->kp.ainsn.insn_singlestep(op->kp.opcode, &op->kp.ainsn, regs);
>         }
>         local_irq_restore(flags);
> }
> 
> Thank you,
> 
