From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 6 Mar 2014 03:18:14 +0000
Subject: [PATCH] clocksource: vf_pit_timer: use complement for
 sched_clock reading
In-Reply-To: <20140306014530.GA11366@S2101-09.ap.freescale.net>
References: <d25af915993aec1b486be653eb86f748ddef54fe.1394057313.git.stefan@agner.ch>
 <20140306014530.GA11366@S2101-09.ap.freescale.net>
Message-ID: <a821b61811ff4861b577ee17ff9f0448@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo at linaro.org]
> Sent: Thursday, March 06, 2014 9:46 AM
> To: Stefan Agner
> Cc: daniel.lezcano at linaro.org; tglx at linutronix.de; linux at arm.linux.org.uk;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Lu
> Jingchang-B35083
> Subject: Re: [PATCH] clocksource: vf_pit_timer: use complement for
> sched_clock reading
> 
> On Wed, Mar 05, 2014 at 11:11:08PM +0100, Stefan Agner wrote:
> > Vybrids PIT register is monitonic decreasing. However, sched_clock
> > reading needs to be monitonic increasing. Use bitwise not to get the
> > complement of the clock register. This fixes the clock going backward.
> > Also, the clock now starts at 0 since we load the register with the
> > maximum value at start.
> >
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Looks correct to me, so
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> But I also copied the driver author Jingchang to see if he has any
> comment.
> 
> Shawn
> 
The fix is correct, thanks.

Best Regards,
Jingchang

> > ---
> >  drivers/clocksource/vf_pit_timer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/vf_pit_timer.c
> > b/drivers/clocksource/vf_pit_timer.c
> > index 02821b0..a918bc4 100644
> > --- a/drivers/clocksource/vf_pit_timer.c
> > +++ b/drivers/clocksource/vf_pit_timer.c
> > @@ -54,7 +54,7 @@ static inline void pit_irq_acknowledge(void)
> >
> >  static u64 pit_read_sched_clock(void)  {
> > -	return __raw_readl(clksrc_base + PITCVAL);
> > +	return ~__raw_readl(clksrc_base + PITCVAL);
> >  }
> >
> >  static int __init pit_clocksource_init(unsigned long rate)
> > --
> > 1.9.0
> >
