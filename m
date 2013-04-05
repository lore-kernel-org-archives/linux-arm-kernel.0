From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 05 Apr 2013 11:04:05 +0100
Subject: [PATCH] ARM: arch_timer: Silence debug preempt warnings
In-Reply-To: <515E5CFC.4090900@codeaurora.org>
References: <1364934672-31554-1-git-send-email-sboyd@codeaurora.org>
 <515E5CFC.4090900@codeaurora.org>
Message-ID: <515EA195.4010307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 05/04/13 06:11, Stephen Boyd wrote:
> On 4/2/2013 1:31 PM, Stephen Boyd wrote:
>> Hot-plugging with CONFIG_DEBUG_PREEMPT=y on a device with arm
>> architected timers causes a slew of "using smp_processor_id() in
>> preemptible" warnings:
>>
>>   BUG: using smp_processor_id() in preemptible [00000000] code: sh/111
>>   caller is arch_timer_cpu_notify+0x14/0xc8
>>
>> This happens because sometimes the cpu notifier, arch_timer_cpu_notify(),
>> is called in preemptible context but we use this_cpu_ptr()
>> to retrieve the clockevent unconditionally. We're only going to
>> actually use the pointer in non-preemptible context though,
>> so use __this_cpu_ptr() instead to avoid the preemptible checks
>> and silence the warning.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Marc Zyngier <Marc.Zyngier@arm.com>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
> 
> Anyone else seeing this one?

Haven't seen this one occurring yet. I suspect my compiler is optimizing
the code in ways that prevent the breakage from being seen.

> 
>>  drivers/clocksource/arm_arch_timer.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>> index d7ad425..5928c29 100644
>> --- a/drivers/clocksource/arm_arch_timer.c
>> +++ b/drivers/clocksource/arm_arch_timer.c
>> @@ -248,7 +248,7 @@ static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
>>  static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
>>  					   unsigned long action, void *hcpu)
>>  {
>> -	struct clock_event_device *evt = this_cpu_ptr(arch_timer_evt);
>> +	struct clock_event_device *evt = __this_cpu_ptr(arch_timer_evt);
>>  
>>  	switch (action & ~CPU_TASKS_FROZEN) {
>>  	case CPU_STARTING:

I'm afraid this would hide bugs if we start using the notifier for other
purposes than exclusivity non-preemptible contexts.

How about moving the this_cpu_ptr() down to the cases themselves, maybe
with a nice comment?

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
