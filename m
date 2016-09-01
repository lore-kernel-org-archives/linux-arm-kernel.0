From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 1 Sep 2016 10:03:30 +0100
Subject: [PATCH] generic: Add the exception case checking routine for ppi
 interrupt
In-Reply-To: <57C7E3B6.1040605@huawei.com>
References: <1472530639-21616-1-git-send-email-majun258@huawei.com>
 <57C548D0.3090700@arm.com> <57C5617B.6080801@huawei.com>
 <57C568F8.20802@arm.com> <20160830112113.GE1223@leverpostej>
 <57C67ABE.908@huawei.com> <57C696DA.4090301@arm.com>
 <57C7E3B6.1040605@huawei.com>
Message-ID: <57C7EEE2.7080205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/16 09:15, majun (F) wrote:
> 
> 
> ? 2016/8/31 16:35, Marc Zyngier ??:
>> On 31/08/16 07:35, majun (F) wrote:
> [...]
>>>>
>>>
>>> I just checked the status of irq 30 during capture kernel booting.
>>>
>>> The irq 30 status is: mask, pending after arch_timer_starting_cpu() called.
>>> Because irq 30 triggered only 1 time during capture kernel booting,
>>> I think this problem maybe happened in the case like:
>>> 1:irq 30 triggered, but not acked by cpu yet.
>>> 2:local_irq_disable() called
>>> 3:system reboot -->capture kernel booting
>>> 4:local_irq_enable()
>>> 5:irq 30 acked by CPU.
>>>
>>> Is this case possible?
>>
>> I can't see how, because you've missed:
>>
>> 3b: All PPIs are disabled as each CPU comes up
>>
>> So for (5) to occur, I can only see two possibilities:
>> (a) either something else is enabling the timer PPI
> 
> I checked the whole process, the irq 30 alway keeping disabled.
> 
>> (b) your GIC doesn't correctly retire a pending PPI that is being disabled
> 
> According to our hardware guy said, GIC in our system has problem in this case.
> Usually, when we mask irq 30, the interrupt which in pending status but not acked by cpu
> should be released/cleared by hardware, but actually, we did't do like this in our system.

That's crazy. This means that you cannot reliably mask interrupts. :-(
Does this only affect PPIs? Or does it affect all interrupt types?

> So, this conclusion just same as you assumption.
> 
> Do you have any suggestion or workaround for this problem?

Well, this issue goes way beyond the hack you wanted to add to the
generic code, and it should probably be addressed in the GIC code
itself, as an implementation specific workaround. Without knowing the
details of the erratum, it is difficult to think of that would be
required. I can come up with something like this:

	irqnr = gic_read_iar();
	if (unlikely(!is_enabled(irqnr))) {
		gic_write_eoir(irqnr);
		if (static_key_true(&supports_deactivate))
			gic_write_dir(irqnr);
		set_pending(irqnr);
		continue;
	}

Performance will suffer (an extra MMIO access on the fast path). If LPIs
are also affected, then the ITS code also needs to be involved, and
that's not going to be pretty either. This code will have to be enabled
at runtime, and handled like other erratum we have in this code.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
