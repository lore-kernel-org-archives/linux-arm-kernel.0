From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Apr 2013 10:34:15 -0700
Subject: [PATCH 1/2] clocksource: arm_arch_timer: unify sched_clock init
In-Reply-To: <51709FD7.8050408@gmail.com>
References: <1366313410-16692-1-git-send-email-robherring2@gmail.com>
 <51708918.1070501@codeaurora.org> <51709FD7.8050408@gmail.com>
Message-ID: <51718017.3060405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/13 18:37, Rob Herring wrote:
> On 04/18/2013 07:00 PM, Stephen Boyd wrote:
>> On 04/18/13 12:30, Rob Herring wrote:
>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>> index 122ff05..17ed8e4 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -266,6 +266,15 @@ static struct notifier_block arch_timer_cpu_nb __cpuinitdata = {
>>>  	.notifier_call = arch_timer_cpu_notify,
>>>  };
>>>  
>>> +static u64 sched_clock_mult __read_mostly;
>>> +
>>> +unsigned long long notrace arch_timer_sched_clock(void)
>>> +{
>>> +	return arch_timer_read_counter() * sched_clock_mult;
>>> +}
>>> +unsigned long long sched_clock(void) \
>>> +	__attribute__((weak, alias("arch_timer_sched_clock")));
>> I'm still lost, how does this prevent the timer in ARM's 32 bit
>> sched_clock code from getting setup in sched_clock_postinit()? That
>> print is still there right? 

I still see this:

[    0.000000] sched_clock: ARM arch timer >56 bits at 19200kHz,
resolution 52ns
[    0.000000] Architected cp15 timer running at 19.20MHz (virt).
[    0.000000] Switching to timer-based delay loop
[    0.000000] sched_clock: 32 bits at 100 Hz, resolution 10000000ns,
wraps every 4294967286ms


>> Who owns sched_clock() in multi-target builds?
> For arm64, it does not define sched_clock, so it will get
> arch_timer_sched_clock.
>
> For arm, sched_clock is defined in arch/arm/kernel/sched_clock.c and the
> weak alias is not used. The arm sched_clock function just calls a
> function pointer which defaults to sched_clock_32 (which is the original
> arm sched_clock implementation). If the arch timer is present, then the
> function pointer is set to arch_timer_sched_clock and any calls to
> setup_sched_clock and the sched_clock_postinit have no effect.
> Otherwise, the functionality is basically unchanged for <=32-bit
> sched_clock implementations.

Ok. I was missing the part where the function pointer is assigned.

>
>> Why can't we play along with the sched_clock code that lives in arm?
>> Maybe we should resurrect those clocksource sched_clock patches again.
>> Or maybe we should add support for setup_sched_clock_64() in arm's sched
>> clock code.
> That's what I originally had which Russell objected to. The needs for
> the arch timer is a bit different since we don't need to deal with
> wrapping. And we need the same boot time offset and suspend handling in
> both arm and arm64.
>

I would much rather we play along with arm's sched_clock code. If we can
add support for 64 bits alongside the 32 bit stuff in the same file we
should be able to generalize the entire code to generic kernel code and
use it on even more arches. I'll try to put something together today.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
