From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Jul 2018 14:25:52 +0100
Subject: [PATCH 2/2] clocksource: arm_arch_timer: set arch_mem_timer
 cpumask to cpu_possible_mask
In-Reply-To: <alpine.DEB.2.21.1807101419130.4356@nanos.tec.linutronix.de>
References: <1531151136-18297-1-git-send-email-sudeep.holla@arm.com>
 <1531151136-18297-2-git-send-email-sudeep.holla@arm.com>
 <alpine.DEB.2.21.1807100008100.1590@nanos.tec.linutronix.de>
 <b98e0d87-3d9a-9b0c-23c4-7b289cc79a97@arm.com>
 <alpine.DEB.2.21.1807101419130.4356@nanos.tec.linutronix.de>
Message-ID: <a8979e78-9844-160a-a758-631505924bbd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/07/18 13:21, Thomas Gleixner wrote:
> On Tue, 10 Jul 2018, Sudeep Holla wrote:
> 
>>
>>
>> On 09/07/18 23:09, Thomas Gleixner wrote:
>>> On Mon, 9 Jul 2018, Sudeep Holla wrote:
>>>
>>>> Currently, arch_mem_timer cpumask is set to cpu_all_mask which should be
>>>> fine. However, cpu_possible_mask is more accurate and if there are other
>>>> clockevent source in the system which are set to cpu_possible_mask, then
>>>> having cpu_all_mask may result in issue.
>>>>
>>>> E.g. on a platform with arm,sp804 timer with rating 300 and
>>>> cpu_possible_mask and this arch_mem_timer timer with rating 400 and
>>>> cpu_all_mask, tick_check_preferred may choose both preferred as the
>>>> cpumasks are not equal though they must be.
>>>>
>>>> This issue was root caused incorrectly initially and a fix was merged as
>>>> commit 1332a9055801 ("tick: Prefer a lower rating device only if it's CPU
>>>> local device").
>>>
>>> To avoid that in the future we really should fix the decision logic to mask
>>> out the non possible CPUs from the supplied masks.
>>
>> Sure, I can do that. But do you want that as a fix for v4.18 ?
> 
> No, that's for 4.19
> 

Ah OK, I assume you are fine with this patch as fix for v4.18.
>> I think we may need this check at another place in tick_setup_device
>>
>> 213         /*
>> 214          * When the device is not per cpu, pin the interrupt to the
>> 215          * current cpu:
>> 216          */
>> 217         if (!cpumask_equal(newdev->cpumask, cpumask))
>> 218                 irq_set_affinity(newdev->irq, cpumask);
>>
>> Does it make sense trim dev->cpumask when registering the clockevents
>> device itself instead of adding check at place where this cpumask
>> can be used ? So that any future user of those masks need not have to
>> take care of that.
> 
> The problem is you cannot trim it because cpu_all_mask is global and const.
> 

Indeed, again forgot it just a pointer to the global one, duh!

>> Also only few ARM clocksource drivers use cpu_all_mask which could be
>> result of copy-paste, we can even fix them too.
>>
>> arm_arch_timer.c:	clk->cpumask = cpu_all_mask;
>> tegra20_timer.c:	tegra_clockevent.cpumask = cpu_all_mask;
>> timer-atcpit100.c:	.cpumask = cpu_all_mask,
>> timer-keystone.c:	event_dev->cpumask = cpu_all_mask;
>> zevio-timer.c:		timer->clkevt.cpumask	= cpu_all_mask;
> 
> Yes, that makes sense. What we could do is warn, when cpu_all_mask is set
> at registration time and replace the pointer with cpu_possible_mask.
> 

I like this approach than having to bitwise and with cpu_possible_mask
at all the necessary place. I will cook up a patch.
-- 
Regards,
Sudeep
