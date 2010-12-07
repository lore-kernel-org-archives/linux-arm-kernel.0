From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Mon, 06 Dec 2010 20:49:11 -0800
Subject: [PATCH 3/5] msm: timer: SMP timer support for msm
In-Reply-To: <alpine.LFD.2.00.1012061025240.2653@localhost6.localdomain6>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>	<1291619778-30289-4-git-send-email-johlstei@codeaurora.org>
	<alpine.LFD.2.00.1012061025240.2653@localhost6.localdomain6>
Message-ID: <4CFDBCC7.60702@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner wrote:
> On Sun, 5 Dec 2010, Jeff Ohlstein wrote:
>>  static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
>>  {
>>  	struct clock_event_device *evt = dev_id;
>> +	if (smp_processor_id() != 0)
>> +		evt = local_clock_event;
>
> Why is dev_id not pointing to the correct device in the first place?
dev_id is specified per struct irqaction, which is registered once per 
irq number. However, each core has a separate clock_event_device. Since 
the timer irq has the same irq number on both cores, we need to know 
what core we are on to know which clock_event_device is the correct one.
>>  
>> +static uint32_t msm_read_timer_count(struct msm_clock *clock,
>> +				     enum timer_location global)
>> +{
>> +	uint32_t t1;
>> +
>> +	if (global)
>> +		t1 = readl(clock->regbase + TIMER_COUNT_VAL + MSM_TMR_GLOBAL);
>> +	else
>> +		t1 = readl(clock->regbase + TIMER_COUNT_VAL);
>> +
>> +	return t1;
>
> Adding such conditionals into a fast path is brilliant. Granted, gcc
> might optimize it out, but I'm not sure given the number of call sites.
>
> What's the point of this exercise ?
The reason is I had a common function for reading a timer count, but 
sometimes we want to read the cpu local timer, such as in the case of 
set_next_event, but sometimes I want to read a global timer, which is at 
a different address. However, you are right that it is silly to put a 
conditional there, especially when which branch I want is static at the 
callsite.
>> +}
>> +
>>  static cycle_t msm_gpt_read(struct clocksource *cs)
>>  {
>> -	return readl(MSM_GPT_BASE + TIMER_COUNT_VAL);
>> +	struct msm_clock *clock = &msm_clocks[MSM_CLOCK_GPT];
>> +	return msm_read_timer_count(clock, GLOBAL_TIMER);
>
> Why don't you store the address of the read register including the
> shift value into the msm_clock structure ?
>
>       clock->counter_reg
>       clock->counter_shift
>
> And then embedd the clocksource struct there as well, so you can
> dereference msm_clock with container_of() and reduce the 3 read
> functions to a single one.
Done.
>> +static struct msm_clock *clockevent_to_clock(struct clock_event_device *evt)
>> +{
>> +#ifdef CONFIG_SMP
>> +	int i;
>> +	for (i = 0; i < NR_TIMERS; i++)
>> +		if (evt == &(msm_clocks[i].clockevent))
>> +			return &msm_clocks[i];
>
> Why don't you use container_of here as well ?
The clockevent could be the local_clock_event, which is not embedded 
into a struct msm_clock. However, its parameters will be the same as one 
of the existing msm_clock entries, so use that.
>>  	if (late >= (-2 << clock->shift) && late < DGT_HZ*5) {
>> -		printk(KERN_NOTICE "msm_timer_set_next_event(%lu) clock %s, "
>> -		       "alarm already expired, now %x, alarm %x, late %d\n",
>> -		       cycles, clock->clockevent.name, now, alarm, late);
>> +		static int print_limit = 10;
>> +		if (print_limit > 0) {
>> +			print_limit--;
>> +			printk(KERN_NOTICE "msm_timer_set_next_event(%lu) "
>> +			       "clock %s, alarm already expired, now %x, "
>> +			       "alarm %x, late %d%s\n",
>> +			       cycles, clock->clockevent.name, now, alarm, late,
>> +			       print_limit ? "" : " stop printing");
>> +		}
>
> The generic clockevents layer has already a check for this. No need
> for extra printk spam.
Done.
>> @@ -107,7 +171,11 @@ static int msm_timer_set_next_event(unsigned long cycles,
>>  static void msm_timer_set_mode(enum clock_event_mode mode,
>>  			      struct clock_event_device *evt)
>>  {
>> -	struct msm_clock *clock = container_of(evt, struct msm_clock, clockevent);
>> +	struct msm_clock *clock = clockevent_to_clock(evt);
>> +	unsigned long irq_flags;
>> +
>> +	local_irq_save(irq_flags);
>
> Always called with interrupts disabled.
Done.
>> +	local_clock_event = evt;
>> +
>> +	local_irq_save(flags);
>> +	get_irq_chip(clock->irq.irq)->unmask(clock->irq.irq);
> Why are you fiddling wiht the irqchip functions directly ? Please use
> disable_irq/enable_irq if at all.
As stated by Russell, this is due to the fact that the timer interrupts 
are private to each core, and share the same irq number on each core.
>> +int local_timer_ack(void)
>> +{
>> +	return 1;
>
> Shouldn't that be an inline ? Why calling code which the compiler
> could optimize out.
Done.
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +void __cpuexit local_timer_stop(void)
>> +{
>> +	local_clock_event->set_mode(CLOCK_EVT_MODE_SHUTDOWN, local_clock_event);
>
> Aarg. No. The generic code already handles cpu hotplug. 
So what needs to be done in local_timer_stop? Just stopping the timer 
from ticking? Aren't I going to want to do all the same things my 
set_mode function does in the shutdown case? I understand not calling 
into the clockevents functions, would you be opposed to me directly 
calling my set_mode function?

-Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
