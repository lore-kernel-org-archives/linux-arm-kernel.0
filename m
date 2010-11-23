From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 23 Nov 2010 11:05:46 +0100
Subject: [PATCH] arm: GIC: Do not try to register more then NR_IRQS
	interrupts
In-Reply-To: <1290431295-16052-1-git-send-email-pawel.moll@arm.com>
References: <1290431040-15417-1-git-send-email-pawel.moll@arm.com>
	<1290431295-16052-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20101123100546.GL4693@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 01:08:15PM +0000, Pawel Moll wrote:
> This change limits number of GIC-originating interrupts to the
> platform maximum (defined by NR_IRQS) while still initialising
> all distributor registers.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/common/gic.c |   14 ++++++--------
>  1 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 772f95f..20e1412 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -231,14 +231,6 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
>  	max_irq = (max_irq + 1) * 32;
>  
>  	/*
> -	 * The GIC only supports up to 1020 interrupt sources.
> -	 * Limit this to either the architected maximum, or the
> -	 * platform maximum.
> -	 */
> -	if (max_irq > max(1020, NR_IRQS))
> -		max_irq = max(1020, NR_IRQS);
> -
> -	/*
>  	 * Set all global interrupts to be level triggered, active low.
>  	 */
>  	for (i = 32; i < max_irq; i += 16)
> @@ -264,6 +256,12 @@ void __init gic_dist_init(unsigned int gic_nr, void __iomem *base,
>  		writel(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
>  
>  	/*
> +	 * Limit number of interrupts registered to the platform maximum
> +	 */
> +	WARN_ON(max_irq > NR_IRQS);
> +	max_irq = min(max_irq, NR_IRQS);
> +
> +	/*
Maybe make this

	if (WARN_ON(max_irq > NR_IRQS))
		max_irq = NR_IRQS;

That said I wonder if this is correct, at least it looks wrong to me.

First (judging from the name) max_irq is used as irq number, while
NR_IRQS must not be used as such (i.e. NR_IRQS - 1 is the last valid
number).  But maybe the variable is just (IMHO) bad.

>  	 * Setup the Linux IRQ subsystem.
>  	 */
>  	for (i = irq_start; i < gic_data[gic_nr].irq_offset + max_irq; i++) {
And further shouldn't gic_data[gic_nr].irq_offset be taken into account
when limiting max_irq?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
