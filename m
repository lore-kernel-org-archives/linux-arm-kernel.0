From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Mon, 21 Sep 2015 21:14:38 +0900
Subject: [PATCH v2] arm64: Introduce IRQ stack
In-Reply-To: <20150921092538.GB26917@e104818-lin.cambridge.arm.com>
References: <1442155337-7020-1-git-send-email-jungseoklee85@gmail.com>
 <20150917111735.GN25444@e104818-lin.cambridge.arm.com>
 <3C2C78B3-4669-4DBA-98DC-362EB762FD9C@gmail.com>
 <CFF333D1-E771-4C50-902A-444DAE76C163@gmail.com>
 <20150917162110.GO25444@e104818-lin.cambridge.arm.com>
 <6A6F7BF2-D75E-4D8D-B0F7-45294C4C4426@gmail.com>
 <20150918150302.GA24449@e104818-lin.cambridge.arm.com>
 <20150918153150.GB24449@e104818-lin.cambridge.arm.com>
 <FE4C26C5-C759-4924-96A5-9D5F6A78CD74@gmail.com>
 <20150921092538.GB26917@e104818-lin.cambridge.arm.com>
Message-ID: <8947726D-C969-4691-8D29-7C552015AC2A@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 21, 2015, at 6:25 PM, Catalin Marinas wrote:
> On Sat, Sep 19, 2015 at 05:44:37PM +0900, Jungseok Lee wrote:
>> On Sep 19, 2015, at 12:31 AM, Catalin Marinas wrote:
>>> On Fri, Sep 18, 2015 at 04:03:02PM +0100, Catalin Marinas wrote:
>>>> On Fri, Sep 18, 2015 at 09:57:56PM +0900, Jungseok Lee wrote:
>>>>> On Sep 18, 2015, at 1:21 AM, Catalin Marinas wrote:
>>>>>> So, without any better suggestion for current_thread_info(), I'm giving
>>>>>> up the idea of using SPSel == 0 in the kernel. I'll look at your patch
>>>>>> in more detail. BTW, I don't think we need the any count for the irq
>>>>>> stack as we don't re-enter the same IRQ stack.
> [...]
>>>>> BTW, in this context, it is only meaningful to decide whether a current interrupt
>>>>> is re-enterrant or not. Its actual value is not important, but I could not figure
>>>>> out a better implementation than this one yet. Any suggestions are welcome!
> [...]
>>> Another thought (it seems that x86 does something similar): we know the
>>> IRQ stack is not re-entered until interrupts are enabled in
>>> __do_softirq. If we enable __ARCH_HAS_DO_SOFTIRQ, we can implement an
>>> arm64-specific do_softirq_own_stack() which increments a counter before
>>> calling __do_softirq. The difference from your patch is that
>>> irq_stack_entry only reads such counter, doesn't need to write it.
>>> 
>>> Yet another idea is to reserve some space in the lower address part of
>>> the stack with a "stack type" information. It still requires another
>>> read, so I think the x86 approach is probably better.
>> 
>> I've realized both hardirq and softirq should be handled on a separate stack
>> in order to reduce kernel stack size, which is a principal objective of this
>> patch.
> 
> The objective is to reduce the kernel thread stack size (THREAD_SIZE).
> This can get pretty deep on some syscalls and together with IRQs (hard
> or soft), we run out of stack.
> 
> So, for now, just stick to reducing THREAD_SIZE by moving the IRQs off
> this stack. If we later find that hardirqs + softirqs can't fit on the
> same _IRQ_ stack, we could either increase it or allocate separate stack
> for softirqs. These are static anyway, allocated during boot. But I
> wouldn't get distracted with separate hard and soft IRQ stacks for now,
> I doubt we would see any issues (when a softirq runs, the IRQ stack is
> pretty much empty, apart from the pt_regs).

Completely agreed.

> 
>> (If I'm not missing something) It is not possible to get a big win
>> with implementing do_softirq_own_stack() since hardirq is handled using a task
>> stack. This prevents a size of kernel stack from being decreased.
> 
> What I meant is that hard and soft IRQs both run on the IRQ stack (not
> the thread stack). But instead of incrementing a counter every time you
> take a hard IRQ, just increment it in do_softirq_own_stack() with a
> simple read+check in elX_irq. The "own_stack" is not the most
> appropriate name because we still have the same IRQ stack but I'm not
> really bothered about this.

Personally I'm favor of James's top-bit comparison idea since there is no
{load|store} operation in irq_stack_exit macro by utilizing one of callee-
saved registers.

I will do re-spin soon with the changes based on feedbacks in this thread
for clarification. It would be better to trace a change history of this patch.

>> However, it would be meaningful to separate hard IRQ stack and soft IRQ one
>> as the next step.
> 
> Only if we see IRQ stack overflowing, otherwise I don't think it's worth
> the effort.

Okay.

Thanks for comments!

Best Regards
Jungseok Lee
