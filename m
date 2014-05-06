From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 May 2014 18:25:14 +0200
Subject: [PATCH resend 03/15] arm64: defer reloading a task's FPSIMD state
 to userland resume
In-Reply-To: <20140506160826.GI23957@arm.com>
References: <1398959381-8126-1-git-send-email-ard.biesheuvel@linaro.org>
 <1398959381-8126-4-git-send-email-ard.biesheuvel@linaro.org>
 <20140506160826.GI23957@arm.com>
Message-ID: <CAKv+Gu9ogEHb6rOT6KgPMDXjTwR5Krz0s7pkiaW_7vtZipu2Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 May 2014 18:08, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, May 01, 2014 at 04:49:35PM +0100, Ard Biesheuvel wrote:
>> @@ -153,12 +252,11 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
>>  {
>>         switch (cmd) {
>>         case CPU_PM_ENTER:
>> -               if (current->mm)
>> +               if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
>>                         fpsimd_save_state(&current->thread.fpsimd_state);
>>                 break;
>>         case CPU_PM_EXIT:
>> -               if (current->mm)
>> -                       fpsimd_load_state(&current->thread.fpsimd_state);
>> +               set_thread_flag(TIF_FOREIGN_FPSTATE);
>
> I think we could enter a PM state on a kernel thread (idle), so we
> should preserve the current->mm check as well.
>

OK

>>                 break;
>>         case CPU_PM_ENTER_FAILED:
>>         default:
>> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
>> index 06448a77ff53..882f01774365 100644
>> --- a/arch/arm64/kernel/signal.c
>> +++ b/arch/arm64/kernel/signal.c
>> @@ -413,4 +413,8 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>>                 clear_thread_flag(TIF_NOTIFY_RESUME);
>>                 tracehook_notify_resume(regs);
>>         }
>> +
>> +       if (thread_flags & _TIF_FOREIGN_FPSTATE)
>> +               fpsimd_restore_current_state();
>
> I think this should be safe. Even if we get preempted here, ret_to_user
> would loop over TI_FLAGS with interrupts disabled until no work pending.
>

I don't follow. Do you think I should change something here?

Anyway, inside fpsimd_restore_current_state() the TIF_FOREIGN_FPSTATE
is checked again, but this time with preemption disabled.

-- 
Ard.
