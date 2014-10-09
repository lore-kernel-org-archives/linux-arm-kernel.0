From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 09 Oct 2014 10:55:38 +0900
Subject: [PATCH v7 1/6] arm64: ptrace: add PTRACE_SET_SYSCALL
In-Reply-To: <CAGXu5jJkP_fg1Ck+rj1nn7tK=ckuMk5ObvgCOJLNhb3cHb3D-Q@mail.gmail.com>
References: <1412243176-16192-1-git-send-email-takahiro.akashi@linaro.org>	<1412243176-16192-2-git-send-email-takahiro.akashi@linaro.org>	<20141008141306.GQ26140@arm.com>
 <CAGXu5jJkP_fg1Ck+rj1nn7tK=ckuMk5ObvgCOJLNhb3cHb3D-Q@mail.gmail.com>
Message-ID: <5435EB1A.90702@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2014 12:30 AM, Kees Cook wrote:
> On Wed, Oct 8, 2014 at 9:13 AM, Will Deacon <will.deacon@arm.com> wrote:
>> Hi Akashi,
>>
>> On Thu, Oct 02, 2014 at 10:46:11AM +0100, AKASHI Takahiro wrote:
>>> To allow tracer to be able to change/skip a system call by re-writing
>>> a syscall number, there are several approaches:
>>>
>>> (1) modify x8 register with ptrace(PTRACE_SETREGSET), and handle this case
>>>      later on in syscall_trace_enter(), or
>>> (2) support ptrace(PTRACE_SET_SYSCALL) as on arm
>>>
>>> Thinking of the fact that user_pt_regs doesn't expose 'syscallno' to
>>> tracer as well as that secure_computing() expects a changed syscall number
>>> to be visible, especially case of -1, before this function returns in
>>> syscall_trace_enter(), we'd better take (2).
>>>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>   arch/arm64/include/uapi/asm/ptrace.h |    1 +
>>>   arch/arm64/kernel/ptrace.c           |   14 +++++++++++++-
>>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
>>> index 6913643..49c6174 100644
>>> --- a/arch/arm64/include/uapi/asm/ptrace.h
>>> +++ b/arch/arm64/include/uapi/asm/ptrace.h
>>> @@ -23,6 +23,7 @@
>>>
>>>   #include <asm/hwcap.h>
>>>
>>> +#define PTRACE_SET_SYSCALL   23
>>>
>>>   /*
>>>    * PSR bits
>>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>>> index fe63ac5..2842f9f 100644
>>> --- a/arch/arm64/kernel/ptrace.c
>>> +++ b/arch/arm64/kernel/ptrace.c
>>> @@ -1082,7 +1082,19 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
>>>   long arch_ptrace(struct task_struct *child, long request,
>>>                 unsigned long addr, unsigned long data)
>>>   {
>>> -     return ptrace_request(child, request, addr, data);
>>> +     int ret;
>>> +
>>> +     switch (request) {
>>> +             case PTRACE_SET_SYSCALL:
>>> +                     task_pt_regs(child)->syscallno = data;
>>> +                     ret = 0;
>>> +                     break;
>>> +             default:
>>> +                     ret = ptrace_request(child, request, addr, data);
>>> +                     break;
>>> +     }
>>> +
>>> +     return ret;
>>>   }
>>
>> I still don't understand why this needs to be in arch-specific code. Can't
>> we implement this in generic code and get architectures to implement
>> something like syscall_set_nr if they want the generic interface?
>
> Personally, I'd rather see this land as-is in the arm64 tree, and then
> later optimize PTRACE_SET_SYSCALL out of arm/ and arm64/, especially
> since only these architectures implement this at the moment.

+1 :)

-Takahiro AKASHI

> This is my plan for the asm-generic seccomp.h too -- I'd rather avoid
> touching other architectures in this series, as it's easier to review
> this way. Then we can optimize the code in a separate series, which
> will have those changes isolated, etc.
>
> -Kees
>
