From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 2 Dec 2010 22:44:06 +0800
Subject: [PATCH 06/15] ARM: mxs: Add timer support
In-Reply-To: <20101130161359.GQ20449@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1290754154-9428-7-git-send-email-shawn.guo@freescale.com>
	<20101130161359.GQ20449@pengutronix.de>
Message-ID: <AANLkTi=V9he4nWQ773sQ17P+AnXqN9RVHA=nhmUc4X=s@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/12/1 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Shawn,
>
[...]
>> +
>> + ? ? /* Disable interrupt in timer module */
>> + ? ? timrot_irq_disable();
>> +
>> + ? ? if (mode != clockevent_mode) {
>> + ? ? ? ? ? ? /* Set event time into far-far future */
>> + ? ? ? ? ? ? __raw_writel(__raw_readl(timer_base +
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? HW_TIMROT_RUNNING_COUNTn(0)) + 3,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? timer_base + HW_TIMROT_MATCH_COUNTn(0));
> I don't know if this is needed, maybe there cannot be a pending event
> when set_mode is called? ?Thomas?
>
Freescale BSP works well without this.  It's probably not needed.

>> +
>> +static struct clocksource clocksource_mxs = {
>> + ? ? .name ? ? ? ? ? = "mxs_timer",
>> + ? ? .rating ? ? ? ? = 200,
>> + ? ? .read ? ? ? ? ? = timrot_get_cycles,
>> + ? ? .mask ? ? ? ? ? = CLOCKSOURCE_MASK(32),
>> + ? ? .shift ? ? ? ? ?= 10,
>> + ? ? .flags ? ? ? ? ?= CLOCK_SOURCE_IS_CONTINUOUS,
>> +};
>> +
>> +static int __init mxs_clocksource_init(struct clk *timer_clk)
>> +{
>> + ? ? unsigned int c = clk_get_rate(timer_clk);
>> +
>> + ? ? if (timrot_is_v1())
>> + ? ? ? ? ? ? clocksource_mxs.mask = CLOCKSOURCE_MASK(16);
> I wonder if a shift of 10 is a bit heavy for a 16 bit timer.
>
I do not understand that.  The shift is used in clocksource_hz2mult() as below.

static inline u32 clocksource_hz2mult(u32 hz, u32 shift_constant)
{
        /*  hz = cyc/(Billion ns)
         *  mult/2^shift  = ns/cyc
         *  mult = ns/cyc * 2^shift
         *  mult = 1Billion/hz * 2^shift
         *  mult = 1000000000 * 2^shift / hz
         *  mult = (1000000000<<shift) / hz
         */
        u64 tmp = ((u64)1000000000) << shift_constant;

        tmp += hz/2; /* round for do_div */
        do_div(tmp, hz);

        return (u32)tmp;
}

The shift is working against the timers frequency (hz).  Should hz be
the thing concerned here instead of timer bit width?  Since both MX23
and MX28 timer are running@32K, so shift value 10 is picked here.

-- 
Regards,
Shawn
