From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 28 Jan 2016 08:50:40 +0000
Subject: A problem about SPI Interrupt Configuration
In-Reply-To: <56A97DB8.2000402@huawei.com>
References: <569EF315.2060203@huawei.com>
 <20160122075741.6a704855@why.wild-wind.fr.eu.org>
 <56A97DB8.2000402@huawei.com>
Message-ID: <56A9D660.2060905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 02:32, Yang Yingliang wrote:
> 
> 
> On 2016/1/22 15:57, Marc Zyngier wrote:
>> On Wed, 20 Jan 2016 10:38:13 +0800
>> Yang Yingliang <yangyingliang@huawei.com> wrote:
>>
>> Hi Yang,
>>
>>> Hi, Marc
>>>
>>> I got some error messages "RWP timeout, gone fishing".
>>>
>>> The case is :
>>>
>>> 			CPU0												CPU1
>>> 													acquire desc->lock in __setup_irq()
>>> 															enable irq in __setup_irq()
>>> read iar in gic_handle_irq()
>>> waiting for desc->lock in handle_fasteoi_irq()
>>> 												call gic_set_affinity() from setup_affinity()
>>> 												waiting for the irq deactive in gic_do_wait_for_rwp()
>>>
>>>
>>> The hardware will not clear GICD_CTLR.RWP until the interrupt is not
>>> active. The interrupt is keeping active while it's waiting for
>>> desc->lock on cpu0. But the lock is hold by cpu1 while it's waiting for
>>> the interrupt is not active. It causes a deadlock here in 1s.
>>>
>>>
>>> And the GICv3 SPEC says:
>>>
>>> 4.5.5 SPI Interrupt Configuration
>>> To configure an SPI interrupt, to ensure that interrupts are never
>>> distributed using partially updated configuration
>>> information, software must:
>>> o Ensure the interrupt is not active
>>> o Ensure that the interrupt is disabled
>>> o This might be done either by writing to GICD_CTLR to clear the enables
>>> for a group, or
>>> o By writing to GICD_ICENABLERn to clear the Enable bit of the interrupt
>>> (see section 5.3.11).
>>> o In both cases, software must poll GICD_CTLR.RWP to ensure the effects
>>> are visible (see section
>>> 5.3.20).
>>> o Program the routing (if appropriate), priority and group
>>> o Enable the interrupt (if required)
>>>
>>> Because it says "Ensure the interrupt is not active", so I can not tell
>>> it is a hardware or software problem.
>>>
>>> Can you please give some advice?
>>
>> Thanks for the accurate description of the problem. This looks to be a
>> core issue, or at least a problem between core code and the way the GIC
>> behaves, unfortunately. The architecture expects the interrupt to be
>> fully configured before it is enabled and made active, while the core
>> code does this the other way around.
>>
>> Can you please have a go at the patch below and let me know if it
>> improve things? This is just a test, and definitely not the complete
>> solution, but I'd like to find out if I'm on the right track.
>>
>> Thanks,
>>
>> 	M.
>>
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 0eebaee..e5802fb 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -1303,12 +1303,6 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>>   		if (new->flags & IRQF_ONESHOT)
>>   			desc->istate |= IRQS_ONESHOT;
>>
>> -		if (irq_settings_can_autoenable(desc))
>> -			irq_startup(desc, true);
>> -		else
>> -			/* Undo nested disables: */
>> -			desc->depth = 1;
>> -
>>   		/* Exclude IRQ from balancing if requested */
>>   		if (new->flags & IRQF_NOBALANCING) {
>>   			irq_settings_set_no_balancing(desc);
>> @@ -1318,6 +1312,12 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>>   		/* Set default affinity mask once everything is setup */
>>   		setup_affinity(desc, mask);
>>
>> +		if (irq_settings_can_autoenable(desc))
>> +			irq_startup(desc, true);
>> +		else
>> +			/* Undo nested disables: */
>> +			desc->depth = 1;
>> +
>>   	} else if (new->flags & IRQF_TRIGGER_MASK) {
>>   		unsigned int nmsk = new->flags & IRQF_TRIGGER_MASK;
>>   		unsigned int omsk = irq_settings_get_trigger_mask(desc);
>>
> 
> This patch can avoid the case I said in this mail.
> But in other case like set affinity by the /proc/irq/x/smp_affinity,
> it's will have the same problem _if_ the hardware is waiting for deactive.

Indeed, and the more I think of it, the more I'm convinced that what you
are looking at is a hardware bug.

If RWP is gated by an interrupt being active, or the disable is gated by
the interrupt being active, then you will end-up in all kind of horrible
problems that software *cannot* solve. The text you quoted earlier is
not something that can be enforced from a software perspective (it
contains a race condition that cannot be avoided).

Furthermore, take the example of a VM that has an active interrupt
linked to a physical interrupt (HW bit set in the List Register) while
you are changing the affinity on the host. Nothing guarantees that the
deactivate will *ever* happen (the guest could decide it doesn't need to
do it, or takes a very long time to do so). In that case, you will
deadlock the same way, and there is nothing you can do from a SW PoV to
solve it.

I suggest you get back to your HW folks, and explain that what they have
here is not a viable design.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
