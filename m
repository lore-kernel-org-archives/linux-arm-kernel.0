From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Mon, 20 Aug 2012 13:45:10 -0700
Subject: [PATCH v3] ARM: support syscall tracing
In-Reply-To: <20120820172559.GW25864@mudshark.cambridge.arm.com>
References: <50324BED.9000500@mentor.com>
 <20120820172559.GW25864@mudshark.cambridge.arm.com>
Message-ID: <5032A1D6.6010605@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> Hi Wade,
>
> On Mon, Aug 20, 2012 at 03:38:37PM +0100, Wade Farnsworth wrote:
>> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
>> index 978eac5..b032c94 100644
>> --- a/arch/arm/kernel/entry-common.S
>> +++ b/arch/arm/kernel/entry-common.S
>> @@ -94,6 +94,15 @@ ENDPROC(ret_from_fork)
>>   	.equ NR_syscalls,0
>>   #define CALL(x) .equ NR_syscalls,NR_syscalls+1
>>   #include "calls.S"
>> +
>> +/*
>> + * Ensure that the system call table is equal to __NR_syscalls,
>> + * which is the value the rest of the system sees
>> + */
>> +.ifne NR_syscalls - __NR_syscalls
>> +.error "__NR_syscalls is not equal to the size of the syscall table"
>> +.endif
>> +
>>   #undef CALL
>>   #define CALL(x) .long x
>>
>> @@ -415,7 +424,7 @@ local_restart:
>>   1:
>>   #endif
>>
>> -	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
>> +	tst     r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
>
> This is just a whitespace change, so I think you can drop it.
>
>> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
>> index 3e0fc5f..4974cdf 100644
>> --- a/arch/arm/kernel/ptrace.c
>> +++ b/arch/arm/kernel/ptrace.c
>> @@ -30,6 +30,9 @@
>>   #include<asm/pgtable.h>
>>   #include<asm/traps.h>
>>
>> +#define CREATE_TRACE_POINTS
>> +#include<trace/events/syscalls.h>
>> +
>>   #define REG_PC	15
>>   #define REG_PSR	16
>>   /*
>> @@ -918,11 +921,11 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
>>   {
>>   	unsigned long ip;
>>
>> +	current_thread_info()->syscall = scno;
>> +
>>   	if (!test_thread_flag(TIF_SYSCALL_TRACE))
>>   		return scno;
>>
>> -	current_thread_info()->syscall = scno;
>> -
>>   	/*
>>   	 * IP is used to denote syscall entry/exit:
>>   	 * IP = 0 ->  entry, =1 ->  exit
>> @@ -942,6 +945,8 @@ static int ptrace_syscall_trace(struct pt_regs *regs, int scno,
>>   asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
>>   {
>>   	int ret = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_ENTER);
>> +	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>> +		trace_sys_enter(regs, scno);
>>   	audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0, regs->ARM_r1,
>>   			    regs->ARM_r2, regs->ARM_r3);
>>   	return ret;
>> @@ -950,6 +955,8 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs, int scno)
>>   asmlinkage int syscall_trace_exit(struct pt_regs *regs, int scno)
>>   {
>>   	int ret = ptrace_syscall_trace(regs, scno, PTRACE_SYSCALL_EXIT);
>> +	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
>> +		trace_sys_exit(regs, scno);
>
> I think that trace_sys_{enter,exit} should take ret rather than scno. A
> debugger could change the syscall number if TIF_SYSCALL_TRACE is set and
> that new number should be the one that we use.
>
> The style, however, is much better and I think the code is fairly clear now
> so we just need to wait for my fix to the core code to get merged (it got
> picked up by Steve Rostedt) and I think we can use ret directly. It might be
> worth dropping the local variable and using scno for everything, so that
> it's obvious where the syscall number is stored.
>

I agree that your patch needs to get merged before mine gets picked up 
so that we don't introduce a new bug.  I've sent v4 with the changes you 
suggest.  Would you like me to modify syscall_trace_* to remove the 
local variable in this patch as well?  It seems to me that such a rework 
is better handled separately, but let me know if you think otherwise.

Thanks for the reviews!

Wade
