From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Feb 2014 10:14:23 +0000
Subject: [PATCH v2 2/4] arm64: defer reloading a task's FPSIMD state to
 userland resume
In-Reply-To: <CAKv+Gu_JKXZKnOvxRHiqH12jRUsA4AHkFrpMFAtqxPzyM1HyAQ@mail.gmail.com>
References: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
 <1391620418-3999-3-git-send-email-ard.biesheuvel@linaro.org>
 <20140221174855.GD25351@arm.com>
 <CAKv+Gu_JKXZKnOvxRHiqH12jRUsA4AHkFrpMFAtqxPzyM1HyAQ@mail.gmail.com>
Message-ID: <989E532E-41BA-41CB-A8C6-2A277FD86416@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 Feb 2014, at 18:33, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 21 February 2014 18:48, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Wed, Feb 05, 2014 at 05:13:36PM +0000, Ard Biesheuvel wrote:
>>> +              */
>>> +             struct fpsimd_state *st = &next->thread.fpsimd_state;
>>> +
>>> +             if (__get_cpu_var(fpsimd_last_task) == &st->last_cpu
>>> +                 && st->last_cpu == smp_processor_id())
>>> +                     clear_ti_thread_flag(task_thread_info(next),
>>> +                                          TIF_FOREIGN_FPSTATE);
>>> +             else
>>> +                     set_ti_thread_flag(task_thread_info(next),
>>> +                                        TIF_FOREIGN_FPSTATE);
>>> +     }
>>> }
>> 
>> I'm still trying to get my head around why we have 3 different type of
>> checks for this (fpsimd_last_task, last_cpu and TIF). The code seems
>> correct but I wonder whether we can reduce this to 2 checks?
> 
> Well, I suppose using the TIF flag is somewhat redundant, it is
> basically a shorthand for expressing that the following does /not/
> hold
> 
> __get_cpu_var(fpsimd_last_state) == &current->thread.fpsimd_state &&
> current->thread.fpsimd_state.cpu == smp_processor_id()

OK, it starts to make more sense now ;).

Basically, if we only cared about context switching (rather than Neon in
the kernel), we would have to always save the state of the scheduled out
task but restore it only if the current hw state is different. A way to
check this is fpsimd_last_state && cpu (I can?t really think of a
better way).

With the addition of kernel_neon_begin/end(), we want to optimise this
further by (a) only saving the state at context switch if it hasn?t
been saved already (by kernel_neon_begin) and (b) defer the restoring to
user space to avoid re-saving/restoring of the state.

Case (a) is when Neon is used between the syscall entry and switch_to()
for a given thread. Case (b) is for scenarios where Neon is used between
switch_to() and return to user. Are both of these likely? I think they are
(e.g. sending->waiting->receiving).

> I suppose that the test at resume can tolerate the overhead, so I can
> rework the code to get rid of it.

It may not be that simple since we need per-CPU variables retrieved in
assembly. So we end up with a function call plus per-CPU variable
checking and this must be done on the return from interrupt path as
well. In which case the TIF flag is quicker as an optimisation. If I 
have any better idea I?ll let you know.

In the meantime, I think it?s ok to keep all three checks for
different scenarios but please add some more explanation in the fpsimd.c
file so that in a year time we still remember the logic (documenting the
scenarios and when we check which TIF flag, per-CPU variable etc.).

Thanks,

Catalin
