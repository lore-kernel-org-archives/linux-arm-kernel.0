From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 22 Aug 2014 09:19:13 +0900
Subject: [PATCH v6 1/6] arm64: ptrace: add PTRACE_SET_SYSCALL
In-Reply-To: <CAGXu5jJrTEhdDZ8fipNeaVm1_wto7u2f=uq_KzyMcVHJMT57vw@mail.gmail.com>
References: <1408611405-8943-1-git-send-email-takahiro.akashi@linaro.org>	<1408611405-8943-2-git-send-email-takahiro.akashi@linaro.org>
 <CAGXu5jJrTEhdDZ8fipNeaVm1_wto7u2f=uq_KzyMcVHJMT57vw@mail.gmail.com>
Message-ID: <53F68C81.6020807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2014 01:47 AM, Kees Cook wrote:
> On Thu, Aug 21, 2014 at 3:56 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>> To allow tracer to be able to change/skip a system call by re-writing
>> a syscall number, there are several approaches:
>>
>> (1) modify x8 register with ptrace(PTRACE_SETREGSET), and handle this case
>>      later on in syscall_trace_enter(), or
>> (2) support ptrace(PTRACE_SET_SYSCALL) as on arm
>>
>> Thinking of the fact that user_pt_regs doesn't expose 'syscallno' to
>> tracer as well as that secure_computing() expects a changed syscall number
>> to be visible, especially case of -1, before this function returns in
>> syscall_trace_enter(), we'd better take (2).
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> Thanks, I like having this on both arm and arm64.

Yeah, having this simplified the code of syscall_trace_enter() a bit, but
also imposes some restriction on arm64, too.

 > I wonder if other archs should add this option too.

Do you think so? I assumed that SET_SYSCALL is to be avoided if possible.

I also think that SET_SYSCALL should take an extra argument for a return value
just in case of -1 (or we have SKIP_SYSCALL?).

-Takahiro AKASHI

> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>> ---
>>   arch/arm64/include/uapi/asm/ptrace.h |    1 +
>>   arch/arm64/kernel/ptrace.c           |   14 +++++++++++++-
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
>> index 6913643..49c6174 100644
>> --- a/arch/arm64/include/uapi/asm/ptrace.h
>> +++ b/arch/arm64/include/uapi/asm/ptrace.h
>> @@ -23,6 +23,7 @@
>>
>>   #include <asm/hwcap.h>
>>
>> +#define PTRACE_SET_SYSCALL     23
>>
>>   /*
>>    * PSR bits
>> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
>> index 0310811..8876049 100644
>> --- a/arch/arm64/kernel/ptrace.c
>> +++ b/arch/arm64/kernel/ptrace.c
>> @@ -1077,7 +1077,19 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
>>   long arch_ptrace(struct task_struct *child, long request,
>>                   unsigned long addr, unsigned long data)
>>   {
>> -       return ptrace_request(child, request, addr, data);
>> +       int ret;
>> +
>> +       switch (request) {
>> +               case PTRACE_SET_SYSCALL:
>> +                       task_pt_regs(child)->syscallno = data;
>> +                       ret = 0;
>> +                       break;
>> +               default:
>> +                       ret = ptrace_request(child, request, addr, data);
>> +                       break;
>> +       }
>> +
>> +       return ret;
>>   }
>>
>>   enum ptrace_syscall_dir {
>> --
>> 1.7.9.5
>>
>
>
>
