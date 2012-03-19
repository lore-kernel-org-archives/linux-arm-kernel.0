From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 19 Mar 2012 17:45:32 +0530
Subject: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to check
 presence of 32k timer
In-Reply-To: <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
References: <1326983304-14619-1-git-send-email-hvaibhav@ti.com>	<1326983304-14619-2-git-send-email-hvaibhav@ti.com>	<87mx9ej8fp.fsf@ti.com>	<CACVXFVOqmC0OhT-Dim8dL9pWnmGwO2-Awc4V2Jziyf7DHQdYcQ@mail.gmail.com>	<79CD15C6BA57404B839C016229A409A83181EF3F@DBDE01.ent.ti.com>
 <CACVXFVP4J8N271Tww77Btm9fGNiP17MepjswBJ0V-8Z4sNt8Eg@mail.gmail.com>
Message-ID: <4F672364.3020403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 March 2012 05:14 PM, Ming Lei wrote:
> On Mon, Mar 19, 2012 at 7:11 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
>>
>> I think you made very good point here. With the above patch, we are almost missing the capability of registering dmtimer as a clocksource for OMAP.
>> It will always use 32k-counter, and never fall back to dmtimer.
>>
>> Then the only options we have here is,
>>
>> 1) Register both the timers, 32k-counter and dmtimer for clocksource; let
>>   Kernel pick up best rating clocksource out of these two.
>>
>>   In case of OMAP1/2/3/4, kernel will use dmtimer, since it has better
>>   Rating. User can choose the 32k-counter clocksource via bootargs.
>>
>>   Impact: without bootargs for clocksource selection, kernel will choose
>>     dmtimer, impacting loss of time during suspend/resume.
>>
This is the right option. The problem is gptimer clocksource
doesn't work across power transitions and hence it is broken.

Even for the perf, with PM enabled, dmtimer can't be used or it needs
to be used with 32KHz clock which makes it no better than sync timer.

So here keeping 32K sync timer is default clocksource makes sense since
it is the only working and viable option.

So what can be done is register both 32K and gptimer together but make
gptimer clocksource registration depends on PM enabled.

This should solve all the needs I guess.

>>
>> 2) Let the current code be as is, means, the clocksource registration will
>>   Happened based on "#ifdef CONFIG_OMAP_32K_TIMER" and this option
>>   selection will be Controlled by Kconfig rules.
> 
We should get rid off CONFIG_OMAP_32K_TIMER.

Regards
Santosh
