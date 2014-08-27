From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 27 Aug 2014 14:55:46 +0900
Subject: [PATCH v6 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <20140826175128.GD23445@arm.com>
References: <1408611405-8943-1-git-send-email-takahiro.akashi@linaro.org>
 <1408611405-8943-3-git-send-email-takahiro.akashi@linaro.org>
 <CAGXu5jJCyqpXkdvNDCu+eMr0qnqwbqUUo4u+2p_7DvFMzfKoEw@mail.gmail.com>
 <53F69045.7010301@linaro.org> <20140826175128.GD23445@arm.com>
Message-ID: <53FD72E2.4020103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 02:51 AM, Will Deacon wrote:
> On Fri, Aug 22, 2014 at 01:35:17AM +0100, AKASHI Takahiro wrote:
>> On 08/22/2014 02:08 AM, Kees Cook wrote:
>>> On Thu, Aug 21, 2014 at 3:56 AM, AKASHI Takahiro
>>> <takahiro.akashi@linaro.org> wrote:
>>>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>>>> index 8876049..c54dbcc 100644
>>>> --- a/arch/arm64/kernel/ptrace.c
>>>> +++ b/arch/arm64/kernel/ptrace.c
>>>> @@ -1121,9 +1121,29 @@ static void tracehook_report_syscall(struct pt_regs *regs,
>>>>
>>>>    asmlinkage int syscall_trace_enter(struct pt_regs *regs)
>>>>    {
>>>> +       unsigned int saved_syscallno = regs->syscallno;
>>>> +
>>>>           if (test_thread_flag(TIF_SYSCALL_TRACE))
>>>>                   tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
>>>>
>>>> +       if (IS_SKIP_SYSCALL(regs->syscallno)) {
>>>> +               /*
>>>> +                * RESTRICTION: we can't modify a return value of user
>>>> +                * issued syscall(-1) here. In order to ease this flavor,
>>>> +                * we need to treat whatever value in x0 as a return value,
>>>> +                * but this might result in a bogus value being returned.
>>>> +                */
>>>> +               /*
>>>> +                * NOTE: syscallno may also be set to -1 if fatal signal is
>>>> +                * detected in tracehook_report_syscall_entry(), but since
>>>> +                * a value set to x0 here is not used in this case, we may
>>>> +                * neglect the case.
>>>> +                */
>>>> +               if (!test_thread_flag(TIF_SYSCALL_TRACE) ||
>>>> +                               (IS_SKIP_SYSCALL(saved_syscallno)))
>>>> +                       regs->regs[0] = -ENOSYS;
>>>> +       }
>>>> +
>>>
>>> I don't have a runtime environment yet for arm64, so I can't test this
>>> directly myself, so I'm just trying to eyeball this. :)
>>>
>>> Once the seccomp logic is added here, I don't think using -2 as a
>>> special value will work. Doesn't this mean the Oops is possible by the
>>> user issuing a "-2" syscall? As in, if TIF_SYSCALL_WORK is set, and
>>> the user passed -2 as the syscall, audit will be called only on entry,
>>> and then skipped on exit?
>>
>> Oops, you're absolutely right. I didn't think of this case.
>> syscall_trace_enter() should not return a syscallno directly, but always
>> return -1 if syscallno < 0. (except when secure_computing() returns with -1)
>> This also implies that tracehook_report_syscall() should also have a return value.
>>
>> Will, is this fine with you?
>
> Well, the first thing that jumps out at me is why this is being done
> completely differently for arm64 and arm. I thought adding the new ptrace
> requests would reconcile the differences?

I'm not sure what portion of my code you mentioned as "completely different", but

1)
setting x0 to -ENOSYS is necessary because, otherwise, user-issued syscall(-1) will
return a bogus value when audit tracing is on.

Please note that, on arm,
                  not traced      traced
                  ------          ------
syscall(-1)      aborted         OOPs(BUG_ON)
syscall(-3000)   aborted         aborted
syscall(1000)    ENOSYS          ENOSYS

So, anyhow, its a bit difficult and meaningless to mimic these invalid cases.

2)
branching a new label, syscall_trace_return_skip (see entry.S), after syscall_trace_enter()
is necessary in order to avoid OOPS in audit_syscall_enter() as we discussed.

Did I make it clear?

-Takahiro AKASHI

> Will
>
