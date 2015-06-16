From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 16 Jun 2015 21:32:08 +0900
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set on
 suspend
In-Reply-To: <557EE890.2050001@collabora.co.uk>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
 <557AB00C.5040606@arm.com> <557AC23D.8040602@collabora.co.uk>
 <557AC85E.5070705@arm.com> <557AD728.7090908@collabora.co.uk>
 <557B34A7.4090507@collabora.co.uk>
 <CAD=FV=UQF+n8AjSXYajqUb0qswcoUrSgnsasV82JaS3dBtNO8Q@mail.gmail.com>
 <557E82BC.7080203@collabora.co.uk> <557E947B.3030804@arm.com>
 <557EE890.2050001@collabora.co.uk>
Message-ID: <CA+Ln22H8A5xY4S=yEnftTKUdsAM3Oib2gZV_GG=m6nENn2fw0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-16 0:00 GMT+09:00 Javier Martinez Canillas
<javier.martinez@collabora.co.uk>:
> Hello Sudeep,
>
> On 06/15/2015 11:01 AM, Sudeep Holla wrote:
>>
>>
>> On 15/06/15 08:46, Javier Martinez Canillas wrote:
>> [...]
>>
>>>
>>> Sudeep, so we may need something like $subject after all from Doug's
>>> explanations since the combiner chip state is lost during a S2R. I know
>>> that it adds more duplicated code (others irqchip drivers do the same)
>>> and it may not scale well if a chip has many registers but is the best
>>> solution I could came with.
>>>
>>
>> OK
>>
>>> If you have a suggestion for a better alternative, I can give a try and
>>> write the patch. But I think $subject could also land to fix this issue
>>> since is a very non intrusive change and later can be changed once the
>>> irqchip core supports this use case.
>>>
>>
>> Agreed. But I would suggest also to add MASK_ON_SUSPEND and set_irq_wake
>> also and then you can restore iff it's non-zero as irq core will take
>> care of most of the non-wakeup sources. Because I am planning to push
>
> I've looking at this and a problem I found is that IIUC the set_irq_wake
> is not propagated from the the Exynos pinctrl / GPIO driver which is the
> combiner's external interrupt source so the callback is never called.
> Which means that right now only the state of the wakeup source IRQs can't
> be saved since that information is not present.
>
> The drivers/pinctrl/samsung/pinctrl-exynos.c driver enables and disables
> the combiner interrupts but its .irq_set_wake handler only updates the
> wakeup source mask for the external interrupts but does not call the
> combiner .set_irq_wake so that should be changed as well.
>

As far as I'm aware of, wake-up events from pin controllers don't go
through GIC, but rather directly to PMU, which is a dedicated unit
responsible for power management and not a standalone interrupt
controller (well actually I saw a series making it a cascaded
controller some time ago, but I'm not sure if that went in). Based on
this, I don't think we have to call set_irq_wake on GIC. Correct me if
I'm wrong, though.

Best regards,
Tomasz
