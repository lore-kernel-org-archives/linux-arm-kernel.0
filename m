From: T.E.Baldwin99@members.leeds.ac.uk (T.E.Baldwin99 at members.leeds.ac.uk)
Date: Thu, 15 Mar 2018 10:38:15 +0000
Subject: ARM: Call syscall_trace_exit even when system call skipped
In-Reply-To: <CAGXu5jKY+uqi53YPhuptwb72zm=mpAaZ1YgCHN7BAGgXWyvqbw@mail.gmail.com>
References: <20180203152112.2449-1-T.E.Baldwin99@members.leeds.ac.uk>
 <20180313235850.GA18373@altlinux.org>
 <CAGXu5jKY+uqi53YPhuptwb72zm=mpAaZ1YgCHN7BAGgXWyvqbw@mail.gmail.com>
Message-ID: <162293d1df0.2772.8578bc6afb023d3c4d0bd68fb35b28aa@members.leeds.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 March 2018 00:45:01 Kees Cook <keescook@chromium.org> wrote:

>>> --- a/arch/arm/kernel/entry-common.S
>>> +++ b/arch/arm/kernel/entry-common.S
>>> @@ -288,16 +288,15 @@ __sys_trace:
>>>       cmp     scno, #-1                       @ skip the syscall?
>>>       bne     2b
>>>       add     sp, sp, #S_OFF                  @ restore stack
>>> -     b       ret_slow_syscall
>>>
>>> -__sys_trace_return:
>>> -     str     r0, [sp, #S_R0 + S_OFF]!        @ save returned r0
>>> +__sys_trace_return_nosave:
>>> +     enable_irq_notrace
>
> Why is __sys_trace_return_nosave the correct destination here? The
> original handle set up for lr a few lines above is for
> __sys_trace_return. It's not clear to me why this change is made?

__sys_trace_return stores the current r0 value on the stack which will 
reloaded on exit to user mode. However if skipping a system call r0 is -1 
and storing it would destroy the users r0 value, unlike the case where the 
system call is made and r0 is the return value.

The enabling of interrupts is redundant for this purpose, the reuse of code 
is a size optimization.

>>>       mov     r0, sp
>>>       bl      syscall_trace_exit
>>>       b       ret_slow_syscall
>>>
>>> -__sys_trace_return_nosave:
>>> -     enable_irq_notrace
>>> +__sys_trace_return:
>>> +     str     r0, [sp, #S_R0 + S_OFF]!        @ save returned r0
>>>       mov     r0, sp
>>>       bl      syscall_trace_exit
>>>       b       ret_slow_syscall
