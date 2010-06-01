From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 1 Jun 2010 15:26:52 -0700
Subject: [RFC PATCH] irq: handle private interrupt registration
In-Reply-To: <1274905794-7848-1-git-send-email-adharmap@codeaurora.org>
References: <1274905794-7848-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <20100601152652.9296c5d0.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 May 2010 13:29:54 -0700
adharmap at codeaurora.org wrote:

> From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> 
> The current code fails to register a handler for the same irq
> without taking in to account that it could be a per cpu interrupt.
> If the IRQF_PERCPU flag is set, enable the interrupt on that cpu
> and return success.
> 
> Change-Id: I748b3aa08d794342ad74cbd0bb900cc599f883a6
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> ---
> 
> On systems with an interrupt controller that supports
> private interrupts per core, it is not possible to call 
> request_irq/setup_irq from multiple cores for the same irq. This is because
> the second+ invocation of __setup_irq checks if the previous
> hndler had a IRQ_SHARED flag set and errors out if not. 
> 
> The current irq handling code doesnt take in to account what cpu it 
> is executing on.  Usually the local interrupt controller registers are banked 
> per cpu a.k.a. a cpu can enable its local interrupt by writing to its banked 
> registers.
> 
> One way to get around this problem is to call the setup_irq on a single cpu 
> while other cpus simply enable their private interrupts by writing to their 
> banked registers
> 
> For eg. code in arch/arm/time/smp_twd.c
> 	/* Make sure our local interrupt controller has this enabled */
> 	local_irq_save(flags);
> 	get_irq_chip(clk->irq)->unmask(clk->irq);
> 	local_irq_restore(flags);
> 
> This looks like a hacky way to get local interrupts working on 
> multiple cores.
> 
> The patch adds a check for PERCPU flag in __setup_irq - if an handler is 
> present it simply enables that interrupt for that core and returns 0.
> 
> ...
>  
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -683,6 +683,37 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
>  	old_ptr = &desc->action;
>  	old = *old_ptr;
>  	if (old) {
> +#if defined(CONFIG_IRQ_PER_CPU)
> +		/* All handlers must agree on per-cpuness */
> +		if ((old->flags & IRQF_PERCPU) !=
> +			(new->flags & IRQF_PERCPU))
> +			goto mismatch;
> +
> +		if (old->flags & IRQF_PERCPU) {
> +			/* the chip must have been set for this interrupt*/
> +			if (!(desc->status & IRQ_NOAUTOEN)) {
> +				desc->depth = 0;
> +				desc->status &= ~IRQ_DISABLED;
> +				desc->chip->startup(irq);
> +			} else
> +				/* Undo nested disables: */
> +				desc->depth = 1;
> +
> +			spin_unlock_irqrestore(&desc->lock, flags);

The rest of the code uses raw_spin_unlock_irqrestore().

I don't know _why_ is uses this.  There are no code comments, and the
239007b8440abff689632f50cdf0f2b9e895b534 changelog is:

: genirq: Convert irq_desc.lock to raw_spinlock
:    
: Convert locks which cannot be sleeping locks in preempt-rt to
: raw_spinlocks.

which is pathetically useless.

But I suppose we should ignorantly copy it and hope we're not screwing
something up.

> +			if (new->thread)
> +				wake_up_process(new->thread);
> +			return 0;
> +		}
> +#endif
> +
> +		/* they are the same types and same handler
> +		 * perhaps it is a private cpu interrupt
> +		 */
> +		if (old->flags == new->flags
> +			&& old->handler == new->handler)
> +			setup_affinity(irq, desc);
> +			return 0;

And this appears to have forgotten to undo the lock altogether, which
makes one wonder about the testing coverage.

It also embeds a `return' statement deep inside a huge and complex
function, which is invariably bad.

And in so doing it bypasses the register_irq_proc() and
register_handler_proc() calls.  I have no way of knowing whether that
was deliberate or whether it was a bug.  If it was deliberate then some
code and'/or changelog commentary is needed, so that others don't think
that it is a bug too.
