From: james.morse@arm.com (James Morse)
Date: Tue, 08 Dec 2015 17:23:32 +0000
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <4EBA6141-5CFB-4CAC-97D2-26346AAA91F0@gmail.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
 <20151207224805.GA20777@MBP.local> <20151208114321.GD19612@arm.com>
 <4EBA6141-5CFB-4CAC-97D2-26346AAA91F0@gmail.com>
Message-ID: <56671214.30402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/15 16:02, Jungseok Lee wrote:
> I've seen the following BUG log with CONFIG_DEBUG_SPINLOCK=y kernel.
>  
>  BUG: spinlock lockup suspected on CPU#1
> 
> Under that option, I cannot even complete a single kernel build successfully.
> I hope I'm the only person to experience it. My Android machine is running
> well for over 12 hours now with the below change.

I can't reproduce this, can you send me your .config file (off-list)? Do
you have any other patches in your tree? What hardware are you using?


> If I read the patches correctly, the dummy stack frame looks as follows.
> 
>   top ------------ <- irq_stack_ptr
>       | dummy_lr |
>       ------------
>       |   x29    |
>       ------------ <- new frame pointer (x29)
>       |   x19    |
>       ------------
>       |   xzr    |
>       ------------
> 
> So, we should refer to x19 in order to retrieve frame->sp. But, frame->sp is
> xzr under the current implementation. I suspect this causes spinlock lockup.

This is the sort of place where it is too easy to make an off-by-one
error, I will go through it all with the debugger again tomorrow.


I'm not seeing this when testing on Juno. This would only affect the
tracing code, are you running perf or ftrace at the same time?

I've just re-tested this with defconfig, and the following hack:
=======%<=======
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index b947eeffa5b2..686086e4d870 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -72,8 +72,10 @@ int notrace unwind_frame(struct stackframe *frame)
         * If we reach the end of the stack - and its an interrupt stack,
         * read the original task stack pointer from the dummy frame.
         */
-       if (frame->sp == irq_stack_ptr)
+       if (frame->sp == irq_stack_ptr) {
                frame->sp = IRQ_STACK_TO_TASK_STACK(irq_stack_ptr);
+               BUG_ON(frame->sp == 0);
+       }

        return 0;
 }
=======%<=======

While running:
> sudo ./perf record -e mem:<address of __do_softirq>:x -ag -- sleep 180

and

> dd if=/dev/sda of=/dev/null bs=512 iflag=direct;

This should cause lots of interrupts from /dev/sda, and cause the
tracing code to step between irq_stack and the original task stack
frequently. The BUG_ON() doesn't fire, and the perf trace output looks
correct.


My only theory is that there is an off by one, and its reading what was
x29 instead. This wouldn't show up in these tests, but might be a
problem for aarch32 user-space, as presumably x29==0 when it switches to
aarch64 mode for el0_irq(). I will try this tomorrow.



Thanks,

James
