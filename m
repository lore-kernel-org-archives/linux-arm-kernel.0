From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Thu, 11 Sep 2014 11:07:34 -0500
Subject: [PATCH] clocksource: arch_timer: Allow the device tree to specify
 the physical timer
In-Reply-To: <5411C68B.6090308@codeaurora.org>
References: <1410450727-8182-1-git-send-email-dianders@chromium.org>
 <5411C68B.6090308@codeaurora.org>
Message-ID: <5411C8C6.4060509@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2014 10:58 AM, Christopher Covington wrote:
> 
> On 09/11/2014 11:52 AM, Doug Anderson wrote:
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index 5163ec1..8ca07a9 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -649,6 +649,9 @@ static void __init arch_timer_init(struct device_node *np)
>>  		arch_timer_ppi[i] = irq_of_parse_and_map(np, i);
>>  	arch_timer_detect_rate(NULL, np);
>>  
>> +	if (of_property_read_bool(np, "arm,use-physical-timer"))
>> +		arch_timer_use_virtual = false;
>> +
>>  	/*
>>  	 * If HYP mode is available, we know that the physical timer
>>  	 * has been configured to be accessible from PL1. Use it, so
>>
> 
> How's the VDSO supposed to deal with this? It currently does:
> 
> cycle_now = arch_counter_get_cntvct()

Note the VDSO for 32-bit ARM is still out of tree so there's no mainline
regression in that respect.

I think as long as there's some way for the vdso initialization code to
discover that it can't use the virtual counter, it should be tractable.
 If that involves adding an API to the arch timer code, that can be
added along with the vdso code.
