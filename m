From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 17:26:38 +0100
Subject: pmu: armv7_a9_pmu_init() fails with -ENXIO
In-Reply-To: <5627B2CA.4030005@free.fr>
References: <56278C91.8050605@free.fr> <56279753.5000107@free.fr>
 <5627A0DB.5030304@arm.com> <5627B2CA.4030005@free.fr>
Message-ID: <5627BCBE.2060102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/10/15 16:44, Mason wrote:
> On 21/10/2015 16:27, Sudeep Holla wrote:
>
>> On 21/10/15 14:46, Mason wrote:
>>
>>> I also looked more closely at of_pmu_irq_cfg()
>>>
>>> platform_get_irq(pdev, 0); returns -6
>>
>> Won't it return here ?
>> Though you must first check why is that returning error.
>>
>>           irq = platform_get_irq(pdev, 0);
>>           if (irq >= 0 && irq_is_percpu(irq))
>>                   return 0;
>
> Thanks for prodding me in the right direction.
> platform_get_irq() was failing because I hadn't properly defined
> the node's interrupt-parent...
>

Yes that's what I guessed seeing of_irq_get.

> I've added
>    interrupt-parent = <&gic>;
> at the root of my DT, and things now work as expected.
> (Haven't tested actually using the counters yet.)
>
> [    0.090058] irq=212 irqs=e7603400 pdev->num_resources=2
> [    0.090091] hw perfevents: Failed to parse /pmu/interrupt-affinity[0]

Better to add this property. It assigns the cpu affinity in logical
order which might break if your logical and physical cpu ordering
differs.(e.g. you boot on CPU#1 instead of CPU#0)

> [    0.090103] armv7_a9_pmu_init: ret=0
> [    0.090145] hw perfevents: enabled with armv7_cortex_a9 PMU driver, 7 counters available
>

Cool

-- 
Regards,
Sudeep
