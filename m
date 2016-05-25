From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 25 May 2016 15:44:09 +0300
Subject: [PATCH] ARM: omap2: am437x: rollback to use
 omap3_gptimer_timer_init()
In-Reply-To: <57457636.3010409@ti.com>
References: <1460457775-23850-1-git-send-email-grygorii.strashko@ti.com>
 <20160412160448.GN5995@atomide.com> <570D3EC8.7090807@ti.com>
 <20160412184250.GT5995@atomide.com> <57457636.3010409@ti.com>
Message-ID: <57459E19.40901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2016 12:53 PM, Lokesh Vutla wrote:
> 
> 
> On Wednesday 13 April 2016 12:12 AM, Tony Lindgren wrote:
>> * Grygorii Strashko <grygorii.strashko@ti.com> [160412 11:31]:
>>> On 04/12/2016 07:04 PM, Tony Lindgren wrote:
>>>> * Grygorii Strashko <grygorii.strashko@ti.com> [160412 03:44]:
>>>>> The commit 55ee7017ee31 ("arm: omap2: board-generic: use
>>>>> omap4_local_timer_init for AM437x") unintentionally changes the
>>>>> clocksource devices for AM437x from OMAP GP Timer to SyncTimer32K.
>>>>>
>>>>> Unfortunately, the SyncTimer32K is starving from frequency deviation
>>>>> as mentioned in commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
>>>>> as clocksource") and, as reported by Franklin [1], even its monotonic
>>>>> nature is under question (most probably there is a HW issue, but it's
>>>>> still under investigation).
>>>>>
>>>>> Taking into account above facts It's reasonable to rollback to the use
>>>>> of omap3_gptimer_timer_init().
>>>>
>>>> I thought only the ePOS EVM does not have the 32k clock available?
>>>> Maybe this is the the old sync timer autocorrection drift issue?
>>>>
>>>
>>> May be, as i mentioned in [1] it could be errata same as for Watchdog
>>> Advisory 22 (or OMAP_TIMER_ERRATA_I103_I767).
>>>
>>> But as per commit 5b5c01359152 ("ARM: OMAP2+: AM43x: Use gptimer
>>> as clocksource") there is no reason to use SyncTimer32K as
>>> clocksource any way (not only on epos):
>>>
>>> commit 5b5c01359152f3ddaa1aa0e5d1141bc2b29ba2c5
>>> Author: Rajendra Nayak <rnayak@ti.com>
>>> Date:   Fri Feb 7 15:51:26 2014 +0530
>>>
>>>      ARM: OMAP2+: AM43x: Use gptimer as clocksource
>>>      
>>>      The SyncTimer in AM43x is clocked using the following two sources:
>>>      1) An inaccuarte 32k clock (CLK_32KHZ) derived from PER DPLL, causing system
>>>         time to go slowly (~10% deviation).
>>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I don't think this statement is right. If clock from PER DPLL is
> inaccurate then all the IPs which uses PER DPLL are in danger. It is the
> On-Chip 32K RC Osc clock that is not an accurate clock-source as per the
> design/spec.
> 
>>>      2) external 32KHz RTC clock, which may not always be available on board like
>>>         in the case of ePOS EVM
> 
> Also this 32KHz RTC clock is not enabled by default and is handled by RTC.
> 
> IMO, it is better to change the clock source of sync timer to
> CLK_32KHz(like it is done in case of am43x-epos). Or do you have any
> other reason to shift to gptimer?
> 

In my opinion this is because of HW issue - OMAP4 errata i103, which,
for some reasons, is not mentioned for am437x (and I do not have confirmation). 

Originally issue was described and fix implemented for OMAP4 by commit

commit 73152a98a25392a451bb0d588a1fbe2796b3c909
Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon Mar 12 20:34:45 2012 +0530

OMAP4: Workaround the OCP synchronisation issue with 32K synctimer.

I saw exactly similar behavior by my self:
- for some reason  ti_32k_read_cycles() return value lower the previously read value
- this causes timekeeping_get_delta() to return negative value
- which, in turn, causes big jiffies shift: 4294939981 -> 13079884
- and this blow up Timekeeping core brain and causes RCU stall error messages,
which is reasonable because all jiffies based timeout will misbehave.

>From registers I can see that 32K synctimer is in no-idle mode

32K synctimer.SYSC = 0x00000008
PRCM_CM_WKUP_SYNCTIMER_CLKCTRL = 0x00000102

and, seems, it's impossible to use static dep on am437x.

So, right now, I don't know how this issues can be W/A, so rallback.

-- 
regards,
-grygorii
