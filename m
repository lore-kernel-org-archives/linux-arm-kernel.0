From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 01 Mar 2011 10:16:36 +0100
Subject: [PATCH 1/3] ARM: S5P: Add s5p_timer support for HRT
In-Reply-To: <20110226142413.GC3640@n2100.arm.linux.org.uk>
References: <1298688357-20775-1-git-send-email-sbkim73@samsung.com>
	<1298688357-20775-2-git-send-email-sbkim73@samsung.com>
	<20110226142413.GC3640@n2100.arm.linux.org.uk>
Message-ID: <4D6CB974.8060003@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 02/26/2011 03:24 PM, Russell King - ARM Linux wrote:
> On Sat, Feb 26, 2011 at 11:45:55AM +0900, Sangbeom Kim wrote:
>> +static irqreturn_t s5p_clock_event_isr(int irq, void *dev_id)
>> +{
>> +	struct clock_event_device *evt = &time_event_device;
> 
> 	struct clock_event_device *evt = dev_id;
> 
>> +
>> +	evt->event_handler(evt);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static struct irqaction s5p_clock_event_irq = {
>> +	.name		= "s5p_time_irq",
>> +	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
>> +	.handler	= s5p_clock_event_isr,
> 
> 	.dev_id	 	= &time_event_device,
> 
>> +};
> ...
>> +static void __init s5p_timer_resources(void)
>> +{
>> +	struct platform_device tmpdev;
>> +
>> +	tmpdev.dev.bus = &platform_bus_type;
>> +
>> +	timerclk = clk_get(NULL, "timers");
>> +	if (IS_ERR(timerclk))
>> +		panic("failed to get timers clock for system timer");
>> +
>> +	clk_enable(timerclk);
>> +
>> +	tmpdev.id = timer_source.event_id;
> 
> So Samsung clock stuff is still being idiotic.  Will this ever be fixed?
> 

Are there any serious difficulties preventing converting Samsung platforms
to clkdev? I don't seem to be aware of any.
Shortcomings of current clk API appeared few times already, and this one
being a disgraceful example.

>> +	tin_event = clk_get(&tmpdev.dev, "pwm-tin");
>> +	if (IS_ERR(tin_event)) {
>> +		clk_put(tin_event);
> 
> Don't clk_put errors.
> 
>> +		panic("failed to get pwm-tin2 clock for system timer");
>> +	}
>> +
>> +	tdiv_event = clk_get(&tmpdev.dev, "pwm-tdiv");
>> +	if (IS_ERR(tdiv_event)) {
>> +		clk_put(tdiv_event);
> 
> Ditto.
> 
>> +		panic("failed to get pwm-tdiv2 clock for system timer");
>> +	}
>> +
>> +	clk_enable(tin_event);
>> +
>> +	tmpdev.id = timer_source.source_id;
>> +	tin_source = clk_get(&tmpdev.dev, "pwm-tin");
>> +	if (IS_ERR(tin_source)) {
>> +		clk_put(tin_source);
> 
> Ditto.
> 
>> +		panic("failed to get pwm-tin4 clock for system timer");
>> +	}
>> +
>> +	tdiv_source = clk_get(&tmpdev.dev, "pwm-tdiv");
>> +	if (IS_ERR(tdiv_source)) {
>> +		clk_put(tdiv_source);
> 
> Ditto.

-- 
Sylwester Nawrocki
Samsung Poland R&D Center
