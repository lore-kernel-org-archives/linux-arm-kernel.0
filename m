From: james.morse@arm.com (James Morse)
Date: Mon, 05 Oct 2015 18:24:09 +0100
Subject: [PATCH v3] arm64: Introduce IRQ stack
In-Reply-To: <56121A97.7000600@linaro.org>
References: <1442923918-11289-1-git-send-email-jungseoklee85@gmail.com>
 <560EAF9F.6090604@arm.com> <67E35231-C136-49B9-B0EF-CD0A2B21752A@gmail.com>
 <56121A97.7000600@linaro.org>
Message-ID: <5612B239.102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/15 07:37, AKASHI Takahiro wrote:
> On 10/04/2015 11:32 PM, Jungseok Lee wrote:
>> On Oct 3, 2015, at 1:23 AM, James Morse wrote:
>>> One observed change in behaviour:
>>> Any stack-unwinding now stops at el1_irq(), which is the bottom of the irq
>>> stack. This shows up with perf (using incantation [0]), and with any calls
>>> to dump_stack() (which actually stops the frame before el1_irq()).
>>>
>>> I don't know if this will break something, (perf still seems to work) - but
>>> it makes the panic() output less useful, as all the 'other' cpus print:
>>
>> Agreed. A process stack should be walked to deliver useful information.
>>
>> There are two approaches I've tried as experimental.
>>
>> 1) Link IRQ stack to a process one via frame pointer
>> As saving x29 and elr_el1 into IRQ stack and then updating x29, IRQ stack
>> could be linked to a process one. It is similar to your patch except some
>> points. However, it might complicate "stack tracer on ftrace" issue.
> 
> Well, as far as object_is_on_stack() works correctly, stack tracer will not
> follow an interrupt stack even if unwind_frame() might traverse from
> an interrupt stack to a process stack. See check_stack().
> 
> Under this assumption, I'm going to simplify my "stack tracer" bugfix
> by removing interrupt-related nasty hacks that I described in RFC.
> 
> Thanks,
> -Takahiro AKASHI
> 
> 
>> 2) Walk a process stack followed by IRQ one
>> This idea, which is straightforward, comes from x86 implementation [1]. The
>> approach might be orthogonal to "stack tracer on ftrace" issue. In this
>> case,

x86 has to walk interrupt/exception stacks because the order may be:
process -> hw_irq -> debug_exception -> double_fault.
Where each of these could have its own stack, the code needs to determine
the correct order to produce a correct stack trace.

Our case is a lot simpler, as we could only ever have two, and know the
order. We only need to walk the irq stack if we are currently using it, and
we always know the process stack is last.

I would go with the first option, being careful of stack corruption when
stepping between them.


>> unfortunately, a top bit comparison of stack pointer cannot be adopted
>> due to
>> a necessity of a final snapshot of a process stack pointer, which is struct
>> irq_stack::thread_sp in v2 patch.

I'm not sure I follow you here.

We can check if regs->sp is an irq stack by comparing it with the per-cpu
irq_stack value, (top bits comparison). Then we know that the last
frame-pointer (in your (1) above), will point to the process stack, at
which point we can walk onto that stack.


>> BTW, I have another question. Is it reasonable to introduce THREAD_SIZE as a
>> kernel configuration option like page size for the sake of convenience
>> because
>> a combination of ARM64 and a small ram is not unusual in real practice?

We want the smallest safe value. It's probably best leaving as it is for
now - once we have this feature, we can collect maximum stack-usage sizes
for different platforms and workloads, and decide on the smallest safe value.


Thanks,

James
