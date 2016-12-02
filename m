From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 2 Dec 2016 12:02:23 -0600
Subject: [PATCH 2/2] ARM: omap: timers: reduce rating of gp_timer
 clocksource
In-Reply-To: <20161202164714.GB4705@atomide.com>
References: <1479968355-18860-1-git-send-email-j-keerthy@ti.com>
 <1479968355-18860-2-git-send-email-j-keerthy@ti.com>
 <d3a71d3d-3015-bb1f-80a4-4bb9adecaa4c@ti.com>
 <20161202164714.GB4705@atomide.com>
Message-ID: <14878d85-1b08-5df1-4e67-6f982ba72019@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/02/2016 10:47 AM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [161129 08:43]:
>>
>>
>> On 11/24/2016 12:19 AM, Keerthy wrote:
>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>>
>>> Now ARM Global timer (rating 300) will not be selected as clocksource,
>>> because it's initialized after OMAP GP Timer (rating 300) and
>>> Timekeeping core will not allow to replace clocksource with new one if
>>> both of them have the same rating.
>>>
>>> Reduce rating of OMAP GP Timer (300->290) when it's used as
>>> clocksource device - this will allow to select ARM Global timer (300)
>>> as clocksource when enabled.
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>
>> Unfortunately, this patch has dependency [1] and can't be used alone as
>> it will cause ARM Global timer to be selected as clocksource
>> always on am437x and this will kill cpuidle, because ARM Global timer
>> is not in always_on domain.
>>
>> The intention of enabling ARM Global timer is only for non-pm aware use
>> cases for RT-kernel latency improvement - where deep cpuidle states are not
>> enabled.
>
> Yeah we need to fix up things to be able to change the clocksource
> in addition to clockevent. However, currently only cpuidle_coupled
> knows when the whole system is idle, so quite a bit of work is
> needed to do that in a sane way.

Also sched_clock and timer_delay ;)


>
> What about the first patch in this series?
>

Fist one is ok. It was originally posted long time ago.

-- 
regards,
-grygorii
