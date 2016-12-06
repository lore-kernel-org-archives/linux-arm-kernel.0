From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Dec 2016 16:48:54 +0000
Subject: [RFC PATCH] arm64: fpsimd: improve stacking logic in
 non-interruptible context
In-Reply-To: <20161206164317.GX1574@e103592.cambridge.arm.com>
References: <1481038740-11633-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161206164317.GX1574@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu8dAumcEV8Wk+8rXO3VnN0e9rAHac=3-FMhra=tZgeVxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2016 at 16:43, Dave Martin <Dave.Martin@arm.com> wrote:
> On Tue, Dec 06, 2016 at 03:39:00PM +0000, Ard Biesheuvel wrote:
>> Currently, we allow kernel mode NEON in softirq or hardirq context by
>> stacking and unstacking a slice of the NEON register file for each call
>> to kernel_neon_begin() and kernel_neon_end(), respectively.
>>
>> Given that
>> a) a CPU typically spends most of its time in userland, during which time
>>    no kernel mode NEON in process context is in progress,
>> b) a CPU spends most of its time in the kernel doing other things than
>>    kernel mode NEON when it gets interrupted to perform kernel mode NEON
>>    in softirq context
>>
>> the stacking and subsequent unstacking is only necessary if we are
>> interrupting a thread while it is performing kernel mode NEON in process
>> context, which means that in all other cases, we can simply preserve the
>> userland FPSIMD state once, and only restore it upon return to userland,
>> even if we are being invoked from softirq or hardirq context.
>>
>> So instead of checking whether we are running in interrupt context, keep
>> track of the level of nested kernel mode NEON calls in progress, and only
>> perform the eager stack/unstack of the level exceeds 1.
>
> Looks reasonable, and this does avoid treating SVE as a special case.
>
> Later on, we may want to enable SVE use in the kernel too, in which case
> kernel_neon_{begin,end}_partial() and fpsimd_partial_state will need
> more changes -- but we don't need to address that right now.
>
> Minor comments below.
>
> Cheers
> ---Dave
>
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm64/kernel/fpsimd.c | 40 +++++++++++++++++++++++++++-------------
>>  1 file changed, 27 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index 394c61db5566..2614a216ac5d 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -220,20 +220,31 @@ void fpsimd_flush_task_state(struct task_struct *t)
>>
>>  #ifdef CONFIG_KERNEL_MODE_NEON
>>
>> -static DEFINE_PER_CPU(struct fpsimd_partial_state, hardirq_fpsimdstate);
>> -static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
>> +/*
>> + * Although unlikely, it is possible for three kernel mode NEON contexts to
>> + * be live at the same time: process context, softirq context and hardirq
>> + * context. So while the userland context is stashed in the thread's fpsimd
>> + * state structure, we need two additional levels of storage.
>> + */
>> +static DEFINE_PER_CPU(struct fpsimd_partial_state, nested_fpsimdstate[2]);
>> +static DEFINE_PER_CPU(int, kernel_neon_nesting_level);
>>
>>  /*
>>   * Kernel-side NEON support functions
>>   */
>>  void kernel_neon_begin_partial(u32 num_regs)
>>  {
>> -     if (in_interrupt()) {
>> -             struct fpsimd_partial_state *s = this_cpu_ptr(
>> -                     in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
>> +     struct fpsimd_partial_state *s;
>> +     int level;
>> +
>> +     preempt_disable();
>> +
>> +     level = this_cpu_read(kernel_neon_nesting_level);
>> +     if (level > 0) {
>> +             s = this_cpu_ptr(nested_fpsimdstate);
>>
>>               BUG_ON(num_regs > 32);
>> -             fpsimd_save_partial_state(s, roundup(num_regs, 2));
>> +             fpsimd_save_partial_state(&s[level - 1], roundup(num_regs, 2));
>>       } else {
>>               /*
>>                * Save the userland FPSIMD state if we have one and if we
>> @@ -241,24 +252,27 @@ void kernel_neon_begin_partial(u32 num_regs)
>>                * that there is no longer userland FPSIMD state in the
>>                * registers.
>>                */
>> -             preempt_disable();
>>               if (current->mm &&
>>                   !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
>>                       fpsimd_save_state(&current->thread.fpsimd_state);
>>               this_cpu_write(fpsimd_last_state, NULL);
>>       }
>> +     this_cpu_write(kernel_neon_nesting_level, level + 1);
>
> Should we BUG_ON overflow/underflow of the nesting level?  That Should
> Not Happen (tm), but we'll make a mess if it does.
>

True.

> For the underflow case, perhaps DEBUG_PREEMPT is adequate for detecting
> this via preempt count underflow.
>

I think it makes sense for the increment to check for overflow and the
decrement to check for underflow, regardless of whether DEBUG_PREEMPT
(or just PREEMPT) is enabled or not.

>>  }
>>  EXPORT_SYMBOL(kernel_neon_begin_partial);
>>
>>  void kernel_neon_end(void)
>>  {
>> -     if (in_interrupt()) {
>> -             struct fpsimd_partial_state *s = this_cpu_ptr(
>> -                     in_irq() ? &hardirq_fpsimdstate : &softirq_fpsimdstate);
>> -             fpsimd_load_partial_state(s);
>> -     } else {
>> -             preempt_enable();
>> +     struct fpsimd_partial_state *s;
>> +     int level;
>> +
>> +     level = this_cpu_read(kernel_neon_nesting_level);
>> +     if (level > 1) {
>> +             s = this_cpu_ptr(nested_fpsimdstate);
>> +             fpsimd_load_partial_state(&s[level - 2]);
>>       }
>> +     this_cpu_write(kernel_neon_nesting_level, level - 1);
>> +     preempt_enable();
>>  }
>>  EXPORT_SYMBOL(kernel_neon_end);
>>
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
