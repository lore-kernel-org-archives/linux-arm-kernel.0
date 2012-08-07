From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 7 Aug 2012 12:47:04 -0500
Subject: [PATCH] ARM: ep93xx: clockevent support
In-Reply-To: <5021122C.3000503@gmail.com>
References: <1344338474.18237.6.camel@localhost> <5021122C.3000503@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206AAE96C18@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 07, 2012 6:04 AM, Ryan Mallon wrote:
> On 07/08/12 21:21, Yan Burman wrote:
>
>> ARM: ep93xx: clockevent support
>> I have ported to 3.6-rc1 and slightly modified a previous patch for clockevent support for the ep93xx.
>> The porting mainly consists of sched_clock support.
>> Tested on 9302 based board.
>> From: Ahmed Ammar <aammar <at> edge-techno.com>
>> Signed-off-by: Yan Burman <burman.yan@gmail.com>

Hello Yan,

> Hi Yan, some comments below.
>
> ~Ryan

I have a couple minor comments as well...

<snip>

>> @@ -114,63 +117,129 @@ void __init ep93xx_map_io(void)
>>  #define EP93XX_TIMER4_CLOCK		983040
>>  
>>  #define TIMER1_RELOAD			((EP93XX_TIMER123_CLOCK / HZ) - 1)
>> -#define TIMER4_TICKS_PER_JIFFY		DIV_ROUND_CLOSEST(CLOCK_TICK_RATE, HZ)
>> -
>> -static unsigned int last_jiffy_time;
>>  
>>  static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
>>  {
>> -	/* Writing any value clears the timer interrupt */

Please leave this comment for the write to EP93XX_TIMER1_CLEAR
below.

>> -	__raw_writel(1, EP93XX_TIMER1_CLEAR);
>> +	struct clock_event_device *evt = dev_id;
>>  
>> -	/* Recover lost jiffies */
>> -	while ((signed long)
>> -		(__raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time)
>> -						>= TIMER4_TICKS_PER_JIFFY) {
>> -		last_jiffy_time += TIMER4_TICKS_PER_JIFFY;
>> -		timer_tick();
>> -	}
>> +	__raw_writel(1, EP93XX_TIMER1_CLEAR);
>> +	evt->event_handler(evt);
>>  
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static int ep93xx_set_next_event(unsigned long evt,
>> +				struct clock_event_device *unused)
>> +{
>> +	u32 tmode = __raw_readl(EP93XX_TIMER1_CONTROL);
>> +
>> +	/* stop timer */
>> +	__raw_writel(tmode & ~EP93XX_TIMER123_CONTROL_ENABLE,
>> +			EP93XX_TIMER1_CONTROL);
>> +	/* program timer */
>> +	__raw_writel(evt, EP93XX_TIMER1_LOAD);
>> +	/* start timer */
>> +	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
>> +			EP93XX_TIMER1_CONTROL);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ep93xx_set_mode(enum clock_event_mode mode,
>> +			    struct clock_event_device *evt)
>> +{
>> +	u32 tmode = EP93XX_TIMER123_CONTROL_CLKSEL;
>> +	/* Disable timer */
>
>
> Nitpick - blank line between variable declarations and code.
>
>> +	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
>> +
>> +	switch (mode) {
>> +	case CLOCK_EVT_MODE_PERIODIC:
>> +		/* Set timer period  */
>> +		__raw_writel((508469 / HZ) - 1, EP93XX_TIMER1_LOAD);

As Ryan mentions below.  There are defines already in this file
for some of the magic values.

The ((508469 / HZ) - 1) is TIMER1_RELOAD.

>> +		tmode |= EP93XX_TIMER123_CONTROL_MODE;
>> +


Is the fall-through here intentional? If so, please put a comment
to indicate that it is.

>> +	case CLOCK_EVT_MODE_ONESHOT:
>> +		tmode |= EP93XX_TIMER123_CONTROL_ENABLE;
>> +		__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
>> +		break;
>> +
>> +	case CLOCK_EVT_MODE_SHUTDOWN:
>> +	case CLOCK_EVT_MODE_UNUSED:
>> +	case CLOCK_EVT_MODE_RESUME:
>> +		return;
>
>
> These cases can be removed.
>
>> +	}
>> +}
>> +
>> +static struct clock_event_device clockevent_ep93xx = {

Nitpick, rename this to ep93xx_clockevent please.

>> +	.name		= "ep93xx-timer1",
>> +	.features	= CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
>> +	.shift		= 32,
>> +	.set_mode	= ep93xx_set_mode,
>> +	.set_next_event	= ep93xx_set_next_event,
>> +};
>> +
>>  static struct irqaction ep93xx_timer_irq = {
>>  	.name		= "ep93xx timer",
>>  	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
>>  	.handler	= ep93xx_timer_interrupt,
>> +	.dev_id		= &clockevent_ep93xx,
>>  };
>>  
>> -static void __init ep93xx_timer_init(void)
>> +static void __init ep93xx_clockevent_init(void)
>>  {

Assuming the rename above, add:

	struct clock_event_device *evt = &ep93xx_clockevent;

Then you can use 'evt->' instead of the longer 'ep93xx_clockevent.'
in the rest of this function. It makes the code a bit cleaner.

>> -	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
>> -		    EP93XX_TIMER123_CONTROL_CLKSEL;
>> +	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
>> +	clockevent_ep93xx.mult = div_sc(508469, NSEC_PER_SEC,
>> +					clockevent_ep93xx.shift);
>
>
> core.c has:
>
>  #define EP93XX_TIMER123_CLOCK               508469
>
> Maybe we should move that to soc.h so you can use it here.

No need to move the defines to soc.h. They are only used in this file.

>> +	clockevent_ep93xx.max_delta_ns =
>> +		clockevent_delta2ns(0xfffffffe, &clockevent_ep93xx);
>> +	clockevent_ep93xx.min_delta_ns =
>> +		clockevent_delta2ns(0xf, &clockevent_ep93xx);
>> +	clockevent_ep93xx.cpumask = cpumask_of(0);
>> +	clockevents_register_device(&clockevent_ep93xx);
>> +}
>>  
>> -	/* Enable periodic HZ timer.  */
>> -	__raw_writel(tmode, EP93XX_TIMER1_CONTROL);
>> -	__raw_writel(TIMER1_RELOAD, EP93XX_TIMER1_LOAD);
>> -	__raw_writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
>> -			EP93XX_TIMER1_CONTROL);
>> +/*
>> + * timer4 is a 40 Bit timer, separated in a 32bit and a 8 bit
>> + * register, EP93XX_TIMER4_VALUE_LOW stores 32 bit word. The
>> + * controlregister is in EP93XX_TIMER4_VALUE_HIGH

I don't think this comment is needed.

> Missing space between control and register.
>
>> + */
>> +static cycle_t ep93xx_get_cycles(struct clocksource *unused)
>> +{
>> +	return __raw_readl(EP93XX_TIMER4_VALUE_LOW);
>> +}
>>  
>> -	/* Enable lost jiffy timer.  */
>> -	__raw_writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
>> -			EP93XX_TIMER4_VALUE_HIGH);
>> +static struct clocksource clocksource_ep93xx = {

Nitpick, rename this to ep93xx_clocksource.

>> +	.name		= "ep93xx_timer4",

Nitpick, use "ep93xx-timer4" for the name, the "-" is used
consistently in this file for all the names.

>> +	.rating		= 200,
>> +	.read		= ep93xx_get_cycles,
>> +	.mask		= 0xFFFFFFFF,
>>
>
> Lower case for hex constant.
>
>> +	.shift		= 20,
>> +	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
>> +};
>>  
>> -	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
>> +static void __init ep93xx_clocksource_init(void)

Again, assuming the rename above, add:

	struct clocksource *src = &ep93xx_clocksource;

Then use the pointer instead of the actual variable.

>> +{
>> +	/* Reset time-stamp counter */
>> +	__raw_writel(0x100, EP93XX_TIMER4_VALUE_HIGH);

Again, the 0x100 magic value is defined as EP93XX_TIMER4_VALUE_HIGH_ENABLE.

>> +	clocksource_ep93xx.mult =
>> +		clocksource_hz2mult(983040, clocksource_ep93xx.shift);
>
>
> core.c has define EP93XX_TIMER4_CLOCK 983040, probably should move
> that to soc.h also.
>
>> +	clocksource_register(&clocksource_ep93xx);
>>  }
>>  
>> -static unsigned long ep93xx_gettimeoffset(void)
>> +static u32 notrace ep93xx_sched_clock(void)
>>  {
>> -	int offset;
>> -
>> -	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
>> +	return __raw_readl(EP93XX_TIMER4_VALUE_LOW);
>> +}
>>  
>> -	/* Calculate (1000000 / 983040) * offset.  */
>> -	return offset + (53 * offset / 3072);
>> +static void __init ep93xx_timer_init(void)
>> +{
>> +	ep93xx_clocksource_init();
>> +	ep93xx_clockevent_init();
>> +	setup_sched_clock(ep93xx_sched_clock, 32, CLOCK_TICK_RATE);
>>  }
>>  
>>  struct sys_timer ep93xx_timer = {
>>  	.init		= ep93xx_timer_init,
>> -	.offset		= ep93xx_gettimeoffset,
>>  };
>>  
>>  
>> 
>> 

Other than those comments, looks good. I'll try to test this later.

Thanks,
Hartley
