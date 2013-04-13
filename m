From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Apr 2013 17:49:47 -0700
Subject: [PATCHv2] ARM: arch_timer: Silence debug preempt warnings
In-Reply-To: <211ac95efd49bd57933aec8c8e746648@localhost>
References: <1365195449-6755-1-git-send-email-sboyd@codeaurora.org>
 <211ac95efd49bd57933aec8c8e746648@localhost>
Message-ID: <5168ABAB.4090402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/13 03:41, Marc Zyngier wrote:
> On Fri,  5 Apr 2013 13:57:29 -0700, Stephen Boyd <sboyd@codeaurora.org>
> wrote:
>> Hot-plugging with CONFIG_DEBUG_PREEMPT=y on a device with arm
>> architected timers causes a slew of "using smp_processor_id() in
>> preemptible" warnings:
>>
>>   BUG: using smp_processor_id() in preemptible [00000000] code: sh/111
>>   caller is arch_timer_cpu_notify+0x14/0xc8
>>
>> This happens because sometimes the cpu notifier,
>> arch_timer_cpu_notify(), is called in preemptible context and
>> other times in non-preemptible context but we use this_cpu_ptr()
>> to retrieve the clockevent in all cases. We're only going to
>> actually use the pointer in non-preemptible context though, so
>> push the this_cpu_ptr() access down into the cases to force the
>> checks to occur only in non-preemptible contexts.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> Changes since v1:
>>  * Pushed down this_cpu_ptr and added a comment
>>
>>  drivers/clocksource/arm_arch_timer.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c
>> b/drivers/clocksource/arm_arch_timer.c
>> index d7ad425..a65a710 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -248,14 +248,16 @@ static void __cpuinit arch_timer_stop(struct
>> clock_event_device *clk)
>>  static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
>>  					   unsigned long action, void *hcpu)
>>  {
>> -	struct clock_event_device *evt = this_cpu_ptr(arch_timer_evt);
>> -
>> +	/*
>> +	 * Grab cpu pointer in each case to avoid spurious
>> +	 * preemptible warnings
>> +	 */
>>  	switch (action & ~CPU_TASKS_FROZEN) {
>>  	case CPU_STARTING:
>> -		arch_timer_setup(evt);
>> +		arch_timer_setup(this_cpu_ptr(arch_timer_evt));
>>  		break;
>>  	case CPU_DYING:
>> -		arch_timer_stop(evt);
>> +		arch_timer_stop(this_cpu_ptr(arch_timer_evt));
>>  		break;
>>  	}
> Looks good to me.
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>

Thanks Marc.

Thomas/John, can you pick this up for 3.10?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
