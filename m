From: stevenrwalter@gmail.com (Steven Walter)
Date: Tue, 29 Nov 2011 13:02:38 -0500
Subject: [PATCH 3/3] ARM: support syscall tracing
In-Reply-To: <20111129172429.GB1104@mudshark.cambridge.arm.com>
References: <1322584095-30439-1-git-send-email-stevenrwalter@gmail.com>
 <1322584095-30439-4-git-send-email-stevenrwalter@gmail.com>
 <20111129172429.GB1104@mudshark.cambridge.arm.com>
Message-ID: <CAK8d-a+KBZATZ5CBcJ6i3asWa9TrZBj=NM42bCjEe7KF050w1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Oops, dropped l-a-k from CC: )

On Tue, Nov 29, 2011 at 12:24 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Nov 29, 2011 at 04:28:15PM +0000, Steven Walter wrote:
>> diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
>> index 2c04ed5..1f23923 100644
>> --- a/arch/arm/include/asm/unistd.h
>> +++ b/arch/arm/include/asm/unistd.h
>> @@ -403,6 +403,8 @@
>>  #define __NR_sendmmsg                        (__NR_SYSCALL_BASE+374)
>>  #define __NR_setns                   (__NR_SYSCALL_BASE+375)
>>
>> +#define NR_syscalls (__NR_setns+1)
>
> [...]
>
>> -     .equ NR_syscalls,0
>> -#define CALL(x) .equ NR_syscalls,NR_syscalls+1
>> +     .equ NR_syscalls_asm,0
>> +#define CALL(x) .equ NR_syscalls_asm,NR_syscalls_asm+1
>
> If we need to have two definitions of NR_syscalls, then it's probably best
> to define one in terms of the other to ensure they are consistent.
> Unfortunately, it looks like we calculate NR_syscalls recursively from the
> syscall table. Perhaps you'd be better off with just the #define and have a
> sanity check on the table size using that.

Yeah I'll have to do something about this.  Russell also raised
concern about it.

>> -     tst     r10, #_TIF_SYSCALL_TRACE                @ are we tracing syscalls?
>> +     tst     r10, #_TIF_SYSCALL_TRACE        @ are we tracing syscalls?
>> +     tsteq   r10, #_TIF_SYSCALL_TRACEPOINT
>>       bne     __sys_trace
>
> Maybe you could macroise this pattern.

Good idea.

>> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
>> index 1411848..0e2699a 100644
>> --- a/arch/arm/kernel/ptrace.c
>> +++ b/arch/arm/kernel/ptrace.c
>> @@ -28,6 +28,9 @@
>>  #include <asm/system.h>
>>  #include <asm/traps.h>
>>
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/syscalls.h>
>
> [...]
>
>> @@ -939,11 +942,20 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
>>
>>       current_thread_info()->syscall = scno;
>>
>> -     if (why == 0) {
>> -             if (tracehook_report_syscall_entry(regs))
>> -                     current_thread_info()->syscall = -1;
>> -     } else {
>> -             tracehook_report_syscall_exit(regs, 0);
>
> Wait - didn't you just add this code?

Indeed.  It's not going away, just getting indented.  Previously we
couldn't get to that line unless TIF_SYSCALL_TRACE.  Now, all we know
is TIF_SYSCALL_TRACE || TIF_SYSCALL_TRACEPOINT, so I have to check
which.
-- 
-Steven Walter <stevenrwalter@gmail.com>
