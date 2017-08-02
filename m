From: panand@redhat.com (Pratyush Anand)
Date: Thu, 3 Aug 2017 00:16:04 +0530
Subject: [PATCH v3 0/5] ARM64: disable irq between breakpoint and step
 exception
In-Reply-To: <59820835.1020301@arm.com>
References: <cover.1501496603.git.panand@redhat.com>
 <597F65BD.3070200@arm.com> <e78a8e67-48ab-421c-c316-3b55821f0eec@redhat.com>
 <59820835.1020301@arm.com>
Message-ID: <883651ba-2178-b5cf-7f6c-bfb2f6999a01@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

Thanks for your analysis.

On Wednesday 02 August 2017 10:43 PM, James Morse wrote:
> Hi Pratyush,
> 
> On 01/08/17 05:18, Pratyush Anand wrote:
>> On Monday 31 July 2017 10:45 PM, James Morse wrote:
>>> On 31/07/17 11:40, Pratyush Anand wrote:
>>>> samples/hw_breakpoint/data_breakpoint.c passes with x86_64 but fails with
>>>> ARM64. Even though it has been NAKed previously on upstream [1, 2], I have
>>>> tried to come up with patches which can resolve it for ARM64 as well.
>>>>
>>>> I noticed that even perf step exception can go into an infinite loop if CPU
>>>> receives an interrupt while executing breakpoint/watchpoint handler. So,
>>>> event though we are not concerned about above test, we will have to find a
>>>> solution for the perf issue.
> 
>> You can easily reproduce the issue with following:
>> # insmod data_breakpoint.ko ksym=__sysrq_enabled
>> # cat /proc/sys/kernel/sysrq
> 
> Thanks, that happily dump-stacks forever. Your first three patches fix the
> stepping over the watchpoint, I've had a go at fixing the interrupt interaction,
> (instead of just masking interrupts).
> 
> gdb single-step works, as does kprobes, FWIW for those three:
> Tested-by: James Morse <james.morse@arm.com>
> 
> 
>>> What causes your infinite loop?
> 
>> Flow is like this:
>> - A SW or HW breakpoint exception is being generated on a cpu lets say CPU5
>> - Breakpoint handler does something which causes an interrupt to be active on
>> the same CPU. In fact there might be many other reasons for an interrupt to be
>> active on a CPU while breakpoint handler was being executed.
>> - So, as soon as we return from breakpoint exception, we go to the IRQ exception
>> handler, while we were expecting a single step exception.
> 
> What breaks when this happens?

I think, as soon as we call enable_dbg from el1_irq, step exception will be 
generated, and we will be stepping very first instruction after enable_dbg 
which is not expected by single step handler.

> 
> With your reproducer and the first three patches I see it hitting the watchpoint
> multiple times and stepping the irq handle
Lets say we were executing instruction from address 0x2000 when watchpoint 
exception occurred. We programmed, ELR with 0x2000 for single stepping, 
however we received an interrupt before instruction at 0x2000 could have been 
single stepped.

Now if 0x3010 is the address next to enable_dbg from el1_irq, then the 
instruction from address 0x3010 will be single stepped. We will jump back to 
0x2000 again after addressing el1_irq, but that is no more available for 
single-stepping and while executing instruction at that address we again land 
into watchpoint exception handler.

I do not have a HW debugger, but this is what looked like while going through 
code.

> 
> I think we have two or three interacting bugs here. I'm not convinced masking
> interrupts is the best fix as the data abort handler inherits this value. We
> might mask interrupts for a fault that can't be handled with interrupts masked.
> 

In my understanding problems are:
(1) Single stepping of unwanted instruction (ie. instruction  next to 
enable_dbg from el1_irq)
(2) We do not have memory at the end of el1_irq, so that we can set watchpoint 
exception generating instruction for single stepping.

I think, we can find a way to take care for (2), but not sure how (1) can be 
taken care, without the approach I am taking.

> I will post some RFC/fixes, but need to get my head round the debug/exception
> interaction in the ARM-ARM first!
> 
> 
> Thanks,
> 
> James
> 

-- 
Regards
Pratyush
