From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 19 Feb 2014 12:32:28 +0000
Subject: [PATCH v3 2/5] irqchip: gic: use dmb ishst instead of dsb when
 raising a softirq
In-Reply-To: <1392812917-29302-2-git-send-email-will.deacon@arm.com>
References: <1392812917-29302-1-git-send-email-will.deacon@arm.com>
 <1392812917-29302-2-git-send-email-will.deacon@arm.com>
Message-ID: <20140219123228.GH30457@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 12:28:34PM +0000, Will Deacon wrote:
> When sending an SGI to another CPU, we require a barrier to ensure that
> any pending stores to normal memory are made visible to the recipient
> before the interrupt arrives.
> 
> Rather than use a vanilla dsb() (which will soon cause an assembly error
> on arm64) before the writel_relaxed, we can instead use dsb(ishst),
> since we just need to ensure that any pending normal writes are visible
> within the inner-shareable domain before we poke the GIC.
> 
> With this observation, we can then further weaken the barrier to a
> dmb(ishst), since other CPUs in the inner-shareable domain must observe
> the write to the distributor before the SGI is generated.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  drivers/irqchip/irq-gic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 341c6016812d..500e533b9648 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -661,9 +661,9 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  
>  	/*
>  	 * Ensure that stores to Normal memory are visible to the
> -	 * other CPUs before issuing the IPI.
> +	 * other CPUs before they observe us issuing the IPI.
>  	 */
> -	dsb();
> +	dmb(ishst);

Oh well ;)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
