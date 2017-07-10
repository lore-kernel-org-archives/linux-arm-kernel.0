From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 10 Jul 2017 14:18:29 +0530
Subject: [PATCH] irqchip: gicv3-its: Use NUMA aware memory allocation for
 ITS tables
In-Reply-To: <27b46938-ae23-9750-e0c7-09fa472d3297@arm.com>
References: <1498405569-463-1-git-send-email-shankerd@codeaurora.org>
 <CAFpQJXU84OTEp-1BteQeSqNy3Ya2hDskZA=Th_0f47qtS9-ucw@mail.gmail.com>
 <CAFpQJXVh0ojzwqZmT5OgBArx9rpK0_yDw_+gyP8LAkT1e4HWrQ@mail.gmail.com>
 <ab7e26a8-5ab7-7c47-f19c-cb02fbd397b6@arm.com>
 <ba64069e-f3a3-de85-df47-01008d7b3513@codeaurora.org>
 <27b46938-ae23-9750-e0c7-09fa472d3297@arm.com>
Message-ID: <CAFpQJXVVeAB7RgGKGX-hwo-0ZU8KHzy9ipgbXN0NHorUpk-5Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Mon, Jul 3, 2017 at 8:23 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Shanker,
>
> On 03/07/17 15:24, Shanker Donthineni wrote:
>> Hi Marc,
>>
>> On 06/30/2017 03:51 AM, Marc Zyngier wrote:
>>> On 30/06/17 04:01, Ganapatrao Kulkarni wrote:
>>>> On Fri, Jun 30, 2017 at 8:04 AM, Ganapatrao Kulkarni
>>>> <gpkulkarni@gmail.com> wrote:
>>>>> Hi Shanker,
>>>>>
>>>>> On Sun, Jun 25, 2017 at 9:16 PM, Shanker Donthineni
>>>>> <shankerd@codeaurora.org> wrote:
>>>>>> The NUMA node information is visible to ITS driver but not being used
>>>>>> other than handling errata. This patch allocates the memory for ITS
>>>>>> tables from the corresponding NUMA node using the appropriate NUMA
>>>>>> aware functions.
>>>>
>>>> IMHO, the description would have been more constructive?
>>>>
>>>> "All ITS tables are mapped by default to NODE 0 memory.
>>>> Adding changes to allocate memory from respective NUMA NODES of ITS devices.
>>>> This will optimize tables access and avoids unnecessary inter-node traffic."
>>>
>>> But more importantly, I'd like to see figures showing the actual benefit
>>> of this per-node allocation. Given that both of you guys have access to
>>> such platforms, please show me the numbers!
>>>
>>
>> I'll share the actual results which shows the improvement whenever
>> available on our next chips. Current version of Qualcomm qdf2400 doesn't
>> support multi socket configuration to capture results and share with you.
>>
>> Do you see any other issues with this patch apart from the performance
>> improvements. I strongly believe this brings the noticeable improvement
>> in numbers on systems where it has multi node memory/CPU configuration.
>
> I agree that it *could* show an improvement, but it very much depends on
> how often the ITS misses in its caches. For this kind of patches, I want
> to see two things:
>
> 1) It brings a measurable benefit on NUMA platforms

Did some measurement of interrupt response time for LPIs and we don't
see any major
improvement due to caching of Tables. However, we have seen
improvements of around 5%.
IMO, we should merge this patch to have NUMA aware allocations and to
avoid unwanted inter-node transactions.

Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

> 2) it doesn't adversely impact non-NUMA systems
AFAIK, no impact on non-NUMA and on single node NUMA systems.

>
> I can deal with (2), but I have no way of evaluating (1), mostly for the
> lack of an infrastructure exercising multiple ITSs at the same time.
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...

thanks
Ganapat
