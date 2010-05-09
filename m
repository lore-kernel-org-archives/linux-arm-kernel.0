From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 9 May 2010 21:07:08 +0800
Subject: [PATCH] ARM: fix inbalance of hardirqs trace before return to
	user or exception
In-Reply-To: <20100509091856.GA29763@n2100.arm.linux.org.uk>
References: <1273377379-18078-1-git-send-email-tom.leiming@gmail.com>
	<20100509091856.GA29763@n2100.arm.linux.org.uk>
Message-ID: <i2kd82e647a1005090607w24424d8p4b524007a9c7fe0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/9 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, May 09, 2010 at 11:56:19AM +0800, tom.leiming at gmail.com wrote:
>> From: Ming Lei <tom.leiming@gmail.com>
>>
>> This patch introduces macro of trace_ret_hardirqs_on, which will
>> call asm_trace_hardirqs_on if I flag in the stored CPSR is zero.
>>
>> The patch adds trace_ret_hardirqs_on before returning to user
>> or exception mode once disable_irq was called explicitly, which does
>> fix the inbalance of hardirqs trace and make lockdep happy. The patch
>> does fix this kind of lockdep warning below:
>
> I'm not convinced that this is required in all the places you're adding
> it. ?Eg, in the return-to-user case, userspace _always_ has IRQs
> enabled, and when we enter kernel space from the exception handler, we
> always enable IRQs. ?Returning from any syscall with IRQs disabled is a
> bug, and so that _should_ produce a warning.
>
> In fact, returning to user mode with IRQs disabled in _any_ case is a
> bug.

The patch only adds hardirqs on event to make lockdep see it.
Maybe in this paths, we should not trace the hardirqs off event, then we
will not need to add the hardirqs on event before return to user. If
you agree, I'll
write another patch to do it.

>
> Please provide your reasoning for adding this to every path.

The patch adds this in places which disable_irq is called before returning to
user or kernel mode from sys-call or exception. This can keep hardirqs trace
balance to remove lockdep warning of "unannotated irqs-on" since disable_irq
may call trace_hardirqs_off to trace hardirqs off event and lockdep
will see it.

If lockdep warning is produced, lockdep does not work afterwards. It is the
purpose of the patch.

>
> Finally, using asm_trace_hardirqs_on is extremely expensive, and in
> many cases the register saving is completely wasteful. ?That's why
> places were doing this:
>
> #ifdef CONFIG_TRACE_IRQFLAGS
> ? ? ? ?tst ? ? r4, #PSR_I_BIT
> ? ? ? ?bleq ? ?trace_hardirqs_on
> #endif
>
> which is much more efficient.

Yes, I'll use the efficient way in v2 of the patch.


-- 
Lei Ming
