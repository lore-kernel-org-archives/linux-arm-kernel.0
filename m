From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 21 Oct 2014 13:12:34 +0200
Subject: [PATCH] ARM/ARM64: arch-timer: fix arch_timer_probed logic
In-Reply-To: <20141021110728.GD15293@leverpostej>
References: <1413385580-23317-1-git-send-email-marc.zyngier@arm.com>
 <54463C55.8010209@linaro.org> <20141021110728.GD15293@leverpostej>
Message-ID: <54463FA2.4070506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2014 01:07 PM, Mark Rutland wrote:
> Hi Daniel,
>
> On Tue, Oct 21, 2014 at 11:58:29AM +0100, Daniel Lezcano wrote:
>> On 10/15/2014 05:06 PM, Marc Zyngier wrote:
>>> Commit c387f07e6205 (clocksource: arm_arch_timer: Discard unavailable
>>> timers correctly) changed the way the driver makes sure both the memory
>>> and system-register timers have been probed before finalizing the probing.
>>>
>>> There is a interesting flaw in this logic that leads to this final step
>>> never to be executed. Things seems to work pretty well until something
>>> actually needs the data that is produced during this final stage.
>>>
>>> For example, KVM explodes on the first run of a guest when executed on
>>> a platform that has both memory and sysreg nodes (Juno, for example).
>>>
>>> Just fix the damned logic, and enjoy booting VMs again.
>>>
>>> Tested on a Juno system.
>>>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>>> Reported-by: Riku Voipio <riku.voipio@linaro.org>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>> ---
>>
>> Applied to my tree. Also for -next.
>
> Is this going to hit -rc2? This was a regression introduced in -rc1.
>
> Without this fix we've also lost our high precision sched_clock on arm64
> platforms.
>

Sure.

Thomas or Ingo,

is it possible to update the tip/urgent branch, so I can send the fixes 
against 3.18-rc1 ?

Thanks in advance

   -- Daniel


>>>    drivers/clocksource/arm_arch_timer.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>> index 2133f9d..43005d4 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -660,11 +660,11 @@ static bool __init
>>>    arch_timer_probed(int type, const struct of_device_id *matches)
>>>    {
>>>    	struct device_node *dn;
>>> -	bool probed = false;
>>> +	bool probed = true;
>>>
>>>    	dn = of_find_matching_node(NULL, matches);
>>> -	if (dn && of_device_is_available(dn) && (arch_timers_present & type))
>>> -		probed = true;
>>> +	if (dn && of_device_is_available(dn) && !(arch_timers_present & type))
>>> +		probed = false;
>>>    	of_node_put(dn);
>>>
>>>    	return probed;
>>>
>>
>>
>> --
>>    <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
>>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
