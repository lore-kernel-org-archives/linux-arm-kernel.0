From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 8 Dec 2017 14:05:53 +0100
Subject: [PATCH v9 3/6] clocksource: stm32: only use 32 bits timers
In-Reply-To: <56efa18e-481b-bd1b-7a54-db4a21073313@linaro.org>
References: <20171208113250.359-1-benjamin.gaignard@st.com>
 <20171208113250.359-4-benjamin.gaignard@st.com>
 <56efa18e-481b-bd1b-7a54-db4a21073313@linaro.org>
Message-ID: <CA+M3ks5CY79SHqcfhgySgsQuPVQyJWHQJ0=OT3Zvxvu2LfUOaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-08 13:51 GMT+01:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 08/12/2017 12:32, Benjamin Gaignard wrote:
>> From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
>>
>> The clock driving counters is at 90MHz so the maximum period
>> for 16 bis counters is around 728us (2^16 / 90.000.000).
>> For 32 bits counters this period is close 47 secondes which is
>> more acceptable.
>>
>> When using 16 bits counters the kernel may not be able to boot
>> because it has a too high overhead compare to the clockevent period.
>> Downgrading the rating of 16bits counter won't change anything
>> to this problem so this patch remove 16 bits counters support
>> and makes sure that they won't be probed anymore.
>
> Benjamin,
>
> there is an inconsistency in this description and the patchset. This is
> why it is so confusing to review and understand the purpose.
>
> Why are you preventing the clockevents to work with 16bits while the
> issue is related to the clocksource you introduce in the next patch ?

No the issue is existing also for clockevent because the max period is
around 728us so the interrupt will fire each 728us which is really too much.

>
> Also, why are you removing the DT nodes ?
>
> Accept to register the clocksource only if it is a 32bits timer. Let the
> clockevents to register themselves and have the rating to sort out the
> this. I do believe that is what Thomas asked you the first time.
>
> You can keep the hardware description in the DT and boot gracefully with
> the first 32bits timer succeeding the init.
>
> Take the time to think about it, comment and let's reach an agreement
> before you send another version, I'm tired to review again and again
> these stm32 timers.
>
> Thanks.
>
>   -- Daniel
>
>
>
>
> --
>  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
