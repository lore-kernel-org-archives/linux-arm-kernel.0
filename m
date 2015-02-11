From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 11 Feb 2015 18:29:45 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150211171313.GS9154@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150211155720.GQ9154@leverpostej>
 <20150211171515.55d5066f@bbrezillon>
 <2067295.NbJCftPPli@vostro.rjw.lan>
 <20150211171313.GS9154@leverpostej>
Message-ID: <20150211182945.5004586a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Feb 2015 17:13:13 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Feb 11, 2015 at 04:42:22PM +0000, Rafael J. Wysocki wrote:
> > On Wednesday, February 11, 2015 05:15:15 PM Boris Brezillon wrote:
> > > On Wed, 11 Feb 2015 15:57:20 +0000
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > 
> > > > [...]
> > > > 
> > > > > > > > So for the flag at request time approach to work, all the drivers using
> > > > > > > > the interrupt would have to flag they're safe in that context.
> > > > > > > 
> > > > > > > Something like IRQF_"I can share the line with a timer" I guess?  That wouldn't
> > > > > > > hurt and can be checked at request time even.
> > > > > > 
> > > > > > I guess that would have to imply IRQF_SHARED, so we'd have something
> > > > > > like:
> > > > > > 
> > > > > > IRQF_SHARED_SUSPEND_OK - This handler is safe to call spuriously during
> > > > > > 			 suspend in the case the line is shared. The
> > > > > > 			 handler will not access unavailable hardware
> > > > > > 			 or kernel infrastructure during this period.
> > > > > > 
> > > > > > #define __IRQF_SUSPEND_SPURIOUS		0x00040000
> > > > > > #define	IRQF_SHARED_SUSPEND_OK		(IRQF_SHARED | __IRQF_SUSPEND_SPURIOUS)
> > > > > 
> > > > > What about
> > > > > 
> > > > > #define __IRQF_TIMER_SIBLING_OK	0x00040000
> > > > > #define	IRQF_SHARED_TIMER_OK	(IRQF_SHARED | __IRQF_TIMER_SIBLING_OK)
> > > > > 
> > > > > The "suspend" part is kind of a distraction to me here, because that really
> > > > > only is about sharing an IRQ with a timer and the "your interrupt handler
> > > > > may be called when the device is suspended" part is just a consequence of that.
> > > > 
> > > > My rationale was that you didn't really care who else was using the IRQ
> > > > (e.g. the timer); you're just stating that you can survive being called
> > > > during suspend (which is what the driver may need to check for in the
> > > > handler if the device happens to be powered down or whatever).
> > > > 
> > > > So I guess I see it the other way around. This is essentially claiming
> > > > we can handle sharing with IRQF_NO_SUSPEND rather than IRQF_TIMER.
> > > > 
> > > > > So IMO it's better to have "TIMER" in the names to avoid encouraging people to
> > > > > abuse this for other purposes not related to timers.
> > > > 
> > > > In the end a name is a name, and if you think IRQF_SHARED_TIMER_OK is
> > > > better I shan't complain.
> > > > 
> > > > The fundamental issue I'm concerned with is addressed by this approach.
> > > 
> > > Okay then, is anyone taking care of submitting such a patch (Mark ?) ?
> > 
> > Well, I guess I should take the responsibility for that. :-)
> > 
> > I'll try to cut one later today or tomorrow unless someone else beats me to that.
> 
> I had a go at the core part below. Does it look like what you had in
> mind?
> 
> I've given it a go on a hacked-up platform, but I don't have any at91
> stuff to test with, so I haven't bothered with the driver portions just
> yet.
> 
> Thanks,
> Mark.
> 
> ---->8----
> From 2d9013517637bb567fbcde3e20797cb2fab1c4c5 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Wed, 11 Feb 2015 16:44:06 +0000
> Subject: [PATCH] genirq: allow safe sharing of irqs during suspend
> 
> In some cases a physical IRQ line may be shared between devices from
> which we expect interrupts during suspend (e.g. timers) and those we do
> not (e.g. anything we cut the power to). Where a driver did not request
> the interrupt with IRQF_NO_SUSPEND, it's unlikely that it can handle
> being called during suspend, and where the IRQ PM code detects a
> mismatch it produces a loud warning (via WARN_ON_ONCE).
> 
> In a small set of cases the handlers for the devices other than timers
> can tolerate being called during suspend time. In these cases the
> warning is spurious, and masks other potentially unsafe mismatches as it
> is only printed for the first mismatch detected. As the behaviour of the
> handlers is an implementation detail, we cannot rely on external data to
> decide when it is safe for a given interrupt line to be shared in this
> manner.
> 
> This patch adds a new flag, IRQF_SHARED_TIMER_OK, which drivers can use
> when requesting an IRQ to state that they can cope if the interrupt is
> shared with a timer driver (and hence may be raised during suspend). The
> PM code is updated to only warn when a mismatch occurs and at least one
> irqaction has neither asked to be called during suspend or has stated it
> is safe to be called during suspend.
> 
> This reduces the set of warnings to those cases where there is a real
> problem. While it is possible that this flag may be abused, any such
> abuses will be explicit in the kernel source and can be detected.
> 
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  include/linux/interrupt.h |  5 +++++
>  kernel/irq/pm.c           | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index d9b05b5..2b8ff50 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -57,6 +57,9 @@
>   * IRQF_NO_THREAD - Interrupt cannot be threaded
>   * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
>   *                resume time.
> + * IRQF_SHARED_TIMER_OK - Interrupt is safe to be shared with a timer. The
> + *                        handler may be called spuriously during suspend
> + *                        without issue.
>   */
>  #define IRQF_DISABLED		0x00000020
>  #define IRQF_SHARED		0x00000080
> @@ -70,8 +73,10 @@
>  #define IRQF_FORCE_RESUME	0x00008000
>  #define IRQF_NO_THREAD		0x00010000
>  #define IRQF_EARLY_RESUME	0x00020000
> +#define __IRQF_TIMER_SIBLING_OK	0x00040000
>  
>  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
> +#define IRQF_SHARED_TIMER_OK	(IRQF_SHARED | __IRQF_TIMER_SIBLING_OK)
>  
>  /*
>   * These values can be returned by request_any_context_irq() and
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 3ca5325..e4ec91a 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -28,6 +28,47 @@ bool irq_pm_check_wakeup(struct irq_desc *desc)
>  }
>  
>  /*
> + * Check whether an interrupt is safe to occur during suspend.
> + *
> + * Physical IRQ lines may be shared between devices which may be expected to
> + * raise interrupts during suspend (e.g. timers) and those which may not (e.g.
> + * anything we cut the power to). Not all handlers will be safe to call during
> + * suspend, so we need to scream if there's the possibility an unsafe handler
> + * will be called.
> + *
> + * A small number of handlers are safe to be shared with timer interrupts, and
> + * we don't want to warn erroneously for these. Such handlers will not poke
> + * hardware that's not powered or call into kernel infrastructure not available
> + * during suspend. These are marked with __IRQF_TIMER_SIBLING_OK.
> + */
> +bool irq_safe_during_suspend(struct irq_desc * desc, struct irqaction *action)
> +{
> +	const unsigned int safe_flags =
> +		__IRQF_TIMER_SIBLING_OK | IRQF_NO_SUSPEND;
> +
> +	/*
> +	 * If no-one wants to be called during suspend, or if everyone does,
> +	 * then there's no potential conflict.
> +	 */
> +	if (!desc->no_suspend_depth)
> +		return true;
> +	if (desc->no_suspend_depth == desc->nr_actions)
> +		return true;
> +
> +	/*
> +	 * If any action hasn't asked to be called during suspend or is not
> +	 * happy to be called during suspend, we have a potential problem.
> +	 */
> +	if (!(action->flags & safe_flags))
> +		return false;
	else if (!(action->flags & IRQF_NO_SUSPEND) ||
		 desc->no_suspend_depth > 1)
		return true;

Am I missing something or is the following loop only required if
we're adding an action with the IRQF_NO_SUSPEND flag set for the
first time ?

> +	for (action = desc->action; action; action = action->next)
> +		if (!(action->flags & safe_flags))
> +			return false;
> +
> +	return true;
> +}
> +
> +/*
>   * Called from __setup_irq() with desc->lock held after @action has
>   * been installed in the action chain.
>   */
> @@ -44,8 +85,7 @@ void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action)
>  	if (action->flags & IRQF_NO_SUSPEND)
>  		desc->no_suspend_depth++;
>  
> -	WARN_ON_ONCE(desc->no_suspend_depth &&
> -		     desc->no_suspend_depth != desc->nr_actions);
> +	WARN_ON_ONCE(!irq_safe_during_suspend(desc, action));
>  }
>  
>  /*



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
