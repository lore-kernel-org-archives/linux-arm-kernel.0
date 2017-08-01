From: panand@redhat.com (Pratyush Anand)
Date: Tue, 1 Aug 2017 09:48:40 +0530
Subject: [PATCH v3 0/5] ARM64: disable irq between breakpoint and step
 exception
In-Reply-To: <597F65BD.3070200@arm.com>
References: <cover.1501496603.git.panand@redhat.com> <597F65BD.3070200@arm.com>
Message-ID: <e78a8e67-48ab-421c-c316-3b55821f0eec@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Monday 31 July 2017 10:45 PM, James Morse wrote:
> Hi Pratyush,
> 
> On 31/07/17 11:40, Pratyush Anand wrote:
>> samples/hw_breakpoint/data_breakpoint.c passes with x86_64 but fails with
>> ARM64. Even though it has been NAKed previously on upstream [1, 2], I have
>> tried to come up with patches which can resolve it for ARM64 as well.
>>
>> I noticed that even perf step exception can go into an infinite loop if CPU
>> receives an interrupt while executing breakpoint/watchpoint handler. So,
>> event though we are not concerned about above test, we will have to find a
>> solution for the perf issue.
> 
> This caught my eye as I've been reworking the order the DAIF flags get
> set/cleared[0].

Thanks for pointing to your series.
> 
> What causes your infinite loop? Is it single-stepping kernel_exit? If so patch 4
> "arm64: entry.S mask all exceptions during kernel_exit" [1] may help.

Flow is like this:
- A SW or HW breakpoint exception is being generated on a cpu lets say CPU5
- Breakpoint handler does something which causes an interrupt to be active on 
the same CPU. In fact there might be many other reasons for an interrupt to be 
active on a CPU while breakpoint handler was being executed.
- So, as soon as we return from breakpoint exception, we go to the IRQ 
exception handler, while we were expecting a single step exception.

I do not think that your patch 4 will help here. That patch disables interrupt 
while kernel_exit will execute.So,until we enable PSR I bit, we can not stop 
an interrupt to be generated before step exception.

You can easily reproduce the issue with following:
# insmod data_breakpoint.ko ksym=__sysrq_enabled
# cat /proc/sys/kernel/sysrq

Where data_breakpoint.ko is module from samples/hw_breakpoint/data_breakpoint.c.

> 
> If its more like "single stepping something we didn't expect" you will get the
> same problem if we take an SError. (which with that series is unmasked ~all the
> time).
> Either way this looks like a new and exciting way of hitting the 'known issue'
> described in patch 12 [3].
> 
> 
> Would disabling MDSCR_EL1.SS if we took an exception solve your problem?
> 
> If so, I think we should add a new flag, 'TIF_KSINGLESTEP', causing us to
> save/restore MDSCR_EL1.SS into pt_regs on el1 exceptions. This would let us
> single-step without modifying the DAIF flags for the location we are stepping,
> and allow taking any kind of exception from that location.
> 
> We should disable nested users of single-step, we can do that by testing the
> flag, print a warning then pretend we missed the breakpoint. (hence it needs to
> be separate from the user single-step flag).
> 
> 
> Thanks,
> 
> James
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg596684.html
> [1] https://www.spinics.net/lists/arm-kernel/msg596686.html
> [2] https://www.spinics.net/lists/arm-kernel/msg596689.html
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Regards
Pratyush
