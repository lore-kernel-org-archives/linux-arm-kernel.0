From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sun, 6 Dec 2015 22:56:15 +0900
Subject: [PATCH v8 0/4] arm64: Add support for IRQ stack
In-Reply-To: <1B79BF57-9B2D-49C2-9C09-48EF52BF2171@gmail.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1B79BF57-9B2D-49C2-9C09-48EF52BF2171@gmail.com>
Message-ID: <DE975D62-830B-43E4-ABC0-11F1B91E6D25@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dec 4, 2015, at 9:17 PM, Jungseok Lee wrote:
> On Dec 4, 2015, at 8:02 PM, James Morse wrote:
> 
> Hi James,
> 
>> This consolidated series adds a per-cpu irq_stack, which will eventually allow
>> us to reduce the size of task stacks.
>> 
>> Code in entry.S switches to the per-cpu irq_stack when irq_count is zero.
>> This counter is updated in do_softirq_own_stack(), which is called before
>> __do_softirq() re-enables interrupts, which could cause recursive use of the
>> irq stack.
>> 
>> sp_el0 is used as a scratch register to store struct thread_info during el1
>> execution, this means code to find it by masking the stack pointer no longer
>> needs to be inlined. This also lets us remove the alignment requirements for
>> the irq stack, (task stacks still need to be naturally aligned).
>> 
>> Patch 2 is a combination of Akashi Takahiro's 'arm64: unwind_frame for
>> interrupt stack' and 'arm64: fix dump_backtrace() to show correct pt_regs at
>> interrupt', both of which need to be present before irq_stack is enabled in
>> Patch 3.
>> 
>> Patch 4 is new, following Catalin's comments, but I don't think it is
>> necessary unless we also decrease the stack size, which I don't think we
>> should do immediatly - it would be good to collect some max_stack_size values
>> for various workloads first.
>> 
>> This series is based on the v4.4-rc3
>> The series can be pulled from git://linux-arm.org/linux-jm.git -b irq_stack/v8
>> 
>> Comments welcome,
> 
> At first glance, this series looks mature ;) I will leave feedbacks after playing
> with this.

I will hold off until the IRQ count management scheme is determined, which is
an important design point.

Best Regards
Jungseok Lee
