From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 12 Jun 2015 12:54:06 +0100
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set
 on suspend
In-Reply-To: <557AC23D.8040602@collabora.co.uk>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
 <557AB00C.5040606@arm.com> <557AC23D.8040602@collabora.co.uk>
Message-ID: <557AC85E.5070705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/06/15 12:27, Javier Martinez Canillas wrote:
> Hello Sudeep,
>
> Thanks a lot for the feedback.
>
> On 06/12/2015 12:10 PM, Sudeep Holla wrote:
>>
>>
>> On 12/06/15 06:43, Javier Martinez Canillas wrote:
>>> The Exynos interrupt combiner IP loses its state when the SoC enters
>>> into a low power state during a Suspend-to-RAM. This means that if a
>>> IRQ is used as a source, the interrupts for the devices are disabled
>>> when the system is resumed from a sleep state so are not triggered.
>>>
>>> Save the interrupt enable set register for each combiner group and
>>> restore it after resume to make sure that the interrupts are enabled.
>>>
>>
>> Not sure if you need this. IMO it's not clean and redundant though I
>> admit many drivers do exactly same thing. I am trying to remove or point
>> out those redundant code as irqchip core has options/flags to do what
>> you need. I assume there are no wakeup sources connected to this
>
> Yes, there are wakeup sources connected to this combiner. As Krzysztof
> said some wakeup sources use a GPIO line as IRQ whose interrupt parent
> is the combiner. As an example the Power gpio-key and cros_ec keyboard
> for both Exynos5250 Snow and Exynos5420 Peach Pit/Pi.
>
> Both drivers/input/keyboard/gpio_keysc and drivers/mfd/cros_ec.c do the
> right thing though and call {enable,disable}_irq_wake() on the S2R path.
>
> And in fact, the peripherals resume the system after a suspend but after
> resume, interrupts are not triggered anymore.
>

I agree for the wakeup source, but I need to go through the irqchip core
again to understand this better.

>> combiner. Setting irqchip flags should solve this problem. A
>> simple patch below should do the job ?
>>
>
> I don't see how the below patch is going to work for the case I'm
> trying to solve. If I understand correctly, the
> IRQCHIP_MASK_ON_SUSPEND flag is used to force masking non wakeup
> interrupt in the suspend path (instead of just disabling the
> interrupts on suspend and not masking at the hardware level)
>

It also takes re-enables all the IRQs in the resume path that were
disabled on the suspend path.

> But my problem is not about interrupts needed to be masked on suspend
> but the opposite, that interrupts have to be unmasked on resume since
> the IP loses its state so after a resume, interrupts are not
> triggered anymore.
>

As I mentioned above this happens for all non-wake up interrupts.
However this needs to done for wake up interrupts IIUC. BTW if these
registers are lost assuming the combiner was powered down, even the
status register will be lost and you will not know exactly the wakeup
reason right ?

> So I also don't see how implementing irq_set_wake() as you suggested
> is going to work. Maybe we need a IRQCHIP_UNMASK_ON_RESUME flag for
> this case?
>

IIRC these combiner feeds to main interrupt controller and you need to
make sure that interrupt is set as wakeup if required. Right ? so you
may still need irq_set_wake IMO.

Regards,
Sudeep
