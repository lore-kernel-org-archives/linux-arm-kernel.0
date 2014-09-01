From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 1 Sep 2014 16:50:46 +0100
Subject: [PATCH v2] arm: use irq_set_affinity with force=false when
 migrating irqs
In-Reply-To: <1409581297-29216-1-git-send-email-sudeep.holla@arm.com>
References: <1409571966-18343-1-git-send-email-sudeep.holla@arm.com>
 <1409581297-29216-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140901155046.GA6830@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 03:21:37PM +0100, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> Since commit 1dbfa187dad ("ARM: irq migration: force migration off CPU
> going down") the ARM interrupt migration code on cpu offline calls
> irqchip.irq_set_affinity() with the argument force=true. At the point
> of this change the argument had no effect because it was not used by
> any interrupt chip driver and there was no semantics defined.
> 
> This changed with commit 01f8fa4f01d8 ("genirq: Allow forcing cpu
> affinity of interrupts") which made the force argument useful to route
> interrupts to not yet online cpus without checking the target cpu
> against the cpu online mask. The following commit ffde1de64012
> ("irqchip: gic: Support forced affinity setting") implemented this for
> the GIC interrupt controller.
> 
> As a consequence the ARM cpu offline irq migration fails if CPU0 is
> offlined, because CPU0 is still set in the affinity mask and the
> validataion against cpu online mask is skipped to the force argument
> being true. The following first_cpu(mask) selection always selects
> CPU0 as the target.
> 
> Solve the issue by calling irq_set_affinity() with force=false from
> the CPU offline irq migration code so the GIC driver validates the
> affinity mask against CPU online mask and therefore removes CPU0 from
> the possible target candidates.
> 
> Tested on TC2 hotpluging CPU0 in and out. Without this patch the system
> locks up as the IRQs are not migrated away from CPU0.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <stable@vger.kernel.org> # 3.10.x

Acked-by: Mark Rutland <mark.rutland@arm.com>

It's nice to finally know what we should be doing here. :)

Would you be able to take a look at doing the same for arm64? The
current solution (now in -stable) allows for hotplugging CPU0 but IIRC
it would break the affinity mask unnecessarily.

Cheers,
Mark.

> ---
>  arch/arm/kernel/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Change v1->v2:
>  - Updated the changelog to reflect the actual history behind
>    this change as suggested by tglx and added his ack
> 
> diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
> index 2c4257604513..5c4d38e32a51 100644
> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -175,7 +175,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
>  	c = irq_data_get_irq_chip(d);
>  	if (!c->irq_set_affinity)
>  		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
> -	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
> +	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
>  		cpumask_copy(d->affinity, affinity);
>  
>  	return ret;
> -- 
> 1.8.3.2
> 
