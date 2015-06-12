From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 12 Jun 2015 11:56:46 +0100
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set
 on suspend
In-Reply-To: <557AB793.1060809@samsung.com>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
 <557AB00C.5040606@arm.com> <557AB793.1060809@samsung.com>
Message-ID: <557ABAEE.9010703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/06/15 11:42, Krzysztof Kozlowski wrote:
> On 12.06.2015 19:10, Sudeep Holla wrote:
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
>> combiner.
>
> It may have wake up sources connected. Correct me if I am wrong but (at
> least) on Exynos5250 combiner takes care of gpx1 GPIO pins which may be
> external interrupts (e.g. power key on Exynos5250 Snow). I didn't check
> other boards.
>

In that case, this irqchip should implement irq_set_wake and the driver
implementing power key should use enable_irq_wake in the suspend path.
Just saving all the mask/enable registers is not scalable solution and
also useless if it's just one or to interrupts that are very few IRQs
registered/actively being used.

Regards,
Sudeep
