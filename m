From: v1ron@mail.ru (Roman Volkov)
Date: Mon, 21 Dec 2015 23:33:59 +0300
Subject: [PATCH 0/4] clocksource/vt8500: Fix hangs in small delays
In-Reply-To: <20151221112916.40373d2f@anonymous>
References: <1450650492-18996-1-git-send-email-v1ron@mail.ru>
 <20151221112916.40373d2f@anonymous>
Message-ID: <20151221233359.268fe6da@anonymous>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Roman Volkov <v1ron <at> mail.ru> writes:
> 
> > 
> > From: Roman Volkov <rvolkov <at> v1ros.org>
> > 
> > vt8500 timer requires special synchronization for accessing some of
> > its registers. Define special read and write functions to handle
> > this process transparently.
> 
> Maybe introduce such accessor functions (conditionally) into the PXA
> driver and kill this one altogether then?

I don't think maintainers will accept a lot of #ifdefs. I have an idea
to move the common code from the PXA to something like pxa_common.c
(can we give the correct name for it?) and include it from the
vt8500_timer.c and pxa_timer.c.

> If I understood you right, this extra bus synchronization is the only
> thing that makes vt8500 different from PXA, so merging the two files
> right away might be a better long-term option.

Sure. But lets make the vt8500 working at this step.

> > To perform a read from the Timer Count register, user must write a
> > one to the Timer Control register and wait for completion flag by
> > polling the Timer Read Count Active bit.
> > 
> > To perform a write to the Count or Match registers, user must poll
> > the write completion flag for the corresponding register to ensure
> > that the previous write completed and then write the actual value.
> > 
> > Signed-off-by: Roman Volkov <rvolkov <at> v1ros.org>
> > ---
> >  drivers/clocksource/vt8500_timer.c | 90
> +++++++++++++++++++++++++++-----------
> >  1 file changed, 65 insertions(+), 25 deletions(-)
> 
> > diff --git a/drivers/clocksource/vt8500_timer.c
> b/drivers/clocksource/vt8500_timer.c
> > index 7649852..4d7513f 100644
> > --- a/drivers/clocksource/vt8500_timer.c
> > +++ b/drivers/clocksource/vt8500_timer.c
> >  <at>  <at>  -38,36 +38,75  <at>  <at> 
> > 
> >  #define VT8500_TIMER_OFFSET	0x0100
> >  #define VT8500_TIMER_HZ		3000000
> > -#define TIMER_MATCH_VAL		0x0000
> > +#define TIMER_MATCH0_VAL	0
> > +#define TIMER_MATCH1_VAL	0x04
> > +#define TIMER_MATCH2_VAL	0x08
> > +#define TIMER_MATCH3_VAL	0x0c
> >  #define TIMER_COUNT_VAL		0x0010
> >  #define TIMER_STATUS_VAL	0x0014
> >  #define TIMER_IER_VAL		0x001c		/*
> > interrupt enable */ #define TIMER_CTRL_VAL		0x0020
> >  #define TIMER_AS_VAL		0x0024		/*
> > access status */ -#define TIMER_COUNT_R_ACTIVE	(1 <<
> > 5)	/* not ready for read */ -#define
> > TIMER_COUNT_W_ACTIVE	(1 << 4)	/* not ready for write
> > */ -#define TIMER_MATCH_W_ACTIVE	(1 << 0)	/* not
> > ready for write */ - -#define timer_readl(addr)
> > readl_relaxed(regbase + addr) -#define timer_writel(v, addr)
> > writel_relaxed(v, regbase + addr) +/* R/W status flags */
> > +#define TIMER_COUNT_R_ACTIVE	(1 << 5)
> > +#define TIMER_COUNT_W_ACTIVE	(1 << 4)
> > +#define TIMER_MATCH3_W_ACTIVE	(1 << 3)
> > +#define TIMER_MATCH2_W_ACTIVE	(1 << 2)
> > +#define TIMER_MATCH1_W_ACTIVE	(1 << 1)
> > +#define TIMER_MATCH0_W_ACTIVE	(1 << 0)
> > +
> > +#define vt8500_timer_sync(bit)	{ while (readl_relaxed \
> > +				    (regbase + TIMER_AS_VAL) &
> > bit) \
> > +					cpu_relax(); }
> 
> The whole issue around 'loops' counter in these busy waits basically
> boils down to whether we would like a way to try and recover from a
> potential hardware misbehavior.
> 
> You can of course argue that when the system timer misbehaves you
> already have bigger issues to worry about, but does a 10 msec limit
> that was in the original version really hurt?

If we do the merging work with PXA, this code will go away. Have this
variable already fixed some _real_ problem? Otherwise this is excessive
coding.

> >  #define MIN_OSCR_DELTA		16
> > 
> >  static void __iomem *regbase;
> > 
> > -static cycle_t vt8500_timer_read(struct clocksource *cs)
> > +static void vt8500_timer_write(unsigned long reg, u32 value)
> 
> Maybe define this with 'value' first, 'reg' second - to be in line
> with the common prototype of writel and such?

Oh my right-handed habits :)

> Plus if you could take the same name for the macro above
> (timer_writel) and this accessor (vt8500_timer_write) that would
> somewhat reduce extra additions/deletions in this patch. Same for the
> read function.

When we perform our merging work, we have to use the following glue:
...
vt8500_timer_read { ... }
#define timer_read(reg)	vt8500_timer_read(reg)
...
#include pxa_common.c

> <skip>
> 
> >  <at>  <at>  -75,23 +114,24  <at>  <at>  static struct clocksource
> clocksource = {
> >  static int vt8500_timer_set_next_event(unsigned long cycles,
> >  				    struct clock_event_device *evt)
> >  {
> > -	cycle_t alarm = clocksource.read(&clocksource) + cycles;
> > -	while (timer_readl(TIMER_AS_VAL) & TIMER_MATCH_W_ACTIVE)
> > -		cpu_relax();
> > -	timer_writel((unsigned long)alarm, TIMER_MATCH_VAL);
> > +	unsigned long alarm = vt8500_timer_read(TIMER_COUNT_VAL) +
> > cycles;
> 
> I personally like the form above better (via clocksource.read) - even
> if just for the fact that it's shorter and reduces the number of
> places where we use TIMER_COUNT_VAL definition.
> 
> Any specific reasons to rewrite it?

To avoid calculation of the 64-bit cycle_t and remove type casts.

> > -	if ((signed)(alarm - clocksource.read(&clocksource)) <=
> > MIN_OSCR_DELTA)
> > +	vt8500_timer_write(TIMER_MATCH0_VAL, alarm);
> > +	if ((signed)(alarm - vt8500_timer_read(
> > +				TIMER_COUNT_VAL)) <=
> > MIN_OSCR_DELTA) {
> 
> Same here.
