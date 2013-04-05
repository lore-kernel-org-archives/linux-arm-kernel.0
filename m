From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 05 Apr 2013 13:12:05 -0700
Subject: [PATCH] ARM: arch_timer: Silence debug preempt warnings
In-Reply-To: <515EA195.4010307@arm.com>
References: <1364934672-31554-1-git-send-email-sboyd@codeaurora.org>
 <515E5CFC.4090900@codeaurora.org> <515EA195.4010307@arm.com>
Message-ID: <515F3015.6010107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/13 03:04, Marc Zyngier wrote:
>
>>>  drivers/clocksource/arm_arch_timer.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
>>> index d7ad425..5928c29 100644
>>> --- a/drivers/clocksource/arm_arch_timer.c
>>> +++ b/drivers/clocksource/arm_arch_timer.c
>>> @@ -248,7 +248,7 @@ static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
>>>  static int __cpuinit arch_timer_cpu_notify(struct notifier_block *self,
>>>  					   unsigned long action, void *hcpu)
>>>  {
>>> -	struct clock_event_device *evt = this_cpu_ptr(arch_timer_evt);
>>> +	struct clock_event_device *evt = __this_cpu_ptr(arch_timer_evt);
>>>  
>>>  	switch (action & ~CPU_TASKS_FROZEN) {
>>>  	case CPU_STARTING:
> I'm afraid this would hide bugs if we start using the notifier for other
> purposes than exclusivity non-preemptible contexts.
>
> How about moving the this_cpu_ptr() down to the cases themselves, maybe
> with a nice comment?

Ok. v2 coming up.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
