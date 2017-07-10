From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 10 Jul 2017 07:30:50 -0500
Subject: [PATCH] irqchip: gicv3-its: Use NUMA aware memory allocation for
 ITS tables
In-Reply-To: <CAFpQJXUm5tEyaBURzx9OtssBt8+ThO0dmPqtdjjGRJzY5cMv-w@mail.gmail.com>
References: <1498405569-463-1-git-send-email-shankerd@codeaurora.org>
 <CAFpQJXU84OTEp-1BteQeSqNy3Ya2hDskZA=Th_0f47qtS9-ucw@mail.gmail.com>
 <CAFpQJXVh0ojzwqZmT5OgBArx9rpK0_yDw_+gyP8LAkT1e4HWrQ@mail.gmail.com>
 <ab7e26a8-5ab7-7c47-f19c-cb02fbd397b6@arm.com>
 <ba64069e-f3a3-de85-df47-01008d7b3513@codeaurora.org>
 <27b46938-ae23-9750-e0c7-09fa472d3297@arm.com>
 <CAFpQJXVVeAB7RgGKGX-hwo-0ZU8KHzy9ipgbXN0NHorUpk-5Kw@mail.gmail.com>
 <bee8ac5a-b19f-8112-5529-485c269f3501@arm.com>
 <CAFpQJXXPfBEP+_3rzkRo7Ydb31GKFokQB1bmOVHXSd1Pu0zsyA@mail.gmail.com>
 <ed7416f2-e60b-bf8c-cdbe-8a83e83ca529@arm.com>
 <CAFpQJXUm5tEyaBURzx9OtssBt8+ThO0dmPqtdjjGRJzY5cMv-w@mail.gmail.com>
Message-ID: <c883dfb1-1df3-13fa-dc22-efa86b18513a@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

Do you have any other concerns taking this patch?


On 07/10/2017 05:21 AM, Ganapatrao Kulkarni wrote:
> Hi Marc,
> 
> On Mon, Jul 10, 2017 at 2:53 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 10/07/17 10:08, Ganapatrao Kulkarni wrote:
>>> On Mon, Jul 10, 2017 at 2:36 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>> On 10/07/17 09:48, Ganapatrao Kulkarni wrote:
>>>>> Hi Marc,
>>>>>
>>>>> On Mon, Jul 3, 2017 at 8:23 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>>> Hi Shanker,
>>>>>>
>>>>>> On 03/07/17 15:24, Shanker Donthineni wrote:
>>>>>>> Hi Marc,
>>>>>>>
>>>>>>> On 06/30/2017 03:51 AM, Marc Zyngier wrote:
>>>>>>>> On 30/06/17 04:01, Ganapatrao Kulkarni wrote:
>>>>>>>>> On Fri, Jun 30, 2017 at 8:04 AM, Ganapatrao Kulkarni
>>>>>>>>> <gpkulkarni@gmail.com> wrote:
>>>>>>>>>> Hi Shanker,
>>>>>>>>>>
>>>>>>>>>> On Sun, Jun 25, 2017 at 9:16 PM, Shanker Donthineni
>>>>>>>>>> <shankerd@codeaurora.org> wrote:
>>>>>>>>>>> The NUMA node information is visible to ITS driver but not being used
>>>>>>>>>>> other than handling errata. This patch allocates the memory for ITS
>>>>>>>>>>> tables from the corresponding NUMA node using the appropriate NUMA
>>>>>>>>>>> aware functions.
>>>>>>>>>
>>>>>>>>> IMHO, the description would have been more constructive?
>>>>>>>>>
>>>>>>>>> "All ITS tables are mapped by default to NODE 0 memory.
>>>>>>>>> Adding changes to allocate memory from respective NUMA NODES of ITS devices.
>>>>>>>>> This will optimize tables access and avoids unnecessary inter-node traffic."
>>>>>>>>
>>>>>>>> But more importantly, I'd like to see figures showing the actual benefit
>>>>>>>> of this per-node allocation. Given that both of you guys have access to
>>>>>>>> such platforms, please show me the numbers!
>>>>>>>>
>>>>>>>
>>>>>>> I'll share the actual results which shows the improvement whenever
>>>>>>> available on our next chips. Current version of Qualcomm qdf2400 doesn't
>>>>>>> support multi socket configuration to capture results and share with you.
>>>>>>>
>>>>>>> Do you see any other issues with this patch apart from the performance
>>>>>>> improvements. I strongly believe this brings the noticeable improvement
>>>>>>> in numbers on systems where it has multi node memory/CPU configuration.
>>>>>>
>>>>>> I agree that it *could* show an improvement, but it very much depends on
>>>>>> how often the ITS misses in its caches. For this kind of patches, I want
>>>>>> to see two things:
>>>>>>
>>>>>> 1) It brings a measurable benefit on NUMA platforms
>>>>>
>>>>> Did some measurement of interrupt response time for LPIs and we don't
>>>>> see any major
>>>>> improvement due to caching of Tables. However, we have seen
>>>>> improvements of around 5%.
>>>>
>>>> An improvement of what exactly?
>>>
>>> interrupt response time.
>>
>> Measured how? On which HW? Using which benchmark?
> 
> This has been tested on ThunderX2.
> We have instrumented gic-v3-its driver code to create dummy LPI device
> with few vectors.
> The LPI is induced from dummy device(through sysfs by writing to
> TRANSLATOR reg).
> The ISR routine(gic_handle_irq) being called to handle the induced LPI.
> NODE 1 cpu is used to induce LPI and NODE 1 cpu/collection is mapped
> in ITT to route this LPI.
> 
> CPU timer counter are sampled at the time LPI is Induced and in ISR
> routine to calculate interrupt response time.
> the result shown improvement of 5% with this patch.
> 
> Do you have any recommended benchmarks to test the same?
> 

Ganapatrao,

Thanks for your efforts on instrumenting ITS driver code to show interrupt performance
improvement of 5% on the ThunderX2 hardware. Actually the current ITS driver is not 
consistent on allocating memory for ITS/GICR tables, GICR pending tables are allocated
from the corresponding NUMA node based on CPU proximity, but not the other tables.


>>
>> Give me the actual benchmark results. Don't expect me to accept this
>> kind of hand-wavy statement.
>>
>>         M.
>> --
>> Jazz is not dead. It just smells funny...
> 
> thanks
> Ganapat
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
