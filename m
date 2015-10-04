From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 4 Oct 2015 23:32:41 +0900
Subject: [PATCH v3] arm64: Introduce IRQ stack
In-Reply-To: <560EAF9F.6090604@arm.com>
References: <1442923918-11289-1-git-send-email-jungseoklee85@gmail.com>
 <560EAF9F.6090604@arm.com>
Message-ID: <67E35231-C136-49B9-B0EF-CD0A2B21752A@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Oct 3, 2015, at 1:23 AM, James Morse wrote:

> Hi,

Hi James,

> 
> On 22/09/15 13:11, Jungseok Lee wrote:
>> Currently, kernel context and interrupts are handled using a single
>> kernel stack navigated by sp_el1. This forces a system to use 16KB
>> stack, not 8KB one. This restriction makes low memory platforms suffer
>> from memory pressure accompanied by performance degradation.
>> 
>> This patch addresses the issue as introducing a separate percpu IRQ
>> stack to handle both hard and soft interrupts with two ground rules:
>> 
>>  - Utilize sp_el0 in EL1 context, which is not used currently
>>  - Do not complicate current_thread_info calculation
>> 
>> It is a core concept to directly retrieve struct thread_info from
>> sp_el0. This approach helps to prevent text section size from being
>> increased largely as removing masking operation using THREAD_SIZE
>> in tons of places.
> 
> One observed change in behaviour:
> Any stack-unwinding now stops at el1_irq(), which is the bottom of the irq
> stack. This shows up with perf (using incantation [0]), and with any calls
> to dump_stack() (which actually stops the frame before el1_irq()).
> 
> I don't know if this will break something, (perf still seems to work) - but
> it makes the panic() output less useful, as all the 'other' cpus print:

Agreed. A process stack should be walked to deliver useful information.

There are two approaches I've tried as experimental.

1) Link IRQ stack to a process one via frame pointer
As saving x29 and elr_el1 into IRQ stack and then updating x29, IRQ stack
could be linked to a process one. It is similar to your patch except some
points. However, it might complicate "stack tracer on ftrace" issue.

2) Walk a process stack followed by IRQ one
This idea, which is straightforward, comes from x86 implementation [1]. The
approach might be orthogonal to "stack tracer on ftrace" issue. In this case,
unfortunately, a top bit comparison of stack pointer cannot be adopted due to
a necessity of a final snapshot of a process stack pointer, which is struct
irq_stack::thread_sp in v2 patch.

Which one is your favorite? or any ideas?

BTW, I have another question. Is it reasonable to introduce THREAD_SIZE as a
kernel configuration option like page size for the sake of convenience because
a combination of ARM64 and a small ram is not unusual in real practice? Needless
to say, a patch, reducing the size, can be managed as out of mainline tree one.

[1] arch/x86/kernel/dumpstack_64.c

Best Regards
Jungseok Lee
