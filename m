From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 Feb 2012 11:19:26 +0000
Subject: [PATCH v2 4/4] ARM: architected timers: add support for UP timer
In-Reply-To: <4F399798.8010601@codeaurora.org>
References: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
 <1328115575-24866-5-git-send-email-marc.zyngier@arm.com>
 <4F399798.8010601@codeaurora.org>
Message-ID: <4F3A433E.4070309@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On 13/02/12 23:07, Christopher Covington wrote:
> On 02/01/2012 11:59 AM, Marc Zyngier wrote:
>> If CONFIG_LOCAL_TIMERS is not defined, let the architected timer
>> driver register a single clock_event_device that is used as a
>> global timer.
> 
> [snip]
> 
>>  static int __init arch_timer_common_register(void)
>>  {
>> @@ -277,7 +281,16 @@ static int __init arch_timer_common_register(void)
>>  		}
>>  	}
>>  
>> -	err = local_timer_register(&arch_timer_ops);
>> +#ifdef CONFIG_LOCAL_TIMERS
>> +	if (is_smp())
>> +		err = local_timer_register(&arch_timer_ops);
>> +	else
>> +#endif
>> +	{
>> +		arch_timer_global_evt.cpumask = cpumask_of(0);
>> +		err = arch_timer_setup(&arch_timer_global_evt);
>> +	}
>> +
>>  	if (err)
>>  		goto out_free_irq;
>>  
> 
> The logic here seems unnecessarily split between the preprocessor and
> compiler. Certainly this can be revised to a more elegant form that
> better keeps with the guidelines on ifdef usage [1].
> 
> 1. http://www.linuxjournal.com/article/5780?page=0,3

This would require a small change in the local timer code (basically
refusing to register a local timer if not on an SMP platform). But this
is just moving code from one #ifdef section to another...

Thanks for reviewing.

	M.
-- 
Jazz is not dead. It just smells funny...
