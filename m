From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Dec 2010 19:40:26 +0000
Subject: [PATCH 28/40] ARM: sched_clock: provide common infrastructure
	for sched_clock()
In-Reply-To: <alpine.LFD.2.00.1012171436100.10437@xanadu.home>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
	<E1PTYmu-0006jS-Na@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1012171334530.10437@xanadu.home>
	<20101217190554.GD9937@n2100.arm.linux.org.uk>
	<20101217191857.GA24940@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1012171436100.10437@xanadu.home>
Message-ID: <20101217194026.GE9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 02:37:41PM -0500, Nicolas Pitre wrote:
> On Fri, 17 Dec 2010, Russell King - ARM Linux wrote:
> 
> > On Fri, Dec 17, 2010 at 07:05:54PM +0000, Russell King - ARM Linux wrote:
> > > Yes, you're right, it should disable local IRQs across the update.  Thanks
> > > for spotting.
> > 
> > Here's the incremental patch for it.  Note that we can safely explicitly
> > disable and re-enable IRQs as the timer subsystem ensures that we will
> > always be called with IRQs enabled:
> > 
> >                         spin_unlock_irq(&base->lock);
> >                         call_timer_fn(timer, fn, data);
> >                         spin_lock_irq(&base->lock);
> > 
> > diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
> > index 82d4d3f..5643cb0 100644
> > --- a/arch/arm/include/asm/sched_clock.h
> > +++ b/arch/arm/include/asm/sched_clock.h
> > @@ -30,7 +30,7 @@ static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> >   * Atomically update the sched_clock epoch.  Your update callback will
> >   * be called from a timer before the counter wraps - read the current
> >   * counter value, and call this function to safely move the epochs
> > - * forward.
> > + * forward.  Only use this from the update callback.
> >   */
> >  static inline void update_sched_clock(struct clock_data *cd, u32 cyc, u32 mask)
> >  {
> > @@ -41,11 +41,13 @@ static inline void update_sched_clock(struct clock_data *cd, u32 cyc, u32 mask)
> >  	 * Write epoch_cyc and epoch_ns in a way that the update is
> >  	 * detectable in cyc_to_fixed_sched_clock().
> >  	 */
> > +	local_irq_disable();
> 
> Actually, wouldn't it be better to use raw_local_irq_disable() here so 
> this is safe with a RT kernel as well?

Grr, there's too many different combinations of stuff... yes, it should be.
