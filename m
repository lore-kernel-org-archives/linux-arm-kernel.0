From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 9 Dec 2015 08:13:35 +0900
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <56671214.30402@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
 <20151207224805.GA20777@MBP.local> <20151208114321.GD19612@arm.com>
 <4EBA6141-5CFB-4CAC-97D2-26346AAA91F0@gmail.com> <56671214.30402@arm.com>
Message-ID: <990C8EDA-22F3-4693-84B8-7E0FE699EC46@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 9, 2015, at 2:23 AM, James Morse wrote:

Hi James,

> On 08/12/15 16:02, Jungseok Lee wrote:
>> I've seen the following BUG log with CONFIG_DEBUG_SPINLOCK=y kernel.
>> 
>> BUG: spinlock lockup suspected on CPU#1
>> 
>> Under that option, I cannot even complete a single kernel build successfully.
>> I hope I'm the only person to experience it. My Android machine is running
>> well for over 12 hours now with the below change.
> 
> I can't reproduce this, can you send me your .config file (off-list)? Do
> you have any other patches in your tree? What hardware are you using?

No additional patches with dragonboard410c [1]. I don't have Juno unfortunately.
Please refer to 'Lock Debugging' and  'RCU Debugging' of .config. 

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_HAVE_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

>> If I read the patches correctly, the dummy stack frame looks as follows.
>> 
>>  top ------------ <- irq_stack_ptr
>>      | dummy_lr |
>>      ------------
>>      |   x29    |
>>      ------------ <- new frame pointer (x29)
>>      |   x19    |
>>      ------------
>>      |   xzr    |
>>      ------------
>> 
>> So, we should refer to x19 in order to retrieve frame->sp. But, frame->sp is
>> xzr under the current implementation. I suspect this causes spinlock lockup.
> 
> This is the sort of place where it is too easy to make an off-by-one
> error, I will go through it all with the debugger again tomorrow.
> 
> 
> I'm not seeing this when testing on Juno. This would only affect the
> tracing code, are you running perf or ftrace at the same time?

No. I've got the same call trace Will reported when only trying kernel build.  

> I've just re-tested this with defconfig, and the following hack:
> =======%<=======
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index b947eeffa5b2..686086e4d870 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -72,8 +72,10 @@ int notrace unwind_frame(struct stackframe *frame)
>         * If we reach the end of the stack - and its an interrupt stack,
>         * read the original task stack pointer from the dummy frame.
>         */
> -       if (frame->sp == irq_stack_ptr)
> +       if (frame->sp == irq_stack_ptr) {
>                frame->sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
> +               BUG_ON(frame->sp == 0);
> +       }
> 
>        return 0;
> }
> =======%<=======
> 
> While running:
>> sudo ./perf record -e mem:<address of __do_softirq>:x -ag -- sleep 180
> 
> and
> 
>> dd if=/dev/sda of=/dev/null bs=512 iflag=direct;
> 
> This should cause lots of interrupts from /dev/sda, and cause the
> tracing code to step between irq_stack and the original task stack
> frequently. The BUG_ON() doesn't fire, and the perf trace output looks
> correct.
> 
> 
> My only theory is that there is an off by one, and its reading what was
> x29 instead. This wouldn't show up in these tests, but might be a
> problem for aarch32 user-space, as presumably x29==0 when it switches to
> aarch64 mode for el0_irq(). I will try this tomorrow.

My description on dummy stack frame was incorrect. frame->sp is retrieved from
x29, not xzr currently. That is why 0x20 is needed instead of 0x10.

Best Regards
Jungseok Lee
