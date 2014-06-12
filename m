From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Thu, 12 Jun 2014 07:45:36 +0000
Subject: [PATCH] clocksource: arch_arm_timer: Fix timecounter
 initialization
In-Reply-To: <5398A7B2.6030807@codeaurora.org>
References: <1402475861-15354-1-git-send-email-Li.Xiubo@freescale.com>
 <5398A7B2.6030807@codeaurora.org>
Message-ID: <bce193f3fc264abf82ff52ef69f0b86a@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  drivers/clocksource/arm_arch_timer.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clocksource/arm_arch_timer.c
> b/drivers/clocksource/arm_arch_timer.c
> > index 5163ec1..6c3cfd8 100644
> > --- a/drivers/clocksource/arm_arch_timer.c
> > +++ b/drivers/clocksource/arm_arch_timer.c
> > @@ -426,7 +426,7 @@ struct timecounter *arch_timer_get_timecounter(void)
> >
> >  static void __init arch_counter_register(unsigned type)
> >  {
> > -	u64 start_count;
> > +	u64 start_count, start_ns;
> >
> >  	/* Register the CP15 based counter if we have one */
> >  	if (type & ARCH_CP15_TIMER)
> > @@ -438,7 +438,8 @@ static void __init arch_counter_register(unsigned type)
> >  	clocksource_register_hz(&clocksource_counter, arch_timer_rate);
> >  	cyclecounter.mult = clocksource_counter.mult;
> >  	cyclecounter.shift = clocksource_counter.shift;
> > -	timecounter_init(&timecounter, &cyclecounter, start_count);
> > +	start_ns = cyclecounter_cyc2ns(&cyclecounter, start_count);
> > +	timecounter_init(&timecounter, &cyclecounter, start_ns);
> >
> >  	/* 56 bits minimum, so we assume worst case rollover */
> >  	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
> 
> This doesn't make much sense. We're converting start_count, which could
> be a very large number, into nanoseconds. It looks like we're assuming
> the counter always starts at 0 which is not always true if you sit in a
> bootloader for a long time. 

Yes, the counter here may usually start counting at bootloader time from zero.


> Perhaps it would be better to just do
> 
>     timecounter_init(&timecounter, &cyclecounter, 0);
> 
> or
> 
>     timecounter_init(&timecounter, &cyclecounter,
> ktime_to_ns(ktime_get_real()));
> 

Here the ktime_get_real() will always return 0, before setting the system clock,
Like:

"rtc-ds3232 1-0068: setting system clock to 2014-06-12 13:01:24 UTC (1402578084)"

And if so, why not just set it to 0 ? And by the way, 0 is must here ?

Thanks,
BRs
Xiubo
