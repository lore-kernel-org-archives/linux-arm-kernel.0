From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Feb 2015 11:23:03 +0000
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150212120917.44e58bf6@bbrezillon>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150211155720.GQ9154@leverpostej>
 <20150211171515.55d5066f@bbrezillon>
 <2067295.NbJCftPPli@vostro.rjw.lan>
 <20150211171313.GS9154@leverpostej>
 <20150211182945.5004586a@bbrezillon>
 <20150212105215.GA1522@leverpostej>
 <20150212120917.44e58bf6@bbrezillon>
Message-ID: <20150212112303.GD1522@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 11:09:17AM +0000, Boris Brezillon wrote:
> On Thu, 12 Feb 2015 10:52:15 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > [...]
> > 
> > > > diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> > > > index d9b05b5..2b8ff50 100644
> > > > --- a/include/linux/interrupt.h
> > > > +++ b/include/linux/interrupt.h
> > > > @@ -57,6 +57,9 @@
> > > >   * IRQF_NO_THREAD - Interrupt cannot be threaded
> > > >   * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
> > > >   *                resume time.
> > > > + * IRQF_SHARED_TIMER_OK - Interrupt is safe to be shared with a timer. The
> > > > + *                        handler may be called spuriously during suspend
> > > > + *                        without issue.
> > > >   */
> > > >  #define IRQF_DISABLED		0x00000020
> > > >  #define IRQF_SHARED		0x00000080
> > > > @@ -70,8 +73,10 @@
> > > >  #define IRQF_FORCE_RESUME	0x00008000
> > > >  #define IRQF_NO_THREAD		0x00010000
> > > >  #define IRQF_EARLY_RESUME	0x00020000
> > > > +#define __IRQF_TIMER_SIBLING_OK	0x00040000
> > > >  
> > > >  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
> > > > +#define IRQF_SHARED_TIMER_OK	(IRQF_SHARED | __IRQF_TIMER_SIBLING_OK)
> > > >  
> > > >  /*
> > > >   * These values can be returned by request_any_context_irq() and
> > > > diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> > > > index 3ca5325..e4ec91a 100644
> > > > --- a/kernel/irq/pm.c
> > > > +++ b/kernel/irq/pm.c
> > > > @@ -28,6 +28,47 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
> > > >  }
> > > >  
> > > >  /*
> > > > + * Check whether an interrupt is safe to occur during suspend.
> > > > + *
> > > > + * Physical IRQ lines may be shared between devices which may be expected to
> > > > + * raise interrupts during suspend (e.g. timers) and those which may not (e.g.
> > > > + * anything we cut the power to). Not all handlers will be safe to call during
> > > > + * suspend, so we need to scream if there's the possibility an unsafe handler
> > > > + * will be called.
> > > > + *
> > > > + * A small number of handlers are safe to be shared with timer interrupts, and
> > > > + * we don't want to warn erroneously for these. Such handlers will not poke
> > > > + * hardware that's not powered or call into kernel infrastructure not available
> > > > + * during suspend. These are marked with __IRQF_TIMER_SIBLING_OK.
> > > > + */
> > > > +bool irq_safe_during_suspend(struct irq_desc * desc, struct irqaction *action)
> > > > +{
> > > > +	const unsigned int safe_flags =
> > > > +		__IRQF_TIMER_SIBLING_OK | IRQF_NO_SUSPEND;
> > > > +
> > > > +	/*
> > > > +	 * If no-one wants to be called during suspend, or if everyone does,
> > > > +	 * then there's no potential conflict.
> > > > +	 */
> > > > +	if (!desc->no_suspend_depth)
> > > > +		return true;
> > > > +	if (desc->no_suspend_depth == desc->nr_actions)
> > > > +		return true;
> 
> Just another nit, can't we also return early when
> desc->nr_actions == 1 (I mean, the handler cannot conflict with anything
> since it is the only one registered) ?

I guess we can, but that case is already covered by the above tests.

If the single action was not IRQF_NO_SUSPEND, then
desc->no_suspend_depth == 0, and we return early.

If the single action was IRQF_NO_SUSPEND, then 
desc->no_suspend_depth == desc->nr_actions, and we return early.

We could change the second test to:
if (desc->nr_actions == 1 || desc->nr_actions == desc->no_suspend_depth)

...but I don't see that we gain much by doing so.

> > > > +
> > > > +	/*
> > > > +	 * If any action hasn't asked to be called during suspend or is not
> > > > +	 * happy to be called during suspend, we have a potential problem.
> > > > +	 */
> > > > +	if (!(action->flags & safe_flags))
> > > > +		return false;
> > > 	else if (!(action->flags & IRQF_NO_SUSPEND) ||
> > > 		 desc->no_suspend_depth > 1)
> > > 		return true;
> > > 
> > > Am I missing something or is the following loop only required if
> > > we're adding an action with the IRQF_NO_SUSPEND flag set for the
> > > first time ?
> > 
> > With the check above we could return true incorrectly after the first
> > time we return true. Consider adding the following in order to an empty
> > desc:
> > 
> > 	flags = IRQF_SHARED		// safe, returns true
> > 	flags = IRQF_NO_SUSPEND		// unsafe, returns false
> > 	flags = IRQF_NO_SUSPEND		// unsafe, but returns true
> 
> Yep, you're right.
> 
> > 
> > Currently it shouldn't matter as the only caller is a WARN_ON_ONCE(),
> > but it seems unfortunate to allow this.
> 
> Absolutely, forget about that, I guess we don't have to optimize that
> test anyway.
> 
> > 
> > We'd also run the loop until we had at least two IRQF_NO_SUSPEND
> > irqactions:
> > 
> > 	flags = IRQF_SHARED_TIMER_OK	// early return
> > 	flags = IRQF_NO_SUSPEND		// run loop
> > 	flags = IRQF_SHARED_TIMER_OK	// run loop
> 
> Hm, no, this one would return directly (it's an '||' operator not an
> '&&' one), because we're not adding an IRQF_NO_SUSPEND handler here, and
> adding IRQF_SHARED_TIMER_OK is always safe, isn't it ?

Sorry, you are correct.

> > 	flags = IRQF_SHARED_TIMER_OK	// run loop
> > 	flags = IRQF_SHARED_TIMER_OK	// run loop
> > 	flags = IRQF_NO_SUSPEND		// don't run loop.
> > 	flags = IRQF_SHARED_TIMER_OK	// don't run loop
> > 
> > I assume that we only have one IRQF_NO_SUSPEND action sharing the line
> > anyway in your case?
> 
> Yep.
> 
> > 
> > Given that we'll only bother to run the test if there's a mismatch
> > between desc->no_suspend_depth and desc->nr_actions, I don't think we
> > win much. These cases should be rare in practice, the tests only
> > performed when we request the irq, and there shouldn't be that many
> > actions to loop over.
> 
> Sure, never mind, as I said, I'm not sure extra optimization is needed
> here.

To keep things easy to reason about, let's leave this as-is for now. If
we encounter a performance problem we can see about optimizing.

Thanks,
Mark.
