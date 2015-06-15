From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 15 Jun 2015 17:23:39 +0200
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set
 on suspend
In-Reply-To: <557EEA6C.6020002@arm.com>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>	<557AB00C.5040606@arm.com>	<557AC23D.8040602@collabora.co.uk>	<557AC85E.5070705@arm.com>	<557AD728.7090908@collabora.co.uk>	<557B34A7.4090507@collabora.co.uk>
 <CAD=FV=UQF+n8AjSXYajqUb0qswcoUrSgnsasV82JaS3dBtNO8Q@mail.gmail.com>
 <557E82BC.7080203@collabora.co.uk> <557E947B.3030804@arm.com>
 <557EE890.2050001@collabora.co.uk> <557EEA6C.6020002@arm.com>
Message-ID: <557EEDFB.7080502@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sudeep,

On 06/15/2015 05:08 PM, Sudeep Holla wrote:
> On 15/06/15 16:00, Javier Martinez Canillas wrote:
>> On 06/15/2015 11:01 AM, Sudeep Holla wrote:
>>> On 15/06/15 08:46, Javier Martinez Canillas wrote:

[...]

>>>
>>> Agreed. But I would suggest also to add MASK_ON_SUSPEND and set_irq_wake
>>> also and then you can restore iff it's non-zero as irq core will take
>>> care of most of the non-wakeup sources. Because I am planning to push
>>
>> I've looking at this and a problem I found is that IIUC the set_irq_wake
>> is not propagated from the the Exynos pinctrl / GPIO driver which is the
>> combiner's external interrupt source so the callback is never called.
>> Which means that right now only the state of the wakeup source IRQs can't
>> be saved since that information is not present.
>>
>> The drivers/pinctrl/samsung/pinctrl-exynos.c driver enables and disables
>> the combiner interrupts but its .irq_set_wake handler only updates the
>> wakeup source mask for the external interrupts but does not call the
>> combiner .set_irq_wake so that should be changed as well.
>>
> 
> Thanks for the looking at this.
>

You are welcome and thanks to you for pointing this out.
 
>> But even for non-wakeup interrupts, I found that they are not enabled when
>> adding the MASK_ON_SUSPEND on my tests. I don't know if that is related
>> to the pinctrl driver missing something else though.
>>
> 
> Even GIC is not masking any interrupt on suspend and if other irqchip or
> drivers are assuming that, it will work fine for now. But once I
> introduce that change in GIC it will break.
> 
>>> MASK_ON_SUSPEND to GIC and it will break this combiner if it assumes the
>>> combiner interrupts are always on in GIC. Implement set_irq_wake as
>>> enable_irq_wake (comb_irq_to_GIC).
>>>
>>
>> Right, but can we do this as a follow-up? S2R is currently broken on these
>> machines and $subject is I think a reasonable small fix that won't introduce
>> any regressions.
>>
> 
> No issues, I just wanted to understand the issue better and also make
> sure we understand that things might break in future once that GIC
> change is introduced. So we already know the reason or atleast have some
> basic understanding as why would it break if it breaks :)
>

Indeed, in the meantime I will continue looking at this to better understand
all the interactions so if something breaks with your changes I may be able
to test / debug and hopefully fix it :)
 
>> To do a more intrusive change, I should better understand the interactions
>> between the Exynos pinctrl / GPIO, interrupt combiner and the GIC and in the
>> meantime S2R will continue to be broken on these platforms unless someone
>> more familiar with all this could point me in the right direction.
>>
> 
> As I said I am fine with this patch for now and I don't want to block it.
>

Thanks a lot, Krzysztof who is one of the Exynos maintainers has also agreed
with the patch so hopefully this can land sooner rather than later.

> Regards,
> Sudeep
> 

Best regards,
Javier
