From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 26 Mar 2013 11:58:36 +0100
Subject: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
In-Reply-To: <5151249D.4000602@ti.com>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
 <1363357630-22214-3-git-send-email-daniel.lezcano@linaro.org>
 <5151249D.4000602@ti.com>
Message-ID: <51517F5C.3090505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 05:31 AM, Santosh Shilimkar wrote:
> On Friday 15 March 2013 07:57 PM, Daniel Lezcano wrote:
>> The cpuidle drivers are duplicating a lot of code and in most
>> of the case there is a common pattern we can factor out:
>>
>> 	* setup the broadcast timers
>> 	* register the driver
>> 	* register the devices
>>
>> This arm driver is the common part between all the ARM cpuidle drivers,
>> with the code factored out.
>>
>> It does not handle the coupled idle state for now but it is the first
>> step to have everyone to converge to the same code pattern.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> While I appreciate the effort behind code consolidation, $subject is
> bit confusing. You are just abstracting the registration code to one
> common place and I don't know why it has to be limited to arm-idle
> since it is very generic code. That is true even for the broad-cast
> notifier setup which is same across all arch's including ARM, X86.

[ ... ]


Ok, I should have put a subject:

"cpuidle / arm : a single cpuidle driver : step 1"

As I mentioned earlier, these init functions will be modified. This is
why I prefer ATM to keep these initialization in this file.

When the consolidation reach an acceptable state, then all the arch will
be consolidated in the generic framework for the common parts.

>> +
>> +	if (use_broadcast_timer)
>> +		arm_idle_timer_broadcast(false);
>> +}
>> +EXPORT_SYMBOL_GPL(arm_idle_exit);
>>
> All above code is completly generic and I would rather create
> some thing like "drivers/cpuidle/generic-idle.c" where it can
> handle all the registration stuff for all arch's rather than
> just ARM. There is nothing ARM specific in above code IMHO.

Yes, it seems generic but it won't be.

There is my tree at

http://git.linaro.org/gitweb?p=people/dlezcano/cpuidle-next.git;a=shortlog;h=refs/heads/linux-pm-next

So you can see a part of the evolution of the patchset.

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
