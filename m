From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 10 Jun 2014 11:43:59 +0100
Subject: [PATCH v4 02/20] arm64: initial support for GICv3
In-Reply-To: <5396820F.3000806@huawei.com> (Abel's message of "Tue, 10 Jun
 2014 04:57:03 +0100")
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-3-git-send-email-marc.zyngier@arm.com>
 <539020A5.6070807@huawei.com>
 <87zjhrvj8g.fsf@approximate.cambridge.arm.com>
 <539533B6.201@huawei.com>
 <87bnu2iifr.fsf@approximate.cambridge.arm.com>
 <5396820F.3000806@huawei.com>
Message-ID: <87ppihf3io.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10 2014 at  4:57:03 am BST, Abel <wuyun.wu@huawei.com> wrote:
> On 2014/6/9 16:41, Marc Zyngier wrote:
>
>> On Mon, Jun 09 2014 at  5:10:30 am BST, Abel <wuyun.wu@huawei.com> wrote:
>>> As for the interrupts here, the ones entered into this 'if' clause, I
>>> think they are expected already been mapped into this irq_domain.
>> 
>> Mapped or not is not the problem. Think of a (broken) implementation
>> that would generate random IDs in the irq_nr..1021 range. You'd end up
>> with the deadlock situation I've outlined above.
>> 
>> And actually, irq_find_mapping can fail, and I should handle this.
>
>
> Yes, makes sense. This case should be properly handled.
> And I still have two questions.
> a) Does this scenario really exist or necessary? I mean, part of interrupts
>    mapped while others which belongs to the same interrupt controller are not.

Not that I know of. But consider this cheap defensive programming. It is
actually cheaper to check against a constant boundary than do a load and
check against a variable. Safer, faster.

> b) Why 1021?

The maximum SPI ID is 1020.

>
>>>>
>>>>>> +                     irqnr = irq_find_mapping(gic_data.domain, irqnr);
>>>>>> +                     handle_IRQ(irqnr, regs);
>>>>>> +                     continue;
>>>>>> +             }
>>>>>> +             if (irqnr < 16) {
>>>>>> +                     gic_write_eoir(irqnr);
>>>>>> +#ifdef CONFIG_SMP
>>>>>> +                     handle_IPI(irqnr, regs);
>>>>>> +#else
>>>>>> +                     WARN_ONCE(true, "Unexpected SGI received!\n");
>>>>>> +#endif
>>>>>> +                     continue;
>>>>>> +             }
>>>>>> +     } while (irqnr != 0x3ff);
>>>>>> +}
>>>>>> +
>>>>>> +static void __init gic_dist_init(void)
>>>>>> +{
>>>>>> +     unsigned int i;
>>>>>> +     u64 affinity;
>>>>>> +     void __iomem *base = gic_data.dist_base;
>>>>>> +
>>>>>> +     /* Disable the distributor */
>>>>>> +     writel_relaxed(0, base + GICD_CTLR);
>>>>>
>>>>>
>>>>> I'm not sure whether waiting for write pending here is
>>>>> necessary. What do you think?
>>>>
>>>> Hmmm. That's a good point. The spec says the RWP tracks the completion
>>>> of writes that change (among other things) the state of an interrupt
>>>> group enable. But the next line will perform a wait_for_rwp anyway after
>>>> having disabled all SPIs. So no, I don't think we need to wait. We
>>>> guaranteed to get a consistent state after the call to gic_dist_config.
>>>
>>>
>>> The spec also says that software must ensure the interrupt is disabled before
>>> changing its routing/priority/group information, see chapter 4.5.5 in v18.
>> 
>> That's only to ensure consistency when a single interrupt is being
>> reconfigured, and that's what the code already does. In this particular
>> context, waiting for RWP looks completely superfluous.
>
> It's reasonable to think GIC having been enabled by boot loader or
> something else in the boot procedure. And here not waiting for RWP may
> cause hardware implementation defined behavior, that is configuring an
> enabled interrupt. It's beyond the scope of the GIC architecture, and
> vendors also don't want to see this happen.

Well, I guess that since this is a one-off thing, it doesn't really add
an extra synchronization. As long as it gives you peace of mind... ;-)

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
