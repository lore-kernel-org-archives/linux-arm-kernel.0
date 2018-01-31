From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 31 Jan 2018 12:37:01 -0800
Subject: [PATCH v3 0/6] 32bit ARM branch predictor hardening
In-Reply-To: <89219459-4887-347b-e10d-b21c8bad7207@arm.com>
References: <20180125152139.32431-1-marc.zyngier@arm.com>
 <d95c2261-febe-bb56-da37-5edc1a593cbb@huawei.com>
 <CAGo_u6o8ahJxnXXN-XuHcsa6=LcA=BBbsGOZ-n8Q9+_dYYswjQ@mail.gmail.com>
 <e34add95-a672-b76c-1746-e2d9d152624c@huawei.com>
 <c25089e9-540b-2b09-555c-a2c9d8850610@gmail.com>
 <61cd49b5-264c-d34b-872f-79c1eaa959ea@arm.com>
 <89219459-4887-347b-e10d-b21c8bad7207@arm.com>
Message-ID: <4ea68257-082b-e6e5-1ed6-fe91afe896a0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2018 11:54 AM, Andr? Przywara wrote:
> On 31/01/18 19:07, Marc Zyngier wrote:
>> On 31/01/18 18:53, Florian Fainelli wrote:
>>> On 01/31/2018 04:45 AM, Hanjun Guo wrote:
>>>> On 2018/1/29 22:58, Nishanth Menon wrote:
>>>>> On Mon, Jan 29, 2018 at 5:36 AM, Hanjun Guo <guohanjun@huawei.com> wrote:
>>>>> [...]
>>>>>
>>>>>> By the way, this patch set just enable branch predictor hardening
>>>>>> on arm32 unconditionally, but some of machines (such as wireless
>>>>>> network base station) will not be exposed to user to take advantage
>>>>>> of variant 2, and those machines will be pretty sensitive for
>>>>>> performance, so can we introduce Kconfig or boot option to disable
>>>>>> branch predictor hardening as an option?
>>>>>
>>>>> I am curious: Have you seen performance degradation with this series?
>>>>> If yes, is it possible to share the information?
>>>>
>>>> Sorry for the late reply, the performance data for context switch (CFS)
>>>> is about 6%~12% drop (A9 based machine) for the first around test, but
>>>> the data is not stable, I need to retest then I will update here.
>>>
>>> What tool did you use to measure this? On a Brahma-B15 platform clocked
>>> at 1.5Ghz, across kernels 4.1, 4.9 (4.15 in progress as we speak), I
>>> measured the following, with two memory configurations, one giving 256MB
>>> of usable memory, another giving 3GB of usable memory, results below are
>>> only the most extreme 256MB case. This is running 13 groups because the
>>> ASID space is 256bits so this should force at least two full ASID
>>> generation rollovers (assuming the logic is correct here).
>>>
>>> for i in $(seq 0 9)
>>> do
>>> 	hackbench 13 process 10000
>>> done
>>>
>>> Average values, in seconds:
>>>
>>> 1) 4.1.45, ACTLR[0] = 0, no spectre variant 2 patches: 114,2666
>>> 2) 4.1.45, ACTLR[0] = 1, no spectre variant 2 patches: 114,2952
>>> 3) 4.1.45, ACTLR[0] =1 , spectre variant 2 patches: 115,5853
>>>
>>> => 3) is a 1.15% degradation against 1)
>>>
>>> 4.9.51, ACTLR[0] = 0, no spectre variant 2 patches: 130,7676
>>> 4.9.51, ACTLR[0] = 1, no spectre variant 2 patches: 130,6848
>>> 4.9.51, ACTLR[0] =1 , spectre variant 2 patches: 132,4274
>>>
>>> => 3) is a 1.26% degradation against 1)
>>>
>>> The relative differences between 4.1 and 4.9 appear consistent (with 4.9
>>> being slower for a reason I ignore).
>>>
>>> Marc, are there any performance tests/results that you ran that you
>>> could share?
>>
>> None. I usually don't run benchmarks, because they are not
>> representative of a real workload. I urge people to run their own real
>> workload, as it is very unlikely to have hackbench's profile...
> 
> Very true.

Of course, but that does not mean you don't want to characterize some
sort of worst case scenario ;)

> 
> Out of curiosity (and to prove that the patches and my home-baked
> firmware fix actually had an effect), I also ran hackbench (of course!)
> on a Calxeda Midway (4*Cortex-A15, 8GB RAM). Native runs showed only
> very little degradation, not unlike Florian's numbers.

How did you run hackbench, out of curiosity?

> Running hackbench in a KVM guest however showed a bigger impact, which
> is of course somewhat expected.

That I have not done, not too interested by KVM, but this is indeed
expected.
-- 
Florian
