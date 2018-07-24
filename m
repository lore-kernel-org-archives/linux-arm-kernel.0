From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 24 Jul 2018 17:45:27 +0200
Subject: [PATCH] Add cap_user_time aarch64
In-Reply-To: <20180724151452.GD25412@arm.com>
References: <20180713192451.49280-1-micpof@gmail.com>
 <20180724151452.GD25412@arm.com>
Message-ID: <20180724154527.GS2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 04:14:54PM +0100, Will Deacon wrote:
> Using only compiler barriers here raises my eyebrows a little, but as long
> as this is all in the context of the reader thread, then it should be ok.
> I think it means that the comment in events/core.c is bogus:
> 
> 	/*
> 	 * Disable preemption so as to not let the corresponding user-space
> 	 * spin too long if we get preempted.
> 	 */
> 	preempt_disable();
> 	++userpg->lock;
> 	barrier();
> 
> because user-space won't get stuck spinning unless its running concurrently,
> at which point it's hosed anyway. Hmmm.

Right, we should fix that. The only reason to keep that
preempt_disable() there is so that the various timestamps retain
temporal locality.

> > +void arch_perf_update_userpage(struct perf_event *event,
> > +			       struct perf_event_mmap_page *userpg, u64 now)
> > +{
> > +	u32 freq;
> > +	u32 shift;
> > +
> > +	/*
> > +	 * Internal timekeeping for enabled/running/stopped times
> > +	 * is always computed with the sched_clock.
> > +	 */
> > +	freq = arch_timer_get_rate();
> > +	userpg->cap_user_time = 1;
> > +
> > +	clocks_calc_mult_shift(&userpg->time_mult, &shift, freq,
> > +			NSEC_PER_SEC, 0);
> > +	/*
> > +	 * time_shift is not expected to be greater than 31 due to
> > +	 * the original published conversion algorithm shifting a
> > +	 * 32-bit value (now specifies a 64-bit value) - refer
> > +	 * perf_event_mmap_page documentation in perf_event.h.
> > +	 */
> > +	if (shift == 32) {
> > +		shift = 31;
> > +		userpg->time_mult >>= 1;
> > +	}
> 
> Can you explain this a bit more, please? Given that we've never enabled this
> on arm64, why do we have a problem with a legacy algorithm?

The worry is, I suppose, that someone still uses the old algorithm
and then ports it to arm64 without checking.

> > +	userpg->time_shift = (u16)shift;
> > +	userpg->time_offset = -now;
> > +
> > +	/*
> > +	 * We are always using the sched_clock as the base, so
> > +	 * cap_user_time_zero makes sense.
> > +	 */
> 
> How are you enforcing that we're always using sched_clock?
> 
> > +	userpg->cap_user_time_zero = 1;
> > +	userpg->time_zero = 0;
> 
> I'm not sure we can rely on the architected timer being zero initialised --
> our booting documentation just require it to be consistent between CPUs.

On x86 the above is:

	/*
	 * cap_user_time_zero doesn't make sense when we're using a different
	 * time base for the records.
	 */
	if (!event->attr.use_clockid) {
		userpg->cap_user_time_zero = 1;
		userpg->time_zero = offset;
	}
