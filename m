From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Sep 2012 18:22:44 -0700
Subject: [PATCH V2] ARM: OMAP: counter: add locking to
 read_persistent_clock
In-Reply-To: <87d31bj5jq.fsf@deeprootsystems.com>
References: <1347434081-11469-1-git-send-email-r.sricharan@ti.com>
 <87d31bj5jq.fsf@deeprootsystems.com>
Message-ID: <20120925012243.GR28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [120924 17:44]:
> R Sricharan <r.sricharan@ti.com> writes:
> 
> > From: Colin Cross <ccross@android.com>
> >
> > read_persistent_clock uses a global variable, use a spinlock to
> > ensure non-atomic updates to the variable don't overlap and cause
> > time to move backwards.
> >
> > Signed-off-by: Colin Cross <ccross@android.com>
> > Signed-off-by: R Sricharan <r.sricharan@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Tony, this should probably be queued up for v3.7-rc and flagged for stable.

Yes I can see that happening. But then in addition..

> > ---
> >  [V2] Added signed-off-by and looped in "linux-arm-kernel" list
> >
> >  arch/arm/plat-omap/counter_32k.c |   21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> > index dbf1e03..2bc51fb 100644
> > --- a/arch/arm/plat-omap/counter_32k.c
> > +++ b/arch/arm/plat-omap/counter_32k.c
> > @@ -55,22 +55,29 @@ static u32 notrace omap_32k_read_sched_clock(void)
> >   * nsecs and adds to a monotonically increasing timespec.
> >   */
> >  static struct timespec persistent_ts;
> > -static cycles_t cycles, last_cycles;
> > +static cycles_t cycles;
> >  static unsigned int persistent_mult, persistent_shift;
> > +static DEFINE_SPINLOCK(read_persistent_clock_lock);
> > +
> >  static void omap_read_persistent_clock(struct timespec *ts)
> >  {
> >  	unsigned long long nsecs;
> > -	cycles_t delta;
> > -	struct timespec *tsp = &persistent_ts;
> > +	cycles_t last_cycles;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&read_persistent_clock_lock, flags);
> >  
> >  	last_cycles = cycles;
> >  	cycles = sync32k_cnt_reg ? __raw_readl(sync32k_cnt_reg) : 0;
> > -	delta = cycles - last_cycles;
> >  
> > -	nsecs = clocksource_cyc2ns(delta, persistent_mult, persistent_shift);
> > +	nsecs = clocksource_cyc2ns(cycles - last_cycles,
> > +					persistent_mult, persistent_shift);

..I think there's another bug here where cycles - last_cycles
returns wrong value when the timer wraps around as cycles_t is
64 bits and the counter is 32 bits. It seems it's been there
since when the read_persistent_clock was added with commit
d92cfcbe (OMAP: timekeeping: time should not stop during suspend)?

It seems that after this patch cycles should not be cycles_t
but u32, and the result of cycles - last_cycles should also
be u32.

> > +	timespec_add_ns(&persistent_ts, nsecs);
> > +
> > +	*ts = persistent_ts;
> >  
> > -	timespec_add_ns(tsp, nsecs);
> > -	*ts = *tsp;
> > +	spin_unlock_irqrestore(&read_persistent_clock_lock, flags);
> >  }

Regards,

Tony
