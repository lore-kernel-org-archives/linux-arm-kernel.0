From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 21 Mar 2012 16:19:22 +0530
Subject: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
In-Reply-To: <4F69B0D1.6020608@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <CAMQu2gxit11dSbruPLCGx37TRwo9mwNCN9JXn0fZLDTVGu2GcA@mail.gmail.com>
 <4F69A4A5.5020208@linaro.org> <4F69A5BA.1080804@ti.com>
 <4F69B0D1.6020608@linaro.org>
Message-ID: <CAMQu2gwDtHBV=iPtxaOyyUHUVwPBTE2woY22U0SSdqruBNuo3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 4:13 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 03/21/2012 10:56 AM, Santosh Shilimkar wrote:
>>
>> On Wednesday 21 March 2012 03:21 PM, Daniel Lezcano wrote:
>>>
>>> On 03/21/2012 10:36 AM, Shilimkar, Santosh wrote:
>>>>
>>>> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
>>>> <daniel.lezcano@linaro.org> ? wrote:
>>>>>
>>>>> This patchset is a proposition to improve a bit the code.
>>>>> The changes are code cleanup and does not change the behavior of the
>>>>> driver itself.
>>>>>
>>>> Thanks. Will have a look at your series.
>>>
>>>
>>> Cool, thanks.
>>>
>>>>> A couple a things call my intention. Why the cpuidle device is set
>>>>> for cpu0 only
>>>>
>>>> Because the mainline code CPUIDLE is supported along with CPUhotplug.
>>>> This is going to change though with Couple CPUIDLE and corresponding
>>>> OMAP updates.
>>>
>>>
>>> Ok, thanks for the information. I will look deeper. What happens to cpu1
>>> when it is online and has nothing to do ?
>>>
>>>>> and why the WFI is not used ?
>>>>>
>>>> I didn't get this question. Do you mean the generic WFI?
>>>
>>>
>> I execute default idle loop.
>
>
> So is it not possible to add a cpuidle device for cpu1 and define only one
> state for the 'wfi-for-omap' ?
>
That's how my post was handling it. But after the review Kevin suggested
me to drop the CPU1 shallow state since it was same as default idle.

>
>>> yes.
>>>
>>>> If yes, then, it's mainly because OMAP need additional
>>>> custom barriers.
>>>
>>>
>>> Ah, ok. I am not sure if it is possible but that may be cool if we can
>>> call cpu_do_idle instead with additional barrier.
>>>
>> There is no need. Since code around WFI is customised, it make no sense
>> to call cpu_do_idle(0 ofr only that instruction sake.
>
>
> For my personal information, why the WFI is customised for omap4 ?
>
OMAP4 silicon has couple of hardware issues around interconnect
and needs to drain the axi buffers with strongly order writes to
ensure that data reaches to peripherals and not get stuck. That
lead to have custom function. Note that, the wfi instruction
itself is same.
