From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 16 Jul 2015 14:12:14 +0100
Subject: [PATCH 1/2] irqchip: gic: enable SKIP_SET_WAKE and MASK_ON_SUSPEND
In-Reply-To: <55A7844D.907@arm.com>
References: <1436971109-20189-1-git-send-email-sudeep.holla@arm.com>
 <55A7844D.907@arm.com>
Message-ID: <55A7ADAE.70402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/07/15 11:15, Marc Zyngier wrote:
> Hi Sudeep,
>
> On 15/07/15 15:38, Sudeep Holla wrote:
>> The GIC controller doesn't provides any facility to configure the wakeup
>> sources. For the same reason, GIC chip implementation can't provide
>> irq_set_wake functionality, but that results in the irqchip core
>> preventing the systems from entering sleep states like "suspend to RAM".
>>
>> The GICv1/v2 controllers supports wakeup events. It signals these wakeup
>> events even when CPU interface is disabled which means the wakeup
>> outputs are always enabled with the required logic in always-on domain.
>> An implementation can powerdown the GIC completely, but then the wake-up
>> must be relayed to some control logic within the power controller that
>> acts as wake-up interrupt controller.
>>
>> Setting the IRQCHIP_SKIP_SET_WAKE flags will ensure that the interrupts
>> from GIC can work as wakeup interrupts and resume from suspend-to-{idle,
>> ram}. The wakeup interrupt sources need to use enable_irq_wake() and the
>> irqchip core will then set the IRQD_WAKEUP_STATE flag.
>>
>> Also it's always safer to mask all the non wakeup interrupts are masked
>> at the chip level when suspending. The irqchip infrastructure can handle
>> masking of those interrupts at the chip level. The chip implementation
>> just have to indicate that with IRQCHIP_MASK_ON_SUSPEND.
>>
>> This patch enables IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND so
>> that the irqchip core allows and handles the power managemant wake up
>> modes.
>
> I don't have any strong feeling against this series (anything that
> removes hacks from the GIC code has my full and unconditional support),
> but I'd just like to make sure I understand the issue.
>

Thanks for having look at this. One of the reason for pushing this is I
see more platforms[1] adding S2R support are needing this.

> There is (AFAIU) 3 cases when suspending:
>

Yes I can't think of any more scenarios, hopefully people will shout
here if they have one :). I also doubt that there are few cascaded/gpio
interrupt controllers that have wakeup source but not setting the
parent IRQ(GIC) as wakeup. With IRQCHIP_MASK_ON_SUSPEND, hopefully it
will get caught and fixed.

> 1) The GIC is in an always-on domain: SKIP_SET_WAKE is set, because
> there is nothing to do (we can always wake up). Problem solved.
>

Yes, simplest scenario.

> 2) The GIC gets powered off, but we have additional HW that will take
> care of the wake-up: this is implemented by a stacked irqchip that will
> do the right thing: irq_set_wake only looks at the top level irqchip, so
> the GIC flag isn't observed, and this should work (maybe by luck...).
>

True, but I have not seen any system with non-GIC controller at the top
level so far from the DT in the mainline. But yes, if there are they
need to implement stacked irqchip and these flags shouldn't affect the
wakeup in that case.

> 3) The GIC gets powered off and nothing will wake us up. I'd say that in
> this case, having programmed a wake-up interrupt is a bit silly, and
> doing S2R is equivalent to committing suicide. Do we have any mechanism
> that would avoid getting in that situation?
>

Right, I hope we find if there are any such systems as part of this
discussion. Ideally they should not register any suspend_ops in this
case to prevent system entering suspend state.

Regards,
Sudeep

[1] https://lkml.org/lkml/2015/6/30/466
