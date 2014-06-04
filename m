From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Wed, 04 Jun 2014 10:42:01 +0100
Subject: [PATCH v2 04/11] sched: Allow all archs to set the power_orig
In-Reply-To: <CAKfTPtB+2dsHjZw=KkYgbP4EnPebLjfdNeVDAStXFJ2h8wbm+g@mail.gmail.com>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-5-git-send-email-vincent.guittot@linaro.org>
 <53888FF0.4020403@arm.com>
 <CAKfTPtB+2dsHjZw=KkYgbP4EnPebLjfdNeVDAStXFJ2h8wbm+g@mail.gmail.com>
Message-ID: <538EE9E9.7090605@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
>> (1) We assume that the current way (update_cpu_power() calls
>> arch_scale_freq_power() to get the avg power(freq) over the time period
>> since the last call to arch_scale_freq_power()) is suitable
>> for us. Do you have another opinion here?
> 
> Using power (or power_freq as you mentioned below) is probably the
> easiest and more straight forward solution. You can use it to scale
> each element when updating entity runnable.
> Nevertheless, I see to 2 potential issues:
> - is power updated often enough to correctly follow the frequency
> scaling ? we need to compare power update frequency with
> runnable_avg_sum variation speed and the rate at which we will change
> the CPU's frequency.
> - the max value of runnable_avg_sum will be also scaled so a task
> running on a CPU with less capacity could be seen as a "low" load even
> if it's an always running tasks. So we need to find a way to reach the
> max value for such situation

I think I mixed two problems together here:

Firstly, we need to scale cpu power in update_cpu_power() regarding
uArch, frequency and rt/irq pressure.
Here the freq related value we get back from arch_scale_freq_power(...,
cpu) could be an instantaneous value (curr_freq(cpu)/max_freq(cpu)).

Secondly, to be able to scale the runnable avg sum of a sched entity
(se->avg->runnable_avg_sum), we preferable have a coefficient
representing uArch diffs (cpu_power_orig(cpu)/cpu_power_orig(most
powerful cpu in the system) and another coefficient (avg freq over 'now
- sa->last_runnable_update'(cpu)/max_freq(cpu). This value would have to
be retrieved from the arch in __update_entity_runnable_avg().

>> (2) Is the current layout of update_cpu_power() adequate for this, where
>> we scale power_orig related to freq and then related to rt/(irq):
>>
>>   power_orig = scale_cpu(SCHED_POWER_SCALE)
>>   power = scale_rt(scale_freq(power_orig))
>>
>> or do we need an extra power_freq data member on the rq and do:
>>
>>   power_orig = scale_cpu(SCHED_POWER_SCALE)
>>   power_freq = scale_freq(power_orig))
>>   power = scale_rt(power_orig))
> 
> do you really mean power = scale_rt(power_orig) or power=scale_rt(power_freq) ?

No, I also think that power=scale_rt(power_freq) is correct.

>> In other words, do we consider rt/(irq) pressure when calculating freq
>> scale invariant task load or not?
> 
> we should take power_freq which implies a new field
[...]
