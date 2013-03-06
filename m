From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 06 Mar 2013 10:27:37 +0100
Subject: [PATCH 2/4][V2] time : set broadcast irq affinity
In-Reply-To: <alpine.LFD.2.02.1303052135080.22263@ionos>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org>
 <1362219013-18173-3-git-send-email-daniel.lezcano@linaro.org>
 <alpine.LFD.2.02.1303052135080.22263@ionos>
Message-ID: <51370C09.5020301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2013 09:40 PM, Thomas Gleixner wrote:
> On Sat, 2 Mar 2013, Daniel Lezcano wrote:
>> When a cpu goes to a deep idle state where its local timer is shutdown,
>> it notifies the time frame work to use the broadcast timer instead.
>>
>> Unfortunately, the broadcast device could wake up any CPU, including an
>> idle one which is not concerned by the wake up at all.
>>
>> This implies, in the worst case, an idle CPU will wake up to send an IPI
>> to another idle cpu.
>>
>> This patch solves this by setting the irq affinity to the cpu concerned
>> by the nearest timer event, by this way, the CPU which is wake up is
>> guarantee to be the one concerned by the next event and we are safe with
>> unnecessary wakeup for another idle CPU.
>>
>> As the irq affinity is not supported by all the archs, a flag is needed
>> to specify which clocksource can handle it : CLOCK_EVT_FEAT_DYNIRQ
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  include/linux/clockchips.h   |    5 +++++
>>  kernel/time/tick-broadcast.c |   40 +++++++++++++++++++++++++++++++++-------
>>  2 files changed, 38 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
>> index 6634652..c93e2a6 100644
>> --- a/include/linux/clockchips.h
>> +++ b/include/linux/clockchips.h
>> @@ -55,6 +55,11 @@ enum clock_event_nofitiers {
>>  #define CLOCK_EVT_FEAT_C3STOP		0x000008
>>  #define CLOCK_EVT_FEAT_DUMMY		0x000010
>>  
>> +/*
>> + * Clock event device can set its irq affinity dynamically
>> + */
>> +#define CLOCK_EVT_FEAT_DYNIRQ		0x000020
>> +
>>  /**
>>   * struct clock_event_device - clock event device descriptor
>>   * @event_handler:	Assigned by the framework to be called by the low
>> diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
>> index 6197ac0..9ca8ff5 100644
>> --- a/kernel/time/tick-broadcast.c
>> +++ b/kernel/time/tick-broadcast.c
>> @@ -406,13 +406,37 @@ struct cpumask *tick_get_broadcast_oneshot_mask(void)
>>  	return to_cpumask(tick_broadcast_oneshot_mask);
>>  }
>>  
>> -static int tick_broadcast_set_event(struct clock_event_device *bc,
>> +/*
>> + * Set broadcast interrupt affinity
>> + */
>> +static void tick_broadcast_set_affinity(struct clock_event_device *bc,
>> +					const struct cpumask *cpumask)
>> +{
>> +	if (!(bc->features & CLOCK_EVT_FEAT_DYNIRQ))
>> +		return;
>> +
>> +	if (cpumask_equal(bc->cpumask, cpumask))
>> +		return;
>> +
>> +	bc->cpumask = cpumask;
> 
> This breaks with CONFIG_CPUMASK_OFFSTACK=y. cpumask_copy() is your friend!

This instruction copies the pointer, not the cpumask content.

bc->cpumask is defined as a const struct cpumask * and is used to copy a
cpumask pointer not the content.

The cpumask parameter is a pointer to a global cpumask provided by the
cpumask_of macro.

But to be in the safe side, I compiled tested with
CONFIG_CPUMASK_OFFSTACK=y without problem.

Did I missed something ?

Thanks
  -- Daniel

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
