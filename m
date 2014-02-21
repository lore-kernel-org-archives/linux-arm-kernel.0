From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 21 Feb 2014 19:33:44 +0100
Subject: [PATCH v2 2/4] arm64: defer reloading a task's FPSIMD state to
 userland resume
In-Reply-To: <20140221174855.GD25351@arm.com>
References: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
 <1391620418-3999-3-git-send-email-ard.biesheuvel@linaro.org>
 <20140221174855.GD25351@arm.com>
Message-ID: <CAKv+Gu_JKXZKnOvxRHiqH12jRUsA4AHkFrpMFAtqxPzyM1HyAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 February 2014 18:48, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Feb 05, 2014 at 05:13:36PM +0000, Ard Biesheuvel wrote:
>> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
>> index 7807974b49ee..f7e70f3f1eb7 100644
>> --- a/arch/arm64/include/asm/fpsimd.h
>> +++ b/arch/arm64/include/asm/fpsimd.h
>> @@ -37,6 +37,8 @@ struct fpsimd_state {
>>                       u32 fpcr;
>>               };
>>       };
>> +     /* the id of the last cpu to have restored this state */
>> +     unsigned int last_cpu;
>
> Just "cpu" is enough.
>

OK

[...]

>>  /*
>> + * In order to reduce the number of times the fpsimd state is needlessly saved
>> + * and restored, keep track here of which task's userland owns the current state
>> + * of the FPSIMD register file.
>> + *
>> + * This percpu variable points to the fpsimd_state.last_cpu field of the task
>> + * whose FPSIMD state was most recently loaded onto this cpu. The last_cpu field
>> + * itself contains the id of the cpu onto which the task's FPSIMD state was
>> + * loaded most recently. So, to decide whether we can skip reloading the FPSIMD
>> + * state, we need to check
>> + * (a) whether this task was the last one to have its FPSIMD state loaded onto
>> + *     this cpu
>> + * (b) whether this task may have manipulated its FPSIMD state on another cpu in
>> + *     the meantime
>> + */
>> +static DEFINE_PER_CPU(unsigned int *, fpsimd_last_task);
>
> This can simply be struct fpsimd_state * to avoid &st->last_cpu. Also
> rename to fpsimd_state_last.
>

OK

>> +
>> +/*
>>   * Trapped FP/ASIMD access.
>>   */
>>  void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
>> @@ -76,36 +93,84 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>>
>>  void fpsimd_thread_switch(struct task_struct *next)
>>  {
>> -     /* check if not kernel threads */
>> -     if (current->mm)
>> +     /*
>> +      * The thread flag TIF_FOREIGN_FPSTATE conveys that the userland FPSIMD
>> +      * state belonging to the current task is not present in the registers
>> +      * but has (already) been saved to memory in order for the kernel to be
>> +      * able to go off and use the registers for something else. Therefore,
>> +      * we must not (re)save the register contents if this flag is set.
>> +      */
>> +     if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
>>               fpsimd_save_state(&current->thread.fpsimd_state);
>> -     if (next->mm)
>> -             fpsimd_load_state(&next->thread.fpsimd_state);
>> +
>> +     if (next->mm) {
>> +             /*
>> +              * If we are switching to a task whose most recent userland
>> +              * FPSIMD contents are already in the registers of *this* cpu,
>> +              * we can skip loading the state from memory. Otherwise, set
>> +              * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
>> +              * upon the next entry of userland.
>
> I would say "return" instead of "entry" (we enter the kernel and return
> to user space ;)).
>

OK

>> +              */
>> +             struct fpsimd_state *st = &next->thread.fpsimd_state;
>> +
>> +             if (__get_cpu_var(fpsimd_last_task) == &st->last_cpu
>> +                 && st->last_cpu == smp_processor_id())
>> +                     clear_ti_thread_flag(task_thread_info(next),
>> +                                          TIF_FOREIGN_FPSTATE);
>> +             else
>> +                     set_ti_thread_flag(task_thread_info(next),
>> +                                        TIF_FOREIGN_FPSTATE);
>> +     }
>>  }
>
> I'm still trying to get my head around why we have 3 different type of
> checks for this (fpsimd_last_task, last_cpu and TIF). The code seems
> correct but I wonder whether we can reduce this to 2 checks?
>

Well, I suppose using the TIF flag is somewhat redundant, it is
basically a shorthand for expressing that the following does /not/
hold

__get_cpu_var(fpsimd_last_state) == &current->thread.fpsimd_state &&
current->thread.fpsimd_state.cpu == smp_processor_id()

I suppose that the test at resume can tolerate the overhead, so I can
rework the code to get rid of it.

Regards,
Ard.
