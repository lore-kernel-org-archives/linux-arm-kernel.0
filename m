From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 25 Apr 2012 10:50:15 +0200 (CEST)
Subject: [PATCH 2/3] IRQ: allow check_wakeup_irqs to notice level-triggered
 interrupts.
In-Reply-To: <20120425030524.7832.85239.stgit@notabene.brown>
References: <20120425025637.7832.14013.stgit@notabene.brown>
 <20120425030524.7832.85239.stgit@notabene.brown>
Message-ID: <alpine.LFD.2.02.1204251018530.2542@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Apr 2012, NeilBrown wrote:

> Level triggered interrupts do not cause IRQS_PENDING to be set, so
> check_wakeup_irqs ignores them.
> They don't need to set IRQS_PENDING as the level stays high which
> shows that they must be pending.  However if such an interrupt fired
> during late suspend, it will have been masked so the fact that it
> is still asserted will not cause the suspend to abort.
> 
> So if any wakeup interrupt is masked, unmask it when checking wakeup
> irqs.  If the interrupt is asserted, suspend will abort.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
>  kernel/irq/pm.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 15e53b1..0d26206 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -106,6 +106,12 @@ int check_wakeup_irqs(void)
>  		if (irqd_is_wakeup_set(&desc->irq_data)) {
>  			if (desc->istate & IRQS_PENDING)
>  				return -EBUSY;
> +			if (irqd_irq_masked(&desc->irq_data))
> +				/* Probably a level interrupt
> +				 * which fired recently and was
> +				 * masked
> +				 */
> +				unmask_irq(desc);

Oh no. We don't unmask unconditionally. What about an interrupt which
is disabled, has no handler ..... ? That needs more thought.

Thanks,

	tglx
