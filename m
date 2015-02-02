From: m.jabrzyk@samsung.com (Marcin Jabrzyk)
Date: Mon, 02 Feb 2015 09:47:29 +0100
Subject: =?UTF-8?B?UFJPQkxFTTrCoEJVRyAgYXBwZWFyaW5nIHdoZW4gdHJ5aW5nIHQ=?=
 =?UTF-8?B?byBhbGxvY2F0ZSBpbnRlcnJ1cHQgb24gRXh5bm9zIE1DVCBhZnRlciBDUFUgaG8=?=
 =?UTF-8?B?dHBsdWc=?=
In-Reply-To: <54CC9EB2.7010409@linaro.org>
References: <544907D4.1020409@samsung.com>
 <20141023140644.GI27405@n2100.arm.linux.org.uk>
 <54494BEE.9020702@codeaurora.org> <544A52B0.9050901@samsung.com>
 <544EA810.6090502@codeaurora.org> <5450C391.2070007@samsung.com>
 <54CC2B18.2070809@codeaurora.org> <54CC9EB2.7010409@linaro.org>
Message-ID: <54CF39A1.50003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31/01/15 10:21, Daniel Lezcano wrote:
> On 01/31/2015 02:08 AM, Stephen Boyd wrote:
>> Kept meaning to get back to this thread. Have you resolved it?
>>
>> On 10/29/14 03:38, Marcin Jabrzyk wrote:
>>> So I've tried this patch, it resolves one problem but introduces also
>>> new ones. As expected the BUG warning is not showing after applying
>>> this patch but there are some interesting side effects.
>>
>> Well that's half good news.
>>
>>> I was looking on /proc/interrupts output. IRQ for CPU0 have "MCT" name
>>> and IRQ for CPU1 has unexpectedly no name at all.
>>
>> This is pretty confusing. I don't see how the patch could cause this to
>> happen.
>>
>>> After making hotplug cycle of CPU1 I've observed that IRQs attached
>>> originally for that CPU are generating on really low count and not in
>>> order with IRQ for CPU0.
>>> What's more the interrupt for CPU1 is showing to me as being counted
>>> for both CPUs, so it's probably not being attached to CPU1.
>>>
>>
>> yeah. Can you give the output of /proc/timer_list in addition to
>> /proc/interrupts? It may give some hints on what's going on. It may also
>> be interesting to see if irq_force_affinity() is failing. Please check
>> the return value and print an error
>
> Hi Stephen, Marcin,
>
> can you have a look if the patch [1] fixes this issue ?
>
>   -- Daniel
>
> [1] https://lkml.org/lkml/2015/1/30/423
>
>
Hi Daniel,

I've checked this patch on the board that have problems and it fixes 
this issue completely. Everything looks fine after power cycle of the CPU.

Best regards,
Marcin Jabrzyk

>> diff --git a/drivers/clocksource/exynos_mct.c
>> b/drivers/clocksource/exynos_mct.c
>> index 1800053b4644..3c4538e26731 100644
>> --- a/drivers/clocksource/exynos_mct.c
>> +++ b/drivers/clocksource/exynos_mct.c
>> @@ -450,6 +450,7 @@ static int exynos4_local_timer_setup(struct
>> clock_event_device *evt)
>>   {
>>       struct mct_clock_event_device *mevt;
>>       unsigned int cpu = smp_processor_id();
>> +    int ret;
>>
>>       mevt = container_of(evt, struct mct_clock_event_device, evt);
>>
>> @@ -468,7 +469,9 @@ static int exynos4_local_timer_setup(struct
>> clock_event_device *evt)
>>       if (mct_int_type == MCT_INT_SPI) {
>>           evt->irq = mct_irqs[MCT_L0_IRQ + cpu];
>>           enable_irq(evt->irq);
>> -        irq_force_affinity(mct_irqs[MCT_L0_IRQ + cpu], cpumask_of(cpu));
>> +        ret = irq_force_affinity(mct_irqs[MCT_L0_IRQ + cpu],
>> cpumask_of(cpu));
>> +        if (ret)
>> +            pr_err("force failed %d\n", ret);
>>       } else {
>>           enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
>>       }
>>
>
>

-- 
Samsung R&D Institute Poland
Samsung Electronics
