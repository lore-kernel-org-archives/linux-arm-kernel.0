From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 26 Feb 2015 09:03:47 +0100
Subject: [RFC PATCH 0/3] genirq: mixing IRQF_NO_SUSPEND and wakeup
 sources on shared IRQs
In-Reply-To: <2154999.DTKV1bGBcx@vostro.rjw.lan>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <2154999.DTKV1bGBcx@vostro.rjw.lan>
Message-ID: <20150226090347.777c47ec@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On Wed, 25 Feb 2015 22:59:36 +0100
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Tuesday, February 24, 2015 10:55:59 AM Boris Brezillon wrote:
> > Hello,
> > 
> > I put the IRQF_NO_SUSPEND_SAFE/IRQF_TIMER_SIBLING_OK/WHATEVER_NAME_YOU_CHOOSE
> > debate aside to concentrate on another problem pointed out by Rafael and
> > Mark: the fact that we cannot mix IRQF_NO_SUSPEND and wakeup sources on
> > a shared IRQ line.
> > 
> > This is because the wakeup code is prevailing the IRQF_NO_SUSPEND case
> > and will trigger a system wakeup as soon as the IRQ line is tagged as a
> > wakeup source.
> > 
> > This series propose an approach to deal with such cases by doing the
> > following:
> > 1/ Prevent any system wakeup when at least one of the IRQ user has set
> >    the IRQF_NO_SUSPEND flag
> > 2/ Adapt IRQ handlers so that they can safely be called in suspended
> >    state
> > 3/ Let drivers decide when the system should be woken up
> > 
> > Let me know what you think of this approach.
> 
> So I have the appended patch that should deal with all that too (it doesn't
> rework drivers that need to share NO_SUSPEND IRQs and do wakeup, but that
> can be done on top of it in a straightforward way).
> 
> The idea is quite simple.  By default, the core replaces the interrupt handlers
> of everyone sharing NO_SUSPEND lines and not using IRQF_NO_SUSPEND with a null
> handler always returning IRQ_NONE at the suspend_device_irqs() time (the
> rationale being that if you don't use IRQF_NO_SUSPEND, then your device has
> no reason to generate interrupts after that point).  The original handlers are
> then restored by resume_device_irqs().
> 
> However, if the IRQ is configured for wakeup, there may be a reason to generate
> interrupts from a device not using IRQF_NO_SUSPEND.  For that, the patch adds
> IRQF_COND_SUSPEND that, if set, will prevent the default behavior described
> above from being applied to irqactions using it if the IRQs in question are
> configured for wakeup.  Of course, the users of IRQF_COND_SUSPEND are supposed
> to implement wakeup detection in their interrupt handlers and then call
> pm_system_wakeup() if necessary.

That patch sounds good to me.
Could you send it on its own to the appropriate MLs ?

Thomas, Peter, Mark, could you share you opinion ?
I know I'm a bit insistent on this fix, but I'd really like to get away
from this warning backtrace (and the associated problems behind it) as
soon as possible.

> 
> So your patch [3/3] could be redone on top of this AFAICS.

Absolutely.

Thanks.

Boris

> 
> Rafael
> 
> 
> ---
>  include/linux/interrupt.h |   10 +++++++++
>  kernel/irq/pm.c           |   49 ++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 55 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/include/linux/interrupt.h
> ===================================================================
> --- linux-pm.orig/include/linux/interrupt.h
> +++ linux-pm/include/linux/interrupt.h
> @@ -57,6 +57,11 @@
>   * IRQF_NO_THREAD - Interrupt cannot be threaded
>   * IRQF_EARLY_RESUME - Resume IRQ early during syscore instead of at device
>   *                resume time.
> + * IRQF_COND_SUSPEND - If the IRQ is shared with a NO_SUSPEND user and it is
> + *                configured for system wakeup, execute this interrup handler
> + *                after suspending interrupts as it may be necessary to detect
> + *                wakeup. Users need to implement system wakeup detection in
> + *                their interrupt handlers.
>   */
>  #define IRQF_DISABLED		0x00000020
>  #define IRQF_SHARED		0x00000080
> @@ -70,6 +75,7 @@
>  #define IRQF_FORCE_RESUME	0x00008000
>  #define IRQF_NO_THREAD		0x00010000
>  #define IRQF_EARLY_RESUME	0x00020000
> +#define IRQF_COND_SUSPEND	0x00040000
>  
>  #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
>  
> @@ -101,6 +107,7 @@ typedef irqreturn_t (*irq_handler_t)(int
>   * @thread_flags:	flags related to @thread
>   * @thread_mask:	bitmask for keeping track of @thread activity
>   * @dir:	pointer to the proc/irq/NN/name entry
> + * @saved_handler:	address of the original interrupt handler function
>   */
>  struct irqaction {
>  	irq_handler_t		handler;
> @@ -115,6 +122,9 @@ struct irqaction {
>  	unsigned long		thread_mask;
>  	const char		*name;
>  	struct proc_dir_entry	*dir;
> +#ifdef CONFIG_PM_SLEEP
> +	irq_handler_t		saved_handler;
> +#endif
>  } ____cacheline_internodealigned_in_smp;
>  
>  extern irqreturn_t no_action(int cpl, void *dev_id);
> Index: linux-pm/kernel/irq/pm.c
> ===================================================================
> --- linux-pm.orig/kernel/irq/pm.c
> +++ linux-pm/kernel/irq/pm.c
> @@ -43,9 +43,6 @@ void irq_pm_install_action(struct irq_de
>  
>  	if (action->flags & IRQF_NO_SUSPEND)
>  		desc->no_suspend_depth++;
> -
> -	WARN_ON_ONCE(desc->no_suspend_depth &&
> -		     desc->no_suspend_depth != desc->nr_actions);
>  }
>  
>  /*
> @@ -63,11 +60,53 @@ void irq_pm_remove_action(struct irq_des
>  		desc->no_suspend_depth--;
>  }
>  
> +static irqreturn_t irq_pm_null_handler(int irq, void *context)
> +{
> +	return IRQ_NONE;
> +}
> +
> +static void prepare_no_suspend_irq(struct irq_desc *desc)
> +{
> +	struct irqaction *action;
> +
> +	for (action = desc->action; action; action = action->next) {
> +		if (action->flags & IRQF_NO_SUSPEND)
> +			continue;
> +
> +		if ((action->flags & IRQF_COND_SUSPEND) &&
> +		    irqd_is_wakeup_set(&desc->irq_data))
> +			continue;
> +
> +		action->saved_handler = action->handler;
> +		action->handler = irq_pm_null_handler;
> +	}
> +}
> +
> +static void restore_no_suspend_irq(struct irq_desc *desc)
> +{
> +	struct irqaction *action;
> +
> +	for (action = desc->action; action; action = action->next) {
> +		if (action->flags & IRQF_NO_SUSPEND)
> +			continue;
> +
> +		if (action->saved_handler) {
> +			action->handler = action->saved_handler;
> +			action->saved_handler = NULL;
> +		}
> +	}
> +}
> +
>  static bool suspend_device_irq(struct irq_desc *desc, int irq)
>  {
> -	if (!desc->action || desc->no_suspend_depth)
> +	if (!desc->action)
>  		return false;
>  
> +	if (desc->no_suspend_depth) {
> +		prepare_no_suspend_irq(desc);
> +		return false;
> +	}
> +
>  	if (irqd_is_wakeup_set(&desc->irq_data)) {
>  		irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
>  		/*
> @@ -135,6 +174,8 @@ static void resume_irq(struct irq_desc *
>  	if (desc->istate & IRQS_SUSPENDED)
>  		goto resume;
>  
> +	restore_no_suspend_irq(desc);
> +
>  	/* Force resume the interrupt? */
>  	if (!desc->force_resume_depth)
>  		return;
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
