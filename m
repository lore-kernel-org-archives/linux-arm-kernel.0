From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed, 08 Dec 2010 20:22:36 -0800
Subject: [PATCH v2 4/6] msm: timer: SMP timer support for msm
In-Reply-To: <20101208163956.GO9777@n2100.arm.linux.org.uk>
References: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>	<1291782501-3909-5-git-send-email-johlstei@codeaurora.org>
	<20101208163956.GO9777@n2100.arm.linux.org.uk>
Message-ID: <4D00598C.3000306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Tue, Dec 07, 2010 at 08:28:19PM -0800, Jeff Ohlstein wrote:
>> Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
>
> I think Thomas' comments still apply to this patch.  In addition:
>
>> @@ -65,49 +78,67 @@ struct msm_clock {
>>  	void __iomem                *regbase;
>>  	uint32_t                    freq;
>>  	uint32_t                    shift;
>> +	void                        *global_counter;
>> +	void                        *local_counter;
>
> These seem to be mmio addresses, so they should be 'void __iomem *' not
> just 'void *'.
>

Done.

>> +enum {
>> +	MSM_CLOCK_GPT,
>> +	MSM_CLOCK_DGT,
>> +	NR_TIMERS,
>> +};
>
> If these are supposed to be indexes to msm_clocks[], then please use
> them as explicit array initializers in there - it adds useful
> documentation so its not necessary to search around to find out
> what's going on.
>

Yes that is what they are for, done.

>> -static cycle_t msm_gpt_read(struct clocksource *cs)
>> +static cycle_t msm_read_timer_count(struct clocksource *cs)
>>  {
>> -	return readl(MSM_GPT_BASE + TIMER_COUNT_VAL);
>> +	struct msm_clock *clk = container_of(cs, struct msm_clock, clocksource);
>> +
>> +	return readl(clk->global_counter) >> clk->shift;
>>  }
>
> Err.  This is what the core clocksource code does:
>
>         cycle_now = tc->cc->read(tc->cc);
>
>         /* calculate the delta since the last timecounter_read_delta(): */
>         cycle_delta = (cycle_now - tc->cycle_last) & tc->cc->mask;
>
>         /* convert to nanoseconds: */
>         ns_offset = cyclecounter_cyc2ns(tc->cc, cycle_delta);
>
> static inline u64 cyclecounter_cyc2ns(const struct cyclecounter *cc,
>                                       cycle_t cycles)
> {
>         u64 ret = (u64)cycles;
>         ret = (ret * cc->mult) >> cc->shift;
>         return ret;
>
> So doesn't this result in shifting left twice?
>
Seems so, fixed.
>> +#ifdef CONFIG_SMP
>> +void local_timer_setup(struct clock_event_device *evt)
>> +{
>> +	unsigned long flags;
>> +	struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
>> +
>> +	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
>> +
>> +	if (!local_clock_event) {
>> +		writel(0, clock->regbase  + TIMER_ENABLE);
>> +		writel(0, clock->regbase + TIMER_CLEAR);
>> +		writel(~0, clock->regbase + TIMER_MATCH_VAL);
>> +	}
>> +	evt->irq = clock->irq.irq;
>> +	evt->name = "local_timer";
>> +	evt->features = CLOCK_EVT_FEAT_ONESHOT;
>> +	evt->rating = clock->clockevent.rating;
>> +	evt->set_mode = msm_timer_set_mode;
>> +	evt->set_next_event = msm_timer_set_next_event;
>> +	evt->shift = clock->clockevent.shift;
>> +	evt->mult = div_sc(clock->freq, NSEC_PER_SEC, evt->shift);
>> +	evt->max_delta_ns =
>> +		clockevent_delta2ns(0xf0000000 >> clock->shift, evt);
>> +	evt->min_delta_ns = clockevent_delta2ns(4, evt);
>> +	evt->cpumask = cpumask_of(smp_processor_id());
>> +
>> +	local_clock_event = evt;
>> +
>> +	local_irq_save(flags);
>> +	get_irq_chip(clock->irq.irq)->unmask(clock->irq.irq);
>> +	local_irq_restore(flags);
>
> I can't make out what the situation is here.  Are you using what is a
> local timer on CPU0 as a global timer?
>
Yes, sorry for the lack of clarity here, I will add better commit text
explaining it. The chip has a set of timers private to each core. They are
mapped at the same address, and which one you access is dependent on 
which core
you are running on. However, since Linux wants a non-percpu clocksource 
that it
can read from either core, I have decided to designate cpu 0's timer as the
global timer. So, we ought to configure the local clock_event_device to 
be the
same as whichever timer we are using on cpu0.

-Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
