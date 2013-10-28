From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 28 Oct 2013 13:32:00 -0700
Subject: [RFC v3 PATCH 3/7] ARM64: defer reloading a task's FPSIMD state
 to userland resume
In-Reply-To: <20131028181238.GB18563@mbp>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
 <1381666503-23726-4-git-send-email-ard.biesheuvel@linaro.org>
 <20131028181238.GB18563@mbp>
Message-ID: <CAKv+Gu9J1WuA23bhOjYnTfQp+poBMwmFPQuuYKPSsO+spSPOCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2013 11:12, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Sun, Oct 13, 2013 at 01:14:59PM +0100, Ard Biesheuvel wrote:
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -72,7 +72,7 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>>  void fpsimd_thread_switch(struct task_struct *next)
>>  {
>>       /* check if not kernel threads */
>> -     if (current->mm)
>> +     if (current->mm && !test_and_clear_thread_flag(TIF_RELOAD_FPSTATE))
>>               fpsimd_save_state(&current->thread.fpsimd_state);
>
> Why does it need test_and_set_thread_flag() here? Some comments would be
> useful as it looks strange to check a reload flag to decide whether to
> save a state. Or change the name to something like 'dirty'.
>

Actually, it's test and clear. If the userland register file has
already been preserved for the purpose of performing kernel mode NEON,
it should not be saved again when the task gets scheduled out. The
clearing could also be deferred to the time when the task gets
scheduled in again. Or perhaps, it would be even better to always
defer loading the userland state for the next task when that task in
fact enters userland.

>>       if (next->mm)
>>               fpsimd_load_state(&next->thread.fpsimd_state);
>
> This function could be optimised a bit more to avoid saving/restoring if
> the switch only happened between a user thread and a kernel one (and
> back again) since the FP state may not have been dirtied. But what I had
> in mind was per-CPU fpstate (possibly pointer or some flag) rather than
> per-thread.
>

Well, then we are entering the realm of lazy restore, imo. There were
some patches proposed for that already, I think? But I do agree that
at his point, there is no need to restore the userland register
contents yet, it can be deferred to the point when the task reenters
userland (as mentioned above).

>> --- a/arch/arm64/kernel/signal.c
>> +++ b/arch/arm64/kernel/signal.c
>> @@ -416,4 +416,6 @@ asmlinkage void do_noti fy_resume(struct pt_regs *regs,
>>               clear_thread_flag(TIF_NOTIFY_RESUME);
>>               tracehook_notify_resume(regs);
>>       }
>> +     if (test_and_clear_thread_flag(TIF_RELOAD_FPSTATE))
>> +             fpsimd_load_state(&current->thread.fpsimd_state);
>
> I think this code can be preempted, it is run with IRQs enabled. And
> there is a small window where we cleared the flag but haven't loaded the
> state.
>

If we are preempted at this point, the fpstate will be loaded in the
normal way the next time this task runs, so I think this is harmless.
Although I guess we may be restoring the fp state twice in that case?

So in summary, what I need to do is:
- rework to use a per_cpu flag rather than a TIF;
- preserve the userland state (if it has one) when a task gets scheduled out;
- restore the userland state when a task enters userland;

I will propose an updated patch after I wrap up the work on the
in_interrupt() kernel mode NEON, as these topics are really orthogonal
and there is no reason to keep them combined in a single series.

-- 
Ard.
